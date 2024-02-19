local function isIn(tab, val)
    for index, value in ipairs(tab) do
    print()
        if value == val then
            return true
        end
    end

    return false
end


function aliasExpand(rl_buffer)
	--line = rl_buffer:getbuffer()
	--command = strsub(line, 1, strfind(line, " "))
	--command = "history"
	--excluded_commands = {"history", "clink"}
	--if (isIn(excluded_commands, command) == false) then
	rl.invokecommand("clink-expand-doskey-alias")
end
