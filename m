From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can: c_can: Provide generic interface to configure
 c-can message objects
Date: Thu, 20 Dec 2012 15:04:14 +0100
Message-ID: <50D31ADE.1050308@pengutronix.de>
References: <cover.1355996839.git.amit.virdi@st.com> <cf2aa76940e89dc91564cf4962d23e58bec432b0.1355996839.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6828472F98A123992D8E14D7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39775 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab2LTOEU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Dec 2012 09:04:20 -0500
In-Reply-To: <cf2aa76940e89dc91564cf4962d23e58bec432b0.1355996839.git.amit.virdi@st.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Amit Virdi <amit.virdi@st.com>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, bhupesh.sharma@st.com, anilkumar@ti.com, spear-devel@list.st.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6828472F98A123992D8E14D7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/20/2012 11:05 AM, Amit Virdi wrote:
> Depending on the underlying platform, the configuration of the c-can
> message objects can change. For e.g. in some systems, it makes more
> sense to receive many message objects and transmit very few. In any
> case, providing flexibility in configuring the message objects is highl=
y
> desirable.
>=20
> The total number of message objects for C_CAN controller is fixed at 32=
=2E
> The receive message objects are assigned higher priority so they begin
> with message object#1. So, in order to configure the message object the=

> driver just needs two parameters - rx_split (for differentiating betwee=
n
> lower bucket and higher bucket) and tx_num.
>=20
> However, if the user doesn't specify these parameters, then the message=

> objects are configured with default parameters with equal distribution
> of receive and transmit message objects (16 each).

As Wolfgang pointed out, the DT should only describe the hardware. In
the ethernet world I think there is ethtool to configure the hardware.
Maybe we need something similar for CAN (or add CAN support to ethtool).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig6828472F98A123992D8E14D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEUEARECAAYFAlDTGt4ACgkQjTAFq1RaXHPCAQCfUY33p4xewKCY7jG0U3AyUOrv
IUAAmJNgFPrW7RYnKYT4hsbX7E1Qg5s=
=xCpq
-----END PGP SIGNATURE-----

--------------enig6828472F98A123992D8E14D7--
