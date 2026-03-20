# Game Design Document - SonicCyclops 2D PVP RTS

## 1. High Concept

A PVP tower defense / RTS hybrid inspired by Mindustry. Two players build production chains, towers, and units to defend their base. After 15 minutes, their bases connect and enemy bot waves invade each other's territory through connecting points. Victory goes to the last player with an operational core.

---

## 2. Core Gameplay Loop

### Setup Phase (0-15 minutes)
1. **Resource Gathering** — Mines extract resources from the map
2. **Production Chains** — Refinery/smelter/factory blocks convert raw resources into useful materials
3. **Defense Building** — Construct turrets to defend against neutral enemies (if any) or prepare for invasion
4. **Unit Production** — Factories build combat units (drills, tanks, etc.)
5. **Economy Management** — Balance spending on defense vs. production

### Invasion Phase (15+ minutes)
1. **Base Connection** — Player bases link via 1-2 connecting corridors
2. **Bot March** — Each player's accumulated units march toward enemy base through connection points
3. **Final Defense** — Turrets + remaining units defend against invasion
4. **Victory Condition** — Destroy enemy core OR last player with functional core wins

---

## 3. Player Experience

### Goals
- Fast-paced, tense PVP matches (~20-30 min total gameplay)
- Strategic decisions: When to build units? When to strengthen defenses?
- Moment of anticipation before invasion phase begins
- Climactic final battle as units clash at the border

### Feedback Loops
- See enemy unit count increasing → player feels pressure to defend
- Turret placement matters → skilled play rewarded
- Resource management constraints → tradeoff decisions

---

## 4. Target Scope

| Element | Scope |
|---------|-------|
| Game Modes | Single match only (no campaign) |
| Multiplayer | TBD: Local 2-player or networked? |
| Map Size | Medium (dynamically generated) |
| Gameplay Loop Duration | 20-30 minutes per match |
| Content Depth | Minimum viable feature set |

**Out of Scope (for V1):**
- Campaign/story mode
- Ranked matchmaking
- Cosmetics/skins
- Spectator mode
- Replays

---

## 5. Art Style

- **Palette:** Mindustry-inspired color scheme (industrial, vibrant)
- **Sprites:** Pixel art, grid-based tiles
- **Resolution:** 16x16 or 32x32 tiles (TBD)
- **Units/Buildings:** Simplified silhouettes, clear visual distinction

---

## 6. Audio

### Aesthetic
Waterflame's "Vast" album vibes: industrial, electronic, atmospheric with moments of intensity.

### Content
- **OST:** 5-10 ambient/upbeat tracks
- **SFX:** Minimal (building placement, unit attack, core damage, invasion alert)
- **Dynamic Music:** TBD - does music change during invasion phase?

---

## 7. Technical Architecture

### Core Systems
1. **Map Generation** → Dynamically create play area with connection points
2. **Building System** → Place towers, factories, mines; handle placement rules
3. **Unit Spawning & Pathfinding** → Generate units from factories; navigate to enemy base
4. **Turret Targeting & Combat** → Auto-target incoming units; damage/destruction
5. **Resource Economy** → Track resources per player; display economy stats
6. **Game State & Timer** → Manage 15-min setup → invasion phase transition
7. **Core Health & Victory** → Detect core destruction; determine winner
8. **UI System** → Minimap, unit count, resources, timer, building menu

### Game Flow
```
Main Menu
    ↓
Game Start → MapGen → Setup Phase (15min) → Invasion Phase → Game Over
    ↓
Controllable Player Spaceship (for observation/fun)
```

---

## 8. MVP Design Decisions (LOCKED)

### Multiplayer
- **Networked play** over LAN/online (not local splitscreen)

### Unit & Building Roster
**Units (MVP):**
- 1x Ground Unit (fires projectiles, can be targeted)
- 1x Air Unit (flies over terrain, can be targeted)

**Buildings:**
- 1x Turret (fixed defense, auto-targets units)
- 2x Factory (1x ground unit factory, 1x air unit factory)
- 2x Mining Building (1x iron mine, 1x coal mine)

### Economy
- **Resources:** Iron + Coal only
- **Resource Flow:** Miners extract → stored in core → factories consume for unit production
- **No crafting chains** (v1 simplicity)

### Combat & Threats
- **Pure PVP** — no neutral enemies during setup phase
- After 15 min invasion: player units march toward enemy base through connection points

### Player Control
- **Player character:** Spaceship (controllable during match for camera/observation)
- Goal: Quick visual iteration with Cage video capture

### Testing
- **E2E tests from day 1** — GUT framework for Godot
- Test architecture: Unit → Integration → Gameplay tests
- All systems must be testable in isolation

---

## 9. Success Criteria

- [x] Core gameplay loop complete (build → defend → invade)
- [x] 15-min timer + phase transition working
- [x] Pathfinding & unit movement smooth
- [x] Turret targeting feels responsive
- [x] Map generation feels varied
- [x] Pixel art aesthetic consistent
- [x] Audio adds to atmosphere without overpowering gameplay
- [x] Single match mode fully playable

---

**Owner:** SonicCyclops  
**Status:** Design Phase  
**Last Updated:** 2026-03-19
