From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [net-next v2] can: ti_hecc: convert to
 devm_platform_ioremap_resource_byname()
Date: Mon, 20 Apr 2020 16:54:22 +0200
Message-ID: <3fd53b73-87b3-b788-d984-cb1c719f9e7f@web.de>
References: <20200420132207.8536-1-zhengdejin5@gmail.com>
 <940fcaa1-8500-e534-2380-39419f1ac5a0@web.de> <20200420141921.GA10880@nuc8i5>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:54757 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgDTOyc (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 20 Apr 2020 10:54:32 -0400
In-Reply-To: <20200420141921.GA10880@nuc8i5>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dejin Zheng <zhengdejin5@gmail.com>, netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

>> Example:
>> bgmac_probe()
>> https://elixir.bootlin.com/linux/v5.7-rc2/source/drivers/net/ethernet/broadcom/bgmac-platform.c#L201
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/broadcom/bgmac-platform.c?id=ae83d0b416db002fe95601e7f97f64b59514d936#n201
>>
> Markus, Thanks very much for your info, I will do it. Thanks again.

If you would use another script (like for the semantic patch language),
you could find remaining update candidates in a convenient way,
couldn't you?

Regards,
Markus
