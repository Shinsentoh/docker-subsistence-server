#!/bin/bash

bash steamcmd \
	+@sSteamCmdForcePlatformType windows \
	+login anonymous \
	+force_install_dir "${STEAMAPPDIR}" \
	+app_update "${STEAMAPPID}" validate \
	+quit

if [ ! -d "${HOME}/.wine" ]; then
    echo "Configuring wine for the first time"
    wine wineboot --init
fi

arguments="server coldmap1?steamsockets -log"
command="${STEAMAPPDIR}/Binaries/Win64/UDK.exe $arguments"

# if UDKDedServerSettings.ini doesn't exists, then it's a fresh container
if [ ! -f "${STEAMAPPDIR}/UDKGame/Config/UDKDedServerSettings.ini" ]; then
	# launch game for some time
	wine64 $command & serverPID=$!
	echo "waiting until UDKDedServerSettings.ini is created."
	while ! [ -f "${STEAMAPPDIR}/UDKGame/Config/UDKDedServerSettings.ini" ]
	do
		sleep 1
	done
	kill -SIGINT $serverPID
	echo "UDKDedServerSettings.ini exists."

	# Download & extract the configs
	wget -qO- "${DLURL}/main/etc/cfg.tar.gz" | tar -xvzf -C "${STEAMAPPDIR}/"
	rm -rf "${STEAMAPPDIR}/UDKGame/Config/UDKDedServerSettings.ini"
	mv "${STEAMAPPDIR}/cfg/UDKDedServerSettings.ini" "${STEAMAPPDIR}/UDKGame/Config"

	# Change first launch variables (you can comment this out if it has done it's purpose)
	sed -i 	-e 's/{{SBST_PROFILE}}/'"${SBST_PROFILE}"'/g' \
			-e 's/{{SBST_HUNTERS}}/'"${SBST_HUNTERS}"'/g' \
			-e 's/{{SBST_HUNTERS_ATTACKS}}/'"${SBST_HUNTERS_ATTACKS}"'/g' \
			-e 's/{{SBST_DIFFICULTY}}/'"${SBST_DIFFICULTY}"'/g' \
			-e 's/{{SBST_DAYS_PER_YEAR}}/'"${SBST_DAYS_PER_YEAR}"'/g' \
			-e 's/{{SBST_MONTH_OVERRIDE}}/'"${SBST_MONTH_OVERRIDE}"'/g' \
			-e 's/{{SBST_PASSWORD}}/'"${SBST_PASSWORD}"'/g' \
			-e 's/{{SBST_ADMIN_PASSWORD}}/'"${SBST_ADMIN_PASSWORD}"'/g' \
			-e 's/{{SBST_SERVER_NAME}}/'"${SBST_SERVER_NAME}"'/g' \
			-e 's/{{SBST_SERVER_DESCRIPTION}}/'"${SBST_SERVER_DESCRIPTION}"'/g' \
			-e 's/{{SBST_HOSTNAME}}/'"${SBST_HOSTNAME}"'/g' \
			-e 's/{{SBST_MAX_PLAYERS}}/'"${SBST_MAX_PLAYERS}"'/g' \
			-e 's/{{SBST_BASE_DECAY_AFTER_HOURS}}/'"${SBST_BASE_DECAY_AFTER_HOURS}"'/g' \
			-e 's/{{SBST_PVP_DAMAGE}}/'"${SBST_PVP_DAMAGE}"'/g' \
			-e 's/{{SBST_DAMAGE_OTHER_PLAYER_BASES}}/'"${SBST_DAMAGE_OTHER_PLAYER_BASES}"'/g' \
			-e 's/{{SBST_ACCESS_ENEMY_ITEMS}}/'"${SBST_ACCESS_ENEMY_ITEMS}"'/g' "${STEAMAPPDIR}/UDKGame/Config/UDKDedServerSettings.ini"

	echo "UDKDedServerSettings.ini was edited with ENV configuration."
fi

echo "starting Subsistence server: '${SBST_SERVER_NAME}' ..."
wine64 $command & serverPID=$!
wait $serverPID
echo "Subsistence server stopped."
exit 0