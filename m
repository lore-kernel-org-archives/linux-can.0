From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/6] canfd: add new data structures and constants
Date: Mon, 18 Jun 2012 21:13:37 +0200
Message-ID: <4FDF7DE1.6000803@pengutronix.de>
References: <4FDF67C3.6020201@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7A9C95D838D920979C7EAEC1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58870 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab2FRTNj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 15:13:39 -0400
In-Reply-To: <4FDF67C3.6020201@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7A9C95D838D920979C7EAEC1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/18/2012 07:39 PM, Oliver Hartkopp wrote:
> - add new struct canfd_frame
> - check identical element offsets in struct can_frame and struct canfd_=
frame
> - new ETH_P_CANFD definition to tag CAN FD skbs correctly
> - add CAN_MTU and CANFD_MTU definitions for easy frame and mode detecti=
on
> - add CAN[FD]_MAX_[DLC|DLEN] helper constants to remove hard coded valu=
es
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/linux/can.h      |   55 ++++++++++++++++++++++++++++++++++++++=
++++----
>  include/linux/if_ether.h |    3 ++-
>  net/can/af_can.c         |    7 ++++++
>  3 files changed, 60 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/linux/can.h b/include/linux/can.h
> index 17334c0..25265e7 100644
> --- a/include/linux/can.h
> +++ b/include/linux/can.h
> @@ -46,18 +46,65 @@ typedef __u32 canid_t;
>   */
>  typedef __u32 can_err_mask_t;
>  +#define CAN_MAX_DLC 8
> +#define CAN_MAX_DLEN 8
> +
> +#define CANFD_MAX_DLC 15
> +#define CANFD_MAX_DLEN 64
> +
>  /**
>   * struct can_frame - basic CAN frame structure
> - * @can_id:  the CAN ID of the frame and CAN_*_FLAG flags, see above.
> - * @can_dlc: the data length field of the CAN frame
> - * @data:    the CAN frame payload.
> + * @can_id:  CAN ID of the frame and CAN_*_FLAG flags, see canid_t def=
inition
> + * @can_dlc: frame payload length in byte (0 .. 8) aka data length cod=
e
> + *           N.B. the DLC field from ISO 11898-1 Chapter 8.4.2.3 has a=
 1:1
> + *           mapping of the 'data length code' to the real payload len=
gth
> + * @data:    CAN frame payload (up to 8 byte)
>   */
>  struct can_frame {
>  	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
> -	__u8    can_dlc; /* data length code: 0 .. 8 */
> +	__u8    can_dlc; /* frame payload length in byte (0 .. 8) */
>  	__u8    data[8] __attribute__((aligned(8)));

checkpatch complains:

WARNING: __aligned(size) is preferred over __attribute__((aligned(size)))=

#84: FILE: include/linux/can.h:102:
+       __u8    data[64] __attribute__((aligned(8)));

total: 0 errors, 1 warnings, 97 lines checked

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig7A9C95D838D920979C7EAEC1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/ffeEACgkQjTAFq1RaXHPbdwCcDTmiCF7tT+Ol6Yqaqqz6Fwki
qZoAn0s+4dorlFkmlPXE3tCGXc1188KD
=5BGv
-----END PGP SIGNATURE-----

--------------enig7A9C95D838D920979C7EAEC1--
