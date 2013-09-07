From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: add explicit copyright to header can/netlink.h
Date: Sat, 07 Sep 2013 12:23:36 +0200
Message-ID: <522AFEA8.3020303@hartkopp.net>
References: <1378477811-3606-1-git-send-email-mkl@pengutronix.de> <ecac65a6d53af596b53d115a9e6552a0@grandegger.com> <20130906193744.GV24802@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:23161 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab3IGKXj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 Sep 2013 06:23:39 -0400
In-Reply-To: <20130906193744.GV24802@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de

On 06.09.2013 21:37, Uwe Kleine-K=F6nig wrote:

>>> I think it is necessary to get the Ack of the people mentioned in
>>> the Cc: commit footers. @Wolfgang: I added a statement
>>>
>>>     The provided data structures and external interfaces from this =
code
>>>     are not restricted to be used by software with a GPL compatible
>>>     license.
>>>
>>> similar to the other can headers. Does that suit you?
>>
>> Is this the common phrase other public header files use as well?
>> What's the motivation for that addition. Likely I might
>> have missed some related discussion.=20
> This is what the headers by Volkswagen are using, but it's only a
> suggestion. So it's up to you.
>=20

Yep.

To make clear that the CAN data structures should not be limited to be =
used in
GPL code, this sentence has been added.

E.g. to allow to implement a similar programming API for BSD, QNX or wh=
atever
which are obviously not GPL ...

Don't know if this it suitable for the netlink stuff anyway.

Best regards,
Oliver


