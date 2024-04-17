-- Loaded by `null.config`
local remap = function(mode, key, target, opts)
    vim.api.nvim_set_keymap(mode, key, target, opts or {
	    noremap = true,
	    silent = true,
    })
end

-- Map Ctrl+U as U so it can be used as redo
remap("n", "<C-u>", "U")
-- Map U as redo
remap("n", "U", "<C-r>")

-- Yank and Put
remap("n", "<C-y>", '"+y')
remap("n", "<C-p>", '"+p')
remap("n", "<C-Y>", '"+y')
remap("n", "<C-P>", '"+p')

-- Comment a line like how it is on VSC (using vim-commentary)
remap("n", "<C-/>", "gcc", { noremap = false })
remap("v", "<C-/>", "gc", { noremap = false })
remap("i", "<C-/>", "<esc>gcc", { noremap = false })
