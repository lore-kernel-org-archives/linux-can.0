From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Possible infinite-loop bug in drivers/net/can/flexcan.c
Date: Fri, 23 Aug 2013 11:05:37 +0200
Message-ID: <521725E1.2050001@pengutronix.de>
References: <y4temi78ek9skf1eo2y0tdx8.1377073413580@email.android.com> <52154B8E.8080007@motec.com.au> <52154FA2.2070902@motec.com.au> <52155CC1.3010002@motec.com.au> <521560A5.2020907@motec.com.au> <521574AB.7000207@motec.com.au> <52170C82.9070109@motec.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8As4aM92almuVVArsXdcATqVTvV2fdnAL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48418 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab3HWJGA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 23 Aug 2013 05:06:00 -0400
In-Reply-To: <52170C82.9070109@motec.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom.evans@motec.com.au>
Cc: lw@karo-electronics.de, Scott Thomson <scott.thomson@motec.com.au>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8As4aM92almuVVArsXdcATqVTvV2fdnAL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/23/2013 09:17 AM, Tom Evans wrote:
> I don't know where best to report this, so I'm sending it upstream to
> our Kernel supplier and to the last author in the file header.

Use the official linux-can mailinglist (Cc'ed).

> I'm changing the FlexCAN driver on our i.MX53 product as the kernel
> can't guarantee the NAPI service time and it is dropping CAN packets.
> I've been measuring 19 MILLISECONDS between the CAN interrupt and NAPI
> reading, so it is dropping a huge number of packets.
>=20
> Anyway, while rewriting, I think I spotted an "infinite loop" on a
> buffer allocation failure:
>=20
> /*
>  * flexcan.c - FLEXCAN CAN controller driver
>  *
>  * Copyright (c) 2005-2006 Varma Electronics Oy
>  * Copyright (c) 2009 Sascha Hauer, Pengutronix
>  * Copyright (c) 2010 Marc Kleine-Budde, Pengutronix
>  *
>  * Based on code originally by Andrey Volkov <avolkov@varma-el.com>
> ...
> static int flexcan_poll(struct napi_struct *napi, int quota)
> {
>         ...
>         reg_iflag1 =3D flexcan_read(&regs->iflag1);
>         while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE &&
>                work_done < quota) {
>                 work_done +=3D flexcan_read_frame(dev);
>                 reg_iflag1 =3D flexcan_read(&regs->iflag1);
>         }
>=20
> where...
>=20
> static int flexcan_read_frame(struct net_device *dev)
> {
>         struct net_device_stats *stats =3D &dev->stats;
>         struct can_frame *cf;
>         struct sk_buff *skb;
>=20
>         skb =3D alloc_can_skb(dev, &cf);
>         if (unlikely(!skb)) {
>                 stats->rx_dropped++;
>                 return 0;
>         }
>=20
> So if alloc_can_skb() returns NULL, it fails to read the FlexCAN
> registers, doesn't clear FLEXCAN_IFLAG_RX_FIFO_AVAILABLE and returns ZE=
RO.
>=20
> The "while" loop in flexcan_poll() only exits when the FlexCAN FIFO is
> empty or when "work_done" counts out.
>=20
> I've put some test code in flexcan_read_frame() to stop allocating skbs=

> after 10,000 calls, and after than many CAN messages the whole thing
> resets as the watchdog resets it.
>=20
> The simplest fix is to have flexcan_read_frame() return "1" on drop.

How does the driver behave if flexcan_read_frame() returns "1" here?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--8As4aM92almuVVArsXdcATqVTvV2fdnAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIXJeEACgkQjTAFq1RaXHO1BACggTa+Ah/92Fpbiybyp7/4vBat
7JIAnAnXSALrXyznHZrlx4ONPOOL5c1p
=FDML
-----END PGP SIGNATURE-----

--8As4aM92almuVVArsXdcATqVTvV2fdnAL--
