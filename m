From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Populating netdev::dev_id for udev discrimination
Date: Tue, 11 Mar 2014 20:08:04 +0100
Message-ID: <531F5F14.50302@pengutronix.de>
References: <1394294420.3356.15.camel@NREC-014563> <531CBB6F.7090803@pengutronix.de> <531D6D3B.9020900@hartkopp.net> <20140310104650.GA456@vandijck-laurijssen.be> <531D9B6F.9010603@pengutronix.de> <531DAD8F.7090602@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PJ2QjBWqO2RruUHmBAjubtnW0BD7fJBFq"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32774 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbaCKTIL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Mar 2014 15:08:11 -0400
In-Reply-To: <531DAD8F.7090602@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PJ2QjBWqO2RruUHmBAjubtnW0BD7fJBFq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/10/2014 01:18 PM, Oliver Hartkopp wrote:
>> You can create a patch against the testing branch of linux-can-next[1]=

>=20
> FYI:
>=20
> Tested with PEAK PCAN USB pro and EMS PCMCIA (both with two channels) a=
nd the
> dev_id works like expected (first channel dev_id =3D 0x0, second channe=
l 0x1).

Can I add your Tested-by for the Peak and the EMS?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PJ2QjBWqO2RruUHmBAjubtnW0BD7fJBFq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMfXxQACgkQjTAFq1RaXHNKEgCeOss2laudmciazJafx5B4lLrE
y90AniA4+/9NZAIVTOyYKcJc+c5HTeiK
=jmyz
-----END PGP SIGNATURE-----

--PJ2QjBWqO2RruUHmBAjubtnW0BD7fJBFq--
