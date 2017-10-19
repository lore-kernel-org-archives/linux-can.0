From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: gs_usb: fix busy loop if no more TX context is
 available
Date: Thu, 19 Oct 2017 11:24:00 +0200
Message-ID: <ce09e16e-85bc-d7ea-a0ae-39ebee9fc4bb@pengutronix.de>
References: <081cdc97-4633-f9b2-2c48-dd4f036c576f@grandegger.com>
 <7e8d89c3-b7af-81c1-cbed-04e83b396162@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="dJ5QaSPoxA6c5LESUpOQeXC2GX7svJSJP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57641 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751797AbdJSJYG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Oct 2017 05:24:06 -0400
In-Reply-To: <7e8d89c3-b7af-81c1-cbed-04e83b396162@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Maximilian Schneider <max@schneidersoft.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dJ5QaSPoxA6c5LESUpOQeXC2GX7svJSJP
Content-Type: multipart/mixed; boundary="d3UNtS7iIdrWIFpjIGsiC1FTRRsDneckD";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Maximilian Schneider <max@schneidersoft.net>
Message-ID: <ce09e16e-85bc-d7ea-a0ae-39ebee9fc4bb@pengutronix.de>
Subject: Re: [PATCH] can: gs_usb: fix busy loop if no more TX context is
 available
References: <081cdc97-4633-f9b2-2c48-dd4f036c576f@grandegger.com>
 <7e8d89c3-b7af-81c1-cbed-04e83b396162@grandegger.com>
In-Reply-To: <7e8d89c3-b7af-81c1-cbed-04e83b396162@grandegger.com>

--d3UNtS7iIdrWIFpjIGsiC1FTRRsDneckD
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/19/2017 10:07 AM, Wolfgang Grandegger wrote:
> Hello,
>=20
> any comments/feedback about that issue? I wonder why it has not been=20
> showed up earlier.

Applied to can + added stable on Cc

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--d3UNtS7iIdrWIFpjIGsiC1FTRRsDneckD--

--dJ5QaSPoxA6c5LESUpOQeXC2GX7svJSJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlnobzAACgkQHv7KIOw4
HPZtiAf/SwlavkHgGCF29bswpcnWNKbtwNbiQ9NtHaGZt3Q4FxElCyVfLsIEzD4a
+C0+KcnweLb1W4d3E8IFikKTER6XrfQGFLSBCC8Tt4769GkSim4LNG+eSWqAbgWR
wl5jvLwGhKab6SkPhFo7Tfc7MmPTrQWNMEwWFjC7zt7gIdj5rWVReB20WxNf3Be2
U6bPwl4iQeDu9Syrqon4HCDQ8jeEUYou8zqt+8WssvuzRshJmXKAFuUVbDWsKVFX
U8Wj/NbySGQ40qNnvVJ+bECygOc7GmPI3uYXdWS3C2ChJ3KqehPh62AvVN63JTvW
uqdLHXKey6VEbY9Jyp2eG37Lzh9VGw==
=kFnO
-----END PGP SIGNATURE-----

--dJ5QaSPoxA6c5LESUpOQeXC2GX7svJSJP--
