local M = {}

---@class mapping
---@field desc? string description
---@field mode? string|string[] mode or array of modes
---@field silent? boolean whether it is silent or not
---@field expr? boolean
---@field buffer? boolean|integer
---@field noremap? boolean

---@param mapList mapping[]
function M.enableMappings(mapList)
  for _, map in ipairs(mapList) do
    local opts = {}

    for key, value in pairs(map) do
      if type(key) ~= "number" and key ~= "mode" then
        opts[key] = value
      end
    end

    opts.silent = map.silent or true

    vim.keymap.set(
      map.mode or "n",
      map[1],
      map[2],
      opts
    )
  end
end

return M
