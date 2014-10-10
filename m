From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Writing socketCAN module for my own hardware
Date: Fri, 10 Oct 2014 10:06:33 +0200
Message-ID: <54379389.5040005@pengutronix.de>
References: <53E9C774.3040401@ep1.ruhr-uni-bochum.de> <53E9CF27.90400@pengutronix.de> <53E9D6F3.4050206@ep1.ruhr-uni-bochum.de> <53E9E614.7060303@pengutronix.de> <542BACC0.4050707@ep1.ruhr-uni-bochum.de> <542BB21B.4030200@pengutronix.de> <542BF456.3030201@ep1.ruhr-uni-bochum.de> <542BF687.1000800@pengutronix.de> <5436A482.4040001@ep1.ruhr-uni-bochum.de> <5436B443.10606@pengutronix.de> <54378E35.6000205@ep1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fuSLoRug07OmTLebQHCv0j7uFrdJTngsx"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55238 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbaJJIGj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Oct 2014 04:06:39 -0400
In-Reply-To: <54378E35.6000205@ep1.ruhr-uni-bochum.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fuSLoRug07OmTLebQHCv0j7uFrdJTngsx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2014 09:43 AM, Florian Feldbauer wrote:
>>> Although I can see at the scope, that reading register 0 of the SJA10=
00
>>> returns the value 1 as it should be.
>>> Also, it seems that there is some kind of endless loop reading this
>>> register.
>> No, just a loop of up to 100 :)

> Maybe it's correlated with the issue that the message
> [  129.210423] sja1000_raspi sja1000_raspi.0 can0: bit-timing not yet
> appears over and over again in dmesg, but register 0 is definitely
> read more than 100 times...

As mentioned earlier, you have probably a mechanism running on your
system, that tries to enable the CAN interface. Bringing up the
interface without a set bit-rate is not allowed.

[...]

>>> Any Ideas why the first initialization of the kernel module doesn't
>>> work?
>>> When is the probe function of the module actually called?
>> As soon as there is a matching driver//device combination on a bus.
>> Looking at your driver, it's racy. You should not do any hardware setu=
p
>> in the init function.
> Ok...I moved the whole configuration of the GPIOs into the probe
> function (instead of the init)
> and now it works! Thanks!
>=20
> Now I only have to solve the problem, that bringing the interface down
> is not possible....
> Always need to reboot just to change bitrate is no fun.
> Maybe I should consult the Raspberry community, if there is some kind o=
f
> network manager...

What kind of distribution are you using?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fuSLoRug07OmTLebQHCv0j7uFrdJTngsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQ3k4kACgkQjTAFq1RaXHNnmgCfS5ntA5CNWnwIbDf/gghLIISq
IvUAn0StN/YpMIqRcarOOoAQ6j4+vk8S
=9h0r
-----END PGP SIGNATURE-----

--fuSLoRug07OmTLebQHCv0j7uFrdJTngsx--
