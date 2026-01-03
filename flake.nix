{
  description = "NixOS configuration with Noctalia";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
      nix-wpsoffice-cn = {
	url = "github:Beriholic/nix-wpsoffice-cn";
        inputs.nixpkgs.follows = "nixpkgs"; 
	};
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, ... }: 
  let
    lib = nixpkgs.lib;
    configDir = ./modules;
    generatedModules = lib.map (file: "${configDir}/${file}") 
      (lib.filter (file: lib.hasSuffix ".nix" file) 
        (lib.attrNames (builtins.readDir configDir)));
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      
      modules = [
        ./configuration.nix
      ] ++ generatedModules; 
    };
  };
}
