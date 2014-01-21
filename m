From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 5/5] include: Move includes copied from the Linux
 kernel into include/linux
Date: Tue, 21 Jan 2014 13:56:04 +0100
Message-ID: <20140121125604.GA26766@pengutronix.de>
References: <1389888754-23013-1-git-send-email-mkl@pengutronix.de>
 <1389888754-23013-6-git-send-email-mkl@pengutronix.de>
 <20140116192818.GC25911@pengutronix.de>
 <52D85910.8000200@pengutronix.de>
 <20140117133709.GD25911@pengutronix.de>
 <52D93885.5040109@pengutronix.de>
 <20140117203605.GF25911@pengutronix.de>
 <52DA7106.5000300@hartkopp.net>
 <20140121095337.GR25911@pengutronix.de>
 <52DE5B3F.3010900@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37465 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbaAUM4G (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 07:56:06 -0500
Content-Disposition: inline
In-Reply-To: <52DE5B3F.3010900@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hello Oliver,

On Tue, Jan 21, 2014 at 12:34:23PM +0100, Oliver Hartkopp wrote:
> On 21.01.2014 10:53, Uwe Kleine-K=F6nig wrote:
> > On Sat, Jan 18, 2014 at 01:18:14PM +0100, Oliver Hartkopp wrote:
> >> On 17.01.2014 21:36, Uwe Kleine-K=F6nig wrote:
> > I don't see a real reason here, but I read between the lines that y=
ou
> > prefer isotp to go into the kernel directly instead of into can-uti=
ls
> > first.
>=20
> We obviously have different ways to think/discuss :-(
>=20
> - Yes, isotp is intended for mainline
> - isotp.h will not change when it goes into mainline
> - therefore can-utils can rely on the existing isotp.h
> - therefore isotp.h can stay together with other includes in can-util=
s
>=20
> IMO it does not make sense to kick out the isotp tools just because o=
f the
> fact that isotp is not in mainline today.
Note I didn't intend to kick out the isotp stuff, I only questioned if
it's sensible to keep the isotp header seperate from the vanilla kernel
headers. And here seperate doesn't mean in a different repository but i=
n
a different path in the same repository.

I think techically it doesn't matter much if there is a single director=
y
with includes or if there are two of them. Then the only difference I
see is that it's easier to sync with the kernel if you just do somethin=
g
like

	cd can-utils
	rm some/directory
	cp -a /path/to/kernel/some/directory

and then don't have to fixup because can-utils' includes contain in
some/directory a header you have to restore afterwards because it's not
part of the kernel. You probably know better if that is a relevant poin=
t
or not. It depends e.g. on answers to the questions:
 - When will isotp be part of the kernel?
 - How often do you have to sync the linux headers into can-utils?

Well, up to you.

> > Anyhow, what I care for is to be able to package can-utils for Debi=
an.
>=20
> Yes. That would be nice indeed.
>=20
> > That's what I can do once the updated headers hit can-utils so IMO =
we
> > can stop arguing even if we don't agree 100%.
>=20
> I hope I was able to focus the discussion some lines before. Don't kn=
ow if
> it's worth the effort to kick out the isotp stuff and merge it later =
on.
I would be surprised if that is sensible and as I hope to got clear now
that's not what I intended to suggest.
=20
> > @Marc or Oliver: Can you please give me a ping as soon as the heade=
rs
> > hit your public repo. Thanks.
>=20
> Indeed I would vote for your latest patch set (v5) as the only missin=
g thing
> there would be to move isotp.h from include/socketcan/can/isotp.h to
> include/linux/can/isotp.h and delete the socketcan directory then.
>=20
> In Marcs patch set (v6) the license updates got lost at some point.
The license updates were not included in my v5 IIRC either. I talked to
Marc earlier today and he said to care for application of v6 + a header
sync.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
