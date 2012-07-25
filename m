From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 1/4] can: c_can: Add device tree support to Bosch
 C_CAN/D_CAN controller
Date: Wed, 25 Jul 2012 10:06:01 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA03290@DBDE01.ent.ti.com>
References: <1343197417-27481-1-git-send-email-anilkumar@ti.com>
 <1343197417-27481-2-git-send-email-anilkumar@ti.com>
 <500FBB48.60005@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59436 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab2GYKGb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Jul 2012 06:06:31 -0400
In-Reply-To: <500FBB48.60005@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

On Wed, Jul 25, 2012 at 14:54:24, Marc Kleine-Budde wrote:
> On 07/25/2012 08:23 AM, AnilKumar Ch wrote:
> > Add device tree support to C_CAN/D_CAN controller and usage details
> > are added to device tree documentation. Driver was tested on AM335x
> > EVM.
> 
> AFAIK you should add devicetree-discuss@lists.ozlabs.org on Cc for DT
> related patches. More comments inline.

I will take care in v2

> 
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  .../devicetree/bindings/net/can/c_can.txt          |   38 ++++++++++++++
> >  drivers/net/can/c_can/c_can_platform.c             |   52 ++++++++++++++------
> >  2 files changed, 75 insertions(+), 15 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/can/c_can.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
> > new file mode 100644
> > index 0000000..78b8ae8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/can/c_can.txt
> > @@ -0,0 +1,38 @@
> > +Bosch C_CAN/D_CAN controller Device Tree Bindings
> > +-------------------------------------------------
> > +
> > +Required properties:
> > +- compatible		: Should be "bosch,c_can_platform" or "bosch,c_can"
> > +			  for C_CAN controllers and "bosch,d_can" for D_CAN
> > +			  controllers.
> > +- reg			: physical base address and size of the C_CAN/D_CAN
> > +			  registers map
> > +- interrupts		: property with a value describing the interrupt
> > +			  number
> > +- interrupt-parent	: The parent interrupt controller
> > +
> > +Optional properties:
> > +- ti,hwmods		: Must be "d_can<n>" or "c_can<n>", n being the
> > +			  instance number
> > +
> > +Note: "ti,hwmods" field is used to fetch the base address and irq
> > +resources from TI, omap hwmod data base during device registration.
> > +Future plan is to migrate hwmod data base contents into device tree
> > +blob so that, all the required data will be used from device tree dts
> > +file.
> > +
> > +Examples:
> > +
> > +	d_can@481D0000 {
> > +		compatible = "bosch,d_can";
> > +		reg = <0x481D0000 0x1000>;
> > +		interrupts = <55 0x4>;
> > +		interrupt-parent = <&intc>;
> > +	};
> > +
> > +(or)
> > +
> > +	d_can@481D0000 {
> > +		compatible = "bosch,d_can";
> > +		ti,hwmods = "d_can1";
> > +	};
> > diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
> > index 6ff7ad0..2f5b153 100644
> > --- a/drivers/net/can/c_can/c_can_platform.c
> > +++ b/drivers/net/can/c_can/c_can_platform.c
> > @@ -30,6 +30,8 @@
> >  #include <linux/io.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/clk.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> >  
> >  #include <linux/can/dev.h>
> >  
> > @@ -65,17 +67,51 @@ static void c_can_plat_write_reg_aligned_to_32bit(struct c_can_priv *priv,
> >  	writew(val, priv->base + 2 * priv->regs[index]);
> >  }
> >  
> > +static struct platform_device_id c_can_id_table[] = {
> > +	{
> > +		.name = KBUILD_MODNAME,
> > +		.driver_data = C_CAN_DEVTYPE,
> > +	}, {
> > +		.name = "c_can",
> > +		.driver_data = C_CAN_DEVTYPE,
> > +	}, {
> > +		.name = "d_can",
> > +		.driver_data = D_CAN_DEVTYPE,
> > +	}, {
> > +	}
> > +};
> > +
> > +static const struct of_device_id c_can_of_table[] = {
> > +	{ .compatible = "bosch,c_can_platform", .data = &c_can_id_table[0] },
> 
> Please don't add the "legacy bosch,c_can_platform" to the device tree

I will remove this from DT bindings.

> bindings. I personally would appreciate if you introduce an enum as
> array index (BOSCH_C_CAN_PLATFORM, BOSCH_C_CAN, BOSCH_D_CAN) and
> initialize the c_can_id_table above using the array indexes, then you
> can use these indexes here too.

What about having the same enum for devtype and index like

enum c_can_dev_id {
	BOSCH_C_CAN_PLATFORM,
	BOSCH_C_CAN,
	BOSCH_D_CAN,
};

static struct platform_device_id c_can_id_table[] = {
	[BOSCH_C_CAN_PLATFORM] = {
		.name = KBUILD_MODNAME,
		.driver_data = BOSCH_C_CAN,
	},
};

Regards
AnilKumar