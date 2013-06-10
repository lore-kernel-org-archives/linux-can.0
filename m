From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] flexcan: Enable/Disable the CAN regulator in probe/remove
Date: Mon, 10 Jun 2013 22:39:16 +0200
Message-ID: <51B63974.2000100@pengutronix.de>
References: <1370460445-15386-1-git-send-email-festevam@gmail.com> <1370460445-15386-2-git-send-email-festevam@gmail.com> <51B606C0.1070407@pengutronix.de> <CAOMZO5CEWHTyw3s+vLtOVMdWmNWUndOZ3E4ohpCyTFXiz+VEOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2RTMQWPSICOWLSWMCJLHU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36061 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab3FJUjZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 16:39:25 -0400
In-Reply-To: <CAOMZO5CEWHTyw3s+vLtOVMdWmNWUndOZ3E4ohpCyTFXiz+VEOQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2RTMQWPSICOWLSWMCJLHU
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/10/2013 09:05 PM, Fabio Estevam wrote:
> Hi Marc,
>=20
> On Mon, Jun 10, 2013 at 2:02 PM, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:
>> On 06/05/2013 09:27 PM, Fabio Estevam wrote:
>>> mx28evk has two CAN ports and they are controlled by the same GPIO.
>>>
>>> If can0 runs flexcan_chip_stop(), then the regulator will be disabled=
, which
>>> means that can1 cannot run anymore.
>>
>> Are you sure? I think the regulator framework has a proper refcount.
>=20
> Yes, the refcount is OK. The problem is that on mx28evk we have two
> CAN ports controlled by the same regulator.
>=20
> Let's say that can0 executes flexcan_chip_stop:
>=20
> static void flexcan_chip_stop(struct net_device *dev)
> {
> 	struct flexcan_priv *priv =3D netdev_priv(dev);
> 	struct flexcan_regs __iomem *regs =3D priv->base;
> 	u32 reg;
>=20
> 	/* Disable all interrupts */
> 	flexcan_write(0, &regs->imask1);
>=20
> 	/* Disable + halt module */
> 	reg =3D flexcan_read(&regs->mcr);
> 	reg |=3D FLEXCAN_MCR_MDIS | FLEXCAN_MCR_HALT;
> 	flexcan_write(reg, &regs->mcr);
>=20
>         if (priv->reg_xceiver)
> 	        regulator_disabled(priv->reg_xceiver);
> ...
>=20
> It will turn off the transceiver here, which means that can1 will not
> be able to operate.
>=20
> Currently this situation is properly handled inside mach-mxs by only
> disabling the CAN transceiver when both CAN ports are not used.

Why don't you enable the regulator in can1, too?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2RTMQWPSICOWLSWMCJLHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlG2OXcACgkQjTAFq1RaXHNMFQCgkX2dekIiQyjCIk3mfbu2kDmr
dAsAnigsQFCZ34ax0GmEh61ibWxr47/6
=3DVU
-----END PGP SIGNATURE-----

------enig2RTMQWPSICOWLSWMCJLHU--
