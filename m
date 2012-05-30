From: Martin Kozusky <mkozusky@kkmicro.cz>
Subject: Re: can4linux compilation for i.mx25 under 2.6.39
Date: Wed, 30 May 2012 15:26:24 +0200
Message-ID: <jq5760$sur$1@dough.gmane.org>
References: <jq50tg$55u$1@dough.gmane.org> <4FC6099D.3030906@pengutronix.de> <jq52en$i2e$1@dough.gmane.org> <4FC60FA7.2000600@pengutronix.de> <jq53rt$uqu$1@dough.gmane.org> <4FC61545.2020504@pengutronix.de> <jq5530$ag8$1@dough.gmane.org> <4FC61E27.6040309@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42258 "EHLO plane.gmane.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753677Ab2E3N1T (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 30 May 2012 09:27:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1SZivB-000479-8m
	for linux-can@vger.kernel.org; Wed, 30 May 2012 15:26:41 +0200
Received: from 213.191.105.242 ([213.191.105.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 30 May 2012 15:26:41 +0200
Received: from mkozusky by 213.191.105.242 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 30 May 2012 15:26:41 +0200
In-Reply-To: <4FC61E27.6040309@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Dne 30.5.2012 15:18, Marc Kleine-Budde napsal(a):
> On 05/30/2012 02:50 PM, Martin Kozusky wrote:
>>>> The best for me would be some kernel module which would just put the CAN
>>>> frame into some big "from userspace available" buffer in the interrupt
>>>> and nothing more. My app would check if there is anything new and read
>>>> it out.
>>>> There are around 1500/sec (at 250kbit) can frames on the bus when the
>>>> problem arise, I think it's not that much.
>>>
>>> Are you writing the can frames to storage in the same thread as
>>> receiving them?
>>
>>
>> No, CAN has it's own thread, which is just making struct from can
>> messages (reading via select() )  and writes them into another buffer.
>> Then the main thread reads this buffer and writes to SD card. Now I
>> changed it so that this buffer is 30MB big, so I first store all the
>> messages into RAM, and when I don't need to record CAN frames anymore, I
>> write all of them to card from this big buffer.
>> But this is just limited workaround because I'm limited with the RAM
>> size (so I had to make the buffer cyclic and just latest xxxx messages
>> are stored, older are overwritten when the buffer is full).
>
> Have you setup realtime priorities for you CAN thread?
No, I did't set up any special attributes. Do you mean I should use 
pthread_attr_setschedpolicy(ptr,SCHED_RR) or something else?

Martin

> Marc
>
>


