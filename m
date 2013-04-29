From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: flexcan driver: tx_bytes counter never incremented when CAN_RAW_LOOPBACK
 removed?
Date: Mon, 29 Apr 2013 12:53:20 +0200
Message-ID: <517E5120.70600@pengutronix.de>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com> <517A968D.20508@pengutronix.de> <CAJW3KNWrdhvXyEA3jmkx+eobH34_g5noykZpyL0YaWjrm1qbLA@mail.gmail.com> <20130426205150.GA28450@thinkoso.home> <517E26E4.8010003@pengutronix.de> <517E4E01.3080705@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2UPELSTPOMGBQARQWBTHS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42530 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab3D2Kx1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Apr 2013 06:53:27 -0400
In-Reply-To: <517E4E01.3080705@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2UPELSTPOMGBQARQWBTHS
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/29/2013 12:40 PM, Stephane Grosjean wrote:
> Hi Marc,
>=20
> Playing with the flexcan driver, I've seen that the tx_bytes counter
> always equals 0 while tx_packets increases.
> I simply removed the CAN_RAW_LOOPBACK option from my CAN socket, so I
> suppose that:
>=20
> stats->tx_bytes +=3D can_get_echo_skb(dev, 0);
>=20
> doesn't do what it should.
> Am I wrong?

Let me see. Yes you're right. can_put_echo_skb() only queues the CAN
frame if CAN_RAW_LOOPBACK is set.

We either can change that can_put_echo_skb() always queues the CAN frame
or that can_get_echo_skb() returns the correct number of bytes even if
the CAN frame is not queued or put the mechanism in each driver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2UPELSTPOMGBQARQWBTHS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF+USQACgkQjTAFq1RaXHNPOQCgj/HKHLJAp/uupC18st7D0iR6
FgkAniy5AMEDbp6JlJm57S0N6cZ1EpkG
=oJKB
-----END PGP SIGNATURE-----

------enig2UPELSTPOMGBQARQWBTHS--
