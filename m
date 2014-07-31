From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Subject: Re: C_CAN: can frame drops
Date: Thu, 31 Jul 2014 15:19:06 +0100
Message-ID: <CA+V-a8uhnn9cfuxULZQ4oBScy9jYfev+n50SphK+HDTVLPVO_g@mail.gmail.com>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl> <53D204A4.1060502@pengutronix.de>
 <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl> <53D2126C.40600@pengutronix.de>
 <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl> <53D214E2.7020205@pengutronix.de>
 <BAY176-W40C40CD192EBD241673159D3FC0@phx.gbl> <53D219E8.5060307@pengutronix.de>
 <BAY176-W36138D837FA40B1721062ED3FC0@phx.gbl> <53D234D9.2010602@hartkopp.net>
 <CA+V-a8vm+WQXcSwPp7e7yKQehs0+BYkHhZg-EfEL1gWE_cBF=g@mail.gmail.com>
 <53D91AB5.5060507@hartkopp.net> <BAY176-W523AF4513C195E7972FE52D3E60@phx.gbl>
 <53DA39CF.2070303@pengutronix.de> <53DA4E89.1080206@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:37705 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbaGaOTm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 31 Jul 2014 10:19:42 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so2815467wes.11
        for <linux-can@vger.kernel.org>; Thu, 31 Jul 2014 07:19:38 -0700 (PDT)
In-Reply-To: <53DA4E89.1080206@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Ssagarr Patil <hugarsagar@outlook.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

On Thu, Jul 31, 2014 at 3:11 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 31.07.2014 14:42, Marc Kleine-Budde wrote:
>> On 07/31/2014 02:41 PM, Ssagarr Patil wrote:
>
>>>> But so far there was no feedback from Sagar, if it was at least helpful.
>>>>
>>> Yes it was beneficial I used MSG_WAITALL flag for recvmmsg() so that
>>> it waits for n frames and there is no memory wastage.
>>>
>
> This is probably not usable for candump, which has to provide the displayed
> CAN frames pretty fast. I think there's some timeout mechanism too, to stop
> the infinitive waiting for n frames.
>
It would be helpful with -l option being enabled ?

Regards,
--Prabhakar Lad

>>> Also is it possible to configure qdiscs for improving the performance ?
>>
>> AFAIK qdiscs are only used in the tx path.
>
> Yep! See:
> http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf
>
>
> Regards,
> Oliver
>
