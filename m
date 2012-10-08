From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC: PATCH 1/5] can: sja1000_platform
Date: Mon, 08 Oct 2012 14:19:37 +0200
Message-ID: <5072C4D9.8020008@pengutronix.de>
References: <1349447947-18451-1-git-send-email-mkl@pengutronix.de> <507299D4.9030506@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig38A25803C236CD89AF06DD50"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56800 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab2JHMTm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Oct 2012 08:19:42 -0400
In-Reply-To: <507299D4.9030506@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, wg@grandegger.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig38A25803C236CD89AF06DD50
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/08/2012 11:16 AM, Andreas Larsson wrote:
> On 10/05/2012 04:39 PM, Marc Kleine-Budde wrote:
>> Hello,
>>
>> this series ports the device tree bindings from the existing
>> sja1000_of_platform driver to the sja1000_platform driver. It has been=

>> compile
>> time tested only. I've written the patches to get rid of the
>> sja1000_of_platform once this in the kernel.
>>
>> Please test, especially on sparc, powerpc and arm.
>=20
> On sparc, sp_probe fails for me because there is no resource of type
> IORESOURCE_IRQ.
>=20
> As far as I can find out, on sparc (32 and 64 bit) IORESOURCE_IRQ
> resources are never created for the platform_device representation. The=

> resources that are created are the ones created for adresses/registers
> in build_device_resources() in arch/sparc/kernel/of_device_32.c and
> arch/sparc/kernel/of_device_64.c respectively.

Okay. Do both sparc architectures implement

    irq_of_parse_and_map()

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig38A25803C236CD89AF06DD50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlByxNkACgkQjTAFq1RaXHPbXACgh70A00Xsz3P4UngckLpXo/kH
dOkAoIMXkzWncsGEGpI7hBZ4Jz7sZ5Lg
=LcIx
-----END PGP SIGNATURE-----

--------------enig38A25803C236CD89AF06DD50--
