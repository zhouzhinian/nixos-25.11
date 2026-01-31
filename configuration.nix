{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

# 主机名与网络
  networking.hostName = "nixos";                  # 改成你喜欢的
  networking.networkmanager.enable = true;

  # 时区与中文支持
  time.timeZone = "Asia/Shanghai";
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    useXkbConfig = true;
  };

  # 国内加速（永久生效）
nix.settings = {
  substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"     # 中科大（可优先）
    "https://cache.nixos.org/"
  ];
  trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
};

  # 普通用户（务必改用户名和初始密码）
  users.users.zhinian = {                            # ← 改成你的用户名
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true; 
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # 基本软件包
  environment.systemPackages = with pkgs; [
     git wget ripgrep jq yq-go eza fzf which file gnused zstd gnupg aria2 
     tree zip xz unzip p7zip yazi
     rustup fastfetch htop 
   ];
  # SSH 服务
  services.openssh.enable = true;
  nixpkgs.config.allowUnfree = true;
  # 开启flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.firefox.enable = true;

  environment.variables = {
	GTK_IM_MODULE = "fcitx";
  	SDL_IM_MODULE = "fcitx";	
   	QT_IM_MODULE = "fcitx";
    	XMODIFIERS = "@im=fcitx";
    	NIXOS_OZONE_WL = "1";

};
    ## Flatpak
 services.flatpak.enable = true;  
 xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
 xdg.portal.config.common.default = "gtk";

  # 系统版本（当前最新稳定版 25.11）
  system.stateVersion = "25.11";
}
