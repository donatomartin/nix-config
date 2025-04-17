{
  programs.nixvim = {

    keymaps = [
      {
        mode = "n";
        key = "<C-n>";
        action = ":Neotree toggle<CR>";
        options.silent = true;
      }
    ];

    plugins.neo-tree = {
      enable = true;

      closeIfLastWindow = true;
      window = {
        width = 30;
        autoExpandWidth = true;
	mappings = {
		"l" = {
			command = "open";
			nowait = false;
		};
		"h" = {
			command = "close_node";
			nowait = false;
		};
	};
      };
    };
  };
}
