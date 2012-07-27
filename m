From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH iproute2 v2 0/3] CAN Filter/Classifier
Date: Fri, 27 Jul 2012 18:42:52 +0200
Message-ID: <5012C50C.5010104@pengutronix.de>
References: <1343383363-6174-1-git-send-email-mkl@pengutronix.de>  <50129E17.7030602@hartkopp.net> <1343398165.12164.3.camel@lolumad> <5012C366.7060504@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8A9B9D3EF74D35CE672B0459"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33653 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab2G0Qm7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Jul 2012 12:42:59 -0400
In-Reply-To: <5012C366.7060504@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Rostislav Lisovy <lisovy@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8A9B9D3EF74D35CE672B0459
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=2E..cleaning up Cc a bit...

On 07/27/2012 06:35 PM, Oliver Hartkopp wrote:
[...]
>> Hello Oliver;
>> You are right -- these are the patches for the old "standalone can
>> filter/classifier" implementation.
>> I will send correct patches hopefully on Monday/Tuesday.

> No hurry.

> I will not have the time next week to check out and test your patches.
> But i would like to do so :-)

I have a test candidate for your patches here, too :) For now I've
squashed and rebased you repo to the v3.4.0 iproute2 repo. I'll
integrate your official patches as soon as I have them.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8A9B9D3EF74D35CE672B0459
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlASxRAACgkQjTAFq1RaXHNG4QCfSzAkFazkpFVxnrgPc9QGvJCy
DCYAn3NIiRRf0UxJufwW1l7hx9fOZTqc
=qobY
-----END PGP SIGNATURE-----

--------------enig8A9B9D3EF74D35CE672B0459--
