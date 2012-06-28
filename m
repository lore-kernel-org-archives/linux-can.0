From: Hui Wang <jason77.wang@gmail.com>
Subject: [RFC PATCH] can: dev: update rx state in the can_get_echo_skb()
Date: Thu, 28 Jun 2012 17:42:20 +0800
Message-ID: <1340876540-27840-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:48843 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932780Ab2F1Jmd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 05:42:33 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, shawn.guo@linaro.org, wg@grandegger.com
Cc: linux-can@vger.kernel.org

After a loopback packet is routed to rx interface, we forget to update
rx state both in the can_get_echo_skb() and in the controller specific
drivers, as a result, after we sent a loopback packet and executed
ifconfig, following state is outputed:
can0      Link encap:UNSPEC  HWaddr 00-00-00-00-<snip>
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:0 (0.0 B)  TX bytes:4 (4.0 B)

We add rx state update in the can_get_echo_skb() to solve this
problem.

Cc: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
I don't know if it is designed like that on purpose, please instruct
me if i am wrong.

I use following commands to let flexcan to work in the loopback mode:
%>ip link set can0 type can bitrate 125000
%>ip link set can0 type can loopback on
%>ip link set can0 up
And send a packet:
%>cantest can0 123#AABBCCDD
When i check net device state, i found tx doesn't equal rx:
%>ifconfig
can0      Link encap:UNSPEC  HWaddr 00-00-00-00-<snip>
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:0 (0.0 B)  TX bytes:4 (4.0 B)

From my understanding, i suppose it should be:
can0      Link encap:UNSPEC  HWaddr 00-00-00-00-<snip>
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:1 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10 
          RX bytes:4 (4.0 B)  TX bytes:4 (4.0 B)

 drivers/net/can/dev.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index f03d7a4..6b62f6a 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -340,6 +340,9 @@ unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
 		netif_rx(priv->echo_skb[idx]);
 		priv->echo_skb[idx] = NULL;
 
+		dev->stats.rx_bytes += dlc;
+		dev->stats.rx_packets++;
+
 		return dlc;
 	}
 
-- 
1.7.6

