#!/bin/bash -e

# ============================================================================================================
# 移植RK3399示例，其他RK3399可模仿
# ============================================================================================================
# 增加设备
echo -e "\ndefine Device/tvi_tvi3315a
  DEVICE_VENDOR := Tvi
  DEVICE_MODEL := TVI3315A
  SOC := rk3399
  UBOOT_DEVICE_NAME := tvi3315a-rk3399
endef
TARGET_DEVICES += tvi_tvi3315a" >> target/linux/rockchip/image/armv8.mk

# 替换package/boot/uboot-rockchip/Makefile
cp -f $GITHUB_WORKSPACE/configfiles/uboot-rockchip/Makefile package/boot/uboot-rockchip/Makefile

# 复制dts与配置文件到package/boot/uboot-rockchip
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3399/{rk3399.dtsi,rk3399-opp.dtsi,rk3399-tvi3315a.dts} package/boot/uboot-rockchip/src/arch/arm/dts/
cp -f $GITHUB_WORKSPACE/configfiles/uboot-rockchip/rk3399-tvi3315a-u-boot.dtsi package/boot/uboot-rockchip/src/arch/arm/dts/
cp -f $GITHUB_WORKSPACE/configfiles/uboot-rockchip/tvi3315a-rk3399_defconfig package/boot/uboot-rockchip/src/configs/

# 复制dts到 target/linux/rockchip/dts/rk3399
# 【修复】istoreos-25.12（内核 6.12）设备树改用 dts/<soc>/ 机制，
# 原路径 files/arch/arm64/boot/dts/rockchip/ 在该分支不存在（files/ 只放内核驱动补丁）
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3399/{rk3399.dtsi,rk3399-opp.dtsi,rk3399-tvi3315a.dts} target/linux/rockchip/dts/rk3399/

# 添加dtb补丁到target/linux/rockchip/patches-6.12
# 【修复】原 patches-6.6 目录在该分支不存在（内核版本为 6.12）
cp -f $GITHUB_WORKSPACE/configfiles/patch/800-add-rk3399-tvi3315a-dtb-to-makefile.patch target/linux/rockchip/patches-6.12/

# ============================================================================================================
# 移植RK3566示例，其他RK35xx可模仿
# ============================================================================================================
# 增加设备
cp -f $GITHUB_WORKSPACE/configfiles/uboot-rockchip/legacy.mk target/linux/rockchip/image/legacy.mk

# 复制dts与配置文件到package/boot/uboot-rockchip
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3568/rk3566-roc-pc.dts package/boot/uboot-rockchip/src/arch/arm/dts/
cp -f $GITHUB_WORKSPACE/configfiles/uboot-rockchip/rk3566-station-m2-u-boot.dtsi package/boot/uboot-rockchip/src/arch/arm/dts/
cp -f $GITHUB_WORKSPACE/configfiles/uboot-rockchip/station-m2-rk3566_defconfig package/boot/uboot-rockchip/src/configs/

# 复制dts到target/linux/rockchip/dts/rk3568
cp -f $GITHUB_WORKSPACE/configfiles/dts/rk3568/rk3566-jp-tvbox.dts target/linux/rockchip/dts/rk3568/
