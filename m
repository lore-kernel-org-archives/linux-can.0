Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA95CC4321E
	for <linux-can@archiver.kernel.org>; Fri,  2 Dec 2022 14:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiLBOTs (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 2 Dec 2022 09:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiLBOTr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Dec 2022 09:19:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BCF9D2D1
        for <linux-can@vger.kernel.org>; Fri,  2 Dec 2022 06:19:46 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1p16tE-0007l3-Cg; Fri, 02 Dec 2022 15:19:44 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:63a6:d4c5:22e2:f72a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D1EC01316F9;
        Fri,  2 Dec 2022 14:19:43 +0000 (UTC)
Date:   Fri, 2 Dec 2022 15:19:35 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] can: tcan4x5x: Fix use of register error status
 mask
Message-ID: <20221202141935.u6flbbsewkh6nrzw@pengutronix.de>
References: <20221116205308.2996556-1-msp@baylibre.com>
 <20221116205308.2996556-14-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n6qgkc23p3snkvok"
Content-Disposition: inline
In-Reply-To: <20221116205308.2996556-14-msp@baylibre.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--n6qgkc23p3snkvok
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.11.2022 21:53:06, Markus Schneider-Pargmann wrote:
> TCAN4X5X_ERROR_STATUS is not a status register that needs clearing
> during interrupt handling. Instead this is a masking register that masks
> error interrupts. Writing TCAN4X5X_CLEAR_ALL_INT to this register
> effectively masks everything.
>=20
> Rename the register and mask all error interrupts only once by writing
> to the register in tcan4x5x_init.
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

please add a fixes tag.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--n6qgkc23p3snkvok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOKCXQACgkQrX5LkNig
0124tAgAmx7mMTaphzkAQxeXrb68161432MibY4wOa5grbtKCQj5/iizK4iwwr2U
knODf0OszEeAyp4Vg045biSnbYbgq8CATeJiLao6kmj6+iCaDm9Z7fETrSCDBS2X
Ax8Q94KKMU23V3Dd2MVgOUl79MJhRuCTlf/I9c/3sSvXqq/bvs6QxXUdsvdqo2N1
mVDzuRXbERcRNcscZvEhmkIYVJI0fuLH6X/KEbuCiBsr7fvLNhJXlKHqiiaIl450
Yi+7KXbuj4of7rBfXvs7svp39fkIbeheCxKKr5g+KhN8Rpuz07+k+WXaFqLLcO/D
d6znj1yhT5XTEM9qNIwgcGrf+2tIpA==
=uJCO
-----END PGP SIGNATURE-----

--n6qgkc23p3snkvok--
