local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	local grep = vim.fn.input("Grep > ")
	if not (grep == nil or grep == '') then
		builtin.grep_string({search = grep})
	end
end)
