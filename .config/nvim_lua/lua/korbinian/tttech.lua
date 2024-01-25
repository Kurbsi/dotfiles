print("SOA config loaded")

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

vim.keymap.set("n", "<leader>rea", "! wslview reports/parasoft/autosar_cpp/report.html<CR>")
vim.keymap.set("n", "<leader>reh", "! wslview reports/parasoft/his/report.html<CR>")
vim.keymap.set("n", "<leader>rem", "! wslview reports/parasoft/autosar_cpp/report.html<CR>")
