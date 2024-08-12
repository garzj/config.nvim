local function confirm(question)
	local a = vim.fn.input(question .. " (Y/n): ")
	return a == "" or string.lower(a) == "y"
end

return { confirm = confirm }
