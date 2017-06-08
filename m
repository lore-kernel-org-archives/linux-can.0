From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: gs_usb: fix memory leak in gs_cmd_reset()
Date: Thu,  8 Jun 2017 12:03:10 +0200
Message-ID: <20170608100310.5868-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-stable <stable@vger.kernel.org>, Maximilian Schneider <max@schneidersoft.net>
List-Id: linux-can.vger.kernel.org

This patch adds the missing kfree() in gs_cmd_reset() to free the
memory that is not used anymore after usb_control_msg().

Cc: linux-stable <stable@vger.kernel.org>
Cc: Maximilian Schneider <max@schneidersoft.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Maximilian,

feel free to review this patch.

Marc

 drivers/net/can/usb/gs_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index eecee7f8dfb7..afcc1312dbaf 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -265,6 +265,8 @@ static int gs_cmd_reset(struct gs_usb *gsusb, struct gs_can *gsdev)
 			     sizeof(*dm),
 			     1000);
 
+	kfree(dm);
+
 	return rc;
 }
 
-- 
2.11.0
