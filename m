From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] to C_CAN driver in linux kernel
Date: Sun, 24 Nov 2013 23:23:01 +0100
Message-ID: <52927C45.8080507@pengutronix.de>
References: <20131124121547.GB4010@pc1xp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lvpJCQguVEWpRjfIxQCeEJeRdwuiNS0nt"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53626 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab3KXWXH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 24 Nov 2013 17:23:07 -0500
In-Reply-To: <20131124121547.GB4010@pc1xp>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Holger Bechtold <Holger.Bechtold@gmx.net>
Cc: wg@grandegger.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lvpJCQguVEWpRjfIxQCeEJeRdwuiNS0nt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Holger,

On 11/24/2013 01:15 PM, Holger Bechtold wrote:
> I would like to sumbit 2 patches to the C_CAN driver module file c_can.=
c.

Thanks for your contribution. Please keep it one patch per Mail, for
further patches please have a look at Documentation/SubmittingPatches in
the Kernel tree.

> Both bugs were noticed, fixed and tested on platform
>    BeagleBoneBlack with AM335x Texas Instruments ARM Microprocessors
> using these 2 kernel versions:

> Linux beaglebone 3.8.13 #1 SMP Thu Sep 12 10:27:06 CEST 2013 armv7l GNU=
/Linux
> Linux ubuntu-armhf 3.8.13-bone20 #1 SMP Wed May 29 10:49:26 UTC 2013 ..=
=2E

> I could not yet test the patches with the newest kernel sources
>    linux-3.12.1
> but the differences in file c_can.c are quite small and pertain only to=

> the control of a CAN-BUS activity LED.
>=20
> If you will accept patches only for the newest kernel sources, please
> drop me a line and I will try to test with newest sources.
>=20
> Best Regards
> Holger Bechtold
>=20
> ---------- patch 1 description ----------------------------------------=
-------
>=20
> The for-loop cycling through the message objects forming the reception =
FIFO
> was left prematurely when it reached the last object (marked IF_MCONT_E=
OB).
> If a received message was stored in this object, it was not handled
> properly, leaving the IF_MCONT_INTPND condition pending. This led to a
> processor deadlock and a kernel panic.

This issue has been fixed by Markus Pargmann and is already upstream in

    5d0f801 can: c_can: Fix RX message handling, handle lost message
before EOB

Which is included in v3.13-rc1~175^2~1^2~1, this means v3.13-rc1 was the
first release containing this patch. It's not in v3.12.1 and wasn't
queued for -stable (i.e. v3.12.2) yet, but should be. I've triggered
David about the status of the patch.

[...]

> ---------- patch 2 description ----------------------------------------=
-------
>=20
> The number of bytes transmitted was not updated correctly. Thus program=
s
> like 'ifconfig' showed wrong transmit byte counts.
>=20
> ---------- patch 2 ----------------------------------------------------=
-------
>=20
> --- drivers/net/can/c_can/c_can.c.orig	2013-11-20 16:57:44.655806758 +0=
100
> +++ drivers/net/can/c_can/c_can.c	2013-11-20 17:06:31.915937041 +0100
> @@ -749,11 +749,8 @@ static void c_can_do_tx(struct net_devic
>  		msg_obj_no =3D get_tx_echo_msg_obj(priv);
>  		val =3D c_can_read_reg32(priv, C_CAN_TXRQST1_REG);
>  		if (!(val & (1 << (msg_obj_no - 1)))) {
> -			can_get_echo_skb(dev,
> -					msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
> -			stats->tx_bytes +=3D priv->read_reg(priv,
> -					C_CAN_IFACE(MSGCTRL_REG, 0))
> -					& IF_MCONT_DLC_MASK;
> +			stats->tx_bytes +=3D can_get_echo_skb(dev, msg_obj_no -
> +				C_CAN_MSG_OBJ_TX_FIRST);

There is a problem with the return value of can_get_echo_skb(), I will
return 0 if the echoing has been switched off. However the flexcan
driver uses this function, too. Maybe it's time to cleanup the echo
handling a bit.

What's wrong with reading the number of bytes from the hardware? Can you
fix the read instead? (Or even better, fix the echoing :)

>  			stats->tx_packets++;
>  			c_can_inval_msg_object(dev, 0, msg_obj_no);
>  		} else {
>=20
> -----------------------------------------------------------------------=
-------
>=20
> Signed-off-by: Holger Bechtold <Holger.Bechtold@gmx.net>

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lvpJCQguVEWpRjfIxQCeEJeRdwuiNS0nt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKSfEUACgkQjTAFq1RaXHMTswCeJG0gOzUHDjaxk8j4mhBJbrPQ
zZoAoI4Zjh72xVbJrYtSI66fy8ukto9q
=Boj7
-----END PGP SIGNATURE-----

--lvpJCQguVEWpRjfIxQCeEJeRdwuiNS0nt--
