From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] can: mcba_usb: fix use-after-free on disconnect
Date: Tue,  1 Oct 2019 12:29:13 +0200
Message-ID: <20191001102914.4567-2-johan@kernel.org>
References: <20191001102914.4567-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191001102914.4567-1-johan@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, =?UTF-8?q?Remigiusz=20Ko=C5=82=C5=82=C4=85taj?= <remigiusz.kollataj@mobica.com>, syzbot+e29b17e5042bbc56fae9@syzkaller.appspotmail.com
List-Id: linux-can.vger.kernel.org

The driver was accessing its driver data after having freed it.

Fixes: 51f3baad7de9 ("can: mcba_usb: Add support for Microchip CAN BUS Analyzer")
Cc: stable <stable@vger.kernel.org>     # 4.12
Cc: Remigiusz Kołłątaj <remigiusz.kollataj@mobica.com>
Reported-by: syzbot+e29b17e5042bbc56fae9@syzkaller.appspotmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
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
