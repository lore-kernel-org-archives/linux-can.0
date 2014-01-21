From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v7 08/10] include: can.h: update comment about
 introduction of __kernel_sa_family_t
Date: Tue, 21 Jan 2014 14:20:55 +0100
Message-ID: <20140121132055.GB26766@pengutronix.de>
References: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
 <1390309204-19854-9-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43782 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbaAUNU4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 08:20:56 -0500
Content-Disposition: inline
In-Reply-To: <1390309204-19854-9-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hello Marc,

On Tue, Jan 21, 2014 at 02:00:02PM +0100, Marc Kleine-Budde wrote:
> This patch updates the comment about the introduction of __kernel_sa_=
family_t,
> while there get rid of C++ commenting style.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  include/linux/can.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/can.h b/include/linux/can.h
> index 5802cb3..e7b1029 100644
> --- a/include/linux/can.h
> +++ b/include/linux/can.h
> @@ -122,8 +122,10 @@ struct canfd_frame {
> =20
>  #define SOL_CAN_BASE 100
> =20
> -// typedef unsigned short __kernel_sa_family_t;
> -// introduced in Linux 3.2 commit 6602a4baf4d1a73cc4685a39ef859e1c5d=
df654c
> +/*
> + * typedef unsigned short __kernel_sa_family_t;
> + * introduced in Linux 3.1 commit 6602a4baf4d1a73cc4685a39ef859e1c5d=
df654c
> + */
I'd make this:

-// typedef unsigned short __kernel_sa_family_t;
-// introduced in Linux 3.2 commit 6602a4baf4d1a73cc4685a39ef859e1c5ddf=
654c
+/*
+ * This typedef was introduced in Linux v3.1-rc2
+ * (commit 6602a4baf4d1a73cc4685a39ef859e1c5ddf654c) in <linux/socket.=
h>.
+ * It must be duplicated here to make the can headers self-contained.
+ */
+ typedef unsigned short __kernel_sa_family_t;

and then drop the following hunk. That should work as intended also on
systems that have kernel headers newer than v3.1-rc2 because a
duplicated typedef shouldn't hurt. (Note I didn't test that or tried to
find a proof in my C book.)

Best regards
Uwe

>  /**
>   * struct sockaddr_can - the sockaddr structure for CAN sockets
> @@ -133,7 +135,7 @@ struct canfd_frame {
>   */
>  struct sockaddr_can {
>  	sa_family_t can_family;
> -//	__kernel_sa_family_t can_family;
> +	/* __kernel_sa_family_t can_family; */
>  	int         can_ifindex;
>  	union {
>  		/* transport protocol class address information (e.g. ISOTP) */
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
