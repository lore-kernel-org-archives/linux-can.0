From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [Socketcan-users] AM335x CAN/D_CAN
Date: Wed, 23 May 2012 10:10:19 +0200
Message-ID: <20120523081019.GH30137@pengutronix.de>
References: <CAHvj1qbb9YJSBLZc1bG6MpEJcjPUtr+37wn3iJUNm_OmpH2SgA@mail.gmail.com>
 <4FBBE272.5020807@grandegger.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9C2E10@DBDE01.ent.ti.com>
 <4FBC8B5D.7000302@grandegger.com>
 <4FBC8C25.3050107@pengutronix.de>
 <20120523080713.GG30137@pengutronix.de>
 <4FBC9AF2.2030508@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HuXIgs6JvY9hJs5C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57795 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757182Ab2EWIK0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 May 2012 04:10:26 -0400
Content-Disposition: inline
In-Reply-To: <4FBC9AF2.2030508@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "AnilKumar, Chimata" <anilkumar@ti.com>, bruce bushby <bruce.bushby@gmail.com>, Linux-CAN <linux-can@vger.kernel.org>


--HuXIgs6JvY9hJs5C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 23, 2012 at 10:08:18AM +0200, Marc Kleine-Budde wrote:
> >> I don't have any of the *_CAN hardware. But the driver looks quite
> >> good.  I'm quite busy at the moment, but currently we've the merge
> >> window. I'll do a review now, anyway. Wolfgang can I have your
> >> Acked-by?
> >
> > We have a BeagleBone in the PTX Lab, with an AM3359, which has the
> > CAN port on the extension header. Does that help?
>
> Sure \o/, if our soldermaster can attach it to our CAN network.

I'll ask him when he's in the office :-)

However, you might need to port mainline linux to it first...

rsc
--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--HuXIgs6JvY9hJs5C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iD8DBQFPvJtr+8z+IKgDhyARAge4AJ9OvQItZ21tp+Puu9J6oqQ0YO3naQCeMSf+
tbSrjF3B7QR0ttFQv3qigBA=
=7kIp
-----END PGP SIGNATURE-----

--HuXIgs6JvY9hJs5C--
