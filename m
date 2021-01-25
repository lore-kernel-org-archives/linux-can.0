Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC69BC433E0
	for <linux-can@archiver.kernel.org>; Tue, 26 Jan 2021 14:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885FB206F7
	for <linux-can@archiver.kernel.org>; Tue, 26 Jan 2021 14:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405826AbhAZOjX (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 26 Jan 2021 09:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391308AbhAZJsM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jan 2021 04:48:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12295C061756
        for <linux-can@vger.kernel.org>; Tue, 26 Jan 2021 01:47:32 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l4KwV-0001x5-BC; Tue, 26 Jan 2021 10:47:23 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:6c72:efc:f7c6:b5c2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 040F05CD72C;
        Mon, 25 Jan 2021 17:50:02 +0000 (UTC)
Date:   Mon, 25 Jan 2021 18:50:02 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     trix@redhat.com
Cc:     wg@grandegger.com, davem@davemloft.net, kuba@kernel.org,
        socketcan@hartkopp.net, colin.king@canonical.com,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: mcba_usb: remove h from printk format specifier
Message-ID: <20210125175002.7afvx63iqoiqgucz@hardanger.blackshift.org>
References: <20210124150916.1920434-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mnrr4n7v7iy5rkut"
Content-Disposition: inline
In-Reply-To: <20210124150916.1920434-1-trix@redhat.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--mnrr4n7v7iy5rkut
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21-01-24 07:09:16, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>=20
> This change fixes the checkpatch warning described in this commit
> commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
>   unnecessary %h[xudi] and %hh[xudi]")
>=20
> Standard integer promotion is already done and %hx and %hhx is useless
> so do not encourage the use of %hh[xudi] or %h[xudi].
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>

Added to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--mnrr4n7v7iy5rkut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAPBMcACgkQqclaivrt
76kUGQf+JLQZOWRFcqRCPuMen2ZqE1NyXfQrfReiAvL/TeAoiCTG9r1asgTvnzMn
sKSIW9cQkDHc8Ub7CprAgmrN/LMsGgdyi2LxsDfYXljpt324ZKeLP7VVtjga8+PQ
uvuR+SAlld3seXmSABMcsrf4ViJf4IcXU0zgfxPzMT6Cyb5QvwbUKTonnye6kMUH
NAmYQlgFLCgInyVvklEkDf52X2DAy8boTIUt6gdcKy8J9Iw/5FSHrhZq9FVJ3OKV
IInvSsThpO51aX73SuC5iAR5fci33Hnd61ElhIKZaCe/sGK8FTY6ChRI69GQNAl1
1AKyAk60SI4AaruWbQA58y+2o2MRPA==
=nlzt
-----END PGP SIGNATURE-----

--mnrr4n7v7iy5rkut--
