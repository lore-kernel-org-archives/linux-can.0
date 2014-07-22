From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [libsocketcan 2/2] Update can_set_ctrlmode() documentation
Date: Tue, 22 Jul 2014 16:26:48 +0200
Message-ID: <53CE74A8.3090506@pengutronix.de>
References: <1405935800-26622-1-git-send-email-nebaruzdin@gmail.com> <1405935800-26622-5-git-send-email-nebaruzdin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="x6QoeQRTmiEeavXMag60o3oVjAU8bVoPb"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39859 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbaGVO0u (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jul 2014 10:26:50 -0400
In-Reply-To: <1405935800-26622-5-git-send-email-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x6QoeQRTmiEeavXMag60o3oVjAU8bVoPb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2014 11:43 AM, Nikita Edward Baruzdin wrote:
> Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
> ---
>  src/libsocketcan.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
>=20
> diff --git a/src/libsocketcan.c b/src/libsocketcan.c
> index fe3a0b3..21884b6 100644
> --- a/src/libsocketcan.c
> +++ b/src/libsocketcan.c
> @@ -774,13 +774,20 @@ int can_set_restart_ms(const char *name, __u32 re=
start_ms)
>   *
>   * @param cm pointer of a can_ctrlmode struct
>   *
> - * This sets the control mode of the can device. There're currently th=
ree
> - * different control modes:
> - * - LOOPBACK
> - * - LISTEN_ONLY
> - * - TRIPPLE_SAMPLING
> + * This sets the control mode of the can device. There are currently t=
he
> + * following modes available (each mapped to its own macro):
>   *
> - * You have to define the control mode struct yourself. a can_ctrlmode=
 struct
> + * @code
> + * #define CAN_CTRLMODE_LOOPBACK           0x01    /* Loopback mode */=


Have you actually compile-tested this change?

> libsocketcan.c:781:52: warning: "/*" within comment [-Wcomment]
>   * #define CAN_CTRLMODE_LOOPBACK           0x01    /* Loopback mode */=


=2E..and it finally fails to build from source. I've fixed this while
applying the patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--x6QoeQRTmiEeavXMag60o3oVjAU8bVoPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEUEARECAAYFAlPOdKgACgkQjTAFq1RaXHO62ACfdJgZwT504nagcB0JMTi+VQSm
iAYAmOpCnm0xzbb+aJIplp+YMm/2JUY=
=sl00
-----END PGP SIGNATURE-----

--x6QoeQRTmiEeavXMag60o3oVjAU8bVoPb--
