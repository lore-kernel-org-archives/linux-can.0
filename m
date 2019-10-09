From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/7] can: rx-offload: continue on error
Date: Wed, 9 Oct 2019 15:18:12 +0200
Message-ID: <134ddb8e-a231-922d-f554-ca77ce0c16af@pengutronix.de>
References: <20190924184437.10607-1-jhofstee@victronenergy.com>
 <20190924184437.10607-2-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BXNKZd3qMlXdhqpqPUPu9DyJyHZxPf3Ik"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190924184437.10607-2-jhofstee@victronenergy.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeroen Hofstee <jhofstee@victronenergy.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BXNKZd3qMlXdhqpqPUPu9DyJyHZxPf3Ik
Content-Type: multipart/mixed; boundary="KNwgur7TmfQkHy3BGycM90HOnustJrKiJ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jeroen Hofstee <jhofstee@victronenergy.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Message-ID: <134ddb8e-a231-922d-f554-ca77ce0c16af@pengutronix.de>
Subject: Re: [PATCH 1/7] can: rx-offload: continue on error
References: <20190924184437.10607-1-jhofstee@victronenergy.com>
 <20190924184437.10607-2-jhofstee@victronenergy.com>
In-Reply-To: <20190924184437.10607-2-jhofstee@victronenergy.com>

--KNwgur7TmfQkHy3BGycM90HOnustJrKiJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello Jeroen,

I'm currently looking at the rx-offload error handling in detail.

TLDR: I've added the patch to linux-can.

Thanks,
Marc

For the record, the details:

On 9/24/19 8:45 PM, Jeroen Hofstee wrote:
> While can_rx_offload_offload_one will call mailbox_read to discard
> the mailbox in case of an error,

Yes.

can_rx_offload_offload_one() will read into the discard mailbox in case
of an error.

Currently there are two kinds of errors:
1) the rx-offoad skb queue (between the IRQ handler and the NAPI)
   is full
2) alloc_can_skb() fails to allocate a skb, due to OOM

> can_rx_offload_irq_offload_timestamp bails out in the error case.

Yes, in case of an error both can_rx_offload_irq_offload_timestamp() and
can_rx_offload_irq_offload_fifo() will stop reading mailboxes, add the
already filled skbs to the queue and schedule NAPI if needed.

Currently both can_rx_offload_irq_offload_timestamp() and
can_rx_offload_irq_offload_fifo() will return the number of queued
mailboxes.

This means in case of queue overflow or OOM, only one mailbox is
discaded, before can_rx_offload_irq_offload_*() returning the number of
successfully queued mailboxes so far.

Looking at the flexcan driver:

https://elixir.bootlin.com/linux/latest/source/drivers/net/can/flexcan.c#=
L867

> 		while ((reg_iflag =3D flexcan_read_reg_iflag_rx(priv))) {
> 			handled =3D IRQ_HANDLED;
> 			ret =3D can_rx_offload_irq_offload_timestamp(&priv->offload,
> 								   reg_iflag);
> 			if (!ret)
> 				break;
> 		}
[...]
> 		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) {
> 			handled =3D IRQ_HANDLED;
> 			can_rx_offload_irq_offload_fifo(&priv->offload);
> 		}

This means for the timestamp mode, at least one mailbox is discarded or
if the error occurred after reading one or more mailboxes the while loop
will try again. If the error persists a second mailbox is discarded.

For the fifo mode, only one mailbox is discarded.

Then the flexcan's IRQ is exited. If there are messages in mailboxes are
pending another IRQ is triggered.... I doubt that this is a good idea.

On the other hand the ti_hecc driver:

> 		/* offload RX mailboxes and let NAPI deliver them */
> 		while ((rx_pending =3D hecc_read(priv, HECC_CANRMP))) {
> 			can_rx_offload_irq_offload_timestamp(&priv->offload,
> 							     rx_pending);
> 			hecc_write(priv, HECC_CANRMP, rx_pending);
> 		}

The error is ignored and the _all_ mailboxes are discarded (given the
error persists).

> Since it is typically called from a while loop, all message will
> eventually be discarded. So lets continue on error instead to discard
> them directly.

After reading my own code and writing it up, your patch totally makes sen=
se.

If there is a shortage of resources, queue overrun or OOM, it makes no
sense to return from the IRQ handler, if a mailbox is still active as it
will trigger the IRQ again. Entering the IRQ handler again probably
doesn't give the system time to recover from the resource problem.

> Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
> ---
>  drivers/net/can/rx-offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.=
c
> index e6a668ee7730..39df41280e2d 100644
> --- a/drivers/net/can/rx-offload.c
> +++ b/drivers/net/can/rx-offload.c
> @@ -158,7 +158,7 @@ int can_rx_offload_irq_offload_timestamp(struct can=
_rx_offload *offload, u64 pen
> =20
>  		skb =3D can_rx_offload_offload_one(offload, i);
>  		if (!skb)
> -			break;
> +			continue;
> =20
>  		__skb_queue_add_sort(&skb_queue, skb, can_rx_offload_compare);
>  	}
>=20

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--KNwgur7TmfQkHy3BGycM90HOnustJrKiJ--

--BXNKZd3qMlXdhqpqPUPu9DyJyHZxPf3Ik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2d3hQACgkQWsYho5Hk
nSBm/Qf/db/9uepOMhA4XKlFASkkpWMbqzjYRhEwCqR2+SPQscKUaCLawPTQFOMS
LN46ygYSRhbiQ8hSI1DwVwfY/alylL3KP4JqRnuawdj98Vi+HR4ywPG5b4cxlguQ
7qmip9bFAgODJCGN43tU3DZ+3yBPG75nRO5BCpcu84TV3HxdZ8TbCrPEjTrhwzdF
aDkMPVSRqe8h3t5KMC3BXgW2MTz7y+ThixpAJUmdeYIDEXS2l0VHWCCXlaeX+/PC
f9xoa57oKxt1CTHAmQFLjCgJ896+otSkrRwzfM0njNR5pC6zgi88MPQyQZYlC43r
zgnL87JBES2oqQ22tILFSMFWY/69lA==
=SEml
-----END PGP SIGNATURE-----

--BXNKZd3qMlXdhqpqPUPu9DyJyHZxPf3Ik--
