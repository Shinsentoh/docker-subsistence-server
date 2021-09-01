############################################################
# Dockerfile that builds a Subsistence Gameserver
############################################################
FROM cm2network/steamcmd:root

LABEL maintainer="bibi_agent000@msn.com"

ENV STEAMAPPID 1362640
ENV STEAMAPP subsistence
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/Shinsentoh/docker-subsistence-server

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.20.1-1.1 \
	&& wget "${DLURL}/develop/etc/entry.sh" -O "${HOMEDIR}/entry.sh" \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& chmod 755 "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	&& chown "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	&& rm -rf /var/lib/apt/lists/*

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

WORKDIR ${HOMEDIR}

VOLUME "${STEAMAPPDIR}"

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 7777/udp \
	27015/tcp \
	27015/udp \
	20560/tcp \
	20560/udp
