From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next] can: add missing initialization of CAN
 statistics
Date: Wed, 6 Jul 2016 09:24:39 +0200
Message-ID: <b3c32a37-d6bc-4d99-1a9b-4a0fb79460b2@pengutronix.de>
References: <1467789546-25178-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Jj7isFd2AoBuDdlFF5XvSlH8qcgvr1DGV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:32811 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750883AbcGFHYr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 6 Jul 2016 03:24:47 -0400
In-Reply-To: <1467789546-25178-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jj7isFd2AoBuDdlFF5XvSlH8qcgvr1DGV
Content-Type: multipart/mixed; boundary="5S98xiR6uTrmb6qgqneqvqjJre5XDSFd9"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <b3c32a37-d6bc-4d99-1a9b-4a0fb79460b2@pengutronix.de>
Subject: Re: [PATCH can-next] can: add missing initialization of CAN
 statistics
References: <1467789546-25178-1-git-send-email-socketcan@hartkopp.net>
In-Reply-To: <1467789546-25178-1-git-send-email-socketcan@hartkopp.net>

--5S98xiR6uTrmb6qgqneqvqjJre5XDSFd9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/06/2016 09:19 AM, Oliver Hartkopp wrote:
> The total rx/tx rate (TXR and RXR) only start working after a statistic=
 reset.
> This patch initializes the statistic data structures and the timer init=
 value
> to provide proper values directly from the start.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  net/can/af_can.c |  1 +
>  net/can/af_can.h |  1 +
>  net/can/proc.c   | 21 ++++++++++++++-------
>  3 files changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 1108079..cefe98c 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -912,6 +912,7 @@ static __init int can_init(void)
>  		return -ENOMEM;
> =20
>  	if (IS_ENABLED(CONFIG_PROC_FS)) {
> +		can_init_stats();
>  		if (stats_timer) {
>  		/* the statistics are updated every second (timer triggered) */
>  			setup_timer(&can_stattimer, can_stat_update, 0);
> diff --git a/net/can/af_can.h b/net/can/af_can.h
> index fca0fe9..8361047 100644
> --- a/net/can/af_can.h
> +++ b/net/can/af_can.h
> @@ -115,6 +115,7 @@ extern struct dev_rcv_lists can_rx_alldev_list;
>  /* function prototypes for the CAN networklayer procfs (proc.c) */
>  void can_init_proc(void);
>  void can_remove_proc(void);
> +void can_init_stats(void);
>  void can_stat_update(unsigned long data);
> =20
>  /* structures and variables from af_can.c needed in proc.c for reading=
 */
> diff --git a/net/can/proc.c b/net/can/proc.c
> index 85ef7bb..056e9f5 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -86,7 +86,7 @@ static const char rx_list_name[][8] =3D {
>   * af_can statistics stuff
>   */
> =20
> -static void can_init_stats(void)
> +static void can_reset_stats(void)
>  {
>  	/*
>  	 * This memset function is called from a timer context (when
> @@ -104,6 +104,13 @@ static void can_init_stats(void)
>  	}
>  }
> =20
> +void can_init_stats(void)
> +{
> +	memset(&can_pstats, 0, sizeof(can_pstats));
> +	memset(&can_stats, 0, sizeof(can_stats));

I think this is not needed, as both are global variables, right?

> +	can_stats.jiffies_init =3D jiffies;
> +}
> +

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5S98xiR6uTrmb6qgqneqvqjJre5XDSFd9--

--Jj7isFd2AoBuDdlFF5XvSlH8qcgvr1DGV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXfLI3AAoJED07qiWsqSVqmX4H/ihRjowJXLavawymLEuhp1uv
irjNaZ+CFv7XbCEezdXgF3+qgZLzoR2ThbrYpFfv2LlJG3KCHY6mUCnIZ+rG21gu
OCJgrFKf6wx7S4JqLIkdpFuKcDV3l37JomA6O4U4NnryrUUC8g53MbLy3HQnFbpQ
1e9f+LwU5slNhlOUJJzTbEVgg1P3RYBuuyRwj9xkY9GRSgFHUHnfQggRKxCBLTZ6
/rnkn4bv5lMfk2BF0/csypZiW+Ljb62Bo6F0wewvQ3zvsKhOuEW8LvHKittTJ9AJ
O+zfGe/7s0IB0KTsRyX+e187yI6H9p5W9vRIQNy02UrRDKAKeWgA9Bpc8f97xPg=
=bWJH
-----END PGP SIGNATURE-----

--Jj7isFd2AoBuDdlFF5XvSlH8qcgvr1DGV--
