From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: [PATCH 2/8] can: ti_hecc: add MODULE_ALIAS
Date: Thu, 22 Nov 2012 15:03:24 +0100
Message-ID: <1353593004.3811.36.camel@coredoba.hi.pengutronix.de>
References: <1353586790-30791-1-git-send-email-mkl@pengutronix.de>
	 <1353586790-30791-3-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38525 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab2KVS3r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 13:29:47 -0500
In-Reply-To: <1353586790-30791-3-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Thu, 2012-11-22 at 13:19 +0100, Marc Kleine-Budde wrote:
> This patch adds a MODULE_ALIAS for the platform bindings, so that
> the module can be loaded automatically udev.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Tested-by: Jan L=C3=BCbbe <jlu@pengutronix.de>

> ---
>  drivers/net/can/ti_hecc.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
> index 9ded21e..1267b36 100644
> --- a/drivers/net/can/ti_hecc.c
> +++ b/drivers/net/can/ti_hecc.c
> @@ -1055,3 +1055,4 @@ module_platform_driver(ti_hecc_driver);
>  MODULE_AUTHOR("Anant Gole <anantgole@ti.com>");
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION(DRV_DESC);
> +MODULE_ALIAS("platform:" DRV_NAME);
--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

