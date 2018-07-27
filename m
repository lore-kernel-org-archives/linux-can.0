From: Anton Vasilyev <vasilyev@ispras.ru>
Subject: [PATCH] can: ems_usb: Fix memory leak on ems_usb_disconnect
Date: Fri, 27 Jul 2018 18:50:42 +0300
Message-ID: <20180727155042.24582-1-vasilyev@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Anton Vasilyev <vasilyev@ispras.ru>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Martin Kelly <mkelly@xevo.com>, Martin Lederhilger <m.lederhilger@ds-automotion.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-can.vger.kernel.org

ems_usb_probe() allocates memory for dev->tx_msg_buffer, but there
is no its deallocation in ems_usb_disconnect.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/net/can/usb/ems_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 12ff0020ecd6..b7dfd4109d24 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -1072,6 +1072,7 @@ static void ems_usb_disconnect(struct usb_interface *intf)
 		usb_free_urb(dev->intr_urb);
 
 		kfree(dev->intr_in_buffer);
+		kfree(dev->tx_msg_buffer);
 	}
 }
 
-- 
2.18.0
