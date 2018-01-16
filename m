From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: peak/usb: fix potential bug in packet
 fragmentation
Date: Tue, 16 Jan 2018 15:34:46 +0100
Message-ID: <8c30ae1d-9f9c-0e52-5909-d6eb775b83ba@pengutronix.de>
References: <20180115153119.18847-1-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="tA97I58Ua1Qxt0gHpvZxTdNUBSQxlbi6t"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58803 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbeAPOfJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Jan 2018 09:35:09 -0500
In-Reply-To: <20180115153119.18847-1-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tA97I58Ua1Qxt0gHpvZxTdNUBSQxlbi6t
Content-Type: multipart/mixed; boundary="TDFePMXqLQLTlQntSeXm0ZI5l5Ep9AIsK";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <8c30ae1d-9f9c-0e52-5909-d6eb775b83ba@pengutronix.de>
Subject: Re: [PATCH v2] can: peak/usb: fix potential bug in packet
 fragmentation
References: <20180115153119.18847-1-s.grosjean@peak-system.com>
In-Reply-To: <20180115153119.18847-1-s.grosjean@peak-system.com>

--TDFePMXqLQLTlQntSeXm0ZI5l5Ep9AIsK
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/15/2018 04:31 PM, Stephane Grosjean wrote:
> In some rare conditions when running one PEAK USB-FD interface over
> a non high-speed USB controller, one useless USB fragment might be sent=
=2E
> This patch fixes the way a USB command is fragmented when its length is=

> greater than 64 bytes and when the underlying USB controller is not a
> high-speed one.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Added to can/testing.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--TDFePMXqLQLTlQntSeXm0ZI5l5Ep9AIsK--

--tA97I58Ua1Qxt0gHpvZxTdNUBSQxlbi6t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpeDYYACgkQHv7KIOw4
HPbppQf+Jq2NBN34jsflMIUe0+4+PVGi4/eWBuXYfQCdbGc93N2x+OAAvy93mCTX
NRrBzq8ESFw6v19cAZMacWwrclzbM8QIAUOCZaeeYiuXkS1mj4tNFqm5brPbznoN
Qa7thTwX5Bxp1k9kk1WuPjA6x9wUDUFZiedcDvcI3t/qDNp3eVPoJpsXYS32xPPz
N8ERasmJUDebPttzUY67gZQ9/iBXsPLASRshqC1l/DMtvAshv0Rymu76ekJPysOK
BcE6qlKOj8rjeRwlimbPnf97FaG68FXwuF5H2tg0EOm63suJWcqBj4jDzZPVxICo
JHT4TSUjE9l5DplQ9+GodCfVoiFIdg==
=eomo
-----END PGP SIGNATURE-----

--tA97I58Ua1Qxt0gHpvZxTdNUBSQxlbi6t--
