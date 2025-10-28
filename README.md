# virtualization `kvm-virtmanager.sh`

## Installation de l'hyperviseur KVM, Virt-Manager et GNOME Boxes

-----

### 🇫🇷 **Description du projet**

Ce script Bash automatise l'installation de l'hyperviseur **KVM (Kernel-based Virtual Machine)** et de ses outils de gestion graphique associés, transformant votre machine Linux en une plateforme de virtualisation complète et performante.

L'installation inclut :

  * **KVM :** L'hyperviseur natif et performant de Linux.
  * **Virt-Manager :** Un gestionnaire de machines virtuelles riche en fonctionnalités.
  * **GNOME Boxes :** Une interface plus simple et conviviale pour la virtualisation.

Ce script garantit également que l'utilisateur est ajouté aux groupes nécessaires (`libvirt`, `kvm`, etc.) pour un fonctionnement immédiat sans nécessiter de configuration manuelle des permissions.

**Large compatibilité :**
Le script est conçu pour fonctionner sur une variété de distributions populaires :

  * **Linux Mint** 20+ et 21.x
  * **Ubuntu** 20.04+ et 22.04.x
  * **Debian** 10 (Buster) et 11 (Bullseye)

### 🇬🇧 **Project Description**

This Bash script automates the installation of the **KVM (Kernel-based Virtual Machine)** hypervisor and its associated graphical management tools, turning your Linux machine into a powerful and complete virtualization platform.

The installation includes:

  * **KVM:** The native and high-performance Linux hypervisor.
  * **Virt-Manager:** A feature-rich virtual machine manager.
  * **GNOME Boxes:** A simpler, user-friendly interface for virtualization.

This script also ensures the user is added to the necessary groups (`libvirt`, `kvm`, etc.) for immediate functionality without requiring manual permission configuration.

**Broad Compatibility:**
The script is designed to work across a variety of popular distributions:

  * **Linux Mint** 20+ and 21.x
  * **Ubuntu** 20.04+ and 22.04.x
  * **Debian** 10 (Buster) and 11 (Bullseye)

-----

### 🛠️ **Installation et utilisation / Installation and Usage**

Pour installer KVM et ses interfaces de gestion, exécutez les commandes suivantes dans votre Terminal :

1.  **Rendre le script exécutable :**

    ```bash
    chmod +x kvm-virtmanager.sh
    ```

2.  **Lancer l'installation :**

    ```bash
    sudo ./kvm-virtmanager.sh
    ```

**IMPORTANT :** Après l'exécution du script, vous devez **redémarrer votre système** pour que les modifications de groupes utilisateurs prennent effet et pour que les services KVM/Libvirt soient complètement actifs.

-----

### 📺 **Démonstration**

Pour une démonstration de l'exécution du script et de la vérification de l'installation de KVM, Virt-Manager et GNOME Boxes :

| Vidéo | Chaîne | Lien |
| :--- | :--- | :--- |
| **Mon script KVM Virtmanager pour Mint, Ubuntu et Debian** | Blabla Linux | [Regarder la Démonstration](http://www.youtube.com/watch?v=MXVjQyoDmyw) |

-----

### 📝 **Licence**

Ce projet est sous licence GNU GPL (v2.0).
