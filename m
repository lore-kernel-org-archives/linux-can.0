From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [net-next v2] can: ti_hecc: convert to
 devm_platform_ioremap_resource_byname()
Date: Mon, 20 Apr 2020 16:00:54 +0200
Message-ID: <940fcaa1-8500-e534-2380-39419f1ac5a0@web.de>
References: <20200420132207.8536-1-zhengdejin5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200420132207.8536-1-zhengdejin5@gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Dejin Zheng <zhengdejin5@gmail.com>, netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
List-Id: linux-can.vger.kernel.org

> v1 -> v2:
> 	- modify the commit comments by Markus's suggestion.

Thanks for another wording fine-tuning.

Would you like to extend your adjustment interests to similar update candidates?

Example:
bgmac_probe()
https://elixir.bootlin.com/linux/v5.7-rc2/source/drivers/net/ethernet/broadcom/bgmac-platform.c#L201
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/broadcom/bgmac-platform.c?id=ae83d0b416db002fe95601e7f97f64b59514d936#n201

Regards,
Markus
