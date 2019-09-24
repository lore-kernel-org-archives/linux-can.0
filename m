From: Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH 4/7] can: ti_hecc: keep MIM and MD set
Date: Tue, 24 Sep 2019 18:45:56 +0000
Message-ID: <20190924184437.10607-5-jhofstee@victronenergy.com>
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

The HECC_CANMIM is set in the xmit path and cleared in the interrupt.
Since this is done with a read, modify, write action the register might
end up with some more MIM enabled then intended, since it is not
protected. That doesn't matter at all, since the tx interrupt disables
the mailbox with HECC_CANME (while holding a spinlock). So lets just
always keep MIM set.

While at it, since the mailbox direction never changes, don't set it
every time a message is send, ti_hecc_reset already sets them to tx.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
---
 drivers/net/can/ti_hecc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index b82c011ddbec..35c82289f2a3 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -382,6 +382,9 @@ static void ti_hecc_start(struct net_device *ndev)
 		hecc_set_bit(priv, HECC_CANMIM, mbx_mask);
 	}
=20
+	/* Enable tx interrupts */
+	hecc_set_bit(priv, HECC_CANMIM, BIT(HECC_MAX_TX_MBOX) - 1);
+
 	/* Prevent message over-write & Enable interrupts */
 	hecc_write(priv, HECC_CANOPC, HECC_SET_REG);
 	if (priv->use_hecc1int) {
@@ -511,8 +514,6 @@ static netdev_tx_t ti_hecc_xmit(struct sk_buff *skb, st=
ruct net_device *ndev)
 	hecc_set_bit(priv, HECC_CANME, mbx_mask);
 	spin_unlock_irqrestore(&priv->mbx_lock, flags);
=20
-	hecc_clear_bit(priv, HECC_CANMD, mbx_mask);
-	hecc_set_bit(priv, HECC_CANMIM, mbx_mask);
 	hecc_write(priv, HECC_CANTRS, mbx_mask);
=20
 	return NETDEV_TX_OK;
@@ -675,7 +676,6 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev=
_id)
 			mbx_mask =3D BIT(mbxno);
 			if (!(mbx_mask & hecc_read(priv, HECC_CANTA)))
 				break;
-			hecc_clear_bit(priv, HECC_CANMIM, mbx_mask);
 			hecc_write(priv, HECC_CANTA, mbx_mask);
 			spin_lock_irqsave(&priv->mbx_lock, flags);
 			hecc_clear_bit(priv, HECC_CANME, mbx_mask);
--=20
2.17.1
