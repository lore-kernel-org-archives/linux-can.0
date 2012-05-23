From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [Socketcan-users] AM335x CAN/D_CAN
Date: Wed, 23 May 2012 10:07:13 +0200
Message-ID: <20120523080713.GG30137@pengutronix.de>
References: <CAHvj1qbb9YJSBLZc1bG6MpEJcjPUtr+37wn3iJUNm_OmpH2SgA@mail.gmail.com>
 <4FBBE272.5020807@grandegger.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9C2E10@DBDE01.ent.ti.com>
 <4FBC8B5D.7000302@grandegger.com>
 <4FBC8C25.3050107@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cW+P/jduATWpL925"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50400 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757152Ab2EWIHT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 May 2012 04:07:19 -0400
Content-Disposition: inline
In-Reply-To: <4FBC8C25.3050107@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "AnilKumar, Chimata" <anilkumar@ti.com>, bruce bushby <bruce.bushby@gmail.com>, Linux-CAN <linux-can@vger.kernel.org>


--cW+P/jduATWpL925
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marc,

On Wed, May 23, 2012 at 09:05:09AM +0200, Marc Kleine-Budde wrote:
> > Yes, I think we should push it forward, even if the C_CAN part
> > remains untested for the moment. IIRC, the patch series is already
> > in a good shape. I personally do also not have a board with a C_CAN
> > controller at hand. Marc, what is your opinion?
>
> I don't have any of the *_CAN hardware. But the driver looks quite
> good.  I'm quite busy at the moment, but currently we've the merge
> window. I'll do a review now, anyway. Wolfgang can I have your
> Acked-by?

We have a BeagleBone in the PTX Lab, with an AM3359, which has the CAN
port on the extension header. Does that help?

rsc
--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--cW+P/jduATWpL925
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iD8DBQFPvJqx+8z+IKgDhyARAly5AKCKBL6XcP8yNQ11xH/TudAFiILx5QCfcKzH
e8+Ht4lLLdR24TGLL0MCOQo=
=nTWX
-----END PGP SIGNATURE-----

--cW+P/jduATWpL925--
