From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: About peak_pci PATH v6.1
Date: Mon, 20 Feb 2012 13:18:54 +0100
Message-ID: <4F423A2E.3030806@pengutronix.de>
References: <4F422DA4.1080703@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7FC5C6B5CEA9FA0866F70550"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51622 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab2BTMS7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Feb 2012 07:18:59 -0500
In-Reply-To: <4F422DA4.1080703@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7FC5C6B5CEA9FA0866F70550
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/20/2012 12:25 PM, Stephane Grosjean wrote:
> I found that the i2c_transfer() is able to sleep, which is generally
> *not* a good idea when in an interrupt context...

Not allowed :)

> So, I changed the delay management with a delayed work mechanism. I
> successfully tested the change on my testbed, but as you know, this is
> not the best place for testing...

> I hope you will be able to find some time to test that new patch.
>=20
> @Marc: the peak_pci and peak_pcmcia patches bring modifications to the
> can/sja1000 dir Kconfig and Makefile, So the apply sequence order is
> critical (I mean, the peak_pci patch must be applied before the
> peak_pcmcia, because of lines numbers). How to fix that? I first
> proposed to use a serie of patches but this was not approved...

I think due to my too short answer there was a misunderstanding. IIRC in
one patch you 1. fixed a problem (which is already in mainline) and 2.
introduced a new feature. This is why I asked for separate patches. All
changes can still go into a series.

I already added your "add support for PEAK-System PCIe/PCIeC/miniPCI
cards" patch to can-next/master, but If you now have a better version,
I'll force update the branch.

I just updated can-next/master, so that it doesn't include your patch.
Now it get complicated :) In order to test the patches you need Olivers
unplug fix patch, I send it to David today, and it's not part of
can-next, yet. For easy testing, I merged linux-can into linux-can-next,
the branch is called "with-can-merge" in the linux-can-next repo. Please
make your patch series based on that branch, I'll apply it to
linux-can-next/master and ask David to merge net into net-next first, in
case he hasn't.

Back to your question. Yes, please give us a series of patches, even if
its PCI and USB drivers.

I hope you understand what I mean ;)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig7FC5C6B5CEA9FA0866F70550
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9COjEACgkQjTAFq1RaXHNtogCeL8+kBKYdw3Ig+7Xh+sRSDCqe
oEsAnR6Nwq2i2DT2vsxBSiKvsIJoN279
=rB5u
-----END PGP SIGNATURE-----

--------------enig7FC5C6B5CEA9FA0866F70550--
