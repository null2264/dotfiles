#!/bin/dash
main() {
	status=$(cmus-remote -Q | grep "status")
	if [ "$status" = "status playing" ]; then
		echo ""
	elif [ "$status" = "status paused" ]; then
		echo "契"
	elif [ "$status" = "status stopped" ]; then
		echo "栗"
	else
		echo ""
	fi
	echo $status
}
main "$@"
