From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] can: add explicit copyright to header can/netlink.h
Date: Sat, 07 Sep 2013 21:15:30 +0200
Message-ID: <3cfa97cc2473a26f5f961bfb4560acd0@grandegger.com>
References: <1378477811-3606-1-git-send-email-mkl@pengutronix.de>
 <ecac65a6d53af596b53d115a9e6552a0@grandegger.com>
 <20130906193744.GV24802@pengutronix.de> <522AFEA8.3020303@hartkopp.net>
 <522AFF20.6000501@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:57418 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab3IGTPd (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 7 Sep 2013 15:15:33 -0400
In-Reply-To: <522AFF20.6000501@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de

On Sat, 07 Sep 2013 12:25:36 +0200, Marc Kleine-Budde <mkl@pengutronix.=
de>=0D
wrote:=0D
> On 09/07/2013 12:23 PM, Oliver Hartkopp wrote:=0D
>> On 06.09.2013 21:37, Uwe Kleine-K=C3=B6nig wrote:=0D
>> =0D
>>>>> I think it is necessary to get the Ack of the people mentioned in=
=0D
>>>>> the Cc: commit footers. @Wolfgang: I added a statement=0D
>>>>>=0D
>>>>>     The provided data structures and external interfaces from thi=
s=0D
>>>>>     code=0D
>>>>>     are not restricted to be used by software with a GPL compatib=
le=0D
>>>>>     license.=0D
>>>>>=0D
>>>>> similar to the other can headers. Does that suit you?=0D
>>>>=0D
>>>> Is this the common phrase other public header files use as well?=0D
>>>> What's the motivation for that addition. Likely I might=0D
>>>> have missed some related discussion. =0D
>>> This is what the headers by Volkswagen are using, but it's only a=0D
>>> suggestion. So it's up to you.=0D
>>>=0D
>> =0D
>> Yep.=0D
>> =0D
>> To make clear that the CAN data structures should not be limited to =
be=0D
>> used in=0D
>> GPL code, this sentence has been added.=0D
>> =0D
>> E.g. to allow to implement a similar programming API for BSD, QNX or=
=0D
>> whatever=0D
>> which are obviously not GPL ...=0D
>> =0D
>> Don't know if this it suitable for the netlink stuff anyway.=0D
> =0D
> The usage of netlink.h in a closed source app might be a nother useca=
se.=0D
=0D
The intention is clear. But many other uapi include files are used in=0D
closed source as well without such a clause.=0D
=0D
Are you/we sure that this addition is even compatible with the=0D
GPL (v2) license. GPL does usually not allow exceptions.=0D
=0D
Wolfgang.
