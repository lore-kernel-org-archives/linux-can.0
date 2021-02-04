Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D41BC433DB
	for <linux-can@archiver.kernel.org>; Thu,  4 Feb 2021 12:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E259664F53
	for <linux-can@archiver.kernel.org>; Thu,  4 Feb 2021 12:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbhBDMuI (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 4 Feb 2021 07:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbhBDMuE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Feb 2021 07:50:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849D3C0613D6
        for <linux-can@vger.kernel.org>; Thu,  4 Feb 2021 04:49:23 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l7e4Q-0006pB-5X; Thu, 04 Feb 2021 13:49:14 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:de60:60b:d135:1fda])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7E7E15D68E8;
        Thu,  4 Feb 2021 12:49:11 +0000 (UTC)
Date:   Thu, 4 Feb 2021 13:49:10 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] can: xilinx_can: Simplify code by using dev_err_probe()
Message-ID: <20210204124910.3k52e26pqnei2oqt@hardanger.blackshift.org>
References: <91af0945ed7397b08f1af0c829450620bd92b804.1612442564.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xxblkl2lc6zjeh2y"
Content-Disposition: inline
In-Reply-To: <91af0945ed7397b08f1af0c829450620bd92b804.1612442564.git.michal.simek@xilinx.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xxblkl2lc6zjeh2y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.02.2021 13:42:48, Michal Simek wrote:
> Use already prepared dev_err_probe() introduced by commit a787e5400a1c
> ("driver core: add device probe log helper").
> It simplifies EPROBE_DEFER handling.
>=20
> Also unify message format for similar error cases.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xxblkl2lc6zjeh2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAb7UMACgkQqclaivrt
76moHQf+P+407ZM7dAhnCFn+vgcklv1aNqes5qfs04XTSoeW7YzpL2uIRirDRb75
ofphIZZYwo2Cd7c1Tw44CzeUCsrurs3MYWdxQvv5FpZGkGIYEyktl3iuddPSEUqa
xCZLMpsgCUQaBqDNKKv1wT9MZrXU9cNx2JJVOtoqqWCNldoL5recOdop6BpdN0OE
nU0ljU1xscTbqF6tPAIsrroplc1otdK8tpJI4mwUOHebOpYlpd9WtTgXmKEETxkr
mfgOOBjiCDs3IVSFNM+k4zw5ZG+3lxX7ygf5H0xrz7M4wTv/6gz9KO/PKqEjmMXX
kFxlhMUuwqCq6AnNOuNdTXaNPcqskw==
=JYmf
-----END PGP SIGNATURE-----

--xxblkl2lc6zjeh2y--
