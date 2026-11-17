# NOCTELLE React

**A modern, component-driven UI foundation for NOCTELLE on Roblox.**

A React-Luau frontend development project focused on clean architecture, consistent design systems, responsive layouts, and a restrained, anime-inspired interface.

**Status:** Early development · Foundation established

---

## Overview

NOCTELLE React is an ongoing frontend modernization initiative for NOCTELLE, a social hangout experience on Roblox.

The project explores how declarative React components, reusable design tokens, and a structured development workflow can improve UI consistency, maintainability, and accessibility.

Its visual direction, **SAO Minimal**, emphasizes clarity over decoration: subtle glass surfaces, refined typography, thin borders, carefully balanced spacing, and contextual interactions.

## Technology Stack

| Technology | Purpose |
|---|---|
| Luau | Application and component language |
| React-Luau | Declarative UI development |
| ReactRoblox | Native Roblox GUI rendering |
| Rojo | Source synchronization with Roblox Studio |
| Wally | Package and dependency management |
| Rokit | Reproducible development toolchain |
| StyLua | Code formatting |
| Selene | Static analysis |
| Git | Version control |

## Design Philosophy

**Minimal by default.** The game environment takes priority over the interface.

**Consistent by design.** Shared tokens govern typography, spacing, control sizing, and visual proportions.

**Responsive in practice.** Components must account for viewport constraints, UI scaling, and actual rendered interaction targets.

**Theme-aware.** The system is intended to support NOCTELLE's six existing themes: Noctelle, Rose, Ocean, Emerald, Ember, and Monochrome.

**Accessible and intentional.** Controls should be readable, comfortably interactive, and free of unnecessary visual noise.

## Project Structure

```text
NOCTELLE-DEV/
├── src/
│   └── shared/
│       └── Foundation/
│           ├── Bootstrap.luau
│           ├── ReactSmokeTest.luau
│           └── Tokens.luau
├── default.project.json
├── rokit.toml
├── wally.toml
├── wally.lock
└── README.md
```

The structure will expand as reusable components and feature-specific interfaces are developed.

## Getting Started

### Prerequisites

- Roblox Studio
- Git
- Rokit
- Rojo Studio plugin
- A supported code editor, such as VS Code

### Local setup

```powershell
git clone <your-repository-url>
cd noctelle-react

rokit install
wally install
```

Build and validate the Rojo project:

```powershell
rojo build default.project.json -o rojo-test.rbxlx
```

Start the development server:

```powershell
rojo serve default.project.json
```

Connect the Rojo Studio plugin to the appropriate development experience.

**Important:** The Rojo configuration is intentionally restricted to the dedicated development place. It does not represent a complete, standalone copy of the NOCTELLE game.

## Development Progress

**Completed**

- [x] Separate development experience and local backup
- [x] Git repository and pinned toolchain
- [x] Isolated Rojo source mapping
- [x] React-Luau dependency installation
- [x] Successful native GUI render test
- [x] Source-managed React smoke test
- [x] Initial design-token module
- [x] Logical touch-target calculation verified

**Planned**

- [ ] Reusable typography primitives
- [ ] Accessible button and icon-button components
- [ ] Minimal glass panel components
- [ ] React theme integration
- [ ] Responsive layout and scaling validation
- [ ] UI component playground
- [ ] Gradual migration of existing NOCTELLE interfaces

## Architecture

This repository focuses on the **presentation layer**.

Existing gameplay services, server-side permissions, remote communication, and persistent systems are intended to remain independent of React UI implementation.

The migration strategy prioritizes isolated development, incremental integration, and functional parity before replacing legacy interfaces.

## Project Scope

This is a frontend development project, **not the complete NOCTELLE game source**.

The full production experience, proprietary game assets, and private server-side implementation are not included.

## Acknowledgments

Inspired by the clean, futuristic interface language associated with *Sword Art Online*, adapted into an original, understated visual direction for NOCTELLE.

Built with the Roblox development ecosystem and the open-source React-Luau tooling community.

---

**NOCTELLE React** — Less interface. More experience.