# Nethunter architecture

## Goals

- Keep kernel-side Nethunter toggles config-driven.
- Match the builder to the actual kernel/platform layout synced by each manifest.
- Maximise real coverage without pretending missing source trees exist.

## Config fields

Each device config includes:

- `platform_family`: current family classifier (`qcom` or `mediatek`)
- `nethunter_kernel`: enables generic kernel config additions
- `nethunter_modules`: enables the module build job
- `nethunter_modules_strategy`: selects the implemented builder path
- `nethunter_modules_note`: human-readable support note

## Implemented strategies

### `qcom_legacy_vendor`

For older Qualcomm trees that still use the legacy vendor/prebuilt layout.

Characteristics:
- `kernel_platform/common` source root
- legacy prebuilt layout (`prebuilts-master` and friends)
- Qualcomm / Oplus vendor module directories may exist and are built when present

### `qcom_ddk_vendor`

For newer Qualcomm DDK-style trees.

Characteristics:
- `kernel_platform/common` source root
- `kernel_platform/build/prebuilts/...` links and newer clang layout
- optional Rust/DDK prebuilts
- synced vendor module directories are built when present

### `qcom_aosp_vendor`

For the newest Qualcomm AOSP main-kernel style manifests.

Characteristics:
- `main-kernel-2025` style manifests
- AOSP prebuilts paths (`platform/prebuilts/...` in manifest, linked into `kernel_platform/prebuilts/...`)
- synced vendor module directories are built when present

### `mtk_gki`

For MediaTek manifests that expose a linked kernel tree via `kernel_platform/common -> kernel-*`.

Characteristics:
- in-tree GKI module build is implemented
- no fake Qualcomm path reuse
- current manifests do **not** sync separate MTK vendor external-module repos, so only in-tree Nethunter modules are built

## Current reality

- Generic Nethunter config plumbing is shared.
- Every config in the repo can now use a real builder path matching its manifest layout.
- Qualcomm external vendor modules are opportunistic: they are compiled only when the synced tree actually contains them.
- MediaTek remains honest about the blocker: missing external vendor repos in current manifests.
- OP11 keeps its existing model-specific patchset; other devices use the generic family flow unless real per-model patches are added.

## How to add a new family

1. Add or extend family/layout detection in `.github/scripts/nethunter-lib.sh`.
2. Implement the new `nethunter_modules_strategy` in `.github/kernel_modules/action.yml`.
3. Enable the strategy only on configs whose manifests really match that layout.
4. Document any blockers instead of silently falling back to an unrelated family path.
