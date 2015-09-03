From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v2 2/2] Allwinner SoC CAN controller Support
Date: Thu, 3 Sep 2015 11:13:11 +0000
Message-ID: <20150903111311.13443.48412@shannon>
References: <1441274970-5632-1-git-send-email-info@gerhard-bertelsmann.de>
 <1441274970-5632-3-git-send-email-info@gerhard-bertelsmann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0060.outbound.protection.outlook.com ([157.55.234.60]:21383
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752010AbbICLqY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Sep 2015 07:46:24 -0400
In-Reply-To: <1441274970-5632-3-git-send-email-info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org

Quoting Gerhard Bertelsmann (2015-09-03 10:09:30)
> Second try:
>  Allwinner A10/A20 CAN Controller support
> 
> 
> Signed-off-by: Gerhard Bertelsmann < info@gerhard-bertelsmann.de >
> Tested-by; Gerhard Bertelsmann < info@gerhard-bertelsmann.de >
> 
> 
>  drivers/net/can/Kconfig                            |  10 +
>  drivers/net/can/Makefile                           |   1 +
>  drivers/net/can/sunxi_can.c                        | 832 +++++++++++++++++++++
>  3 files changed, 843 insertions(+)
> 
[...]

Hi Gerhard,

Have you looked at changes made to sja1000 since 2013? It might be prudent to
apply those changes. ;)

See:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/drivers/net/can/sja1000/sja1000.c

In particular, I noticed that this one is not applied:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=215db1856e8313ef8a1d9b64346dc261570012a6

Cheers,
Andri
