From: matthias.fuchs@esd.eu
Subject: [PATCH v2 1/2] can: usb: esd_usb2: Add support for listen-only mode
Date: Mon, 29 Oct 2012 10:54:47 +0100
Message-ID: <1351504488-7060-2-git-send-email-matthias.fuchs@esd.eu>
References: <1351504488-7060-1-git-send-email-matthias.fuchs@esd.eu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60560 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442Ab2J2J4N (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Oct 2012 05:56:13 -0400
In-Reply-To: <1351504488-7060-1-git-send-email-matthias.fuchs@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Matthias Fuchs <matthias.fuchs@esd.eu>

From: Matthias Fuchs <matthias.fuchs@esd.eu>

Add listen-only mode for esd_usb2 driver.

Signed-off-by: Matthias Fuchs <matthias.fuchs@esd.eu>
---
 drivers/net/can/usb/esd_usb2.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index bd36e55..f4317c0 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -891,6 +891,9 @@ static int esd_usb2_set_bittiming(struct net_device *netdev)
 	u32 canbtr;
 
 	canbtr = ESD_USB2_UBR;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		canbtr |= ESD_USB2_LOM;
+
 	canbtr |= (bt->brp - 1) & (ESD_USB2_BRP_MAX - 1);
 	canbtr |= ((bt->sjw - 1) & (ESD_USB2_SJW_MAX - 1))
 		<< ESD_USB2_SJW_SHIFT;
@@ -971,6 +974,7 @@ static int esd_usb2_probe_one_net(struct usb_interface *intf, int index)
 	priv->index = index;
 
 	priv->can.state = CAN_STATE_STOPPED;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY;
 	priv->can.clock.freq = ESD_USB2_CAN_CLOCK;
 	priv->can.bittiming_const = &esd_usb2_bittiming_const;
 	priv->can.do_set_bittiming = esd_usb2_set_bittiming;
-- 
1.7.4.1

