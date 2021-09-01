#!/bin/bash
bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous \
				+force_install_dir "${STEAMAPPDIR}" \
				+app_update "${STEAMAPPID}" validate \
				+quit

# if [ ! -f "${STEAMAPPDIR}/cfg/UDKDedServerSettings.ini" ]; then
# 	# Download & extract the configs
# 	wget -qO- "${DLURL}/main/etc/cfg.tar.gz" | tar xvzf - -C "${STEAMAPPDIR}/"

# # Change first launch variables (you can comment this out if it has done it's purpose)
# sed -i 	-e 's/{{SBST_PROFILE}}/'"${SBST_PROFILE}"'/g' \
# 		-e 's/{{SBST_HUNTERS}}/'"${SBST_HUNTERS}"'/g' \
# 		-e 's/{{SBST_HUNTERS_ATTACKS}}/'"${SBST_HUNTERS_ATTACKS}"'/g' \
# 		-e 's/{{SBST_DIFFICULTY}}/'"${SBST_DIFFICULTY}"'/g' \
# 		-e 's/{{SBST_DAYS_PER_YEAR}}/'"${SBST_DAYS_PER_YEAR}"'/g' \
# 		-e 's/{{SBST_MONTH_OVERRIDE}}/'"${SBST_MONTH_OVERRIDE}"'/g' \
# 		-e 's/{{SBST_PASSWORD}}/'"${SBST_PASSWORD}"'/g' \
# 		-e 's/{{SBST_ADMIN_PASSWORD}}/'"${SBST_ADMIN_PASSWORD}"'/g' \
# 		-e 's/{{SBST_SERVER_NAME}}/'"${SBST_SERVER_NAME}"'/g' \
# 		-e 's/{{SBST_SERVER_DESCRIPTION}}/'"${SBST_SERVER_DESCRIPTION}"'/g' \
# 		-e 's/{{SBST_HOSTNAME}}/'"${SBST_HOSTNAME}"'/g' \
# 		-e 's/{{SBST_MAX_PLAYERS}}/'"${SBST_MAX_PLAYERS}"'/g' \
# 		-e 's/{{SBST_BASE_DECAY_AFTER_HOURS}}/'"${SBST_BASE_DECAY_AFTER_HOURS}"'/g' \
# 		-e 's/{{SBST_PVP_DAMAGE}}/'"${SBST_PVP_DAMAGE}"'/g' \
# 		-e 's/{{SBST_DAMAGE_OTHER_PLAYER_BASES}}/'"${SBST_DAMAGE_OTHER_PLAYER_BASES}"'/g' \
# 		-e 's/{{SBST_ACCESS_ENEMY_ITEMS}}/'"${SBST_ACCESS_ENEMY_ITEMS}"'/g' "${STEAMAPPDIR}/cfg/UDKDedServerSettings.ini"

# fi

# bash "${STEAMAPPDIR}/SquadGameServer.sh" \
# 			Port="${PORT}" \
# 			QueryPort="${QUERYPORT}" \
# 			RCONPORT="${RCONPORT}" \
# 			FIXEDMAXPLAYERS="${FIXEDMAXPLAYERS}" \
# 			FIXEDMAXTICKRATE="${FIXEDMAXTICKRATE}" \
# 			RANDOM="${RANDOM}"
