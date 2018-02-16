From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: kvaser_usb: Simplify struct
 kvaser_msg_cardinfo
Date: Fri, 16 Feb 2018 11:24:57 +0100
Message-ID: <588ce8c3-5a21-b678-50b2-a9d9d6949d63@pengutronix.de>
References: <20180216091337.13924-1-jimmyassarsson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fA3RxQJnm25Ilwbf4eYHYb0NGZjGu0hCH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49105 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933469AbeBPKZq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 05:25:46 -0500
In-Reply-To: <20180216091337.13924-1-jimmyassarsson@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fA3RxQJnm25Ilwbf4eYHYb0NGZjGu0hCH
Content-Type: multipart/mixed; boundary="io8fpyiCb1Th6jjpzYN0bib9CpghwUMiL";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org
Message-ID: <588ce8c3-5a21-b678-50b2-a9d9d6949d63@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: kvaser_usb: Simplify struct
 kvaser_msg_cardinfo
References: <20180216091337.13924-1-jimmyassarsson@gmail.com>
In-Reply-To: <20180216091337.13924-1-jimmyassarsson@gmail.com>

--io8fpyiCb1Th6jjpzYN0bib9CpghwUMiL
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/16/2018 10:13 AM, Jimmy Assarsson wrote:
> serial_number_high can be removed from the struct since it is never use=
d in
> the USBcan II firmware.
>=20
> Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
> ---
> Changes in v2:
>   - Made this a separate patch.
>=20
>  drivers/net/can/usb/kvaser_usb.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kva=
ser_usb.c
> index 63587b8e6825..ee10beaa5da3 100644
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
> +	u32 ean[2];

Nitpick: This doesn't belong into this patch. Please use __le32 instead
of u32.

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

Otherwise good.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--io8fpyiCb1Th6jjpzYN0bib9CpghwUMiL--

--fA3RxQJnm25Ilwbf4eYHYb0NGZjGu0hCH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqGsXkACgkQk9IU1zQo
ZfHhTgf9Ga5/mk/xpYbIp9scPRzQlkwbk3Wdrk/1eLzDx8Fa94Cs5QL4RxX/E1tj
iZLFnHUQY2wOzeCHkqjwkWSGnb4ZksnMdrc2rbl0BtQgNBBT4QM/N9+miOv9VNm1
ucg/i+6esZWvuxtsQbar7W72PTCZ8CshBimQYfCDfapHi/pr0LoKusa1C/vLwLDE
A/MI1V7TTpaAZhIOeLXZH3bmg1dSi2qf/rLs4B7oLpAGBkld88zX3Xn6FXHImEh4
MaY62ob/L+BgSkgdQ4xBlOgIM0ZDO4DI0SjdA930vkIeL3PzlfrCpFIJXNY89TW1
9waBwiEBuCUAiDagtvPKiqSPbsgJ0A==
=Oovv
-----END PGP SIGNATURE-----

--fA3RxQJnm25Ilwbf4eYHYb0NGZjGu0hCH--
