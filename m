From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: trouble bringing up can0 interface on intel eg20t chipset
Date: Mon, 10 Feb 2014 17:57:10 +0100
Message-ID: <52F904E6.2060605@pengutronix.de>
References: <52F903EB.8030107@symboticware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IHknqnc4Grv5QqQnLfEDOq0tUVk9hGw9Q"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52288 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbaBJQ5X (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Feb 2014 11:57:23 -0500
In-Reply-To: <52F903EB.8030107@symboticware.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Luc Richer <lricher@symboticware.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IHknqnc4Grv5QqQnLfEDOq0tUVk9hGw9Q
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/10/2014 05:52 PM, Luc Richer wrote:
> I am trying to interface with vehicle engine using Intel EG20T chipset.=

>=20
> This board does have a pinout for CANbus interface, and I believe I hav=
e
> determined the correct module for the interface is pch_can
> http://cateee.net/lkddb/web-lkddb/PCH_CAN.html
> Someone told me I may need the i2c module for this chipset as well, so =
I
> have loaded it also (i2c_eg20t)
>=20
> I have loaded the modules for the can interface (can, can-dev, can-raw,=

> can-bcm) along with i2c_eg20t and pch_can.
>=20
> dmesg | grep can reveals
> can: controller area network core (rev 20120528 abi 9)
> can: raw protocol (rev 20120528)
> can: broadcast manager protocol (rev 20120528 t)

Please send the output of:

    lspci
    ifconfig -a

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--IHknqnc4Grv5QqQnLfEDOq0tUVk9hGw9Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlL5BOYACgkQjTAFq1RaXHMJfACglNc7KYMuD6UYsDaj10ABfLyW
XbYAniar0ZK/kzfSjaWoNN4vMbeWxA9T
=UgjV
-----END PGP SIGNATURE-----

--IHknqnc4Grv5QqQnLfEDOq0tUVk9hGw9Q--
