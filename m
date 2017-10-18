From: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>
Subject: [PATCH 2/2] can: usb: esd_usb2: Fix can_dlc value for received RTR,
 frames
Date: Wed, 18 Oct 2017 13:25:17 +0200
Message-ID: <c66525cb-77bd-fa5f-d3ab-78db08bdd763@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxp01.htp-tel.de ([212.59.41.8]:62558 "EHLO mxpout01.htp-tel.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753337AbdJRLZ0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 18 Oct 2017 07:25:26 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

The dlc member of the struct rx_msg contains also the ESD_RTR flag to mark
received RTR frames. Without the fix the can_dlc value for received RTR
frames would always be set to 8 by get_can_dlc() instead of the received
value.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index 6183b7707ad7..20f2aa21677f 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -49,7 +49,7 @@ MODULE_LICENSE("GPL v2");
 #define CMD_IDADD              6 /* also used for IDADD_REPLY */

 /* esd CAN message flags - dlc field */
-#define ESD_RTR                        0x10
+#define ESD_RTR                        0x10u

 /* esd CAN message flags - id field */
 #define ESD_EXTID              0x20000000
@@ -334,7 +334,7 @@ static void esd_usb2_rx_can_msg(struct
esd_usb2_net_priv *priv,
                }

                cf->can_id = id & ESD_IDMASK;
-               cf->can_dlc = get_can_dlc(msg->msg.rx.dlc);
+               cf->can_dlc = get_can_dlc(msg->msg.rx.dlc & ~ESD_RTR);

                if (id & ESD_EXTID)
                        cf->can_id |= CAN_EFF_FLAG;
-- 
2.11.0


