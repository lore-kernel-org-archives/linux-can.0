From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: API to support hardware priorities
Date: Mon, 9 Nov 2015 16:38:09 +0100
Message-ID: <5640BDE1.7060508@pengutronix.de>
References: <20151109123618.41ad1bae@mitra> <5640A065.2000401@pengutronix.de>
 <5640A4E4.6020005@pengutronix.de> <20151109162703.3fd6d4fc@mitra>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="mBBV9rnKtg4m9mcuI0VmdMHtvqbjLr0wL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47427 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbbKIPiT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Nov 2015 10:38:19 -0500
In-Reply-To: <20151109162703.3fd6d4fc@mitra>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mBBV9rnKtg4m9mcuI0VmdMHtvqbjLr0wL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/2015 04:27 PM, Benedikt Spranger wrote:
>> Do you mean the mailbox feature, where you queue a frame into
>> hardware, but sending is delayed until a certain CAN-ID is RX'ed?
> No.
> The C-CAN/D-CAN and some other Controller can be configured to have
> mailboxes for a certain Id. For example you can configure MBX 1 for
> Id 23, MBX 2 for Id 42 and 3-7 act as FIFO. So every packet matching Id=

> 23 should queued up to MBX 1, every package matching Id 42 to MBX 2 and=

> all other Packages to the FIFO.

OK, I was not aware of that feature. I'll have a look to the datasheets.
What's the benefit of associating a mailbox to a specific ID in the
hardware?

> Having a multiqueue TX part may help but may have some drawbacks. If th=
e
> FIFO (or an other queue) is full the driver calls netif_stop_queue().

In this scenario there will be two netif_queues per CAN driver....

> Sending bulk data can block out a "high priority" Package. On the other=

> hand a application writing bulk data in blocking mode should not
> receive a EAGAIN and not be punished by a "mixed up" queue i.e.
> violating the package send order.

=2E..one serving the bulk hardware FIFO and one serving the high prio HW
queue.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--mBBV9rnKtg4m9mcuI0VmdMHtvqbjLr0wL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWQL3hAAoJEP5prqPJtc/HziUH/1fGxp/Y3mKgE6CYBBhmcxtr
CXBZWKHk5dCDMB4xsSuj2dtfbFZXd2eovrcTx5B0V59BAqqpfs/Q6Ko/kc2/1dGu
+rZk9iVAqGkOTFngpgpzPc3RXVwRxflkcDLFl1qZJBrLDVHMY5ypLaFcLSSC4LFa
asZNm+TIAsI9PUEPWyuqe5c9RDD1VV5rtadzvIZjSbyKjru/ipDr7WwtMC2z/0Xk
S9fRgS5OwRUancyOGhUf4HO952Af8XxAb3X++XZ/Q4MeLelaMEele03fU+pRhbwW
HUBfeiAJGH7Rh5guXo6aMtU9hpKevG44z0OzocrIIaDoSMF0QE00bULqvUrkalY=
=Lt8t
-----END PGP SIGNATURE-----

--mBBV9rnKtg4m9mcuI0VmdMHtvqbjLr0wL--
