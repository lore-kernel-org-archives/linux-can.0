From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] net, can, ifi: fix "write buffer full" error
Date: Thu, 8 Feb 2018 22:33:54 +0100
Message-ID: <ca1b9134-1e5a-ea83-146f-693ba38be413@pengutronix.de>
References: <20180208064748.17985-1-hs@denx.de>
 <59322f7d-4207-a5a4-89b5-dff1634e4183@pengutronix.de>
 <dfae1bda-9ccd-6a48-95f9-e061c1bd3828@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AjzWQDiH4BTjT9M1jcvMMIAvLcuVe9UvA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36579 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBHVek (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Feb 2018 16:34:40 -0500
In-Reply-To: <dfae1bda-9ccd-6a48-95f9-e061c1bd3828@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>, linux-can@vger.kernel.org
Cc: Markus Marb <markus@marb.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AjzWQDiH4BTjT9M1jcvMMIAvLcuVe9UvA
Content-Type: multipart/mixed; boundary="O3JBU05ZpuhadwbMSXPFnpyaJSgR8MAI1";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>,
 linux-can@vger.kernel.org
Cc: Markus Marb <markus@marb.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <ca1b9134-1e5a-ea83-146f-693ba38be413@pengutronix.de>
Subject: Re: [PATCH v2 1/2] net, can, ifi: fix "write buffer full" error
References: <20180208064748.17985-1-hs@denx.de>
 <59322f7d-4207-a5a4-89b5-dff1634e4183@pengutronix.de>
 <dfae1bda-9ccd-6a48-95f9-e061c1bd3828@denx.de>
In-Reply-To: <dfae1bda-9ccd-6a48-95f9-e061c1bd3828@denx.de>

--O3JBU05ZpuhadwbMSXPFnpyaJSgR8MAI1
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/08/2018 08:22 PM, Marek Vasut wrote:
> On 02/08/2018 03:46 PM, Marc Kleine-Budde wrote:
>> On 02/08/2018 07:47 AM, Heiko Schocher wrote:
>>> the driver reads in the ISR first the IRQpending register,
>>> and clears after that in a write *all* bits in it.
>>>
>>> It could happen that the isr register raise bits between
>>> this 2 register accesses, which leads in lost bits ...
>>>
>>> In case it clears "TX message sent successfully", the driver
>>> never sends any Tx data, and buffers to userspace run over.
>>>
>>> Fixed this:
>>> clear only the bits in the IRQpending register, the
>>> driver had read.
>>>
>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>> Reviewed-by: Marek Vasut <marex@denx.de>
>>
>> Applied both to linux-can.
>=20
> Can you also apply them to stable, so they get into 4.9.x etc ?

I've already added stable on Cc, so they will be picked up by the stable
maintainers.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--O3JBU05ZpuhadwbMSXPFnpyaJSgR8MAI1--

--AjzWQDiH4BTjT9M1jcvMMIAvLcuVe9UvA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlp8wkMACgkQk9IU1zQo
ZfE7FggAr/8DWqoGIVzkjlBsFruOMFUvtM/nKU3cFX6DwndYf7m9Z1LTk2WdpC3J
EgdfbDLms/CtGEoTCApVMxVcvAQwoQyyrd8QJYefJrBBQKenYATi8xX4pkpU0P9S
cNL7jVYPpDnFECM/OZR222tU6yy90W5Aw7ZG29S5jcf4skqVC189khTTgwlhks0B
j+TLHDUKEJbk/pGzz/pWG/dvK7r7dnlpdB5EyR/0zhMdi54WPtQ0QRnaFU/ImYL5
e8EUX/sQYSGcQfPEUZIKQSAv6Dht6h3CNfzipc1JvvTFs+W7FWTDfc5hg+nNTlbP
fFU+r2FZ2pRJ3LTPDHYd68DXCRMdUQ==
=G2Z6
-----END PGP SIGNATURE-----

--AjzWQDiH4BTjT9M1jcvMMIAvLcuVe9UvA--
