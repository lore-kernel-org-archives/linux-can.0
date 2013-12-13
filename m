From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: sja1000 interrupt problem
Date: Fri, 13 Dec 2013 11:07:29 +0100
Message-ID: <52AADC61.6010807@pengutronix.de>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <201311131008.55018.pisa@cmp.felk.cvut.cz> <5287E6B2.8020709@hartkopp.net> <85256584a266750b1330cfae8bebd55c@grandegger.com> <5288D236.403@hartkopp.net> <5288FB91.9050703@grandegger.com> <52892B21.9000501@grandegger.com> <CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com> <CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com> <333c0fd4238558062478212eb0704b04@grandegger.com> <CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com> <a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com> <52A71B6C.3050600@hartkopp.net> <8e5f03acb59e16a0ebcd31499a533f15@grandegger.com> <52A73BB1.7070701@hartkopp.net> <52A783B2.5020002@grandegger.com> <52A89A0A.7010803@hartkopp.net> <52A8BC94.6
 010805@grandegger.com> <52A953F3.3000605@hartkopp.net> <52A9F491.3060406@hartkopp.net> <52AA3F16.3070309@grandegger.com> <52AAD5A9.5030607@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CemnlRQutlPAtCGToHbFqTopLdWP0N0JU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54574 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab3LMKHo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Dec 2013 05:07:44 -0500
In-Reply-To: <52AAD5A9.5030607@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>
Cc: Austin Schuh <austin@peloton-tech.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CemnlRQutlPAtCGToHbFqTopLdWP0N0JU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/13/2013 10:38 AM, Oliver Hartkopp wrote:
[...]

> So after some time all CAN related interrupts have been disabled ...
>=20
> I wondered if the PITA access for consuming the bit is really working.
> Therefore I made the if-statement a while statement here:
>=20
> --- linux-source-3.10/drivers/net/can/sja1000/peak_pci.c	2013-09-08 07:=
10:14.000000000 +0200
> +++ linux-source-3.10-rt/drivers/net/can/sja1000/peak_pci.c	2013-12-13 =
08:42:15.850192329 +0100
> @@ -539,12 +539,17 @@
>  static void peak_pci_post_irq(const struct sja1000_priv *priv)
>  {
>  	struct peak_pci_chan *chan =3D priv->priv;
> +#if 0
>  	u16 icr;
> =20
>  	/* Select and clear in PITA stored interrupt */
>  	icr =3D readw(chan->cfg_base + PITA_ICR);
>  	if (icr & chan->icr_mask)
>  		writew(chan->icr_mask, chan->cfg_base + PITA_ICR);
> +#else
> +	while (readw(chan->cfg_base + PITA_ICR) & chan->icr_mask)
> +		writew(chan->icr_mask, chan->cfg_base + PITA_ICR);
> +#endif
>  }
> =20
>  static int peak_pci_probe(struct pci_dev *pdev, const struct pci_devic=
e_id *ent)
>=20
>=20
> This should usually not have any effect, right?
> But what happened was a big crash after a pretty short time:
>=20
> [  760.718091] INFO: rcu_preempt self-detected stall on CPU { 1}  (t=3D=
84015 jiffies g=3D482 c=3D481 q=3D2688)

For me it seems that the new while loop keeps spinning and then the rcu
subsystem detects some stalls.

Maybe it's time to get in touch with the hardware engineers at peak.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--CemnlRQutlPAtCGToHbFqTopLdWP0N0JU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKq3GYACgkQjTAFq1RaXHNfHQCeP0joDbp7Jrf2P6mPTC3klR7K
I20AnAyedQ5ux0yr1jFYjwISnn7+yc+s
=k31U
-----END PGP SIGNATURE-----

--CemnlRQutlPAtCGToHbFqTopLdWP0N0JU--
