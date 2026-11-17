local dap = require("dap")
local dapui = require("dapui")
local utils = require("utils")

--------------------------------------------------------------------------------
-- DAP UI
--------------------------------------------------------------------------------

dapui.setup({
  layouts = {
    {
      elements = {
        "scopes",
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40,
      position = "right",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 10,
      position = "bottom",
    },
  },
})

--------------------------------------------------------------------------------
-- SIGNS
--------------------------------------------------------------------------------

vim.fn.sign_define("DapBreakpoint", {
  text = "●",
  texthl = "DapBreakpoint",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointCondition", {
  text = "●",
  texthl = "DapBreakpointCondition",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapStopped", {
  text = "→",
  texthl = "DapStopped",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = "○",
  texthl = "DapBreakpointRejected",
  linehl = "",
  numhl = "",
})

--------------------------------------------------------------------------------
-- PYTHON
--------------------------------------------------------------------------------

dap.adapters.python = function(callback, config)
  ---------------------------------------------------------------------------
  -- ATTACH
  ---------------------------------------------------------------------------

  if config.request == "attach" then
    local host = "127.0.0.1"
    local port = 5678

    if config.connect then
      host = config.connect.host or host
      port = config.connect.port or port
    end

    callback({
      type = "server",
      host = host,
      port = port,
    })

    return
  end

  ---------------------------------------------------------------------------
  -- LAUNCH
  ---------------------------------------------------------------------------

  callback({
    type = "executable",
    command = "python",
    args = {
      "-m",
      "debugpy.adapter",
    },
  })
end

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Python: Current File",

    program = "${file}",

    pythonPath = function()
      return "python"
    end,
  },

  {
    type = "python",
    request = "attach",
    name = "Python: Attach",

    connect = {
      host = "127.0.0.1",
      port = 5678,
    },
  },
}

--------------------------------------------------------------------------------
-- JAVA
--
-- IMPORTANT:
--
-- Do NOT manually configure a Java launch classpath here.
--
-- nvim-jdtls + vscode-java-debug should generate:
--
--   mainClass
--   projectName
--   classPaths
--   modulePaths
--
-- based on the actual Maven/Gradle project.
--------------------------------------------------------------------------------

local function setup_java_dap()
  local ok_jdtls, jdtls = pcall(require, "jdtls")

  if not ok_jdtls then
    vim.notify(
      "nvim-jdtls is not available",
      vim.log.levels.WARN
    )
    return
  end

  ---------------------------------------------------------------------------
  -- Register Java debug support from the active JDTLS client
  ---------------------------------------------------------------------------

  local ok_dap, jdtls_dap = pcall(require, "jdtls.dap")

  if not ok_dap then
    vim.notify(
      "jdtls.dap is not available",
      vim.log.levels.WARN
    )
    return
  end

  jdtls_dap.setup_dap({
    hotcodereplace = "auto",
  })

  ---------------------------------------------------------------------------
  -- Discover all public static void main(...) classes in the current project
  --
  -- This is the important part.
  --
  -- It lets JDTLS determine:
  --
  --   * fully qualified main class
  --   * Maven/Gradle project
  --   * compiled output directories
  --   * dependency classpath
  --   * module path
  ---------------------------------------------------------------------------

  jdtls_dap.setup_dap_main_class_configs()
end

--------------------------------------------------------------------------------
-- SET UP JAVA DAP ONCE JDTLS ATTACHES
--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup(
    "JavaDapSetup",
    { clear = true }
  ),

  callback = function(args)
    local client =
        vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      return
    end

    if client.name ~= "jdtls" then
      return
    end

    -- JDTLS/java-debug needs a moment after LspAttach to expose its commands.
    vim.schedule(function()
      setup_java_dap()
    end)
  end,
})

--------------------------------------------------------------------------------
-- JAVA REMOTE ATTACH
--
-- Keep this explicitly configured because remote attach doesn't require
-- discovery of a main class/classpath.
--------------------------------------------------------------------------------

dap.configurations.java = dap.configurations.java or {}

table.insert(dap.configurations.java, {
  type = "java",
  request = "attach",
  name = "Java: Attach localhost:5005",

  hostName = "127.0.0.1",
  port = 5005,
})

