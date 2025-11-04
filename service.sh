#!/system/bin/sh

MODDIR="${0%/*}"

wait_until_login() {
  until [ "$(getprop sys.boot_completed)" -eq 1 ]; do
    sleep 1
  done
  
  # test
  test_file="/storage/emulated/0/.SILENT"
  until touch "$test_file" 2>/dev/null; do
    sleep 1
  done
  rm -f "$test_file"
}

wait_until_login
sleep 20

if [ -x "$MODDIR/system/bin/silent_trace" ]; then
  setsid "$MODDIR/system/bin/silent_trace" >/dev/null 2>&1 < /dev/null &
else
  if [ -x "/system/bin/silent_trace" ]; then
    setsid /system/bin/silent_trace >/dev/null 2>&1 < /dev/null &
  fi
fi
