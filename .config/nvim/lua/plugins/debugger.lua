return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "leoluz/nvim-dap-go",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require "dap"
        local dapui = require "dapui"

        require("dapui").setup()
        require("dap-go").setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug continue" })
        vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug step over" })
        vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug step into" })
        vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug step out" })
        vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Toggle debug" })

        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
        }

        dap.configurations.odin = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
        }
    end,
}
