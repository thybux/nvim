return {
  -- Configuration moderne des icônes avec Nerd Font
  {
    "nvim-tree/nvim-web-devicons",
    priority = 1000,
    config = function()
      require('nvim-web-devicons').setup({
        -- Icônes modernes et élégantes
        override = {
          -- JavaScript/TypeScript
          js = {
            icon = "",
            color = "#f7df1e",
            cterm_color = "185",
            name = "Javascript"
          },
          mjs = {
            icon = "",
            color = "#f7df1e",
            cterm_color = "185",
            name = "Javascript"
          },
          ts = {
            icon = "",
            color = "#3178c6",
            cterm_color = "74",
            name = "Typescript"
          },
          tsx = {
            icon = "",
            color = "#1354bf",
            cterm_color = "26",
            name = "TypescriptReact"
          },
          jsx = {
            icon = "",
            color = "#20c2e3",
            cterm_color = "45",
            name = "JavascriptReact"
          },
          
          -- Frameworks/Libraries
          vue = {
            icon = "",
            color = "#4fc08d",
            cterm_color = "78",
            name = "Vue"
          },
          svelte = {
            icon = "",
            color = "#ff3e00",
            cterm_color = "196",
            name = "Svelte"
          },
          
          -- Data/Config
          json = {
            icon = "",
            color = "#cbcb41",
            cterm_color = "185",
            name = "Json"
          },
          yaml = {
            icon = "",
            color = "#6d8086",
            cterm_color = "66",
            name = "Yaml"
          },
          yml = {
            icon = "",
            color = "#6d8086",
            cterm_color = "66",
            name = "Yaml"
          },
          toml = {
            icon = "",
            color = "#9c4221",
            cterm_color = "124",
            name = "Toml"
          },
          xml = {
            icon = "",
            color = "#e37933",
            cterm_color = "166",
            name = "Xml"
          },
          
          -- Web
          html = {
            icon = "",
            color = "#e44d26",
            cterm_color = "196",
            name = "Html"
          },
          css = {
            icon = "",
            color = "#563d7c",
            cterm_color = "60",
            name = "Css"
          },
          scss = {
            icon = "",
            color = "#cf649a",
            cterm_color = "169",
            name = "Scss"
          },
          sass = {
            icon = "",
            color = "#cf649a", 
            cterm_color = "169",
            name = "Sass"
          },
          less = {
            icon = "",
            color = "#1d365d",
            cterm_color = "54",
            name = "Less"
          },
          
          -- Backend
          py = {
            icon = "",
            color = "#3776ab",
            cterm_color = "61",
            name = "Python"
          },
          rb = {
            icon = "",
            color = "#cc342d",
            cterm_color = "160",
            name = "Ruby"
          },
          go = {
            icon = "",
            color = "#00add8",
            cterm_color = "38",
            name = "Go"
          },
          rs = {
            icon = "",
            color = "#dea584",
            cterm_color = "216",
            name = "Rust"
          },
          java = {
            icon = "",
            color = "#007396",
            cterm_color = "24",
            name = "Java"
          },
          php = {
            icon = "",
            color = "#777bb4",
            cterm_color = "103",
            name = "Php"
          },
          
          -- Scripts/Tools
          lua = {
            icon = "",
            color = "#000080",
            cterm_color = "18",
            name = "Lua"
          },
          vim = {
            icon = "",
            color = "#019833",
            cterm_color = "28",
            name = "Vim"
          },
          sh = {
            icon = "",
            color = "#4d5a5e",
            cterm_color = "59",
            name = "Shell"
          },
          bash = {
            icon = "",
            color = "#89e051",
            cterm_color = "113",
            name = "Bash"
          },
          zsh = {
            icon = "",
            color = "#89e051",
            cterm_color = "113",
            name = "Zsh"
          },
          fish = {
            icon = "",
            color = "#4d5a5e",
            cterm_color = "59",
            name = "Fish"
          },
          
          -- Documentation
          md = {
            icon = "",
            color = "#519aba",
            cterm_color = "74",
            name = "Markdown"
          },
          mdx = {
            icon = "",
            color = "#519aba",
            cterm_color = "74",
            name = "Mdx"
          },
          tex = {
            icon = "",
            color = "#3d6117",
            cterm_color = "22",
            name = "Tex"
          },
          
          -- Git
          gitignore = {
            icon = "",
            color = "#f1502f",
            cterm_color = "196",
            name = "GitIgnore"
          },
          gitattributes = {
            icon = "",
            color = "#f1502f",
            cterm_color = "196",
            name = "GitAttributes"
          },
          
          -- Database
          sql = {
            icon = "",
            color = "#dad8d8",
            cterm_color = "188",
            name = "Sql"
          },
          
          -- Docker
          dockerfile = {
            icon = "",
            color = "#384d54",
            cterm_color = "59",
            name = "Dockerfile"
          },
          
          -- C/C++
          c = {
            icon = "",
            color = "#599eff",
            cterm_color = "111",
            name = "C"
          },
          cpp = {
            icon = "",
            color = "#f34b7d",
            cterm_color = "204",
            name = "Cpp"
          },
          h = {
            icon = "",
            color = "#a074c4",
            cterm_color = "140",
            name = "H"
          },
          hpp = {
            icon = "",
            color = "#a074c4", 
            cterm_color = "140",
            name = "Hpp"
          },
        },
        
        override_by_filename = {
          [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "GitIgnore"
          },
          [".eslintrc.js"] = {
            icon = "",
            color = "#4b32c3",
            name = "Eslint"
          },
          [".eslintrc.json"] = {
            icon = "",
            color = "#4b32c3",
            name = "EslintJSON"
          },
          ["package.json"] = {
            icon = "",
            color = "#8bc34a",
            name = "PackageJson",
          },
          ["package-lock.json"] = {
            icon = "",
            color = "#cb3837",
            name = "PackageLockJson"
          },
          ["yarn.lock"] = {
            icon = "",
            color = "#2c8ebb",
            name = "YarnLock"
          },
          ["tsconfig.json"] = {
            icon = "",
            color = "#3178c6",
            name = "TsConfig"
          },
          ["vite.config.js"] = {
            icon = "󰉁",
            color = "#bd34fe",
            name = "ViteConfig"
          },
          ["webpack.config.js"] = {
            icon = "󰜫",
            color = "#8dd6f9",
            name = "WebpackConfig"
          },
          ["tailwind.config.js"] = {
            icon = "󱏿",
            color = "#06b6d4",
            name = "TailwindConfig"
          },
          [".prettierrc"] = {
            icon = "",
            color = "#c596c7",
            name = "PrettierConfig"
          },
          ["Dockerfile"] = {
            icon = "",
            color = "#384d54",
            name = "Dockerfile"
          },
          ["docker-compose.yml"] = {
            icon = "",
            color = "#384d54",
            name = "DockerCompose"
          },
          ["README.md"] = {
            icon = "",
            color = "#519aba",
            name = "Readme"
          },
          ["Makefile"] = {
            icon = "",
            color = "#6d8086",
            name = "Makefile"
          },
          [".env"] = {
            icon = "",
            color = "#faf743",
            name = "Env"
          },
          [".env.local"] = {
            icon = "",
            color = "#faf743",
            name = "EnvLocal"
          },
        },
        
        color_icons = true,
        default = true,
        strict = true,
      })
    end,
  }
}