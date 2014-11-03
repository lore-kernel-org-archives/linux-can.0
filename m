From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 11/15] can: rx-fifo: Add support for can state tracking
 and error polling
Date: Mon, 03 Nov 2014 12:24:08 +0100
Message-ID: <545765D8.7090906@pengutronix.de>
References: <1412956020-21489-1-git-send-email-david@protonic.nl> <1412956020-21489-12-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="52N4FxTcloRdMIGROmUSlpvjKcuHKD1SR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37825 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaKCLYP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 06:24:15 -0500
In-Reply-To: <1412956020-21489-12-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--52N4FxTcloRdMIGROmUSlpvjKcuHKD1SR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2014 05:46 PM, David Jander wrote:
> The interrupt handler should store the error flags if needed and call
> can_rx_fifo_irq_error() if there was an error flag set. This will trigg=
er
> a napi-poll that will call poll_can_state() and poll_bus_error()
> callbacks. Those should handle can state machine and send error frames
> as needed.
>=20
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/net/can/dev.c   | 23 ++++++++++++++++++++---
>  include/linux/can/dev.h |  9 +++++++++
>  2 files changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index fc35d28..dac7579 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -352,6 +352,9 @@ static int can_rx_fifo_napi_poll(struct napi_struct=
 *napi, int quota)
>  	unsigned int tail;
> =20
>  restart_poll:
> +	if (work_done < quota)
> +		work_done +=3D fifo->poll_can_state(fifo);
> +

Do we need two callbacks in the poll-loop? I think one should be enough.
The driver can call as many non-rx related functions as needed then.
E.g. state change, bus error handling, tx-completion handling, etc...

What about adding a guard:

	if (fifo->poll && work_done < quota)
		work_done +=3D fifo->poll(fifo);

=2E..so that the poll callback can be NULL.

