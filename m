From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/3] can: peak_usb: fix cleanup sequence order in case of error during init
Date: Sun,  7 Dec 2014 23:06:05 +0100
Message-ID: <1417989966-31309-3-git-send-email-mkl@pengutronix.de>
References: <1417989966-31309-1-git-send-email-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1417989966-31309-1-git-send-email-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Stephane Grosjean <s.grosjean@peak-system.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

This patch sets the correct reverse sequence order to the instructions
set to run, when any failure occurs during the initialization steps.
It also adds the missing unregistration call of the can device if the
failure appears after having been registered.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 644e6ab8a489..dc807e10f802 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -735,7 +735,7 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 	dev->cmd_buf = kmalloc(PCAN_USB_MAX_CMD_LEN, GFP_KERNEL);
 	if (!dev->cmd_buf) {
 		err = -ENOMEM;
-		goto lbl_set_intf_data;
+		goto lbl_free_candev;
 	}
 
 	dev->udev = usb_dev;
@@ -775,7 +775,7 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 	err = register_candev(netdev);
 	if (err) {
 		dev_err(&intf->dev, "couldn't register CAN device: %d\n", err);
-		goto lbl_free_cmd_buf;
+		goto lbl_restore_intf_data;
 	}
 
 	if (dev->prev_siblings)
@@ -788,14 +788,14 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 	if (dev->adapter->dev_init) {
 		err = dev->adapter->dev_init(dev);
 		if (err)
-			goto lbl_free_cmd_buf;
+			goto lbl_unregister_candev;
 	}
 
 	/* set bus off */
 	if (dev->adapter->dev_set_bus) {
 		err = dev->adapter->dev_set_bus(dev, 0);
 		if (err)
-			goto lbl_free_cmd_buf;
+			goto lbl_unregister_candev;
 	}
 
 	/* get device number early */
@@ -807,11 +807,14 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 
 	return 0;
 
-lbl_free_cmd_buf:
-	kfree(dev->cmd_buf);
+lbl_unregister_candev:
+	unregister_candev(netdev);
 
-lbl_set_intf_data:
+lbl_restore_intf_data:
 	usb_set_intfdata(intf, dev->prev_siblings);
+	kfree(dev->cmd_buf);
+
+lbl_free_candev:
 	free_candev(netdev);
 
 	return err;
-- 
2.1.3
