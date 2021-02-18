Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71E7C433E0
	for <linux-can@archiver.kernel.org>; Thu, 18 Feb 2021 20:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7625364DA8
	for <linux-can@archiver.kernel.org>; Thu, 18 Feb 2021 20:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhBRUij (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 18 Feb 2021 15:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhBRUh0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Feb 2021 15:37:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DAFC06178A
        for <linux-can@vger.kernel.org>; Thu, 18 Feb 2021 12:36:46 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lCq2S-0002CM-Pc; Thu, 18 Feb 2021 21:36:40 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:2d7d:5aac:572b:4471])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 83EAE5E446B;
        Thu, 18 Feb 2021 20:36:38 +0000 (UTC)
Date:   Thu, 18 Feb 2021 21:36:37 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     linux-can@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V3 0/3] can: flexcan: fixes for freeze mode
Message-ID: <20210218203637.tax6lm53n3r3miry@pengutronix.de>
References: <20210218110037.16591-1-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="htdpndxuebxii7jn"
Content-Disposition: inline
In-Reply-To: <20210218110037.16591-1-qiangqing.zhang@nxp.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--htdpndxuebxii7jn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.02.2021 19:00:34, Joakim Zhang wrote:
> Fixes for freeze mode.

Applied all to linux-can/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--htdpndxuebxii7jn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAuz9IACgkQqclaivrt
76nbigf9HPsIuf6Zo4bUHQb1qAzFB3FRHO+fzv9QUUEmULTvUZumE5ta16JKZOB5
PKyih3xLrwiuic6r/nl2PWGqwjxRfJ4w/wxp6+FZbZcxXn0wa1ny+8KNerr7KZv0
DzfjDpc/UF9exlTqcOA3m9kF06KP1Kxq5v0EYoc/660h0TTPtnLcK/BnVXzVANRp
c2y12O5J+tGDqz6NA+/j6c/eU4mAygskLTblpdQCU2oAGu4+vQdf3SK61czbJFPa
VXsBDzbKTPQTZqEF85EJRGnzZZ1raCQeCU0Wbqab/V8CeII1EjV1emGUv7N+OW8Y
4WHE06SBbCjv85AyFt6hTMxRaxQssA==
=yUf0
-----END PGP SIGNATURE-----

--htdpndxuebxii7jn--
