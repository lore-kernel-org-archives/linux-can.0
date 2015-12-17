From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Hardware Loopback on RT-Socket-CAN Needed
Date: Thu, 17 Dec 2015 15:43:21 +0100
Message-ID: <5672CA09.2050503@pengutronix.de>
References: <54DCF20AC6227B4FABAC7D71A5A1208F78E9068B@BLRKECMBX13.ad.infosys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7rKfsrW1ERTBJeUw8IodqCb0VXHWsei5h"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58840 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752079AbbLQOnc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Dec 2015 09:43:32 -0500
In-Reply-To: <54DCF20AC6227B4FABAC7D71A5A1208F78E9068B@BLRKECMBX13.ad.infosys.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephen Marshall <Stephen_Marshall@infosys.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7rKfsrW1ERTBJeUw8IodqCb0VXHWsei5h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/17/2015 03:13 PM, Stephen Marshall wrote:
> I am looking for some information on Loopback functionality for the
> RT-Socket-CAN.

You mean RT-Socket-CAN as in Xenomai? This is, as far as i know dead.

> In Socket-CAN, we used to test the loopback functionality on own socket=

> using the flag *CAN_RAW_RECV_OWN_MSGS *using *MSG.CONFIRM* flag. Howeve=
r
> in RT-Socket CAN we see that this option has been disabled purposefully=
=2E
>=20
> Could someone please clarify us on the below questions?
>=20
> 1)      How we can do a hardware loopback (i.e., message from the
> transmit socket has to reach the same socket through the bus) on
> RT-Socket CAN?

Some CAN controllers have a bit to enable HW Loopback, e.g. flexcan has:

/* FLEXCAN module configuration register (CANMCR) bits */
#define FLEXCAN_MCR_SRX_DIS             BIT(17)

for this.

> 2)      If receive own messages is not supported, how is address claim
> handled in J1939 applications for other RT-Socket-CAN programs?

I don't know anyone using j1939 on RT-Socket-CAN. However there are some
companies, especially in the last 3 month interested in bringing j1939
to mainline linux-can.

> 3)      How do we patch the RT-Socket-CAN with the CAN_RAW_RECV_OWN_MSG=
S
> fix at kernel level? Any details on fix that should be taken and GIT
> repo details would be helpful. Would patching have any impact on the
> real-time capability?

Don't know. Sorry, I'm interested in mainline linux-can only.

> We use the SJA1000 CAN Controller and Xenomai 2.6. We tried setting the=

> SRR (Self Reception Request) bit at driver using *CAN_CTRLMODE_LOOPBACK=
*
> <http://www.xenomai.org/documentation/xenomai-2.4/html/api/group__rtcan=
=2Ehtml#ga19ec0cc4379e80c32cbd333cf7c145e9>*,
> *however it was doing a software loopback where the looped back message=

> would not have actually gone in the bus. We needed the
> CAN_RAW_RECV_OWN_MSGS fix at RT-Socket-CAN, could someone help?

We do a software loopback in linux-can, too. But we do the actual
loopback-send in the TX-completion handler. This means no sent frame, no
loopback. You can do this in the Xenomai driver probably, too. However,
an increase of interrupts might have slight impact on the overall RT
performance, but I this this is unelectable.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7rKfsrW1ERTBJeUw8IodqCb0VXHWsei5h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWcsoJAAoJEP5prqPJtc/HDmUH+gImnTWVq0LZYLCrnepwpNek
DQ4+bsEIxwboavFuuKIAEUMpktIemx4nxrM1LQ8lFA0SU1Z7zuNauPfebtKusIae
6H8ijF39FXCUUPgk0c4PPQuDc6c0hTQsEk2Vuc63YutV6WlxJqHUs/miPWR1ei+y
hSXnRTw6rDQOsE+sRzswSp7YcUbAo/2x03l+s91zBOoLqPLbZnM/cwr6SqvvcPWi
D6UQD3jJe1VWJV5wMDPFaZY+YA0Vd/92lU0afcegSK1t8+CqOsljqpGIzBLe3+YM
wNuRxgOi8dtRM1qckfBT5herf921cATbGfxcytNjB85mUlIKcwzqfW8HQp68cAs=
=xvV+
-----END PGP SIGNATURE-----

--7rKfsrW1ERTBJeUw8IodqCb0VXHWsei5h--
