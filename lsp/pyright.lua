-- lua/lsp/pyright.lua

---@brief
---
--- https://github.com/microsoft/pyright
---
--- `pyright`, a static type checker and language server for python

local function set_python_path(command)
  local path = command.args
  local clients = vim.lsp.get_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'pyright',
  }
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend('force', client.settings.python, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
    end
    client:notify('workspace/didChangeConfiguration', { settings = nil })
  end
end

---@type vim.lsp.Config
return {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyrightconfig.json',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,  -- Good for Polars type stubs and completions
        diagnosticMode = 'openFilesOnly',  -- Less aggressive diagnostics; change to 'workspace' if you want broader checks
        typeCheckingMode = 'basic',  -- Optional: Adjust to 'strict' for more rigorous type checking
      },
    },
  },
  handlers = {
    -- Custom handler to tweak diagnostics display (reduces clutter as per your earlier request)
    ['textDocument/publishDiagnostics'] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,  -- Disable inline text
        signs = true,          -- Keep signs in the signcolumn (pair with vim.opt.signcolumn = 'number')
        underline = true,      -- Underline issues
        update_in_insert = false,  -- Don't update while typing
      }
    ),
  },
  on_attach = function(client, bufnr)
    -- Custom command for organizing imports
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
      local params = {
        command = 'pyright.organizeimports',
        arguments = { vim.uri_from_bufnr(bufnr) },
      }
      -- Direct request for private commands
      client.request('workspace/executeCommand', params, nil, bufnr)
    end, {
      desc = 'Organize Imports',
    })

    -- Custom command for setting Python path (useful for virtualenvs)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
      desc = 'Reconfigure pyright with the provided python path',
      nargs = 1,
      complete = 'file',
    })

    -- Optional: Add your own keymaps here if needed (e.g., for blink.cmp integration or navigation)
    -- local opts = { buffer = bufnr, noremap = true, silent = true }
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  end,
}
