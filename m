From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Can't start ESD CAN-USB/2
Date: Fri, 31 Jan 2014 18:56:58 +0100
Message-ID: <52EBE3EA.6030706@pengutronix.de>
References: <52EBCACD.9080906@iit.it> <52EBCBFA.2090205@pengutronix.de> <52EBD794.3020503@iit.it> <52EBDCD2.6000301@pengutronix.de>,<52EBDD1D.4060503@pengutronix.de> <B83FB8757830C3428B64299F968D0F68034C56FE@IITMXWGE012.iit.local> <52EBE0D4.2060907@pengutronix.de> <52EBE25E.40707@iit.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QI65PbQNJe6f1a8JtXbdGOQ6E38rlGliK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54043 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932868AbaAaR5D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2014 12:57:03 -0500
In-Reply-To: <52EBE25E.40707@iit.it>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Francesco Giovannini <francesco.giovannini@iit.it>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QI65PbQNJe6f1a8JtXbdGOQ6E38rlGliK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2014 06:50 PM, Francesco Giovannini wrote:
> Yes I had to compile it myself because OpenSuse does not include it. I
> first added it to the kernel config as a module and then ran make
> M=3D./drivers/net/can/usb in the kernel source tree.

Please don't top post.

Have you used the kernel sources provided by suse? If not, try these.
Try a different USB port on the machine, if the CAN adapter has a USB
cable that is removable, swap it too. If it's still failing try a
different machine.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--QI65PbQNJe6f1a8JtXbdGOQ6E38rlGliK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLr4+oACgkQjTAFq1RaXHMssgCgl7lWLq7dmDLS1As25wFS0aR2
DmsAmwZ1Go3skO6TwxWGMffT8E6aaQq+
=SZqw
-----END PGP SIGNATURE-----

--QI65PbQNJe6f1a8JtXbdGOQ6E38rlGliK--
