From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [BUG] pfifo_fast may cause out-of-order CAN frame transmission
Date: Wed, 8 Jan 2020 15:55:34 +0100
Message-ID: <661cc33a-5f65-2769-cc1a-65791cb4b131@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Cc: Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-can.vger.kernel.org

Hello,

I've run into an issue of CAN frames being sent out-of-order on an i.MX6 Dual
with Linux v5.5-rc5. Bisecting has lead me down to this commit:

ba27b4cdaaa ("net: dev: introduce support for sch BYPASS for lockless qdisc")

With it, using pfifo_fast, every few hundred frames, FlexCAN's .ndo_start_xmit is
passed frames in an order different from how userspace stuffed them into the same
socket.

Reverting it fixes the issue as does booting with maxcpus=1 or using pfifo
instead of pfifo_fast.

According to [1], such reordering shouldn't be happening.

Details on my setup:
Kernel version: v5.5-rc5, (occurs much more often with LOCKDEP turned on)
CAN-Bitrate: 250 kbit/s
CAN frames are generated with:
cangen canX -I2 -L1 -Di -i -g0.12 -p 100
which keeps polling after ENOBUFS until socket is writable, sends out a CAN
frame with one incrementing payload byte and then waits 120 usec before repeating.

Please let me know if any additional info is needed.

Cheers
Ahmad

[1]: http://linux-tc-notes.sourceforge.net/tc/doc/sch_pfifo_fast.txt

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
