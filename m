From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: usb-can device
Date: Tue, 28 Aug 2012 14:18:18 +0200
Message-ID: <503CB70A.8040506@hartkopp.net>
References: <1345996339.6610.10.camel@slaptop>  <503A4E9B.9060308@pengutronix.de> <503B1198.3010506@hartkopp.net> <1346071259.3928.33.camel@slaptop> <503CB26E.7010106@hartkopp.net> <503CB5DF.4030707@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:50220 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab2H1MSV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 28 Aug 2012 08:18:21 -0400
In-Reply-To: <503CB5DF.4030707@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Max S." <max@schneidersoft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 28.08.2012 14:13, Marc Kleine-Budde wrote:

> Max, please leave the mailinglist on Cc.


Acked-by me too. But i think it was an accident :-)

>>>> *2:
>>>> To provide a state-of-the-art echo functionality the sk pointer (skb->sk) is
>>>> sent along with the CAN frame. This allows to skb_free() the original tx skb
>>>> and create a new one at rx time with the correct sk pointer, when the frame is
>>>> echoed after successful transmission. As we are endian safe the sk pointer can
>>>> be taken from the USB URB as-is. (For security reasons we should probably not
>>>> take the pointer directly but double check with stored echo-skbs)
>>>
>>> hm. I also don't think it would be wise to accept a pointer from the
>>> outside in kernel space. maybe accept an index(that can be checked) into
>>> a pointer array?.. I don't know, I'm not at that point yet :P.
>>>
>>
>>
>> I found a very interesting implementation in the Bosch M_CAN specification:
>>
>> http://www.semiconductors.bosch.de/en/ipmodules/can/canipmodules/m_can/m_can.asp
>>
>> http://www.semiconductors.bosch.de/media/en/pdf/ipmodules_1/m_can/mcan_users_manual.pdf
>>
>> Section 2.4.3 Tx Buffer Element (page 45)
>>
>> ---8<---
>>
>> T1 Bits 31:24 MM[7:0]: Message Marker
>>
>> Written by CPU during Tx Buffer configuration. Copied into Tx Event FIFO
>> element for identification of Tx message status.
>>
>> ---8<---
>>
>> So you can see in the Tx event FIFO, which marked CAN frame has been sent.
>>
>> This is probably enough to provide just a byte and to create an array of
>> skb pointers which is referenced by this Message Marker. Maybe 256 markers
>> are too much ... we could only use 8 markers IMO.
> 
> Why not a full u32? Then you're free on the driver side to do what you
> want with it.


Yes. You're right. It's a marker - and if i personally only want to handle an
index into an array with 8 elements with my driver it's my choice.

Regards,
Oliver

