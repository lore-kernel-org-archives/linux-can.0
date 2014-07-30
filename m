From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Subject: Re: C_CAN: can frame drops
Date: Wed, 30 Jul 2014 12:28:15 +0100
Message-ID: <CA+V-a8vm+WQXcSwPp7e7yKQehs0+BYkHhZg-EfEL1gWE_cBF=g@mail.gmail.com>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl> <53D204A4.1060502@pengutronix.de>
 <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl> <53D2126C.40600@pengutronix.de>
 <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl> <53D214E2.7020205@pengutronix.de>
 <BAY176-W40C40CD192EBD241673159D3FC0@phx.gbl> <53D219E8.5060307@pengutronix.de>
 <BAY176-W36138D837FA40B1721062ED3FC0@phx.gbl> <53D234D9.2010602@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:39043 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbaG3L2r (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Jul 2014 07:28:47 -0400
Received: by mail-wg0-f47.google.com with SMTP id b13so1025300wgh.18
        for <linux-can@vger.kernel.org>; Wed, 30 Jul 2014 04:28:45 -0700 (PDT)
In-Reply-To: <53D234D9.2010602@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Ssagarr Patil <hugarsagar@outlook.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

On Fri, Jul 25, 2014 at 11:43 AM, Oliver Hartkopp
<socketcan@hartkopp.net> wrote:
> Hi Sagar,
>
>>>
>>>  If you want to log all CAN
>>> messages, you can probably make use of recvmmsg() to receive more than
>>> one CAN frame at a time (instead of using recvmsg() or read()). When
>>> writing to disk, don't write a single CAN frame at a time, it's better
>>> to write large blocks, i.e. several 4k of data.
>>>
>> I am using the v3.16 (the master branch from git://gitorious.org/linux-can/linux-can.git)
>>
>> OK will try experiment with recvmmsg() & and writing to disk with large blocks.
>>
>
> I implemented a proof-of-concept for recvmmsg() for candump.
>
> You can try:
>
> https://gitorious.org/linux-can/canpump
>

Any plans of adding this into mainline can-utils ?

Thanks,
--Prabhakar Lad
