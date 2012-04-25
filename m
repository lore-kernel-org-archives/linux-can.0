From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Peak PCAN USB question
Date: Wed, 25 Apr 2012 10:31:12 +0200
Message-ID: <4F97B650.4080509@pengutronix.de>
References: <77D4E1B1D8549C4388FD52C58AC24547053FE38D@SBSPORT2.portnet.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCAC5BC8D49F42E80978584BD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49501 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308Ab2DYIbV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Apr 2012 04:31:21 -0400
In-Reply-To: <77D4E1B1D8549C4388FD52C58AC24547053FE38D@SBSPORT2.portnet.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCAC5BC8D49F42E80978584BD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/25/2012 09:37 AM, Heinz-J=FCrgen Oertel wrote:
> I'm working on a project where the application has to use can4linux and=
 SocketCAN.
> Mainly because can4linux has no USB support yet.
> For some requests to the SocketCAN layer I use libsocketcan.
> Can someone confirm that can_get_berr_counter(), can_get_state()
> and may be some more functions are not working with the Peak PCAN USB I=
nterface?

can_get_berr_counter ends up in the do_get_berr_counter callback, which
isn't implemented in the peak drivers.

grep -R do_get_berr_counter drivers/net/can/usb/peak_usb/

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigCAC5BC8D49F42E80978584BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+XtlUACgkQjTAFq1RaXHO70QCfRGIff7gX51g8q+5ZAa/3A2ws
f/wAnRdapKPKeFV4TBJYzKdC56TpKBDS
=UbGl
-----END PGP SIGNATURE-----

--------------enigCAC5BC8D49F42E80978584BD--
