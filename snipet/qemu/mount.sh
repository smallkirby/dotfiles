mkdir /tmp/shared/
mount -t 9p -o trans=virtio test_mount /tmp/shared/ -oversion=9p2000.L,posixacl,cache=loose
