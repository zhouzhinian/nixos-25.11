{inputs, pkgs, ...}: {
      environment.systemPackages = with pkgs; [
	inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta
	inputs.nix-wpsoffice-cn.packages.${pkgs.stdenv.hostPlatform.system}.default
	inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
	 
 ];

      fonts.packages = with pkgs; [
	inputs.nix-wpsoffice-cn.packages.${pkgs.stdenv.hostPlatform.system}.chinese-fonts
  ];
}		
