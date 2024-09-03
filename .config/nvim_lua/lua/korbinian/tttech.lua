function LoadReports(report)
    local report_path="/home/hirschmuelle/dev/soa-com-middleware/reports/parasoft/" .. report .. "/report.html"
    local f=io.open(report_path,"r")
    if f~=nil then
        io.close(f)
        vim.fn.system("wslview " .. report_path)
    else
        print("Could not load " .. report_path)
    end
end

local korbinian_SOA = vim.api.nvim_create_augroup("korbinian_SOA", {clear = true})
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    group = korbinian_SOA,
    pattern = "/home/hirschmuelle/dev/soa-com-middleware/*",
    callback = function()
        print("WE ARE IN SOA FROM AUTOCMD")
    end,
})


