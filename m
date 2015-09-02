From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] CAN controller support for Allwinner A10/A20 SoCs
Date: Wed, 2 Sep 2015 21:22:35 +0200
Message-ID: <55E74C7B.1000001@pengutronix.de>
References: <55E74381.6050506@gerhard-bertelsmann.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bhF0QtatTCIPB3V46idhAahk3x9O8l0cQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55934 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932155AbbIBTWn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Sep 2015 15:22:43 -0400
In-Reply-To: <55E74381.6050506@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bhF0QtatTCIPB3V46idhAahk3x9O8l0cQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/02/2015 08:44 PM, Gerhard Bertelsmann wrote:
> This driver add support for SUNXI CAN controllers found on Allwinner A1=
0/A20 SoCs
> V1

Thanks for the patch. I suggest to use git send-email to post the patch.
Please test your patch with scripts/checkpatch.pl (included in the
kernel tree) before submitting - you can even use the "--file" option to
check a file, before creating the patch.

Here some general remarks:

- please remove the EXPORT_SYMBOL_GPL, as this is a stand alone driver.
- why are there udelay()s in the hot path of the code?
- please move the device tree bindings into a separate file in
  Documentation/devicetree/bindings/net/can/
  please provide that binding doc as a separate patch
- please provide a proper Signed-off-by line, with a working
  non obfuscated email address

Your priv struct seems a bit bloated:

> struct sunxican_priv {
> 	struct can_priv can;
> 	struct net_device *dev;

write only variable

> 	struct napi_struct napi;

not used

>=20
> 	int open_time;

read only variable

> 	struct sk_buff *echo_skb;

not used

> 	void __iomem *base;
> 	struct clk *clk;
>=20
> 	void *priv;		/* for board-specific data */

I think this is never used

>=20
> 	unsigned long irq_flags;	/* for request_irq() */

This is a read only variable

> 	spinlock_t cmdreg_lock;	/* lock for concurrent cmd register writes */
>=20
> 	u16 flags;		/* custom mode flags */

not used

> };

Please fix these sparse warning:

> drivers/net/can/sunxi_can.c:596:13: warning: symbol 'sunxi_can_interrup=
t' was not declared. Should it be static?
> drivers/net/can/sunxi_can.c:690:6: warning: symbol 'free_sunxicandev' w=
as not declared. Should it be static?

Compile with "make C=3D1" to test yourself. Install the "sparse" package
of your distribution first.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--bhF0QtatTCIPB3V46idhAahk3x9O8l0cQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV50x7AAoJEP5prqPJtc/H/IYIALXlKXdifZOc0I+qn1xjEqOy
f3Y/FLHvSNFXq1pRfe96mJjTRALAKjilreh37aPwJSrpmMcnuz+9umsU/druu5NO
3DSV6Vq8mGIJUu5UAcH3NC22vI+D0OfBImbTBzIp2l+I14GvsfaVkACTSE6jdopq
bCXqcBkGbwU9Ky4jJ+AUYoHelQo6GTLfhuPpbVy/UaCoAG4royxqjlWnRiH9TRVZ
Z4E3FU5EQgsMnUbrN1BoyjTZsa85GG3TN6ozYJ1Rutp06mU/azaqSLNWQApAODWT
6Op4R4BKa191+KTlPG6vF+7LYPR9cNil2WSnpM1J6zn2c6SRo/1vz4H6NcnGlEA=
=Cjnc
-----END PGP SIGNATURE-----

--bhF0QtatTCIPB3V46idhAahk3x9O8l0cQ--
