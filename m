From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: C_CAN: can frame drops
Date: Wed, 30 Jul 2014 18:17:57 +0200
Message-ID: <53D91AB5.5060507@hartkopp.net>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl> <53D204A4.1060502@pengutronix.de> <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl> <53D2126C.40600@pengutronix.de> <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl> <53D214E2.7020205@pengutronix.de> <BAY176-W40C40CD192EBD241673159D3FC0@phx.gbl> <53D219E8.5060307@pengutronix.de> <BAY176-W36138D837FA40B1721062ED3FC0@phx.gbl> <53D234D9.2010602@hartkopp.net> <CA+V-a8vm+WQXcSwPp7e7yKQehs0+BYkHhZg-EfEL1gWE_cBF=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:64933 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129AbaG3QSS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Jul 2014 12:18:18 -0400
In-Reply-To: <CA+V-a8vm+WQXcSwPp7e7yKQehs0+BYkHhZg-EfEL1gWE_cBF=g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Prabhakar Lad <prabhakar.csengg@gmail.com>
Cc: Ssagarr Patil <hugarsagar@outlook.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 30.07.2014 13:28, Prabhakar Lad wrote:

>>>>  If you want to log all CAN
>>>> messages, you can probably make use of recvmmsg() to receive more than
>>>> one CAN frame at a time (instead of using recvmsg() or read()). When
>>>> writing to disk, don't write a single CAN frame at a time, it's better
>>>> to write large blocks, i.e. several 4k of data.
>>>>
>>> I am using the v3.16 (the master branch from git://gitorious.org/linux-can/linux-can.git)
>>>
>>> OK will try experiment with recvmmsg() & and writing to disk with large blocks.
>>>
>>
>> I implemented a proof-of-concept for recvmmsg() for candump.
>>
>> You can try:
>>
>> https://gitorious.org/linux-can/canpump
>>
> 
> Any plans of adding this into mainline can-utils ?
> 

Hm - currently not.

If it turns out to really help to increase the throughput for e.g. candump it
would be worth thinking to integrate it into candump.

But so far there was no feedback from Sagar, if it was at least helpful.

So from my current perspective the canpump source code would be a candidate
for can-tests as many other SocketCAN code examples are sitting there too.

Regards,
Oliver

