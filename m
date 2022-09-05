Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B80C6FA86
	for <linux-can@archiver.kernel.org>; Mon,  5 Sep 2022 16:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiIEQM2 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 5 Sep 2022 12:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiIEQM1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Sep 2022 12:12:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEC353D2B
        for <linux-can@vger.kernel.org>; Mon,  5 Sep 2022 09:12:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oVEi0-0007BO-Ij; Mon, 05 Sep 2022 18:12:24 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:b4c0:a600:5e68:1e31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 691A2DAE5C;
        Mon,  5 Sep 2022 16:12:22 +0000 (UTC)
Date:   Mon, 5 Sep 2022 18:12:21 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "Fink, Peter" <pfink@christ-es.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        John Whittington <git@jbrengineering.co.uk>
Subject: Re: [PATCH v3 0/2] can: gs_usb: hardware timestamp support
Message-ID: <20220905161221.fdncypbd27kirnx6@pengutronix.de>
References: <20220827221548.3291393-1-mkl@pengutronix.de>
 <20220827222253.2r7nydujnquubsgy@pengutronix.de>
 <0455cdf16ab7430291b2691f3f00854a@christ-es.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fnaiuyybzxx7xqe"
Content-Disposition: inline
In-Reply-To: <0455cdf16ab7430291b2691f3f00854a@christ-es.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--2fnaiuyybzxx7xqe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.08.2022 09:16:10, Fink, Peter wrote:
> Hi Marc,
>=20
> currently CANext FD does not support timestamps. We also have no
> active plans on adding timestamp support, but I wouldn't rule it out
> completely that this might come up at some point and we will add it.

Thanks for the feedback,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2fnaiuyybzxx7xqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMWH+MACgkQrX5LkNig
0132SggAp5BkwR6TR51Whah2mj60+zO5dZizBE+HdcFUZcFlw2X4TgJSACtuRZuI
XSWR3SBMiXebesecpoH84efbfvpZnDeH20W2SGV1wu0rvP/IShTAgEmlSd8LOigq
4n9+Qna6BuAgnxdGF1Tcus/tvIRVGHZbP5xYtJWXIt7OJklcBXxR/7F92gcJFqOp
kd2jOb/wSAN3BoQWtrD0e+39rI5Rn6dAfHHICjeELBeAqVjpJnzO9gqDl633qzYQ
DIigpfj7Yn8pfk2rtSNlQTAlmLw42l8uE/zKsJEe3uHcBzU45w3yIQA6jUAgc33Z
qILORFw+exaiIm5YOP4Ww1RtYyP6pA==
=YYZh
-----END PGP SIGNATURE-----

--2fnaiuyybzxx7xqe--
