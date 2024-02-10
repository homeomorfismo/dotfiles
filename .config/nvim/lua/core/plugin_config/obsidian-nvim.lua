-- tag = "*",  -- recommended, use latest release instead of latest commit
requires = {
    "nvim-lua/plenary.nvim",
}
config = function()
require("obsidian").setup({
    workspaces = {
        {
            name = "personal",
            path = "~/Documents/PersonalNotes",
        },
        {
            name = "work",
            path = "~/Documents/WorkNotes",
        },
    },
})
end
