From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 07 Apr 2014 14:48:54 +0200
Message-ID: <3160314.uNhSqa4Py1@ws-stein>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <2082533.2A1719KrNC@ws-stein> <alpine.DEB.2.02.1404071433000.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:56126 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754945AbaDGMuH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 08:50:07 -0400
In-Reply-To: <alpine.DEB.2.02.1404071433000.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

Hello Thomas,

On Monday 07 April 2014 14:34:17, Thomas Gleixner wrote:
> > I'm currently trying to locate problem causes. Using your new set of patches on the tag linux-can-fixes-for-3.15-20140401 I lot of lost messages.
> > Using bisect it seems that c0a9f4d39 "can: c_can: Reduce register access" introduced this problem on my hardware. Before that I only see switched messages occasionally.
> > 
> 
> Does the last patch which disables the RX buffer split still have that
> issue?

Regardless of CAN_C_CAN_STRICT_FRAME_ORDERING I'm still losing messages.
BTW: I need the following patch to be able to use CAN_C_CAN_STRICT_FRAME_ORDERING:

Regards,
Alexander

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index acdc24c..0e9f974 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -799,7 +799,7 @@ static inline void c_can_rx_object_get(struct net_device *dev, u32 obj)
 		c_can_object_get(dev, IF_RX, obj, IF_COMM_RCV_HIGH);
 }
 
-static inline void c_can_rx_finalize(struct c_can_priv *priv, u32 obj)
+static inline void c_can_rx_finalize(struct net_device *dev, struct c_can_priv *priv, u32 obj)
 {
 #ifdef CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING
 	if (obj < C_CAN_MSG_RX_LOW_LAST)
@@ -842,7 +842,7 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 		/* read the data from the message object */
 		c_can_read_msg_object(dev, IF_RX, ctrl);
 
-		c_can_rx_finalize(priv, obj);
+		c_can_rx_finalize(dev, priv, obj);
 
 		pkts++;
 		quota--;
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

