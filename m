From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] can: xilinx: fix xcan_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:16:13 +0200
Message-ID: <20180424131614.3357-1-luc.vanoostenryck@gmail.com>
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
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>
List-Id: linux-can.vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/net/can/xilinx_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 89aec07c2..a19648606 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -386,7 +386,7 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
  *
  * Return: 0 on success and failure value on error
  */
-static int xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
-- 
2.17.0
