From: Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH 1/7] can: rx-offload: continue on error
Date: Tue, 24 Sep 2019 18:45:38 +0000
Message-ID: <20190924184437.10607-2-jhofstee@victronenergy.com>
References: <20190924184437.10607-1-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190924184437.10607-1-jhofstee@victronenergy.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Jeroen Hofstee <jhofstee@victronenergy.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

While can_rx_offload_offload_one will call mailbox_read to discard
the mailbox in case of an error, can_rx_offload_irq_offload_timestamp
bails out in the error case. Since it is typically called from a while
loop, all message will eventually be discarded. So lets continue on
error instead to discard them directly.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
---
 drivers/net/can/rx-offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index e6a668ee7730..39df41280e2d 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -158,7 +158,7 @@ int can_rx_offload_irq_offload_timestamp(struct can_rx_=
offload *offload, u64 pen
=20
 		skb =3D can_rx_offload_offload_one(offload, i);
 		if (!skb)
-			break;
+			continue;
=20
 		__skb_queue_add_sort(&skb_queue, skb, can_rx_offload_compare);
 	}
--=20
2.17.1
