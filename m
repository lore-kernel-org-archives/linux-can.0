From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [mcp251x - spi] Blocked to "wait_for_completion"
Date: Thu, 06 Dec 2012 12:49:03 +0100
Message-ID: <50C0862F.4080309@pengutronix.de>
References: <CA78C307B8F06747967D122FC656B1537FEDF3@SERVEUR0.nvp.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA2BEADF16FC0F8129A5FB399"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38965 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423208Ab2LFLtJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 06:49:09 -0500
In-Reply-To: <CA78C307B8F06747967D122FC656B1537FEDF3@SERVEUR0.nvp.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mylene Josserand <Mylene.Josserand@navocap.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA2BEADF16FC0F8129A5FB399
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Mylene,

what SPI controller are you using?
Which SoC are you on?
Do you have a MCP2510 or a MCP2515?

On 12/06/2012 12:22 PM, Mylene Josserand wrote:
> I am new to this mailing list so I hope I am writing to the good
> section. It is the first time I use CAN protocol so I am a newbie ! I
> am currently working on CAN with the driver MCP251x for my company.
>=20
> For some reasons, my company have the kernel 2.6.32.59 version. The
> MCP251x driver have been backported from the Linux version 2.6.34. I

A lot of fixes have been applied to the driver since v2.6.34, you should
backport them, too.

> am testing it but only for reading purpose. So I have a set-up to
> send CAN frame (in another computer) and received them with candump
> (this is what I want).
>=20
>=20
> When I send CAN frames every 20 ms, the CAN interface seems to be
> blocked after 1-2 minutes (sometimes 5 minutes) of reading. In fact,
> the candump stop showing CAN messages and I can not act anymore on
> it. If I increase the interval time between frames (100 msec), the
> time before being blocked is around 30-40 minutes. And if it is every
> 1 sec, it is after 13 hours !
>=20
> I have made some debugging traces on the driver and I saw that the
> problem is in the call of "spi_sync" function (in the
> "mcp251x_spi_trans" function). I have done the same on the "spi.c"
> and I saw that the spi is blocked by the "wait_for_completion"
> function. What is it waiting for ? With some readings, I saw that

The CAN driver calls into the SPI layer to send a message synchronously.
The SPI layer kicks the SPI driver to send the message, bus, this is
done asynchronously. In the completion handler of the SPI driver the SPI
layer is told that the SPI transfer is complete.

In the above described mechanism the SPI layer is waiting with
wait_for_completion(), the SPI driver will call (either directly, or via
a callback, which has been set by the SPI layer) a complete() which will
wake up the SPI layer.

If the SPI layer is still in wait_for_completion(), the SPI transfer
never finished...there's might be a bug in the SPI driver.

> this function is not stoppable so it is normal that the function is
> blocked. But I did not understand why it is blocking in this function
> only after some times.
>=20
> Can you have some explanation of this problem ? Have you already seen

See above.

> that before ? How solve it ? Update the kernel to new version ? (If

Never seen it.

Debug your SPI driver. Especially the completion of a transfer. Hook up
a scope to the SPI lines.

Updating the Kernel is always a good idea. Use latest v3.7-rc or newer
if updating.

> you have new version, could you test it please ?) I have seen that
> some new kernel version (3.0.53 and upper) have some update on this
> spi_sync function. Is this going to fix this problem or not ?

There are probably a lot of changes between 2.6.32 and 3.0.53 in the SPI
layer in probably in your SPI driver as well.

Marc

> PS : I had an Undelivered response. I did not know if my email has
> been sent so I send it a 2nd time. Sorry for potential spam !

Maybe you tried to send a HTML mail, which is not supported here :)

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigA2BEADF16FC0F8129A5FB399
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDAhjIACgkQjTAFq1RaXHOGqgCgjuO7KZh6k18SapcPHIpTPkdj
+qkAnifPqIQEXMmikxmhQ9T0RBHiFtSF
=2nKY
-----END PGP SIGNATURE-----

--------------enigA2BEADF16FC0F8129A5FB399--
