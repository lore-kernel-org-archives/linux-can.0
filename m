From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5] can: sun4i: fix overrun
Date: Tue, 7 Nov 2017 09:22:04 +0100
Message-ID: <a3f9fa4f-5382-8aef-8bc4-1c86da2f78b6@pengutronix.de>
References: <1509983842-18821-1-git-send-email-info@gerhard-bertelsmann.de>
 <1509988616-19479-1-git-send-email-info@gerhard-bertelsmann.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="OqhBJx2t3aj2B85nX45STLjnA4JVCavk4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49353 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933148AbdKGIWK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Nov 2017 03:22:10 -0500
In-Reply-To: <1509988616-19479-1-git-send-email-info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: GBert <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OqhBJx2t3aj2B85nX45STLjnA4JVCavk4
Content-Type: multipart/mixed; boundary="HPUeu6lDACLhEookNek3fbSt5ulV3Iav3";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: GBert <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org
Message-ID: <a3f9fa4f-5382-8aef-8bc4-1c86da2f78b6@pengutronix.de>
Subject: Re: [PATCH v5] can: sun4i: fix overrun
References: <1509983842-18821-1-git-send-email-info@gerhard-bertelsmann.de>
 <1509988616-19479-1-git-send-email-info@gerhard-bertelsmann.de>
In-Reply-To: <1509988616-19479-1-git-send-email-info@gerhard-bertelsmann.de>

--HPUeu6lDACLhEookNek3fbSt5ulV3Iav3
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/06/2017 06:16 PM, GBert wrote:
> From: cb2begq <info@gerhard-bertelsmann.de>
>=20
> SUN4Is CAN IP has a 64 byte deep FIFO buffer. If the buffer is not drai=
ned
> fast enough (overrun) it's getting mangled. Already received frames are=

> dropped - the data can't be restored.
>=20
> V5: ignore timeout error and add a comment
> V4: add error handling
> V3: fix compilation
> V2: no duplicate error reporting
>=20
>=20
> Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

Applied to can.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HPUeu6lDACLhEookNek3fbSt5ulV3Iav3--

--OqhBJx2t3aj2B85nX45STLjnA4JVCavk4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloBbS0ACgkQHv7KIOw4
HPYEywf/eofcKxAjeTQpKj8PZS5owVPF/VdbOY87Oi1WtKZoNlw0Nr7CQ45M6anH
32xrY6WJWjiawT1OLLEKQDKJhxOBvYVrYr2/v7kGPpHquH3HUbGQH2w5hoUj3U+J
na2W4ZACQONclo5HK/FPhUKuGkxaj2xaIUbwh//ncrcFm+beo5PbcY4sWUKJPgQO
EC265Hl5RUhssj8Y+BpMGSeOJ0UQ4GGJ/311Lgzt5TyjbGXWFNarGVAANUcnmjGF
ijVAwZXVYpjf3XWfWh9REFp+2Kjg9mFAGUwk8/fVCitofQE39hra51ePFUF7ZNEF
0hH93XZWZZaot/QC0zkcNDf1r7oE1A==
=hILq
-----END PGP SIGNATURE-----

--OqhBJx2t3aj2B85nX45STLjnA4JVCavk4--
