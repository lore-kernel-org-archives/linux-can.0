From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: cansniffer loop time
Date: Tue, 24 Jun 2014 17:35:25 +0200
Message-ID: <53A99ABD.7020407@pengutronix.de>
References: <53A99784.5020609@thm-motorsport.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pdjfTw1gpt4SR3bP7Ec8egfeSKaIQ97Iw"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48774 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbaFXPi7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jun 2014 11:38:59 -0400
In-Reply-To: <53A99784.5020609@thm-motorsport.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Felix Seitz <felix.seitz@thm-motorsport.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pdjfTw1gpt4SR3bP7Ec8egfeSKaIQ97Iw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hey Felix,

On 06/24/2014 05:21 PM, Felix Seitz wrote:
> we from THM Motorsport are using the cansniffer running on a Raspberry

What is "the cansniffer"?

> Pi to read out sensor data traffic on the CANbus in our car.
> I would like to set the cansniffer's loop time lower than 100ms. I trie=
d
> to changing the source code but apparently I don't fully understand
> where the loop delay comes from.
> Could you give me some tips on how to set a lower delay for the
> cansniffer? 20ms delay would be perfect.

Despite the fact, that the rpi is not the best hardware/software for
doing CAN under Linux, there is no delay within the Linux Kernel that
would cause a loop delay.

If you see such a delay it's probably in the application of "the
cansniffer". The rpi has no CAN controller on the board, there are
several possibilities to upgrade CAN support. The worst solution is to
attach an mcp2515 via SPI, USB based CAN dongles give much better
performance. However USB on the rpi is quite bad, too...

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pdjfTw1gpt4SR3bP7Ec8egfeSKaIQ97Iw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOpmr0ACgkQjTAFq1RaXHP+2QCgixKjR75J/+ZsFapIkXQe37cc
NcsAn3wLxRNHUnVjHfwhZuSCdGmM2HK4
=7oco
-----END PGP SIGNATURE-----

--pdjfTw1gpt4SR3bP7Ec8egfeSKaIQ97Iw--
