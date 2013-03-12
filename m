From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2 1/2] can: at91_can: add dt support
Date: Tue, 12 Mar 2013 08:45:06 +0100
Message-ID: <42886.3010173247$1363074380@news.gmane.org>
References: <1363022764-7647-1-git-send-email-ludovic.desroches@atmel.com>
 <513E1523.4010803@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <513E1523.4010803@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: plagnioj@jcrosoft.com, devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Mon, Mar 11, 2013 at 06:32:19PM +0100, Marc Kleine-Budde wrote:
> On 03/11/2013 06:26 PM, ludovic.desroches@atmel.com wrote:
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> > 
> > Add device tree support.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> > Changes in v2:
> > - code cleanup
> > - correct typo
> > 
> >  .../devicetree/bindings/net/can/atmel-can.txt      | 14 ++++
> >  drivers/net/can/at91_can.c                         | 74 ++++++++++++++++------
> >  2 files changed, 69 insertions(+), 19 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/can/atmel-can.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/atmel-can.txt b/Documentation/devicetree/bindings/net/can/atmel-can.txt
> > new file mode 100644
> > index 0000000..72cf0c5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/can/atmel-can.txt
> > @@ -0,0 +1,14 @@
> > +* AT91 CAN *
> > +
> > +Required properties:
> > +  - compatible: Should be "atmel,at91sam9263-can" or "atmel,at91sam9x5-can"
> > +  - reg: Should contain CAN controller registers location and length
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
> > index 44f3637..8c113f5 100644
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
> > +	.type = AT91_DEVTYPE_SAM9263,
> > +};
> > +
> > +static struct at91_devtype_data at91_at91sam9x5_data = {
> > +	.rx_first = 0,
> > +	.rx_split = 4,
> > +	.rx_last = 5,
> > +	.tx_shift = 1,
> > +	.type = AT91_DEVTYPE_SAM9X5,
> >  };
> >  
> >  static const struct can_bittiming_const at91_bittiming_const = {
> > @@ -1249,10 +1251,40 @@ static struct attribute_group at91_sysfs_attr_group = {
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
> > +static struct at91_devtype_data* at91_can_get_driver_data(struct platform_device *pdev)
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
> > @@ -1260,8 +1292,12 @@ static int at91_can_probe(struct platform_device *pdev)
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
> > @@ -1310,7 +1346,6 @@ static int at91_can_probe(struct platform_device *pdev)
> >  	priv->dev = dev;
> >  	priv->reg_base = addr;
> >  	priv->devtype_data = *devtype_data;
> > -	priv->devtype_data.type = devtype;
> >  	priv->clk = clk;
> >  	priv->pdata = pdev->dev.platform_data;
> >  	priv->mb0_id = 0x7ff;
> > @@ -1373,10 +1408,10 @@ static int at91_can_remove(struct platform_device *pdev)
> >  static const struct platform_device_id at91_can_id_table[] = {
> >  	{
> >  		.name = "at91_can",
> > -		.driver_data = AT91_DEVTYPE_SAM9263,
> > +		.driver_data = (unsigned long)&at91_at91sam9x5_data,
> >  	}, {
> >  		.name = "at91sam9x5_can",
> > -		.driver_data = AT91_DEVTYPE_SAM9X5,
> > +		.driver_data = (unsigned long)&at91_at91sam9263_data,
> 
> It's a kernel_ulong_t, not a (unsigned long), I can fix this while
> applying the patch.
> 

Ok I let you fix it while applying so.

Thanks Marc.

Regards

Ludovic

> >  	}, {
> >  		/* sentinel */
> >  	}
> > @@ -1389,6 +1424,7 @@ static struct platform_driver at91_can_driver = {
> >  	.driver = {
> >  		.name = KBUILD_MODNAME,
> >  		.owner = THIS_MODULE,
> > +		.of_match_table = at91_can_dt_ids,
> >  	},
> >  	.id_table = at91_can_id_table,
> >  };
> > 
> 
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
