---@diagnostic disable: undefined-global
return {
	s({ desc = "Current time", name = "time", trig = "timex" }, {
		f(function()
			return os.date("%H:%M")
		end),
	}),
}
