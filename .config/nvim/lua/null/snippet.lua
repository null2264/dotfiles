-- REF: https://www.reddit.com/r/neovim/comments/1cxfhom/builtin_snippets_so_good_i_removed_luasnip/

local M = {}

local global_snippets = {
    { trigger = "shebang", body = "#!/bin/sh" },
    { trigger = "shebash", body = "#!/usr/bin/env bash" },
}

local snippets_by_filetype = {
    lua = {
        { trigger = "fun", body = "function ${1:name}(${2:args}) $0 end" },
        { trigger = "class", body = [[
local ${1:Name} = {}
${1:Name}.__index = ${1:Name}

type I${1:Name} = {
    $2
}

export type ${1:Name} = typeof(setmetatable({} :: I${1:Name}, ${1:Name}))

type ${1:Name}Internal = {
    $3
} & ${1:Name}]] },
    },
    go = {
        { trigger = "fun", body = "func ${1:name}(${2}) {$0\n}" },
        { trigger = "err-nil", body = "if ${1:err} != nil {$0\n}" },
    },
}

local function get_buf_snips()
    local ft = vim.bo.filetype
    local snips = vim.list_slice(global_snippets)

    if ft and snippets_by_filetype[ft] then
        vim.list_extend(snips, snippets_by_filetype[ft])
    end

    return snips
end

-- cmp source for snippets to show up in completion menu
function M.register_cmp_source()
    local cmp_source = {}
    local cache = {}
    function cmp_source.complete(_, _, callback)
        local bufnr = vim.api.nvim_get_current_buf()
        if not cache[bufnr] then
            local completion_items = vim.tbl_map(function(s)
                ---@type lsp.CompletionItem
                local item = {
                    word = s.trigger,
                    label = s.trigger,
                    kind = vim.lsp.protocol.CompletionItemKind.Snippet,
                    insertText = s.body,
                    insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
                }
                return item
            end, get_buf_snips())

            cache[bufnr] = completion_items
        end

        callback(cache[bufnr])
    end

    require('cmp').register_source('null', cmp_source)
end

return M
