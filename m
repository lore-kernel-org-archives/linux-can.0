From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v4 3/3] can: c_can: Add runtime PM support to Bosch
 C_CAN/D_CAN controller
Date: Mon, 6 Aug 2012 06:48:32 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA85CC3@DBDE01.ent.ti.com>
References: <1343913191-14722-1-git-send-email-anilkumar@ti.com>
 <1343913191-14722-4-git-send-email-anilkumar@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA7F150@DBDE01.ent.ti.com>
 <501C21E5.9080106@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53571 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab2HFGst convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Aug 2012 02:48:49 -0400
In-Reply-To: <501C21E5.9080106@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Gole, Anant" <anantgole@ti.com>

On Sat, Aug 04, 2012 at 00:39:25, Marc Kleine-Budde wrote:
> On 08/03/2012 08:32 AM, Hiremath, Vaibhav wrote:
> > On Thu, Aug 02, 2012 at 18:43:11, AnilKumar, Chimata wrote:
> >> Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
> >> APIs control clocks for C_CAN/D_CAN IP and prevent access to the
> >> register of C_CAN/D_CAN IP when clock is turned off.
> >>
> >> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> >> ---
> >>  drivers/net/can/c_can/c_can_platform.c |    8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
> >> index d0a66cf..83a1e17 100644
> >> --- a/drivers/net/can/c_can/c_can_platform.c
> >> +++ b/drivers/net/can/c_can/c_can_platform.c
> >> @@ -32,6 +32,7 @@
> >>  #include <linux/clk.h>
> >>  #include <linux/of.h>
> >>  #include <linux/of_device.h>
> >> +#include <linux/pm_runtime.h>
> >>  
> >>  #include <linux/can/dev.h>
> >>  
> >> @@ -177,6 +178,9 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
> >>  		goto exit_free_device;
> >>  	}
> >>  
> >> +	pm_runtime_enable(&pdev->dev);
> >> +	pm_runtime_get_sync(&pdev->dev);
> >> +
> > 
> > If module is inserted or built into the kernel, module stays in enabled 
> > state always, isn't that wrong?
> > Ideally, you should enable the module when it is required or being used.
> 
> Good point.
> 
> If you don't access the module's registers in the probe- (or its
> subroutines) it should be enough to enable the module in the open()
> function. Have a look at clk_prepare_enable / clk_disable_unprepare in
> the flexcan driver.
> 

Yeah Marc, something similar, above runtime pm api's should be moved to 
open-n-close.

Thanks,
Vaibhav

> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
> 

