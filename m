From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v7 09/10] include: gw.h: update comment
Date: Tue, 21 Jan 2014 14:24:19 +0100
Message-ID: <20140121132419.GD26766@pengutronix.de>
References: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
 <1390309204-19854-10-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36412 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbaAUNYU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 08:24:20 -0500
Content-Disposition: inline
In-Reply-To: <1390309204-19854-10-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Tue, Jan 21, 2014 at 02:00:03PM +0100, Marc Kleine-Budde wrote:
> This comment was added to the kernel in patch:
>=20
>     391ac12 can: gw: add a per rule limitation of frame hops
The corresponding can-utils commit is:

	ad7f44095ac3 (cangw: add an option for the per rule limitation of fram=
e hops)

which somehow introduced the difference even though it referenced commi=
t
391ac12.

Best regards
Uwe

> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  include/linux/can/gw.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/can/gw.h b/include/linux/can/gw.h
> index a9d4363..4e27c82 100644
> --- a/include/linux/can/gw.h
> +++ b/include/linux/can/gw.h
> @@ -128,7 +128,7 @@ enum {
>   * Limit the number of hops of this specific rule. Usually the recei=
ved CAN
>   * frame can be processed as much as 'max_hops' times (which is give=
n at module
>   * load time of the can-gw module). This value is used to reduce the=
 number of
> - * possible hops for this gateway job to a value smaller then max_ho=
ps.
> + * possible hops for this gateway rule to a value smaller then max_h=
ops.
>   *
>   * CGW_CS_XOR (length 4 bytes):
>   * Set a simple XOR checksum starting with an initial value into
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
