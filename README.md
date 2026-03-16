<div align="center">

# 🔥 Wild Kernels for OnePlus (Oppo/Realme)

[![KernelSU](https://img.shields.io/badge/KernelSU-Supported-green)](https://kernelsu.org/)
[![KernelSU-Next](https://img.shields.io/badge/KernelSU-Supported-green)](https://kernelsu-next.github.io/webpage/)
[![SUSFS](https://img.shields.io/badge/SUSFS-Integrated-orange)](https://gitlab.com/simonpunk/susfs4ksu)

</div>

---

## ⚠️ Disclaimer

Flashing this kernel will not void your warranty, but there is always a risk of bricking your device. Please make sure to:
- 💾 Back up your data
- 🧠 Understand the risks before proceeding

- I am **not responsible** for bricked devices, damaged hardware, or any issues that arise from using this kernel.
- **Please** do thorough research and fully understand the features added in this kernel before flashing it.
- By flashing this kernel, **YOU** are choosing to make these modifications. If something goes wrong, **do not blame me**.

<div align="center">

# **🚨 Proceed at your own risk!**

</div>

---

## 🔧 Available Kernels

<div align="center">

| Kernel | Repository | Status |
|--------|------------|--------|
| 🏗️ **GKI** | [GKI_KernelSU_SUSFS](https://github.com/WildKernels/GKI_KernelSU_SUSFS) | ✅ Active |
| 👑 **Sultan** | [Sultan_KernelSU_SUSFS](https://github.com/WildKernels/Sultan_KernelSU_SUSFS) | ✅ Active |
| 📱 **OnePlus/Oppo/Realme** | [OnePlus_KernelSU_SUSFS](https://github.com/WildKernels/OnePlus_KernelSU_SUSFS) | ✅ Active |
| 📱 **Samsung** | [Samsung_KernelSU_SUSFS](https://github.com/WildKernels/Samsung_KernelSU_SUSFS) | ✅ Active |
</div>

---

## 🔗 Additional Resources

- 🩹 [Kernel Patches](https://github.com/WildKernels/kernel_patches)
- ⚡ [Kernel Flasher](https://github.com/fatalcoder524/KernelFlasher)

---

## Device Compatibility

- Please verify the device compatibility before flashing here: [Compatibility_Info](https://github.com/WildKernels/OnePlus_KernelSU_SUSFS/blob/main/compatibility.md).

---

## ✨ Features

- 🔐 **KernelSU / KernelSU-Next**: Kernel-level root support
- 🔥 **WildKSU Manager Support**
- 🥷 **SUSFS** integration
- 🛡️ **BBG**: Baseband Guard security
- 🛠️ **HMBIRD SCX**: Enabled on supported SM8750 / MT6991 targets
- 🖧 **BBRv1**
- ✅ **LTO**
- 🚀 **Optimisation patches**
- 🌐 **TTL Target Support**
- 🧱 **IP Set & IPv6 NAT Support**
- ⚡️ **TMPFS XATTR / POSIX ACL**
- </> **Unicode Bypass Fix**
- 📡 **Config-driven Nethunter support**
  - `nethunter_kernel`: generic kernel config toggles; architecture is shared and can be enabled per config
  - `nethunter_modules`: family-aware module build toggle implemented across the repo's real kernel layouts
  - Strategies are explicit per layout family (`qcom_legacy_vendor`, `qcom_ddk_vendor`, `qcom_aosp_vendor`, `mtk_gki`) instead of pretending one builder fits every tree

---

## 📡 Nethunter support status

This repo now groups Nethunter module support by the kernel layouts that actually exist in the synced manifests.

### What is actually implemented

- **Kernel-side Nethunter config framework:** still config-driven
- **In-tree module build:** implemented for every device family currently described by the manifests in this repo
- **External vendor-module build:** implemented for Qualcomm trees when the synced source actually contains those vendor module directories

### Implemented layout strategies

- `qcom_legacy_vendor`
  - older Qualcomm trees with legacy prebuilts / vendor layout
- `qcom_ddk_vendor`
  - Qualcomm DDK-style trees (`kernel_platform/common`, newer prebuilts layout, optional Rust/DDK bits)
- `qcom_aosp_vendor`
  - newest Qualcomm AOSP-main-kernel style trees (for example SM8845 / SM8850 manifests)
- `mtk_gki`
  - MediaTek linked-kernel trees (`kernel_platform/common` linked to `kernel-5.10`, `kernel-6.1`, or `kernel-6.6`)

### Honest limitations

- MediaTek manifests in this repo currently expose the kernel tree itself, but not separate vendor external-module repositories. Those configs now build the in-tree Nethunter module set and explicitly stop there.
- Qualcomm configs attempt external vendor modules only when the synced tree actually contains the referenced module directories. Missing vendor repos are reported as such instead of being faked.
- The OP11-specific patchset remains model-specific; other devices use the generic family pipeline unless real per-model patches are added.

### Current enabled configs

All shipped device configs now carry an explicit Nethunter module strategy and are enabled for the family path that matches their manifest layout.

### How to add support for a new device

1. Set `platform_family` correctly (`qcom` or `mediatek` currently).
2. Pick the real layout strategy that matches the manifest/tree shape.
3. Enable `nethunter_modules` only after wiring that strategy to the synced source layout.
4. Update docs if the manifest introduces a genuinely new family or blocker.

---

## 📋 Installation Instructions

For GKI installation, please follow the official guide:

📖 **[KernelSU Installation Guide](https://kernelsu.org/guide/installation.html)**

You can also find installation instructions in the release notes.

---

## 🌟 Special Thanks

**These amazing people help make this project possible! ❤️**

<div align="center">

| 🔧 **Project** | 👨‍💻 **Developer** | 🔗 **Link** |
|:---------------:|:----------------:|:-----------:|
| **KernelSU** | tiann | [![GitHub](https://img.shields.io/badge/GitHub-tiann-blue?style=flat-square&logo=github)](https://github.com/tiann/KernelSU) |
| **KernelSU-Next** | rifsxd | [![GitHub](https://img.shields.io/badge/GitHub-rifsxd-blue?style=flat-square&logo=github)](https://github.com/KernelSU-Next/KernelSU-Next) |
| **Magic-KSU** | 5ec1cff | [![GitHub](https://img.shields.io/badge/GitHub-5ec1cff-blue?style=flat-square&logo=github)](https://github.com/5ec1cff/KernelSU) |
| **SUSFS** | simonpunk | [![GitLab](https://img.shields.io/badge/GitLab-simonpunk-orange?style=flat-square&logo=gitlab)](https://gitlab.com/simonpunk/susfs4ksu.git) |
| **SUSFS Module** | sidex15 | [![GitHub](https://img.shields.io/badge/GitHub-sidex15-blue?style=flat-square&logo=github)](https://github.com/sidex15) |
| **Sultan Kernels** | kerneltoast | [![GitHub](https://img.shields.io/badge/GitHub-kerneltoast-blue?style=flat-square&logo=github)](https://github.com/kerneltoast) |
| **Baseband Guard** | vc-teahouse | [![GitHub](https://img.shields.io/badge/GitHub-vc--teahouse-blue?style=flat-square&logo=github)](https://github.com/vc-teahouse/Baseband-guard.git) |

</div>

*If you have contributed and are not listed here, please remind me.* 🙏

---

## 💬 Support

If you encounter any issues or need help, feel free to:
- 🐛 Open an issue in this repository
- 💬 Reach out directly

---

## 📱 Connect With Us

<div align="center">

[![Telegram](https://img.shields.io/badge/Telegram-fatalcoder524-blue?logo=telegram)](https://t.me/anonymous_yolo)
[![Telegram Group](https://img.shields.io/badge/Telegram-WildKernels-blue?logo=telegram)](https://t.me/WildKernels)

</div>

---

## 💝 Donations

Any and all donations are appreciated.

PayPal: [paypal.me/fatalcoder524](https://paypal.me/fatalcoder524)

DM on Telegram for UPI donations!
