From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] peak_pci: fix use after free in netdev teardown
Date: Mon, 19 May 2014 09:11:08 +0200
Message-ID: <5379AE8C.9050406@pengutronix.de>
References: <1397072720.22713.19.camel@acrs-z800-1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UnVchWh0MacMAQ8kLD1c5q98cPvKtVAvE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47882 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbaESHLk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 May 2014 03:11:40 -0400
In-Reply-To: <1397072720.22713.19.camel@acrs-z800-1>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UnVchWh0MacMAQ8kLD1c5q98cPvKtVAvE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/09/2014 09:45 PM, Christopher R. Baker wrote:
> Hi All,
>=20
> In the course of tracking down (and eventually backporting) a fix to on=
e
> of my systems that is still running a 3.2 kernel, I noticed what I
> believe to be a pair of use-after-free bugs in peak_pci.c pertaining to=

> the linked list of netdevs that is maintained for multi-port cards.
> These bugs persist in 3.14, so I thought I should send along a patch fo=
r
> review.
>=20
> Basically, the "prev_dev" pointer that is used for this list lives in
> memory that is allocated by alloc_sja1000dev(), but it is referenced
> after the call to free_sja1000dev() when walking the list during
> teardown, both in the failure case of peak_pci_probe and in
> peak_pci_remove.  Unless I'm missing something, these are toes waiting
> to be stubbed...
>=20
> Caveats:
>  - This is a growing blob of copy-pasta that should probably be
> refactored to a common location.  For example, peak_pci_remove could be=

> restructured to incrementally check and free allocated resources,
> allowing the "failure_remove_channels" label to delegate the cleanup to=

> peak_pci_remove.  I didn't want to bite off too much this time, though,=

> so I left that alone.
>  - I don't have an expresscard adapter to check the placement of the
> pciec_remove stanzas.  By inspection, unregister_sja1000dev does not
> appear to have a path back to the pciec stuff, but I may have missed
> something.
>=20
> -ChrisR
>=20
> Signed-of-by: Christopher R. Baker <cbaker@rec.ri.cmu.edu>

Stephane, can you please have a look at the patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--UnVchWh0MacMAQ8kLD1c5q98cPvKtVAvE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlN5ro0ACgkQjTAFq1RaXHOUyQCghzru3tQmQiAedHHC/N1U/EOd
grkAn0sDwX6h+rpFaYDAoApRMIPpibjN
=HrYG
-----END PGP SIGNATURE-----

--UnVchWh0MacMAQ8kLD1c5q98cPvKtVAvE--
