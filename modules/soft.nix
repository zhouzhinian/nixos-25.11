{ inputs, config, lib, pkgs, ... }: {
   environment.systemPackages = with pkgs; [
   	git wget ripgrep jq yq-go eza fzf which file gnused zstd gnupg aria2 
	tree zip xz unzip p7zip	yazi helix vscode
        zed-editor vlc rustup fastfetch htop brave
	papirus-icon-theme
        mint-cursor-themes
        subversion
 	dracula-icon-theme
        dracula-theme
	qbittorrent-enhanced
	tokyonight-gtk-theme
	thunderbird
        obs-studio
	sparkle
	splayer
  github-desktop
  ];
 ## Flatpak
services.flatpak.enable = true;  
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
xdg.portal.config.common.default = "gtk";   

services.ollama.enable = true;

# vscode chajian
programs.direnv.enable = true;
}
