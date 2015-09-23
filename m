From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: can: Allwinner A10/A20 CAN Controller support - Kernel module
Date: Wed, 23 Sep 2015 10:19:44 +0300
Message-ID: <20150923071944.GA28834@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:49487 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbbIWHT5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2015 03:19:57 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: info@gerhard-bertelsmann.de
Cc: linux-can@vger.kernel.org

Hello Gerhard Bertelsmann,

The patch 0738eff14d81: "can: Allwinner A10/A20 CAN Controller
support - Kernel module" from Sep 16, 2015, leads to the following
static checker warning:

	drivers/net/can/sun4i_can.c:604 sun4i_can_err()
	warn: mask and shift to zero

drivers/net/can/sun4i_can.c
   596          if (isrc & SUN4I_INT_ARB_LOST) {
   597                  /* arbitration lost interrupt */
   598                  netdev_dbg(dev, "arbitration lost interrupt\n");
   599                  alc = readl(priv->base + SUN4I_REG_STA_ADDR);
   600                  priv->can.can_stats.arbitration_lost++;
   601                  stats->tx_errors++;
   602                  if (likely(skb)) {
   603                          cf->can_id |= CAN_ERR_LOSTARB;
   604                          cf->data[0] = (alc & 0x1f) >> 8;
                                              ^^^^^^^^^^^^^^^^^^
This is zero.  No idea what was intended.

   605                  }
   606          }

regards,
dan carpenter
