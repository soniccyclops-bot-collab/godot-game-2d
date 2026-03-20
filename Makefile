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

##@ Development

.PHONY: setup
setup: ## Setup development environment
	@echo "Setting up Godot 2D game project..."
	# TODO: Install Godot, LilyPond, LibreSprite

.PHONY: build
build: ## Build game and assets
	@echo "Building game assets..."
	# TODO: Compile shaders, process sprites, render music

.PHONY: clean
clean: ## Clean build artifacts
	@echo "Cleaning build artifacts..."
	rm -rf .godot/
	rm -rf assets/**/exported/

.PHONY: test
test: ## Run tests
	@echo "Running tests..."
	# TODO: Run Godot unit tests

##@ Assets

.PHONY: music
music: ## Process LilyPond music files
	@echo "Processing music files..."
	# TODO: lilypond → audio pipeline

.PHONY: sprites
sprites: ## Process LibreSprite files
	@echo "Processing sprite files..."
	# TODO: libresprite → spritesheet pipeline

##@ Development

.PHONY: run
run: ## Run the game in development mode
	@echo "Starting game..."
	# TODO: Launch Godot project

##@ Utilities

.PHONY: help
help: ## Displays help info
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)