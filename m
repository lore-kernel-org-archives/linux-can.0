From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/7] can: peak_usb: fix potential double kfree_skb()
Date: Wed, 24 Jul 2019 15:03:21 +0200
Message-ID: <20190724130322.31702-7-mkl@pengutronix.de>
References: <20190724130322.31702-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190724130322.31702-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Stephane Grosjean <s.grosjean@peak-system.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

When closing the CAN device while tx skbs are inflight, echo skb could
be released twice. By calling close_candev() before unlinking all
pending tx urbs, then the internal echo_skb[] array is fully and
correctly cleared before the USB write callback and, therefore,
can_get_echo_skb() are called, for each aborted URB.

Fixes: bb4785551f64 ("can: usb: PEAK-System Technik USB adapters driver core")
Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 458154c9b482..22b9c8e6d040 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -568,16 +568,16 @@ static int peak_usb_ndo_stop(struct net_device *netdev)
 	dev->state &= ~PCAN_USB_STATE_STARTED;
 	netif_stop_queue(netdev);
 
+	close_candev(netdev);
+
+	dev->can.state = CAN_STATE_STOPPED;
+
 	/* unlink all pending urbs and free used memory */
 	peak_usb_unlink_all_urbs(dev);
 
 	if (dev->adapter->dev_stop)
 		dev->adapter->dev_stop(dev);
 
-	close_candev(netdev);
-
-	dev->can.state = CAN_STATE_STOPPED;
-
 	/* can set bus off now */
 	if (dev->adapter->dev_set_bus) {
 		int err = dev->adapter->dev_set_bus(dev, 0);
-- 
2.20.1
