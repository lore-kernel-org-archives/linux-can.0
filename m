From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: gw: ensure DLC boundaries after CAN frame modification
Date: Thu,  3 Jan 2019 13:26:34 +0100
Message-ID: <20190103122634.2530-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: davem@davemloft.net, netdev@vger.kernel.org
Cc: ieatmuttonchuan@gmail.com, meissner@suse.de, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

The CAN frame modification rules allow bitwise logical operations which can
be also applied to the can_dlc field. Ensure the manipulation result to
maintain the can_dlc boundaries so that the CAN drivers do not accidently
write arbitrary content beyond the data registers in the CAN controllers
I/O mem when processing can-gw manipulated outgoing frames. When passing these
frames to user space this issue did not have any effect to the kernel or any
leaked data as we always strictly copy sizeof(struct can_frame) bytes.

Reported-by: Muyu Yu <ieatmuttonchuan@gmail.com>
Reported-by: Marcus Meissner <meissner@suse.de>
Tested-by: Muyu Yu <ieatmuttonchuan@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-stable <stable@vger.kernel.org> # >= v3.2
---
 net/can/gw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/can/gw.c b/net/can/gw.c
index faa3da88a127..9000d9b8a133 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -418,6 +418,10 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 
 	/* check for checksum updates when the CAN frame has been modified */
 	if (modidx) {
+		/* ensure DLC boundaries after the different mods */
+		if (cf->can_dlc > 8)
+			cf->can_dlc = 8;
+
 		if (gwj->mod.csumfunc.crc8)
 			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
 
-- 
2.19.2
