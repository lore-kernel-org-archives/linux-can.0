From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/4] can: mcp251x: Make use of device properties
Date: Tue, 3 Sep 2019 16:02:27 +0300
Message-ID: <20190903130227.GX2680@smile.fi.intel.com>
References: <20190903124259.60920-1-andriy.shevchenko@linux.intel.com>
 <9ba9d56b-c045-74d3-9693-a9a959ffb675@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9ba9d56b-c045-74d3-9693-a9a959ffb675@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Tue, Sep 03, 2019 at 02:50:05PM +0200, Marc Kleine-Budde wrote:
> On 9/3/19 2:42 PM, Andy Shevchenko wrote:
> > The purpose of this series is to simplify driver by switching to use device
> > properties. In particular it allows to drop legacy platform data.
> > 
> > Patch 1 switches driver to use devm_clk_get_optional() API.
> > 
> > Patch 2 unifies getting the driver data independently of the table which
> > provides it.
> > 
> > Patch 3 drops extra check for regulator presence by switch to use an already
> > present wrapper.
> > 
> > And patch 4 gets rid of legacy platform data.
> > 
> > Changelog v2:
> > - add patch 4 to get rid of legacy platform data
> 
> Sorry for not telling, your v1 series has already been applied and it's
> included in the latest pull request. Can you please rebase your patches
> on top of:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/tag/?h=linux-can-next-for-5.4-20190903


Thank you!

Basically first 3 patches didn't change. Consider patch 4 only. Should I resend
it separately as v3?

-- 
With Best Regards,
Andy Shevchenko
