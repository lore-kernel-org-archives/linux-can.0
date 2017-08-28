From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 08/14] can: af_can: can_rx_register(): use max() instead
 of open coding it
Date: Mon, 28 Aug 2017 17:24:56 +0200
Message-ID: <784b180d-53d3-d0ed-8186-fa2d00fed94d@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-9-mkl@pengutronix.de>
 <36e76b44-3e3a-f5fc-46f4-77ccabca5d8f@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="KrtU1DfpEd9BicL2aAv6N610R1Rtk5Vh3"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44125 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751161AbdH1PZB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Aug 2017 11:25:01 -0400
In-Reply-To: <36e76b44-3e3a-f5fc-46f4-77ccabca5d8f@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KrtU1DfpEd9BicL2aAv6N610R1Rtk5Vh3
Content-Type: multipart/mixed; boundary="HTC4tf6glw2gVs0gvDKdfDU3gPDe543br";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <784b180d-53d3-d0ed-8186-fa2d00fed94d@pengutronix.de>
Subject: Re: [PATCH 08/14] can: af_can: can_rx_register(): use max() instead
 of open coding it
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-9-mkl@pengutronix.de>
 <36e76b44-3e3a-f5fc-46f4-77ccabca5d8f@hartkopp.net>
In-Reply-To: <36e76b44-3e3a-f5fc-46f4-77ccabca5d8f@hartkopp.net>

--HTC4tf6glw2gVs0gvDKdfDU3gPDe543br
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 03:28 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
>> This patch replaces an open coded max by the proper kernel define max(=
).
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Acked-by: Oliver Hartkopp <soketcan@hartkopp.net>

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HTC4tf6glw2gVs0gvDKdfDU3gPDe543br--

--KrtU1DfpEd9BicL2aAv6N610R1Rtk5Vh3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmkNckACgkQHv7KIOw4
HPaedgf/f84jQpuUmW//wi7HNTz4Ab48hnDUM7v1bRqjOOb35Sjtmlm5VgqSCjow
GENvLpPK9y4h5/96cXxTTuTAMczqZOrfvB3z5trj2d/PoWP9jM6fY2EaKYYNtXZ7
hQC1geRvMaHQ501Z7x+4BobUPNPh85nkl14zuEndfko2BElYlJB3t8f93KlHl2QH
iQUb0WTN5WZnvwz1KyGwjoeMba0QRQweGwbu6ul2Bmh0TY3rsA8vGFwPqoaQWu8E
zhqcqJjoEc5A4VPLLpBe+hFs4qrI47hfcwWjU3NSZZVuRdYTutyW7JifCcW8+WcO
3FealZSjKrEbsKXFq67bPDR4BLhssA==
=A69y
-----END PGP SIGNATURE-----

--KrtU1DfpEd9BicL2aAv6N610R1Rtk5Vh3--
