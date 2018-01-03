From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] CAN NETWORK DRIVERS: set cf->can_id to CAN_ERR_CRTL when
 cf->data[1] is filled with either CAN_STATE_ERROR_WARNING or
 CAN_STATE_ERROR_PASSIVE
Date: Wed, 3 Jan 2018 11:50:45 +0100
Message-ID: <01538ffa-fd44-4263-2ddf-2417930d990c@pengutronix.de>
References: <d2b8a0f4-e274-ef88-4428-b17c8a4f1966@ds-automotion.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="zADlFO3KL8FxDRFYn1q5ILhkIXcmvFdZA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49809 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751582AbeACKu5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Jan 2018 05:50:57 -0500
In-Reply-To: <d2b8a0f4-e274-ef88-4428-b17c8a4f1966@ds-automotion.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lederhilger Martin <M.Lederhilger@ds-automotion.com>, "wg@grandegger.com" <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zADlFO3KL8FxDRFYn1q5ILhkIXcmvFdZA
Content-Type: multipart/mixed; boundary="dmieKk6iSGDP1YWQXW0mMQ9Hd0eg7zVl7";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Lederhilger Martin <M.Lederhilger@ds-automotion.com>,
 "wg@grandegger.com" <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <01538ffa-fd44-4263-2ddf-2417930d990c@pengutronix.de>
Subject: Re: [PATCH] CAN NETWORK DRIVERS: set cf->can_id to CAN_ERR_CRTL when
 cf->data[1] is filled with either CAN_STATE_ERROR_WARNING or
 CAN_STATE_ERROR_PASSIVE
References: <d2b8a0f4-e274-ef88-4428-b17c8a4f1966@ds-automotion.com>
In-Reply-To: <d2b8a0f4-e274-ef88-4428-b17c8a4f1966@ds-automotion.com>

--dmieKk6iSGDP1YWQXW0mMQ9Hd0eg7zVl7
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 12/21/2017 03:42 PM, Lederhilger Martin wrote:
> This patch improves error reporting of the CAN driver for EMS Dr. Thoma=
s Wuensche CPC-USB/ARM7.
> Signed-off-by: Martin Lederhilger <m.lederhilger@ds-automotion.com>

Added to can after rephrasing the subject and commit message.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--dmieKk6iSGDP1YWQXW0mMQ9Hd0eg7zVl7--

--zADlFO3KL8FxDRFYn1q5ILhkIXcmvFdZA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpMtYUACgkQHv7KIOw4
HPbBPQgA0gJso3ud6Ho6PTyuMnvE6iSprBNwaMF+yu3MB4MgZcbtCXKz7KTzzciq
SZcVGIYgRWos5kJErPWxw2LqxRFZpKrZrW0bZQVI0mnlmWTQ4np9LV29kaayOg8y
U5UFwzNIntpoCTftSy5rhIQgoFbDUAwmJ7uvznnqvpnLJAD5RSrr+eS+BVP7UWa1
YzMfKhPsiB4rZ4vcix7NztZATwQDQI9SUUTNRaHA69neByDGTSfpruQJTtbQ5RLr
wb8LHBgsIJlrX6pj9cnVAc/11Cb7jNFO267a1ofKeXlIjhxII4Y32OVu19y+lR2O
XGkGvUzNQIX/cusb5SmtVp3jYBxiPA==
=Y4sR
-----END PGP SIGNATURE-----

--zADlFO3KL8FxDRFYn1q5ILhkIXcmvFdZA--
