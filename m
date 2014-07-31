From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: C_CAN: can frame drops
Date: Thu, 31 Jul 2014 16:11:21 +0200
Message-ID: <53DA4E89.1080206@hartkopp.net>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl> <53D204A4.1060502@pengutronix.de> <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl> <53D2126C.40600@pengutronix.de> <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl> <53D214E2.7020205@pengutronix.de> <BAY176-W40C40CD192EBD241673159D3FC0@phx.gbl> <53D219E8.5060307@pengutronix.de> <BAY176-W36138D837FA40B1721062ED3FC0@phx.gbl> <53D234D9.2010602@hartkopp.net> <CA+V-a8vm+WQXcSwPp7e7yKQehs0+BYkHhZg-EfEL1gWE_cBF=g@mail.gmail.com>,<53D91AB5.5060507@hartkopp.net> <BAY176-W523AF4513C195E7972FE52D3E60@phx.gbl> <53DA39CF.2070303@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:12783 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaGaOL3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 31 Jul 2014 10:11:29 -0400
In-Reply-To: <53DA39CF.2070303@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Ssagarr Patil <hugarsagar@outlook.com>, Prabhakar Lad <prabhakar.csengg@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 31.07.2014 14:42, Marc Kleine-Budde wrote:
> On 07/31/2014 02:41 PM, Ssagarr Patil wrote:

>>> But so far there was no feedback from Sagar, if it was at least helpful.
>>>
>> Yes it was beneficial I used MSG_WAITALL flag for recvmmsg() so that 
>> it waits for n frames and there is no memory wastage.
>>

This is probably not usable for candump, which has to provide the displayed
CAN frames pretty fast. I think there's some timeout mechanism too, to stop
the infinitive waiting for n frames.

>> Also is it possible to configure qdiscs for improving the performance ?
> 
> AFAIK qdiscs are only used in the tx path.

Yep! See:
http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf


Regards,
Oliver

