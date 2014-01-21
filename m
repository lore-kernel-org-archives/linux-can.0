From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 5/5] include: Move includes copied from the Linux kernel
 into include/linux
Date: Tue, 21 Jan 2014 12:34:23 +0100
Message-ID: <52DE5B3F.3010900@hartkopp.net>
References: <1389888754-23013-1-git-send-email-mkl@pengutronix.de> <1389888754-23013-6-git-send-email-mkl@pengutronix.de> <20140116192818.GC25911@pengutronix.de> <52D85910.8000200@pengutronix.de> <20140117133709.GD25911@pengutronix.de> <52D93885.5040109@pengutronix.de> <20140117203605.GF25911@pengutronix.de> <52DA7106.5000300@hartkopp.net> <20140121095337.GR25911@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:61193 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbaAULea (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 06:34:30 -0500
In-Reply-To: <20140121095337.GR25911@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org



On 21.01.2014 10:53, Uwe Kleine-K=F6nig wrote:
> On Sat, Jan 18, 2014 at 01:18:14PM +0100, Oliver Hartkopp wrote:
>> On 17.01.2014 21:36, Uwe Kleine-K=F6nig wrote:


> I don't see a real reason here, but I read between the lines that you
> prefer isotp to go into the kernel directly instead of into can-utils
> first.

We obviously have different ways to think/discuss :-(

- Yes, isotp is intended for mainline
- isotp.h will not change when it goes into mainline
- therefore can-utils can rely on the existing isotp.h
- therefore isotp.h can stay together with other includes in can-utils

IMO it does not make sense to kick out the isotp tools just because of =
the
fact that isotp is not in mainline today.

Alternatively we could split the isotp related stuff into another git r=
epo,
e.g. can-isotp-utils and merge them again at the point when isotp is in=
 mainline.

> Anyhow, what I care for is to be able to package can-utils for Debian=
=2E

Yes. That would be nice indeed.

> That's what I can do once the updated headers hit can-utils so IMO we
> can stop arguing even if we don't agree 100%.

I hope I was able to focus the discussion some lines before. Don't know=
 if
it's worth the effort to kick out the isotp stuff and merge it later on=
=2E

> @Marc or Oliver: Can you please give me a ping as soon as the headers
> hit your public repo. Thanks.

Indeed I would vote for your latest patch set (v5) as the only missing =
thing
there would be to move isotp.h from include/socketcan/can/isotp.h to
include/linux/can/isotp.h and delete the socketcan directory then.

In Marcs patch set (v6) the license updates got lost at some point.

Best regards,
Oliver

