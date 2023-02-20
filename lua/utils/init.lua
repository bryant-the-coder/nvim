local utils = {}
local home = os.getenv "HOME"
utils.path_sep = package.config:sub(1, 1) == "\\" and "\\" or "/"

function utils.get_config_path()
    local config = os.getenv "XDG_CONFIG_DIR"
    if not config then
        return home .. "/.config/nvim"
    end
    return config
end

function utils.get_data_path()
    local data = os.getenv "XDG_DATA_DIR"
    if not data then
        return home .. "/.local/share/nvim"
    end
    return data
end

return utils
