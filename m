From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH RESEND 3/5] can: flexcan: adopt pinctrl support
Date: Mon, 07 May 2012 10:06:48 +0200
Message-ID: <4FA78298.4080401@pengutronix.de>
References: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org> <1336352040-28447-4-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig27A7DA69D1F5637C7BD9385A"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50653 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab2EGIHH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 May 2012 04:07:07 -0400
In-Reply-To: <1336352040-28447-4-git-send-email-shawn.guo@linaro.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sascha Hauer <s.hauer@pengutronix.de>, Dong Aisheng <dong.aisheng@linaro.org>, linux-can@vger.kernel.org, Linux Netdev List <netdev@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig27A7DA69D1F5637C7BD9385A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

On 05/07/2012 02:53 AM, Shawn Guo wrote:
> Cc: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

It doesn't compile yet against net-next/master, which is based on v3.4-rc=
4:

/home/frogger/pengutronix/socketcan/linux/drivers/net/can/flexcan.c: In
function 'flexcan_probe':
/home/frogger/pengutronix/socketcan/linux/drivers/net/can/flexcan.c:937:
error: implicit declaration of function 'devm_pinctrl_get_select_default'=

/home/frogger/pengutronix/socketcan/linux/drivers/net/can/flexcan.c:937:
warning: assignment makes pointer from integer without a cast

Which tree does this series depend on? If this should go over the
linux-can tree, I have to ask David first to merge this.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig27A7DA69D1F5637C7BD9385A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+ngpwACgkQjTAFq1RaXHMNsgCgiYbrkhwS5tLz/iiVhUtnM7B4
aV8AnR6CrZWExGoxbTLf7JPAm8zpd/5l
=lIkD
-----END PGP SIGNATURE-----

--------------enig27A7DA69D1F5637C7BD9385A--
