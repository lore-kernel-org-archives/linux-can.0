From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can-j1939: fix ecu allocation at bad time
Date: Thu, 9 Mar 2017 11:16:49 +0100
Message-ID: <3005bf21-2c73-3756-ee34-c52d388c4a56@pengutronix.de>
References: <20170309093304.31542-1-maxime.jayat@mobile-devices.fr>
 <20170309100639.GC32600@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hQkF6FoALba0CheF9k0apvIejnvaUJbPh"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48519 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750798AbdCIKRB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Mar 2017 05:17:01 -0500
In-Reply-To: <20170309100639.GC32600@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maxime Jayat <maxime.jayat@mobile-devices.fr>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hQkF6FoALba0CheF9k0apvIejnvaUJbPh
Content-Type: multipart/mixed; boundary="eiRXeXWsng7Sa1jSAojm6pICk3BcHhXjT";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Maxime Jayat <maxime.jayat@mobile-devices.fr>, linux-can@vger.kernel.org
Message-ID: <3005bf21-2c73-3756-ee34-c52d388c4a56@pengutronix.de>
Subject: Re: [PATCH] can-j1939: fix ecu allocation at bad time
References: <20170309093304.31542-1-maxime.jayat@mobile-devices.fr>
 <20170309100639.GC32600@airbook.vandijck-laurijssen.be>
In-Reply-To: <20170309100639.GC32600@airbook.vandijck-laurijssen.be>

--eiRXeXWsng7Sa1jSAojm6pICk3BcHhXjT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/09/2017 11:06 AM, Kurt Van Dijck wrote:
> Hey Mark,
>=20
> When you resume your j1939 mainline work, please add this patch.

Will do.

> Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

You mean probably Acked-by, as the patch does not flow through your hands=
=2E

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--eiRXeXWsng7Sa1jSAojm6pICk3BcHhXjT--

--hQkF6FoALba0CheF9k0apvIejnvaUJbPh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljBK5EACgkQHv7KIOw4
HPYiuwf/f4S4UaI30UOETADCBdgCUgUNTtw40XMPmBM86uDQaHBIxhLpoDF8tNNV
E3qPZ5Hl9Va3HXpce9GkL646UgeY5DFpfNAzuzy306lG/a1WfIzZiwkB8353WPfR
HHH4Woc2qPp605CFJ3ptUubUqPiXxPvJySyq8KVMBsqJq+ZyXzpLVveN6LeR7qmK
NHIe4mGopqlhLfimIN7lLLc3zQU4puVbpDJuvUuNYG6p+g+k/I2d8NmBGpGspT7J
+pDP3Jg7vDsnpVZXbW0xveVv7Yg9/NSqcXJAEzIXe6E7aBVoN0Vg8C55mbKyQeDj
iORInGF8cF3omY3QGQdW9WmcN613Og==
=LTnD
-----END PGP SIGNATURE-----

--hQkF6FoALba0CheF9k0apvIejnvaUJbPh--
