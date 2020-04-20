From: Dejin Zheng <zhengdejin5@gmail.com>
Subject: Re: [net-next v2] can: ti_hecc: convert to
 devm_platform_ioremap_resource_byname()
Date: Mon, 20 Apr 2020 22:19:21 +0800
Message-ID: <20200420141921.GA10880@nuc8i5>
References: <20200420132207.8536-1-zhengdejin5@gmail.com>
 <940fcaa1-8500-e534-2380-39419f1ac5a0@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <940fcaa1-8500-e534-2380-39419f1ac5a0@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
List-Id: linux-can.vger.kernel.org

On Mon, Apr 20, 2020 at 04:00:54PM +0200, Markus Elfring wrote:
> > v1 -> v2:
> > 	- modify the commit comments by Markus's suggestion.
> 
> Thanks for another wording fine-tuning.
> 
> Would you like to extend your adjustment interests to similar update candidates?
> 
> Example:
> bgmac_probe()
> https://elixir.bootlin.com/linux/v5.7-rc2/source/drivers/net/ethernet/broadcom/bgmac-platform.c#L201
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/broadcom/bgmac-platform.c?id=ae83d0b416db002fe95601e7f97f64b59514d936#n201
>
Markus, Thanks very much for your info, I will do it. Thanks again.

BR,
Dejin

> Regards,
> Markus
