{
  description = "NixOS configuration with auto-module loading";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

     nix-wpsoffice-cn = {
	    url = "github:Beriholic/nix-wpsoffice-cn";
        inputs.nixpkgs.follows = "nixpkgs";
	};
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
     };
    hyprland.url = "github:hyprwm/Hyprland";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    # 自动扫描 modules 目录下的所有 .nix 文件
    configDir = ./modules;
    generatedModules = builtins.map (file: configDir + "/${file}")
      (builtins.filter (file: nixpkgs.lib.hasSuffix ".nix" file)
        (builtins.attrNames (builtins.readDir configDir)));
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ] ++ generatedModules;
    };
  };
}
