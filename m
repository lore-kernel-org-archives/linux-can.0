From: Alexander Gerasiov <gq@cs.msu.su>
Subject: Re: Bug#568303: can-utils Debian package
Date: Thu, 20 Feb 2014 17:30:05 +0400
Message-ID: <1444f73d090.27d4.77cf013f3ec6cb326b88fe89a2c6c054@cs.msu.su>
References: <CAGm1_ktzQgs92L0RxoVYGVhbb88hZi9dQACF8=pazYHouXh-1w@mail.gmail.com>
 <4947876.WXEsvsyjiy@shelbyville.comnets.uni-bremen.de>
 <20140115200207.512cf5e8@snail>
 <20140123183951.GA20892@perseus.defre.xn--kleine-knig-yfb.de>
 <20140220095131.GG6988@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eol.lvk.cs.msu.su ([158.250.17.73]:42107 "EHLO
	eol.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbaBTNaN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Feb 2014 08:30:13 -0500
In-Reply-To: <20140220095131.GG6988@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, 568303@bugs.debian.org
Cc: Markus Becker <mab@comnets.uni-bremen.de>, Yegor Yefremov <yegorslists@googlemail.com>, linux-can@vger.kernel.org, debian-devel@lists.debian.org

Sorry guys. I'm totally busy with other tasks last month :-(. As I reme=
mber=20
your package is quite ready for upload, so I'll do it tomorrow (without=
 my=20
changes, just add myself as an uploader if you don't mind). Ok?


On February 20, 2014 1:52:19 PM Uwe Kleine-K=C3=B6nig=20
<u.kleine-koenig@pengutronix.de> wrote:

> Hello Alexander, hello *,
>
> On Thu, Jan 23, 2014 at 07:39:51PM +0100, Uwe Kleine-K=C3=B6nig wrote=
:
> > On Wed, Jan 15, 2014 at 08:02:07PM +0400, Alexander GQ Gerasiov wro=
te:
> > > > On Wednesday 15 January 2014 12:40:52 you wrote:
> > > > > I've notice some progress on the issue:
> > > > > > > > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D5683=
03
> > > > > > > > If Alexander won't post anything to this bug, where can=
 I=20
> find the
> > > > > package archives, he was talking about?
> > > > > > He was talking about collab-maint:
> > > > > >=20
> http://anonscm.debian.org/gitweb/?p=3Dcollab-maint/can-modules.git;a=3D=
summary
> > > > http://anonscm.debian.org/gitweb/?p=3Dcollab-maint/can-utils.gi=
t;a=3Dsummary
> > > > > > Anyone can join collab-maint, you don't need to be Debian d=
eveloper.
> > > > It would be good if you two coordinate. CCing Alexander therefo=
re.
> > > > I'm in heavy reformatting package from the link above. (Only ca=
n-utils,
> > > cause I use vanilla kernel's modules.)
> > I started creating a debian package from scratch, too, before being
> > aware of this bug. My plan was to sent the ITP bug once the package=
 is
> > ready together with an RFS (as I'm only DM).
> > > Right now I've asked my college to make clean-room rewrite of som=
e
> > > lines in slcand.c, because it has licensing issues. (Mix of GPL a=
nd
> > > GFDL licensed code.)
> > This is resolved upstream in commit
> > 393a91c7d8f6 (slcand: reimplement daemonize routine).
> > > I think I'll do an upload this week or the next one. If you have =
any
> > > ideas or want to join packaging on alioth, you're welcome. But pl=
ease
> > > contact me prior any work, because current version on alioth is v=
ery
> > > different from one I'm working on. (And because of many changes I=
 don't
> > > see a reason to upload broken state into git repo right now.)
> > I'll rebase my packaging stuff, fixup for the latest changes and wi=
ll
> > let you know. Maybe we can work together then and pick the best thi=
ngs
> > from both approaches.
> I finished my packaging stuff nearly a month ago and contacted Alexan=
der
> by private mail without response so far. My efforts are available at
>
> 	http://git.pengutronix.de/?p=3Dukl/can-utils.git debian/sid
>
> I'd like to get forward here. @Alexander: Maybe you can provide me wi=
th
> the work you did already, then I'll merge our approaches. Are you sti=
ll
> interested in co-maintainance of can-utils? If not, are you OK when I
> take ownership of this bug and start looking for a sponsor?
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig   =
         |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |


