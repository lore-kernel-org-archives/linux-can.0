From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: MCP2515 DTS support
Date: Wed, 26 Feb 2014 18:50:04 +0100
Message-ID: <530E294C.4050209@pengutronix.de>
References: <144554558e0.2748.cbaa067694a7e68fb76a213b35423fb5@gmail.com> <1393388253.686159171@f330.i.mail.ru> <530DE824.2060803@gmail.com> <1393426239.267518204@f362.i.mail.ru> <530E262C.2040603@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1NsOeSEERuMErI5OdbbrTDvbpgRjVl3m4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48710 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaBZRuI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2014 12:50:08 -0500
In-Reply-To: <530E262C.2040603@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lucas Zampar Bernardi <lucas.zampar@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1NsOeSEERuMErI5OdbbrTDvbpgRjVl3m4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2014 06:36 PM, Lucas Zampar Bernardi wrote:
> You are right Alexander!
> The CONFIG_COMMON_CLK hasn't enable!
> But for all SOC AT91_SAM9x5 still uses old clock style (AT91_USE_OLD_CL=
K):
>=20
> config SOC_AT91SAM9X5
>         bool "AT91SAM9x5 family"
>         select HAVE_AT91_DBGU0
>         select HAVE_FB_ATMEL
>         select SOC_AT91SAM9
>         select AT91_USE_OLD_CLK
>         select HAVE_AT91_UTMI
>         select HAVE_AT91_SMD
>         select HAVE_AT91_USB_CLK
>=20
> and one of dependencies for COMMON_CLK_AT91 is don't be AT91_USE_OLD_CL=
K
>=20
> config COMMON_CLK_AT91
>         bool
>        default AT91_PMC_UNIT && USE_OF && !AT91_USE_OLD_CLK
>         select COMMON_CLK
>=20
> config OLD_CLK_AT91
>         bool
>         default AT91_PMC_UNIT && AT91_USE_OLD_CLK
>=20
>=20
>=20
>=20
> Now came my question: Can I use CONFIG_COMMON_CLK without my ARCH
> support? If not, how we will support devices that need CONFIG_COMMON_CL=
K?

You probably have to wait for common clock support. However you can
still hook platform data to your spi device. For a mxs add this to
arch/arm/mach-mxs/mach-mxs.c:

static int abc_spi_notifier_call(struct notifier_block *nb,
					unsigned long event, void *data)
{
	struct device *dev =3D data;

	if (event =3D=3D BUS_NOTIFY_BIND_DRIVER)
		if (strcmp(dev_name(dev), "spi32766.0") =3D=3D 0)
			dev->platform_data =3D &abc_pdata;

	return NOTIFY_OK;
}

static struct notifier_block abc_spi_nb =3D {
	.notifier_call =3D abc_spi_notifier_call,
};

static void __init abc_post_init(void)
{
	bus_register_notifier(&spi_bus_type, &abc_spi_nb);
}

static void __init mxs_machine_init(void)
{

	of_platform_populate(NULL, of_default_bus_match_table,
			     mxs_auxdata_lookup, NULL);

	if (of_machine_is_compatible("123,abc"))
		abc_post_init();
}

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1NsOeSEERuMErI5OdbbrTDvbpgRjVl3m4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMOKUwACgkQjTAFq1RaXHNQfACfe3dj15BCcu5keU5l2sgPZUH1
G/YAnidvq2ln25Q/OSqLmkQE2TSTcSWp
=uYL0
-----END PGP SIGNATURE-----

--1NsOeSEERuMErI5OdbbrTDvbpgRjVl3m4--
