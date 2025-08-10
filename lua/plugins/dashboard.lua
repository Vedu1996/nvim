return {
	"glepnir/dashboard-nvim",
	event = "VimEnter",
	config = function()
		local my_art = {
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
		"░██    ░██ ░██████  ░██████  ",
		"░██    ░██   ░██   ░██   ░██ ",
		"░██    ░██   ░██  ░██        ",
		"░██    ░██   ░██  ░██        ",
		" ░██  ░██    ░██  ░██        ",
		"  ░██░██     ░██   ░██   ░██ ",
		"   ░███    ░██████  ░██████  ",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
		}

		require("dashboard").setup({
			theme = "doom",
			config = {
				header = my_art,
				center = {
					{
						icon = " ",
						desc = "Find File",
						action = "Telescope find_files",
						key = "f",
					},
					{
						icon = " ",
						desc = "Recent Files",
						action = "Telescope oldfiles",
						key = "r",
					},
					{
						icon = " ",
						desc = "Find Word",
						action = "Telescope live_grep",
						key = "w",
					},
					{
						icon = "洛 ",
						desc = "Lazy Plugins",
						action = "Lazy",
						key = "l",
					},
					{
						icon = " ",
						desc = "Quit",
						action = "qa",
						key = "q",
					},
				},
			},
		})
	end,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-lua/plenary.nvim" },
	},
	init = function()
		if vim.fn.argc(-1) == 0 then
			local stats = require("lazy").stats()
			if stats.startuptime < 1.0 then -- Only show dashboard on very fast startups
				vim.api.nvim_create_autocmd("VimEnter", {
					pattern = "*",
					once = true,
					callback = function()
						vim.cmd("Dashboard")
					end,
				})
			end
		end

		vim.g.lazyvim_alpha_enabled = false
	end,
}
