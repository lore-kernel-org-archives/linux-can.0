From: John Whitmore <arigead@gmail.com>
Subject: Re: [PATCH] mcp251x: mcp2515 stops receiving
Date: Thu, 22 May 2014 00:53:47 +0100
Message-ID: <20140521235346.GA15375@griso.site>
References: <2E9F00CBB66AB544A1ACDC59627518BA0DC7ED11@mailserver>
 <5370FE36.8020901@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36827 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbaEUXxU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 May 2014 19:53:20 -0400
Received: by mail-wi0-f169.google.com with SMTP id hi2so9164674wib.0
        for <linux-can@vger.kernel.org>; Wed, 21 May 2014 16:53:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5370FE36.8020901@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Rost, Martin" <Martin.Rost@tonfunk.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Alexander Shiyan <shc_work@mail.ru>

On Mon, May 12, 2014 at 07:00:38PM +0200, Marc Kleine-Budde wrote:
> Hey Martin,
> 
> On 05/08/2014 08:33 AM, Rost, Martin wrote:
> > The mcp2515 sometimes seems to trigger an interrupt with the
> > corresponding register not being set yet. This makes the driver exit
> > the interrupt because there is obviously nothing to do, but the
> > interrupt line is kept low. Therefore the driver does not see any
> > more interrupts until the chip is reset (via interface down/up).
> 
> Hmmmm, I think level triggered interrupt would help here. However not
> all interrupt controller support level interrupts and
> arch/arm/mach-pxa/icontrol.c sets the trigger to rising edge.
> 
> > This patch changes the IST to first check the IRQ registers, and wait
> > up to 10 ms if an event really occurrs. If the IRQ register is still
> > empty after 10ms, a kernel message gets issued.
> 
> What happens if the register is still empty after 10ms? Can we do
> something better than the print, which will probably not fix the probem...
> 
> > The IST loop is rearranged to evaluate the IRQ register at the last
> > moment before exiting, to not miss a late irq event.
> 
> Alexander, have you seen or heard of this problem before? What do you
> think about this workaround?
> 

I've had this problem before but with the MCP2515 connected to a Microchip
Microcontroller. I've been working on other stuff and just got back to looking
into this problem. Whilst it's not Linux based I was getting this exact
problem and was forced to poll the MCP2515 instead of managing it via
interrupts. Earlier today I got the best of both worlds by doing nothing in
the ISR other then setting a FLAG and clearing the interrupt. The Flag is then
picked up in the main processing loop of the code. It's a race condition and a
flaw in the MCP2515, in my opinion. 

I'm not an expert in the Linux Driver code nor the implemented fix but I can
confirm that the Interrupt is generated with no flags set. I'm not sure of the
10mS timing but I'd imagine that should work.



> > ---
> > diff --git "a/mcp251x.c" "b/mcp251x.c"
> > index ad58ac6..668ce63 100644
> > --- "a/mcp251x.c"	
> > +++ "b/mcp251x.c"	
> > @@ -806,15 +806,29 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
> >  	struct mcp251x_priv *priv = dev_id;
> >  	struct spi_device *spi = priv->spi;
> >  	struct net_device *net = priv->net;
> > +	u8 intf, eflag;
> > +	u8 retrycount = 10;
> >  
> >  	mutex_lock(&priv->mcp_lock);
> > -	while (!priv->force_quit) {
> > +	
> > +	do {
> > +	mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
> > +		if (!intf) {
> > +//			printk(KERN_CRIT "MCP251x: IRQ delaying.\r\n");
> 
> please remove that line
> 
> > +			mdelay(1);
> > +		}
> > +	} while (!intf && (retrycount--));
> > +	
> > +	if (!intf)
> > +		printk(KERN_CRIT "MCP251x: IRQ without a cause.\r\n");
> 
> In Linux, we use \n only, also dev_LEVEL() is preferred over plain printk.
> 
> > +	
> > +	while ((!priv->force_quit) && (intf)) {
> >  		enum can_state new_state;
> > -		u8 intf, eflag;
> > +//		u8 intf, eflag;
> 
> please remove, not comment out.
> 
> >  		u8 clear_intf = 0;
> >  		int can_id = 0, data1 = 0;
> >  
> > -		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
> > +//		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
> 
> same here
> 
> >  
> >  		/* mask out flags we don't care about */
> >  		intf &= CANINTF_RX | CANINTF_TX | CANINTF_ERR;
> > @@ -913,8 +927,8 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
> >  			}
> >  		}
> >  
> > -		if (intf == 0)
> > -			break;
> > +//		if (intf == 0)
> > +//			break;
> 
> same here
> 
> >  
> >  		if (intf & CANINTF_TX) {
> >  			net->stats.tx_packets++;
> > @@ -926,6 +940,7 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
> >  			netif_wake_queue(net);
> >  		}
> >  
> > +		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
> >  	}
> >  	mutex_unlock(&priv->mcp_lock);
> >  	return IRQ_HANDLED;
> 
> I'll send a cleaned version of you patch.
> 
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 


