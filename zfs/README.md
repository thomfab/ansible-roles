# Add ZFS utilities to a server

This role install ZFS tools on an Ubuntu server

## Role Variables

This role installs the zfsutils-linux package and copies 3 useful scripts.

Two can be used with monit to monitor that pools are imported and healthy :
* zfs_nbpools.sh : returns the number of imported pool. Exit code is 0 if at least one pool is imported, 1 if not
* zfs_healthcheck.sh : checks health of pools (script found in https://calomel.org/zfs_health_check_script.html and used as is)

The last script `zfs_scrub.sh` scrubs all imported pools.
3 variables can be used to control scheduling :
* zfs_scrub_hour 
* zfs_scrub_minute
* zfs_scrub_weekday (see crontab man page for possible values)


## Example Playbook

Example :

    ---
    - hosts: servers
      roles:
        - role: zfs
          zfs_scrub_hour: "11"
          zfs_scrub_minute: "0"
          zfs_scrub_weekday: "1"

## License

BSD
