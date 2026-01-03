# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

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
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"  # 清华
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
 #  environment.systemPackages = with pkgs; [
 #    vim git wget curl
 #  ];

  # 桌面环境（根据下载的 ISO 启用一个）
  
  # KDE Plasma
  # services.desktopManager.plasma6.enable = true;

  # GNOME（GNOME ISO 用）
   services.displayManager.gdm.enable = true;
   services.desktopManager.gnome.enable = true;

  # SSH 服务
  services.openssh.enable = true;
  nixpkgs.config.allowUnfree = true;
  # 开启flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # 系统版本（当前最新稳定版 25.11）
  system.stateVersion = "25.11";
}
