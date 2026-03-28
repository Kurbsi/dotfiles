-- require("korbinian.packer")
require("korbinian.remap")
require("korbinian.set")
require("korbinian.tttech")
require("korbinian.lazy_init")

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
