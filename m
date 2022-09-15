Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0896CECAAA1
	for <linux-can@archiver.kernel.org>; Thu, 15 Sep 2022 08:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiIOIXA (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 15 Sep 2022 04:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiIOIWe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Sep 2022 04:22:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AD298759
        for <linux-can@vger.kernel.org>; Thu, 15 Sep 2022 01:21:10 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oYk7Q-0005kz-UV; Thu, 15 Sep 2022 10:21:08 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:e736:a6f2:e69:df99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 546C2E3A7B;
        Thu, 15 Sep 2022 08:21:08 +0000 (UTC)
Date:   Thu, 15 Sep 2022 10:21:00 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: [PATCH v9 0/7] can: support CAN XL
Message-ID: <20220915082100.3fwytzz3r4gvx2n7@pengutronix.de>
References: <20220912170725.120748-1-socketcan@hartkopp.net>
 <85091fff-f8c6-efc5-eb40-17166e8734fe@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wtccqsl32uxjyxkh"
Content-Disposition: inline
In-Reply-To: <85091fff-f8c6-efc5-eb40-17166e8734fe@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--wtccqsl32uxjyxkh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.09.2022 07:13:49, Oliver Hartkopp wrote:
> since we missed the 6.0 merge window end of July there has been no
> functional change to this patch set.
>=20
> We are now at 6.0-rc5 again and I would like to extend the CI/test and us=
age
> coverage in net-next and other linux-next trees for these changes.
>=20
> Can you please upstream this patch set when there are no more remarks from
> your side either?

Applied to linux-can-next and included in my recent pull request.

Thanks for your work,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wtccqsl32uxjyxkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMi4GkACgkQrX5LkNig
010BwQgAuF0vLqL7A8ZcOCFscn1zRvdZJhEZbo2kWKvvdbGF4kI/lyArKUQLvCvK
UM72/fwDzWbr8vm3Ti3ItOhCK1qViSaS449IbnLLPyVImCMdBTJQtyP9pdNm15bP
Bqr29mGB55TzuUtZK7SNazGcrUHuzzGW+cbX/gD6sal7zc7cZN8JEJ5c9oSOflL/
cKEI+r/n0zYTtM4H0iBQsaGB5SJxKzJhi0s4iR66xfrov6iOaWAw3axlV1P/1kIn
oRHuSzluVIAwgQlyXgAbrfhQLN1ainBHrKuvBYkWasHCXr03ObXapA2GXJ41a2R8
4ORPG3K77dXDeG/ioLY5FSJSbql+fA==
=h/Q9
-----END PGP SIGNATURE-----

--wtccqsl32uxjyxkh--
