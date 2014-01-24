From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: BUG? candump -x and non CANFD frames
Date: Fri, 24 Jan 2014 15:14:36 +0100
Message-ID: <52E2754C.9020204@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="r9fKeJOHc55Fh3g7TiStHOmnXnolhwm3d"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41435 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbaAXOOm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 24 Jan 2014 09:14:42 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r9fKeJOHc55Fh3g7TiStHOmnXnolhwm3d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I'm running "candump -x any,0:0,#FFFFFFFF" on standard CAN hardware and
I see this output:

  can0  RX - -  222   [7]  00 00 00 00 00 00 00
  can0  TX - E  111   [1]  00

The "E" should not be there, as it only makes sense for CANFD frames, as
it's derived from the "flags" member of the canfd_frame.

>  68 struct can_frame {
>  69         canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>  70         __u8    can_dlc; /* frame payload length in byte (0 .. CAN_=
MAX_DLEN) */
>  71         __u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
>  72 };

> 102 struct canfd_frame {
> 103         canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
> 104         __u8    len;     /* frame payload length in byte */
> 105         __u8    flags;   /* additional flags for CAN FD */
> 106         __u8    __res0;  /* reserved / padding */
> 107         __u8    __res1;  /* reserved / padding */
> 108         __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
> 109 };

As the software is big and proprietary, I cannot look at the code, if
the unused 3 bytes in the can_frame are filled with zeros or not. At
first sight all TX'ed frames have the E flag set.

What's the correct fix?

Do we have to fix something in the kernel, is there a possible
information leak of 3 bytes of kernel memory for TX'ed frames? Or only a
cross application information leakage?

Another possible solution is to only print the flags member if we
actually have received CANFD frames.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--r9fKeJOHc55Fh3g7TiStHOmnXnolhwm3d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLidUwACgkQjTAFq1RaXHO+mwCfZXpH8bSo3YzoRJ7U3Ua/JOH8
mGsAn2S/tXjCE4/lt3seth6gPDDcQjRS
=1iVb
-----END PGP SIGNATURE-----

--r9fKeJOHc55Fh3g7TiStHOmnXnolhwm3d--