--------------------------------------------------------------------------------
-- REFRESH JAVA DEBUG CONFIGURATIONS
--
-- Useful after:
--
--   * mvn clean
--   * changing pom.xml
--   * changing build.gradle
--   * switching branches
--   * adding/removing modules
--------------------------------------------------------------------------------

local function refresh_java_dap()
  local ok, jdtls_dap = pcall(require, "jdtls.dap")

  if not ok then
    vim.notify(
      "jdtls.dap is not available",
      vim.log.levels.ERROR
    )
    return
  end

  jdtls_dap.setup_dap_main_class_configs({
    verbose = true,
  })

  vim.notify(
    "Java DAP configurations refreshed",
    vim.log.levels.INFO
  )
end

--------------------------------------------------------------------------------
-- DAP UI LIFECYCLE
--------------------------------------------------------------------------------

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  -- Keep UI open.
end

dap.listeners.before.event_exited["dapui_config"] = function()
  -- Keep UI open.
end

--------------------------------------------------------------------------------
-- HELPERS
--------------------------------------------------------------------------------

local function add_watch()
  local expression =
      vim.fn.input("Expression to watch: ")

  if expression == nil or expression == "" then
    return
  end

  dapui.elements.watches.add(expression)
end

local function conditional_breakpoint()
  local condition =
      vim.fn.input("Breakpoint condition: ")

  if condition == nil or condition == "" then
    return
  end

  dap.set_breakpoint(condition)
end

local function terminate()
  if dap.session() == nil then
    vim.notify(
      "No active DAP session",
      vim.log.levels.INFO
    )
    return
  end

  dap.terminate()
end

--------------------------------------------------------------------------------
-- KEYMAPS
--------------------------------------------------------------------------------

utils.enableMappings({
  ---------------------------------------------------------------------------
  -- EXECUTION
  ---------------------------------------------------------------------------

  {
    "<F5>",
    function()
      dap.continue()
    end,
    desc = "DAP: Start / Continue",
  },

  {
    "<F10>",
    function()
      dap.step_over()
    end,
    desc = "DAP: Step Over",
  },

  {
    "<F11>",
    function()
      dap.step_into()
    end,
    desc = "DAP: Step Into",
  },

  {
    "<F12>",
    function()
      dap.step_out()
    end,
    desc = "DAP: Step Out",
  },

  {
    "<leader>dd",
    function()
      dap.step_over()
    end,
    desc = "DAP: Step Over",
  },

  {
    "<leader>di",
    function()
      dap.step_into()
    end,
    desc = "DAP: Step Into",
  },

  {
    "<leader>do",
    function()
      dap.step_out()
    end,
    desc = "DAP: Step Out",
  },

  {
    "<leader>dr",
    function()
      dap.run_to_cursor()
    end,
    desc = "DAP: Run to Cursor",
  },

  {
    "<leader>dl",
    function()
      dap.run_last()
    end,
    desc = "DAP: Run Last",
  },

  {
    "<leader>dt",
    terminate,
    desc = "DAP: Terminate",
  },

  ---------------------------------------------------------------------------
  -- BREAKPOINTS
  ---------------------------------------------------------------------------

  {
    "<leader>db",
    function()
      dap.toggle_breakpoint()
    end,
    desc = "DAP: Toggle Breakpoint",
  },

  {
    "<leader>dcb",
    conditional_breakpoint,
    desc = "DAP: Conditional Breakpoint",
  },

  {
    "<leader>dc",
    function()
      dap.clear_breakpoints()
    end,
    desc = "DAP: Clear Breakpoints",
  },

  ---------------------------------------------------------------------------
  -- UI
  ---------------------------------------------------------------------------

  {
    "<leader>du",
    function()
      dapui.toggle()
    end,
    desc = "DAP: Toggle UI",
  },

  {
    "<leader>dw",
    add_watch,
    desc = "DAP: Add Watch",
  },

  {
    "<leader>dre",
    function()
      dap.repl.open()
    end,
    desc = "DAP: Open REPL",
  },

  ---------------------------------------------------------------------------
  -- JAVA
  ---------------------------------------------------------------------------

  {
    "<leader>djr",
    refresh_java_dap,
    desc = "DAP: Refresh Java Configurations",
  },
})
