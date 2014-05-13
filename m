From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCHv2] Fix CAN on socfpga, for net/master
Date: Tue, 13 May 2014 14:07:53 +0200
Message-ID: <20140513120753.GB8635@amd.pavel.ucw.cz>
References: <6bf951b6-51e7-4b90-b054-9ba5b6e93874@email.android.com>
 <20140427122510.GB12901@amd.pavel.ucw.cz>
 <1398716449.836.4.camel@dinh-ubuntu>
 <20140428211505.GA28242@amd.pavel.ucw.cz>
 <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
 <20140430215359.GA15148@amd.pavel.ucw.cz>
 <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
 <20140502084851.GA5730@amd.pavel.ucw.cz>
 <53638F17.6000702@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50310 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759892AbaEMMHz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 May 2014 08:07:55 -0400
Content-Disposition: inline
In-Reply-To: <53638F17.6000702@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Thor Thayer <tthayer.linux@gmail.com>, Thor Thayer <tthayer@altera.com>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com

Hi!

> Please split into several patches:
> - add 32 bit accessor functions
>   and replace two 16 bit accesses by a single 32 bit access
> - if-DCAN-then-32bit access
>   please explain in the commit message why this is needed
> - add hwinit support for non ti devices

> > @@ -88,7 +89,8 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
> >  	spin_lock(&raminit_lock);
> >  
> >  	ctrl = readl(priv->raminit_ctrlreg);
> > -	/* We clear the done and start bit first. The start bit is
> > +	/*
> > +	 * We clear the done and start bit first. The start bit is
> 
> Please don't change the commenting style.

Ok.

> > +static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
> > +{
> > +	u32 ctrl;
> > +
> > +	spin_lock(&raminit_lock);
> > +
> > +	ctrl = readl(priv->raminit_ctrlreg);
> 
> As far as I can see raminit_ctrlreg is in this case a non shared
> resource, so you don't need any spinlock. Also you don't need to use
> raminit_ctrlreg, as it is C_CAN_FUNCTION_REG.

I was adapting existing code which had the raminit paths shared. Will
remove the spinlock.

And yes, I can replace it with priv->read_... , but it will result in
some churn of consts...

> > +static void c_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
> > +		u32 val)
> > +{
> > +	priv->write_reg(priv, index + 1, val>>16);
>                                            ^  ^
> 
> Please add spaces around the >>

Sorry about that.

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
