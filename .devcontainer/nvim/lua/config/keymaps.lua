local map = vim.keymap.set

--------------------------------------------------
-- File Explorer
--------------------------------------------------

-- VSCode: Ctrl+B toggles sidebar
map("n", "<C-b>", "<cmd>NvimTreeToggle<CR>")

-- VSCode: Ctrl+Shift+E focuses explorer
map("n", "<C-S-e>", "<cmd>NvimTreeFocus<CR>")

--------------------------------------------------
-- Telescope (Search & Navigation)
--------------------------------------------------

-- VSCode: Ctrl+P quick open
map("n", "<C-p>", function()
  require("telescope.builtin").find_files()
end)

-- VSCode: Ctrl+Shift+F search in files
map("n", "<C-S-f>", function()
  require("telescope.builtin").live_grep()
end)

-- VSCode: Ctrl+Shift+P command palette
map("n", "<C-S-p>", function()
  require("telescope.builtin").commands()
end)

-- Leader shortcuts
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end)

map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end)

map("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end)

map("n", "<leader>fh", function()
  require("telescope.builtin").help_tags()
end)

--------------------------------------------------
-- LSP Navigation
--------------------------------------------------

map("n", "gd", vim.lsp.buf.definition)
map("n", "gr", vim.lsp.buf.references)
map("n", "K", vim.lsp.buf.hover)

-- VSCode: F12 go to definition, Shift+F12 references, F2 rename
map("n", "<F12>", vim.lsp.buf.definition)
map("n", "<S-F12>", vim.lsp.buf.references)
map("n", "<F2>", vim.lsp.buf.rename)

--------------------------------------------------
-- LSP Actions
--------------------------------------------------

map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>ca", vim.lsp.buf.code_action)

--------------------------------------------------
-- Diagnostics
--------------------------------------------------

map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)

-- Trouble (Problems Panel)
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
map("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics" })

--------------------------------------------------
-- Comments (VSCode: Ctrl+/)
--------------------------------------------------

map("n", "<C-/>", function()
  require("Comment.api").toggle.linewise.current()
end)

map("v", "<C-/>", function()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end)

--------------------------------------------------
-- Line Operations (VSCode-like)
--------------------------------------------------

-- VSCode: Ctrl+Shift+K delete line
map("n", "<C-S-k>", "<cmd>normal! dd<CR>")

-- VSCode: Alt+Up/Down move line
map("n", "<A-j>", "<cmd>move .+1<CR>==")
map("n", "<A-k>", "<cmd>move .-2<CR>==")
map("v", "<A-j>", ":move '>+1<CR>gv=gv")
map("v", "<A-k>", ":move '<-2<CR>gv=gv")

--------------------------------------------------
-- Formatting
--------------------------------------------------

map("n", "<leader>f", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "Format File" })

-- VSCode: Shift+Alt+F format document
map("n", "<S-A-f>", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "Format File" })

--------------------------------------------------
-- Terminal
--------------------------------------------------

-- VSCode: Ctrl+` toggle terminal
map("n", "<C-`>", "<cmd>ToggleTerm<CR>")
map("t", "<C-`>", "<cmd>ToggleTerm<CR>")

-- Ctrl+\ as fallback (some terminals eat Ctrl+`)
map("n", "<C-\\>", "<cmd>ToggleTerm<CR>")
map("t", "<C-\\>", "<cmd>ToggleTerm<CR>")

-- Leader shortcut
map("n", "<leader>tt", "<cmd>ToggleTerm<CR>")

-- Escape terminal mode
map("t", "<Esc>", "<C-\\><C-n>")

--------------------------------------------------
-- Git
--------------------------------------------------

-- VSCode: Ctrl+Shift+G source control
map("n", "<C-S-g>", "<cmd>Neogit<CR>")

map("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Git Status" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Git Diff" })
map("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "Close Diff" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "File History" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", { desc = "Repository History" })

--------------------------------------------------
-- GitSigns
--------------------------------------------------

map("n", "]h", function() require("gitsigns").next_hunk() end)
map("n", "[h", function() require("gitsigns").prev_hunk() end)
map("n", "<leader>hs", function() require("gitsigns").stage_hunk() end)
map("n", "<leader>hr", function() require("gitsigns").reset_hunk() end)
map("n", "<leader>hp", function() require("gitsigns").preview_hunk() end)
map("n", "<leader>hb", function() require("gitsigns").blame_line() end)

--------------------------------------------------
-- Buffers (VSCode Tabs)
--------------------------------------------------

-- Shift+H/L cycle tabs
map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>")
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>")

-- VSCode: Ctrl+Tab / Ctrl+Shift+Tab cycle buffers
map("n", "<C-Tab>", "<cmd>BufferLineCycleNext<CR>")
map("n", "<C-S-Tab>", "<cmd>BufferLineCyclePrev<CR>")

-- VSCode: Ctrl+W close tab
map("n", "<C-w>", "<cmd>bdelete<CR>")

-- Leader shortcut
map("n", "<leader>bd", "<cmd>bdelete<CR>")

--------------------------------------------------
-- Save
--------------------------------------------------

-- VSCode: Ctrl+S save
map("n", "<C-s>", "<cmd>w<CR>")
map("i", "<C-s>", "<Esc><cmd>w<CR>")

--------------------------------------------------
-- Window Navigation
--------------------------------------------------

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

--------------------------------------------------
-- Misc Quality of Life
--------------------------------------------------

-- Stay in visual mode after indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Don't yank on paste in visual mode
map("v", "p", '"_dP')

-- Clear search highlight with Escape
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
