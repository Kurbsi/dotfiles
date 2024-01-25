require("korbinian.packer")
require("korbinian.remap")
require("korbinian.set")

local function isSoaDirectory()
    local target_directory = "/home/hirschmuelle/dev/soa-com-middleware"
    local current_directory = vim.fn.getcwd()
    return target_directory == current_directory
end
if isSoaDirectory() then
    require("korbinian.tttech")
end
