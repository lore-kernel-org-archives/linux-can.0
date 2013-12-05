From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v6] can: sja1000: fix {pre,post}_irq() handling and IRQ
 handler return value
Date: Thu, 05 Dec 2013 21:26:45 +0100
Message-ID: <52A0E185.1080402@grandegger.com>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:50785 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab3LEU0r (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Dec 2013 15:26:47 -0500
In-Reply-To: <loom.20131205T202627-307@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Andrysek <richard.andrysek@rg-mechatronics.com>, linux-can@vger.kernel.org

On 12/05/2013 08:37 PM, Richard Andrysek wrote:
> Wolfgang Grandegger <wg <at> grandegger.com> writes:
> 
>> 	2) How the data overrun can happen, if the can bus load  is ~25%?
>>
>> If a bunch of messages is sent in a short time. The 25% is an average
>> load, I assume.
>>
>>> 	 
>>> 	$ sudo cat /proc/net/can/stats
>>> 	[sudo] password for ran:
>>>  
>>>   1421819 transmitted frames (TXF)
>>>   2606493 received frames (RXF)
>>>    473873 matched frames (RXMF)
>>>  
>>>        18 % total match ratio (RXMR)
>>>      2400 frames/s total tx rate (TXR)
>>>      4400 frames/s total rx rate (RXR)
>>>  
>>>        18 % current match ratio (CRXMR)
>>>      2400 frames/s current tx rate (CTXR)
>>>      4400 frames/s current rx rate (CRXR)
>>>  
>>>        18 % max match ratio (MRXMR)
>>>      2427 frames/s max tx rate (MTXR)
>>>      4427 frames/s max rx rate (MRXR)
>>>  
>>>         4 current receive list entries (CRCV)
>>>         9 maximum receive list entries (MRCV)
>>>  
>>> 	        2 statistic resets (STR)
>>
>>   # ip -d -s link show can0
>>
>> will list the CAN statistics.
>>
>> Wolfgang.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo <at> vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 
> Hi Wolfgang,
> 
> thank you for help. I've recognized that these two lines comes from a
> network world:
> 
> RX packets:12462166 errors:121380 dropped:0 overruns:0 frame:121380
> TX packets:11604619 errors:678 dropped:0 overruns:0 carrier:0

What do you mean? CAN belongs to the network world. What does the
following command report:

 # ip -d -s link show can0

> Then each event "arbitration lost" generates an IRQ.

From a CAN device?

> Is it OK to disable it, just now for tests. With that I want to reduce an
> amount of IRQs. Is it possible to disable it without a new compilation of a
> kernel?

"ifconfig <device> down" should do the job. You may get in trouble if
it's your ethernet device, though.

> We are running quite fast, in few ms. So we test your driver quite well:)

With "-rt" or with vanilla Linux?

Wolfgang.

