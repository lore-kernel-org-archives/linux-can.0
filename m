From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can: sja1000 fix isr hang when hw is unplugged under
 load
Date: Sat, 18 Feb 2012 15:19:53 +0100
Message-ID: <4F3FB389.7050104@hartkopp.net>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de> <4F3BE2AC.9020108@hartkopp.net> <4F3EB82C.7080905@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:47493 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab2BROUS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 18 Feb 2012 09:20:18 -0500
In-Reply-To: <4F3EB82C.7080905@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 17.02.2012 21:27, Marc Kleine-Budde wrote:

> On 02/15/2012 05:51 PM, Oliver Hartkopp wrote:
>> In the case of hotplug enabled devices (PCMCIA/PCIeC) the removal of the
>> hardware can cause an infinite loop in the common sja1000 isr.
>>
>> Use the already retrieved status register to indicate a possible hardware
>> removal and double check by reading the mode register in sja1000_is_absent.
>>
>> v2: Create a new function to not print information in irq context.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Thanks for the patch. I'm going to commit it to can-next. Any objections?


Indeed it should go into stable 3.2 too, as it was the first kernel, where the
EMS PCMCIA driver was integrated.

So putting it into Daves net-tree for 3.3rc fixes and announce it for stable
3.2 seems correct to me.

> P.S.:
> Please make it based on can-next/master next time, it fails to apply due

> to Wolfgang's dev_LEVEL -> netdev_LEVEL patch. But it's trivial to
> apply, by hand :)


The patch was based on the latest 3.3rc3 from Linus's tree, which was my
intention (see above).

Tnx,
Oliver
