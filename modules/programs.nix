{ inputs, config, lib, pkgs, ... }: {
   environment.systemPackages = with pkgs; [
   	git wget ripgrep jq yq-go eza fzf which file gnused zstd gnupg aria2 
	tree zip xz unzip p7zip	yazi
        zed-editor vlc rustup fastfetch htop 
	papirus-icon-theme
        mint-cursor-themes
        subversion
 	dracula-icon-theme
        dracula-theme
	qbittorrent-enhanced
	tokyonight-gtk-theme
	thunderbird
        obs-studio
	vscode
  ];
 ## Flatpak
services.flatpak.enable = true;  
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
xdg.portal.config.common.default = "gtk";
   
services.ollama.enable = true;

}
