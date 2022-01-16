#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
	#Update and Upgrade
	echo "Updating and Upgrading"
	#apt-get update && sudo apt-get upgrade -y

	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "@2022 ANZAKU PIUS\nPlease Select All to Install LAMP Stack:" 22 76 16)
	options=(1 "APACHE" off # any option can be set to default to "on"
	         2 "PHP" off
	         3 "Mysl Server" off
	         4 "Build Essentials" off
	         5 "Git" off )
		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in

			1)
			    	#Install Apache
				echo "Installing Apache..."
				sudo apt install apache2 -y
				;;
	            
	               2)
	                       #Install Mysql Server
    				echo "Installing Mysql Server..."
	 			sudo apt install mysql-server -y
	 			;;
			
			3)
				#Install PHP
        			echo "Installing PHP..."
				sudo apt install php libapache2-mod-php php-mcrypt php-mysql -y
	            
        			echo "Installing Phpmyadmin..."
				sudo apt install phpmyadmin -y

				echo "Cofiguring apache to run Phpmyadmin..."
				echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
				
				echo "Enabling module rewrite"
				sudo a2enmod rewrite
				echo "Restarting Apache Server"
				service apache2 restart
				;;
    		       4) 	   		     
				#Install Build Essentials
				echo "Installing Build Essentials..."
				sudo apt install -y build-essential
				;;
				
			5)
				#Install git
				echo "Installing Git, please congiure git later..."
				sudo apt install git -y
				;;
			
	    esac
	done
fi
