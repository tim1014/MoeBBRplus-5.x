#!/bin/bash
# By MoeClub

# bbr_min_rtt_win_sec
sed -i 's|static const u32 bbr_min_rtt_win_sec[^;]*;|static const u32 bbr_min_rtt_win_sec = 13;|g' /root/convert_official_linux-6.0.x_src_to_bbrplus.patch

# bbr_probe_rtt_mode_ms
sed -i 's|static const u32 bbr_probe_rtt_mode_ms[^;]*;|static const u32 bbr_probe_rtt_mode_ms = 56;|g' /root/convert_official_linux-6.0.x_src_to_bbrplus.patch

# bbr_min_tso_rate
sed -i 's|static const int bbr_min_tso_rate[^;]*;|static const int bbr_min_tso_rate = 256000;|g' /root/convert_official_linux-6.0.x_src_to_bbrplus.patch

# bbr_gain
sed -i 's|static const int bbr_high_gain[^;]*;|static const int bbr_high_gain = BBR_UNIT * (2885 * 2) / 1000 + 1;|g' /root/convert_official_linux-6.0.x_src_to_bbrplus.patch
sed -i 's|static const int bbr_drain_gain[^;]*;|static const int bbr_drain_gain = BBR_UNIT * 2 * 1000 / 2885;|g' /root/convert_official_linux-6.0.x_src_to_bbrplus.patch

# bbr_pacing_gain
#sed -i '1h;1!H;$!d;${g;s|static const int bbr_pacing_gain\[\][^;]*;|static const int bbr_pacing_gain[] = \{\n        BBR_UNIT * 16 / 8,\n        BBR_UNIT * 6 / 8,\n        BBR_UNIT * 16 / 8,        BBR_UNIT * 10 / 8,        BBR_UNIT * 14 / 8,\n        BBR_UNIT * 10 / 8,        BBR_UNIT * 12 / 8,        BBR_UNIT * 10 / 8\n\};|g;}' /root/convert_official_linux-6.0.x_src_to_bbrplus.patch

# bbr_full_bw_thresh
sed -i 's|static const u32 bbr_full_bw_thresh[^;]*;|static const u32 bbr_full_bw_thresh = BBR_UNIT * 17 / 16;|g' /root/convert_official_linux-6.0.x_src_to_bbrplus.patch

# bbr_lt_bw
sed -i 's|static const u32 bbr_lt_bw_ratio[^;]*;|static const u32 bbr_lt_bw_ratio = BBR_UNIT / 4;|g' /root/convert_official_linux-6.0.x_src_to_bbrplus.patch
sed -i 's|static const u32 bbr_lt_bw_diff[^;]*;|static const u32 bbr_lt_bw_diff = 8000 / 8;|g' /root/convert_official_linux-6.0.x_src_to_bbrplus.patch

# mark
#sed -i 's|^MODULE_DESCRIPTION([^;]*;|MODULE_DESCRIPTION("TCP BBR (Bottleneck Bandwidth and RTT) [SV: '$(date +%Y/%m/%d)' Installed]");|g' /root/convert_official_linux-6.0.x_src_to_bbrplus.patch