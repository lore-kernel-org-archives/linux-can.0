From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 4/4] can: mcp251x: Get rid of legacy platform data
Date: Tue, 3 Sep 2019 18:22:31 +0300
Message-ID: <20190903152231.GY2680@smile.fi.intel.com>
References: <20190903124259.60920-1-andriy.shevchenko@linux.intel.com>
 <20190903124259.60920-5-andriy.shevchenko@linux.intel.com>
 <dc494f9a-0de3-5beb-bcbf-adbfb4813761@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dc494f9a-0de3-5beb-bcbf-adbfb4813761@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
List-Id: linux-can.vger.kernel.org

On Tue, Sep 03, 2019 at 03:17:11PM +0200, Marc Kleine-Budde wrote:
> On 9/3/19 2:42 PM, Andy Shevchenko wrote:
> > Instead of using legacy platform data, switch to use device properties.
> > For clock frequency we are using well established clock-frequency property.
> > 
> > Users, two for now, are also converted here.
> 
> I've removed this section already in this patch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?h=linux-can-next-for-5.4-20190903&id=f6cae800bfdb6711f0d45af98643a944998be6f2
> 
> ...I've dropped that hunk.

Awesome, thanks!

-- 
With Best Regards,
Andy Shevchenko
