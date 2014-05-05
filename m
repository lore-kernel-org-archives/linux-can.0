From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH 1/2] hwinit support for non-TI devices
Date: Mon, 5 May 2014 15:00:21 +0200
Message-ID: <20140505130021.GD16649@amd.pavel.ucw.cz>
References: <20140427122510.GB12901@amd.pavel.ucw.cz>
 <1398716449.836.4.camel@dinh-ubuntu>
 <20140428211505.GA28242@amd.pavel.ucw.cz>
 <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
 <20140430215359.GA15148@amd.pavel.ucw.cz>
 <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
 <20140502084851.GA5730@amd.pavel.ucw.cz>
 <20140505120810.GB16461@amd.pavel.ucw.cz>
 <5367824D.2070406@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34193 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216AbaEENAW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 May 2014 09:00:22 -0400
Content-Disposition: inline
In-Reply-To: <5367824D.2070406@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Thor Thayer <tthayer.linux@gmail.com>, Thor Thayer <tthayer@altera.com>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com

> > +
> > +	ctrl = readl(priv->raminit_ctrlreg);
> > +	ctrl &= ~DCAN_RAM_INIT_BIT;
> > +	writel(ctrl, priv->raminit_ctrlreg);
> 
> Why don't use use the reg directly? Have you read my previous
> review?

Not really. I did not notice that there are more comments below all
that quoted text. Standby.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
