# GUT Framework Installation

## Why GUT?

GUT (Godot Unit Test) is the standard testing framework for Godot. It provides:
- Unit test execution in the Godot editor
- CLI test running for CI/CD
- Coverage reports
- Easy assertion syntax

## Installation Steps

1. **Download GUT addon**:
   ```bash
   git clone https://github.com/bitwes/Gut.git addons/gut
   ```

2. **Enable in Godot**:
   - Open project in Godot editor
   - Navigate to Project → Project Settings → Autoload
   - Add `addons/gut/gut.gd` as "Gut" autoload

3. **Verify installation**:
   ```bash
   # Run a single test file
   godot -s addons/gut/gut.gd -d user://results src/tests/unit/test_resource_economy.gd
   ```

## Running Tests

All tests are managed via `make`:

```bash
make test-unit          # Unit tests only
make test-integration   # Integration tests only
make test-e2e          # E2E tests only
make test-all          # All test suites
make test-watch        # Auto-rerun on file changes
make test-coverage     # With coverage report
```

## Test File Conventions

- **Unit tests**: `src/tests/unit/test_*.gd`
- **Integration tests**: `src/tests/integration/test_*.gd`
- **E2E tests**: `src/tests/e2e/test_*.gd`

Each test file must:
1. Extend `GutTest`
2. Define `before_each()` for setup
3. Define `after_each()` for cleanup
4. Use assertions: `assert_eq()`, `assert_true()`, `assert_false()`, etc.

---

**Next**: Clone GUT and enable in Godot editor.
