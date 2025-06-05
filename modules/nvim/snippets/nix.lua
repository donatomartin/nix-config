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
		t({ "", "  " }),
		i(2, "body"),
	}),

	-- Let in
	s({ desc = "Let expression", trig = "let" }, {
		t("let"),
		t({ "", "  " }),
		i(1, "bindings"),
		t({ "", "in", "  " }),
		i(2, "expression"),
	}),

	-- If then else
	s({ desc = "If expression", trig = "if" }, {
		t("if "),
		i(1, "cond"),
		t(" then "),
		i(2, "trueExpr"),
		t(" else "),
		i(3, "falseExpr"),
	}),

	-- Derivation
	s({ desc = "Derivation", trig = "drv" }, {
		t("stdenv.mkDerivation {"),
		t({ "", '  name = "' }),
		i(1, "name"),
		t('";'),
		t({ "", "  src = " }),
		i(2, "source"),
		t(";"),
		t({ "", "  buildInputs = [ " }),
		i(3, "inputs"),
		t(" ];"),
		t({ "", "}" }),
	}),

	-- Nixvim plugin
	s({ desc = "NixVim plugin", trig = "nvplugin" }, {
		t("plugins."),
		i(1, "pluginName"),
		t(" = {enable = true;"),
		i(2, "content"),
		t("}"),
	}),
}
