local M = {}

function M.getch_lazy_nvim() -- Get or Fetch lazy.nvim
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

function M.map(modes, key, target, opts)
	local mt = {}

	for mode in modes:gmatch"." do
		table.insert(mt, mode)
	end

	vim.keymap.set(mt, key, target, opts or {
		noremap = true,
		silent = true,
	})
end

-- <<[LAZY] REF: https://github.com/LazyVim/LazyVim/blob/7a5dbea/lua/lazyvim/util/plugin.lua#L59-L124
-- Properly load file based plugins without blocking the UI
function M.lazy_file()
	M.use_lazy_file = M.use_lazy_file and vim.fn.argc(-1) > 0

	-- Add support for the LazyFile event
	local Event = require("lazy.core.handler.event")

	if M.use_lazy_file then
		-- We'll handle delayed execution of events ourselves
		Event.mappings.LazyFile = { id = "LazyFile", event = "User", pattern = "LazyFile" }
		Event.mappings["User LazyFile"] = Event.mappings.LazyFile
	else
		-- Don't delay execution of LazyFile events, but let lazy know about the mapping
		Event.mappings.LazyFile = { id = "LazyFile", event = { "BufReadPost", "BufNewFile", "BufWritePre" } }
		Event.mappings["User LazyFile"] = Event.mappings.LazyFile
		return
	end

	local events = {} ---@type {event: string, buf: number, data?: any}[]

	local done = false
	local function load()
		if #events == 0 or done then
			return
		end
		done = true
		vim.api.nvim_del_augroup_by_name("lazy_file")

		---@type table<string,string[]>
		local skips = {}
		for _, event in ipairs(events) do
			skips[event.event] = skips[event.event] or Event.get_augroups(event.event)
		end

		vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile", modeline = false })
		for _, event in ipairs(events) do
			if vim.api.nvim_buf_is_valid(event.buf) then
				Event.trigger({
					event = event.event,
					exclude = skips[event.event],
					data = event.data,
					buf = event.buf,
				})
				if vim.bo[event.buf].filetype then
					Event.trigger({
						event = "FileType",
						buf = event.buf,
					})
				end
			end
		end
		vim.api.nvim_exec_autocmds("CursorMoved", { modeline = false })
		events = {}
	end

	-- schedule wrap so that nested autocmds are executed
	-- and the UI can continue rendering without blocking
	load = vim.schedule_wrap(load)

	vim.api.nvim_create_autocmd(M.lazy_file_events, {
		group = vim.api.nvim_create_augroup("lazy_file", { clear = true }),
		callback = function(event)
			table.insert(events, event)
			load()
		end,
	})
end
-- >>[LAZY]

return M
