#!/bin/bash

# ==============================================================================
# TITRE: Installation de KVM, Virt-Manager, GNOME Boxes et SSH
# AUTEUR: Amaury Libert (Base) | Amélioré par l'IA
# LICENCE: GPLv2
# DESCRIPTION:
#   Installation automatisée de l'hyperviseur KVM, du gestionnaire de machines
#   virtuelles (Virt Manager, GNOME Boxes) et de SSH.
#   Compatible Debian 10/11, Ubuntu 20.04/22.04 et Linux Mint 20/21.
# ==============================================================================

# --- Configuration et Préparation ---

# Mode strict: Quitte en cas d'erreur (-e), variable non définie (-u), ou échec
# dans un pipe (-o pipefail).
set -euo pipefail

# Couleurs pour une sortie utilisateur claire
VERT='\033[0;32m'
ROUGE='\033[0;31m'
JAUNE='\033[0;33m'
CYAN='\033[0;36m'
FIN='\033[0m'

# Vérification des droits root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${ROUGE}ERREUR : Ce script doit être exécuté avec 'sudo' ou en tant que root.${FIN}"
    exit 1
fi

# Déterminer l'utilisateur réel (pour l'ajout aux groupes)
UTILISATEUR_REEL=${SUDO_USER:-$(whoami)}

echo -e "${CYAN}*** Début de l'installation de l'environnement KVM/QEMU et SSH ***${FIN}"
clear # Effacer l'écran après le message d'introduction

# --- Étape 1: Vérification des Prérequis ---

echo -e "${JAUNE}1. Vérification des prérequis de virtualisation (KVM)...${FIN}"

# Vérifier si le support de la virtualisation est activé dans le BIOS (Intel/AMD)
if grep -qE '(vmx|svm)' /proc/cpuinfo; then
    echo -e "${VERT}La virtualisation matérielle est activée (vt-x/AMD-V). Poursuite de l'installation.${FIN}"
else
    echo -e "${ROUGE}AVERTISSEMENT : La virtualisation matérielle (vt-x/AMD-V) ne semble PAS être activée dans le BIOS.${FIN}"
    echo "KVM pourrait ne pas fonctionner correctement ou du tout. Continuer (o/N) ?"
    read -r -p "Continuer ? (o/N) " REPONSE
    if [[ ! "$REPONSE" =~ ^([oO]|[oO][uU][iI])$ ]]; then
        echo -e "${ROUGE}Installation annulée par l'utilisateur.${FIN}"
        exit 1
    fi
fi

# --- Étape 2: Installation des Paquets ---

echo -e "${JAUNE}2. Rafraîchissement des dépôts et installation des paquets...${FIN}"
apt update

# Liste des paquets pour une meilleure lisibilité et maintenance
PAQUETS=(
    qemu
    qemu-kvm
    libvirt-daemon-system # Paquet plus standard que libvirt0 pour le daemon
    virt-manager
    python3-guestfs
    libguestfs-tools
    ovmf # Support UEFI
    # Outils SSH / Réseau
    ssh-askpass
    ssh-askpass-gnome
    openssh-server
    bridge-utils
    # Frontend GNOME
    gnome-boxes
)

# Utilisation de xargs pour gérer la liste
printf '%s\n' "${PAQUETS[@]}" | xargs apt install -y -o 'apt::install-recommends=true'

if [ $? -ne 0 ]; then
    echo -e "${ROUGE}ERREUR : L'installation des paquets a échoué. Abandon.${FIN}"
    exit 1
fi
echo -e "${VERT}Paquets installés avec succès.${FIN}"

# --- Étape 3: Configuration des Groupes Utilisateurs ---

echo -e "${JAUNE}3. Ajout de l'utilisateur ${UTILISATEUR_REEL} aux groupes KVM nécessaires...${FIN}"

# La bonne pratique est d'ajouter l'utilisateur aux groupes:
# - kvm (Accès direct à /dev/kvm)
# - libvirt (Accès au démon libvirt)
GROUPES_A_AJOUTER=("kvm" "libvirt")

# Itération sur les groupes pour l'ajout
for GROUPE in "${GROUPES_A_AJOUTER[@]}"; do
    if getent group "$GROUPE" >/dev/null; then
        echo "Ajout à $GROUPE..."
        # Utilisation de -aG pour ajouter l'utilisateur aux groupes sans écraser les existants
        usermod -aG "$GROUPE" "${UTILISATEUR_REEL}"
    else
        echo -e "${JAUNE}AVERTISSEMENT : Le groupe '$GROUPE' n'existe pas. Ignoré.${FIN}"
    fi
done

# Note: Les groupes 'libvirt-qemu' et 'libvirt-dnsmasq' sont généralement gérés
# par le système libvirt et ne nécessitent pas l'ajout de l'utilisateur de bureau.

echo -e "${VERT}Groupes configurés. (Nécessite une déconnexion/reconnexion).${FIN}"

# --- Étape 4: Nettoyage et Finalisation ---

echo -e "${JAUNE}4. Nettoyage et finalisation...${FIN}"
apt autoremove -y

echo -e "${VERT}*** Installation KVM/Virt-Manager/SSH terminée ! ***${FIN}"
echo ""
echo -e "N'oubliez pas de vous ${ROUGE}déconnecter et reconnecter${VERT} pour que les changements de groupes prennent effet et utiliser KVM.${FIN}"
