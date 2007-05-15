# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-mplayer/files/rc-addon-0.9.15.sh,v 1.1 2007/05/15 12:51:41 zzam Exp $
#
# rc-addon plugin-startup-skript for vdr-mplayer
#

: ${MPLAYER_PLUGIN_CALL:=mplay.sh}
: ${MPLAYER_PLUGIN_MOUNT:=mount-mplayer.sh}

plugin_pre_vdr_start() {
	local P=/usr/share/vdr/mplayer/bin
	local CALL=""
	if [ -f $P/${MPLAYER_PLUGIN_CALL} ]; then
		CALL=${MPLAYER_PLUGIN_CALL}
	elif [ -f $P/mplay.sh ]; then
		CALL=mplay.sh
	elif [ -f $P/mplayer.sh ]; then
		CALL=mplayer.sh
	else
		eerror "vdr-mplayer: No mplayer-script found"
	fi
	add_plugin_param "-m ${P}/${MPLAYER_PLUGIN_MOUNT}"
	add_plugin_param "-M ${P}/${CALL}"
}
