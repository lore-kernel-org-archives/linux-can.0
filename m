From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Wed, 21 Mar 2012 14:51:43 +0100
Message-ID: <4F69DCEF.20800@pengutronix.de>
References: <20120321091055.GA433@vandijck-laurijssen.be> <20120321120846.GB3372@vandijck-laurijssen.be> <4F69CA74.3020607@pengutronix.de> <1683048.Xku7xyE0R6@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig10D7B1189066C6C0D84C93E8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43954 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359Ab2CUNvz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Mar 2012 09:51:55 -0400
In-Reply-To: <1683048.Xku7xyE0R6@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: dev@sebastianhaas.info, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig10D7B1189066C6C0D84C93E8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/21/2012 02:29 PM, Alexander Stein wrote:
>> Further, there are only certain dlc values allowed for CAN FD. We must=

>> decide if the enforce these values or simply do padding with "0" somew=
here.
>=20
> What I understand from the proposal is that DLCs >8 are optional. So yo=
u might=20
> get hardware which still supports only 8 bytes. How can/should this be =

> handled?

I haven't read the pdf that Kurt linked in the original mail. Is the
usage of dlc > 8 optional or the support of dlc > 8 in hardware?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig10D7B1189066C6C0D84C93E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9p3PIACgkQjTAFq1RaXHPB8gCeJaOMNW+IddHYx3v/DFnfx11c
7EkAoIjfjgAGS5XUoITg9tkTAdG2yhEe
=awFC
-----END PGP SIGNATURE-----

--------------enig10D7B1189066C6C0D84C93E8--
