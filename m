From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Socketcan-users] Finding a transmitter's CAN ID
Date: Mon, 19 Aug 2013 16:59:57 +0200
Message-ID: <521232ED.4050607@pengutronix.de>
References: <1376923439605-7678.post@n3.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IfH74jN4Ww8HlJFnPPJ5F1Qqxj6EcidgL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58694 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab3HSPAH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Aug 2013 11:00:07 -0400
In-Reply-To: <1376923439605-7678.post@n3.nabble.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Rob__V <r.valler@enextra.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IfH74jN4Ww8HlJFnPPJ5F1Qqxj6EcidgL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Rob,

please come to the new mailinglist inux-can@vger.kernel.org

Marc

On 08/19/2013 04:43 PM, Rob__V wrote:
> Hi all,
>=20
> I am currently working on a project with several embedded platforms con=
nect
> via CAN:
> 1 x Linux board connected via SocketCAN
> N x embedded boards using the Atmega16M1 (CAN) MCU.
>=20
> The Linux board is 'treated' as the master and needs to know the CAN ID=
 of
> each
> atmega board that sends it a CAN message. So my question is :
>=20
> How is the Linux/SocketCAN board able to determine the CAN ID of other
> networked nodes when they transmit ?
>=20
> Of course, each CAN node can determine the target ID for each message b=
ut
> I am not sure if the source ID is known ... outside of arbitration.
>=20
>=20
> Thank you for your time.
>=20
> All the best,
> Rob
>=20
>=20
>=20
> --
> View this message in context: http://socket-can.996257.n3.nabble.com/Fi=
nding-a-transmitter-s-CAN-ID-tp7678.html
> Sent from the Socket-CAN Users mailing list archive at Nabble.com.
> _______________________________________________
> Socketcan-users mailing list
> Socketcan-users@lists.berlios.de
> https://lists.berlios.de/mailman/listinfo/socketcan-users
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--IfH74jN4Ww8HlJFnPPJ5F1Qqxj6EcidgL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlISMu0ACgkQjTAFq1RaXHPN6gCdFrz1bAqWxOlncmnKl8XNMBZq
KzAAn3kiMuwXSWybQ5lQalK9sCAebOYC
=MMTU
-----END PGP SIGNATURE-----

--IfH74jN4Ww8HlJFnPPJ5F1Qqxj6EcidgL--
