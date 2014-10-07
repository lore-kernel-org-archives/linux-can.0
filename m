From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC PATCH 1/2] can: rx-fifo: Increase MB size limit from 32
 to 64
Date: Tue, 07 Oct 2014 16:18:13 +0200
Message-ID: <5433F625.7020904@pengutronix.de>
References: <20141006131751.75823c82@archvile>	<1412674205-23882-1-git-send-email-david@protonic.nl>	<5433E7E0.4050007@pengutronix.de> <20141007152757.405ea6ab@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EElRGoeD0WA0SXNRPQaIicR0eJMOqgXUD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46300 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822AbaJGOSS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Oct 2014 10:18:18 -0400
In-Reply-To: <20141007152757.405ea6ab@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EElRGoeD0WA0SXNRPQaIicR0eJMOqgXUD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/07/2014 03:27 PM, David Jander wrote:
>> Applied to the rx-fifo branch. I can rebase the branch if you need e.g=
=2E
>> v3.17....
>=20
> Uh-oh! I meant to have comments on the idea more than apply immediately=
=2E.. I
> thought a cautious "RFC" in the subject would do that ;-)

No problem. Pushed the old code.

> Never mind, there are still some bugs in that patch.... the
> can_rx_fifo_mask_*() functions contain some 0U constants that need to c=
hange
> to 0LLU. I think it is better you drop the current version for now...
> I am currently debugging a new version of flexcan that uses these two p=
atches,
> to see if it works, but I'd like to have your (and other people's) opin=
ion on
> this whole idea before going too far into that direction...

The general code looks good. I'm not sure if you/we should take care of
CAN-fd support for the rx-fifo yet. I think we should wait until we have
a CAN-fd device without a proper hardware fifo.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--EElRGoeD0WA0SXNRPQaIicR0eJMOqgXUD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQz9iUACgkQjTAFq1RaXHMw2QCfbSfn3prfiFOTL6zkX2v/9xMp
Hk8AoJGTLYkeICHTVke2DYJbnI1mlF9A
=cDsx
-----END PGP SIGNATURE-----

--EElRGoeD0WA0SXNRPQaIicR0eJMOqgXUD--
