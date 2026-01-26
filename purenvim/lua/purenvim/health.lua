local M = {}

M.check = function()
  vim.health.start("PureNvim")

  -- Neovim version
  if vim.fn.has("nvim-0.12") == 1 then
    vim.health.ok("Neovim 0.12+")
  elseif vim.fn.has("nvim-0.11") == 1 then
    vim.health.warn("Neovim 0.11 detected. Some features require 0.12+")
  else
    vim.health.error("Neovim 0.12+ required")
  end

  -- Required tools
  vim.health.start("Required Tools")
  local required = {
    { cmd = "git", name = "Git" },
    { cmd = "cc", name = "C Compiler" },
    { cmd = "rg", name = "ripgrep (fuzzy grep)" },
    { cmd = "fd", name = "fd (fuzzy find)" },
  }

  for _, tool in ipairs(required) do
    if vim.fn.executable(tool.cmd) == 1 then
      vim.health.ok(tool.name .. " found")
    else
      vim.health.error(tool.name .. " not found")
    end
  end

  -- LSP servers
  vim.health.start("LSP Servers")
  local servers = {
    { cmd = "clangd", name = "clangd (C/C++)" },
    { cmd = "rust-analyzer", name = "rust-analyzer (Rust)" },
    { cmd = "lua-language-server", name = "lua-language-server (Lua)" },
  }

  for _, srv in ipairs(servers) do
    if vim.fn.executable(srv.cmd) == 1 then
      vim.health.ok(srv.name .. " found")
    else
      vim.health.warn(srv.name .. " not found. Install via :Mason")
    end
  end

  -- Plugins
  vim.health.start("Plugins")
  local plugins = {
    { mod = "mini.pick", name = "mini.pick" },
    { mod = "mini.ai", name = "mini.ai" },
    { mod = "mini.diff", name = "mini.diff" },
    { mod = "mini.jump2d", name = "mini.jump2d" },
    { mod = "oil", name = "oil.nvim" },
    { mod = "clangd_extensions", name = "clangd_extensions.nvim" },
    { mod = "mason", name = "mason.nvim" },
  }

  for _, plugin in ipairs(plugins) do
    local ok = pcall(require, plugin.mod)
    if ok then
      vim.health.ok(plugin.name .. " loaded")
    else
      vim.health.warn(plugin.name .. " not loaded")
    end
  end

  -- Treesitter parsers
  vim.health.start("Treesitter Parsers")
  local parsers = { "c", "cpp", "rust", "lua", "vim", "vimdoc", "markdown", "json", "toml", "yaml" }
  local parser_dir = vim.fn.stdpath("data") .. "/parser"
  local runtime_parsers = vim.api.nvim_get_runtime_file("parser/*.so", true)

  local function has_parser(lang)
    if vim.fn.filereadable(parser_dir .. "/" .. lang .. ".so") == 1 then
      return true
    end
    for _, p in ipairs(runtime_parsers) do
      if p:match("/" .. lang .. "%.so$") then
        return true
      end
    end
    return false
  end

  for _, lang in ipairs(parsers) do
    if has_parser(lang) then
      vim.health.ok(lang .. " parser found")
    else
      vim.health.info(lang .. " parser not found")
    end
  end
end

return M
