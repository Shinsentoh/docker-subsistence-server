############################################################
# Dockerfile that builds a Subsistence Gameserver
############################################################
FROM silentmecha/steamcmd-wine:latest

LABEL maintainer="bibi_agent000@msn.com"

ENV STEAMAPPID 1362640
ENV STEAMAPP Subsistence
ENV STEAMAPPDIR "${HOME}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/Shinsentoh/docker-subsistence-server

USER root

RUN set -x \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& wget "${DLURL}/main/etc/entry.sh" -O "${HOME}/entry.sh" \
	&& chmod 755 "${HOME}/entry.sh" "${STEAMAPPDIR}" \
	&& chown "${USER}:${USER}" "${HOME}/entry.sh" "${STEAMAPPDIR}"

ENV SBST_PORT=7777 \
	SBST_QUERYPORT=27015 \
	SBST_PROFILE=1 \
	SBST_HUNTERS=true \
	SBST_HUNTERS_ATTACKS=0 \
	SBST_DIFFICULTY=normal \
	SBST_DAYS_PER_YEAR=24 \
	SBST_MONTH_OVERRIDE=-1 \
	SBST_PASSWORD="Password" \
	SBST_ADMIN_PASSWORD= \
	SBST_SERVER_NAME="Subsistence Server" \
	SBST_SERVER_DESCRIPTION= \
	SBST_HOSTNAME="Host name" \
	SBST_MAX_PLAYERS=32 \
	SBST_BASE_DECAY_AFTER_HOURS=0 \
	SBST_PVP_DAMAGE=true \
	SBST_DAMAGE_OTHER_PLAYER_BASES=true \
	SBST_ACCESS_ENEMY_ITEMS=true

USER ${USER}

WORKDIR ${HOME}

VOLUME 	${STEAMAPPDIR}

# Expose ports
EXPOSE 	${SBST_PORT}/udp \
		${SBST_QUERYPORT}/tcp \
		${SBST_QUERYPORT}/udp

CMD ["bash", "entry.sh"]