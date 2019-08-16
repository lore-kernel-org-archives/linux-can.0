From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: AW: can: tcan4x5x: spi bits_per_word issue on Raspberry PI
Date: Fri, 16 Aug 2019 10:37:46 +0200
Message-ID: <175f7e89-5b4b-dd54-20a3-d6a5a04c6e9c@pengutronix.de>
References: <3f71bdff8f4f4fe19ad9a09be89bc73d@escrypt.com>
 <f78bb414-4165-3f56-151a-47ab4a8a645d@pengutronix.de>
 <e6577cc2-89fc-9428-b73e-47f41eff2949@posteo.de>
 <47108d803086402c83d1073f3e3a62bb@escrypt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="IpmV2nXkM23PsJCcqjltl8zNRA16cz2PT"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <47108d803086402c83d1073f3e3a62bb@escrypt.com>
Sender: netdev-owner@vger.kernel.org
To: "FIXED-TERM Buecheler Konstantin (ETAS-SEC/ECT-Mu)" <fixed-term.Konstantin.Buecheler@escrypt.com>, Patrick Menschel <menschel.p@posteo.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IpmV2nXkM23PsJCcqjltl8zNRA16cz2PT
Content-Type: multipart/mixed; boundary="ak7Mq7nZXYSjf959xHCvJGAI8P3hrHYs1";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "FIXED-TERM Buecheler Konstantin (ETAS-SEC/ECT-Mu)"
 <fixed-term.Konstantin.Buecheler@escrypt.com>,
 Patrick Menschel <menschel.p@posteo.de>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Dan Murphy <dmurphy@ti.com>
Message-ID: <175f7e89-5b4b-dd54-20a3-d6a5a04c6e9c@pengutronix.de>
Subject: Re: AW: can: tcan4x5x: spi bits_per_word issue on Raspberry PI
References: <3f71bdff8f4f4fe19ad9a09be89bc73d@escrypt.com>
 <f78bb414-4165-3f56-151a-47ab4a8a645d@pengutronix.de>
 <e6577cc2-89fc-9428-b73e-47f41eff2949@posteo.de>
 <47108d803086402c83d1073f3e3a62bb@escrypt.com>
In-Reply-To: <47108d803086402c83d1073f3e3a62bb@escrypt.com>

--ak7Mq7nZXYSjf959xHCvJGAI8P3hrHYs1
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 8/16/19 10:26 AM, FIXED-TERM Buecheler Konstantin (ETAS-SEC/ECT-Mu)
wrote:
>>> Have you changed the bits_per_word to 8? Then you read just a stream
>>> of bytes. If you tread them as an u32 they are in host order.
>=20
> @Marc
> Yes, I changed bits_per_word to 8. Since the PI does not support any va=
lues apart from=20
> 8 and 9 this seems to be the only way.

ok

>> from my experience with SPIDEV on RPI, the driver uses a char array fo=
r I/O.
>> As the RPI code is build little endian, logically little endian comes =
out of SPI. You
>> basically have to invert the bit and byte order by hand for a big endi=
an slave.
>=20
> @Patrick, Marc
> You both are right. This seems to be the problem. The SPI driver uses c=
har arrays
> and the tcan driver treats them as u32.=20

No, the tcan configures the spi device or rather the host driver that
the word len should be 32 bit. If you change the value to 8 you break
the assumptions in the driver.

> I will try to change the byte order by hand to get it running for my pr=
oject. But in the long=20
> run, this does not seem to be a proper solution...=20

Indeed, that's the wrong approach. I don't have any HW here to test, but
I'll prepare a patch. BTW: the driver is broken in several ways, when it
comes to the regmap configuration.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ak7Mq7nZXYSjf959xHCvJGAI8P3hrHYs1--

--IpmV2nXkM23PsJCcqjltl8zNRA16cz2PT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1Wa1oACgkQWsYho5Hk
nSBYbggArMg9DyraQFbMqVDr2Posft5IoTY9z7iEoWSEOoxOukZ/RgihVCgGBseu
3ClgJrD8GHOA0bYV7CVIOaj2hRLFIxA7gS6mq1Ur32XejLIdw8+tSmd76mIVPNrL
273pSYYsp3Tbrn96oFoJ56ZD+VXAUzDNbOYo6iNG3xa6A+CeAPOZ/6VAiI1wIwoo
PiPNJe481G0d3qghj4rPCN9H/qUlOq/MaAhGL6cyNSUUY2QIXmmhUC8AblKq5SSE
ord5WgW0+m9ht0CUrLof5iGLVSh04xKWEMi+CcLLOEH6scsJQRQsJdltxYuUX7UG
ikjR5aHjHWqtAjTuAzajPTklEsqw/w==
=/+CC
-----END PGP SIGNATURE-----

--IpmV2nXkM23PsJCcqjltl8zNRA16cz2PT--
