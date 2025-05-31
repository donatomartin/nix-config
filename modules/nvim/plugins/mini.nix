{
  plugins.mini = {
    enable = true;
    modules = {
      ai = {
        n_lines = 50;
        search_method = "cover_or_next";
      };
      comment = {
        mappings = {
          comment = "<leader>/";
          comment_line = "<leader>/";
          comment_visual = "<leader>/";
          textobject = "<leader>/";
        };
      };
    };
  };
}
