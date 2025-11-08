#!/bin/bash

# Script to set up GTK themes, icons, and cursors for niri

set -e  # Exit on error

# Create GTK config directories
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/gtk-4.0

# Extract theme and icon archives
tar -xf ~/.local/share/themes/Tokyonight-BL-MB-Dark.tar.xz -C ~/.local/share/themes/
tar -xf ~/.local/share/icons/Future-cyan-cursors.tar.gz -C ~/.local/share/icons/
tar -xf ~/.local/share/icons/Newaita-reborn-dracula-dark.tar.xz -C ~/.local/share/icons/

# Create symlinks for GTK 3
ln -s ~/.local/share/themes/Tokyonight-BL-MB-Dark/gtk-3.0/gtk.css ~/.config/gtk-3.0/gtk.css
ln -s ~/.local/share/themes/Tokyonight-BL-MB-Dark/gtk-3.0/gtk-dark.css ~/.config/gtk-3.0/gtk-dark.css

# Create symlinks for GTK 4
ln -s ~/.local/share/themes/Tokyonight-BL-MB-Dark/gtk-4.0/gtk.css ~/.config/gtk-4.0/gtk.css
ln -s ~/.local/share/themes/Tokyonight-BL-MB-Dark/gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/gtk-dark.css

# Create GTK 3 settings.ini
cat > ~/.config/gtk-3.0/settings.ini << 'EOF'
[Settings]
gtk-theme-name=Tokyonight-BL-MB-Dark
gtk-icon-theme-name=Newaita-reborn-dracula-dark
gtk-cursor-theme-name=Future-cyan-cursors
gtk-application-prefer-dark-theme=1
EOF

# Create GTK 4 settings.ini
cat > ~/.config/gtk-4.0/settings.ini << 'EOF'
[Settings]
gtk-theme-name=Tokyonight-BL-MB-Dark
gtk-icon-theme-name=Newaita-reborn-dracula-dark
gtk-cursor-theme-name=Future-cyan-cursors
gtk-application-prefer-dark-theme=1
EOF

echo "Theming applied"
