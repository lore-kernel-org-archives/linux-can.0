From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH] can: migrate documentation to restructured text
Date: Wed, 24 Jan 2018 12:56:58 +0100
Message-ID: <20180124115658.uress2uqtif6eeeu@pengutronix.de>
References: <20180124101911.18006-1-r.schwebel@pengutronix.de>
 <4dfbb289-1acf-403d-43f8-d13ee4ac931b@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="o6q7oxe6bdmx6jpp"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46719 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933416AbeAXL5B (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Jan 2018 06:57:01 -0500
Content-Disposition: inline
In-Reply-To: <4dfbb289-1acf-403d-43f8-d13ee4ac931b@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, linux-doc@vger.kernel.org


--o6q7oxe6bdmx6jpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 12:50:20PM +0100, Marc Kleine-Budde wrote:
> On 01/24/2018 11:19 AM, Robert Schwebel wrote:
> > The kernel documentation is now restructured text. Convert the SocketCAN
> > documentation and include it in the toplevel kernel documentation.
> >=20
> > This patch doesn't do any content change.
> >=20
> > All references to can.txt in the code are converted to can.rst.
> >=20
> > Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
>=20
> This fails to apply on next-next/master. v4.15-rc7 was working though
> and git rebase did the work. Use net-next/master as a base in the future.

Thanks, will do.

rsc=20
--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--o6q7oxe6bdmx6jpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQTgfk2nRbrlyHaVRT7zP4gqAOHIAUCWmh0gAAKCRD7zP4gqAOH
IFzjAJ9qUPkchVwp4SmB7uuNy9m430F3tACeIMHJUGpAHQz5nwgpluPjLpQSUMs=
=/MSL
-----END PGP SIGNATURE-----

--o6q7oxe6bdmx6jpp--
