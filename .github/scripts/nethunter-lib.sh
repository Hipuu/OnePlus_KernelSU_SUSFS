#!/usr/bin/env bash

set -euo pipefail

nethunter_platform_family() {
  local family="${OP_PLATFORM_FAMILY:-}"
  if [[ -n "$family" ]]; then
    printf '%s\n' "$family"
    return 0
  fi

  case "${OP_SOC:-}" in
    pineapple|sun|kalama|waipio|canoe|blair|crow|cliffs)
      printf 'qcom\n'
      ;;
    dimensity*|helio*)
      printf 'mediatek\n'
      ;;
    *)
      printf 'unknown\n'
      ;;
  esac
}

nethunter_modules_supported() {
  local family
  family="$(nethunter_platform_family)"
  case "$family:${OP_NETHUNTER_MODULES_STRATEGY:-none}" in
    qcom:qcom_vendor)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

append_config_if_missing() {
  local config_file="$1"
  shift
  local line
  for line in "$@"; do
    grep -qxF "$line" "$config_file" || echo "$line" >> "$config_file"
  done
}

apply_nethunter_kernel_config() {
  local config_file="$1"
  append_config_if_missing "$config_file" \
    CONFIG_BT_HCIBTUSB=y \
    CONFIG_BT_HCIBTUSB_BCM=y \
    CONFIG_BT_HCIBTUSB_RTL=y \
    CONFIG_BT_HCIVHCI=y \
    CONFIG_BT_HCIBCM203X=y \
    CONFIG_BT_HCIBPA10X=y \
    CONFIG_BT_HCIBFUSB=y \
    CONFIG_USB_AIRSPY=y \
    CONFIG_USB_HACKRF=y \
    CONFIG_CAN=y \
    CONFIG_CAN_DEV=y \
    CONFIG_CAN_CALC_BITTIMING=y \
    CONFIG_CAN_LEDS=y \
    CONFIG_CAN_VCAN=y \
    CONFIG_CAN_GRCAN=y \
    CONFIG_CAN_XILINXCAN=y \
    CONFIG_CAN_C_CAN=y \
    CONFIG_CAN_C_CAN_PLATFORM=y \
    CONFIG_CAN_C_CAN_PCI=y \
    CONFIG_CAN_CC770=y \
    CONFIG_CAN_CC770_ISA=y \
    CONFIG_CAN_CC770_PLATFORM=y \
    CONFIG_CAN_M_CAN=y \
    CONFIG_CAN_M_CAN_PCI=y \
    CONFIG_CAN_M_CAN_PLATFORM=y \
    CONFIG_CAN_M_CAN_TCAN4X5X=y \
    CONFIG_CAN_HI311X=y \
    CONFIG_CAN_MCP251X=y \
    CONFIG_CAN_8DEV_USB=y \
    CONFIG_CAN_EMS_USB=y \
    CONFIG_CAN_ESD_USB2=y \
    CONFIG_CAN_GS_USB=y \
    CONFIG_CAN_KVASER_USB=y \
    CONFIG_CAN_PEAK_USB=y \
    CONFIG_NETLINK_DIAG=y \
    CONFIG_VSOCKETS=y \
    CONFIG_NET_SCHED=y \
    CONFIG_NET_EMATCH_CANID=y \
    CONFIG_USB_SERIAL=y \
    CONFIG_USB_SERIAL_CONSOLE=y \
    CONFIG_USB_SERIAL_GENERIC=y \
    CONFIG_USB_SERIAL_CH341=y \
    CONFIG_USB_SERIAL_FTDI_SIO=y \
    CONFIG_USB_SERIAL_PL2303=y
}

apply_nethunter_module_config() {
  local config_file="$1"
  local scripts_config="$2"

  "$scripts_config" --file "$config_file" \
    --enable CONFIG_WLAN_VENDOR_REALTEK \
    --enable CONFIG_WLAN_VENDOR_ATH \
    --module CONFIG_ATH_COMMON \
    --module CONFIG_ATH9K \
    --module CONFIG_ATH9K_HW \
    --module CONFIG_ATH9K_HTC \
    --module CONFIG_ATH9K_COMMON \
    --module CONFIG_ATH10K \
    --module CONFIG_ATH10K_USB \
    --module CONFIG_ATH11K \
    --enable CONFIG_WLAN_VENDOR_MEDIATEK \
    --module CONFIG_MT7601U \
    --module CONFIG_MT76_CORE \
    --module CONFIG_MT76_USB \
    --module CONFIG_MT76x02_LIB \
    --module CONFIG_MT76x02_USB \
    --module CONFIG_MT76_CONNAC_LIB \
    --module CONFIG_MT7603E \
    --module CONFIG_MT76x2_COMMON \
    --module CONFIG_MT76x0_COMMON \
    --module CONFIG_MT7615_COMMON \
    --module CONFIG_MT7915E \
    --module CONFIG_MT7921E \
    --module CONFIG_MAC80211_LEDS \
    --module CONFIG_CAN_SLCAN
}
