From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: socketCAN mcp2515 - rx buffer overflow
Date: Thu, 08 Mar 2012 15:11:15 +0100
Message-ID: <4F58BE03.5030905@pengutronix.de>
References: <loom.20120308T140608-84@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9A945B7D37ACF345927E37AF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48636 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab2CHOL0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 8 Mar 2012 09:11:26 -0500
In-Reply-To: <loom.20120308T140608-84@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gianluca <gmattiroli@midsx.ch>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A945B7D37ACF345927E37AF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/08/2012 02:09 PM, Gianluca wrote:
> Hi All,
> I'm using an embedded Armadeus evaluation board - apf51 - with the mcp2=
515 CAN=20
> controller (via spi) and linux 2.6.38.8.

Using an SPI attached CAN controller is a really bad choice. Try is
upgrading to mx53, which has as far as I know one or even two internal
flexcan cores, an option for you? Another option is to attach a local
bus capable controller like the SJA1000 to your CPU, or use an USB
dongle or a PCMCIA card.

The next thing is the SPI driver on the (mainline) mx51. If I remember
correctly the mainline kernel doesn't support DMA for the SPI driver
yet. I don't know if the freescale kernel does. Depending on your kernel
version there are some knobs to tune the PIO SPI driver, mainly to
increase the priority of the SPI task.

Last but not least, there is a not yet mainlined improved version of the
mcp2515 driver around.

regards, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |




--------------enig9A945B7D37ACF345927E37AF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9YvgMACgkQjTAFq1RaXHOJmwCfRzCRemdyvQyfgYbchWipme5y
FAoAnAnblaaHCU13QT1bFNueqLmDF02X
=IS6M
-----END PGP SIGNATURE-----

--------------enig9A945B7D37ACF345927E37AF--
