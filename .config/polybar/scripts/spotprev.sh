#!/bin/sh

main() {
	if ! pgrep -x spotify >/dev/null; then
		echo "";exit
	fi

	echo " 玲"
}

main "$@"
