From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH linux-can/testing] can: tcan4x5x: Disable the INH pin
 device-state GPIO is unavailable
Date: Thu, 9 Jan 2020 10:13:04 +0100
Message-ID: <cbb1b67d-4ded-7b18-ee9f-8bf0a728c639@pengutronix.de>
References: <20191212161536.23264-1-dmurphy@ti.com>
 <b0560413-525c-39ba-30ce-816c098e51ab@pengutronix.de>
 <afa5c681-bbd1-a6f6-2b58-4f24c924144e@pengutronix.de>
 <01f16f0f-cfdf-0a3c-48b1-59e0824c83e8@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fpYAuQt2XlEFQFDtw5R5YXONFkS9bkxgD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44093 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbgAIJNQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Jan 2020 04:13:16 -0500
In-Reply-To: <01f16f0f-cfdf-0a3c-48b1-59e0824c83e8@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fpYAuQt2XlEFQFDtw5R5YXONFkS9bkxgD
Content-Type: multipart/mixed; boundary="7xj7R9DykdC8qHiXWcS4m8WrFl6Rm9WSF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
Message-ID: <cbb1b67d-4ded-7b18-ee9f-8bf0a728c639@pengutronix.de>
Subject: Re: [PATCH linux-can/testing] can: tcan4x5x: Disable the INH pin
 device-state GPIO is unavailable
References: <20191212161536.23264-1-dmurphy@ti.com>
 <b0560413-525c-39ba-30ce-816c098e51ab@pengutronix.de>
 <afa5c681-bbd1-a6f6-2b58-4f24c924144e@pengutronix.de>
 <01f16f0f-cfdf-0a3c-48b1-59e0824c83e8@ti.com>
In-Reply-To: <01f16f0f-cfdf-0a3c-48b1-59e0824c83e8@ti.com>

--7xj7R9DykdC8qHiXWcS4m8WrFl6Rm9WSF
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 1/8/20 9:47 PM, Dan Murphy wrote:
>> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/log/=
?h=3Dtesting
>>
>> ...if I've collected every m_can related patch.
>=20
> Is this still relevant or have you pulled this in?

Yes, it's still relevant, because it's upstream in the mean time. If
there are any problems left, we should fix them.

> It looks good to me.

If you find time, please test.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--7xj7R9DykdC8qHiXWcS4m8WrFl6Rm9WSF--

--fpYAuQt2XlEFQFDtw5R5YXONFkS9bkxgD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl4W7qAACgkQWsYho5Hk
nSA3/wf8CSV/i981YFgY8ZAFJNg/jE7uzycNLKqGD71hO8d/8FPW9Kukyfrrhk5m
BpF7tb4IY95mC0lbE5g0UUbQitgsDl3jGHLtwQO/vP6OwWD1m2JrKjUFA4Pw1TSl
jIVaXHgwuS+xJFNdSAwsHOSry5iVedR8/3wxhPx67iCksJPe6t3YmXSHwV5PZw0c
idYIoxpm62OE+9/nJgg+AwCfBT1TVaVlkXKknWdsi7PpVuTHV6WW/WTxxclbuh38
LRN0Ec2UURJNwk2zTGK4KWlg231wYwXTmTAwIZKqmBks+pbtVqlJicZBdpIdEO66
lz/H/owcB1V2Z0mV2wbZgsgbhmoIKQ==
=IJve
-----END PGP SIGNATURE-----

--fpYAuQt2XlEFQFDtw5R5YXONFkS9bkxgD--
