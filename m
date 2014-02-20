From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Bug#568303: can-utils Debian package
Date: Thu, 20 Feb 2014 10:51:31 +0100
Message-ID: <20140220095131.GG6988@pengutronix.de>
References: <CAGm1_ktzQgs92L0RxoVYGVhbb88hZi9dQACF8=pazYHouXh-1w@mail.gmail.com>
 <4947876.WXEsvsyjiy@shelbyville.comnets.uni-bremen.de>
 <20140115200207.512cf5e8@snail>
 <20140123183951.GA20892@perseus.defre.xn--kleine-knig-yfb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56453 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbaBTJvu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Feb 2014 04:51:50 -0500
Content-Disposition: inline
In-Reply-To: <20140123183951.GA20892@perseus.defre.xn--kleine-knig-yfb.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander GQ Gerasiov <gq@cs.msu.su>, 568303@bugs.debian.org
Cc: Markus Becker <mab@comnets.uni-bremen.de>, Yegor Yefremov <yegorslists@googlemail.com>, linux-can@vger.kernel.org, debian-devel@lists.debian.org

Hello Alexander, hello *,

On Thu, Jan 23, 2014 at 07:39:51PM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Jan 15, 2014 at 08:02:07PM +0400, Alexander GQ Gerasiov wrote=
:
> > > On Wednesday 15 January 2014 12:40:52 you wrote:
> > > > I've notice some progress on the issue:
> > > >=20
> > > > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D568303
> > > >=20
> > > > If Alexander won't post anything to this bug, where can I find =
the
> > > > package archives, he was talking about?
> > >=20
> > > He was talking about collab-maint:
> > >=20
> > > http://anonscm.debian.org/gitweb/?p=3Dcollab-maint/can-modules.gi=
t;a=3Dsummary
> > > http://anonscm.debian.org/gitweb/?p=3Dcollab-maint/can-utils.git;=
a=3Dsummary
> > >=20
> > > Anyone can join collab-maint, you don't need to be Debian develop=
er.
> > > It would be good if you two coordinate. CCing Alexander therefore=
=2E
> >=20
> > I'm in heavy reformatting package from the link above. (Only can-ut=
ils,
> > cause I use vanilla kernel's modules.)
> I started creating a debian package from scratch, too, before being
> aware of this bug. My plan was to sent the ITP bug once the package i=
s
> ready together with an RFS (as I'm only DM).
> =20
> > Right now I've asked my college to make clean-room rewrite of some
> > lines in slcand.c, because it has licensing issues. (Mix of GPL and
> > GFDL licensed code.)
> This is resolved upstream in commit
> 393a91c7d8f6 (slcand: reimplement daemonize routine).
>=20
> > I think I'll do an upload this week or the next one. If you have an=
y
> > ideas or want to join packaging on alioth, you're welcome. But plea=
se
> > contact me prior any work, because current version on alioth is ver=
y
> > different from one I'm working on. (And because of many changes I d=
on't
> > see a reason to upload broken state into git repo right now.)
> I'll rebase my packaging stuff, fixup for the latest changes and will
> let you know. Maybe we can work together then and pick the best thing=
s
> from both approaches.
I finished my packaging stuff nearly a month ago and contacted Alexande=
r
by private mail without response so far. My efforts are available at

	http://git.pengutronix.de/?p=3Dukl/can-utils.git debian/sid

I'd like to get forward here. @Alexander: Maybe you can provide me with
the work you did already, then I'll merge our approaches. Are you still
interested in co-maintainance of can-utils? If not, are you OK when I
take ownership of this bug and start looking for a sponsor?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
