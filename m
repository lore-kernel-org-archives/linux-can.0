From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: flexcan: add 2nd clock to support imx53 and newer
Date: Wed, 18 Jul 2012 12:16:02 +0200
Message-ID: <50068CE2.9090408@pengutronix.de>
References: <1342601282-1208-1-git-send-email-mkl@pengutronix.de> <50068A54.80705@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8FE62F2D791E23840926D6BB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46659 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291Ab2GRKQO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 06:16:14 -0400
In-Reply-To: <50068A54.80705@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: linux-can@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8FE62F2D791E23840926D6BB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/18/2012 12:05 PM, Hui Wang wrote:
> Marc Kleine-Budde wrote:
>> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>
>> This patch adds support for a second clock to the flexcan driver. On
>> modern freescale ARM cores like the imx53 and imx6q two clocks ("ipg"
>> and "per") must be enabled in order to access the CAN core.
>>
>> In the original driver, the clock was requested without specifying the=

>> connection id, further all mainline ARM archs with flexcan support
>> (imx28, imx25, imx35) register their flexcan clock without a
>> connection id, too.
>>
>> This patch first renames the existing clk variable to clk_ipg and
>> converts it to devm for easier error handling. The connection id "ipg"=

>> is added to the devm_clk_get() call. Then a second clock "per" is
>> requested. As all archs don't specify a connection id, both clk_get
>> return the same clock. This ensures compatibility to existing flexcan
>> support and adds support for imx53 at the same time.
>>
>> After this patch hits mainline, the archs may give their existing
>> flexcan clock the "ipg" connection id and implement a dummy "per"
>> clock.
>>
>> This patch has been tested on imx28 (unmodified clk tree) and on imx53=

>> with a seperate "ipg" and "per" clock.
>>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Hui Wang <jason77.wang@gmail.com>
>>  =20
> Acked-by: Hui Wang <jason77.wang@gmail.com>

tnx, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8FE62F2D791E23840926D6BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAGjOYACgkQjTAFq1RaXHOZrwCeIw/rAsam4GWAkq4B+mW8kITv
o54AnAz00UATlP6EiDe/nrum336EJAuE
=FK+x
-----END PGP SIGNATURE-----

--------------enig8FE62F2D791E23840926D6BB--
