From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v7 07/10] include: can.h: remove unused include of
 version.h
Date: Tue, 21 Jan 2014 14:22:05 +0100
Message-ID: <20140121132205.GC26766@pengutronix.de>
References: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
 <1390309204-19854-8-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43798 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265AbaAUNWG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 08:22:06 -0500
Content-Disposition: inline
In-Reply-To: <1390309204-19854-8-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Tue, Jan 21, 2014 at 02:00:01PM +0100, Marc Kleine-Budde wrote:
> This patch remove the include of version.h, as it's not used.
>=20
Maybe point out that this #include is also missing in the kernel and so
this drops another difference that need to be cared for when syncing th=
e
kernel headers into can-utils.

Uwe
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  include/linux/can.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/linux/can.h b/include/linux/can.h
> index 2f77ab3..5802cb3 100644
> --- a/include/linux/can.h
> +++ b/include/linux/can.h
> @@ -13,7 +13,6 @@
>  #ifndef CAN_H
>  #define CAN_H
> =20
> -#include <linux/version.h>
>  #include <linux/types.h>
>  #include <linux/socket.h>
> =20
> --=20
> 1.8.5.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
