if [ ! -f .initialized ]; then                                                                                                                                                                                    
    echo "Initializing container"                                                                                                                                                                                 
    # run initializing commands                                                                                                                                                                                   
    touch .initialized

    #ativa todos os sites
    cd /etc/apache2/sites-available/  
    a2ensite *
	service apache2 reload                                                                                                                                                                                                
fi                                                                                                                                                                                                                

exec "$@"