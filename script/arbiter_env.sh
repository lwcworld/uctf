#!/usr/bin/env sh
export INSTALL_SPACE=/opt/sasc
. ${INSTALL_SPACE}/venv3/bin/activate
. ${INSTALL_SPACE}/setup.sh
log="arbiter_log"
eval "$@" \&
PID=$!
echo "running" "$@" "in PID $PID"> $log
{ (cat <&3 3<&- >/dev/null; kill $PID; echo "killed" >> $log) & } 3<&0
trap "echo EXIT >> $log" EXIT
wait $PID
