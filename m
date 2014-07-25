From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: C_CAN: can frame drops
Date: Fri, 25 Jul 2014 12:43:37 +0200
Message-ID: <53D234D9.2010602@hartkopp.net>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>,<53D204A4.1060502@pengutronix.de> <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl>,<53D2126C.40600@pengutronix.de> <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl>,<53D214E2.7020205@pengutronix.de> <BAY176-W40C40CD192EBD241673159D3FC0@phx.gbl>,<53D219E8.5060307@pengutronix.de> <BAY176-W36138D837FA40B1721062ED3FC0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:37884 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbaGYKnp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 06:43:45 -0400
In-Reply-To: <BAY176-W36138D837FA40B1721062ED3FC0@phx.gbl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ssagarr Patil <hugarsagar@outlook.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Sagar,

>>
>>  If you want to log all CAN
>> messages, you can probably make use of recvmmsg() to receive more than
>> one CAN frame at a time (instead of using recvmsg() or read()). When
>> writing to disk, don't write a single CAN frame at a time, it's better
>> to write large blocks, i.e. several 4k of data.
>>
> I am using the v3.16 (the master branch from git://gitorious.org/linux-can/linux-can.git)
> 
> OK will try experiment with recvmmsg() & and writing to disk with large blocks.
>  

I implemented a proof-of-concept for recvmmsg() for candump.

You can try:

https://gitorious.org/linux-can/canpump

:-)

Maybe it helps.

Regards,
Oliver

