From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: mcp251x: mcp2515 stops receiving
Date: Sat, 22 Mar 2014 21:15:41 +0100
Message-ID: <532DEF6D.3010208@hartkopp.net>
References: <2E9F00CBB66AB544A1ACDC59627518BA0DB3F120@mailserver>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:15387 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbaCVUPn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 22 Mar 2014 16:15:43 -0400
In-Reply-To: <2E9F00CBB66AB544A1ACDC59627518BA0DB3F120@mailserver>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Rost, Martin" <Martin.Rost@tonfunk.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Martin,

I'm not really deep in any of these MCP251x and SPI topic but I know from an
intern who was using the Raspberry Pi together with a MCP2515 that he tried a
different driver (mcp2515 instead of mcp251x) and also a SPI low latency patch
which seems to enable some DMA functionality in the Raspberry Pi:

	http://elinux.org/RPi_CANBus

Don't know what of these tweaks should go into mainline as I personally do not
have any experiences with this stuff.

Maybe it helps in your environment.

Btw. I did not want to prevent others (with more experiences on this mcp251x
topic) to answer your question in a more specific way ;-)

Regards,
Oliver


On 21.03.2014 13:40, Rost, Martin wrote:
> Hello List,
> 
> We are using the MCP2515 on a tegra3 (Toradex Colibri T30, to be precise) and every now and then the driver just stops.
> The interrupt line stays low, and the driver does not collect the data.
> From my investigations I conclude, that the MCP lowers the IRQ line before the value in the INTF register is  updated, 
> so when the driver reads the INTF register, a 0 is returned, and the driver assumes nothing has to be done.
>  
> (
> Chances are I'm misinterpreting my observations. 
> It might as well be that the call to the IST is suspended, because the previous instance is still running and processes the new irq cause as well, 
> so the next call will not see the signal at all. 
> But in that case the driver should not stop with the irq line held low, or should it?
> )
>  
> We are using the 3.1.10 kernel from the toradex repository, which should be in sync with the nvidia tegra4linux one.
> I have browsed through the patches between 3.1.10 and head and have applied all those that seem to address issues and don't interfere with the 3.1.10 kernel structures, but to no avail.
> In fact, these patches have been applied:
> cab32f39dcc5b35db96497dc0a026b5dea76e4e7
> db388d6460ffa53b3b38429da6f70a913f89b048
> ae5d589e5f9f3217656ada632869968178886ac6
> b1ef05a5a20afe50d4188a5b59579bd140758cf0
> I have changed the IST loop to poll the INTF register beforehand for up to 10ms, and now the driver seems a lot more stable in our environment.
> Has someone seen this issue before, or can confirm I am not completely off the path?
>  
> On a side note, I have a second reason that makes the driver stop, which has to do with smp somehow.
> Disabling core1..3 keeps that from happening, but the problem addressed above would persist.
> Switching the irq to a different core by setting /proc/irq/91/smp_affinity does not trigger this problem.
> Any insights or starting point on this would also be greatly appreciated.
>  
> Best regards
> Martin 
> 
