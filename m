From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH] can: c_can: fix segfault during rmmod
Date: Thu, 27 Sep 2012 11:22:17 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA3CD18@DBDE01.ent.ti.com>
References: <1348742499-6526-1-git-send-email-anilkumar@ti.com>
 <5064347C.3020706@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38625 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab2I0LW2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Sep 2012 07:22:28 -0400
In-Reply-To: <5064347C.3020706@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

Hi Marc,

On Thu, Sep 27, 2012 at 16:41:56, Marc Kleine-Budde wrote:
> On 09/27/2012 12:41 PM, AnilKumar Ch wrote:
> > This patch fixes an oops which occurs during unloading the driver. The
> > problem is that clock is not enabled during unregister_c_can_dev()
> > which does c_can/d_can module interrupts enable/disable.
> 
> Looking at the code, I see that
>     c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
> is called during c_can_stop().
> 
> This should be sufficient as during unregister_netdev() the driver's
> close function will be called (it the netdev is still opened) [1].
> 
> I think your patch
>     4cdd34b can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN controller
> has not reached the David's net branch, so I prefer to remove the
> offending:
>     c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
> call from the unregister_c_can_dev().
> 

The moment I clicked the send button I thought this, I will send a new
patch by removing that line.

Thanks
AnilKumar 
