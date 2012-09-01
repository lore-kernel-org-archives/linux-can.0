From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Truncate DLC to 8 instead of dropping?
Date: Sat, 1 Sep 2012 19:33:13 +0200
Message-ID: <20120901173313.GA9656@pengutronix.de>
References: <20120831115904.GB2624@pengutronix.de>
 <20120831125021.GB1191@vandijck-laurijssen.be>
 <5040E7C2.4040305@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44098 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab2IARdO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 1 Sep 2012 13:33:14 -0400
Content-Disposition: inline
In-Reply-To: <5040E7C2.4040305@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>, linux-can@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2012 at 06:35:14PM +0200, Oliver Hartkopp wrote:
> Hello Kurt and Wolfram,
>=20
> On 31.08.2012 14:50, Kurt Van Dijck wrote:
>=20
> > On Fri, Aug 31, 2012 at 01:59:04PM +0200, Wolfram Sang wrote:
> >> Hi,
> >>
> >> I just noticed today that commit c7cd606f60e7679c7f9eee7010f02a6f00020=
9c1
> >> ("can: Fix data length code handling in rx path") says regarding
> >> overlong packets:
> >>
> >> =3D=3D=3D
> >>
> >> The ISO 11898-1 Chapter 8.4.2.3 (DLC field) says that register values =
> 8
> >> should be reduced to 8 without any error reporting or frame drop.
> >>
> >> =3D=3D=3D
> >>
> >> and this is why get_can_dlc() came into existance.
> >>
> >> However, functions like can_dropped_invalid_skb() from dev.h or can_rc=
v() from
> >> af_can.c do check for a correct length, but drop the packet in the err=
or case.
> >> Don't those need to be fixed?
> >>
> >=20
> > Interesting point. My first idea is to acknowledge your thinking, BUT:
> > * ISO 11898-1 is about the wire format, whereas your issues address
> >   higher level interfaces. Higher level interfaces may IMHO use a stric=
ter
> >   format that the wire format.
>=20
>=20
> Pointing to the wire format is a good idea.
> To me this "dlc error ignoring" requirement is implemented by the CAN
> controller. And when the dlc value in the controller register is not sani=
tized
> we should do it on driver level.

If I understand both of you correctly, that means the checks in the
functions I mentioned should be removed then?

Fine with me if this is consistent, I just wondered if it wasn't nice to
have a check in an upper layer in case the driver did not correctly
implement the check.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBCRtgACgkQD27XaX1/VRvQgACfTqCMio3PkfzVoil3AIP8hSUH
n3QAn1sKkMBLhMSyJj4TXdAS9qKB8vKV
=Ed0q
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
