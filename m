From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: fix rx wrong sequence issue
Date: Mon, 05 Nov 2012 19:40:37 +0100
Message-ID: <50980825.6030805@pengutronix.de>
References: <1349678436-747-1-git-send-email-anilkumar@ti.com> <5097A45F.3000606@pengutronix.de> <5098023F.5040001@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0FF9703FFBCBF3F6F57D0656"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48856 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab2KESkp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 Nov 2012 13:40:45 -0500
In-Reply-To: <5098023F.5040001@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, swarren@wwwdotorg.org, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0FF9703FFBCBF3F6F57D0656
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/05/2012 07:15 PM, Marc Kleine-Budde wrote:
> On 11/05/2012 12:34 PM, Marc Kleine-Budde wrote:
>> Hello,
>>
>> On 10/08/2012 08:40 AM, AnilKumar Ch wrote:
>>> Fix "received wrong sequence count. expected: x, got: y" errors
>>> reported by cansequence in a stress test (--verbose).
>>>
>>> While processing the receive packets in mailboxes, upper mailboxes
>>> need to enable while processing 12th (RX_BUFFER mailbox) mailbox.
>>> This requires a status check to identify whether the receiving of
>>> packets in progress or not. If the mailboxes are enabled before the
>>> receive packet status is cleared then there is a possibility of
>>> receiving out of order packets.
>>>
>>> With this patch mailboxes are enabled once the receive status is
>>> cleared.
>>>
> [..]
>=20
>> Then I had a closer look at AnilKumar Ch's patch, the canme register i=
s
>> not changed if a the CAN core currently receives a CAN frame. I added
>> AnilKumar Ch's busy loop before modifying the canme register, and it
>> works now. So I conclude that the "pick next free mailbox" algorithm i=
n
>> the CAN core is racy. You are not allowed to do something that changes=
 a
>> mailbox's status from disabled/full to enabled/free when a CAN frame i=
s
>> received. As you cannot control CAN frame reception, this is a nice
>> hardware race condition. Please add this to the manual and errata shee=
ts.
>=20
> I really want to know where the race window starts and ends, in order t=
o
> specify proper timeouts.
>=20
> This is a hunk from AnilKumar Ch's patch:
>=20
>>  			/* enable high bank mailboxes */
>> +			timeout =3D jiffies + usecs_to_jiffies(RM_TIMEOUT_US);
>> +			while (hecc_get_bit(priv, HECC_CANES, HECC_CANES_RM)) {
>> +				cpu_relax();
>> +				if (time_after(jiffies, timeout)) {
>> +					netdev_warn(ndev, "receiving pkt\n");
>> +					break;
>> +				}
>> +			}
>> +
>=20
> You first wait for reception to finish, but then might block on this
> spin_lock. This introduces a software race condition.
>=20
>>  			spin_lock_irqsave(&priv->mbx_lock, flags);
>>  			mbx_mask =3D hecc_read(priv, HECC_CANME);
>>  			mbx_mask |=3D HECC_RX_HIGH_MBOX_MASK;
>=20
> We have to use the spin_lock because the CANME register is shared
> between the rx and tx path. I think it's better to make use of
> CANRPM+CANMIM, because I think the critical path is the modification of=

> the CANRPM register, which is not shared, so it can be written without
> the need for the spin_lock.

I've implemented both solutions and both are working. I've instrumented
how long the CAN driver does stay in the while loop. I've loaded the CAN
bus with:

# 1 byte frame
cansequence -p

# 8 byte frame, all 1s
cansend can0 -i 0xffffffff 0xff 0xff 0xff 0xff 0xff 0xaff 0xff 0xff
--loop=3D-1 -e

Both solution show about the same number of loops, depending on the bit
rate of the bus:

500 kbit/s
hecc_set_bit_canme: looped 867 times

50 kbit/s
hecc_set_bit_canme: looped 4807 times

AnilKumar, can you get in contact with the hardware people to figure out
a better solution than to cycle 4k times in a loop?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig0FF9703FFBCBF3F6F57D0656
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCYCCUACgkQjTAFq1RaXHP+hQCdEQRgMl3n5Z0p9JsXm4MqIoaE
+yMAnjTcpFyBuKWUXRmwvllcureL3JFk
=i8PE
-----END PGP SIGNATURE-----

--------------enig0FF9703FFBCBF3F6F57D0656--
