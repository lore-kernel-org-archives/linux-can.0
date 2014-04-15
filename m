From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Problem with Eurotech COM1273 Dual Channel CAN PC104 Module.
Date: Tue, 15 Apr 2014 14:33:17 +0200
Message-ID: <534D270D.5060705@pengutronix.de>
References: <CA+s8ZrqFBun4bo2rJJFHb0FrV7m7PLybUVM+jjahKsdW8bdnaQ@mail.gmail.com>	<164afc991761b9eeb0eec6902814d00e@grandegger.com>	<534D0F00.7000202@hartkopp.net> <CA+s8Zrqrd_U0g1GRCDzXncgWLA_kO3Hyhjwy6Oe1S0cYohm2og@mail.gmail.com> <534D1F63.6080101@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VBM46MNiH6XPg5ue5gidubwgPhbPwTL1T"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59206 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbaDOMda (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Apr 2014 08:33:30 -0400
In-Reply-To: <534D1F63.6080101@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, khurram gulzar <khurramgulzar@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VBM46MNiH6XPg5ue5gidubwgPhbPwTL1T
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/15/2014 02:00 PM, Oliver Hartkopp wrote:
> As I wrote in the other thread:
>=20
>> The command i am executing is=20
>> modprobe sja1000_isa port=3D0x200,0x204 irq=3D10,11 indirect=3D1=20
>=20
> The parameters for each interface are given separately

The indirect mode is racy, btw....

> static u8 sja1000_isa_port_read_reg_indirect(const struct sja1000_priv =
*priv,
>                                              int reg)
> {
>         unsigned long base =3D (unsigned long)priv->reg_base;
>=20
>         outb(reg, base);
>         return inb(base + 1);
> }
>=20
> static void sja1000_isa_port_write_reg_indirect(const struct sja1000_pr=
iv *priv,
>                                                 int reg, u8 val)
> {
>         unsigned long base =3D (unsigned long)priv->reg_base;
>=20
>         outb(reg, base);
>         outb(val, base + 1);
> }

We need locks.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VBM46MNiH6XPg5ue5gidubwgPhbPwTL1T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNNJw0ACgkQjTAFq1RaXHP2QwCffa79NkQ9i2aOPuHSeB8dZ0gv
n7kAnjwpBgE4qGvYtQb74O6D9RFNIvS3
=em8E
-----END PGP SIGNATURE-----

--VBM46MNiH6XPg5ue5gidubwgPhbPwTL1T--
