From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can: flexcan.c: Re-write receive path to use MB queue
 instead of FIFO
Date: Tue, 02 Sep 2014 13:30:24 +0200
Message-ID: <5405AA50.6040100@pengutronix.de>
References: <1409133487-23367-1-git-send-email-david@protonic.nl> <1409133487-23367-3-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GmBQEslspWiCVHXR3A6VuUw32BV7qkXpO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36545 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaIBLa0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 07:30:26 -0400
In-Reply-To: <1409133487-23367-3-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>, wg@grandegger.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GmBQEslspWiCVHXR3A6VuUw32BV7qkXpO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/27/2014 11:58 AM, David Jander wrote:
> The FlexCAN controller has a RX FIFO that is only 6 messages deep, and =
a
> mailbox space capable of holding up to 63 messages.
> This space was largely unused, limiting the permissible latency from
> interrupt to NAPI to only 6 messages. This patch uses all available MBs=

> for message reception and frees the MBs in the IRQ handler to greatly
> decrease the likelihood of receive overruns.

What about the order of the incoming CAN frames? Is it still preserved?

You make use of the CTRL2 register, which is not present on some older
(but supported) flexcan IP cores. You increase FLEXCAN_MCR_MAXMB to
0x40, which is not supported on older IPs. The register rximr, is also
not present on older cores. Don't break support for the older CAN cores.

Please make this patch based on linux-can-next/master (which holds some
updates to the regs structure).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--GmBQEslspWiCVHXR3A6VuUw32BV7qkXpO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQFqlAACgkQjTAFq1RaXHMI1ACfYXMgRvU8eJ64ra4HtEq/iQhg
m9oAnjp767beu+YwQiIDnv9oUmRGL1nC
=5KiN
-----END PGP SIGNATURE-----

--GmBQEslspWiCVHXR3A6VuUw32BV7qkXpO--
