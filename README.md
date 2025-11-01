# ️❄️ NixOS Starter with a [dendritic](https://github.com/mightyiam/dendritic) touch

A modular **NixOS flake setup** designed for quick bootstrapping, clear structure, and long-term scalability.
It follows a _dendritic pattern_: branching modules that stay cleanly separated yet interconnected through [`flake.parts`](https://github.com/hercules-ci/flake-parts).

## 🌱 Features

- **Flake-based layout** with `flake-parts` and `import-tree`
- **Stable & unstable** nixpkgs side by side (`nixos-25.05` + `nixos-unstable`)
- **Integrated Home Manager** (system + user separation)
- **Preconfigured developer tools**:
  - `treefmt` for formatting
  - `git-hooks.nix` for pre-commit checks
  - `nh` for flake management and cleanup
- **Battery-friendly laptop defaults** (powersave, geoclue, suspend actions)
- **Modular overlays** for custom & stable package layers
- **Declarative users**, ready for SSH + wheel access

## 🧠 Core Ideas

- Keep **Nix logic declarative**, not imperative
- Organize modules **by context**, not by feature overlap
- Avoid hard-coding values (see `TODO` hints for user details and paths)
- Reuse `flake.meta` for **cross-module data sharing**
