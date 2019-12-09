From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 13/13] can: kvaser_usb: kvaser_usb_leaf: Fix some info-leaks to USB devices
Date: Mon,  9 Dec 2019 17:32:56 +0100
Message-ID: <20191209163256.12000-14-mkl@pengutronix.de>
References: <20191209163256.12000-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191209163256.12000-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Xiaolong Huang <butterflyhuangxx@gmail.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Xiaolong Huang <butterflyhuangxx@gmail.com>

Uninitialized Kernel memory can leak to USB devices.

Fix this by using kzalloc() instead of kmalloc().

Signed-off-by: Xiaolong Huang <butterflyhuangxx@gmail.com>
Fixes: 7259124eac7d ("can: kvaser_usb: Split driver into kvaser_usb_core.c and kvaser_usb_leaf.c")
Cc: linux-stable <stable@vger.kernel.org> # >= v4.19
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 07d2f3aa2c02..ae4c37e1bb75 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -608,7 +608,7 @@ static int kvaser_usb_leaf_simple_cmd_async(struct kvaser_usb_net_priv *priv,
 	struct kvaser_cmd *cmd;
 	int err;
 
-	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
+	cmd = kzalloc(sizeof(*cmd), GFP_ATOMIC);
 	if (!cmd)
 		return -ENOMEM;
 
@@ -1140,7 +1140,7 @@ static int kvaser_usb_leaf_set_opt_mode(const struct kvaser_usb_net_priv *priv)
 	struct kvaser_cmd *cmd;
 	int rc;
 
-	cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
 
@@ -1206,7 +1206,7 @@ static int kvaser_usb_leaf_flush_queue(struct kvaser_usb_net_priv *priv)
 	struct kvaser_cmd *cmd;
 	int rc;
 
-	cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
 
-- 
2.24.0
