{
  pkgs,
  ...
}:
{

  imports = [
    # include NixOS-WSL modules
    ./hardware-configuration.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "donato";
  networking.hostName = "wsl";

  users.users.donato = {
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  # Enable experimental
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    ripgrep
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
