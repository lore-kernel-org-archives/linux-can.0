From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Truncate DLC to 8 instead of dropping?
Date: Sat, 1 Sep 2012 20:17:57 +0200
Message-ID: <20120901181757.GC9656@pengutronix.de>
References: <20120831115904.GB2624@pengutronix.de>
 <20120831125021.GB1191@vandijck-laurijssen.be>
 <5040E7C2.4040305@hartkopp.net>
 <20120901173313.GA9656@pengutronix.de>
 <20120901181106.GA425@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40743 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab2IASR6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 1 Sep 2012 14:17:58 -0400
Content-Disposition: inline
In-Reply-To: <20120901181106.GA425@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 01, 2012 at 08:11:06PM +0200, Kurt Van Dijck wrote:
> On Sat, Sep 01, 2012 at 07:33:13PM +0200, Wolfram Sang wrote:
> > On Fri, Aug 31, 2012 at 06:35:14PM +0200, Oliver Hartkopp wrote:
> > > Hello Kurt and Wolfram,
> > >=20
> > > On 31.08.2012 14:50, Kurt Van Dijck wrote:
> > >=20
> > > > On Fri, Aug 31, 2012 at 01:59:04PM +0200, Wolfram Sang wrote:
> > > >> Hi,
> > > >>
> > > >> I just noticed today that commit c7cd606f60e7679c7f9eee7010f02a6f0=
00209c1
> > > >> ("can: Fix data length code handling in rx path") says regarding
> > > >> overlong packets:
> > > >>
> > > >> =3D=3D=3D
> > > >>
> > > >> The ISO 11898-1 Chapter 8.4.2.3 (DLC field) says that register val=
ues > 8
> > > >> should be reduced to 8 without any error reporting or frame drop.
> > > >>
> > > >> =3D=3D=3D
> > > >>
> > > >> and this is why get_can_dlc() came into existance.
> > > >>
> > > >> However, functions like can_dropped_invalid_skb() from dev.h or ca=
n_rcv() from
> > > >> af_can.c do check for a correct length, but drop the packet in the=
 error case.
> > > >> Don't those need to be fixed?
> > > >>
> > > >=20
> > > > Interesting point. My first idea is to acknowledge your thinking, B=
UT:
> > > > * ISO 11898-1 is about the wire format, whereas your issues address
> > > >   higher level interfaces. Higher level interfaces may IMHO use a s=
tricter
> > > >   format that the wire format.
> > >=20
> > >=20
> > > Pointing to the wire format is a good idea.
> > > To me this "dlc error ignoring" requirement is implemented by the CAN
> > > controller. And when the dlc value in the controller register is not =
sanitized
> > > we should do it on driver level.
> >=20
> > If I understand both of you correctly, that means the checks in the
> > functions I mentioned should be removed then?
>=20
> Not completely IMHO. The check in the recv path should not be necessary.

OK. I only meant the rx path.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBCUVUACgkQD27XaX1/VRs5bwCgpP3aRyQXLT3Xmrt3HcRX4OQQ
PDEAnjmjInVJfqWR3mEXq6Z7ekNL9IWf
=wMLH
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
