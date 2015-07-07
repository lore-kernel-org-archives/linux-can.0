From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Setting up flexcan mailboxes in Linux
Date: Tue, 7 Jul 2015 12:04:20 +0200
Message-ID: <559BA424.5010106@pengutronix.de>
References: <81C1BF6140F61847A49020308B539A57128B21@MBX01.hosting.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SLlpH6Dhp7Goc8hNEQFTFPsmjF9i3xNw0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38055 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbbGGKE0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Jul 2015 06:04:26 -0400
In-Reply-To: <81C1BF6140F61847A49020308B539A57128B21@MBX01.hosting.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Emil Fors <emil@koenigsegg.se>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SLlpH6Dhp7Goc8hNEQFTFPsmjF9i3xNw0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Emil,

please use the linux-can mailinglst for CAN related questions.

On 07/07/2015 11:59 AM, Emil Fors wrote:
> my name is Emil and I am trying to configure a Toradex Apalis iMX6q
> module. I need to set up the flexcan mailboxes in order to filter out
> messages I'm not interested in. I have CAN communication working using
> the libsocketcan library written by one Luotao Fu, who seems to be a
> colleague of yours? However, that library doesn't seem to provide me
> with control over mailbox configuration. Could you please advise as to
> how I'd best proceed? I noted that the library is (C) 2009, perhaps it
> is outdated? Do you know of a more recent and perhaps better solution?

Hardware filtering is not supported on an driver so far. But we have an
idea how to implement this.

However you can make use of the software filtering via CAN_RAW_FILTER.
See
http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L43=
3
for more information.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SLlpH6Dhp7Goc8hNEQFTFPsmjF9i3xNw0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVm6QkAAoJEP5prqPJtc/HJyQIALJvtCKO/HZRlzkEWD9zM+zE
TxNwMP2B7MjT7BmK/LWbvZxYBgMJ+agyUVzPaZuQlUi4oz9ZNzB5mKCNM1VPotJb
zyHTR9WmSklcjqfa83Csb9dZmuYEDNk4kCSkd0BZ9gfUL6Nt7PQdOq75KHsYN7P2
WHNRcI8SFq0gjiST8ubV9rPxgYEyRzFmXH3FKz4tpCvl2ekECXLK3OWzRYoXIAHD
Iv45HKbLJMVKrynFVAtf9E4cV5209pY/sXUr+OpCy2mxlYPvpOydQc+qfcUyeuml
hHnRaGzvGa51vmgGRZS9indP46kBgcOhEaSmue7pAKXYb9Z4anXa9f4DL2Rvrf0=
=L4O2
-----END PGP SIGNATURE-----

--SLlpH6Dhp7Goc8hNEQFTFPsmjF9i3xNw0--
