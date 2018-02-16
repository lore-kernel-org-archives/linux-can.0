From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/2] can: kvaser_usb: Simplify struct
 kvaser_msg_cardinfo
Date: Fri, 16 Feb 2018 14:26:27 +0100
Message-ID: <809e5d4e-c637-2473-2794-f5ba6611e2bd@pengutronix.de>
References: <20180216132125.13232-1-jimmyassarsson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5vRWhunco5GxMdt0KBdbgGlfEYQ0ZUtSN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58125 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030925AbeBPN1Q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 08:27:16 -0500
In-Reply-To: <20180216132125.13232-1-jimmyassarsson@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5vRWhunco5GxMdt0KBdbgGlfEYQ0ZUtSN
Content-Type: multipart/mixed; boundary="kTYgLtrgUIpJaZJiwnNvOtg5eAPlSCZMj";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org
Message-ID: <809e5d4e-c637-2473-2794-f5ba6611e2bd@pengutronix.de>
Subject: Re: [PATCH v3 1/2] can: kvaser_usb: Simplify struct
 kvaser_msg_cardinfo
References: <20180216132125.13232-1-jimmyassarsson@gmail.com>
In-Reply-To: <20180216132125.13232-1-jimmyassarsson@gmail.com>

--kTYgLtrgUIpJaZJiwnNvOtg5eAPlSCZMj
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/16/2018 02:21 PM, Jimmy Assarsson wrote:
> serial_number_high can be removed from the struct since it is never use=
d in
> the USBcan II firmware.
>=20
> Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
> ---
> Changes in v3:
>   - Change data type of ean, from u32 to __le32.
>=20
> Changes in v2:
>   - Made this a separate patch.
>=20
>  drivers/net/can/usb/kvaser_usb.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kva=
ser_usb.c
> index 63587b8e6825..3c17bb3b1588 100644
> --- a/drivers/net/can/usb/kvaser_usb.c
> +++ b/drivers/net/can/usb/kvaser_usb.c
> @@ -196,19 +196,11 @@ struct kvaser_msg_simple {
>  struct kvaser_msg_cardinfo {
>  	u8 tid;
>  	u8 nchannels;
> -	union {
> -		struct {
> -			__le32 serial_number;
> -			__le32 padding;
> -		} __packed leaf0;
> -		struct {
> -			__le32 serial_number_low;
> -			__le32 serial_number_high;
> -		} __packed usbcan0;
> -	} __packed;
> +	__le32 serial_number;
> +	__le32 padding0;
>  	__le32 clock_resolution;
>  	__le32 mfgdate;
> -	u8 ean[8];
> +	__le32 ean[2];

Don't do that change in this patch - it belongs to 2/2.

>  	u8 hw_revision;
>  	union {
>  		struct {
> @@ -218,7 +210,7 @@ struct kvaser_msg_cardinfo {
>  			u8 padding;
>  		} __packed usbcan1;
>  	} __packed;
> -	__le16 padding;
> +	__le16 padding1;
>  } __packed;
> =20
>  struct kvaser_msg_cardinfo2 {
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--kTYgLtrgUIpJaZJiwnNvOtg5eAPlSCZMj--

--5vRWhunco5GxMdt0KBdbgGlfEYQ0ZUtSN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqG3AMACgkQk9IU1zQo
ZfHvPgf/RkyDTgmM9rNiKz8RgJQnO6mSeq0uilTcDLekFtdoblpMEemUHMgh2U2D
VWnnONqapTEzKi8ZTbsq627J5IC7r9TVLURjij6uNPjq5IKjjMOpAGJKzBe9o/gF
glSo5lO4ayBGACYp0+sSDTSr8WRL0hwIF1TvWxFS8bjqKYhKUkiyWpldAqFH72nV
4oKc9UG2QDbFs5IzQpdlmV2WbEh4QwNvUQ9+7BNmKeVzwuxI+V6/lOr2VBhJiaeq
NLsuU74Z2e2nIeyqHt1iCM9ObDGKP3orbVT1v6JdnTzzU/QSXRZ89gWaOyN+M+MN
3ToNtpgEBDimU/llBsurjvKrHtZy4g==
=LLhn
-----END PGP SIGNATURE-----

--5vRWhunco5GxMdt0KBdbgGlfEYQ0ZUtSN--
