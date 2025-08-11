-- lua/plugins/debugging.lua

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"jay-babu/mason-nvim-dap.nvim",
				lazy = false,
				opts = {
					ensure_installed = {
						"js-debug-adapter",
					},
					automatic_installation = true,
					handlers = {},
				},
			},

			-- The UI for the debugger
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"nvim-neotest/nvim-nio",
				},
				config = function()
					local dapui = require("dapui")
					dapui.setup({
						layouts = {
							{
								elements = {
									{ id = "scopes", size = 0.33 },
									{ id = "breakpoints", size = 0.17 },
									{ id = "stacks", size = 0.25 },
									{ id = "watches", size = 0.25 },
								},
								size = 0.3,
								position = "left",
							},
							{
								elements = {
									{ id = "repl", size = 0.5 },
									{ id = "console", size = 0.5 },
								},
								size = 0.25,
								position = "bottom",
							},
						},
					})

					-- 👇 THE FIX IS HERE 👇
					local dap, dapui = require("dap"), require("dapui")
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close()
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close()
					end
				end,
			},

			-- Shows variable values as virtual text
			{
				"theHamsta/nvim-dap-virtual-text",
				config = function()
					require("nvim-dap-virtual-text").setup()
				end,
			},
		},
		config = function()
			-- The rest of your config is unchanged
			local dap = require("dap")

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "127.0.0.1",
				port = 8171,
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						8171,
					},
				},
			}

			dap.configurations.javascript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
			}

			dap.configurations.typescript = dap.configurations.javascript

			-- Keymaps
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Toggle Conditional Breakpoint" })
			vim.keymap.set("n", "<leader>dl", dap.launch, { desc = "Launch Debugger" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<leader>dk", dap.disconnect, { desc = "Disconnect" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
			vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
			vim.keymap.set("n", "<leader>du", require("dapui").toggle, { desc = "Toggle DAP UI" })
		end,
	},
}
