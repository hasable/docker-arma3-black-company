#!/bin/bash
set -e
/opt/confd/bin/confd -onetime -backend env

# Update AdminToolKit configuration...
if [ ! -z "${ATK_CONFIG_ADMIN_LIST}" ]; then 
	BUILD_ATK_CFG="true"
	echo "Admins : ${ATK_CONFIG_ADMIN_LIST}"
	sed -i "s#^\(.*AdminList.*{\).*\(}\)#\1 \"${ATK_CONFIG_ADMIN_LIST//,/\", \"}\" \2#"  /home/steamu/sources/\@AdminToolkitServer/addons/admintoolkit_servercfg/config.cpp
fi

if [ ! -z "${ATK_CONFIG_MODERATOR_LIST}" ]; then 
	BUILD_ATK_CFG="true"
	echo "Moderators : ${ATK_CONFIG_MODERATOR_LIST}"
	sed -i "s#^\(.*ModeratorList.*{\).*\(}\)#\1 \"${ATK_CONFIG_MODERATOR_LIST//,/\", \"}\" \2#"  /home/steamu/sources/\@AdminToolkitServer/addons/admintoolkit_servercfg/config.cpp
fi

if [ ! -z "${BUILD_ATK_CFG}" ]; then 
	echo "Rebuilding AdminToolkit server configuration..."
	pushd /home/steamu/sources/\@AdminToolkitServer/addons/
	makepbo -N admintoolkit_servercfg
	mv -f admintoolkit_servercfg.pbo /opt/arma3/\@AdminToolkitServer/addons/admintoolkit_servercfg.pbo
	popd
fi

# Update ExileServer configuration...
echo "Rebuilding Exile server configuration..."

# calcul du decalage UTC
UTC=$(( ${DECALAGE} + $(date -d @0 +%-H) * 3600 + $(date -d @0 +%-M) * 60 ))

# calcul debut de la session de jeu
startp=$(( ( ( $(date +%s ) + ${EXILE_CONFIG_RESTART_START} + ${UTC} ) / ${EXILE_CONFIG_RESTART_CYCLE})*${EXILE_CONFIG_RESTART_CYCLE} - ${EXILE_CONFIG_RESTART_START} - ${UTC} ))
echo "Started at $(date -d @$startp +%H:%M )"
# et calcul de fin
endp=$(( ${startp} + ${EXILE_CONFIG_RESTART_CYCLE} ))
echo "Should end at $(date -d @$endp +%H:%M )"
current=$(date +%s )

remain=$(( ${endp} - ${current} ))
if [ "${remain}" -lt "${EXILE_CONFIG_RESTART_GRACE_TIME}" ]; then
        remain=$(( ${remain} + ${EXILE_CONFIG_RESTART_CYCLE} ))
fi
echo "Remaining time $(date -u -d @$remain '+%H:%M')"

sed -i "s#^\(\s*restartTimer\[\] \s*=\s\).*\(;\s*$\)#\1$(date -u -d @$remain '+{%-H, %-M}')\2#"  /home/steamu/sources/\@ExileServer/addons/exile_server_config/config.cpp

if [ ! -z "${EXILE_CONFIG_PASSWORD_COMMAND}" ]; then 
	sed -i "s#^\(\s*serverPassword\s*=\s*\"\).*\(\".*$\)#\1${EXILE_CONFIG_PASSWORD_COMMAND}\2#"  /home/steamu/sources/\@ExileServer/addons/exile_server_config/config.cpp
fi

pushd /home/steamu/sources/\@ExileServer/addons/		
makepbo -N exile_server_config
mv -f exile_server_config.pbo /opt/arma3/\@ExileServer/addons/exile_server_config.pbo
popd

# Update missions ...
# Mise à jour du timer dans la status bar Exad
pushd /home/steamu/sources/mpmissions
for mission in *; do 
	if [ -d ${mission}/ExAdClient ]; then
		sed -i "s#^\(\s*ExAd_SB_Timer\s*=\).*\(;.*$\)#\1 ${remain}\2#"  ${mission}/ExAdClient/StatsBar/customize.sqf
	fi
	makepbo -N ${mission} && mv -f ${mission}.pbo /opt/arma3/mpmissions/
done
popd


# as a backup, because sometime Exile fails to stop, add a timer...
remain=$(( ${remain} + ${EXILE_CONFIG_RESTART_GRACE_TIME} ))
( echo "Server will be hard stopped in ${remain}" \
       && sleep ${remain} \
       && kill -9 $$ \
) &

if [ ! -z "${DEVELOPMENT}" ]; then 
	pushd ${DEVELOPMENT}
	for mod in @*; do
		echo "Rebuilding ${mod}..."
		pushd ${mod}/addons/
		for dir in *; do
			if [ -d ${dir} ]; then 
				makepbo -N ${dir}
				mv -f ${dir}.pbo /opt/arma3/${mod}/addons/${dir}.pbo
				echo " - added /opt/arma3/${mod}/addons/${dir}.pbo"
			fi			
		done
		popd
	done
	
	if [ -d mpmissions ]; then 
		pushd mpmissions
		for dir in *; do
			if [ -d ${dir} ]; then 
				makepbo -N ${dir}
				mv -f ${dir}.pbo /opt/arma3/mpmissions/${dir}.pbo
				echo " - added /opt/arma3/mpmissions/${dir}.pbo"
			fi			
		done
		popd
	fi
	popd
fi

exec "$@"
