#!/bin/bash
#
# Autheur:
#   Amaury Libert <amaury-libert@hotmail.com> de Blabla Linux <https://blablalinux.be>
#
# Description:
#   Script d'installations de l'hyperviseur KVM, du gestionnaire de machines virtuelles Virt Manager, de Gnome Boxes et du protocole de communication sécurisé SSH pour Linux Mint 20 (Cinnamon/Mate/xfce).
#
# Préambule Légal:
# 	Ce script est un logiciel libre.
# 	Vous pouvez le redistribuer et / ou le modifier selon les termes de la licence publique générale GNU telle que publiée par la Free Software Foundation; version 3.
#
# 	Ce script est distribué dans l'espoir qu'il sera utile, mais SANS AUCUNE GARANTIE; sans même la garantie implicite de QUALITÉ MARCHANDE ou d'ADÉQUATION À UN USAGE PARTICULIER.
# 	Voir la licence publique générale GNU pour plus de détails.
#
# 	Licence publique générale GNU : <https://www.gnu.org/licenses/gpl-3.0.txt>
#
echo "Effacement écran..."
clear
#
echo "Rafraîchissement dépôts..."
apt update
#
echo "Installations de qemu, qemu-kvm, libvirt0, virt-manager, libguestfs-tools, ssh-askpass, bridge-utils, gnome-boxes..."
apt install -y -o 'apt::install-recommends=true' \
  qemu qemu-kvm libvirt0 virt-manager libguestfs-tools ssh-askpass bridge-utils gnome-boxes ssh-askpass-gnome openssh-server
#
echo "KVM ajouts groupes..."
usermod -G kvm -a $SUDO_USER
usermod -G libvirt -a $SUDO_USER
usermod -G libvirt-qemu -a $SUDO_USER
usermod -G libvirt-dnsmasq -a $SUDO_USER
#
echo "Nettoyage..."
apt autoremove
