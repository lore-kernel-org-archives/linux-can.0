From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: API to support hardware priorities
Date: Mon, 9 Nov 2015 14:51:32 +0100
Message-ID: <5640A4E4.6020005@pengutronix.de>
References: <20151109123618.41ad1bae@mitra> <5640A065.2000401@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="r4QfwT2mKo0IPHSOaQpf3iakFDCkUealN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47889 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbbKINvl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Nov 2015 08:51:41 -0500
In-Reply-To: <5640A065.2000401@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Benedikt Spranger <b.spranger@linutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r4QfwT2mKo0IPHSOaQpf3iakFDCkUealN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/2015 02:32 PM, Marc Kleine-Budde wrote:
> Let's move this discussion to the mailing list. I'll translate your
> questions.
>=20
> On 11/09/2015 12:36 PM, Benedikt Spranger wrote:
>> C-CAN und D-CAN basierte Hardware (wie auch andere) unterst=C3=BCtzt j=
a das
>> priorisierende Versenden von CAN-Paketen. Gibt es Bestrebungen, dieses=

>> Feature in der API abzubilden?
>=20
> Several CAN IP cores support prioritisation of CAN frames. Is it planne=
d
> to support this?

There are two buffers before a CAN frame gets send to the wire:
First there is the queueing in the network layer. You can replace the
FIFO of the interface by a multi prio queue and filter your CAN frames
by CAN-ID.

The second buffer might be the in the hardware. For now each driver
ensures that the buffer in configured as a FIFO. Some CAN IP cores
support sending CAN frames based on the CAN-ID (lowest ID first), some
have a priority value, some cores even combine these two.

Several thoughts on this:

IIRC the kernel networking driver API supports several TX queues per
networking device. We might be exploited this to implement a bulk large
FIFO queue and a high prio no just one buffer TX queue per driver.

We can introduce a per device knob to switch a CAN driver from true TX
FIFO mode to CAN-ID based priority TX mode. The driver's TX and
TX-complete routines have to be adopted as they now assume that the CAN
frames are send in true FIFO order. The feature can be toggled via
netlink/canconfig.

>> Im konkreten Fall werden neben Bulk-Daten azyklisch auch zeitkritische=

>> CAN-Pakete versendet. Hierbei ist eine FIFO-Abarbeitung st=C3=B6rend. =
Das
>> Mailbox-basierte Design von C-CAN/D-CAN unterst=C3=BCtzt ja neben der
>> Verwendung der Mailboxen als FIFO auch die dedizierte Konfiguration au=
f
>> eine CAN-Id/Maske.
>=20
> Bene want to send bulk data and time critical cyclic data. Using a
> hardware FIFO introduces unwanted latencies. He further mentions that
> it's possible to configure the mailboxes to serve a CAN-ID/mask.

Are we talking about RX or TX here?

Do you mean the mailbox feature, where you queue a frame into hardware,
but sending is delayed until a certain CAN-ID is RX'ed?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--r4QfwT2mKo0IPHSOaQpf3iakFDCkUealN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWQKTkAAoJEP5prqPJtc/HKXEIAMI3qedoe/bB2QaJAyMuADyt
ZrQrxFqdwK6qan/9s3/vUn/VEUZe92AG/nBk0Tfz/zp0lds6ktxfOnEJRinpz6lf
lFZ3BGnUzyTq6aRuS3NaMQP60UtG7GgwjO+ivmH4kusMkSXUBOIaoD9m3DIuTqp2
79kI4sSmFACvZC/7ZwRCi63cfYj8YDU1g+wTYkweE71N4TQ1hihTDAy3Hi1UjDDj
H7wAh7MTL016RqyNL0p9JpmegxyeBqOXBsO3h4EMO8hy+FDoLHBpvKa3w3kMPgQ0
LItWGOp5GI1TbmjBYlJjDlxXUQjZcz8Nq4yJkl/AkPflGge1tv62f5HPOvOnquk=
=Ju1j
-----END PGP SIGNATURE-----

--r4QfwT2mKo0IPHSOaQpf3iakFDCkUealN--
