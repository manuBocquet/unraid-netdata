docker run -d --cap-add SYS_PTRACE \
	-v /var/run/docker.sock:/var/run/docker.sock:ro \
	-v /proc:/host/proc:ro \
	-v /sys:/host/sys:ro \
	-p 19999:19999 netdata
