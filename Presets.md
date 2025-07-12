# ODO Command Presets

This file defines all available preset commands for the ODO command-line tool, including their parameters, data types, and operational domains.

## System Configuration Commands

### configure-system
- **Domain**: macOS System (Global preferences)
- **Parameters**: None
- **Description**: Configures macOS system settings including Finder, energy, and UI preferences

### configure-shell
- **Domain**: macOS System (User shell)
- **Parameters**:
  - `username` (String, optional): Username to configure shell for
- **Description**: Sets default shell to bash for specified user and root

### configure-ssh-known-hosts
- **Domain**: User SSH (~/.ssh)
- **Parameters**: None
- **Description**: Adds GitHub SSH keys to known_hosts file

## Security & Access Commands

### disable-spctl
- **Domain**: macOS System (Security/Gatekeeper)
- **Parameters**: None
- **Description**: Disables Gatekeeper (allows apps from anywhere)

### disable-screen-lock
- **Domain**: macOS System (Security/Screen lock)
- **Parameters**:
  - `password` (String, required): User password for authentication
- **Description**: Disables screen lock functionality

### enable-passwordless-sudo
- **Domain**: macOS System (sudo configuration)
- **Parameters**:
  - `username` (String, required): Username to enable passwordless sudo for
  - `password` (String, required): User password for initial authentication
- **Description**: Enables passwordless sudo for specified user

### enable-auto-login
- **Domain**: macOS System (Login window)
- **Parameters**:
  - `username` (String, required): Username for auto-login
  - `password` (String, required): User password
- **Description**: Enables automatic login for specified user

### disable-protected-services
- **Domain**: macOS System (Launch services/daemons)
- **Parameters**: None
- **Prerequisites**: SIP must be disabled
- **Description**: Disables various macOS system services and daemons

## Development Tools Commands

### configure-xcode
- **Domain**: Xcode application
- **Parameters**: None
- **Description**: Configures Xcode application settings and iOS Simulator preferences

### install-xcode-command-line-tools
- **Domain**: Xcode/Developer tools
- **Parameters**: None
- **Description**: Installs the latest Xcode Command Line Tools

### install-cached-xcode-versions
- **Domain**: Xcode installation
- **Parameters**:
  - `xcode_cache_dir` (String, optional): Directory containing Xcode .xip files
  - `default_xcode_version` (String, optional): Default Xcode version to select
- **Description**: Installs Xcode versions from cached .xip files

### install-developer-certificates
- **Domain**: macOS System (Security/Certificates)
- **Parameters**: None
- **Description**: Downloads and installs Apple developer certificates to system keychain

## Package Management Commands

### install-homebrew
- **Domain**: Homebrew package management
- **Parameters**: None
- **Description**: Downloads and installs Homebrew package manager

### install-homebrew-formulae
- **Domain**: Homebrew package management
- **Parameters**:
  - `formulae` (Array[String], required): List of Homebrew formulae to install
- **Description**: Installs specified Homebrew formulae

### install-homebrew-casks
- **Domain**: Homebrew package management
- **Parameters**:
  - `casks` (Array[String], required): List of Homebrew casks to install
- **Description**: Installs specified Homebrew casks

### install-rosetta-2
- **Domain**: macOS System (Apple Silicon compatibility)
- **Parameters**: None
- **Description**: Installs Rosetta 2 for Intel app compatibility on Apple Silicon

## System Update Commands

### update-macos
- **Domain**: macOS System (Software updates)
- **Parameters**:
  - `username` (String, required): Username for system updates
  - `password` (String, required): User password for authentication
- **Description**: Installs macOS updates and configures Setup Assistant

### update-safari
- **Domain**: macOS System (Safari browser)
- **Parameters**: None
- **Description**: Installs Safari-only updates

## Maintenance Commands

### cleanup-spotlight-index
- **Domain**: macOS System (Spotlight/MDS)
- **Parameters**: None
- **Description**: Erases all MDS indexes and waits for rebuilding to complete

### wait-for-finder
- **Domain**: macOS System (Finder process)
- **Parameters**:
  - `timeout` (Int, optional): Timeout in seconds to wait for Finder (default: 30)
- **Description**: Waits for Finder process to start, with configurable timeout

## Parameter Types

### String
Single text value. Can be provided as command-line argument or environment variable.

### Array[String]
Multiple text values. Can be provided as space-separated list or multiple flags.

### Int
Numeric value for timeouts, counts, or other integer parameters.

### Bool
Boolean flag indicating true/false state.

## Domains

### macOS System
Commands that modify global macOS system settings, services, or configurations requiring admin privileges.

### User
Commands that modify user-specific settings and configurations in the user's home directory.

### Xcode
Commands specific to Xcode application, developer tools, and iOS/macOS development environment.

### Homebrew
Commands for managing Homebrew package manager and its packages/casks.

## Environment Variables

Many commands support environment variables as parameter sources:

- `USERNAME`: Default username for user-specific operations
- `PASSWORD`: User password for authentication
- `XCODE_CACHE_DIR`: Directory for cached Xcode installation files
- `DEFAULT_XCODE_VERSION`: Default Xcode version to install/select
- `BREW_CASKS`: Space-separated list of Homebrew casks
- `BREW_FORMULAE`: Space-separated list of Homebrew formulae
- `TIMEOUT`: Default timeout for waiting operations

## Command Categories

Commands are organized into logical categories for easier discovery and management:

1. **System Configuration**: Core macOS system setup and preferences
2. **Security & Access**: Authentication, authorization, and security settings
3. **Development Tools**: Xcode, developer certificates, and development environment
4. **Package Management**: Homebrew and package installation
5. **System Updates**: macOS and application updates
6. **Maintenance**: System maintenance and utility operations