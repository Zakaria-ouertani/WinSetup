--------------------------------------------------------------------------------
-- Auto-updater for latest release of Clink.
-- https://github.com/chrisant996/clink

--------------------------------------------------------------------------------
-- Make sure the Clink version has the required capabilities.

if not clink.runcoroutineuntilcomplete then
    return
end

--------------------------------------------------------------------------------
-- Updater configuration.

local github_repo = "chrisant996/clink"
local local_tag_filename = "clink_updater_tag"

--------------------------------------------------------------------------------
-- Logging helper function.

local function log_info(message)
    message = "Clink updater: " .. message
    log.info(message)
end

--------------------------------------------------------------------------------
-- Updater settings.

--settings.add("clink.autoupdate", true, "Auto-update the Clink program files", "When enabled, periodically checks for updates for the Clink program files.")
--settings.add("clink.update_interval", 3, "Days between update checks", "The Clink autoupdater will wait this many days between update checks.")

if not settings.get("clink.autoupdate") then
    log_info("clink.autoupdate is false.")
    return
end

--------------------------------------------------------------------------------
-- Internal functions.

local function unzip(zip, out)
    if out and out ~= "" and os.isdir(out) then
        local fmt = [[2>nul powershell.exe -Command $ProgressPreference='SilentlyContinue' ; Expand-Archive -Force -LiteralPath "%s" -DestinationPath "%s" ; echo $error.count]]
        local cmd = string.format(fmt, zip, out)
        local f = io.popenyield(cmd)
        if f then
            local result = nil
            if f:read() == "0" then
                result = true
            end
            for _ in f:lines() do
                result = nil
            end
            f:close()
            return result
        end
    else
        log_info("output directory '"..tostring(out).."' does not exist.")
        return
    end
end

local function get_script_file()
    local info = debug.getinfo(1, 'S')
    if not info.source or info.source:sub(1, 1) ~= "@" then
        return nil
    end
    return info.source:sub(2)
end

local function can_check_for_update()
    local clink_exe = os.getalias("clink"):match('^"(.*)"')
    if not clink_exe or clink_exe == "" then
        log_info("unable to find Clink executable file.")
        return false
    end

    local t = os.globfiles(clink_exe, true)
    if not t or not t[1] or not t[1].type then
        log_info("could not determine target location.")
        return false
    end

    if t[1].type:find("readonly") then
        log_info("cannot update because files are readonly.")
        return false
    end

    if os.isfile(path.join(path.getdirectory(clink_exe), path.getbasename(clink_exe)..".lib")) then
        log_info("autoupdate is disabled for local build directories.")
        return false
    end

    local script = get_script_file()
    t = os.globfiles(script, true)
    if not t or not t[1] or not t[1].type then
        log_info("could not determine updater tag file location.")
        return false
    end

    local persist = path.join(path.toparent(script), local_tag_filename)
    local f = io.open(persist)
    if not f then
        log_info("updating because there is no record of having updated before.")
        return true
    end

    local local_lastcheck = f:read("*l")
    f:close()

    if local_lastcheck then
        local now = os.time()
        local interval_days = settings.get("bundle.update_interval")
        if interval_days < 1 then
            interval_days = 1
        end
        if tonumber(local_lastcheck) + (interval_days * 24*60*60) > now then
            log_info("too soon to check for updates (" .. tonumber(local_lastcheck) .. " vs " .. now .. ").")
            return false
        end
    end

    return true
end

local function parse_version_tag(tag)
    local maj, min, pat
    maj, min, pat = tag:match("v(%d+)%.(%d+)%.(%d+)")
    if not maj then
        maj, min = tag:match("v(%d+)%.(%d+)")
    end
    if maj and min then
        return tonumber(maj), tonumber(min), tonumber(pat or 0)
    end
end

local function check_for_update()
    local files = {}

    log_info("check_for_update() reached.")

    local clink_exe = os.getalias("clink"):match('^"(.*)"')
    if not clink_exe or clink_exe == "" then
        log_info("unable to find Clink executable file.")
        return
    end

    -- Get local version by running clink, in case it's been updated already
    -- but the current process hasn't been restarted.
    local local_tag
    local f = io.popenyield('2>nul "'..clink_exe..'" --version')
    if not f then
        log_info("unable to get local version.")
        return
    end
    for line in f:lines() do
        if not local_tag then
            local_tag = "v"..line
        end
    end
    f:close()

    -- Use github API to query latest release.
    local cloud_tag
    local api = string.format('2>nul curl.exe -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/%s/releases/latest', github_repo)
    local f = io.popenyield(api)
    if not f then
        log_info("unable to query github api.")
        return
    end
    local latest_zip
    for line in f:lines() do
        local tag = line:match('"tag_name": "(.*)"')
        local match = line:match('"browser_download_url": "(.*%.zip)"')
        if not cloud_tag and tag then
            cloud_tag = tag
        end
        if not latest_zip and match then
            latest_zip = match
        end
    end
    f:close()
    if not latest_zip then
        log_info("unable to find latest release zip file.")
        return
    end

    -- Compare versions.
    local needed = true
    local cmaj, cmin, cpat = parse_version_tag(cloud_tag)
    local lmaj, lmin, lpat = parse_version_tag(local_tag)
    if lmaj > cmaj then
        needed = false
    elseif lmaj == cmaj then
        if lmin > cmin then
            needed = false
        elseif lmin == cmin then
            if lpat >= cpat then
                needed = false
            end
        end
    end
    if not needed then
        log_info("no update available; local version "..local_tag.." is not older than latest release "..cloud_tag..".")
        return
    end

    -- Download latest release zip file.
    -- Note:  Because of github redirection, there's no way to verify whether
    -- the file existed.  But if it's not a zip file then the expand will fail,
    -- and that's good enough.
    local local_zip
    f, local_zip = os.createtmpfile("updclink", ".zip")
    if not f then
        log_info("unable to create temporary file.")
        return
    end
    f:close()
    local cmd = string.format('2>nul curl -L --url %s -o "%s"', latest_zip, local_zip)
    f = io.popenyield(cmd)
    if not f then
        log_info("failed to download zip file.")
        os.remove(local_zip)
        return
    end
    for _ in f:lines() do
    end
    f:close()

    -- Expand the zip file.
    local out_dir = path.toparent(clink_exe)
    local ok = unzip(local_zip, out_dir)
    os.remove(local_zip)
    if not ok then
        log_info("failed to unzip the latest release.")
        return
    end

    -- The update appears to have succeeded (and if it didn't, the next check
    -- for updates will reassess and retry).  Write the last update time.
    local target = path.toparent(get_script_file())
    local persist = path.join(target, local_tag_filename)
    f = io.open(persist, "w")
    if not f then
        log_info("unable to record last update time to '" .. persist .. "'.")
        return
    end
    f:write(tostring(os.time()))
    f:write("\n")
    f:close()
    log_info("updated Clink to "..cloud_tag..".")
end

--------------------------------------------------------------------------------
-- Create a coroutine to handle updating in the background.

if can_check_for_update() then
    local c = coroutine.create(check_for_update)
    clink.runcoroutineuntilcomplete(c)
end
