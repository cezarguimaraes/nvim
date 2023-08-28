local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	local str = vim.fn.input("Grep >");
	print("searching for " .. str)
	builtin.grep_string({ search = str });
end)

