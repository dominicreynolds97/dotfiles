local java_cmds = vim.api.nvim_create_augroup("java_cmds", { clear = true })
local cache_vars = {}

local root_files = {
  ".git",
  "mvnw",
  "gradlew",
  "pom.xml",
  "build.gradle",
  "build.sbt",
}

local features = {
  codelens = true,
  debugger = true,
}

local function get_jdtls_paths()
  if cache_vars.paths then
    return cache_vars.paths
  end

  local path = {}
  local mason = vim.env.HOME .. "/.local/share/nvim/mason"

  path.data_dir = vim.fn.stdpath("cache") .. "/jdtls"
  print("data_dir: " .. path.data_dir)

  local jdtls_install = mason .. "/share/jdtls"

  path.java_agent = jdtls_install .. "/lombok.jar"
  path.launcher_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher.jar")

  path.os_config = "linux"
  if vim.fn.has("mac") == 1 then
    path.os_config = "mac"
  elseif vim.fn.has("win32") == 1 then
    path.os_config = "win"
  end

  path.platform_config = mason .. "/packages/jdtls/config_" .. path.os_config

  path.bundles = {}

  -- OK TO HERE!

 --  local java_test_path = mason .. "/share/java-test"

 --  local java_test_bundle = vim.split(
 --    vim.fn.glob(java_test_path .. "/extension/server/*.jar"),
 --    "\n"
 --  )

 --  if java_test_bundle[1] ~= "" then
 --    vim.list_extend(path.bundles, java_test_bundle)
 --  end

 --  local java_debug_path = mason .. "/share/java-debug-adapter"

 --  local java_debug_bundle = vim.split(
 --    vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"),
 --    "\n"
 --  )

 --  if java_debug_bundle[1] ~= "" then
 --    vim.list_extend(path.bundles, java_debug_bundle)
 --  end

  path.runtimes = {
    {
      name = "JavaSE-21",
      path = vim.fn.expand("~/.sdkman/candidates/java/21.0.7-amzn")
    },
  }

  cache_vars.paths = path

  return path
end

local function enable_codelens(bufnr)
  pcall(vim.lsp.codelens.refresh)

  vim.api.nvim_create_autocmd("BufWritePost", {
    buffer = bufnr,
    group = java_cmds,
    desc = "refresh codelens",
    callback = function()
      pcall(vim.lsp.codelens.refresh)
    end,
  })
end

local function enable_debugger(bufnr)
end

local function jdtls_on_attach(client, bufnr)
  --if features.debugger then
  --  enable_debugger(bufnr)
  --end

  if features.codelens then
    enable_codelens(bufnr)
  end

  local function opts(des)
    return {
      buffer = bufnr,
      noremap = true,
      silent = true,
      desc = des,
    }
  end
  local keymap = vim.keymap.set
  local jdtls = require("jdtls")

  -- Organize imports
  keymap("n", "<leader>oi", jdtls.organize_imports, opts("Organize imports"))

  -- Extract variable
  keymap("n", "<leader>ev", jdtls.extract_variable, opts("Extract variable"))

  -- Extract variable (visual)
  keymap("v", "<leader>ev", [[<ESC><CMD>lua require('jdtls').extract_variable(true)<CR>]], opts("Extract variable"))

  -- Extract constant
  keymap("n", "<leader>ec", jdtls.extract_constant, opts("Extract constant"))

  -- Extract constant (visual)
  keymap("v", "<leader>ec", [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]], opts("Extract constant"))

  -- Extract method (visual)
  keymap("v", "<leader>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts("Extract method"))

  -- Update project configuration
  keymap("n", "<leader>up", jdtls.update_projects_config, opts("Update project"))

  -- Test class
  keymap("n", "<leader>tc", jdtls.test_class, opts("Test class"))

  -- Test nearest method
  keymap("n", "<leader>tm", jdtls.test_nearest_method, opts("Test nearest method"))
end

local function setup_jdtls()
  local jdtls = require("jdtls")
  local extendedClientCapabilities = jdtls.extendedClientCapabilities;
  extendedClientCapabilities.onCompletionItemSelectedCommand = "editor.action.triggerParameterHints"

  local path = get_jdtls_paths()
  local data_dir = path.data_dir .. "/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  print("local data_dir: ", data_dir)

  if cache_vars.capabilities == nil then
    jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

   -- local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
   -- cache_vars.capabilites = vim.tbl_deep_extend(
   --   "force",
   --   vim.lsp.protocol.make_client_capabilites(),
   --   ok_cmp and cmp_lsp.default_capabilites() or {}
   -- )
  end

  local cmd = {
    "java",

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.profuct=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. path.java_agent,
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",

    "-jar", path.launcher_jar,

    "-configuration", path.platform_config,

    "-data", data_dir,
  }
  for _, v in ipairs(cmd) do
    print(v)
  end



  local lsp_settings = {
    java = {
      eclipse = { downloadSources = true },
      configuration = {
        updateBuildConfiguration = "interactive",
        --runtimes = path.runtimes,
      },
      maven = { downloadSources = true },
      implementaionsCodeLens = { enabled = false },
      referencesCodeLens = { enabled = false },
      references = { includeDecompiledSources = true },
      format = { enabled = true },
      signatureHelp = { enabled = true },
    },
    completion = {
      maxResults = 20,
      importOrder = { "java", "javax", "com", "org" },
      favoriteStaticMembers = {
        'org.hamcrest.MatcherAssert.assertThat',
        'org.hamcrest.Matchers.*',
        'org.hamcrest.CoreMatchers.*',
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',
        'java.util.Objects.requireNonNullElse',
        'org.mockito.Mockito.*',
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        }
      },
      codeGeneration = {
        toString = {
          template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
        },
        useBlocks = true,
      },
    },
  }

  jdtls.start_or_attach({
    cmd = cmd,
    settings = lsp_settings,
    on_attach = jdtls_on_attach,
    capabilites = cache_vars.capabilites,
    root_dir = vim.fs.root(0, root_files),
    flags = {
      allow_incremental_sync = true,
    },
    init_options = {
      bundles = path.bundles,
      extendedClientCapabilities = extendedClientCapabilities,
    },
  })
end

setup_jdtls()
