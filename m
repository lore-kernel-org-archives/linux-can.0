From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] can: sun4i: fix sun4ican_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:16:11 +0200
Message-ID: <20180424131611.3307-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@bootlin.com>, netdev@vger.kernel.org, linux-can@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>
List-Id: linux-can.vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/net/can/sun4i_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 1ac2090a1..093fc9a52 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -409,7 +409,7 @@ static int sun4ican_set_mode(struct net_device *dev, enum can_mode mode)
  * xx xx xx xx         ff         ll 00 11 22 33 44 55 66 77
  * [ can_id ] [flags] [len] [can data (up to 8 bytes]
  */
-static int sun4ican_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t sun4ican_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct sun4ican_priv *priv = netdev_priv(dev);
 	struct can_frame *cf = (struct can_frame *)skb->data;
-- 
2.17.0
