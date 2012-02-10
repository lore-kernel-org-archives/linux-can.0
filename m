From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can/sja1000: potential issue in sja1000.c?
Date: Fri, 10 Feb 2012 16:37:01 +0100
Message-ID: <4F35399D.2010604@pengutronix.de>
References: <1328281974-11761-1-git-send-email-s.grosjean@peak-system.com> <4F2FF9EE.1060301@volkswagen.de> <4F34F8BC.3030903@peak-system.com> <4F34FC8F.4000104@pengutronix.de> <4F350326.30006@grandegger.com> <4F35388C.5040803@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig132F1DA7725F0EDE0A05F213"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36073 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758016Ab2BJPhG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Feb 2012 10:37:06 -0500
In-Reply-To: <4F35388C.5040803@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig132F1DA7725F0EDE0A05F213
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/10/2012 04:32 PM, Sebastian Haas wrote:
>>> Is 0xff a valid value for REG_SR in the first place? If not we can fo=
r
>>> example exit the interrupt handler.
>>
>> Is the access to the address space of an unplugged card defined at all=
?
>> Or may it even hang the system?
> AFAIK PCMCIA is based on ISA and therefor it is absolutely valid to rea=
d
> and even write into this address space. It is up to user to check if th=
e
> device is still there and accessiable.
>=20
> For that ems_pcmcia does something like this:
> static irqreturn_t ems_pcmcia_interrupt(int irq, void *dev_id)
> {
> ...
>   /* Card not present */
>   if (readw(card->base_addr) !=3D 0xAA55)
>     return IRQ_HANDLED;
>=20
>   Call sja1000_interrupt() ...
> ...
> }

This code just makes the race window smaller, but you still have one.
It's a good idea to limit the number of rounds in the while loop in the
interrupt handler.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig132F1DA7725F0EDE0A05F213
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk81OZ8ACgkQjTAFq1RaXHPJ2QCeM0MGcf2GC6MkUg/onmGunt4q
vi4An1AeUN59yv7dIrVR/srht6T4b3fc
=2B8G
-----END PGP SIGNATURE-----

--------------enig132F1DA7725F0EDE0A05F213--
