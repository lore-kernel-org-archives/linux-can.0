Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917ECC433C1
	for <linux-can@archiver.kernel.org>; Wed, 24 Mar 2021 08:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7B9619F3
	for <linux-can@archiver.kernel.org>; Wed, 24 Mar 2021 08:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhCXIlf (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 24 Mar 2021 04:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbhCXIl0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Mar 2021 04:41:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DABC061763
        for <linux-can@vger.kernel.org>; Wed, 24 Mar 2021 01:41:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lOz4t-0004ur-6x; Wed, 24 Mar 2021 09:41:23 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:ac2f:839b:d9d7:b2c1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 619BF5FEC82;
        Wed, 24 Mar 2021 08:41:22 +0000 (UTC)
Date:   Wed, 24 Mar 2021 09:41:21 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Yegor Yefremov <yegorslists@googlemail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: RFC: slcan: read status flags
Message-ID: <20210324084121.wlnrqapgcfbvgfdp@pengutronix.de>
References: <CAGm1_ksAVdckLEg+uMts6U9+=83PjesaSNjFojFPedeCsUCrUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l6qftj4gfibgohhk"
Content-Disposition: inline
In-Reply-To: <CAGm1_ksAVdckLEg+uMts6U9+=83PjesaSNjFojFPedeCsUCrUA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--l6qftj4gfibgohhk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.03.2021 09:31:16, Yegor Yefremov wrote:
> Is there any chance we could add 'F' command to get the error flags?
> The problem is, there is no special interrupt or special packet coming
> from the serial-to-CAN converter. So we cannot timely send this
> information to the user.

You mean you have to send a 'F' command to the CAN controller to query
the status?

> But perhaps an IOCTL could get the current state?

Can you hook something up to the do_get_berr_counter() callback? What's
the response to a 'F' command?

You can send the command in the do_get_berr_counter() and sleep on a
waitqueue. On receive of the response in the serial RX handler, parse
it, store in data priv and wake up the waitqueue.

If you don't get any CAN error counters, but CAN state information (like
error active, passive, bus off), it might be a good idea to set some
error counter values that correspond to the CAN state. Send CAN state
CAN frames from RX handler as usual.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--l6qftj4gfibgohhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBa+y8ACgkQqclaivrt
76kpJwf/QvhCOj1k5yGFmmfeMDSdxz7IQFZeV76nItCD+rewnE3zXEjSwKvX69ve
32GUHZFa6jGrCKeKSfhsIcN5MEFxuqoTEZElaIxJsicvMLqrae/7HgcWu3IKZERm
P/vlx7gB33CrBWYCBVZLNH0PkbQu0EfIGNUQHlzhsrXSPwxStnOl3NCdjfc5F5Xu
ewXIRRhQY6OTNitPOLILqbsXCXmqtsrEzdhjvJXcrUJmmFul8Z0OUsXp3WXQB7KQ
2nkGnVMCY/V+89aLoHmhlZOtZp9KZy+fk9xBDeCFufrEekoDnD9stLbVS38TH1Oo
VVybI8+nK3rMUgOagDGPzcA/WtCv/g==
=mpEV
-----END PGP SIGNATURE-----

--l6qftj4gfibgohhk--
