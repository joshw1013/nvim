return {
	"lukas-reineke/indent-blankline.nvim",
	-- TODO: Delete the tag once bug is fixed
	tag = "v3.8.2",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	opts = {
		indent = { char = "┊" },
	},
}
