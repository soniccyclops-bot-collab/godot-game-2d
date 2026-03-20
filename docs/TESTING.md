# Testing Architecture

## Philosophy
- **Test-Driven:** Architecture designed for testability from day 1
- **E2E First:** Start with full gameplay scenarios, work toward unit tests
- **GUT Framework:** Godot Unit Test framework for all test coverage
- **No Untested Systems:** Every feature must have passing tests before merge

## Test Pyramid

```
       /\
      /E2E\       - Full game scenarios
     /------\     - Map generation → unit spawning → combat → victory
    / System\    - Multi-system integration
   /----------\  - Unit spawning + turret combat
  / Integration\ - Core economy + factory production
 /-----------\  - Single system in isolation
/ Unit Tests \
```

## Test Organization

```
tests/
├── unit/                    # Single system tests
│   ├── test_map_generator.gd
│   ├── test_resource_economy.gd
│   ├── test_unit_spawner.gd
│   ├── test_pathfinding.gd
│   ├── test_turret_targeting.gd
│   └── test_game_timer.gd
│
├── integration/             # Multi-system tests
│   ├── test_factory_production.gd      # Economy + Factory
│   ├── test_unit_movement_combat.gd    # Pathfinding + Turret
│   └── test_phase_transition.gd        # Timer + Invasion
│
└── e2e/                     # Full gameplay scenarios
    ├── test_complete_game.gd           # Setup → Invasion → Victory
    ├── test_player_vs_ai.gd            # Human player vs simple AI
    └── test_networked_match.gd         # Two networked players
```

## Test Patterns

### Unit Test Example
```gdscript
extends GutTest

func test_mine_produces_resource():
    var mine = MiningBuilding.new()
    mine.resource_type = "iron"
    mine.production_rate = 10  # per second
    
    var initial = mine.stored_resource
    mine._process(1.0)  # 1 second passes
    
    assert_eq(mine.stored_resource, initial + 10)

func test_factory_requires_resources():
    var factory = UnitFactory.new()
    factory.resources = {"iron": 0, "coal": 0}
    
    assert_false(factory.can_produce_unit())
    factory.resources["iron"] = 100
    factory.resources["coal"] = 50
    assert_true(factory.can_produce_unit())
```

### Integration Test Example
```gdscript
extends GutTest

func test_ground_unit_spawns_and_fires():
    var game = GameState.new()
    game.setup()
    
    # Setup: Ground factory with resources
    var factory = game.player1.factories["ground"]
    factory.enqueue_unit()
    
    # Process: Time passes, unit spawns
    game._process(factory.build_time)
    var unit = factory.last_spawned_unit
    
    # Assert: Unit exists and can target turrets
    assert_not_null(unit)
    var turret = game.player2.turrets[0]
    assert_true(unit.can_target(turret))
```

### E2E Test Example
```gdscript
extends GutTest

func test_complete_pvp_match():
    var game = PVPMatch.new()
    game.start_match()
    
    # Phase 1: Setup (0-15 min)
    assert_eq(game.current_phase, "setup")
    assert_eq(game.timer, 900)  # 15 minutes
    
    # Simulate both players building
    game.player1.place_building("iron_mine", Vector2(10, 10))
    game.player2.place_building("air_factory", Vector2(100, 100))
    
    # Fast forward to invasion
    game._process_until_time(901)  # Past 15 minutes
    
    # Phase 2: Invasion (15+ min)
    assert_eq(game.current_phase, "invasion")
    assert_not_null(game.connection_point)
    
    # Simulate units marching and combat
    while game.is_running():
        game._process(0.016)  # 60 FPS frame
        
        if game.player1.core.health <= 0:
            assert_eq(game.winner, "player2")
            break
        if game.player2.core.health <= 0:
            assert_eq(game.winner, "player1")
            break
```

## Test Coverage Goals

| System | Coverage |
|--------|----------|
| Map Generation | 90%+ (all terrain types, connection points) |
| Resource Economy | 95%+ (production, consumption, limits) |
| Unit Spawning | 90%+ (queue, timing, resource costs) |
| Pathfinding | 85%+ (simple A*, obstacle avoidance) |
| Combat | 95%+ (targeting, damage, destruction) |
| Game Timer | 100% (phase transitions, exact timing) |
| Networking | 70%+ (basic RPC, state sync) |

## Test Execution Workflow

```bash
# Run all tests
make test

# Run by category
make test-unit
make test-integration
make test-e2e

# Run with coverage report
make test-coverage

# Watch mode (auto-rerun on file changes)
make test-watch
```

## Continuous Integration

- Tests run on every commit
- All tests must pass before merge
- Coverage reports generated automatically
- E2E tests run on networked build (simulated or real)

## Testability Constraints

**Avoid:**
- Direct `Input` calls (mock instead)
- Time-dependent logic (inject delta time)
- Hard scene dependencies (use factories/dependency injection)
- Random without seeding (seed RNG for reproducibility)

**Embrace:**
- Pure functions where possible
- Dependency injection for external systems
- Event signals for decoupling
- Mocked network calls for offline testing

---

**Owner:** SonicCyclops  
**Status:** Architecture Phase  
**Last Updated:** 2026-03-19
