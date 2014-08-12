From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Writing socketCAN module for my own hardware
Date: Tue, 12 Aug 2014 10:24:07 +0200
Message-ID: <53E9CF27.90400@pengutronix.de>
References: <53E9C774.3040401@ep1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CMBP2Mf1cVwDrVqrKQQsMdMnGtVqgr0XV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40418 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbaHLIYN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Aug 2014 04:24:13 -0400
In-Reply-To: <53E9C774.3040401@ep1.ruhr-uni-bochum.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CMBP2Mf1cVwDrVqrKQQsMdMnGtVqgr0XV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/12/2014 09:51 AM, Florian Feldbauer wrote:
> I have developed a CAN interface for the Raspberry Pi computer using th=
e
> SJA1000 directly connected to the GPIOs of the CPU.

This sounds very slow :)

> So far this interface is used as chardev and works fine.
> But I'm also developing a user-space program using this CAN interface.
> This program should also be compatible with other CAN interfaces like
> the ones from PEAK or Kvazer. So I thought using socketCAN would be a
> good idea.

Yes.

> Is there any documentation on how to write a socketCAN compatible kerne=
l
> module for my own hardware?
> I tried writing something similar to the sja1000_isa driver...

IMHO sja1000_platform.c is a better blueprint, as it uses the device
tree to describe the hardware and does not rely on module parameters.

> So far my modified kernel compiles and I can change bitrate and bring
> the interface up.
> But as soon as I try to send a CAN frame I get the error:
> Error 105: No buffer space available

You are sending CAN frames faster than the driver is able to send them,
you have to wait a bit, before sending new CAN frames.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--CMBP2Mf1cVwDrVqrKQQsMdMnGtVqgr0XV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlPpzycACgkQjTAFq1RaXHOeuwCeLwGVJjego9OPqeaisVWS6iOl
etoAoIdaA8P23cFpGiwMLO3Kf06TP4t0
=R5tr
-----END PGP SIGNATURE-----

--CMBP2Mf1cVwDrVqrKQQsMdMnGtVqgr0XV--
