Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB93C433F5
	for <linux-can@archiver.kernel.org>; Tue,  7 Sep 2021 06:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E398D60232
	for <linux-can@archiver.kernel.org>; Tue,  7 Sep 2021 06:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhIGGkS (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 7 Sep 2021 02:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhIGGkR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Sep 2021 02:40:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF5C061575
        for <linux-can@vger.kernel.org>; Mon,  6 Sep 2021 23:39:11 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mNUl5-0003cx-6v; Tue, 07 Sep 2021 08:39:03 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-bd09-20f3-2295-682f.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:bd09:20f3:2295:682f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BE641678816;
        Tue,  7 Sep 2021 06:39:00 +0000 (UTC)
Date:   Tue, 7 Sep 2021 08:38:59 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Dario Binacchi <dariobin@libero.it>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] can: c_can: fix null-ptr-deref on ioctl()
Message-ID: <20210907063859.llgedf5wc4n4rc73@pengutronix.de>
References: <20210906233704.1162666-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hbn3bbhn5ny2drbw"
Content-Disposition: inline
In-Reply-To: <20210906233704.1162666-1-ztong0001@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--hbn3bbhn5ny2drbw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.09.2021 16:37:02, Tong Zhang wrote:
> the pdev maybe not a platform device, e.g. c_can_pci device,
> in this case, calling to_platform_device() would not make sense.
> Also, per the comment in drivers/net/can/c_can/c_can_ethtool.c, @bus_info
> sould match dev_name() string, so I am replacing this with dev_name() to
  ^^^^^
  should

Fixed while applying.

> fix this issue.
>=20
> [    1.458583] BUG: unable to handle page fault for address: 000000010000=
0000
> [    1.460921] RIP: 0010:strnlen+0x1a/0x30
> [    1.466336]  ? c_can_get_drvinfo+0x65/0xb0 [c_can]
> [    1.466597]  ethtool_get_drvinfo+0xae/0x360
> [    1.466826]  dev_ethtool+0x10f8/0x2970
> [    1.467880]  sock_ioctl+0xef/0x300
>=20
> Fixes: 2722ac986e93 ("can: c_can: add ethtool support")
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>

Applied to linux-can/testing + added stable on Cc.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hbn3bbhn5ny2drbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmE3CQAACgkQqclaivrt
76mPnQf9FlnF0qWsD40bZToqcod8lIoeZbZpp1TIqbe0jiVif3a5s3eohV7/ZyDb
wyVKfYK3kDsRZrR8ooDXXhjW6KjtX9RPdxt7q26+bq3FnZz1yxb3XYDB2L3tKh/T
WUY0xS0f+rBM+YprvBorusR/m1/RH1Y8FTVJplHNcyV4GYP3l+8DiYBkdYvDh5Pb
Ki9DE7h1aPcGatI2GejClZ8graC6PCklIpuvtIw4A907RteARcvwvUZYKClv8KFP
xgzUIABh60Tvz4BtC4FFB48WtMeaDp2rfxLXap06u+ZvEF2PNXmmCFAMnbP2demE
Lkpxz5fHT40EmTo7E1g0sdbYG364Dw==
=NJEs
-----END PGP SIGNATURE-----

--hbn3bbhn5ny2drbw--
