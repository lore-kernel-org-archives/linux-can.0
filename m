From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/5 resend] can: various fixes to xilinx_can driver
Date: Thu, 8 Feb 2018 15:28:27 +0100
Message-ID: <e3bb96a4-810e-9591-4193-dbbc45a93a8b@pengutronix.de>
References: <20180126142723.3212-1-anssi.hannula@bitwise.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0PaPMjd6uScW57MzTWaIIzRJXbwUSe2YB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34657 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbeBHO3I (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Feb 2018 09:29:08 -0500
In-Reply-To: <20180126142723.3212-1-anssi.hannula@bitwise.fi>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Anssi Hannula <anssi.hannula@bitwise.fi>, linux-can@vger.kernel.org
Cc: Michal Simek <michal.simek@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0PaPMjd6uScW57MzTWaIIzRJXbwUSe2YB
Content-Type: multipart/mixed; boundary="DLqLxAfz0sDToiDkmy0Z449Rzv1jGBy23";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Anssi Hannula <anssi.hannula@bitwise.fi>, linux-can@vger.kernel.org
Cc: Michal Simek <michal.simek@xilinx.com>
Message-ID: <e3bb96a4-810e-9591-4193-dbbc45a93a8b@pengutronix.de>
Subject: Re: [PATCH 0/5 resend] can: various fixes to xilinx_can driver
References: <20180126142723.3212-1-anssi.hannula@bitwise.fi>
In-Reply-To: <20180126142723.3212-1-anssi.hannula@bitwise.fi>

--DLqLxAfz0sDToiDkmy0Z449Rzv1jGBy23
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 03:27 PM, Anssi Hannula wrote:
> Hi all,
>=20
> I submitted a few bugfixes in Feb 2017 ("can: various fixes to
> xilinx_can driver") but they were not applied, so here they are again.
>=20
> I seem to have missed CCing Michal Simek (the maintainer per
> MAINTAINERS) last time, but I've included him in the loop now so he can=

> comment.
>=20
> The last patch saw several revisions after comments from Marc, the one =
here
> is the same as the last version posted back then.
>=20
> I've rebased them on top of linux-can/master and tested on Zynq-7000 HW=
=2E

I've taken patches 1-3 to linux-can. Patches 3, 4, [PATCH v2] can:
xilinx_can: use can_change_state(), 5 to linux-can-next.

Once net/master will be merged to net-next/master, patch 3 will fall
away and I'll send a pull reqeust upstream.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DLqLxAfz0sDToiDkmy0Z449Rzv1jGBy23--

--0PaPMjd6uScW57MzTWaIIzRJXbwUSe2YB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlp8XosACgkQk9IU1zQo
ZfHG+ggAozoDuuNmkQfngMzGsJ0KWC39IS6z6ZtkUhscYAG7gBNw2Uw3bbPe+M+6
zUq+RPdnBj+W3j6Es93NkRIJbjVdD/ZTca0hg3EZvsUUHks3HvprRmFEUrki4ggu
aGR0IKemSjtN+h5R/HY4KxuyzvU7cFWMnsXVqT9+oPT9nG/FEzLXqmb4NfdccNf5
/1ND1cMbg1h6SOD1c2DXUasT8QlRJzkD7RLtJnRvmSwCM07Fyz29g7y9RQ1Xp869
uZjLh1GhajF9FQC3UZ2SVK7IpTegoLFKGY7UWDOc868CnnKI55qeCEFTStEIhq0i
SMht4aGAr977Tw3FzOVHZ3bsc3xsYQ==
=RX+e
-----END PGP SIGNATURE-----

--0PaPMjd6uScW57MzTWaIIzRJXbwUSe2YB--
