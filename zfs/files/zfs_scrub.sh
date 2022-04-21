#!/bin/bash

TOPIC=zfs_scrub

log_message () {
  if which logger > /dev/null; then
    LEVEL=$1
    shift
    logger -p user.$LEVEL -t $TOPIC "$@"
  fi
}

log_info () {
  log_message "info" "$@"
}

log_warning () {
  log_message "warn" "$@"
}

log_error () {
  log_message "err" "$@"
}

LOGFILE="$0"
TMPLOG="/tmp/${LOGFILE##*/}.log"

log_info "ZFS scrub start"
log_info "parameters: $@"

POOLS=$(zpool list -H -o name)

for pool in $POOLS
do
  /sbin/zpool scrub $pool > $TMPLOG 2>&1
  if [ $? -eq 0 ]; then
    log_info "scrub successful"
  else
    log_error "error while scrubing"
  fi
  log_info < $TMPLOG
done

log_info "ZFS scrub end"
