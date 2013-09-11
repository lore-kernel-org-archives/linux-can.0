From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 Sep 2013 21:17:38 +0200
Message-ID: <5230C1D2.2080700@hartkopp.net>
References: <1378920814-sup-4559@pruts.nl> <5230B4C9.4070904@pengutronix.de> <1378923967-sup-6565@pruts.nl> <5230B897.7020807@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:44465 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab3IKTRu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Sep 2013 15:17:50 -0400
In-Reply-To: <5230B897.7020807@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Ico Doornekamp <can@zevv.nl>
Cc: linux-can <linux-can@vger.kernel.org>

On 11.09.2013 20:38, Marc Kleine-Budde wrote:
> On 09/11/2013 08:30 PM, Ico Doornekamp wrote:


>>> But you're using a 64 bit system while Yegor uses a 32 bit one
>>> (according to your notes below).
>>

I wonder if the used of an unsigned long data type for the u32 can_id
and the use of kstrtoul() might cause an issue on 64 bit platforms?!?

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/net/can/slcan.c#n146

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/net/can/slcan.c#n164


The 'unsigned long' conversion was introduced in 2009 due to a report of Kurt van Dijck:

http://svn.berlios.de/wsvn/socketcan/trunk/kernel/2.6/drivers/net/can/slcan.c?op=revision&rev=919
http://svn.berlios.de/wsvn/socketcan/trunk/kernel/2.6/drivers/net/can/slcan.c?op=diff&rev=919&peg=919

but maybe kstrtouint()

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/lib/kstrtox.c#n202

would be the better choice now.


>> Indeed, but I believe that should in no way interfere with captured data
>> endianess.
>>
>>> Your dump doesn't look correct in my wireshark, it has alternating
>>> extended and standard frames and the standard frames have identifiers
>>> of 0x060000 which is not valid.
>>>
>>> Does the command line tool candump show proper frames?
>>
>> I'll have to look into that tomorrow, at this time I only have access to
>> the capture file I made earlier.

Yes, that would be my first question too ...

Regards,
Oliver


