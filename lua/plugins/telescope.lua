return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require("telescope").setup({
        defaults = {
          theme = "ivy",
          mappings = {
            n = {
              ["q"] = require("telescope.actions").close,
            },
          },
          file_ignore_patterns = {
            "node_modules",
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        pickers = {
          oldfiles = {
            theme = "ivy"
          },
          find_files = {
            theme = "ivy"
          },
          live_grep = {
            theme = "ivy"
          },
          grep_string = {
            theme = "ivy"
          }
        }
      })
      local builtin = require("telescope.builtin")
      local find_with_dotfiles = function()
        builtin.find_files({
          find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
          previewer = false,
        })
      end
      -- Function to search for word under cursor
      local grep_word_under_cursor = function()
        local word = vim.fn.expand("<cword>")
        builtin.grep_string({ search = word })
      end
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fh", find_with_dotfiles, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fG", grep_word_under_cursor, {})
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
      -- to also include dot files.
      -- vim.keymap.set(
      --     "n",
      --     "<leader>fh",
      --     "<cmd>lua require'telescope.builtin'.find_files({ find_commands = {'rg', '--files', '--hidden', '-g', '!.git'} })<CR>",
      --     {}
      -- )
      require("telescope").load_extension("ui-select")
    end,
  },
}
