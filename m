From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Support of MCP2515 and AM35x High-End CAN controller in (RT-)SocketCAN
Date: Wed, 02 May 2012 10:07:58 +0200
Message-ID: <4FA0EB5E.6060205@pengutronix.de>
References: <CAKG=6c5jafRAGjeQscTKLQbSjPFp7UJYwhhcpOS2QoNvy7Cggw@mail.gmail.com> <CAKG=6c4wMX4ZWFKAxN81-Rnf07wG1vqL96q0e78oe+VjsLSNrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBC81843755C4520C7EFA6E1A"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49949 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab2EBJ3i (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 May 2012 05:29:38 -0400
In-Reply-To: <CAKG=6c4wMX4ZWFKAxN81-Rnf07wG1vqL96q0e78oe+VjsLSNrA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marcus Liebhardt <marcus.liebhardt@yujinrobot.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC81843755C4520C7EFA6E1A
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: quoted-printable

On 05/02/2012 09:51 AM, Marcus Liebhardt wrote:
> Hi everybody!
>=20
> Looking for a low-cost solution for a real-time Linux system with CAN
> bus support, I am currently considering the Beaglebone [1] (similar to
> the Beagleboard) with the addition of a CAN bus cape [2]. The later
> provides two MCP2515 CAN controller and also allows the use of the
> integrated CAN controller [3] of the Beaglebone's ARM microprocessor
> (Cortex A8) .

Don't use mcp2515, you won't have any fun with it. Consider using a SoC
with an integrated CAN controller, like the freescale i.mx family or one
of the TIs with an integrated (and supported) CAN cores.

> I am thinking about using a Linux kernel plus the RT-patch
> (CONFIG_PREEMPT_RT), since it seems to be less work then setting up
> Xenomai and the MCP2515 is already supported by SocketCAN. However, I
> am not sure, if this set-up will satisfy our real-time constraints,
> since SocketCAN is not real-time safe. Furthermore, I couldn't find
> information about working solutions of patched Linux kernels on the
> Beaglebord besides this paper [4].
> Hence, I am also looking into the option of using Xenomai on the
> Beaglebone for which I found working examples, such as [4]. However,
> according to this list [5] the MCP2515 is not supported by
> RTcan/RT-SocketCAN. Is this still true?

If you have realtime contraints, do with mainline Linux + PREEMPT_RT and
use a proper CAN controller.

> Furthermore, is there support for the integrated CAN controller (AM35x
> HECC) in SocketCAN and/or RT-SocketCAN?

The Kconfig says that the TI HECC is supported.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigBC81843755C4520C7EFA6E1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+g62QACgkQjTAFq1RaXHMx0ACeKl5qz+xAM68bezu6SQm2GTpA
lR8AmQFjr0ggn9IGCutQSMYoXVgqW/eh
=ucIg
-----END PGP SIGNATURE-----

--------------enigBC81843755C4520C7EFA6E1A--
