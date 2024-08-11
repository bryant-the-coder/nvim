require("modules.lang.debugger.dap_cpp")
--
local dap = require("dap")
dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "/home/bryant/.local/share/extension/debugAdapters/bin/OpenDebugAD7",
}
