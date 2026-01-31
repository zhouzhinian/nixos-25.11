{ inputs, config, lib, pkgs, ... }: {
   environment.systemPackages = with pkgs; [
   helix
   zed-editor
   vlc
   papirus-icon-theme
   mint-cursor-themes
   dracula-icon-theme
   dracula-theme
   qbittorrent-enhanced
   tokyonight-gtk-theme
   thunderbird
   obs-studio
#  sparkle
   splayer
   github-desktop
  ];
services.ollama.enable = true;

# vscode chajian
programs.direnv.enable = true;
programs.clash-verge.enable = true;
programs.zsh.enable = true;
users.defaultUserShell = pkgs.zsh;

}
