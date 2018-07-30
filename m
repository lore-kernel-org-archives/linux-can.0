From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: ems_usb: Fix memory leak on ems_usb_disconnect()
Date: Mon, 30 Jul 2018 11:08:22 +0200
Message-ID: <20180730090822.16919-2-mkl@pengutronix.de>
References: <20180730090822.16919-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180730090822.16919-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Anton Vasilyev <vasilyev@ispras.ru>, stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

ems_usb_probe() allocates memory for dev->tx_msg_buffer, but there
is no its deallocation in ems_usb_disconnect().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Cc: <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
