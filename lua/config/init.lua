local M = {}

function M.setup()
  require "config.options"
  require "plugins" -- Load plugin configuration
  
  require "config.keymaps"
  require "config.autocmds" -- Load plugin configuration
end

return M
