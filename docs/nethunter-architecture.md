# Nethunter architecture

## Goals

- Keep kernel-side Nethunter toggles config-driven.
- Avoid pretending one device's external module builder works on every SoC family.
- Allow staged expansion by platform family.

## Config fields

Each device config now includes:

- `platform_family`: current family classifier (`qcom` or `mediatek`)
- `nethunter_kernel`: enables generic kernel config additions
- `nethunter_modules`: enables external module build job
- `nethunter_modules_strategy`: selects the implemented builder path
- `nethunter_modules_note`: human-readable support note

## Current strategies

### `qcom_vendor`

Implemented in `.github/kernel_modules/action.yml`.

Assumptions:
- QCOM-style `kernel_platform/msm-kernel`
- QCOM / Oplus vendor module layout
- existing vendor module make targets are present

This path currently keeps the OP11-specific patchset only where it is actually needed, while allowing other QCOM configs to reuse the generic module-config pipeline without falsely claiming model-specific patch coverage.

### `none`

No external module build.

Used for:
- unsupported devices
- unvalidated devices
- MediaTek targets until a dedicated builder exists

## Current reality

- Generic kernel-side Nethunter config plumbing is reusable.
- External module builds are only implemented for QCOM configs that explicitly opt into `qcom_vendor`.
- MediaTek is intentionally left as a documented placeholder/guardrail, not fake support.

## How to add a new family

1. Add family detection to `.github/scripts/nethunter-lib.sh`.
2. Implement a new `nethunter_modules_strategy` in `.github/kernel_modules/action.yml` or split it into family-specific scripts.
3. Enable the new strategy only on tested configs.
4. Update `README.md` and this document.
