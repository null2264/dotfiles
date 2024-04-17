local RT = {}

function RT.getch_lazy_nvim() -- Get or Fetch lazy.nvim
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)

	return require("lazy")
end

function RT.map(modes, key, target, opts)
	local mt = {}

	for mode in modes:gmatch"." do
		table.insert(mt, mode)
	end

	vim.keymap.set(mt, key, target, opts or {
		noremap = true,
		silent = true,
	})
end

return RT
