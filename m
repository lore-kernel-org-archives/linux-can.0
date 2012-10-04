From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: sja1000: Make sja1000_of_platform selectable
 and compilable on SPARC
Date: Thu, 04 Oct 2012 17:12:41 +0200
Message-ID: <506DA769.6090000@pengutronix.de>
References: <506D9266.6010707@gaisler.com> <1349359150-18012-1-git-send-email-andreas@gaisler.com> <506DA06D.3070003@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig24858AE9555E31A41568B3BF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52087 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965590Ab2JDPNe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 4 Oct 2012 11:13:34 -0400
In-Reply-To: <506DA06D.3070003@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig24858AE9555E31A41568B3BF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/04/2012 04:42 PM, Marc Kleine-Budde wrote:
> On 10/04/2012 03:59 PM, Andreas Larsson wrote:
>> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
>=20
> Looks better. However on sparc and sparc64, I'm seeing this warning.
> From my point of view a false positive.
>=20
>> linux/drivers/net/can/sja1000/sja1000_of_platform.c: In function 'sja1=
000_ofp_remove':
>> linux/include/linux/ioport.h:165:18: warning: 'res.end' is used uninit=
ialized in this function [-Wuninitialized]
>> linux/drivers/net/can/sja1000/sja1000_of_platform.c:78:18: note: 'res.=
end' was declared here
>> linux/include/linux/ioport.h:165:2: warning: 'res.start' is used unini=
tialized in this function [-Wuninitialized]
>> linux/drivers/net/can/sja1000/sja1000_of_platform.c:78:18: note: 'res.=
start' was declared here

Looking at the preprocessed code, the compiler is right:

> # 30 "/home/frogger/pengutronix/socketcan/linux/include/linux/of_addres=
s.h"
> static inline __attribute__((always_inline)) __attribute__((no_instrume=
nt_function)) int of_address_to_resource(struct device_node *dev, int ind=
ex,
>       struct resource *r)
> {
>  return -22;
> }

http://lxr.free-electrons.com/source/include/linux/of_address.h#L29

Why is CONFIG_OF_ADDRESS not set in my .config?

http://lxr.free-electrons.com/source/drivers/of/Kconfig#L43

What a U+1F4A9,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig24858AE9555E31A41568B3BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBtp2wACgkQjTAFq1RaXHPw5gCdEgKyFWbRqtVQu+p0znOyhSEm
r3gAn20oEar9cJ/bVzEzyi5B3+AH8vCM
=gSkA
-----END PGP SIGNATURE-----

--------------enig24858AE9555E31A41568B3BF--
