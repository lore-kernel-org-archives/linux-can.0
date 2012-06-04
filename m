From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Socketcan-users] Flexcan on i.mx536 Infotainment Platform
Date: Mon, 04 Jun 2012 23:52:57 +0200
Message-ID: <4FCD2E39.3060809@pengutronix.de>
References: <1338845698.76889.YahooMailNeo@web140802.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEE6F2877F4686A28D6E1AE78"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49160 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760946Ab2FDVxE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Jun 2012 17:53:04 -0400
In-Reply-To: <1338845698.76889.YahooMailNeo@web140802.mail.bf1.yahoo.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Keith Jones <keith.rjones@yahoo.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEE6F2877F4686A28D6E1AE78
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Keith,

please switch to the "linux-can@vger.kernel.org" mailinglist, the
berlios list is obsolete.

On 06/04/2012 11:34 PM, Keith Jones wrote:
> I booted up my new Infotainment demo board after ported 2.6.39
> flexcan (flexcan.h flexcan.c) support into my 2.6.35 linux distro.

Use v3.4 or better, this version contains some vital fixes against error
irq floods.

> After seeing flexcan driver register and performing the following
> commands, I get constant interrupts and error packets visualized
> using my Canoe CANbus sniffer. I am using 250K baud. Did not check
> termination. No oscilloscope was used as yet. Can not receive any
> packets. can state goes from ERROR-ACTIVE to ERROR-PASSIVE.

Please check the Termination, do you have a second CAN member on the bus?=


> Any clues?

> root@freescale ~$ cansend can0 123#1122334455
> root@freescale /usr/bin$ ip -d -s link show can0
> 2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN=
 qlen 10
>     link/can
>     can state ERROR-PASSIVE (berr-counter tx 128 rx 0) restart-ms 0
>     bitrate 250000 sample-point 0.875
>     tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>     flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>     clock 24000000
>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>     0          0          0          5          5          0
>     RX: bytes  packets  errors  dropped overrun mcast
>     80         10       0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     5          0        0       0       0       0

If the tx error counter goes up, the device may be the only device on
the CAN bus. Your sniffer is probably totally passive, which means it
doesn't qualify as a second station.

cheers, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigEE6F2877F4686A28D6E1AE78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/NLj0ACgkQjTAFq1RaXHOGBgCfVZlq8Lwfe5NLhsTDnFODxJZS
bBEAnR035DUOhWNXciRsOdYthHt6EAyf
=VwC1
-----END PGP SIGNATURE-----

--------------enigEE6F2877F4686A28D6E1AE78--
