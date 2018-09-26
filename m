From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [PATCH resend] can: rcar_can: convert to SPDX identifiers
Date: Wed, 26 Sep 2018 09:34:01 +0000
Message-ID: <TY2PR01MB19628FAC2F3E5D7D8D6F5C86C3150@TY2PR01MB1962.jpnprd01.prod.outlook.com>
References: <874ledyrc6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <874ledyrc6.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-Net <netdev@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

> Subject: [PATCH resend] can: rcar_can: convert to SPDX identifiers
>=20
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Thanks,
Ramesh

> ---
> Wolfgang, Marc
>=20
> 2 weeks past, resend patch
>=20
>  drivers/net/can/rcar/Kconfig      | 1 +
>  drivers/net/can/rcar/Makefile     | 1 +
>  drivers/net/can/rcar/rcar_can.c   | 6 +-----
>  drivers/net/can/rcar/rcar_canfd.c | 6 +-----
>  4 files changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/can/rcar/Kconfig b/drivers/net/can/rcar/Kconfig
> index 7b03a3a..bd5a8fc 100644
> --- a/drivers/net/can/rcar/Kconfig
> +++ b/drivers/net/can/rcar/Kconfig
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>  config CAN_RCAR
>  	tristate "Renesas R-Car CAN controller"
>  	depends on ARCH_RENESAS || ARM
> diff --git a/drivers/net/can/rcar/Makefile b/drivers/net/can/rcar/Makefil=
e
> index 08de36a..c9185b0 100644
> --- a/drivers/net/can/rcar/Makefile
> +++ b/drivers/net/can/rcar/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>  #
>  #  Makefile for the Renesas R-Car CAN & CAN FD controller drivers
>  #
> diff --git a/drivers/net/can/rcar/rcar_can.c
> b/drivers/net/can/rcar/rcar_can.c
> index 11662f4..06f90a0 100644
> --- a/drivers/net/can/rcar/rcar_can.c
> +++ b/drivers/net/can/rcar/rcar_can.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /* Renesas R-Car CAN device driver
>   *
>   * Copyright (C) 2013 Cogent Embedded, Inc. <source@cogentembedded.com>
>   * Copyright (C) 2013 Renesas Solutions Corp.
> - *
> - * This program is free software; you can redistribute  it and/or modify
> it
> - * under  the terms of  the GNU General  Public License as published by
> the
> - * Free Software Foundation;  either version 2 of the  License, or (at
> your
> - * option) any later version.
>   */
>=20
>  #include <linux/module.h>
> diff --git a/drivers/net/can/rcar/rcar_canfd.c
> b/drivers/net/can/rcar/rcar_canfd.c
> index 602c19e..0541000 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -1,11 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /* Renesas R-Car CAN FD device driver
>   *
>   * Copyright (C) 2015 Renesas Electronics Corp.
> - *
> - * This program is free software; you can redistribute  it and/or modify
> it
> - * under  the terms of  the GNU General  Public License as published by
> the
> - * Free Software Foundation;  either version 2 of the  License, or (at
> your
> - * option) any later version.
>   */
>=20
>  /* The R-Car CAN FD controller can operate in either one of the below tw=
o
> modes
> --
> 2.7.4
