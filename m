From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [patch V2 12/21] can: c_can": Work around C_CAN RX wreckage
Date: Mon, 14 Apr 2014 22:17:44 +0200
Message-ID: <534C4268.50800@pengutronix.de>
References: <20140411080547.845836199@linutronix.de> <20140411080652.540058139@linutronix.de> <1607542.s21fNX8q9K@ws-stein> <alpine.DEB.2.02.1404142212530.22697@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mW5TghWoCnohPq6tt90aBlNjJAb2dMS7t"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34308 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343AbaDNURz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Apr 2014 16:17:55 -0400
In-Reply-To: <alpine.DEB.2.02.1404142212530.22697@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mW5TghWoCnohPq6tt90aBlNjJAb2dMS7t
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/14/2014 10:13 PM, Thomas Gleixner wrote:
> On Mon, 14 Apr 2014, Alexander Stein wrote:
>=20
>> I think the " in the subject got there by accident :-)
>=20
> Definitely :)

I'll fix this while applying.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--mW5TghWoCnohPq6tt90aBlNjJAb2dMS7t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNMQmgACgkQjTAFq1RaXHN2aACfeQJekcCpAFpQlX+q1EdRtLh9
m5IAn3Jo8jZr4W/6dAENC+VxZhcHucHr
=3LTe
-----END PGP SIGNATURE-----

--mW5TghWoCnohPq6tt90aBlNjJAb2dMS7t--
