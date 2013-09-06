From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] can: add explicit copyright to header can/netlink.h
Date: Fri, 6 Sep 2013 21:37:44 +0200
Message-ID: <20130906193744.GV24802@pengutronix.de>
References: <1378477811-3606-1-git-send-email-mkl@pengutronix.de>
 <ecac65a6d53af596b53d115a9e6552a0@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39282 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab3IFThs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Sep 2013 15:37:48 -0400
Content-Disposition: inline
In-Reply-To: <ecac65a6d53af596b53d115a9e6552a0@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de

Hello Wolfgang,

On Fri, Sep 06, 2013 at 05:48:06PM +0200, Wolfgang Grandegger wrote:
> Hi Marc and Uwe,
>=20
> On Fri,  6 Sep 2013 16:30:11 +0200, Marc Kleine-Budde <mkl@pengutroni=
x.de>
> wrote:
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > This file is copied to the source code of user space applications (=
in
> > this case can-utils) and so it makes sense to mention explicitly it=
s
> > copyright. I added the terms of C code that was introduced in the s=
ame
> > commit as this header.
> >=20
> > Cc: Wolfgang Grandegger <wg@grandegger.com>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> > Hello Wolfgang,
> >=20
> > this is the remaining hunk from Uwe's patch that has not been Acked=
=2E
> > Continuing
> > with Uwe's words (adopted):
> >=20
> > I think it is necessary to get the Ack of the people mentioned in
> > the Cc: commit footers. @Wolfgang: I added a statement
> >=20
> >     The provided data structures and external interfaces from this =
code
> >     are not restricted to be used by software with a GPL compatible
> >     license.
> >=20
> > similar to the other can headers. Does that suit you?
>=20
> Is this the common phrase other public header files use as well?
> What's the motivation for that addition. Likely I might
> have missed some related discussion.=20
This is what the headers by Volkswagen are using, but it's only a
suggestion. So it's up to you.

Best regards
Uwe
>=20
>=20
>=20
> Thanks,
>=20
>=20
>=20
> Wolfgang.
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
