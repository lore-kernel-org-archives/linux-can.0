From: Luis Henriques <luis.henriques@canonical.com>
Subject: Re: request to queue "9b3d423 ARM: i.MX6q: fix the wrong parent of
 can_root clock" for stable
Date: Thu, 28 Nov 2013 14:50:11 +0000
Message-ID: <20131128145011.GC3344@hercules.my.domain>
References: <529719C1.7030402@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <529719C1.7030402@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: stable@vger.kernel.org, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Jiada Wang <jiada_wang@mentor.com>
List-Id: linux-can.vger.kernel.org

On Thu, Nov 28, 2013 at 11:24:01AM +0100, Marc Kleine-Budde wrote:
> Hello Greg,
> 
> can you please queue
> 
>     9b3d423 ARM: i.MX6q: fix the wrong parent of can_root clock
> 
> for the stable trees.
> 
> This patch (and another, which is not yet upstream) is needed for
> flexcan on mx6 to work properly.

Thanks Marc, I'm queuing this patch for the 3.5 kernel as well.

Cheers,
--
Luis
