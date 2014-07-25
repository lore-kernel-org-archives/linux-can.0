From: Ssagarr Patil <hugarsagar@outlook.com>
Subject: RE: C_CAN: can frame drops
Date: Fri, 25 Jul 2014 16:52:16 +0530
Message-ID: <BAY176-W2797C4257A9D55478CDF55D3FC0@phx.gbl>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>,<53D204A4.1060502@pengutronix.de>
 <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl>,<53D2126C.40600@pengutronix.de>
 <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl>,<53D214E2.7020205@pengutronix.de>
 <BAY176-W40C40CD192EBD241673159D3FC0@phx.gbl>,<53D219E8.5060307@pengutronix.de>
 <BAY176-W36138D837FA40B1721062ED3FC0@phx.gbl>,<53D22D0F.3020001@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bay004-omc4s22.hotmail.com ([65.54.190.224]:64126 "EHLO
	BAY004-OMC4S22.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751860AbaGYLWR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 25 Jul 2014 07:22:17 -0400
In-Reply-To: <53D22D0F.3020001@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Marc,

>
> On 07/25/2014 11:47 AM, Ssagarr Patil wrote:
>>>> Any suggestion on how to still improve the performance so as there is zero frame loss ?
>>>> either on driver or application side.
>>>
>>> Use the latest kernel, at least v3.15 which has tglx's patches
>>> integrated. v3.16 might even be better. If you want to log all CAN
>>> messages, you can probably make use of recvmmsg() to receive more than
>>> one CAN frame at a time (instead of using recvmsg() or read()). When
>>> writing to disk, don't write a single CAN frame at a time, it's better
>>> to write large blocks, i.e. several 4k of data.
>>>
>> I am using the v3.16 (the master branch from git://gitorious.org/linux-can/linux-can.git)
>>
>> OK will try experiment with recvmmsg() & and writing to disk with large blocks.
>>
>>> Depending on the actual c_can/d_can implementation you're using, there
>>> might be some optimisation left in the driver, i.e. use 32 bit access if
>>> possible. However before touching the driver, measurement to identify
>>> the hot spots should be done.
>>>
>> OK
>>
>>> The next step would be to switch to preempt rt enabled system.
>>>
>> I am afraid I cant use this, as project needs to be run on normal Linux.
>
> Preempt-rt is a normal Linux system, though. :)
>
Yes but our requirement is to not to have on rt-linux :(

Thanks,
--Sagar
 		 	   		  