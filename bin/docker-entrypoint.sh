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

if [ ! -z "${EXILE_CONFIG_PASSWORD_COMMAND}" ]; then 
	echo "Rebuilding Exile server configuration..."
	pushd /home/steamu/sources/\@ExileServer/addons/
	sed -i "s#^\(\s*serverPassword\s*=\s*\"\).*\(\".*$\)#\1${EXILE_CONFIG_PASSWORD_COMMAND}\2#"  exile_server_config/config.cpp
	makepbo -N exile_server_config
	mv -f exile_server_config.pbo /opt/arma3/\@ExileServer/addons/exile_server_config.pbo
	popd
fi

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
		pushd mpmssions
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
