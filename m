From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: re: can: Allwinner A10/A20 CAN Controller support - Kernel module
Date: Wed, 23 Sep 2015 09:51:28 +0200
Message-ID: <34a8301812e4b25545b9c0f13d1cd80f@mail.rdts.de>
References: <20150923071944.GA28834@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:43292 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595AbbIWHvb (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 23 Sep 2015 03:51:31 -0400
In-Reply-To: <20150923071944.GA28834@mwanda>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-can@vger.kernel.org, linux-can-owner@vger.kernel.org

Hi Dan,

Am 2015-09-23 09:19, schrieb Dan Carpenter:
> Hello Gerhard Bertelsmann,
> 
> The patch 0738eff14d81: "can: Allwinner A10/A20 CAN Controller
> support - Kernel module" from Sep 16, 2015, leads to the following
> static checker warning:
> 
> 	drivers/net/can/sun4i_can.c:604 sun4i_can_err()
> 	warn: mask and shift to zero
> 
> drivers/net/can/sun4i_can.c
>    596          if (isrc & SUN4I_INT_ARB_LOST) {
>    597                  /* arbitration lost interrupt */
>    598                  netdev_dbg(dev, "arbitration lost 
> interrupt\n");
>    599                  alc = readl(priv->base + SUN4I_REG_STA_ADDR);
>    600                  priv->can.can_stats.arbitration_lost++;
>    601                  stats->tx_errors++;
>    602                  if (likely(skb)) {
>    603                          cf->can_id |= CAN_ERR_LOSTARB;
>    604                          cf->data[0] = (alc & 0x1f) >> 8;
>                                               ^^^^^^^^^^^^^^^^^^
> This is zero.  No idea what was intended.

indeed, that's wrong - mask should be 0x1f00.
I will send an update. Thanks for your hint.

> 
>    605                  }
>    606          }
> 
> regards,
> dan carpenter

Regards,

Gerd
