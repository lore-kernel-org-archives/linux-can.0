Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9E1C433F5
	for <linux-can@archiver.kernel.org>; Thu, 17 Feb 2022 10:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbiBQKZ6 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 17 Feb 2022 05:25:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239405AbiBQKZu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 05:25:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5EB27B9AD
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 02:25:35 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nKdyc-0001oW-6c; Thu, 17 Feb 2022 11:25:30 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B80D936276;
        Thu, 17 Feb 2022 10:25:28 +0000 (UTC)
Date:   Thu, 17 Feb 2022 11:25:25 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next] dt-binding: can: m_can: fix indention of table
 in bosch,mram-cfg description
Message-ID: <20220217102525.33wtuoue5yp4xtq3@pengutronix.de>
References: <20220217101111.2291151-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jmg6mm4skitgaao7"
Content-Disposition: inline
In-Reply-To: <20220217101111.2291151-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--jmg6mm4skitgaao7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Chandrasekar Ramakrishnan,

I just noticed that the binding maintainer's email address bounces.
Chandrasekar Ramakrishnan can I add you as the maintainer of the DT
binding?

Marc

On 17.02.2022 11:11:11, Marc Kleine-Budde wrote:
> This patch fixes the indention of the table in the description of the
> bosch,mram-cfg property.
>=20
> Cc: Sriram Dash <sriram.dash@samsung.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b=
/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index 61f9e512c346..3bc1ed39a0a5 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -69,8 +69,8 @@ properties:
>        M_CAN includes the following elements according to user manual:
>        11-bit Filter	0-128 elements / 0-128 words
>        29-bit Filter	0-64 elements / 0-128 words
> -      Rx FIFO 0	0-64 elements / 0-1152 words
> -      Rx FIFO 1	0-64 elements / 0-1152 words
> +      Rx FIFO 0		0-64 elements / 0-1152 words
> +      Rx FIFO 1		0-64 elements / 0-1152 words
>        Rx Buffers	0-64 elements / 0-1152 words
>        Tx Event FIFO	0-32 elements / 0-64 words
>        Tx Buffers	0-32 elements / 0-576 words
> --=20
> 2.34.1
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jmg6mm4skitgaao7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIOIpIACgkQrX5LkNig
013fjAf7BE4KgB5ShgVdob4vbYF/W6dSRxNzUdev6InGJBjZYOG/ybYiGT11zvA9
jNs4X9rj9urbPWkE5JTU3+l2nBQl+4639Rrvg2s5oygNbaaRoNbZUePhw2XYkkpi
t9gBlLOMlRSoym8LFKRhLinUfSNygYa9h/7SkUvSPqShIpOull7Re4Ln9XGoI73Z
2BCBT2G1USq2gv8XUho4JiCpiY2sdbPq47U8bV5rKqvJWDE6bbmwzHmnpYaMDzxV
Zm+EQCBbE6YO2IMSfcxsLcv9afZv3QHVpVqp0NNvbX3ERCl2DjyHkcXYNmiQbVNj
DXxpxmgbHZeFGeu38I2sqKEbHZU7cQ==
=ye5K
-----END PGP SIGNATURE-----

--jmg6mm4skitgaao7--
