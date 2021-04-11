# BBRPlus-5.10.x (Tuned By MoeClub)

Linux BBRplus Kernel v5.10.x ported from <a href="https://github.com/MoeClub/BBR" target="_blank">MoeClub/BBR</a> v4.14.153 <br/>
(Please note that **IT DOES NOT** based on v5.10 version of BBR, instead just simple ported the v4.14.153 version of BBR)

# Credits

https://github.com/MoeClub/BBR<br/>
https://github.com/UJX6N/bbrplus-5.10

<br/><br/>

# Highlights

- Merged MoeClub v4.14.153 "tcp_bbr" patches into bbrplus.
- Keep official v5.10 "tcp_bbr" module in the kernel, now can do either.

	net.ipv4.tcp_congestion_control = bbrplus
	net.ipv4.tcp_congestion_control = bbr
