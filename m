From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM i.MX5: set CAN peripheral clock to 24 MHz parent
Date: Mon, 25 Nov 2013 18:48:11 +0100
Message-ID: <52938D5B.6030002@pengutronix.de>
References: <1385399751-19109-1-git-send-email-mkl@pengutronix.de> <1385399751-19109-3-git-send-email-mkl@pengutronix.de> <1385400467.906340545@f177.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GhGBNeAEScUPaqhJ1hoqpEnl4HOAi7qNA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56429 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756879Ab3KYRs0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Nov 2013 12:48:26 -0500
In-Reply-To: <1385400467.906340545@f177.i.mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Shawn Guo <shawn.guo@linaro.org>, lst@pengutronix.de, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GhGBNeAEScUPaqhJ1hoqpEnl4HOAi7qNA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/25/2013 06:27 PM, Alexander Shiyan wrote:
>> This patch sets the parent of CAN peripheral clock (a.k.a. CPI clock) =
to the
>> lp_apm clock, which has a rate of 24 MHz.
>>
>> In the CAN world a base clock with multiple of 8 MHz is suited best fo=
r all CIA
>> recommented bit rates. Without this patch the CAN peripheral clock on =
i.MX53
>> has a rate of 66.666 MHz which produces quite large bit rate errors.
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  arch/arm/mach-imx/clk-imx51-imx53.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/c=
lk-imx51-imx53.c
>> index e349fd5..28f7f3f 100644
>> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
>> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
>> @@ -306,6 +306,9 @@ static void __init mx5_clocks_common_init(unsigned=
 long rate_ckil,
>>  	/* move usb phy clk to 24MHz */
>>  	clk_set_parent(clk[IMX5_CLK_USB_PHY_SEL], clk[IMX5_CLK_OSC]);
>> =20
>> +	/* move can bus clk to 24MHz */
>> +	clk_set_parent(clk[IMX5_CLK_CAN_SEL], clk[IMX5_CLK_LP_APM]);
>> +
>>  	clk_prepare_enable(clk[IMX5_CLK_GPC_DVFS]);
>>  	clk_prepare_enable(clk[IMX5_CLK_AHB_MAX]); /* esdhc3 */
>>  	clk_prepare_enable(clk[IMX5_CLK_AIPS_TZ1]);
>> --=20
>=20
> Again, CAN is missing on i.MX51, so this should be moved from common_in=
it function.

Doh, will fix.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--GhGBNeAEScUPaqhJ1hoqpEnl4HOAi7qNA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKTjVsACgkQjTAFq1RaXHMFgQCfUFwb6AAiAOReeq0y2IwBxh2g
X8YAoIrP14PBqdCV9PfAGNAyPdOnduTw
=q274
-----END PGP SIGNATURE-----

--GhGBNeAEScUPaqhJ1hoqpEnl4HOAi7qNA--
