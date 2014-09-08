From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Inconsistent error state transition error frames
Date: Mon, 08 Sep 2014 18:36:38 +0200
Message-ID: <540DDB16.8010304@pengutronix.de>
References: <7EAA3DE6DC6BA14D830C95541CC66EBC9F72FED6@GRBSR0004.marel.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="580W6woxxOke813SlU62SIsrSa84OdjLJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42940 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbaIHQgp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Sep 2014 12:36:45 -0400
In-Reply-To: <7EAA3DE6DC6BA14D830C95541CC66EBC9F72FED6@GRBSR0004.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <Andri.Yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--580W6woxxOke813SlU62SIsrSa84OdjLJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/08/2014 06:26 PM, Andri Yngvason wrote:
> I've been working on a userspace program to monitor the CAN bus and I
> found that it only works as expected on one platform (flexcan). The
> problem is that on most other platforms, no error frame is emitted
> when the controller transitions back to error-active state. I see
> that you've already discussed this on this list here:
> http://thread.gmane.org/gmane.linux.can/201
>
> Why hasn't this been resolved?

I assume no one needed this feature so far, I assume. And/or cared not
enough to upstream these patches.

> I already patched the mscan and sja1000 drivers myself, and I was
> considering submitting them, but since you've already done some work
> on this (which I believe is superior to mine), my work is unlikely to

Wolfgang mentioned in this mail, that he had some patches back than. Do
you still have them, Wolfgang?

> be of any consequence to this community, except to show that this
> inconsistency does indeed result in wasted effort and frustration.

Feel free to post your patches.

> Of course, I'll help out if I can, e.g. by testing on the platforms
> that I have available.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--580W6woxxOke813SlU62SIsrSa84OdjLJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQN2xYACgkQjTAFq1RaXHM/NQCgiCIUBM9jFfbVAp67921CeY/3
B44AoIZrhpmN/83GpPrxJZaWpOemiv8G
=Adkn
-----END PGP SIGNATURE-----

--580W6woxxOke813SlU62SIsrSa84OdjLJ--
