From: Ssagarr Patil <hugarsagar@outlook.com>
Subject: RE: C_CAN: can frame drops
Date: Fri, 25 Jul 2014 16:54:15 +0530
Message-ID: <BAY176-W27879D761DD2E747BD167FD3FC0@phx.gbl>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>,<53D204A4.1060502@pengutronix.de>
 <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl>,<53D2126C.40600@pengutronix.de>
 <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl>,<53D214E2.7020205@pengutronix.de>
 <BAY176-W40C40CD192EBD241673159D3FC0@phx.gbl>,<53D219E8.5060307@pengutronix.de>
 <BAY176-W36138D837FA40B1721062ED3FC0@phx.gbl>,<53D234D9.2010602@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bay004-omc3s25.hotmail.com ([65.54.190.163]:64826 "EHLO
	BAY004-OMC3S25.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760080AbaGYLYQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 25 Jul 2014 07:24:16 -0400
In-Reply-To: <53D234D9.2010602@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

>
>>>
>>> If you want to log all CAN
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
> :-)
>
Thanks for implementing it I was too doing the same thing although you have removed
the logging part of it I am adding it and testing.


Thanks,
--sagar
 		 	   		  