{
  programs.nixvim = {

    plugins.noice = {
      enable = true;
      settings = {
        routes = [
          {
            view = "notify";
            filter = {
              event = "msg_showmode";
            };
          }
        ];

      };
    };
  };
}
