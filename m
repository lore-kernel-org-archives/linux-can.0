From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 2/3] can: at91_can: add pinctrl support
Date: Fri, 8 Mar 2013 19:46:48 +0100
Message-ID: <20130308184648.GE4590@game.jcrosoft.org>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
 <1362763842-14924-3-git-send-email-ludovic.desroches@atmel.com>
 <513A21E4.6000801@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <513A21E4.6000801@pengutronix.de>
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
Cc: devicetree-discuss@lists.ozlabs.org, ludovic.desroches@atmel.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 18:37 Fri 08 Mar     , Marc Kleine-Budde wrote:
> On 03/08/2013 06:30 PM, ludovic.desroches@atmel.com wrote:
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >  drivers/net/can/at91_can.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> > index c7f70d4..56fb2aa 100644
> > --- a/drivers/net/can/at91_can.c
> > +++ b/drivers/net/can/at91_can.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/module.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/of.h>
> > +#include <linux/pinctrl/consumer.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/rtnetlink.h>
> >  #include <linux/skbuff.h>
> > @@ -1292,6 +1293,7 @@ static int at91_can_probe(struct platform_device *pdev)
> >  	struct clk *clk;
> >  	void __iomem *addr;
> >  	int err, irq;
> > +	struct pinctrl *pinctrl;
> >  
> >  	devtype_data = at91_can_get_driver_data(pdev);
> >  	if (!devtype_data) {
> > @@ -1314,6 +1316,13 @@ static int at91_can_probe(struct platform_device *pdev)
> >  		goto exit_put;
> >  	}
> >  
> > +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> 
> Is this still needed? I think the pinctrl framework automatically
> enables the default pinctrl for a device if available.
yes this is useless

Best Regards,
J.
> 
> Marc
> 
> > +	if (IS_ERR(pinctrl)) {
> > +		dev_err(&pdev->dev, "Failed to request pinctrl\n");
> > +		err = PTR_ERR(pinctrl);
> > +		goto exit_put;
> > +	}
> > +
> >  	if (!request_mem_region(res->start,
> >  				resource_size(res),
> >  				pdev->name)) {
> > 
> 
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
