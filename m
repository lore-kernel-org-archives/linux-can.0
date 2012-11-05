From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: fix rx wrong sequence issue
Date: Mon, 05 Nov 2012 12:34:55 +0100
Message-ID: <5097A45F.3000606@pengutronix.de>
References: <1349678436-747-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3B2B11BF22FB0DD434EE5F07"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47001 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab2KELfG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 Nov 2012 06:35:06 -0500
In-Reply-To: <1349678436-747-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, swarren@wwwdotorg.org, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3B2B11BF22FB0DD434EE5F07
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

On 10/08/2012 08:40 AM, AnilKumar Ch wrote:
> Fix "received wrong sequence count. expected: x, got: y" errors
> reported by cansequence in a stress test (--verbose).
>=20
> While processing the receive packets in mailboxes, upper mailboxes
> need to enable while processing 12th (RX_BUFFER mailbox) mailbox.
> This requires a status check to identify whether the receiving of
> packets in progress or not. If the mailboxes are enabled before the
> receive packet status is cleared then there is a possibility of
> receiving out of order packets.
>=20
> With this patch mailboxes are enabled once the receive status is
> cleared.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

AnilKumar Ch, can you add some TI people with access to the vhdl CAN
core design to Cc?

I'm debugging this issue for a week, fixed several other problems with
the driver and now and it seems there is a race condition in the hardware=
=2E

The algorithm in the driver relies on the ability to re-enable a bunch
of mailboxes with a single write command. In the ti_hecc hardware the
driver uses the CANME (mailbox enable) register to do so. Under certain
circumstances I've noticed that the CAN core receives the next message
into an undefined mailbox. According to the data sheet CAN messages are
always received into the highest free mailbox (with a matching filter).
But after enabling the mailboxes the next CAN frame doesn't go into the
highest mailbox.

This is a log from my test application. The ti_hecc receives 1 byte long
frames at 500 kbit/s. In the first data byte a number is increased with
every CAN frame (the "d=3D" column). The enabled mailboxes are in the "me=
"
column and the pending messages in "rmp".

> [   57.390747] ti_hecc ti_hecc: can0: i=3D39502 m=3D14 n=3D14 rmp=3D000=
04000 me=3D00007ff0 d=3D 78
> [   57.390777] ti_hecc ti_hecc: can0: i=3D39503 m=3D13 n=3D13 rmp=3D000=
02000 me=3D00003ff0 d=3D 79
> [   57.390777] ti_hecc ti_hecc: can0: i=3D39504 m=3D12 n=3D12 rmp=3D000=
01000 me=3D00001ff0 d=3D 80
> [   57.390808] ti_hecc ti_hecc: can0: i=3D39505 m=3D11 n=3D11 rmp=3D000=
00800 me=3D00000ff0 d=3D 81
> [   57.390838] ti_hecc ti_hecc: can0: i=3D39506 m=3D10 n=3D10 rmp=3D000=
00400 me=3D000007f0 d=3D 82
> [   57.390838] ti_hecc ti_hecc: can0: i=3D39507 m=3D 9 n=3D 9 rmp=3D000=
00200 me=3D000003f0 d=3D 83
> [   57.390869] ti_hecc ti_hecc: can0: i=3D39508 m=3D 8 n=3D 8 rmp=3D000=
00100 me=3D000001f0 d=3D 84

Here the driver enables the high priority mailboxes (0xfffff000) with a
single write. Actually the driver writes 0xfffff0f0, as there a still
four free low priority mailboxes.

> [   57.390899] ti_hecc ti_hecc: can0: i=3D39509 m=3D 0 n=3D 7 rmp=3D000=
10000 me=3Dfffff0f0 d=3D  0
                                                                 ^
The next CAN frame should be received, either into 0x00000800 (if the
reception happens before the driver enables the high prio mailboxes) or
into 0x80000000 (if the reception takes place after the driver has
written the canme register).

> [   57.390930] ti_hecc ti_hecc: can0: i=3D39510 m=3D 0 n=3D 7 rmp=3D000=
10000 me=3Dfffff0f0 d=3D  0
> [   57.390930] ti_hecc ti_hecc: can0: i=3D39511 m=3D 0 n=3D 7 rmp=3D000=
10000 me=3Dfffff0f0 d=3D  0
> [   57.390960] ti_hecc ti_hecc: can0: i=3D39512 m=3D 0 n=3D 7 rmp=3D000=
10000 me=3Dfffff0f0 d=3D  0
> [   57.390991] ti_hecc ti_hecc: can0: i=3D39513 m=3D 0 n=3D 7 rmp=3D000=
10000 me=3Dfffff0f0 d=3D  0
> [   57.391021] ti_hecc ti_hecc: can0: i=3D39514 m=3D 0 n=3D 7 rmp=3D000=
10000 me=3Dfffff0f0 d=3D  0
> [   57.391021] ti_hecc ti_hecc: can0: i=3D39515 m=3D 0 n=3D 7 rmp=3D000=
10000 me=3Dfffff0f0 d=3D  0
> [   57.391052] ti_hecc ti_hecc: can0: i=3D39516 m=3D 0 n=3D 7 rmp=3D000=
10000 me=3Dfffff0f0 d=3D  0
> [   57.391082] ti_hecc ti_hecc: can0: i=3D39517 m=3D31 n=3D31 rmp=3D800=
10000 me=3Dfffff0f0 d=3D 86
                                                              ^
We see the next frame goes into 0x80000000 as expected. (There are so
many d=3D0 lines, because the driver is confused, as the next frame is no=
t
expected in the 0x00010000 mailbox.)

There isn't any tx going on at the moment, the rx-path is the only
modifier of the canme register.

I thought maybe there is a problem in the hardware with the canme
register, so I've reworked the algorithm not to change the canme
register at all. canme stays 0xfffffff0 all the time (all rx mailboxes
active), but received frames are not acknowledged (I don't write 1s into
canrmp after message reception). The pending rx interrupts are masked
with canmim. To "enable" the mailboxes again, the driver clears bits in
the canrmp register with a single write and then unmasks the interrupt
again. This however results in _the_same_ buggy behaviour.

Then I had a closer look at AnilKumar Ch's patch, the canme register is
not changed if a the CAN core currently receives a CAN frame. I added
AnilKumar Ch's busy loop before modifying the canme register, and it
works now. So I conclude that the "pick next free mailbox" algorithm in
the CAN core is racy. You are not allowed to do something that changes a
mailbox's status from disabled/full to enabled/free when a CAN frame is
received. As you cannot control CAN frame reception, this is a nice
hardware race condition. Please add this to the manual and errata sheets.=


I'll post a series which fixes the problems I've found soon.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig3B2B11BF22FB0DD434EE5F07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCXpGMACgkQjTAFq1RaXHMAKQCZAR1pX0ASxqJ+7JpkhZB00cUq
YwIAoIdSgSnVL8kg2Rt0r1Ck5EGUEza+
=Q+0G
-----END PGP SIGNATURE-----

--------------enig3B2B11BF22FB0DD434EE5F07--
