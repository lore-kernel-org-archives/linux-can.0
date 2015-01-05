From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH stable] can_dev: fix crtlmode_supported check
Date: Mon, 05 Jan 2015 18:40:15 +0100
Message-ID: <54AACC7F.5070605@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:61804 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbbAERk1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 Jan 2015 12:40:27 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

When changing flags in the CAN drivers ctrlmode the provided new content has 
to be checked whether the bits are allowed to be changed.
The bits that are to be changed are given as a bitfield in cm->mask.
Therefore checking against cm->flags is wrong as the content can hold any kind 
of values.

The iproute2 tool sets the bits in cm->mask and cm->flags depending on the 
detected command line options. To be robust against bogus user space 
applications additionally sanitize the provided flags with the provided mask.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
CC: Wolfgang Grandegger <wg@grandegger.com>

---

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 3ec8f6f..847c1f8 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -807,10 +807,14 @@ static int can_changelink(struct net_device *dev,
  		if (dev->flags & IFF_UP)
  			return -EBUSY;
  		cm = nla_data(data[IFLA_CAN_CTRLMODE]);
-		if (cm->flags & ~priv->ctrlmode_supported)
+
+		/* check whether changed bits are allowed to be modified */
+		if (cm->mask & ~priv->ctrlmode_supported)
  			return -EOPNOTSUPP;
+
+		/* clear bits to be modified and copy the flag values */
  		priv->ctrlmode &= ~cm->mask;
-		priv->ctrlmode |= cm->flags;
+		priv->ctrlmode |= (cm->flags & cm->mask);

  		/* CAN_CTRLMODE_FD can only be set when driver supports FD */
  		if (priv->ctrlmode & CAN_CTRLMODE_FD)



