From: Reuben Dowle <Reuben.Dowle@navico.com>
Subject: RE: [libsocketcan] Add can_get_link_stats() - v2
Date: Wed, 7 Mar 2012 23:45:39 +0000
Message-ID: <6686CF564BC462488080D46D3C933CA408A44C@EXCH02-AKLNZ.MARINE.NET.INT>
References: <6686CF564BC462488080D46D3C933CA4089AA6@EXCH02-AKLNZ.MARINE.NET.I
 NT><4F572E15.2050304@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vw-hfger.navico.com ([81.89.228.210]:3398 "EHLO
	VW-HFGER.navico.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457Ab2CGXp5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 18:45:57 -0500
In-Reply-To: <4F572E15.2050304@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Sounds like good change. I will re-submit a patch when I have a spare m=
oment (probably next week).

REUBEN DOWLE | DESIGN ENGINEER | NAVICO AUCKLAND
=A0
Confidentiality Notice | This message may contain confidential and/or p=
rivileged information. If you are not the addressee or authorized to re=
ceive this for the addressee, you must not use, copy, disclose or take =
any action based on this message or any information herein. If you have=
 received this message in error, please advise the sender immediately b=
y reply e-mail and delete this message. Thank you for your cooperation


> -----Original Message-----
> From: Marc Kleine-Budde [mailto:mkl@pengutronix.de]
> Sent: Wednesday, March 07, 2012 10:45 PM
> To: Reuben Dowle
> Cc: linux-can@vger.kernel.org
> Subject: Re: [libsocketcan] Add can_get_link_stats() - v2
>=20
> On 03/06/2012 08:04 PM, Reuben Dowle wrote:
> > Add can_get_link_stats()
> >
> > This function gets link_stats64 information for the can interface.
> > This structure can be for any interface (not just can), but it seem=
s
> > logical to keep functions for getting any statistics relevant to CA=
N
> > in this library.
> >
> > Signed-off-by: Reuben Dowle <reuben.dowle@navico.com>
>=20
> I was at iCC2012 CAN conference, now I've some more time to look at t=
he
> code. What about naming the function after the struct? Seems more
> consistent to me.
>=20
> > +int can_get_link_stats(const char *name, struct rtnl_link_stats64
> > +*ls)
>=20
> I mean "can_get_link_stats64" instead of "can_get_link_stats"?
>=20
> Marc
>=20
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



