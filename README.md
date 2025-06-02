# Dotfiles Configuration

A comprehensive collection of configuration files for a modern Linux desktop environment featuring Waybar, Rofi, and various system utilities.

## 📁 Structure Overview

```
dotfiles/
├── waybar/          # Status bar configuration and scripts
├── rofi/            # Application launcher and menus
├── wlogout/         # Logout/power management interface
└── scripts/         # Utility scripts and automation
```

## 🖥️ Waybar Configuration

### Main Components
- **Status Bar**: Customizable status bar with multiple layout configurations
- **Modules**: CPU info, GPU info, battery, network, audio, clock, workspaces
- **Scripts**: Dynamic system monitoring and control utilities

### Key Features
- Multiple bar layouts (top/bottom/left/right positioning)
- CPU temperature and utilization monitoring with emoji indicators
- GPU information display
- Battery status with power management integration
- Network and audio controls
- Custom theme and wallpaper switching capabilities

### Scripts
- [`globalcontrol.sh`](waybar/scripts/globalcontrol.sh): Central control script for themes and system management
- [`cpuinfo.sh`](waybar/scripts/cpuinfo.sh): Real-time CPU monitoring with temperature and usage stats
- [`logoutlaunch.sh`](waybar/scripts/logoutlaunch.sh): Logout interface launcher with dynamic styling

## 🚀 Rofi Configuration

### Applets
Collection of interactive system utilities accessible via Rofi:

#### Power Management
- **Power Menu**: Multiple styles for system power controls (shutdown, reboot, suspend, hibernate, logout, lock)
- **Battery**: Battery status and power management settings
- **Brightness**: Display brightness controls

#### Applications
- **Apps**: Quick access to favorite applications
- **App as Root**: Launch applications with elevated privileges
- **Quick Links**: Fast access to web services (Google, Gmail, YouTube, GitHub, Reddit, Twitter)

#### Media & System
- **Volume**: Audio control for speakers and microphone
- **MPD**: Music player daemon controls with playback management

### Power Menu Variants
Multiple power menu styles available:
- **Type 1-6**: Different visual layouts and confirmation dialogs
- **Features**: Systemctl integration, music pause on suspend, confirmation prompts

## 🔐 WLogout Integration

Logout interface with customizable styling:
- Dynamic button styling based on theme colors
- Scalable UI elements based on monitor resolution
- Integration with power management commands

## ⚙️ System Integration

### Theme Management
- Automatic theme detection and switching
- Wallpaper management with brightness detection
- Color scheme synchronization across applications

### Configuration Directories
```bash
CONFIG_DIR="$HOME/.config"      # Main configuration directory
CACHE_DIR="$HOME/.cache"        # Cache directory for themes and thumbnails
THEME_DIR="$HOME/.config/themes" # Theme directory
```

### Dependencies
- **Core**: Waybar, Rofi, WLogout
- **System**: systemctl, amixer, light, sensors
- **Optional**: mpc, betterlockscreen, pavucontrol
- **Tools**: jq, awk, sed, grep

## 🎨 Theming

### Theme Management
- Automatic theme detection from system configuration
- Wallpaper-based color scheme detection
- Dynamic CSS generation for consistent styling
- Font and icon theme synchronization

### Customization
- Modular configuration allowing easy component swapping
- Color scheme adaptation based on wallpaper brightness
- Scalable UI elements for different screen resolutions

## 📋 Usage Examples

### Launching Rofi Applets
```bash
# Power menu
rofi/applets/bin/powermenu.sh

# Volume control
rofi/applets/bin/volume.sh

# Brightness adjustment
rofi/applets/bin/brightness.sh
```

### Waybar Script Integration
```bash
# Get CPU information
waybar/scripts/cpuinfo.sh

# Launch logout interface
waybar/scripts/logoutlaunch.sh

# Theme control
waybar/scripts/globalcontrol.sh --verbose
```

## 🔧 Installation

1. Clone the repository to your home directory
2. Ensure all dependencies are installed
3. Copy or symlink configuration files to appropriate directories:
   - `~/.config/waybar/`
   - `~/.config/rofi/`
   - `~/.config/wlogout/`
4. Make scripts executable: `chmod +x waybar/scripts/* rofi/applets/bin/*`
5. Configure paths in your shell profile if needed

## 📝 Configuration Notes

- Optimized for modern Wayland compositors
- Scripts include fallback configurations for standalone usage
- Power management features require appropriate systemd permissions
- Audio controls use ALSA mixer (amixer) by default
- Theme detection works with standard Linux theming systems

## 🎛️ Customization

### Waybar Modules
Easily customize which modules appear in your status bar by editing the configuration files. Each module is self-contained and can be enabled/disabled independently.

### Rofi Themes
Multiple built-in themes available for different visual preferences. Switch between them by modifying the theme variable in the applet scripts.

### Color Schemes
Automatic color detection from wallpapers with fallback to manual color scheme definitions.

This configuration provides a cohesive desktop environment with powerful customization options and seamless integration between components, designed to work independently without external theme management dependencies.
