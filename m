From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: About PCAN-USB issues
Date: Tue, 31 Jan 2012 18:58:13 +0100
Message-ID: <4F282BB5.40006@pengutronix.de>
References: <1567213.2GCzMlGyKY@lisa> <4F1E9DA9.9060804@hartkopp.net> <4F1EE678.2050604@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1BF28993B3D63DADDB760D79"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53076 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141Ab2AaR6W (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 12:58:22 -0500
In-Reply-To: <4F1EE678.2050604@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Sebastian Haas <dev@sebastianhaas.info>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1BF28993B3D63DADDB760D79
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/24/2012 06:12 PM, Stephane Grosjean wrote:
> Hello all,
>=20
> I'm finally back to the linux-can... I'm currently working on several
> projects so the peak_usb did progress slowly these last days...
>=20
> Back to the issue: I changed the way the can state is handled in the
> peak_usb driver and finally get an easy tesbed to create bus-off
> events... Now, the driver puts the candev into that state only once, no=

> more periodic error-warnings or else. I'm looking now to how the restar=
t
> mechanism works.
>=20
> 1st: since the restart can be automatic, the related do_set_mode
> callback is called from a timer context, in which you're not allowed to=

> sleep. So I suppose this is the reason of some Kernel hangs you (Oliver=
)
> detected last week: the peak_usb driver (tries to) reset the device by
> sending an usb message, using usb_bulk_msg(), which usage is not allowe=
d
> in such a context! To confirm, is someone able to do the same with the
> ems_usb driver, please? It seems that this driver acts as the peak_usb
> does.
>=20
> Moreover, it seems that the "manual" restart is also called from such a=

> timer context, so the consequences are the same...
>=20
> I'll have to change the way that reset is done into full asynchronous m=
ode.

Does it make sense to replace the timer by a workqueue and schedule it
by schedule_delayed_work(). On the downside a workqueue can only be
delayed in jiffies granularity.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig1BF28993B3D63DADDB760D79
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8oK7sACgkQjTAFq1RaXHMhLQCdEnvx3eJOtzqvsQEK4pNWmKcK
YtEAoIMeTtNFS+1LgVco6VJqXlxGwcA1
=/3wk
-----END PGP SIGNATURE-----

--------------enig1BF28993B3D63DADDB760D79--
