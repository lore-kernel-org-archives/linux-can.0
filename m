From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
Date: Thu, 16 Mar 2017 11:18:33 +0100
Message-ID: <85ad9a0c-50be-f7b1-4465-ecfdce02df75@pengutronix.de>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <3117407.TP9DfUe48K@ws-stein>
 <c05c554a-c76c-f6d0-7327-f459d807ab3e@hartkopp.net>
 <5803815.9246bLnB9A@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="HPI6CJqu4UEVj6Hw5vojftELj6owAl4Lm"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54733 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751137AbdCPKUL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Mar 2017 06:20:11 -0400
In-Reply-To: <5803815.9246bLnB9A@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Efim Monjak <emonjak@lipowsky.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HPI6CJqu4UEVj6Hw5vojftELj6owAl4Lm
Content-Type: multipart/mixed; boundary="DIPdMNkjED02PO9wMU3l9Jov04mnliXS9";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alexander Stein <alexander.stein@systec-electronic.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Efim Monjak <emonjak@lipowsky.de>, linux-can@vger.kernel.org
Message-ID: <85ad9a0c-50be-f7b1-4465-ecfdce02df75@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <3117407.TP9DfUe48K@ws-stein>
 <c05c554a-c76c-f6d0-7327-f459d807ab3e@hartkopp.net>
 <5803815.9246bLnB9A@ws-stein>
In-Reply-To: <5803815.9246bLnB9A@ws-stein>

--DIPdMNkjED02PO9wMU3l9Jov04mnliXS9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 10:58 AM, Alexander Stein wrote:
>>> Let's see if I get time to cook rx-offload on a USB driver.
>>=20
>> That would be highly appreciated :-)
>=20
> Mh, at a first glance I don't know how to do that, actually. AFAICS
> rx-offload does not support 'pushing' struct can_frame into the
> queue, only pulling from rx-offload. There is no fixed connection
> bewteen the internal can device structure and CAN frames, like
> hardware message boxes. In order to use
> can_rx_offload_irq_offload_fifo() to insert (mostly) a single=20
> can_frame I would need to store the last urb. I think I need to add a
> function similar to can_rx_offload_irq_queue_err_skb(), e.g.=20
> can_rx_offload_irq_queue_skb, but without scheduling. This should be
> done once the urb was completly read.

Does your device support multiple CAN frames per USB?

Maybe rename

> int can_rx_offload_irq_queue_err_skb(struct can_rx_offload *offload, st=
ruct sk_buff *skb)

into can_rx_offload_irq_queue_skb() or
can_rx_offload_irq_queue_skb_schedule() and fix the race condition:

> int can_rx_offload_irq_queue_skb(struct can_rx_offload *offload, struct=
 sk_buff *skb)
> {
take spinlock
>         if (skb_queue_len(&offload->skb_queue) >
>             offload->skb_queue_len_max)

release in case of error

>                 return -ENOMEM;
>=20
>         skb_queue_tail(&offload->skb_queue, skb);

use unlocked variant of skb_queue_tail, i.e. __skb_queue_tail()

release spin lock

>         can_rx_offload_schedule(offload);
>=20
>         return 0;
> }

Then factor all but the can_rx_offload_schedule(offload) call into a
separate function.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DIPdMNkjED02PO9wMU3l9Jov04mnliXS9--

--HPI6CJqu4UEVj6Hw5vojftELj6owAl4Lm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljKZnkACgkQHv7KIOw4
HPZ4fAf/dxHOCnXYRdxew+JmtaNxnqopKgQAn469hD40CP697GbIAEBMtxuXpc30
miVxjlFxD52E/OKXKp3VanO1ONixacE/24PmvkXdFjC7fuGIsB+pEn6xsheiphvq
AocI9nGZ4aZ9rkaVVjYnrsAcj6mddrQg+6NfZIzvVPioUUMhqmKJLQF11gnI+NDE
eSihpvKEd+mKglIQ0EL1yIbS8d2Z/qILdE8VEpfp2ZE/YDYWEH5TKR5/2Y6b0O6i
BNrZF3TmKIAydOt+21g8pLnPQy8Do4UJZcq4wK2pYCYLXs5P6J1jeavj6om9vnui
R8AkSm9zcyq99NRHf6bdWcmxAB7ZSw==
=iAj5
-----END PGP SIGNATURE-----

--HPI6CJqu4UEVj6Hw5vojftELj6owAl4Lm--
