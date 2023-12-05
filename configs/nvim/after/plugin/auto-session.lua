local autosession = require("auto-session")

autosession.setup {
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
    auto_session_root_dir =  os.getenv("USERPROFILE") .. "\\.vim\\auto-session",
    auto_session_enabled = true,
    auto_session_create_enabled = true
}
