From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6] can: sja1000: fix {pre,post}_irq() handling and IRQ
 handler return value
Date: Fri, 06 Dec 2013 11:12:51 +0100
Message-ID: <52A1A323.1030605@pengutronix.de>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com> <loom.20131206T100036-664@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8TTiVT9PKIWQKcqNdcnPpCUE78MvLJWHl"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52280 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406Ab3LFKOe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2013 05:14:34 -0500
In-Reply-To: <loom.20131206T100036-664@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Andrysek <richard.andrysek@rg-mechatronics.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8TTiVT9PKIWQKcqNdcnPpCUE78MvLJWHl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2013 10:27 AM, Richard Andrysek wrote:
>> What do you mean? CAN belongs to the network world. What does the
>> following command report:
>>
>>  # ip -d -s link show can0
>=20
> I have now already modified driver, but before it shown the overrun &
> arbitration lost errors. Perfect command:)
>>
>>> Then each event "arbitration lost" generates an IRQ.
>>
>> From a CAN device?
>=20
> Yes you can see it in a code of driver/net/can/sja1000/sja1000.c,
> function:
>=20
> static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t st=
atus)
> {=20
>    ...
>    if (isrc & IRQ_ALI) {
>       /* arbitration lost interrupt */
>       netdev_dbg(dev, "arbitration lost interrupt\n");
>       alc =3D priv->read_reg(priv, SJA1000_ALC);
>       priv->can.can_stats.arbitration_lost++;
>       stats->tx_errors++;
>       cf->can_id |=3D CAN_ERR_LOSTARB;
>       cf->data[0] =3D alc & 0x1f;
>    }
>    ...
> }
>=20
>=20
> I've just studied sja1000.c I do not know yet, if it is healthy.
> May be something in upper levels will be not anymore well handled.=20
> I've changed a code in a function (see IRQ_ALI part):

You can send a diff, to illustrate your changes.

> static void set_normal_mode(struct net_device *dev)
> {
>   ...
>                if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
>                     priv->write_reg(priv, SJA1000_IER, IRQ_ALL & ~IRQ_A=
LI);
>                else
>                     priv->write_reg(priv, SJA1000_IER,
>                                     IRQ_ALL & ~(IRQ_BEI | IRQ_ALI));
>   ...
> }
>=20
> But I prefare to make some kind of "ioctl" support for that. There are
> applications, where it shall not happend. Concurrently I've played with=

> taskset and priorities.

ioctl() is not a option here, but there are two options:
1) We can put the arbitration lost error to the bus errors,
   but I think that's wrong.
2) You can add another ctrlmode to disable arbitration lost error
   reporting.

> $ ps -e -o pid,rtprio,comm | grep "irq/19"
>    56     89 irq/19-uhci_hcd
>  1877     88 irq/19-can0
>  1922     88 irq/19-can1
>=20
> I do not still understand, what does it mean "irq/19-uhci_hcd". Which i=
s
> also active, even I do not have any USB device. Mouse and keyboard are
> connected through PS2.

The USB interrupt is needed, even if you don't have a device plugged
into an USB port. You have to disable you USB Device in your BIOS,
disable the driver or something like that.

> $ lsusb
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>=20
> Now I have NO FAILURE. To make 100% confirmation, I have to improve  te=
sts.
> Until now:
>=20
> $ ip -d -s link show can0
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN=
 mode
> DEFAULT qlen 10
>     link/can
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>     bitrate 1000000 sample-point 0.750
>     tq 250 prop-seg 1 phase-seg1 1 phase-seg2 1 sjw 1
>     sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
>     clock 8000000
>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>     0          0          0          0          0          0
>     RX: bytes  packets  errors  dropped overrun mcast
>     1874449440 234306180 0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     771292494  107205646 0       0       0       0
>=20
> $ ip -d -s link show can1
> 4: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN=
 mode
> DEFAULT qlen 10
>     link/can
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>     bitrate 1000000 sample-point 0.750
>     tq 250 prop-seg 1 phase-seg1 1 phase-seg2 1 sjw 1
>     sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
>     clock 8000000
>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>     0          0          0          0          0          0
>     RX: bytes  packets  errors  dropped overrun mcast
>     384541802  59160277 0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     77591108   9843156  0       0       0       0
>=20
>=20
> Please keep in mind arbit-lost is now zero forever.

Because you disabled it, right?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--8TTiVT9PKIWQKcqNdcnPpCUE78MvLJWHl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKhoyQACgkQjTAFq1RaXHOHRQCfRxe7AizpgpBhtneH3bh4c0uZ
PJMAnjgJFF925MjxERGA87OSH7Zi++d8
=jeRG
-----END PGP SIGNATURE-----

--8TTiVT9PKIWQKcqNdcnPpCUE78MvLJWHl--
