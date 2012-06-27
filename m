From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/4] can: flexcan: add transceiver switch support when
 use device tree
Date: Wed, 27 Jun 2012 10:26:18 +0200
Message-ID: <4FEAC3AA.500@pengutronix.de>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com> <1340785161-3598-2-git-send-email-jason77.wang@gmail.com> <1340785161-3598-3-git-send-email-jason77.wang@gmail.com> <1340785161-3598-4-git-send-email-jason77.wang@gmail.com> <1340785161-3598-5-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9D60E038BE3928653CD2EDD5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56357 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab2F0I0k (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 04:26:40 -0400
In-Reply-To: <1340785161-3598-5-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: davem@davemloft.net, shawn.guo@linaro.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9D60E038BE3928653CD2EDD5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/27/2012 10:19 AM, Hui Wang wrote:
> Some platforms (like i.MX6) has an external PHY, the PHY is operated
> by some gpios. If the system registers a platform_data, we can
> set a callback function pointer to pdata->transceiver_switch to
> implement PHY switch. If we use device tree, we couldn't pass
> platform_data to the driver, so i move the switch function to the
> driver and add device tree entries to let user set which gpios
> are used to operate PHY.
>=20
> This design doesn't break existing platforms, if a platform doesn't
> need PHY switch, it doesn't need to set dt entries just as before,
> if a platform has platform_data, the pdata->transceiver_switch has
> higher priority.
>=20
> Cc: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>

please coordinate whith Shawn Guo, he has posted a similar patch some
days ago. http://www.spinics.net/lists/netdev/msg202442.html

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig9D60E038BE3928653CD2EDD5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/qw6sACgkQjTAFq1RaXHOBbwCff0JkVG9JsGG+tElutfNMLfjU
OBYAn3N3VNDVQfpl7y9yKjqx3UwRw5nM
=3FZq
-----END PGP SIGNATURE-----

--------------enig9D60E038BE3928653CD2EDD5--
