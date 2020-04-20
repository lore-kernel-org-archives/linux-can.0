From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [net-next v2] can: ti_hecc: convert to
 devm_platform_ioremap_resource_byname()
Date: Mon, 20 Apr 2020 17:42:04 +0200
Message-ID: <a6fbdb0b-60be-baae-ad17-1977ed12fdaa@web.de>
References: <20200420132207.8536-1-zhengdejin5@gmail.com>
 <940fcaa1-8500-e534-2380-39419f1ac5a0@web.de> <20200420141921.GA10880@nuc8i5>
 <3fd53b73-87b3-b788-d984-cb1c719f9e7f@web.de> <20200420151911.GA2698@nuc8i5>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420151911.GA2698@nuc8i5>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dejin Zheng <zhengdejin5@gmail.com>, netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
List-Id: linux-can.vger.kernel.org

>> If you would use another script (like for the semantic patch language),
>> you could find remaining update candidates in a convenient way,
>> couldn't you?
>>
> Markus, could you share the script?

Theoretically, yes.

Practically, I would prefer additional development options.

* I am trying for a while to improve some components also by advanced
  applications of the Coccinelle software.
  I hope to increase incentives for involved contributors.

* I imagine that a known directory would be a nice place for
  further reuse of such SmPL scripts.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle?id=ae83d0b416db002fe95601e7f97f64b59514d936

* How will your motivation evolve?
  + Pick more updates for your own contribution statistics.
  And / Or
  + Tell more interested parties about change possibilities.

Regards,
Markus
