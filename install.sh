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
ttf-nerd-fonts-symbols ttf-firacode ttf-jetbrains-mono-nerd \
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

# Configuración inicial de Hyperland
echo "Configurando Hyperland..."
mkdir -p ~/.config/hyperland
if [ ! -f ~/.config/hyperland/hyprland.conf ]; then
    cp /usr/share/hyperland/hyprland.conf ~/.config/hyperland/ || error_handler
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

# Configuración final
echo "Instalación y configuración completadas. Reinicia tu sistema para aplicar los cambios."
