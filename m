From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: at91_can.c: Data transmission stops
Date: Wed, 28 Nov 2012 15:56:49 +0100
Message-ID: <50B62631.8070606@pengutronix.de>
References: <50B37C90.3040904@rosetechnology.dk> <50B389D6.4050308@grandegger.com> <50B398E6.2070101@rosetechnology.dk> <50B4CA2D.5080309@rosetechnology.dk> <50B4EAE1.6070400@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3210BC2B87E5B2B35FFC5C94"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34431 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392Ab2K1O45 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Nov 2012 09:56:57 -0500
In-Reply-To: <50B4EAE1.6070400@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Henrik Bork Steffensen <hbs@rosetechnology.dk>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3210BC2B87E5B2B35FFC5C94
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/27/2012 05:31 PM, Wolfgang Grandegger wrote:
[...]

> As mentioned above, on the c_can there is definitely a race with the
> message ram due to the busy wait after accessing it. See:
>=20
>   http://lxr.linux.no/#linux+v3.6.8/drivers/net/can/c_can/c_can.c#L237
>=20
>> Or is it the potential race between "c_can_start_xmit" and "c_can_do_t=
x" ?
>> Or even the access to the net api?
>>
>> Would someone care to explain?
>=20
> I will try. In at91_start_xmit, if we get interrupted
>=20
> 	if (!(at91_read(priv, AT91_MSR(get_tx_next_mb(priv))) &
>               AT91_MSR_MRDY) ||
>              (priv->tx_next & get_next_mask(priv)) =3D=3D 0)
>=20
> 		/* HERE */
>=20
> 		netif_stop_queue(dev);
>=20
> and then at91_irq_tx() is called executing netif_wake_queue() we may en=
d
> up with a stopped tx queue. But I'm not yet 100% sure.

I don't think so, because after this follows[1]

	/* Enable interrupt for this mailbox */
	at91_write(priv, AT91_IER, 1 << mb);

[1] http://lxr.free-electrons.com/source/drivers/net/can/at91_can.c#L524

So first the queued ist stopped, then the interrupt activated.

Then in the interrupt handler[2], [3]:

	reg_sr =3D at91_read(priv, AT91_SR);
	reg_imr =3D at91_read(priv, AT91_IMR);

	reg_sr &=3D reg_imr;

=2E..

	if (reg_sr & AT91_IRQ_MB_TX)
		at91_irq_tx(dev, reg_sr);

[2] http://lxr.free-electrons.com/source/drivers/net/can/at91_can.c#L1081=

[3] http://lxr.free-electrons.com/source/drivers/net/can/at91_can.c#L1104=


The at91_irq_tx() function works on the reg_sr.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig3210BC2B87E5B2B35FFC5C94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC2JjUACgkQjTAFq1RaXHOEFwCfVNxlCprEi37UE2qIm0J0kdh1
y3IAoIuxghy6ihVhA+iWvY3UF9Nv6Ptl
=FpoQ
-----END PGP SIGNATURE-----

--------------enig3210BC2B87E5B2B35FFC5C94--
