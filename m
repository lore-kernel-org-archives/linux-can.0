Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FB3C5519F
	for <linux-can@archiver.kernel.org>; Tue, 17 Nov 2020 10:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13E22225E
	for <linux-can@archiver.kernel.org>; Tue, 17 Nov 2020 10:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgKQKGA (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 17 Nov 2020 05:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgKQKGA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Nov 2020 05:06:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3714AC0613CF
        for <linux-can@vger.kernel.org>; Tue, 17 Nov 2020 02:06:00 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kexrq-0000e7-7Z; Tue, 17 Nov 2020 11:05:42 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:4295:bc9e:e8ea:bff7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id ACE3159448F;
        Tue, 17 Nov 2020 10:05:29 +0000 (UTC)
Date:   Tue, 17 Nov 2020 11:05:28 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     xiakaixu1987@gmail.com
Cc:     manivannan.sadhasivam@linaro.org, thomas.kopp@microchip.com,
        wg@grandegger.com, kuba@kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] can: mcp251xfd: remove useless code in
 mcp251xfd_chip_softreset
Message-ID: <20201117100528.hfdgwe5fyckweurt@hardanger.blackshift.org>
References: <1605605352-25298-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vejvaibdl4v32vmq"
Content-Disposition: inline
In-Reply-To: <1605605352-25298-1-git-send-email-kaixuxia@tencent.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--vejvaibdl4v32vmq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2020 at 05:29:12PM +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
>=20
> It would directly return if the variable err equals to 0 or other errors.
> Only when the err equals to -ETIMEDOUT it can reach the 'if (err)'
> statement, so the 'if (err)' and last 'return -ETIMEDOUT' statements are
> useless. Romove them.
>=20
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Applied to linux-can-next/testing.

Tnx,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vejvaibdl4v32vmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+zoGUACgkQqclaivrt
76nLcwf+K7Ock9na2DUNadKgKZpILJKHxuuwomO5Jgx8BeeSy6v261b9g55FZNlg
FeF6IIOWa3lD0AYCVfznChS4qdwHp0g7yaLzrs2vYbyXVRnXCZufOSeaMWTCBV18
xXUtZaYrj644MAx3LnjGfXQcSuxMK2ARUC57bOAvoOql7m7Vc5Ln54JWmCIOhbN1
LjD2TS8N3RjvZM847cB9V86N85ZEJHhtgN0NpqHUbm/DFF20n3SBlocE+7zHmsrd
pCGbZOQ40g8hvy2LkzZNjALGDHfsRDmQoZRQ1eQK+YMsf9qMx2PCFVh+s3ZY6nM3
eg3YsErI42Vs8hEFcV6bflqVx/4f7g==
=vHS6
-----END PGP SIGNATURE-----

--vejvaibdl4v32vmq--
