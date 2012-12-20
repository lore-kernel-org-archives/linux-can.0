From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: c_can: Enable clock before first use
Date: Thu, 20 Dec 2012 15:07:18 +0100
Message-ID: <50D31B96.8010501@pengutronix.de>
References: <cover.1355996839.git.amit.virdi@st.com> <3ce526df6a4f9e71f8b05132689db7426bae6bbb.1355996839.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEFE86D03BF78E8ED4396E677"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41153 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab2LTOHZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Dec 2012 09:07:25 -0500
In-Reply-To: <3ce526df6a4f9e71f8b05132689db7426bae6bbb.1355996839.git.amit.virdi@st.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Amit Virdi <amit.virdi@st.com>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, bhupesh.sharma@st.com, anilkumar@ti.com, spear-devel@list.st.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEFE86D03BF78E8ED4396E677
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/20/2012 11:05 AM, Amit Virdi wrote:
> Current implementation assumes clock to be always enabled. Instead,
> explicitly enable device clock before usage.
>=20
> Signed-off-by: Amit Virdi <amit.virdi@st.com>
> Reviewed-by: Shiraz Hashim <shiraz.hashim@st.com>
> ---
>  drivers/net/can/c_can/c_can_platform.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c=
_can/c_can_platform.c
> index 6e8dc56..d0bd6e6 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -194,6 +194,12 @@ static int __devinit c_can_plat_probe(struct platf=
orm_device *pdev)
>  		goto exit;
>  	}
> =20
> +	ret =3D clk_prepare_enable(clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not prepare CAN clock\n");
> +		goto exit_no_clk_en;
> +	}
> +
>  	/* get the platform data */
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	irq =3D platform_get_irq(pdev, 0);
> @@ -295,6 +301,8 @@ exit_iounmap:
>  exit_release_mem:
>  	release_mem_region(mem->start, resource_size(mem));
>  exit_free_clk:
> +	clk_disable_unprepare(clk);
> +exit_no_clk_en:
>  	clk_put(clk);
>  exit:
>  	dev_err(&pdev->dev, "probe failed\n");

Why do you have to enable the clock if the driver is loaded? What about
disabling the clock on driver unload. The clock should be enabled on
open and disabled on close if the network interface. If you need to
access the registers of your hardware, you should enable the clock
before accessing the regs and disable the clock when finished.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigEFE86D03BF78E8ED4396E677
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDTG5YACgkQjTAFq1RaXHP0GACfSvZkSxU2vS4QtRtXbTG3eStM
OYoAnR9s6b8S3544WaGchOy5W3ieC+S/
=QS/I
-----END PGP SIGNATURE-----

--------------enigEFE86D03BF78E8ED4396E677--
