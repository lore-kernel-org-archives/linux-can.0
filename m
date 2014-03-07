From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: FlexCAN on i.MX28 interrupt flooding retrying send
Date: Fri, 07 Mar 2014 15:40:26 +0100
Message-ID: <5319DA5A.7080003@pengutronix.de>
References: <53197E8A.5050409@meduna.org> <53198753.8000900@pengutronix.de> <5319CB58.4070708@meduna.org> <5319CFA7.7040402@pengutronix.de> <OFA84C0F6D.092C777B-ON86257C94.004E3F0B-86257C94.004F1F2D@notes.cat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JQXgvMtTSIx81uST91bBvDhfSLHjPkajf"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52346 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbaCGOki (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Mar 2014 09:40:38 -0500
In-Reply-To: <OFA84C0F6D.092C777B-ON86257C94.004E3F0B-86257C94.004F1F2D@notes.cat.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jason R1 White <White_Jason_R1@cat.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JQXgvMtTSIx81uST91bBvDhfSLHjPkajf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/07/2014 03:24 PM, Jason R1 White wrote:
> Marc,
>=20
> What do you mean that flexcan driver doesn't have the improvement for t=
he
> mx28?  What do you mean by non DT?  I see e358784 in the kernel tree, b=
ut

Your flexcan driver does always enable bus errors, because on most older
socks you need the bus errors as a workaround to detect the warning and
passive interrupt. With modern kernel on the mx28, the bus error is not
enabled by default.

In the development of the kernel, the mx28 was first switched to Device
Tree (DT) only, then we figured out, that the mx28 doesn't have the
above mentioned problem and the bus error is disabled by default.

> we are not yet picking it up.  Is there any other fixes for the mx28 th=
at
> you are aware of?  Can you send the patch set for the berror_limit?  We=

> experienced a lot of issues with the error interrupt causing a lot of
> cpu usage and ended up having to disable it.  Normally I like to at
> least detect the bus error condition.

I'm in the hot phase of two projects, so it will take some time to dig
into the berr_limit again, as it needs some work.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--JQXgvMtTSIx81uST91bBvDhfSLHjPkajf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMZ2loACgkQjTAFq1RaXHM2dQCeMO4MLsdcCp2OWvfesvFTd6om
FOcAnjdPWADE1RqRF3VO45swh8R0sZ/m
=oT7V
-----END PGP SIGNATURE-----

--JQXgvMtTSIx81uST91bBvDhfSLHjPkajf--
