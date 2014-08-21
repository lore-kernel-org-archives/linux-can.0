From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/1] net: can: sja1000: Validate initialization state
 in start method
Date: Thu, 21 Aug 2014 11:26:46 +0200
Message-ID: <53F5BB56.5060006@pengutronix.de>
References: <1407501050-16156-1-git-send-email-mirza.krak@hostmobility.com> <53EC8CD8.2040703@pengutronix.de> <53F5B184.4050907@hostmobility.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xfuqjJbhO0pkK3ExXNcWvi3JfTfq9TJj3"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42744 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbaHUJ0x (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 21 Aug 2014 05:26:53 -0400
In-Reply-To: <53F5B184.4050907@hostmobility.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@hostmobility.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xfuqjJbhO0pkK3ExXNcWvi3JfTfq9TJj3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/21/2014 10:44 AM, Mirza Krak wrote:
[...]

>>> This patch adds a check in sja1000_start if the chip is initialized, =
if
>>> not we initialize it.
>> Applied to can.

> I am sorry but applied to what? I haven't seen it been applied anywhere=

> when browsing linux-can on gitorious.

Until 5 minutes ago, it was on my hard drive only :D
But now it's included in the pull request I send to David, you can find
it on gitorious under the tag linux-can-fixes-for-3.17-20140821.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xfuqjJbhO0pkK3ExXNcWvi3JfTfq9TJj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlP1u1YACgkQjTAFq1RaXHNbWgCfT73ZBZVwQou2w7Qo0M2U3YRW
I1wAnjTkA0nXv8PFEYWbavND3OigJwds
=I9wT
-----END PGP SIGNATURE-----

--xfuqjJbhO0pkK3ExXNcWvi3JfTfq9TJj3--
