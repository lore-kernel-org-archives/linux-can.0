From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: bcm: check timer values before ktime conversion
Date: Tue, 22 Jan 2019 11:26:55 +0100
Message-ID: <1b29b1df-82c5-6c5a-a558-b73a0a1166b4@pengutronix.de>
References: <20190113183143.10612-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rvgqE9VqRFhzNL7PG4i8iyOLkZR0Y5bYs"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190113183143.10612-1-socketcan@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, davem@davemloft.net, netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, lifeasageek@gmail.com, threeearcat@gmail.com, syzkaller@googlegroups.com, nautsch2@gmail.com, Kyungtae Kim <kt0755@gmail.com>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rvgqE9VqRFhzNL7PG4i8iyOLkZR0Y5bYs
Content-Type: multipart/mixed; boundary="7qAQq7gyWHSmv7jcStgnG3EEbMF61COxX";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, davem@davemloft.net,
 netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, lifeasageek@gmail.com, threeearcat@gmail.com,
 syzkaller@googlegroups.com, nautsch2@gmail.com,
 Kyungtae Kim <kt0755@gmail.com>, linux-stable <stable@vger.kernel.org>
Message-ID: <1b29b1df-82c5-6c5a-a558-b73a0a1166b4@pengutronix.de>
Subject: Re: [PATCH v2] can: bcm: check timer values before ktime conversion
References: <20190113183143.10612-1-socketcan@hartkopp.net>
In-Reply-To: <20190113183143.10612-1-socketcan@hartkopp.net>

--7qAQq7gyWHSmv7jcStgnG3EEbMF61COxX
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/13/19 7:31 PM, Oliver Hartkopp wrote:
> Kyungtae Kim detected a potential integer overflow in bcm_[rx|tx]_setup=
()
> when the conversion into ktime multiplies the given value with NSEC_PER=
_USEC
> (1000).
>=20
> Reference: https://marc.info/?l=3Dlinux-can&m=3D154732118819828&w=3D2
>=20
> Add a check for the given tv_usec, so that the value stays below one se=
cond.
> Additionally limit the tv_sec value to a reasonable value for CAN relat=
ed
> use-cases of 400 days and ensure all values to be positive.
>=20
> Reported-by: Kyungtae Kim <kt0755@gmail.com>
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: linux-stable <stable@vger.kernel.org> # >=3D 2.6.26
> ---
>  net/can/bcm.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 0af8f0db892a..d4ae0a1471f3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -67,6 +67,9 @@
>   */
>  #define MAX_NFRAMES 256
> =20
> +/* limit timers to 400 days for sending/timeouts */
> +#define BCM_TIMER_SEC_MAX (400*24*60*60)

I've added spaces around the * while applying the patch.

> +
>  /* use of last_frames[index].flags */
>  #define RX_RECV    0x40 /* received data for this element */
>  #define RX_THR     0x80 /* element not been sent due to throttle featu=
re */
> @@ -140,6 +143,22 @@ static inline ktime_t bcm_timeval_to_ktime(struct =
bcm_timeval tv)
>  	return ktime_set(tv.tv_sec, tv.tv_usec * NSEC_PER_USEC);
>  }
> =20
> +/* check limitations for timeval provided by user */
> +static int bcm_is_invalid_tv(struct bcm_msg_head *msg_head)

I've converted this into a bool function.

> +{
> +	if ((msg_head->ival1.tv_sec < 0) ||
> +	    (msg_head->ival1.tv_sec > BCM_TIMER_SEC_MAX) ||
> +	    (msg_head->ival1.tv_usec < 0) ||
> +	    (msg_head->ival1.tv_usec >=3D USEC_PER_SEC) ||
> +	    (msg_head->ival2.tv_sec < 0) ||
> +	    (msg_head->ival2.tv_sec > BCM_TIMER_SEC_MAX) ||
> +	    (msg_head->ival2.tv_usec < 0) ||
> +	    (msg_head->ival2.tv_usec >=3D USEC_PER_SEC))
> +		return 1;

return true;
> +
> +	return 0;

return false;

> +}
> +
>  #define CFSIZ(flags) ((flags & CAN_FD_FRAME) ? CANFD_MTU : CAN_MTU)
>  #define OPSIZ sizeof(struct bcm_op)
>  #define MHSIZ sizeof(struct bcm_msg_head)
> @@ -873,6 +892,10 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
>  	if (msg_head->nframes < 1 || msg_head->nframes > MAX_NFRAMES)
>  		return -EINVAL;
> =20
> +	/* check timeval limitations */
> +	if ((msg_head->flags & SETTIMER) && bcm_is_invalid_tv(msg_head))
> +		return -EINVAL;
> +
>  	/* check the given can_id */
>  	op =3D bcm_find_op(&bo->tx_ops, msg_head, ifindex);
>  	if (op) {
> @@ -1053,6 +1076,10 @@ static int bcm_rx_setup(struct bcm_msg_head *msg=
_head, struct msghdr *msg,
>  	     (!(msg_head->can_id & CAN_RTR_FLAG))))
>  		return -EINVAL;
> =20
> +	/* check timeval limitations */
> +	if ((msg_head->flags & SETTIMER) && bcm_is_invalid_tv(msg_head))
> +		return -EINVAL;
> +
>  	/* check the given can_id */
>  	op =3D bcm_find_op(&bo->rx_ops, msg_head, ifindex);
>  	if (op) {
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7qAQq7gyWHSmv7jcStgnG3EEbMF61COxX--

--rvgqE9VqRFhzNL7PG4i8iyOLkZR0Y5bYs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlxG7+8ACgkQk9IU1zQo
ZfHZxQf/U9VJx5/wD7gdU+gyT78e5HafJhHB8lX/VS/uAOTuujzyEeNRoyi6DYKJ
TypcX+VCuCwZaNpGeaxuOmHl7ek9D5W5UtPM0Ujg4IuJIBBeNZqy2k5vSOFetrty
i6WIP5QW/Ymihf9lp1lkMfI64ffBAithd4uF934OKSV5fI08WPWsPhXzcOypwxRM
Q8Z1n+z1DwVqAH2qoTJ5lmY3riZ1aJlaiVlwR1Xh1he9u61qBOqLOAnG5DHiu/+n
cL2a47rYrqTURZYg9G/u/9IaA6GI5/vMo7xAYKroZ8hpVtKxlBAQDgtPM96uC/gK
2zvsA2veVwkRPPSXMEwqbybsLIMPZg==
=hVD1
-----END PGP SIGNATURE-----

--rvgqE9VqRFhzNL7PG4i8iyOLkZR0Y5bYs--
