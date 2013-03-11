From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] can: at91_can: add dt support
Date: Mon, 11 Mar 2013 10:17:22 +0100
Message-ID: <18373.5904204243$1362993491@news.gmane.org>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
 <1362763842-14924-2-git-send-email-ludovic.desroches@atmel.com>
 <513A2365.5050803@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <513A2365.5050803-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-can.vger.kernel.org

On Fri, Mar 08, 2013 at 06:44:05PM +0100, Marc Kleine-Budde wrote:
> On 03/08/2013 06:30 PM, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
> > From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> > 
> > Add device tree support.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> > ---
> >  .../devicetree/bindings/net/can/atmel-can.txt      | 14 ++++
> >  drivers/net/can/at91_can.c                         | 75 ++++++++++++++++------
> >  2 files changed, 70 insertions(+), 19 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/can/atmel-can.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/atmel-can.txt b/Documentation/devicetree/bindings/net/can/atmel-can.txt
> > new file mode 100644
> > index 0000000..69381db
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/can/atmel-can.txt
> > @@ -0,0 +1,14 @@
> > +* AT91 CAN *
> > +
> > +Required properties:
> > +  - compatible: Should be "atmel,at91sam9263-can" or "atmel,at91sam9x5-can"
> 
> On imx we use the oldest SoC with that IP available. Which strategy are
> you following on at91?
> 

We are using the same strategy.

> > +  - reg: Should contain RTC registers location and length
> 
> RTC?
> 

My mistake, I'll correct that, bad copy-paste.

> > +  - interrupts: Should contain IRQ line for the CAN controller
> > +
> > +Example:
> > +
> > +	can0: can@f000c000 {
> > +		compatbile = "atmel,at91sam9x5-can";
> > +		reg = <0xf000c000 0x300>;
> > +		interrupts = <40 4 5>
> > +	};
> > diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> > index 44f3637..c7f70d4 100644
> > --- a/drivers/net/can/at91_can.c
> > +++ b/drivers/net/can/at91_can.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/netdevice.h>
> > +#include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/rtnetlink.h>
> >  #include <linux/skbuff.h>
> > @@ -155,19 +156,20 @@ struct at91_priv {
> >  	canid_t mb0_id;
> >  };
> >  
> > -static const struct at91_devtype_data at91_devtype_data[] = {
> > -	[AT91_DEVTYPE_SAM9263] = {
> > -		.rx_first = 1,
> > -		.rx_split = 8,
> > -		.rx_last = 11,
> > -		.tx_shift = 2,
> > -	},
> > -	[AT91_DEVTYPE_SAM9X5] = {
> > -		.rx_first = 0,
> > -		.rx_split = 4,
> > -		.rx_last = 5,
> > -		.tx_shift = 1,
> > -	},
> > +static struct at91_devtype_data at91_at91sam9263_data = {
> > +	.rx_first = 1,
> > +	.rx_split = 8,
> > +	.rx_last = 11,
> > +	.tx_shift = 2,
> > +	.type = AT91_DEVTYPE_SAM9263
> 
> nitpick:
> can you add a trailing ","
> 
> > +};
> > +
> > +static struct at91_devtype_data at91_at91sam9x5_data = {
> > +	.rx_first = 0,
> > +	.rx_split = 4,
> > +	.rx_last = 5,
> > +	.tx_shift = 1,
> > +	.type = AT91_DEVTYPE_SAM9X5
> 
> dito
> 

ok

> >  };
> >  
> >  static const struct can_bittiming_const at91_bittiming_const = {
> > @@ -1249,10 +1251,41 @@ static struct attribute_group at91_sysfs_attr_group = {
> >  	.attrs = at91_sysfs_attrs,
> >  };
> >  
> > +#if defined(CONFIG_OF)
> > +static const struct of_device_id at91_can_dt_ids[] = {
> > +	{
> > +		.compatible = "atmel,at91sam9x5-can",
> > +		.data = &at91_at91sam9x5_data,
> > +	}, {
> > +		.compatible = "atmel,at91sam9263-can",
> > +		.data = &at91_at91sam9263_data,
> > +	}, {
> > +		/* sentinel */
> > +	}
> > +};
> > +MODULE_DEVICE_TABLE(of, at91_can_dt_ids);
> > +#else
> > +#define at91_can_dt_ids NULL
> > +#endif
> > +
> > +static struct at91_devtype_data* at91_can_get_driver_data(
> > +						struct platform_device *pdev)
> 
> I think it's okay to put this into one line.
> 

ok

> > +{
> > +	if (pdev->dev.of_node) {
> > +		const struct of_device_id *match;
> > +		match = of_match_node(at91_can_dt_ids, pdev->dev.of_node);
> > +		if (!match) {
> > +			dev_err(&pdev->dev, "no matching node found in dtb\n");
> > +			return NULL;
> > +		}
> > +		return (struct at91_devtype_data *)match->data;
> > +	}
> > +	return (struct at91_devtype_data *)platform_get_device_id(pdev)->driver_data;
> > +}
> > +
> >  static int at91_can_probe(struct platform_device *pdev)
> >  {
> >  	const struct at91_devtype_data *devtype_data;
> > -	enum at91_devtype devtype;
> >  	struct net_device *dev;
> >  	struct at91_priv *priv;
> >  	struct resource *res;
> > @@ -1260,8 +1293,12 @@ static int at91_can_probe(struct platform_device *pdev)
> >  	void __iomem *addr;
> >  	int err, irq;
> >  
> > -	devtype = pdev->id_entry->driver_data;
> > -	devtype_data = &at91_devtype_data[devtype];
> > +	devtype_data = at91_can_get_driver_data(pdev);
> > +	if (!devtype_data) {
> > +		dev_err(&pdev->dev, "no driver data\n");
> > +		err = -ENODEV;
> > +		goto exit;
> > +	}
> >  
> >  	clk = clk_get(&pdev->dev, "can_clk");
> >  	if (IS_ERR(clk)) {
> > @@ -1310,7 +1347,6 @@ static int at91_can_probe(struct platform_device *pdev)
> >  	priv->dev = dev;
> >  	priv->reg_base = addr;
> >  	priv->devtype_data = *devtype_data;
> > -	priv->devtype_data.type = devtype;
> >  	priv->clk = clk;
> >  	priv->pdata = pdev->dev.platform_data;
> >  	priv->mb0_id = 0x7ff;
> > @@ -1373,10 +1409,10 @@ static int at91_can_remove(struct platform_device *pdev)
> >  static const struct platform_device_id at91_can_id_table[] = {
> >  	{
> >  		.name = "at91_can",
> > -		.driver_data = AT91_DEVTYPE_SAM9263,
> > +		.driver_data = (unsigned long)&at91_at91sam9x5_data,
> >  	}, {
> >  		.name = "at91sam9x5_can",
> > -		.driver_data = AT91_DEVTYPE_SAM9X5,
> > +		.driver_data = (unsigned long)&at91_at91sam9263_data,
> >  	}, {
> >  		/* sentinel */
> >  	}
> > @@ -1389,6 +1425,7 @@ static struct platform_driver at91_can_driver = {
> >  	.driver = {
> >  		.name = KBUILD_MODNAME,
> >  		.owner = THIS_MODULE,
> > +		.of_match_table = at91_can_dt_ids,
> >  	},
> >  	.id_table = at91_can_id_table,
> >  };
> 
> Marc

Thanks for your feedback

Regards

Ludovic
