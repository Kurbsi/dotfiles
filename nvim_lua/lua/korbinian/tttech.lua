local function create_file_url(line_number)
    local tttech_repo = "https://git.tttech.com/projects/MOTIONWISE/repos/soa-com-middleware/browse/"
    local file_path = vim.fn.expand('%:.')

    local prepended_string = tttech_repo .. file_path
    if line_number then
        prepended_string = prepended_string .. "#" .. line_number
    end

    -- Copy the result to the clipboard
    vim.fn.setreg('+', prepended_string)

    -- Notify the user
    print("Copied to clipboard: " .. prepended_string)
end

function _G.insert_jira_link()
    -- Get the Jira URL base (you can customize this)
    local jira_base_url = vim.g.jira_base_url or "https://issues.tttech.com/browse/"

    -- Create an input dialog to get the issue number
    local issue_number = vim.fn.input("Jira Issue: ")

    -- Check if the user provided an issue number
    if issue_number ~= "" then
        -- Format the full Jira URL
        local jira_url = jira_base_url .. issue_number

        -- Create the markdown-style link
        local link_text = "[" .. issue_number .. "](" .. jira_url .. ")"

        -- Insert the link at the current cursor position
        vim.api.nvim_put({ link_text }, "", true, true)

        -- Return to normal mode and move cursor to the end of the inserted text
        vim.cmd("stopinsert")
    else
        print("No issue number provided, aborting.")
    end
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
        vim.keymap.set("n", "<leader>jl", insert_jira_link, { noremap = true, desc = "Insert Jira link" })
        vim.opt.makeprg = "docker compose exec motionwise-lean ./build.sh linux-host ms_mbpp"
        -- vim.api.nvim_create_user_command("SoaPipeline", function(opts)
        --     local cmd = opts.args ~= "" and opts.args or "echo No argumets provided"
        --     vim.fn.system(cmd)
        -- end, { nargs = "*", desc = "Run the SOA build pipeline" })
    end,
})
vim.keymap.set("n", "<leader>jl", _G.insert_jira_link, { noremap = true, desc = "Insert Jira link" })
