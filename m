From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: fix rx wrong sequence issue
Date: Mon, 05 Nov 2012 19:15:27 +0100
Message-ID: <5098023F.5040001@pengutronix.de>
References: <1349678436-747-1-git-send-email-anilkumar@ti.com> <5097A45F.3000606@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFE1978EB3A791621699DC986"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36396 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061Ab2KESPg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 Nov 2012 13:15:36 -0500
In-Reply-To: <5097A45F.3000606@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, swarren@wwwdotorg.org, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFE1978EB3A791621699DC986
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/05/2012 12:34 PM, Marc Kleine-Budde wrote:
> Hello,
>=20
> On 10/08/2012 08:40 AM, AnilKumar Ch wrote:
>> Fix "received wrong sequence count. expected: x, got: y" errors
>> reported by cansequence in a stress test (--verbose).
>>
>> While processing the receive packets in mailboxes, upper mailboxes
>> need to enable while processing 12th (RX_BUFFER mailbox) mailbox.
>> This requires a status check to identify whether the receiving of
>> packets in progress or not. If the mailboxes are enabled before the
>> receive packet status is cleared then there is a possibility of
>> receiving out of order packets.
>>
>> With this patch mailboxes are enabled once the receive status is
>> cleared.
>>
[..]

> Then I had a closer look at AnilKumar Ch's patch, the canme register is=

> not changed if a the CAN core currently receives a CAN frame. I added
> AnilKumar Ch's busy loop before modifying the canme register, and it
> works now. So I conclude that the "pick next free mailbox" algorithm in=

> the CAN core is racy. You are not allowed to do something that changes =
a
> mailbox's status from disabled/full to enabled/free when a CAN frame is=

> received. As you cannot control CAN frame reception, this is a nice
> hardware race condition. Please add this to the manual and errata sheet=
s.

I really want to know where the race window starts and ends, in order to
specify proper timeouts.

This is a hunk from AnilKumar Ch's patch:

>  			/* enable high bank mailboxes */
> +			timeout =3D jiffies + usecs_to_jiffies(RM_TIMEOUT_US);
> +			while (hecc_get_bit(priv, HECC_CANES, HECC_CANES_RM)) {
> +				cpu_relax();
> +				if (time_after(jiffies, timeout)) {
> +					netdev_warn(ndev, "receiving pkt\n");
> +					break;
> +				}
> +			}
> +

You first wait for reception to finish, but then might block on this
spin_lock. This introduces a software race condition.

>  			spin_lock_irqsave(&priv->mbx_lock, flags);
>  			mbx_mask =3D hecc_read(priv, HECC_CANME);
>  			mbx_mask |=3D HECC_RX_HIGH_MBOX_MASK;

We have to use the spin_lock because the CANME register is shared
between the rx and tx path. I think it's better to make use of
CANRPM+CANMIM, because I think the critical path is the modification of
the CANRPM register, which is not shared, so it can be written without
the need for the spin_lock.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigFE1978EB3A791621699DC986
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCYAj8ACgkQjTAFq1RaXHNT9ACfTevBbh8HC+avWpbNpCJcRrfA
iZkAn0ERcnXDSNewnlYxnIxzNXKDX2OR
=8Cig
-----END PGP SIGNATURE-----

--------------enigFE1978EB3A791621699DC986--
