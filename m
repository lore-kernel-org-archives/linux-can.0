From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can/sja1000: potential issue in sja1000.c?
Date: Fri, 10 Feb 2012 12:16:31 +0100
Message-ID: <4F34FC8F.4000104@pengutronix.de>
References: <1328281974-11761-1-git-send-email-s.grosjean@peak-system.com> <4F2FF9EE.1060301@volkswagen.de> <4F34F8BC.3030903@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC2DB5ED39DDAADD2118C6C7F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35204 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab2BJLQh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Feb 2012 06:16:37 -0500
In-Reply-To: <4F34F8BC.3030903@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC2DB5ED39DDAADD2118C6C7F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/10/2012 12:00 PM, Stephane Grosjean wrote:
> Hi all,
>=20
> While always fighting against pcmcia Oliver (very hot) unplug issue, I
> decided to have a look to the sja1000 lib, since the pcmcia driver ISR
> does call "sja1000_interrupt()",
>=20
> Unfortunately, I found that:
>=20
>                 if (isrc & IRQ_RI) {
>                         /* receive interrupt */
>                         while (status & SR_RBS) {
>                                 sja1000_rx(dev);
>                                 status =3D priv->read_reg(priv, REG_SR)=
;
>                         }
>                 }
>=20
> My problem is, once the card is unplugged, every ioread in its
> corresponding io space does return 0xff...
> I just change this potential infinite while() into a corresponding
> for(;;) loop to test, like this:
>=20
> -                        while (status & SR_RBS) {
> +                        int i;
> +                        for (i =3D 0; (status & SR_RBS) && (i < 10); i=
++) {
>=20
> And no more PC hang!
>=20
> Can you confirm this, please?
>=20
> @Oliver: IMHO, the 0xff (invalid) value is also the reason of the
> "wakeup interrupt" message you got when unplugging the cards from their=

> slots...

Is 0xff a valid value for REG_SR in the first place? If not we can for
example exit the interrupt handler.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigC2DB5ED39DDAADD2118C6C7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk80/JMACgkQjTAFq1RaXHMuTgCeJ/A6+/CYWtybZsSa5vcKbhJO
feQAn3694L+MdjfZLlSK2tmbqHgmeQJf
=nod9
-----END PGP SIGNATURE-----

--------------enigC2DB5ED39DDAADD2118C6C7F--