>  	/* handle mailboxes */
>  	head =3D smp_load_acquire(&fifo->ring_head);
>  	tail =3D fifo->ring_tail;
> @@ -363,14 +366,19 @@ restart_poll:
>  		smp_store_release(&fifo->ring_tail, tail);
>  	}
> =20
> +	if (work_done < quota)
> +		work_done +=3D fifo->poll_bus_error(fifo);
> +
>  	if (work_done < quota) {
>  		napi_complete(napi);
> =20
>  		/* Check if there was another interrupt */
>  		head =3D smp_load_acquire(&fifo->ring_head);
> -		if ((CIRC_CNT(head, tail, fifo->ring_size) >=3D 1) &&
> -		    napi_reschedule(&fifo->napi))
> +		if (((CIRC_CNT(head, tail, fifo->ring_size) >=3D 1) ||
> +		    fifo->poll_errors) && napi_reschedule(&fifo->napi)) {
> +			fifo->poll_errors =3D false;
>  			goto restart_poll;
> +		}
>  	}
> =20
>  	return work_done;
> @@ -393,7 +401,8 @@ int can_rx_fifo_add(struct net_device *dev, struct =
can_rx_fifo *fifo)
>  		return -EINVAL;
> =20
>  	if (!fifo->mailbox_enable_mask || !fifo->mailbox_move_to_buffer ||
> -	    !fifo->mailbox_enable)
> +	    !fifo->mailbox_enable || !fifo->poll_bus_error ||
> +	    !fifo->poll_can_state)
>  		return -EINVAL;
> =20
>  	/* Make ring-buffer a sensible size that is a power of 2 */
> @@ -412,6 +421,7 @@ int can_rx_fifo_add(struct net_device *dev, struct =
can_rx_fifo *fifo)
>  	fifo->mask_low =3D can_rx_fifo_mask_low(fifo);
>  	fifo->mask_high =3D can_rx_fifo_mask_high(fifo);
>  	fifo->second_first =3D false;
> +	fifo->poll_errors =3D false;
>  	fifo->active =3D fifo->mask_low | fifo->mask_high;
>  	fifo->mailbox_enable_mask(fifo, fifo->active);
> =20
> @@ -503,6 +513,13 @@ int can_rx_fifo_irq_offload(struct can_rx_fifo *fi=
fo)
>  }
>  EXPORT_SYMBOL_GPL(can_rx_fifo_irq_offload);
> =20
> +void can_rx_fifo_irq_error(struct can_rx_fifo *fifo)
> +{
> +	fifo->poll_errors =3D true;
> +	can_rx_fifo_napi_schedule(fifo);
> +}
> +EXPORT_SYMBOL_GPL(can_rx_fifo_irq_error);
> +
>  void can_rx_fifo_napi_enable(struct can_rx_fifo *fifo)
>  {
>  	napi_enable(&fifo->napi);
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index c49c37b..e1ed6d4 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -75,12 +75,15 @@ struct can_rx_fifo {
>  	void (*mailbox_enable)(struct can_rx_fifo *rx_fifo, unsigned int mb);=

>  	unsigned int (*mailbox_move_to_buffer)(struct can_rx_fifo *rx_fifo,
>  		struct can_frame *frame, unsigned int mb);
> +	unsigned int (*poll_can_state)(struct can_rx_fifo *rx_fifo);
> +	unsigned int (*poll_bus_error)(struct can_rx_fifo *rx_fifo);
> =20
>  	u64 mask_low;
>  	u64 mask_high;
>  	u64 active;
> =20
>  	unsigned int second_first;
> +	bool poll_errors;
> =20
>  	bool inc;
> =20
> @@ -92,6 +95,11 @@ struct can_rx_fifo {
>  	struct napi_struct napi;
>  };
> =20
> +static inline void can_rx_fifo_napi_schedule(struct can_rx_fifo *fifo)=

> +{
> +	napi_schedule(&fifo->napi);
> +}
> +
>  /*
>   * get_can_dlc(value) - helper macro to cast a given data length code =
(dlc)
>   * to __u8 and ensure the dlc value to be max. 8 bytes.
> @@ -135,6 +143,7 @@ u8 can_len2dlc(u8 len);
> =20
>  int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo);=

>  int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo);
> +void can_rx_fifo_irq_error(struct can_rx_fifo *fifo);
>  void can_rx_fifo_napi_enable(struct can_rx_fifo *fifo);
>  void can_rx_fifo_napi_disable(struct can_rx_fifo *fifo);
>  void can_rx_fifo_reset(struct can_rx_fifo *fifo);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--52N4FxTcloRdMIGROmUSlpvjKcuHKD1SR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUV2XYAAoJECte4hHFiupUq5wP/0aniHaWezuietVpQv+mZDpV
Zo1M9dq3J2uybz1C1KJdBcueOqqDW8Kas8DtThiUQyXo5viPWGKHjhYVQLiOYbQq
eSBvVm0SZ3sZ+tPbWm2eRmAAfPGB46sdMb1P26854QuqiZW6737RmZAVXSGkM9Nh
4yb221Ayw8iQYfpDsnk8V14H3BDqVxnsc0cyCKyK6vBi1YWpmJc+bzMxzhlaMGhY
YGNdpIPB0iZCLFFYaMpQq3OodzGwdp1tu+6GAoi0XofVDqSvRc44d5zTGaRR9+uV
AjgWCDizBjrje6JNtGbE5M1xtJ5z+JS3ThHidgZBW2t7guLsCQcZNtJLUSOcjeoA
ZGk2zjMh637Yk6L6BOQAB4mF8yTNkxA7bOwibJ4XNx8NCUmNDDCflNQ8pivDDUvK
RAnDGjNpm3DcGkm1FX8cnCwhPP6FSiEDU9Kn2IZdHNq4oBeTdimE3ZWRt9TSWHHj
WKEgfo203QdDrD9kmFoufB1GH6UZ2L5ohqE17JNVTa6dirTe946JJJDrHK8JcvzP
nHA0534bOcE9cPU5BDtfXgWPk7JpzFc9+nY1ZM7FJAoQFBc8sZClOQ50cnZXAYVo
3hC2U1ezX+dFvnV1KwgjN0082B3IVY2Ivk0ZWZAbkmZvJdOHr3rB3aEgpXWpzzge
HrpTwxjcYTEWyyZS5k+e
=g8FA
-----END PGP SIGNATURE-----

--52N4FxTcloRdMIGROmUSlpvjKcuHKD1SR--
