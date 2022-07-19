Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9EEC43334
	for <linux-can@archiver.kernel.org>; Tue, 19 Jul 2022 19:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbiGST3U (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 19 Jul 2022 15:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiGST3U (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 15:29:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D2652DD7
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 12:29:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oDsuD-0005EF-Px; Tue, 19 Jul 2022 21:29:17 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 02522B44B7;
        Tue, 19 Jul 2022 19:29:16 +0000 (UTC)
Date:   Tue, 19 Jul 2022 21:29:16 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 1/3] can: peak_usb: constify characters string
Message-ID: <20220719192916.x4yvllpvoik5zcg7@pengutronix.de>
References: <20220719120632.26774-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h5syhnca2bgkfkpn"
Content-Disposition: inline
In-Reply-To: <20220719120632.26774-1-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--h5syhnca2bgkfkpn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.07.2022 14:06:30, Stephane Grosjean wrote:
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Please add a patch description next time. Added one while applying. Also
fixed the comment style in patch 3/3.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--h5syhnca2bgkfkpn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLXBgkACgkQrX5LkNig
012B7ggAq44LI+8sxFuJEcSl7GPU8ytKsdNaF09YsXpMTIBPn5cO/PaFuKoeCldf
tMfA6dJFZxAuSIYIufJ98RDG6/vG5szSl27AeVVPnYMEngbBtUki7nJIMlNXnu4s
GKgn8/jHCEmO7pDM3pnzTdmIbSrRj4m7Ez4TQgBh1mhU/5J/Gdjm5lA0w2u07Dim
Odp6zYMfxpATlmpaPOyPLitofWcK9u9JL/72Z7ShvYZL84e5QPU3MS2sXRGgJJTm
a5ZyT9omD/DQh6AMBt8LLU+q3gwIpzW9oHkCcvYKbuWakef3uDheW25HlCWc3mVV
doQCVacB1kdY7ocSi68CgeAo7bjQ/Q==
=tAD/
-----END PGP SIGNATURE-----

--h5syhnca2bgkfkpn--
