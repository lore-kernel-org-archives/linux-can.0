From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] c_can: Add support for eg20t (pch_can)
Date: Thu, 17 Apr 2014 23:27:03 +0200
Message-ID: <53504727.4040605@pengutronix.de>
References: <"<533DB663.3030408@hartkopp.net>"> <1396853523-14941-1-git-send-email-alexander.stein@systec-electronic.com> <53503DFB.1080203@pengutronix.de> <alpine.DEB.2.02.1404172316060.22697@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="e8OEniffP4mt7ObuM1CU39Rmj3mSqf2uS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42100 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbaDQV1K (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Apr 2014 17:27:10 -0400
In-Reply-To: <alpine.DEB.2.02.1404172316060.22697@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e8OEniffP4mt7ObuM1CU39Rmj3mSqf2uS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2014 11:18 PM, Thomas Gleixner wrote:
> On Thu, 17 Apr 2014, Marc Kleine-Budde wrote:
>=20
>> On 04/07/2014 08:52 AM, Alexander Stein wrote:
>>> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com=
>
>> [..]
>>
>>> +static void c_can_pci_reset_pch(const struct c_can_priv *priv, bool =
enable)
>>> +{
>>> +	if (enable) {
>>> +		u32 __iomem *addr =3D priv->base + PCH_PCI_SOFT_RESET;
>>> +
>>> +		/* write to sw reset register */
>>> +		iowrite32(1, addr);
>>
>> Do we need to wait for something here?
>=20
> No. It's activating the "reset line" for that IP block. As long as the
> bit is set the IP is effectivly in HW reset state. Releasing the reset
> brings it back to operation. iowrite32() is serialized by itself, so
> no extra work required.

Thanks Thomas.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--e8OEniffP4mt7ObuM1CU39Rmj3mSqf2uS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNQRycACgkQjTAFq1RaXHMzHACeJBcbRQ+5Q7xtazn41Rnmkyp7
i5QAn2iGCWgurh9xafUFZ/ttMvM+eufq
=2hBU
-----END PGP SIGNATURE-----

--e8OEniffP4mt7ObuM1CU39Rmj3mSqf2uS--
