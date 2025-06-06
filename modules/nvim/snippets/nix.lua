local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {

	-- Función
	s({ desc = "Nix Function", name = "func", trig = "func" }, {
		t("{ "),
		i(1, "args"),
		t(" }:"),
		t({ "", "{" }),
		t({ "", "  " }),
		i(2, "body"),
		t({ "", "}" }),
	}),

	-- VsCode nixvim mappin
	s({ desc = "NixVim VsCode keymap", trig = "vscode" }, {
		t("{"),
		t({ "", '  mode = "n";' }), -- line break and indent
		t({ "", '  key = "' }),
		i(1, "key"),
		t('";'),
		t({ "", "  action = \"<cmd>call VSCodeNotify('" }),
		i(2, "action"),
		t("')<CR>\";"),
		t({ "", "  options = { silent = true; };" }),
		t({ "", "}" }),
	}),
}
