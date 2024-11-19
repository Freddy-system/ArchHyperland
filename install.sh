#!/bin/bash

# Función para manejar errores
error_handler() {
    echo "Error en el paso anterior. Verifica los mensajes anteriores."
    exit 1
}

# Actualización del sistema
echo "Actualizando el sistema..."
sudo pacman -Syu --noconfirm || error_handler

# Instalación de Wayland y dependencias
echo "Instalando Wayland y dependencias..."
sudo pacman -S --noconfirm wayland wayland-utils xorg-xwayland mesa vulkan-intel \
base-devel git pipewire pipewire-alsa pipewire-pulse wireplumber \
brightnessctl tlp swaybg mako alacritty rofi ranger nemo \
wl-clipboard qt5-wayland qt6-wayland gtk3 gtk4 || error_handler

# Instalación de yay
if ! command -v yay &> /dev/null; then
    echo "Clonando y compilando yay desde AUR..."
    git clone https://aur.archlinux.org/yay.git || error_handler
    cd yay
    makepkg -si --noconfirm || error_handler
    cd ..
    rm -rf yay
else
    echo "yay ya está instalado."
fi

# Instalación de Hyperland y Eww
echo "Instalando Hyperland y Eww..."
yay -S --noconfirm hyperland eww || error_handler

# Instalación de wget o curl si no están presentes
if ! command -v wget &> /dev/null && ! command -v curl &> /dev/null; then
    echo "Instalando wget y curl..."
    sudo pacman -S --noconfirm wget curl || error_handler
fi

# Configuración inicial de Hyperland
echo "Configurando Hyperland..."
mkdir -p ~/.config/hypr
if [ -f /usr/share/hyprland/hyprland.conf ]; then
    cp /usr/share/hyprland/hyprland.conf ~/.config/hypr/ || error_handler
else
    echo "No se encontró el archivo predeterminado. Descargando ejemplo..."
    if command -v wget &> /dev/null; then
        wget -O ~/.config/hypr/hyprland.conf https://raw.githubusercontent.com/hyprwm/Hyprland/main/example/hyprland.conf || error_handler
    elif command -v curl &> /dev/null; then
        curl -L -o ~/.config/hypr/hyprland.conf https://raw.githubusercontent.com/hyprwm/Hyprland/main/example/hyprland.conf || error_handler
    else
        echo "Error: No se pudo encontrar wget o curl para descargar el archivo."
        error_handler
    fi
fi

# Instalación del navegador Brave
echo "Instalando navegador Brave..."
yay -S --noconfirm brave-bin || error_handler

# Instalación de otros paquetes útiles
echo "Instalando paquetes útiles..."
sudo pacman -S --noconfirm iwd libreoffice-fresh gimp vlc || error_handler

# Configuración del firewall
echo "Configurando firewall..."
sudo pacman -S --noconfirm ufw || error_handler
sudo systemctl enable ufw || error_handler
sudo systemctl start ufw || error_handler

# Limpieza de paquetes antiguos
echo "Limpiando paquetes antiguos..."
if ! command -v paccache &> /dev/null; then
    echo "Instalando pacman-contrib (para paccache)..."
    sudo pacman -S --noconfirm pacman-contrib || error_handler
fi
sudo paccache -r || error_handler

# Instalación de temas e iconos
echo "Instalando temas e iconos..."
yay -S --noconfirm whitesur-gtk-theme-git nordzy-icons || error_handler
sudo pacman -S --noconfirm lxappearance || error_handler

# Instalación de un gestor de inicio de sesión ligero (ly)
echo "Instalando gestor de inicio de sesión ly..."
yay -S --noconfirm ly || error_handler
sudo systemctl enable ly.service || error_handler
sudo systemctl disable gdm.service || error_handler

# Instalación de bloqueo de pantalla
echo "Instalando swaylock..."
yay -S --noconfirm swaylock || error_handler

# Configuración adicional para Alacritty
echo "Verificando configuración de Alacritty..."
mkdir -p ~/.config/alacritty
if [ ! -f ~/.config/alacritty/alacritty.yml ]; then
    cat << EOF > ~/.config/alacritty/alacritty.yml
# Configuración básica de Alacritty
window:
  opacity: 0.9
  dynamic_padding: true
font:
  size: 12
EOF
fi

# Configuración final
echo "Instalación y configuración completadas. Reinicia tu sistema para aplicar los cambios."
