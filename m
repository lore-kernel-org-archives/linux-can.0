From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: peak-usb: peak_usb_netif_rx() ts_high ununsed
Date: Fri, 8 Dec 2017 10:59:32 +0100
Message-ID: <d5e60605-6d3f-a7a1-7c8a-4a8c9766c3c9@pengutronix.de>
References: <ee2e4702-5d2d-b6fc-a90c-5fc9b0d3f362@pengutronix.de>
 <VI1PR0302MB33255A4E1224FB34C7B70572D6320@VI1PR0302MB3325.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2AD9s3EggV74c9gGQQIKX4edWIMiFi6NL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33833 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753791AbdLHJ7j (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Fri, 8 Dec 2017 04:59:39 -0500
In-Reply-To: <VI1PR0302MB33255A4E1224FB34C7B70572D6320@VI1PR0302MB3325.eurprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2AD9s3EggV74c9gGQQIKX4edWIMiFi6NL
Content-Type: multipart/mixed; boundary="koGOFdrJFoDe2DCQDSTd0M2goCfVh5l4c";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <d5e60605-6d3f-a7a1-7c8a-4a8c9766c3c9@pengutronix.de>
Subject: Re: peak-usb: peak_usb_netif_rx() ts_high ununsed
References: <ee2e4702-5d2d-b6fc-a90c-5fc9b0d3f362@pengutronix.de>
 <VI1PR0302MB33255A4E1224FB34C7B70572D6320@VI1PR0302MB3325.eurprd03.prod.outlook.com>
In-Reply-To: <VI1PR0302MB33255A4E1224FB34C7B70572D6320@VI1PR0302MB3325.eurprd03.prod.outlook.com>

--koGOFdrJFoDe2DCQDSTd0M2goCfVh5l4c
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 04:04 PM, St=C3=A9phane Grosjean wrote:
> Yep, you're right: peak_usb_get_ts_time() handles 32-bit wrapping
> when computing delay between two consecutives events, so the ts_high
> argument is useless.

ts_high is never used in the driver now.

> Consequently, each call to "peak_usb_netif_rx(a, b, c, d);" in
> pcan_usb_fd.c can be changed into "peak_usb_netif_rx(a, b, c);"
ACK.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--koGOFdrJFoDe2DCQDSTd0M2goCfVh5l4c--

--2AD9s3EggV74c9gGQQIKX4edWIMiFi6NL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloqYoQACgkQHv7KIOw4
HPbYawgAq5i7JnPicDAz3vpWTVZSpYKzv74LO3kN57KMGS+gHkTi2UyI/+bDgL9p
3wIxXfLH/xTQTzWeXn00Qq0ZY5KnBo/SaIESTnpJsjzOq9C3lrfmvy/NGIx0oD4/
OyxbtggpTnYes5zxfdrbIgNKPEptUAfePDelYAMNjc0XdUYO9kg6bXsjyutmg+iX
eHbLD5m9uIQ3oNS7xWeNz3Im7C10K9QUhZ3dQBQ0mosXfaNnPcTYTu26cb0VUVnr
8nOBlL4imIB0+wAeBm9jCqMNbXBHX4DhX+kbN6FDrUe1ZbE+oer8WCEi1zr7Kg9L
w4zIzISdAJMmgvccQ75oxglkp2qGhw==
=bsT/
-----END PGP SIGNATURE-----

--2AD9s3EggV74c9gGQQIKX4edWIMiFi6NL--
