-- ============================================================
-- Single source of truth for all external tool paths.
-- Edit ONLY this file when your environment changes.
-- ============================================================

local M = {}

-- Python virtual environment (pynvim, ruff, black, etc.)
M.python_venv = vim.fn.expand("~/py-env/.venv")

-- Go
M.goroot = vim.env.GOROOT ~= nil and vim.env.GOROOT or "/usr/local/go"
M.gopath = vim.env.GOPATH ~= nil and vim.env.GOPATH or vim.fn.expand("~/go")

-- Node via nvm — uses the "current" symlink (nvm's default alias)
M.nvm_dir = vim.env.NVM_DIR or vim.fn.expand("~/.nvm")
M.node_bin = M.nvm_dir .. "/current/bin"

-- Derived paths (don't edit these)
M.python = M.python_venv .. "/bin/python"
M.ruff = M.python_venv .. "/bin/ruff"
M.black = M.python_venv .. "/bin/black"
M.isort = M.python_venv .. "/bin/isort"

return M
