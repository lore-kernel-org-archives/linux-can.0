From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: sja1000 fix isr hang when hw is unplugged under
 load
Date: Mon, 20 Feb 2012 12:02:25 +0100
Message-ID: <4F422841.3070901@pengutronix.de>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de> <4F3BE2AC.9020108@hartkopp.net> <4F3EB82C.7080905@pengutronix.de> <4F3FB389.7050104@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB757D798D41444A2DAED63CB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60455 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab2BTLCb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Feb 2012 06:02:31 -0500
In-Reply-To: <4F3FB389.7050104@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB757D798D41444A2DAED63CB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/18/2012 03:19 PM, Oliver Hartkopp wrote:
>>> In the case of hotplug enabled devices (PCMCIA/PCIeC) the removal of =
the
>>> hardware can cause an infinite loop in the common sja1000 isr.
>>>
>>> Use the already retrieved status register to indicate a possible hard=
ware
>>> removal and double check by reading the mode register in sja1000_is_a=
bsent.
>>>
>>> v2: Create a new function to not print information in irq context.
>>>
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

> Indeed it should go into stable 3.2 too, as it was the first kernel, wh=
ere the
> EMS PCMCIA driver was integrated.

I just send it to David, including Cc to stable and Wolfgang's Acked-by.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB757D798D41444A2DAED63CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9CKEQACgkQjTAFq1RaXHO6xgCeMza+UlcW0LE6Nz1Tu04lmvpz
DWgAn3XyneSOBMZ0rF6ynp0YyJE4pDqW
=e0ri
-----END PGP SIGNATURE-----

--------------enigB757D798D41444A2DAED63CB--
