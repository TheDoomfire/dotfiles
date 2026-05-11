return {
	"Pocco81/auto-save.nvim",
	config = function()
		require("auto-save").setup({
			enabled = true,
			execution_message = {
				message = function() -- message to print on save
					return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
				end,
				dim = 0.18, -- dim the color of `message`
				cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
			},
			--execution_message = { "Auto-saved!" },
			trigger_events = { "InsertLeave", "TextChanged", "CursorHold" },
			debounce_delay = 1000,
		})
	end,
}

--hello whats up?
