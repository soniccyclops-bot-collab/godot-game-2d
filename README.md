# 🎮 SonicCyclops 2D PVP RTS Game

A networked PVP tower defense / RTS hybrid inspired by Mindustry. Two players build production chains, mines, and units. After 15 minutes, their bases connect and enemy bot waves invade.

## 🎯 MVP Features

- **Setup Phase (0-15min):** Mine resources, build factories, construct turrets
- **Invasion Phase (15+min):** Units march toward enemy base, final battle
- **Networked PVP** — Two player matches over LAN/online
- **Pixel Art Aesthetic** — Simple, colorful sprites
- **Minimal Unit Roster** — 1 ground unit, 1 air unit for simplicity
- **Full Test Coverage** — E2E tests from day 1

## 🛠️ Toolchain

- **Game Engine:** [Godot 4](https://godotengine.org/) - Open source 2D/3D engine
- **Pixel Art:** [LibreSprite](https://libresprite.github.io/) - Aseprite fork
- **Music:** [LilyPond](https://lilypond.org/) - Text-based music notation
- **Testing:** [GUT](https://github.com/bitwes/Gut) - Godot Unit Test framework

## 📁 Project Structure

```
├── src/
│   ├── systems/          # Core game systems (resource economy, timer, etc.)
│   ├── scenes/           # Godot scenes
│   └── tests/            # GUT test suites
│       ├── unit/
│       ├── integration/
│       └── e2e/
├── assets/
│   ├── sprites/          # Pixel art (PNG exports)
│   ├── music/            # LilyPond files + audio
│   └── audio/            # SFX
├── docs/                 # Game Design Doc, Testing Guide
└── Makefile              # Build automation
```

## 🚀 Development

### Setup
```bash
make setup              # Initialize project structure
git clone https://github.com/bitwes/Gut.git addons/gut  # Install GUT
```

### Running
```bash
make run               # Launch game in editor
make run-cage         # Launch in Cage (kiosk mode for video capture)
```

### Testing
```bash
make test              # Run unit tests
make test-all          # Run all test suites (unit, integration, e2e)
make test-coverage     # Generate coverage reports
```

### Asset Creation
```bash
make sprites           # Process sprite files
make music             # Compose and export music
```

## 📚 Documentation

- **[Game Design Document](docs/GDD.md)** - Core concept, mechanics, MVP scope
- **[Testing Architecture](docs/TESTING.md)** - Test patterns, pyramid, coverage goals
- **[GUT Setup Guide](docs/GUT_SETUP.md)** - Framework installation

## 🎨 Asset Library (MVP)

### Units
| Sprite | Type | Role |
|--------|------|------|
| ![Ship](assets/sprites/spaceship.png) | Spaceship | Player observation |
| ![Ground](assets/sprites/ground_unit.png) | Ground Unit | Tank-like, fires projectiles |
| ![Air](assets/sprites/air_unit.png) | Air Unit | Flies over terrain |

### Buildings
| Sprite | Type | Function |
|--------|------|----------|
| ![Turret](assets/sprites/turret.png) | Turret | Auto-target defense |
| ![Iron Mine](assets/sprites/iron_mine.png) | Iron Mine | Produces iron |
| ![Coal Mine](assets/sprites/coal_mine.png) | Coal Mine | Produces coal |
| ![Ground Factory](assets/sprites/ground_factory.png) | Ground Factory | Builds ground units |
| ![Air Factory](assets/sprites/air_factory.png) | Air Factory | Builds air units |

## 🎮 Gameplay Loop

1. **Match Start** → Map generates, resources visible
2. **Setup (0-15min)** → Players mine, build factories, construct turrets
3. **Invasion (15+min)** → Units march through connection point to enemy base
4. **Combat** → Turrets + remaining units defend
5. **Victory** → Destroy enemy core or last survivor wins

## 🧪 Testing Philosophy

- **E2E First** — Full game scenarios before unit tests
- **Testable Architecture** — All systems designed for isolation
- **100% Coverage on Critical Paths** — Resource economy, combat, timers
- **CLI Test Execution** — Run via Makefile or CI/CD

## 📈 Roadmap (Post-MVP)

- [ ] Campaign/story mode
- [ ] Ranked matchmaking
- [ ] Additional unit types
- [ ] Map variety + terrain effects
- [ ] Spectator mode
- [ ] Replay system
- [ ] Cosmetics/skins

## 🏗️ Status

**Current Phase:** Core Architecture + Test Suite  
**Latest Commit:** Asset library created  
**Test Coverage:** Core systems (ResourceEconomy, GameTimer, Player)

---

**Built by SonicCyclops 🔴**  
*OpenClaw AI Assistant on Raspberry Pi*