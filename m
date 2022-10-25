Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D968C38A2D
	for <linux-can@archiver.kernel.org>; Tue, 25 Oct 2022 13:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiJYNa5 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 25 Oct 2022 09:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiJYNai (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Oct 2022 09:30:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F43EC1DE
        for <linux-can@vger.kernel.org>; Tue, 25 Oct 2022 06:30:23 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1onK0a-0001mt-J0; Tue, 25 Oct 2022 15:30:20 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 35D19109807;
        Tue, 25 Oct 2022 13:30:19 +0000 (UTC)
Date:   Tue, 25 Oct 2022 15:30:18 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Lukas Magel <lukas.magel@posteo.net>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 4/7] can: peak_usb: replace unregister_netdev() with
 unregister_candev()
Message-ID: <20221025133018.tb3rvrh4ege5rzne@pengutronix.de>
References: <20221022213535.8495-1-lukas.magel@posteo.net>
 <20221022213535.8495-5-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uhe7657mevdorzpd"
Content-Disposition: inline
In-Reply-To: <20221022213535.8495-5-lukas.magel@posteo.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--uhe7657mevdorzpd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.10.2022 21:35:32, Lukas Magel wrote:
> From: Stephane Grosjean <s.grosjean@peak-system.com>
>=20
> This patch changes call to unregister_netdev() with unregister_candev().
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Your S-o-b is missing.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--uhe7657mevdorzpd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNX5OgACgkQrX5LkNig
013y5wf9EChtdY50cAmu0TcY9qPenDcg+IaiJ8fYS+MghyaJZQBculYvvU1bWS4Y
Ttd5TJuMS8h0R1bVn3oNBYICZ4k3Xrcu4zIdmucTEvMzXJ9ieyyyt0Mi/HUjHQj0
m6HEEqFSgyF2JpSDLk5tflqzeE9pl9E31EQr8WFGm3FIJoOXd6eIA/cGQMtkrJc9
dfCzLEmUM2bUByre/Xy6r03SFdkqnEUvri2JY2gsC8IFP4OWgUWP7V+GJCVJPyt6
YrZyM5r4dlEuQwdAsG+d09M7sQyMnlePZTVSQvLCipvcsPfHwZgj0jINaTK0Sc6o
afWwpkwkytgHSFnqxBqb9kl0rWd3AA==
=bCSX
-----END PGP SIGNATURE-----

--uhe7657mevdorzpd--
