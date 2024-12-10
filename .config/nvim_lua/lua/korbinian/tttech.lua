function LoadReports(report)
    local report_path = "/home/hirschmuelle/dev/soa-com-middleware/reports/parasoft/" .. report .. "/report.html"
    local f = io.open(report_path, "r")
    if f ~= nil then
        io.close(f)
        vim.fn.system("wslview " .. report_path)
    else
        print("Could not load " .. report_path)
    end
end

local function create_file_url(line_number)
    local tttech_repo = "https://git.tttech.com/projects/MOTIONWISE/repos/soa-com-middleware/browse/"
    local file_path = vim.fn.expand('%')

    local prepended_string = tttech_repo .. file_path
    if line_number then
        prepended_string = prepended_string .. "#" .. line_number
    end

    -- Copy the result to the clipboard
    vim.fn.setreg('+', prepended_string)

    -- Notify the user
    print("Copied to clipboard: " .. prepended_string)
end

local korbinian_SOA = vim.api.nvim_create_augroup("korbinian_SOA", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = korbinian_SOA,
    pattern = "/home/hirschmuelle/dev/soa-com-middleware/*",
    callback = function()
        vim.keymap.set(
            "n", "<leader>yup", function() create_file_url() end,
            { silent = true, desc = "Copy path to file as a link to bitbucket" })
        vim.keymap.set(
            "n", "<leader>yul", function() create_file_url(vim.fn.line('.')) end,
            { silent = true, desc = "Copy path to line as a link to bitbucket" })
    end,
})
