From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: allow compilation on arm and powerpc
Date: Fri, 17 May 2013 10:51:00 +0200
Message-ID: <5195EF74.8070005@pengutronix.de>
References: <1368711756-22324-1-git-send-email-mkl@pengutronix.de> <20130517020351.GE3893@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2BTQAAMIKHERLPINUMOQI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34467 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109Ab3EQIvX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 May 2013 04:51:23 -0400
In-Reply-To: <20130517020351.GE3893@S2101-09.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, Kumar Gala <galak@kernel.crashing.org>, U Bhaskar-B22300 <B22300@freescale.com>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2BTQAAMIKHERLPINUMOQI
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/17/2013 04:03 AM, Shawn Guo wrote:
> Hi Marc,
>=20
> On Thu, May 16, 2013 at 03:42:36PM +0200, Marc Kleine-Budde wrote:
>> This patch removes the Kconfig symbols HAVE_CAN_FLEXCAN and
>> IMX_HAVE_PLATFORM_FLEXCAN from arch/{arm,powerpc} and allowing compila=
tion on
>> all arm and powerpc platforms.
>=20
> I'm generally fine with the approach.  But with Kconfig symbol
> IMX_HAVE_PLATFORM_FLEXCAN removed, how does the build of
> platform-flexcan.o work?
>=20
> arch/arm/mach-imx/devices/Makefile:obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXC=
AN) +=3D platform-flexcan.o

Doh! - I've removed too much, will change.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2BTQAAMIKHERLPINUMOQI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGV73gACgkQjTAFq1RaXHOhLACfXhnZQvq8oFaR1qHQyBycdj4z
or4AnRO8KuSrpX8kUrwFu2rESmefa4Av
=5VdO
-----END PGP SIGNATURE-----

------enig2BTQAAMIKHERLPINUMOQI--
