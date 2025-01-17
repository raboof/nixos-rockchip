{ pkgs, lib }:

let
  kernelConfig = with lib.kernel; {
    ARCH_ROCKCHIP = yes;
    CHARGER_RK817 = yes;
    COMMON_CLK_RK808 = yes;
    COMMON_CLK_ROCKCHIP = yes;
    GPIO_ROCKCHIP = yes;
    MFD_RK808 = yes;
    MMC_DW = yes;
    MMC_DW_ROCKCHIP = yes;
    MMC_SDHCI_OF_DWCMSHC = yes;
    MOTORCOMM_PHY = yes;
    PCIE_ROCKCHIP_DW_HOST = yes;
    PHY_ROCKCHIP_INNO_CSIDPHY = yes;
    PHY_ROCKCHIP_INNO_DSIDPHY = yes;
    PHY_ROCKCHIP_INNO_USB2 = yes;
    PHY_ROCKCHIP_NANENG_COMBO_PHY = yes;
    PINCTRL_ROCKCHIP = yes;
    PWM_ROCKCHIP = yes;
    REGULATOR_RK808 = yes;
    ROCKCHIP_DW_HDMI = yes;
    ROCKCHIP_IODOMAIN = yes;
    ROCKCHIP_IOMMU = yes;
    ROCKCHIP_MBOX = yes;
    ROCKCHIP_PHY = yes;
    ROCKCHIP_PM_DOMAINS = yes;
    ROCKCHIP_SARADC = yes;
    ROCKCHIP_THERMAL = yes;
    ROCKCHIP_VOP2 = yes;
    RTC_DRV_RK808 = yes;
    SND_SOC_RK817 = yes;
    SND_SOC_ROCKCHIP = yes;
    SND_SOC_ROCKCHIP_I2S_TDM = yes;
    SPI_ROCKCHIP = yes;
    STMMAC_ETH = yes;
    VIDEO_HANTRO_ROCKCHIP = yes;
  };
in
with pkgs.linuxKernel;
{
  linux_6_1          = pkgs.linuxPackages_6_1;
  linux_6_1_rockchip = packagesFor (kernels.linux_6_1.override { structuredExtraConfig = kernelConfig; });

  linux_6_4          = pkgs.linuxPackages_6_4;
  linux_6_4_rockchip = packagesFor (kernels.linux_6_4.override { structuredExtraConfig = kernelConfig; });

  linux_6_4_pinetab  = packagesFor (kernels.linux_6_4.override {
    argsOverride = {
      src = pkgs.fetchFromGitHub {
        owner = "dreemurrs-embedded";
        repo = "linux-pinetab2";
        rev = "7bf088c52c63ac80e1635f9edc5d3ca73619a254";
        sha256 = "+jt4ni8I9dHVPyILGJkEdKgPK/C02e7cte6B1EyQRT8=";
      };
      version = "6.4.3-danctnix1";
      modDirVersion = "6.4.3-danctnix1";
    };
    structuredExtraConfig = kernelConfig;
  });
}

