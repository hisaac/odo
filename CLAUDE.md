# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Swift command-line tool called "odo" built using Swift Package Manager and the ArgumentParser library. The project is in its initial stages with basic structure in place.

## Commands

### Building and Running

- `swift build` - Build the project
- `swift run` - Build and run the executable
- `swift run odo` - Run the specific target

### Package Management

- `swift package resolve` - Resolve package dependencies
- `swift package update` - Update dependencies to latest versions

### Testing

- `swift test` - Run tests (when test targets are added)

## Code Style

- Use tabs for indentation (not spaces)

## Best Practices

- Prefer system APIs over shelling out to binaries when possible
