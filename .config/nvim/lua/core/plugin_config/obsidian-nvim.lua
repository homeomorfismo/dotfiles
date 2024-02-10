require("obsidian").setup({
    tag = "*",  -- recommended, use latest release instead of latest commit
    requires = {
        "nvim-lua/plenary.nvim",
    },
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
    completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,

        min_chars = 3,

        -- Where to put new notes created from completion. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "current_dir",

        -- Either 'wiki' or 'markdown'.
        preferred_link_style = "markdown",

        -- Control how wiki links are completed with these (mutually exclusive) options:
        --
        -- 1. Whether to add the note ID during completion.
        -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
        -- Mutually exclusive with 'prepend_note_path' and 'use_path_only'.
        prepend_note_id = false,
        -- 2. Whether to add the note path during completion.
        -- E.g. "[[Foo" completes to "[[notes/foo|Foo]]" assuming "notes/foo.md" is the path of the note.
        -- Mutually exclusive with 'prepend_note_id' and 'use_path_only'.
        prepend_note_path = false,
        -- 3. Whether to only use paths during completion.
        -- E.g. "[[Foo" completes to "[[notes/foo]]" assuming "notes/foo.md" is the path of the note.
        -- Mutually exclusive with 'prepend_note_id' and 'prepend_note_path'.
        use_path_only = true,
    },
    picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'fzf.vim', or 'mini.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support these.
        mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-l>",
        },
    },
    sort_by = "modified",
    sort_reversed = true,
    yaml_parser = "native",  -- "native" or "yaml"
})
