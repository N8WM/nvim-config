return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			fps = 60,
			stages = "slide",
		})
	end,
}
