From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 4/5] can: bcm: add support for CAN FD frames
Date: Fri, 17 Jun 2016 12:23:50 +0200
Message-ID: <d37c690e-d872-cf25-b22c-7a6def80069f@pengutronix.de>
References: <1465068411-24301-1-git-send-email-socketcan@hartkopp.net>
 <1465068411-24301-5-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7MVhdcugvWFWAqvSmQg6U2ibXEspnhgE6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34996 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754177AbcFQKX6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 06:23:58 -0400
In-Reply-To: <1465068411-24301-5-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7MVhdcugvWFWAqvSmQg6U2ibXEspnhgE6
Content-Type: multipart/mixed; boundary="7DtQNVJA6ILBaSBcEKan2xomMPI9ATLqG"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <d37c690e-d872-cf25-b22c-7a6def80069f@pengutronix.de>
Subject: Re: [PATCH v4 4/5] can: bcm: add support for CAN FD frames
References: <1465068411-24301-1-git-send-email-socketcan@hartkopp.net>
 <1465068411-24301-5-git-send-email-socketcan@hartkopp.net>
In-Reply-To: <1465068411-24301-5-git-send-email-socketcan@hartkopp.net>

--7DtQNVJA6ILBaSBcEKan2xomMPI9ATLqG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/04/2016 09:26 PM, Oliver Hartkopp wrote:
> The programming API of the CAN_BCM depends on struct can_frame which is=

> given as array directly behind the bcm_msg_head structure. To follow th=
is
> schema for the CAN FD frames a new flag 'CAN_FD_FRAME' in the bcm_msg_h=
ead
> flags indicates that the concatenated CAN frame structures behind the
> bcm_msg_head are defined as struct canfd_frame.
>=20
> This patch adds the support to handle CAN and CAN FD frames on a per BC=
M-op
> base. Main changes:
>=20
> - generally use struct canfd_frames instead if struct can_frames
> - use canfd_frame.flags instead of can_frame.can_dlc for private BCM fl=
ags
> - make all CAN frame sizes depending on the new CAN_FD_FRAME flags
> - separate between CAN and CAN FD when sending/receiving frames
>=20
> Due to the dependence of the CAN_FD_FRAME flag the former binary interf=
ace
> for classic CAN frames remains stable.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/uapi/linux/can/bcm.h |   1 +
>  net/can/bcm.c                | 223 ++++++++++++++++++++++++++---------=
--------
>  2 files changed, 134 insertions(+), 90 deletions(-)
>=20
> diff --git a/include/uapi/linux/can/bcm.h b/include/uapi/linux/can/bcm.=
h
> index 7a291dc..cefb304 100644
> --- a/include/uapi/linux/can/bcm.h
> +++ b/include/uapi/linux/can/bcm.h
> @@ -99,5 +99,6 @@ enum {
>  #define RX_ANNOUNCE_RESUME  0x0100
>  #define TX_RESET_MULTI_IDX  0x0200
>  #define RX_RTR_FRAME        0x0400
> +#define CAN_FD_FRAME        0x0800
> =20
>  #endif /* !_UAPI_CAN_BCM_H */
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index f3bf387..31571b6 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1,7 +1,7 @@
>  /*
>   * bcm.c - Broadcast Manager to filter/send (cyclic) CAN content
>   *
> - * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
> + * Copyright (c) 2002-2016 Volkswagen Group Electronic Research
>   * All rights reserved.
>   *
>   * Redistribution and use in source and binary forms, with or without
> @@ -67,27 +67,27 @@
>   */
>  #define MAX_NFRAMES 256
> =20
> -/* use of last_frames[index].can_dlc */
> +/* use of last_frames[index].flags */
>  #define RX_RECV    0x40 /* received data for this element */
>  #define RX_THR     0x80 /* element not been sent due to throttle featu=
re */
> -#define BCM_CAN_DLC_MASK 0x0F /* clean private flags in can_dlc by mas=
king */
> +#define BCM_CAN_FLAGS_MASK 0x3F /* to clean private flags after usage =
*/
> =20
>  /* get best masking value for can_rx_register() for a given single can=
_id */
>  #define REGMASK(id) ((id & CAN_EFF_FLAG) ? \
>  		     (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
>  		     (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
> =20
> -#define CAN_BCM_VERSION CAN_VERSION
> +#define CAN_BCM_VERSION "20160531"
> =20
>  MODULE_DESCRIPTION("PF_CAN broadcast manager protocol");
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Oliver Hartkopp <oliver.hartkopp@volkswagen.de>");
>  MODULE_ALIAS("can-proto-2");
> =20
> -/* easy access to CAN frame payload */
> -static inline u64 GET_U64(const struct can_frame *cp)
> +/* easy access to the first 64 bit of can(fd)_frame payload */
> +static inline u64 GET_U64(const struct canfd_frame *cp, int offset)
>  {
> -	return *(u64 *)cp->data;
> +	return *(u64 *)(cp->data + offset);

Can you ensure that offset is always a multiple of 8? Unaligned pointer
access will be quite slow on some platforms. Can you please make this
function lower-case (as it's a function not a macro).

>  }
> =20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7DtQNVJA6ILBaSBcEKan2xomMPI9ATLqG--

--7MVhdcugvWFWAqvSmQg6U2ibXEspnhgE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXY8+2AAoJED07qiWsqSVqqiAH/2nGC01ZkOWQfuQ/kPfq0k+0
hwuRk6Lsw6fw1A0LIAWOoK1UzGH/YWu58/ehIWHTTOX6jzSZyCTvkFa3IbSuQRXh
xSP7mNWECVN18qrsI2daJYOHp5WLJhbE6mIqm2f7ammQky+nWxXiMXiE/A68zqQk
15ob1iNOggnlsUD+fxaH/Ufs68/FMx8+KFiyhSD8N1Ik7oOIm6Vk38DQAaalS9At
5Epxf7B+tYuMQlnTB/HE3aJS9o19Crsqf7mpNkynlfD90r+8azyDi8sQTkRA4Odm
nXJyZ8vxUP8SIxhw9jRgkcH8rL/BH8pjUeu8eV/Uw5WaEfFrMvyVaqAkZwNWGXg=
=jpKp
-----END PGP SIGNATURE-----

--7MVhdcugvWFWAqvSmQg6U2ibXEspnhgE6--
