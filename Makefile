SHELL := /bin/bash
.SHELLFLAGS = -e -c
.DEFAULT_GOAL := help
.ONESHELL:
.SILENT:
MAKEFLAGS += --no-print-directory

ifneq (,$(wildcard ./.env))
    include .env
    export
endif

# Paths
GODOT := $(shell which godot || which godot3-server || echo "godot")
GUT_DIR := addons/gut

##@ Development

.PHONY: setup
setup: ## Setup development environment
	@echo "Setting up Godot 2D game project..."
	mkdir -p src/systems src/scenes src/tests/{unit,integration,e2e}
	mkdir -p assets/{sprites,music,audio}
	@echo "✓ Project structure ready"
	@echo "Next: Install GUT framework in Godot editor"

.PHONY: build
build: ## Build game and assets
	@echo "Building game assets..."
	@echo "TODO: Compile shaders, process sprites, render music"

.PHONY: clean
clean: ## Clean build artifacts
	@echo "Cleaning build artifacts..."
	rm -rf .godot/
	rm -rf assets/**/exported/
	find . -name "*.import" -delete

.PHONY: test
test: test-unit ## Run all tests (alias: test-unit)

.PHONY: test-unit
test-unit: ## Run unit tests
	@echo "Running unit tests..."
	$(GODOT) -s $(GUT_DIR)/gut.gd -d user://results/unit src/tests/unit/ || true

.PHONY: test-integration
test-integration: ## Run integration tests
	@echo "Running integration tests..."
	$(GODOT) -s $(GUT_DIR)/gut.gd -d user://results/integration src/tests/integration/ || true

.PHONY: test-e2e
test-e2e: ## Run E2E tests
	@echo "Running E2E tests..."
	$(GODOT) -s $(GUT_DIR)/gut.gd -d user://results/e2e src/tests/e2e/ || true

.PHONY: test-all
test-all: test-unit test-integration test-e2e ## Run all test suites

.PHONY: test-watch
test-watch: ## Watch mode - auto-rerun tests on file changes
	@echo "Starting test watch mode..."
	@while true; do \
		find src -name "*.gd" -mmin -1 | grep -q . && $(MAKE) test-unit; \
		sleep 2; \
	done

.PHONY: test-coverage
test-coverage: ## Run tests with coverage report
	@echo "Running tests with coverage..."
	$(GODOT) -s $(GUT_DIR)/gut.gd --coverage src/tests/ || true

##@ Assets

.PHONY: music
music: ## Process LilyPond music files
	@echo "Processing music files..."
	@echo "TODO: lilypond → audio pipeline"

.PHONY: sprites
sprites: ## Process LibreSprite files
	@echo "Processing sprite files..."
	@echo "TODO: libresprite → spritesheet pipeline"

##@ Gameplay

.PHONY: run
run: ## Run the game in development mode
	@echo "Starting game..."
	$(GODOT) --path . &

.PHONY: run-server
run-server: ## Run headless server (for networked testing)
	@echo "Starting headless server..."
	$(GODOT) --path . --headless &

.PHONY: run-cage
run-cage: ## Run game in Cage kiosk mode (for video capture)
	@echo "Starting game in Cage window..."
	cage -- $(GODOT) --path . &

##@ Documentation

.PHONY: docs
docs: ## Open project documentation
	@echo "Opening GDD and TESTING docs..."
	@cat docs/GDD.md docs/TESTING.md | less

##@ Utilities

.PHONY: help
help: ## Displays help info
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
