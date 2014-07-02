From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4] flexcan: add err_irq handler for flexcan
Date: Wed, 02 Jul 2014 09:04:12 +0200
Message-ID: <53B3AEEC.4060507@pengutronix.de>
References: <1404201809-7010-1-git-send-email-B45475@freescale.com> <53B287A6.10707@pengutronix.de> <a77a3b25e46f45c4951e0ec517904460@BLUPR03MB341.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GGLLxhCXX9LpIxgRqFM11pHcgSSPBxR7B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52464 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaGBHEe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Jul 2014 03:04:34 -0400
In-Reply-To: <a77a3b25e46f45c4951e0ec517904460@BLUPR03MB341.namprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Scott Wood <scottwood@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GGLLxhCXX9LpIxgRqFM11pHcgSSPBxR7B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/02/2014 04:00 AM, qiang.zhao@freescale.com wrote:
>>> +static irqreturn_t flexcan_err_irq(int irq, void *dev_id) {
>>> +	struct net_device *dev =3D dev_id;
>>> +	struct flexcan_priv *priv =3D netdev_priv(dev);
>>> +	struct flexcan_regs __iomem *regs =3D priv->base;
>>> +	u32 reg_ctrl, reg_esr;
>>> +
>>> +	reg_esr =3D flexcan_read(&regs->esr);
>>> +	reg_ctrl =3D flexcan_read(&regs->ctrl);
>>> +
>>> +	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
>>> +		if (reg_esr & FLEXCAN_ESR_ERR_INT)
>>> +			flexcan_write(reg_ctrl & ~FLEXCAN_CTRL_ERR_MSK,
>>> +				      &regs->ctrl);
>>> +		flexcan_irq(irq, dev);
>>
>> I still don't understand why you need a special flexcan_err_irq()
>> function. Why don't you just call:
>>
>> request_irq(priv->err_irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
>>
>> instead?
>=20
> Flexcan_irq is for flexcan normal interrupt(such as Message Buffer, Wak=
e up and so on).
> And it will return IRQ_HANDLED if flexcan_irq is triggered.
> But err_irq is shared with other devices, it should return IRQ_HANDLED =
when the interrupt=20
> is triggered by flexcan device, if not return IRQ_NONE.

What about fixing flexcan_irq() first and the make use of it?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--GGLLxhCXX9LpIxgRqFM11pHcgSSPBxR7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOzruwACgkQjTAFq1RaXHNIoQCfevQDasjs+wezjMLO3mgwpRGU
4K4AnApL43vz1N7MPuFIkn25fgKGjvmf
=YSao
-----END PGP SIGNATURE-----

--GGLLxhCXX9LpIxgRqFM11pHcgSSPBxR7B--
