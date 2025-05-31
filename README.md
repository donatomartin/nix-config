# My NixOS Configuration

In this repo you will find all my laptop's configuration, all the tools and services I have enabled on my daily basis. Most of the functionality is installed in the home-manager so it can be installed in any OS without superuser or admin privileges using a single-user nix package manager installation.

You will also find my nixvim configuration as a home-manager module, feel free to use, modify and share any of the resources found in this codebase.

## Nix single-user installation

```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

```bash
. ~/.nix-profile/etc/profile.d/nix.sh
```

Enable the required experimental features for it to work (nix-command and flakes)

```bash
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

Check it's working

```bash
nix --version
```

## Home-manager installation

```bash
cd ~
git clone https://github.com/donatomartin/nix-config
cd nix-config
```

Replace the username and system variables with your own in the [flake](./flake.nix) before running the next command.

```bash
nix run .#activate-home
```

Verify it's working

```bash
home-manager generations
```

## Execute NixVim Directly

```bash
nix run github:donatomartin/nix-config#nixvim
```
