From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] can: add explicit copyright to header can/netlink.h
Date: Fri, 06 Sep 2013 23:05:42 +0200
Message-ID: <1b45fb94c09a6ee453fd1606cc21e111@grandegger.com>
References: <1378477811-3606-1-git-send-email-mkl@pengutronix.de>
 <ecac65a6d53af596b53d115a9e6552a0@grandegger.com>
 <20130906193744.GV24802@pengutronix.de>
 <62dc5723044ed5670932d4a452471510@grandegger.com>
 <20130906204503.GW24802@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:41189 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759441Ab3IFVFq (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 6 Sep 2013 17:05:46 -0400
In-Reply-To: <20130906204503.GW24802@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de

On Fri, 6 Sep 2013 22:45:03 +0200, Uwe Kleine-K=C3=B6nig=0D
<u.kleine-koenig@pengutronix.de> wrote:=0D
> Hello Wolfgang,=0D
> =0D
> On Fri, Sep 06, 2013 at 10:35:54PM +0200, Wolfgang Grandegger wrote:=0D
>> On Fri, 6 Sep 2013 21:37:44 +0200, Uwe Kleine-K=C3=B6nig=0D
>> <u.kleine-koenig@pengutronix.de> wrote:=0D
>> > Hello Wolfgang,=0D
>> > =0D
>> > On Fri, Sep 06, 2013 at 05:48:06PM +0200, Wolfgang Grandegger wrot=
e:=0D
>> >> Hi Marc and Uwe,=0D
>> >> =0D
>> >> On Fri,  6 Sep 2013 16:30:11 +0200, Marc Kleine-Budde=0D
>> >> <mkl@pengutronix.de>=0D
>> >> wrote:=0D
>> >> > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=0D
>> >> > =0D
>> >> > This file is copied to the source code of user space applicatio=
ns=0D
>> >> > (in=0D
>> >> > this case can-utils) and so it makes sense to mention explicitl=
y=0D
its=0D
>> >> > copyright. I added the terms of C code that was introduced in t=
he=0D
>> same=0D
>> >> > commit as this header.=0D
>> >> > =0D
>> >> > Cc: Wolfgang Grandegger <wg@grandegger.com>=0D
>> >> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>=0D
>> >> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>=0D
>> >> > ---=0D
>> >> > Hello Wolfgang,=0D
>> >> > =0D
>> >> > this is the remaining hunk from Uwe's patch that has not been=0D
Acked.=0D
>> >> > Continuing=0D
>> >> > with Uwe's words (adopted):=0D
>> >> > =0D
>> >> > I think it is necessary to get the Ack of the people mentioned =
in=0D
>> >> > the Cc: commit footers. @Wolfgang: I added a statement=0D
>> >> > =0D
>> >> >     The provided data structures and external interfaces from t=
his=0D
>> code=0D
>> >> >     are not restricted to be used by software with a GPL=0D
compatible=0D
>> >> >     license.=0D
>> >> > =0D
>> =0D
>> >> > similar to the other can headers. Does that suit you?=0D
>> =0D
>> >> =0D
>> =0D
>> >> Is this the common phrase other public header files use as well?=0D
>> =0D
>> >> What's the motivation for that addition. Likely I might=0D
>> =0D
>> >> have missed some related discussion. =0D
>> =0D
>> > This is what the headers by Volkswagen are using, but it's only a=0D
>> =0D
>> > suggestion. So it's up to you.=0D
>> =0D
>> =0D
>> =0D
>> Which headers. In net-next's "include/uapi/linux/can.h" I read:=0D
>> =0D
>> =0D
>> =0D
>> /*=0D
>>  * linux/can.h=0D
>>  *=0D
>>  * Definitions for CAN network layer (socket addr / CAN frame / CAN=0D
>>  filter)=0D
>>  *=0D
>>  * Authors: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>=0D
>>  *          Urs Thuermann   <urs.thuermann@volkswagen.de>=0D
>>  * Copyright (c) 2002-2007 Volkswagen Group Electronic Research=0D
>>  * All rights reserved.=0D
>>  *=0D
>>  */=0D
> Yeah, in net-next the license is still missing, see=0D
> http://thread.gmane.org/gmane.linux.can/3757 for my suggestion. The=0D
> sentence is taken from the corresponding .c files.=0D
=0D
Ah, you mean your modifications. I have browsed other uapi header files=
=0D
and have not found similar statements. Well, I do not see a need for=0D
such an addition. The GPL v2 text is fine, though, because I published=0D
the device interface under that license.=0D
=0D
Thanks,=0D
=0D
Wolfgang.=0D

