From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Thu, 06 Dec 2012 15:23:27 +0100
Message-ID: <50C0AA5F.5070305@pengutronix.de>
References: <loom.20121114T160521-534@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or  g> <loom.20121121T162041-774@p  ost.gmane.org> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305 @grandegger.com> <loom.20121121T184014-391@post.gmane.org> <50AD319E.2000209@grandegger.com> <loom.20121121T215717-10 6@post.gmane.org> <loom.20121123T150627-133@post.gmane.org> <50AF8C01.6060 809@grandegger.com> <loom.20121123T155746-12@post.gmane.org> <50AFABB1.7080 507@grandegger.com> <50AFAFF0.9030706@grandegger.com> <loom.20121123T184133-638@post.gmane.org> <50B2449B.806  0708@grandegger.com> <loom.20121126T154645-335@post.gmane.org> <50B38AFB.70209@grandegger.com> <loom.20121126T181452
 -657@post.gmane.org> <50B3B162.9020905@grandegger.com> <50B751D7.6060106@grandeg ger.com> <loom.20121129T150945-987@post.gmane.org> <loom.20121206T150229-86@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6D9C5E73B3FACED74F15A68B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45456 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932710Ab2LFOX3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 09:23:29 -0500
In-Reply-To: <loom.20121206T150229-86@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D9C5E73B3FACED74F15A68B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/06/2012 03:20 PM, Michael Pellegrini wrote:
> Michael Pellegrini <mikep86 <at> gmail.com> writes:
>=20
>>> I have implemented a better solution now using different sets of
>>> registers for tx and rx. This avoids locking in the RX path as well.
>>> Furthermore, pch_can now uses spin_[un]lock_bh. Would be nice if you
>>> could give the pch_can and c_can_pci driver a try when time permits.
>>
>> Great! I'm happy to test these drivers out.  In addition to testing
>> these drivers through my application, I'm looking at creating a soak t=
est to
>> really push the interface (and the driver) hard.  That test will proba=
bly be
>> ready early next week.  I will get back to you with the results.
>=20
> I have some results. =20
>=20
> The good news: The c_can driver appears to work very well.  It has been=
 running
> successfully under the soak test for 18 hours and counting.
>=20
> The bad news: The pch_can driver is exhibiting the transmission problem=
 again.
> The soak test causes the driver to fail within minutes.

We want to kick the pch_can driver anyways.

> Details of the soak test:
>=20
> There are two systems involved in the test: the PCH-System and an Exter=
nal Node.
> The External Node transmits data at a high rate, bringing bus utilizati=
on to
> ~35%.
> The PCH-System also transmits data, in bursts of 10 messages every 5 ms=
=2E
> Combined, the two systems utilize ~90% of bus bandwidth.
> The PCH-System is constantly checking that it is receiving data from th=
e
> External Node at the expected rate and in the expected order.

Which patches do you have applied to the c_can driver?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig6D9C5E73B3FACED74F15A68B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDAql8ACgkQjTAFq1RaXHOoOwCfXrypAwTcI8ua1pJFVRFc5VWg
JhIAoIH7GsaXGMAo4aPSTweqhJMsnB17
=YHSc
-----END PGP SIGNATURE-----

--------------enig6D9C5E73B3FACED74F15A68B--
