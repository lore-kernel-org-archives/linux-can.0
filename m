From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] The gs_usb driver was performing USB transfers with
 buffers allocated on the stack. This causes the driver to not function with
 vmapped stacks.
Date: Fri, 24 Feb 2017 17:03:41 +0100
Message-ID: <a7a75930-46ac-3eeb-6238-1138d84ecb0a@pengutronix.de>
References: <20170224160034.13338-1-e@ethanzonca.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ENxTEoS4NW1o64tpRfcHbD6HJIigHiGbO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59437 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751334AbdBXQlz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Feb 2017 11:41:55 -0500
In-Reply-To: <20170224160034.13338-1-e@ethanzonca.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ethan Zonca <e@ethanzonca.com>, wg@grandegger.com, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ENxTEoS4NW1o64tpRfcHbD6HJIigHiGbO
Content-Type: multipart/mixed; boundary="oDvpTRQWna2Tmnd27tlqxsMJSd1EjlKOH";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ethan Zonca <e@ethanzonca.com>, wg@grandegger.com,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <a7a75930-46ac-3eeb-6238-1138d84ecb0a@pengutronix.de>
Subject: Re: [PATCH] The gs_usb driver was performing USB transfers with
 buffers allocated on the stack. This causes the driver to not function with
 vmapped stacks.
References: <20170224160034.13338-1-e@ethanzonca.com>
In-Reply-To: <20170224160034.13338-1-e@ethanzonca.com>

--oDvpTRQWna2Tmnd27tlqxsMJSd1EjlKOH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 05:00 PM, Ethan Zonca wrote:
> Instead, allocate memory for the transfer buffers.
>=20
> Also fix minor style issues: spaces between bitwise OR operators and de=
claration of bare unsigned variable.

Can you please make that three separate patches. Please send them to the
linux-can mailinglist (Cc'ed).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--oDvpTRQWna2Tmnd27tlqxsMJSd1EjlKOH--

--ENxTEoS4NW1o64tpRfcHbD6HJIigHiGbO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAliwWV0ACgkQHv7KIOw4
HPbqPggA0v0NiEnGSNYJRbNdpoqy604uRa1GlqsPPgCYh8yyTFY6hxT7/PjRIbIO
IfdIfgL5dNPwNOxnV0NXk+tJ27cjff98asdzA/3Ogh96Sq5YmtyOMA4xfhMsUZv0
Q7fXYm6gcYaUo07YIFOQQ7Qqp/MQfZlyvlKAYgp1vR50Dx68lbu0TQfyUjbBp7+/
Pr0EV9ZW/Oz9Js3yG0vRI9QCrus6GmPyFzzdLVUOXHWo1DszN0ye+JdO4Lf0Xnj1
m0FUdLNOL1kC0Ke6yyQPxeurBPd4C7lRDoJdEug7VOAWoxcjG4yClh6EH5X3Bt7C
n5+ZmZMOocFt8GPdW48F1WygoW1S6A==
=zVlt
-----END PGP SIGNATURE-----

--ENxTEoS4NW1o64tpRfcHbD6HJIigHiGbO--
