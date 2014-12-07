From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: slcan/vcan: eliminate banner[] variable, switch
 to pr_info()
Date: Sun, 07 Dec 2014 21:18:09 +0100
Message-ID: <5484B601.8070609@pengutronix.de>
References: <1417596244-5743-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GLiWTMR0IA3X3eqrjn2GJo9c7lGFe874c"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57954 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbaLGUSM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 7 Dec 2014 15:18:12 -0500
In-Reply-To: <1417596244-5743-1-git-send-email-jmmahler@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jeremiah Mahler <jmmahler@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GLiWTMR0IA3X3eqrjn2GJo9c7lGFe874c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/03/2014 09:44 AM, Jeremiah Mahler wrote:
> Several can modules in drivers/net/can use a banner[] variable at the
> top which defines a string that is used once during init.  This string
> is also embedded with KERN_INFO which makes it printk() specific.
>=20
> Improve the code by eliminating the banner[] variable and moving the
> string to where it is printed.  Then switch from printk(KERN_INFO to
> pr_info() for the lines that were changed.
>=20
> This patch is similar to [1] which was applied to net/can.
>=20
>   [1]: https://lkml.org/lkml/2014/11/22/10
>=20
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>

applied to can-next/master.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--GLiWTMR0IA3X3eqrjn2GJo9c7lGFe874c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUhLYBAAoJECte4hHFiupUbvAP/0XpEyI95EjpOP/+KFiEjcp2
fsN0hMevbJyVkbXogwGtdjUt/q/LvnygTbaK52s4MjgOJzrUHPfjh2xbK3y2bfv2
5fUD7bwAKzso8rLr4QBdnwv87X9I3CbtqhxtUUmfYvYPOtNs4yAi3MBoKl2ZlKx4
QLA5bTeBg+MrC4KEeJ/sGBi9iBEUQUMqi5MX1QQbkuse6WePlBaxpjqB8x6ofMnB
HhZ8eSvGZTd/Tt+JkPv34RDkRJkaZ7Y33QRDD7eYc+aVGJpqF+KjdfdEbkSIVUn+
Q4+S+JaPTJoiFNplvOMejmnr/mVv8tdx8UhlEi+kMC7lIrvEOwVrx5ZJX/TmbMA3
I4U9FtijksXnKdAyP1BjU9kHBsrIu0CU9+wcpE9YORUc9Bftm2Wka0sfS/1aAm8w
8MJeB68ZDr9fVnwX3IuWwpVjYHTXsXdCp/yvXKBleJq1AGVGutvEPDgDPXnbLc6Y
sN/P0YXvrAu6IlzJ9qLZv9kMxzl/m0TxJ4wLAbEN2naxseYYzSfCXdOnBof4hS2D
y5Ufev1uCG9TOejROw3FTGhOnuj+56AuSTV7lunFQ3fvL5duUcRy8hd2z9MqEt+i
INEv6mK+Fq/RrzWSrtnW0RzegnST70qgR1FJqUqL66TRYWpAwFsrrrosDRNiwQD6
+/bA7j1Ng/waba2Sr82p
=Ei5I
-----END PGP SIGNATURE-----

--GLiWTMR0IA3X3eqrjn2GJo9c7lGFe874c--
