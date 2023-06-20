Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0437EB64D7
	for <linux-can@archiver.kernel.org>; Tue, 20 Jun 2023 13:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjFTNkq (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjFTNkp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Jun 2023 09:40:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265C91BB
        for <linux-can@vger.kernel.org>; Tue, 20 Jun 2023 06:40:44 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qBbb8-00042a-0H; Tue, 20 Jun 2023 15:40:42 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0BCFF1DDB92;
        Tue, 20 Jun 2023 13:40:41 +0000 (UTC)
Date:   Tue, 20 Jun 2023 15:40:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH v2 00/14] can: kvaser_pciefd: Fixes and improvments
Message-ID: <20230620-dwindling-unaltered-ae5bbd016f8e-mkl@pengutronix.de>
References: <20230529134248.752036-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a7ainhg5kjscgtqi"
Content-Disposition: inline
In-Reply-To: <20230529134248.752036-1-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--a7ainhg5kjscgtqi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.05.2023 15:42:34, Jimmy Assarsson wrote:
> This patch series contains various non critical fixes and improvments for
> the kvaser_pciefd driver.

Applied to linux-can-next, fixing the typo while applying:
s/improvments/improvements/.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--a7ainhg5kjscgtqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSRrFUACgkQvlAcSiqK
BOisFwf/ZW7F2gGypSSsza9oCgpESbnE2gcDsfOHmXm8GJM6euHHXDWrjKq2E/M3
LmV202rdIepSMUhG4a1nDzSJolFtl05k1QT7PlppHOud6B0KLtr8j+ectt5lfzJ0
4K+ihhk750gOcEVKWlj2IHqMtHiE9uQWFXfwDjx1e60PsuSKOv07tMCcAoBVD/UO
nDvICr+fpMgMR8pPEil372RF+fz+5xs8+7gxWgHy8m/4B7oL0jCSgjEYKYV5bRwV
urZBUs7AnIRD/DvgQgx0bL0RJh6s2K5EIR6SLai3qyVybTbvkRm/8fGF5LOCZVBB
9Ndl31xBz6ilv6Lg/KYembY+LXwKUQ==
=t2ue
-----END PGP SIGNATURE-----

--a7ainhg5kjscgtqi--
