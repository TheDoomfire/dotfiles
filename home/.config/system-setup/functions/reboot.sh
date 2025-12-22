!/bin/bash

prompt_reboot() {
    read -t 30 -p $'\n⚠️ Reboot now? (y/N) ' response || response="n"
    [[ "${response,,}" =~ ^(y|yes)$ ]] || { 
        echo "Reboot skipped."
        return 1
    }
    echo "Rebooting system..."
    sudo reboot
}
