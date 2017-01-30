From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: fix hrtimer/tasklet termination in bcm op removal
Date: Mon, 30 Jan 2017 11:06:35 +0100
Message-ID: <6bedda8d-eb0c-b382-4e34-cb910bd20f2d@pengutronix.de>
References: <20170118203051.16192-1-socketcan@hartkopp.net>
 <7ded2bd2-45af-e4e1-63d9-e9959d8db2e3@web.de>
 <00fddc03-13c7-cf6e-0b90-04aea7fe645f@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ig2abS8lOLh3eXW6d2ow0EJbDvkdNDJ6u"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58105 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752360AbdA3KqW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Jan 2017 05:46:22 -0500
In-Reply-To: <00fddc03-13c7-cf6e-0b90-04aea7fe645f@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Michael Josenhans <michael.josenhans@web.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ig2abS8lOLh3eXW6d2ow0EJbDvkdNDJ6u
Content-Type: multipart/mixed; boundary="Bp7FiOqqgrqh2sRJA9aAXU6U0lFLkSau7";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Michael Josenhans <michael.josenhans@web.de>
Cc: linux-can@vger.kernel.org
Message-ID: <6bedda8d-eb0c-b382-4e34-cb910bd20f2d@pengutronix.de>
Subject: Re: [PATCH] can: fix hrtimer/tasklet termination in bcm op removal
References: <20170118203051.16192-1-socketcan@hartkopp.net>
 <7ded2bd2-45af-e4e1-63d9-e9959d8db2e3@web.de>
 <00fddc03-13c7-cf6e-0b90-04aea7fe645f@hartkopp.net>
In-Reply-To: <00fddc03-13c7-cf6e-0b90-04aea7fe645f@hartkopp.net>

--Bp7FiOqqgrqh2sRJA9aAXU6U0lFLkSau7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/28/2017 06:25 PM, Oliver Hartkopp wrote:
> On 01/28/2017 05:42 PM, Michael Josenhans wrote:
>=20
>> When removing a bcm tx operation either a hrtimer or a tasklet might r=
un.
>> As the hrtimer triggers its associated tasklet and vice versa we need =
to
>> take care to mutually terminate both handlers.
>>
>> Reported-by: Michael Josenhans <michael.josenhans@web.de>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Tested-by: Michael Josenhans <michael.josenhans@web.de>
>=20
> Thanks for testing!
>=20
> @Marc: This is a candidate for stable too.

added to can.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Bp7FiOqqgrqh2sRJA9aAXU6U0lFLkSau7--

--ig2abS8lOLh3eXW6d2ow0EJbDvkdNDJ6u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAliPECsACgkQPTuqJayp
JWopOwf9EfIPV9C6eoIDgn/IRNGFJQfFLBiqg9/InLMvOa67OL+/QzjPnHt6Wa9S
9ATLTqHdMowjksdEjL4Ek2JplSE9ciUkgbfDMLtTBiWrCYYyDfZiOMyapsfrj8qI
ntJHnIQJ/hFSUfZrEWuWNiiCvG0xJ6gpRWVlOdJwvEgWh7Sj6W0QtEp74wk1G7qW
OPnyiPptCqEB61v6JzFyVQoyyAdw0eMa2M7QfY40rKlTvz3MC0oqwyclkmO5Cc1V
jO23ii88hPCh/oUkoB8TnrV9VWxKOj7zIUqHoOrYa+XBXwNqOjUCtgaj5oHG6u9u
gI0ez5YdpJ4chwKaEMTnpoXO3jRuMg==
=WRVv
-----END PGP SIGNATURE-----

--ig2abS8lOLh3eXW6d2ow0EJbDvkdNDJ6u--
