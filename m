From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/4] can: flexcan: Disable error irq when in error passive
Date: Thu, 14 Aug 2014 13:18:47 +0200
Message-ID: <53EC9B17.80600@pengutronix.de>
References: <1407850987-26707-1-git-send-email-alexander.stein@systec-electronic.com> <1407850987-26707-4-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="I7j3h53gVcsopNFCtnES1Luut3BwKcH4H"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45073 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbaHNLSx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Aug 2014 07:18:53 -0400
In-Reply-To: <1407850987-26707-4-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I7j3h53gVcsopNFCtnES1Luut3BwKcH4H
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/12/2014 03:43 PM, Alexander Stein wrote:
> If the error irq is enabled and the hardware is trying to send a CAN
> message to an open bus it will receive a lot of acknowledge errors and
> generating lots of interrupts. So error interrupts are disabled when
> entering error passive and reenable them when leaving error passive.
> We can only leave error passive by receiving CAN frames in which case N=
API
> is scheduled anyway or by sending more CAN frames when send is possible=

> again. But with the transition of error counters from 96 to 95 the flag=
s
> TX_WRN and RX_WRN are gone again, so we need to remember the flags stat=
e
> to detect a change there.

There are use cases where the error interrupts even when in passive mode
are essential. You have a use case, where you'd like to turn them off
completely. Have you had a look at the bus error limiting patches?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--I7j3h53gVcsopNFCtnES1Luut3BwKcH4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlPsmxcACgkQjTAFq1RaXHMAQQCcC+OQoAWNQIHHJdVWqHTq3F0k
36AAn1CAT1uzGPODahtxbANjyzRxGMdJ
=iIIB
-----END PGP SIGNATURE-----

--I7j3h53gVcsopNFCtnES1Luut3BwKcH4H--
