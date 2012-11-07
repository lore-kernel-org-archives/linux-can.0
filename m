From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: WIP: fix out-of-order problem - CANMIN
 Version
Date: Wed, 07 Nov 2012 13:27:14 +0100
Message-ID: <509A53A2.8020902@pengutronix.de>
References: <a> <1352145232-16403-1-git-send-email-mkl@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA664B7@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig72DF21D85C2F40E71ADCAE68"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60958 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab2KGM1Y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Nov 2012 07:27:24 -0500
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA664B7@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig72DF21D85C2F40E71ADCAE68
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/07/2012 01:10 PM, AnilKumar, Chimata wrote:
> On Tue, Nov 06, 2012 at 01:23:52, Marc Kleine-Budde wrote:
>> This is Work-In-Process patch which fixes several problem:
>> - ti_hecc_xmit: modify CANMIM under spin_lock
>> - ti_hecc_rx_pkt: don't re-enable current mailbox,
>>   next CAN frame might do into same mailbox
>> - ti_hecc_interrupt: modify CANMIM under spin_lock
>> - ti_hecc_rx_poll: rework polling loop, wrap-around-handling and
>>   reactivation of mailboxes.
>>
>> Before acknowledging the received CAN frames in CANRMP wait for CAN co=
re to
>> finish current rx, otherwise next CAN frame goes into undefined mailbo=
x. Idea
>> lifted shamelessly from AnilKumar Ch's patch.
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Hello AnilKumar,
>>
>> here's the CANMIN version. With this patch the rx-path doesn't change =
the CANME
>> register, the wait-for-end-of-reception is done before writing to the =
CANRMP
>> register. So there isn't any spin_lock after the busy wait loop.
>>
>> please test,
>=20
> +Anant
>=20
> Hi Marc,
>=20
> Note: I am not using the standard utilities, I have the utilities
> from http://git.pengutronix.de/?p=3Dtools/canutils.git

I use them as well.

> 1. I am seeing the issue with this patch as well.
>=20
> @500KBPS
> <0x002> [1] 13
> <0x002> [1] 16
> <0x002> [1] 18
> <0x002> [1] 1d
> <0x002> [1] 20
> <0x002> [1] 23
> <0x002> [1] 26
> <0x002> [1] 29
>=20
> @1MBPS
> <0x002> [1] 22
> <0x002> [1] 37
> <0x002> [1] 44
> <0x002> [1] 54
> <0x002> [1] 6a
> <0x002> [1] 80
> <0x002> [1] 94
> <0x002> [1] a6
>=20
> Steps I have followed:-
>     One side AM335x sending packets through D_CAN ip
>       $ cansequence can0 -p
>     AM3517 receiving the packets through HECC ip
>       $ candump can0
>=20
> 2. But if I use this command in the reception side @500KBPS I am not
> seeing any out of seq message "received wrong sequence count....".
> This might be due to load on the system is less because no
> UART/console prints
>=20
> $ cansequence -r -v | grep wrong=20

I'm using $(cansequence -rvv | grep wrong) and it works for me even
under heavy ping -f load  at 500Kbit/s. I think without the grep the
receiving process spends too much time printing and the receive buffer
in the socket will overflow.

> 3. @1MBPS I have seen the wrong sequence message.

Can you give the the exact error messages. There is a difference between
"lost" messages and out-of-order messages. Lost messages simply print a
single wrong sequence number detected message. An out-of-order reception
prints a characteristic 3 line error message.

BTW: We should check if a lost message on the CAN core level leads to a
receive buffer overflow CAN error frame.

My hardware is not working properly at 1Mbit/s. Can you check if the
patch I sent first makes a difference?

> With the standard utilities can we test the can-sequence? I have not
> used those.

As Wolfgang pointed out, you might use canfdtest [1]. But I haven't used
it, yet. Maybe I should as cansequence doesn't trigger the problem at
500 kbit/s any more.

Marc

[1] https://gitorious.org/linux-can/can-utils/blobs/master/canfdtest.c

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig72DF21D85C2F40E71ADCAE68
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCaU6UACgkQjTAFq1RaXHMYeACfTFJuMkimibo2sunCYaStt1J8
Y1sAnRu4KtjNbqKcgGREi5XQ/tkqGFSB
=r3x4
-----END PGP SIGNATURE-----

--------------enig72DF21D85C2F40E71ADCAE68--
