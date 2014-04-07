From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 07 Apr 2014 17:36:04 +0200
Message-ID: <10077840.fz9L5lnEL0@ws-stein>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <1589068.2zsYHU9sGb@ws-stein> <alpine.DEB.2.02.1404071659360.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:60230 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754665AbaDGPhW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 11:37:22 -0400
In-Reply-To: <alpine.DEB.2.02.1404071659360.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Monday 07 April 2014 17:24:26, Thomas Gleixner wrote:
> On Mon, 7 Apr 2014, Alexander Stein wrote:
> > On Monday 07 April 2014 15:31:20, Thomas Gleixner wrote:
> > > What other patches do you have applied?
> > 
> > I have shrinked them a bit to the absolute necessity. In general
> > these are patches for the current hardware to make them working.
> 
> > 53b385c37e4eb155cf9d515913ddf76750e2ac24 c_can: Add support for eg20t (pch_can)
> 
> I can't see anything whats wrong with that one.
> 
> Can you check, whether the following check in c_can_read_objects()
> 
>                if (!(ctrl & IF_MCONT_NEWDAT))
>                         continue;
> 
> ever triggers?
> 
> It'd be odd, because we get the buffers with the NEWDAT pending bits
> from the NEWDATA1 register.

Using the following patch the warning raises about every 5ms. With and without your last patchset.
Being based on linux-can-fixes-for-3.15-20140401 + my patchset:
> fcbd69d2d869cb0c55c035d36cd6795251fd01da c_can_pci: enable PCI bus master only for MSI
> 53b385c37e4eb155cf9d515913ddf76750e2ac24 c_can: Add support for eg20t (pch_can)
> 95bf9c0f276925e401ac7d3c6ff47185b9badd2f pch_gbe: remove shutdown and restart of interface after PHY settings change
> 7229aafbce39e22c82544d7021dccd6b0c23f881 pch_gbe: reset PHY before first configuration
> 9fd3c55d07a41bc18931ec6a51176cbf667dbe21 pch_gbe: remove unnecessary PHY resets
> c80898c56b575baa1ce2dcfbcaa6c654194f5cf8 pch_gbe: change order of PHY address discovering
> c97bfddb0cf93c3ca0cb79490ab602b4ab24a740 pch_gbe: Add module parameter for RGMII/GMII PHY mode selection
> f09f76391c8a90814fd78cfced35fceb616ea7e3 pch_gbe: print invalid MAC address during probe
> 14ab44191d17390be4fa2683092b8913a8b34a17 i2c-eg20t: Try to add busses starting from bus number 1

but reverting c0a9f4d39 this does _NOT_ arise.

Regards,
Alexander

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 0e9f974..1a76565 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -836,8 +836,10 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 		 * odd HW behaviour. Do not remove that unless you
 		 * want to brick your machine.
 		 */
-		if (!(ctrl & IF_MCONT_NEWDAT))
+		if (!(ctrl & IF_MCONT_NEWDAT)) {
+			netdev_warn(dev, "Odd behavior");
 			continue;
+		}
 
 		/* read the data from the message object */
 		c_can_read_msg_object(dev, IF_RX, ctrl);

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

