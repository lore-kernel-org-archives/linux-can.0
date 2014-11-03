From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 13/15] can: rx-fifo: Add support for simple irq offloading
Date: Mon, 03 Nov 2014 12:59:32 +0100
Message-ID: <54576E24.5000307@pengutronix.de>
References: <1412956020-21489-1-git-send-email-david@protonic.nl> <1412956020-21489-14-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="G4gKRVV51F4WsMqJksMFukJI15lSK5oQq"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33517 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbaKCL7k (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 06:59:40 -0500
In-Reply-To: <1412956020-21489-14-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G4gKRVV51F4WsMqJksMFukJI15lSK5oQq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2014 05:46 PM, David Jander wrote:
> Some CAN controllers have a usable FIFO already but can still benefit f=
rom
> off-loading the CAN controller FIFO in the interrupt into an extra ring=
-
> buffer. Add support for these simpler cases also.
>=20
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/net/can/dev.c   | 76 ++++++++++++++++++++++++++++++++++++++++-=
--------
>  include/linux/can/dev.h |  2 ++
>  2 files changed, 65 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index dac7579..278aea3 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -384,10 +384,32 @@ restart_poll:
>  	return work_done;
>  }
> =20
> +static int can_rx_fifo_init_ring(struct net_device *dev,
> +		struct can_rx_fifo *fifo, unsigned int weight)
> +{
> +	fifo->dev =3D dev;
> +
> +	/* Make ring-buffer a sensible size that is a power of 2 */
> +	fifo->ring_size =3D (2 << fls(weight));
> +	fifo->ring =3D kzalloc(sizeof(struct can_frame) * fifo->ring_size,
> +			     GFP_KERNEL);
> +	if (!fifo->ring)
> +		return -ENOMEM;
> +
> +	fifo->ring_head =3D fifo->ring_tail =3D 0;
> +
> +	/* Take care of NAPI handling */
> +	netif_napi_add(dev, &fifo->napi, can_rx_fifo_napi_poll, weight);
> +
> +	fifo->poll_errors =3D false;
> +
> +	return 0;
> +}
> +
>  int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
>  {
>  	unsigned int weight;
> -	fifo->dev =3D dev;
> +	int ret;
> =20
>  	if ((fifo->low_first < fifo->high_first) &&
>  	    (fifo->high_first < fifo->high_last)) {
> @@ -405,23 +427,14 @@ int can_rx_fifo_add(struct net_device *dev, struc=
t can_rx_fifo *fifo)
>  	    !fifo->poll_can_state)
>  		return -EINVAL;
> =20
> -	/* Make ring-buffer a sensible size that is a power of 2 */
> -	fifo->ring_size =3D (2 << fls(weight));
> -	fifo->ring =3D kzalloc(sizeof(struct can_frame) * fifo->ring_size,
> -			     GFP_KERNEL);
> -	if (!fifo->ring)
> -		return -ENOMEM;
> -
> -	fifo->ring_head =3D fifo->ring_tail =3D 0;
> -
> -	/* Take care of NAPI handling */
> -	netif_napi_add(dev, &fifo->napi, can_rx_fifo_napi_poll, weight);
> +	ret =3D can_rx_fifo_init_ring(dev, fifo, weight);
> +	if (ret)
> +		return ret;
> =20
>  	/* init variables */
>  	fifo->mask_low =3D can_rx_fifo_mask_low(fifo);
>  	fifo->mask_high =3D can_rx_fifo_mask_high(fifo);
>  	fifo->second_first =3D false;
> -	fifo->poll_errors =3D false;
>  	fifo->active =3D fifo->mask_low | fifo->mask_high;
>  	fifo->mailbox_enable_mask(fifo, fifo->active);
> =20
> @@ -434,6 +447,26 @@ int can_rx_fifo_add(struct net_device *dev, struct=
 can_rx_fifo *fifo)
>  }
>  EXPORT_SYMBOL_GPL(can_rx_fifo_add);
> =20
> +int can_rx_fifo_add_simple(struct net_device *dev, struct can_rx_fifo =
*fifo)
> +{
> +	int ret;
> +
> +	if (!fifo->mailbox_move_to_buffer || !fifo->poll_bus_error ||
> +	    !fifo->poll_can_state)
> +		return -EINVAL;
> +
> +	ret =3D can_rx_fifo_init_ring(dev, fifo, 64);
> +	if (ret)
> +		return ret;
> +
> +	/* init variables */
> +	fifo->mask_low =3D 0;
> +	fifo->mask_high =3D 0;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(can_rx_fifo_add_simple);

I'd rather see, that we use the same rx_fifo_add() function to create
all rx-fifo available. Can we add a flag to struct can_rx_fifo?

> +
>  static unsigned int can_rx_fifo_offload_if_full(struct can_rx_fifo *fi=
fo, unsigned int n)
>  {
>  	unsigned int head =3D fifo->ring_head;
> @@ -513,6 +546,23 @@ int can_rx_fifo_irq_offload(struct can_rx_fifo *fi=
fo)
>  }
>  EXPORT_SYMBOL_GPL(can_rx_fifo_irq_offload);
> =20
> +int can_rx_fifo_irq_offload_simple(struct can_rx_fifo *fifo)
> +{
> +	unsigned int received =3D 0;
> +	unsigned int ret;
> +
> +	do {
> +		ret =3D can_rx_fifo_offload_if_full(fifo, 0);
> +		received +=3D ret;
> +	} while (ret);
> +
> +	if (received)
> +		can_rx_fifo_napi_schedule(fifo);
> +
> +	return received;
> +}
> +EXPORT_SYMBOL_GPL(can_rx_fifo_irq_offload_simple);

I think it's better to have only one offload function, that should do
the right thing depending on the struct can_rx_fifo.

> +
>  void can_rx_fifo_irq_error(struct can_rx_fifo *fifo)
>  {
>  	fifo->poll_errors =3D true;
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index e1ed6d4..18feef3 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -142,7 +142,9 @@ u8 can_dlc2len(u8 can_dlc);
>  u8 can_len2dlc(u8 len);
> =20
>  int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo);=

> +int can_rx_fifo_add_simple(struct net_device *dev, struct can_rx_fifo =
*fifo);
>  int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo);
> +int can_rx_fifo_irq_offload_simple(struct can_rx_fifo *fifo);
>  void can_rx_fifo_irq_error(struct can_rx_fifo *fifo);
>  void can_rx_fifo_napi_enable(struct can_rx_fifo *fifo);
>  void can_rx_fifo_napi_disable(struct can_rx_fifo *fifo);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--G4gKRVV51F4WsMqJksMFukJI15lSK5oQq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUV24lAAoJECte4hHFiupUzMEP/1hOp4f210pjiyudtCVrYw5h
fqhAlB0AXj7VNvMeGT5e/ROUtsyF2VS6XF6ucIdlQqcBZBKSnDFOe3exxor7jH69
rz1ZjJquktCMXFa07nCFORRLV+VulKCJyNpC8BR6lyKyTDFb9Nf9XJC36/sGsV9S
X7zCCcXTUgqyEmJpNxOf7tMQLDIxHNHn30gwbLjiyJC3HeOZZSz/fzpjQrf8F8M0
1PJQcSYDbN2sTD7mJUPOco7voSk9PeokUNrnv4we6OKqXkPTtKtb0KtupK9LJJdj
69y2yaqfkNCFNx2yn5+vE34s7MW/9IWNKPTiJfyC2l9NqrNUk5+F4OPEb05xbAbW
bCzrhvku3VS4fqt9dMaHS/6ao1+wJGzUZ8kGn4rLQ/85qTadbps6XQGhDJifHFye
NhzlbNhlZNT185DBPSop1O2/fb2bbfevPOLjsZzDskrSBGgFte1bE0t5omLHSmSt
lX+19/G2XVSUs9P+BcIK5JnXDp3fI9kjo4XWrdfCyRD5foAS9rmQ/ZJqFa1x1uSn
cxAWoAyIfaYAR1yYCEVtLzNgyMxqQnSn4qgI/+gi5jm/RwJjzTkxZB3+xPTmV2kn
SlEd//wehEjXSC/h/cWP30yiT8tw0hP6RIplH2Z+1hivjW5IDZlXbSAE4DyJYLcn
NCIdKBNxNEHqyYQing3u
=T3g4
-----END PGP SIGNATURE-----

--G4gKRVV51F4WsMqJksMFukJI15lSK5oQq--
