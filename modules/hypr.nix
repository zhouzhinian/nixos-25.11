{inputs, pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  environment.systemPackages = [
	pkgs.hyprpanel
  pkgs.hyprpolkitagent
	pkgs.hyprshot
	pkgs.hyprlock
	pkgs.hypridle
	pkgs.hyprsunset
	pkgs.hyprdim
	pkgs.nautilus
	pkgs.file-roller
	pkgs.satty
	pkgs.nwg-look
	pkgs.kitty

];
 services.displayManager.gdm.enable = true;

}
