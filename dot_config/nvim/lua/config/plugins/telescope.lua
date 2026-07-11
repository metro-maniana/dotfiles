return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require 'telescope'.setup {
      defaults = {
        file_ignore_patterns = {
          ".git"
        }
      }
    }
    vim.keymap.set("n", "<space>fl", function()
      require('telescope.builtin').live_grep({
        additional_args = function()
          return { "--hidden" }
        end
      })
    end)

    vim.keymap.set("n", "<space>fd", function()
      require('telescope.builtin').find_files({ hidden = true })
    end)

    vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)

    vim.keymap.set("n", "<space>en", function()
      require('telescope.builtin').find_files {
        cwd = vim.fn.stdpath("config"),
        hidden = true
      }
    end)
  end
}
