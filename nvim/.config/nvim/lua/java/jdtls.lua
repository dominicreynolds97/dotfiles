local function setup_jdtls()
  local jdtls = require("jdtls")

  -- Paths
  local home = os.getenv("HOME")
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

  local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
  local jdtls_path = mason_path .. "/jdtls"
  local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

  local os_config = "linux"
  if vim.fn.has("mac") == 1 then
    os_config = "mac"
  elseif vim.fn.has("win32") == 1 then
    os_config = "win"
  end

  local config = {
    cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.profuct=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "-jar", launcher_jar,
      "-configuration", jdtls_path .. "/config_" .. os_config,
      "-data", workspace_dir,
    },

    root_dir = require("jdtls.setup").find_root({
      ".git", "mvnw", "gradlew", "pom.xml", "build.gradle"
    }),

    settings = {
      java = {
        eclipse = { downloadSources = true },
        configuration = { updateBuildConfiguration = "interactive" },
        maven = { downloadSources = true },

        implementaionsCodeLens = { enabled = true },
        referencesCodeLens = { enabled = true },

        references = { includeDecompiledSources = true },

        format = { enabled = true },

        completion = {
          favouriteStaticMembers = {
            "org.junit.jupiter.api.Assertions.*",
            "org.mockito.Mockito.*",
          },
        },
      },
      signatureHelp = { enabled = true },
    },

    init_options = {
      bundles = {},
    },

    capabilities = require("cmp_nvim_lsp".default_capabilities(),
  }

  local bundles = {
    vim.fn.glob(mason_path .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
  }
  vim.list_extend(
    bundles,
    vim.split(vim.fn.glob(mason_path .. "/java-test/extension/server/*.jar", 1), "\n")
  )
  config.init_options.bundles = bundles

  jdtls.start_or_attach(config)

  -- TODO
  -- Java-specific keybindings to map:
  -- - Organize imports
  -- - Extract variable
  -- - Extract variable (visual)
  -- - Extract constant
  -- - Extract constant (visual)
  -- - Extract method (visual)
  -- - Update project configuration
  -- - Run main class
  -- - Test class
  -- - Test nearest method
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = setup_jdtls
})
