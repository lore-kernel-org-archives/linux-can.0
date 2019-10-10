From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 03/29] can: mcba_usb: fix use-after-free on disconnect
Date: Thu, 10 Oct 2019 14:17:24 +0200
Message-ID: <20191010121750.27237-4-mkl@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191010121750.27237-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc: davem@davemloft.net, kernel@pengutronix.de, jhofstee@victronenergy.com, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, =?UTF-8?q?Remigiusz=20Ko=C5=82=C5=82=C4=85taj?= <remigiusz.kollataj@mobica.com>, syzbot+e29b17e5042bbc56fae9@syzkaller.appspotmail.com, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Johan Hovold <johan@kernel.org>

The driver was accessing its driver data after having freed it.

Fixes: 51f3baad7de9 ("can: mcba_usb: Add support for Microchip CAN BUS Analyzer")
Cc: stable <stable@vger.kernel.org>     # 4.12
Cc: Remigiusz Kołłątaj <remigiusz.kollataj@mobica.com>
Reported-by: syzbot+e29b17e5042bbc56fae9@syzkaller.appspotmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/mcba_usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 19a702ac49e4..21faa2ec4632 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -876,9 +876,8 @@ static void mcba_usb_disconnect(struct usb_interface *intf)
 	netdev_info(priv->netdev, "device disconnected\n");
 
 	unregister_candev(priv->netdev);
-	free_candev(priv->netdev);
-
 	mcba_urb_unlink(priv);
+	free_candev(priv->netdev);
 }
 
 static struct usb_driver mcba_usb_driver = {
-- 
2.23.0
