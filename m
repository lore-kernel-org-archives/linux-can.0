From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Bug#568303: can-utils Debian package
Date: Mon, 24 Feb 2014 09:25:29 +0100
Message-ID: <20140224082529.GC27579@pengutronix.de>
References: <CAGm1_ktzQgs92L0RxoVYGVhbb88hZi9dQACF8=pazYHouXh-1w@mail.gmail.com>
 <4947876.WXEsvsyjiy@shelbyville.comnets.uni-bremen.de>
 <20140115200207.512cf5e8@snail>
 <20140123183951.GA20892@perseus.defre.xn--kleine-knig-yfb.de>
 <20140220095131.GG6988@pengutronix.de>
 <1444f73d090.27d4.77cf013f3ec6cb326b88fe89a2c6c054@cs.msu.su>
 <20140224104448.66d46355@snail>
 <20140224070825.GA31051@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50785 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbaBXIZn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 24 Feb 2014 03:25:43 -0500
Content-Disposition: inline
In-Reply-To: <20140224070825.GA31051@physik.fu-berlin.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Alexander GQ Gerasiov <gq@cs.msu.su>, 568303@bugs.debian.org, Markus Becker <mab@comnets.uni-bremen.de>, Yegor Yefremov <yegorslists@googlemail.com>, linux-can@vger.kernel.org, debian-devel@lists.debian.org

Hi Adrian,

On Mon, Feb 24, 2014 at 08:08:25AM +0100, John Paul Adrian Glaubitz wro=
te:
> On Mon, Feb 24, 2014 at 10:44:48AM +0400, Alexander GQ Gerasiov wrote=
:
> > Thu, 20 Feb 2014 17:30:05 +0400
> > Alexander Gerasiov <gq@cs.msu.su> wrote:
> >=20
> > > Sorry guys. I'm totally busy with other tasks last month :-(. As =
I
> > > remember your package is quite ready for upload, so I'll do it
> > > tomorrow (without my changes, just add myself as an uploader if y=
ou
> > > don't mind). Ok?
> >=20
> > As Uwe is worried about correctness I'd like to mention, that I did=
 not
> > use his package as the base for last upload, but incorporated some =
of
> > lines he wrote into my package.
>=20
> That doesn't sound plausible to me given the fact that you imported
> his debian/rules file and commented out his overrride_dh_* statements
> [1].
>=20
> If you had incorporated some of his changes, you'd just have use the
> default rules file from the template.
>=20
> You should also have asked yourself why Uwe had added those overrides
> and not just silently commented them out. If someone adds extra
> overrides, he usually has very good reasons. You should have asked Uw=
e
> about that.
This is wrong, the overrides are not from me. d/rules seems to be
Alexander's (well, or Joey Hess' and Craig Small's) work.

> > Package is in new queue right now and will be soon available in
> > unstable repository.
>=20
> It's actually been set to not be reviewed before February 28th to be
> able to discuss this matter first.
I think the best will be when Alexander and I discuss the issue in
private. I don't see a need to pull that conflict into public.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
