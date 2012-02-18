From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can: sja1000 fix isr hang when hw is unplugged under
 load
Date: Sat, 18 Feb 2012 16:34:44 +0100
Message-ID: <4F3FC514.4000307@hartkopp.net>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de> <4F3BE2AC.9020108@hartkopp.net> <4F3EB82C.7080905@pengutronix.de> <4F3FB6AB.4030506@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:37262 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab2BRPe5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 18 Feb 2012 10:34:57 -0500
In-Reply-To: <4F3FB6AB.4030506@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 18.02.2012 15:33, Wolfgang Grandegger wrote:

> On 02/17/2012 09:27 PM, Marc Kleine-Budde wrote:
>> On 02/15/2012 05:51 PM, Oliver Hartkopp wrote:
>>> In the case of hotplug enabled devices (PCMCIA/PCIeC) the removal of the
>>> hardware can cause an infinite loop in the common sja1000 isr.
>>>
>>> Use the already retrieved status register to indicate a possible hardware
>>> removal and double check by reading the mode register in sja1000_is_absent.
>>>
>>> v2: Create a new function to not print information in irq context.
>>>
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> Thanks for the patch. I'm going to commit it to can-next. Any objections?
> 
> Sorry for the late response but what is this double check good for? All
> register reads will return 0xff if the card is unplugged. And if the
> double check is OK we will continue even we have realized a clear
> failure (status was 0xff).


Hi Wolfgang,

i checked the SJA1000 spec. The status register can potentially hold the value
0xFF by specification. So even when it's not very likely that it holds 0xFF -
it can be. Additionally you may have SJA1000 FPGA cores that do not behave
exactly like the SJA1000 itself.

To double check the unlikely case i do a read on the mode register, which has
some bits definitely set to "0" which is a strong indication for the
controller removal.

Regards,
Oliver
