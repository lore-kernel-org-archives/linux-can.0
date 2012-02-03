From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: pull-request: can 2012-02-03
Date: Fri, 03 Feb 2012 01:34:05 +0100
Message-ID: <4F2B2B7D.9000606@pengutronix.de>
References: <4F2B2A97.5000004@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5E9B7FEB2700CC4C46238D3A"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54080 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab2BCAeH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2012 19:34:07 -0500
In-Reply-To: <4F2B2A97.5000004@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: mkl@blackshift.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5E9B7FEB2700CC4C46238D3A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/03/2012 01:30 AM, Marc Kleine-Budde wrote:
> here is a group of CAN driver fixes intended for 3.3. The first one by
> Wolfgang Grandegger fixing a race condition in the TX path the cc770
> driver. The next one, by Wolfgang Zarre, adds locking to the indirect
> register access function. Then follows a patch by Wolfgang Grandegger
> which fixes the irq flood on flexcan (on mx28) which is triggered by
> error interrupts. Xi Wang's patch fixes the error passive level test
> on pch_can. Stephane Grosjean contribues a patch for peak_pci which
> fixes the linking of the channels avoiding an kernel oops when the
> driver is removed. The next patch by Wolfgang Grandegger fixes the
> ti_hecc driver, by using netif_rx in interrupt context. The last patch
> comes from Sebastian Haas, it removes a double netif_device_detach
> from the error path of the ems_usb driver.

I've moved shuffled the patches about around, picking the fixes and
trying to get them into 3.3. I'm going to send the remaining ones to
net-next.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig5E9B7FEB2700CC4C46238D3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8rK30ACgkQjTAFq1RaXHNsDACgg/K5ZgtsWkptZOnfb9OGMeH6
u+kAnA0W8A3JXPExC9D+GPGF+blX/bqy
=hLDS
-----END PGP SIGNATURE-----

--------------enig5E9B7FEB2700CC4C46238D3A--
