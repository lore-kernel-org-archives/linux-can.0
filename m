From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: j1939: generic addr struct
Date: Thu, 17 Aug 2017 09:43:02 +0200
Message-ID: <cbeb1c36-7ea5-353a-cb9d-7d1c0d3dc997@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cfBg0XsehRARkpJXjRgHgxP8wSONsxsr5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59545 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751173AbdHQHnK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 03:43:10 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, David Jander <david@protonic.nl>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cfBg0XsehRARkpJXjRgHgxP8wSONsxsr5
Content-Type: multipart/mixed; boundary="EX2U8Ut5P8nEuSQURtJHI8qSEJxrqsBmW";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>,
 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
 David Jander <david@protonic.nl>
Message-ID: <cbeb1c36-7ea5-353a-cb9d-7d1c0d3dc997@pengutronix.de>
Subject: j1939: generic addr struct

--EX2U8Ut5P8nEuSQURtJHI8qSEJxrqsBmW
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello,

I'd like to introduce a generic j1939 address struct, it's used inside
the kernel only, so no userspace visible changes. What about:

> +struct j1939_addr {
> +       name_t src_name;
> +       name_t dst_name;
> +       pgn_t pgn;
> +
> +       u8 sa;
> +       u8 da;
> +};

=2E..or use src_addr and dst_addr, instead of sa and da?

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--EX2U8Ut5P8nEuSQURtJHI8qSEJxrqsBmW--

--cfBg0XsehRARkpJXjRgHgxP8wSONsxsr5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmVSQYACgkQHv7KIOw4
HPbsHQgAtNoN7adfDQdtQAeP8RWbogat8L1EC06v1Bbq522CPKbA0O7shF2Buuw+
Kra1jQMKiZ37EDgvceYoMm91B+or5T7nUIVhsQMm6pye5lntnhVrne3c25HzGlW2
WZzY5CNYD6+9Wn+QiOq9DxGpMVEUL+5kdp/qN/ZP0q8yW7jDDrMx1U/xHfctSra4
EBbE0AJ0KM/M25afwcW6tP6gK8r48Jn9MKA3opMK4IHxLi2TuvGEyCZXaPcwK918
P2GjiLeEHbsKYnP1nBN2kvdEbvEMIqBHvMwDWHHAEUp2i8iIymuUS7ayapwhqfHZ
qdWtlO+tZMoRhcdOzAF/m+GwpgAPKw==
=dU0p
-----END PGP SIGNATURE-----

--cfBg0XsehRARkpJXjRgHgxP8wSONsxsr5--
