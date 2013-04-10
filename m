From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Wed, 10 Apr 2013 15:39:39 +0200
Message-ID: <51656B9B.80907@pengutronix.de>
References: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2AVRGCILSOWPTFTOQINHL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33333 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab3DJNkA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 10 Apr 2013 09:40:00 -0400
In-Reply-To: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mylene Josserand <Mylene.Josserand@navocap.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2AVRGCILSOWPTFTOQINHL
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/10/2013 03:07 PM, Mylene Josserand wrote:
> When I compile the driver in static, the kernel stopped booting. With=20
> some printk, the driver is blocked at the function "spi_write" of the=20
> function "mcp251x_hw_reset". The dmesg with my outputs :
>=20
> "
> spi_imx imx27-cspi.0: master is unqueued, this is deprecated
> spi_imx imx27-cspi.0: probed
> CAN device driver interface
> mcp251x_can_init
> mcp251x_clean
> mcp251x_can_probe
> mcp251x_hw_probe
> mcp251x_hw_reset
> mcp251x_hw_reset : spi_write : start
> "

Does it hang here?

http://lxr.linux.no/linux+v3.8.6/drivers/net/can/mcp251x.c#L624

Is this the first spi transfer that occurs in the driver?

> I thought that it was a spi problem because of the warning "master is=20
> unqueued, this is deprecated" but in fact the spi works.
> One surprising thing (for me) is that the MCP251x compiled in module is=
=20
> probed ! (I did not test it yet)

If it's the first spi transfer in the driver that hangs and if the
mcp251x works if loaded as a module, there is probably some
initialisation missing. Look for stuff that gets initialized after the
mcp251x would have been loaded if compiled into the kernel. Make a
"diff" between the bootload with mcp251x compiled into the kernel and
without. Other usual suspects are: clocks, pinmux (spi _and_ the mcp251x
dedicated IRQ line), gpio setup.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2AVRGCILSOWPTFTOQINHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFla6cACgkQjTAFq1RaXHOcHQCcDXxbx6I9/gZmSfXKSO9OrTRE
CuYAoIxGzzhq8X0cfKuei+Rr8FT2uufn
=bWbJ
-----END PGP SIGNATURE-----

------enig2AVRGCILSOWPTFTOQINHL--
