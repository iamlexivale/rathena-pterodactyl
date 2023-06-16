#!/bin/sh
echo "rAthena Development Team presents"
echo "           ___   __  __"
echo "     _____/   | / /_/ /_  ___  ____  ____ _"
echo "    / ___/ /| |/ __/ __ \/ _ \/ __ \/ __  /"
echo "   / /  / ___ / /_/ / / /  __/ / / / /_/ /"
echo "  /_/  /_/  |_\__/_/ /_/\___/_/ /_/\__,_/"
echo ""
echo "http://rathena.org/board/"
echo ""
echo "Initalizing Docker container..."

DATE=$(date '+%Y-%m-%d %H:%M:%S')

setup_init () {
    install_rathena
    setup_mysql_config
    setup_config
}

install_rathena () {
    git clone https://github.com/rathena/rathena.git /home/container
    cd /home/container
    ./configure --enable-packetver=${PACKETVER}
    make clean
    make server
    chmod a+x login-server && chmod a+x char-server && chmod a+x map-server 
}

setup_mysql_config () {
    echo "###### MySQL setup ######"
    if [ -z "${MYSQL_HOST}" ]; then echo "Missing MYSQL_HOST environment variable. Unable to continue."; exit 1; fi
    if [ -z "${MYSQL_DB}" ]; then echo "Missing MYSQL_DB environment variable. Unable to continue."; exit 1; fi
    if [ -z "${MYSQL_USER}" ]; then echo "Missing MYSQL_USER environment variable. Unable to continue."; exit 1; fi
    if [ -z "${MYSQL_PWD}" ]; then echo "Missing MYSQL_PWD environment variable. Unable to continue."; exit 1; fi

    echo "Setting up MySQL on Login Server..."
    echo -e "use_sql_db: yes\n\n" >> /conf/import/inter_conf.txt
    echo -e "login_server_ip: ${MYSQL_HOST}" >> /conf/import/inter_conf.txt
    echo -e "login_server_db: ${MYSQL_DB}" >> /conf/import/inter_conf.txt
    echo -e "login_server_id: ${MYSQL_USER}" >> /conf/import/inter_conf.txt
    echo -e "login_server_pw: ${MYSQL_PWD}\n" >> /conf/import/inter_conf.txt

    echo "Setting up MySQL on Map Server..."
    echo -e "map_server_ip: ${MYSQL_HOST}" >> /conf/import/inter_conf.txt
    echo -e "map_server_db: ${MYSQL_DB}" >> /conf/import/inter_conf.txt
    echo -e "map_server_id: ${MYSQL_USER}" >> /conf/import/inter_conf.txt
    echo -e "map_server_pw: ${MYSQL_PWD}\n" >> /conf/import/inter_conf.txt

    echo "Setting up MySQL on Char Server..."
    echo -e "char_server_ip: ${MYSQL_HOST}" >> /conf/import/inter_conf.txt
    echo -e "char_server_db: ${MYSQL_DB}" >> /conf/import/inter_conf.txt
    echo -e "char_server_id: ${MYSQL_USER}" >> /conf/import/inter_conf.txt
    echo -e "char_server_pw: ${MYSQL_PWD}\n" >> /conf/import/inter_conf.txt

    echo "Setting up MySQL on IP ban..."
    echo -e "ipban_db_ip: ${MYSQL_HOST}" >> /conf/import/inter_conf.txt
    echo -e "ipban_db_db: ${MYSQL_DB}" >> /conf/import/inter_conf.txt
    echo -e "ipban_db_id: ${MYSQL_USER}" >> /conf/import/inter_conf.txt
    echo -e "ipban_db_pw: ${MYSQL_PWD}\n" >> /conf/import/inter_conf.txt

    echo "Setting up MySQL on log..."
    echo -e "log_db_ip: ${MYSQL_HOST}" >> /conf/import/inter_conf.txt
    echo -e "log_db_db: ${MYSQL_DB}" >> /conf/import/inter_conf.txt
    echo -e "log_db_id: ${MYSQL_USER}" >> /conf/import/inter_conf.txt
    echo -e "log_db_pw: ${MYSQL_PWD}\n" >> /conf/import/inter_conf.txt

    echo "Importing database..."
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/item_db.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/item_db2.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/item_db2_re.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/item_db_equip.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/item_db_etc.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/item_db_re.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/item_db_re_equip.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/item_db_re_etc.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/item_db_re_usable.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/item_db_usable.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/logs.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/main.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/mob_db.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/mob_db2.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/mob_db2_re.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/mob_db_re.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/mob_skill_db.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/mob_skill_db2.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/mob_skill_db2_re.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/mob_skill_db_re.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/roulette_default_data.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} < /sql-files/web.sql
    mysql -u${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} -D${MYSQL_DB} -e "UPDATE login SET userid = \"${SET_INTERSRV_USERID}\", user_pass = \"${SET_INTERSRV_PASSWD}\" WHERE account_id = 1;"
}

setup_config () {
    echo "Create account server..."
    if ! [ -z "${SET_INTERSRV_USERID}" ]; then 
        echo -e "userid: ${SET_INTERSRV_USERID}" >> /conf/import/map_conf.txt
        echo -e "userid: ${SET_INTERSRV_USERID}" >> /conf/import/char_conf.txt
    fi
    if ! [ -z "${SET_INTERSRV_PASSWD}" ]; then 
        echo -e "passwd: ${SET_INTERSRV_PASSWD}" >> /conf/import/map_conf.txt
        echo -e "passwd: ${SET_INTERSRV_PASSWD}" >> /conf/import/char_conf.txt
    fi
    
    echo "Configuration server..."
    if ! [ -z "${SET_MOTD}" ]; then echo -e "${SET_MOTD}" > /conf/motd.txt; fi
    if ! [ -z "${SET_CHAR_TO_LOGIN_IP}" ]; then echo -e "login_ip: ${SET_CHAR_TO_LOGIN_IP}" >> /conf/import/char_conf.txt; fi
    if ! [ -z "${SET_CHAR_PUBLIC_IP}" ]; then echo -e "char_ip: ${SET_CHAR_PUBLIC_IP}" >> /conf/import/char_conf.txt; fi
    if ! [ -z "${SET_MAP_TO_CHAR_IP}" ]; then echo -e "char_ip: ${SET_MAP_TO_CHAR_IP}" >> /conf/import/map_conf.txt; fi
    if ! [ -z "${SET_MAP_PUBLIC_IP}" ]; then echo -e "map_ip: ${SET_MAP_PUBLIC_IP}" >> /conf/import/map_conf.txt; fi
    if ! [ -z "${ADD_SUBNET_MAP}" ]; then echo -e "subnet: ${ADD_SUBNET_MAP}" >> /conf/subnet_athena.conf; fi
    if ! [ -z "${SET_SERVER_NAME}" ]; then echo -e "server_name: ${SET_SERVER_NAME}" >> /conf/import/char_conf.txt; fi
    if ! [ -z "${SET_SERVER_NAME}" ]; then echo -e "wisp_server_name: ${SET_SERVER_NAME}" >> /conf/import/char_conf.txt; fi
    if ! [ -z "${SET_PINCODE_ENABLED}" ]; then echo -e "pincode_enabled: ${SET_PINCODE_ENABLED}" >> /conf/import/char_conf.txt; fi
}

exec "$@"