From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: kvaser_usb: Ignore spurious error events after a
 busoff
Date: Wed, 04 Feb 2015 14:04:35 +0100
Message-ID: <54D218E3.3050204@pengutronix.de>
References: <20150202201555.GA29327@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ioMe1EK8x0hOJnf9RjpoKeWmo475PeKCv"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60917 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965485AbbBDNEr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Feb 2015 08:04:47 -0500
In-Reply-To: <20150202201555.GA29327@linux>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>, Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ioMe1EK8x0hOJnf9RjpoKeWmo475PeKCv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2015 09:15 PM, Ahmed S. Darwish wrote:
> From: Ahmed S. Darwish <ahmed.darwish@valeo.com>
>=20
> Sending data in high speed then introducing a busoff results
> in spurious BUS_ERROR events from the USBCan-II firmware directly
> _after_ the triggered BUS_OFF event.
>=20
> In the current CAN state handling code, this will lead to an
> invalid can state of ACTIVE, ERROR, or PASSIVE even though the
> CAN controller has been already shut down due to the busoff.
>=20
> Guard the state handling code from such invalid events.
>=20
> Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>

Applied to can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ioMe1EK8x0hOJnf9RjpoKeWmo475PeKCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU0hjmAAoJECte4hHFiupU+X4P/2TvFxLIyG5LORJEZ0KSLPza
cBiP88OK14uNlM/WW5JkggfLislHBCfc1fdIH7wQfuEBtabO6xPL33KSkymjT/F1
R7yo8sjMoK3YAl1KPG1xmFoXTt8lX1/oivjKiBYF5e61LsPcjWA7q6d13dduMhMC
FY+fbD78AO940rNHNjensIW6m1GWDI9Jvb9n3g5O4VRRjZsgigDXaPdxKwcsM93t
LD41IHtcIpn7qE8q+x8OkWDlbItLuVZfKLhJjLUcoJurFy0TRkb2NdvVy04WHF7n
upN9g1KZOHRONuqw3RALYRoh77eU1JSLQBojXjZzJEaN28yl5/yZ7Q0KMa7cgUwl
oJiiKv3RHxG9ZvZbZoplSZscMOZfGPZCyIVvV+OfNylHXfaXu8VUfafiy7EBW9uT
sNyn1UB4ZLbvRY8an8GGkRyhPjat/91109jwxyvL5tbRR081FVKlq8NIXItUATQ5
voEQaSJ4ApfGOhv/rE7Ozdbi0V5Wr15q35OHegSmQ7LCnXaOEvKLT/ZojaOBbL09
j1ZU559+1W9Z32+pYeBDIHeRhZ7TphDxrNB6kYNuASNpVer18MPrWq+cMXoQvfix
cPeYKxjP2lX9pYtQi4oa1d3K/UIGjRxIZmpz6WFvJmcOTnH+D+aw2vF54sdT8zLj
8CoyBmpzfVHe4vuJEJVd
=sGtY
-----END PGP SIGNATURE-----

--ioMe1EK8x0hOJnf9RjpoKeWmo475PeKCv--
