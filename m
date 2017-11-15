From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
Date: Wed, 15 Nov 2017 11:54:20 +0100
Message-ID: <bfa971bb-1217-ed86-d1d8-e353ecc506aa@pengutronix.de>
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
 <20171114120207.xbee2cgsai4qka46@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="o7qiMC3WpGcCdQpHm6f4ksauBgA6wOgoT"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49683 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752314AbdKOKyd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 15 Nov 2017 05:54:33 -0500
In-Reply-To: <20171114120207.xbee2cgsai4qka46@sirena.org.uk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>, Tim Harvey <tharvey@gateworks.com>
Cc: Jan Glauber <jan.glauber@caviumnetworks.com>, linux-spi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o7qiMC3WpGcCdQpHm6f4ksauBgA6wOgoT
Content-Type: multipart/mixed; boundary="OJPt4AltXt13rjA1heHo76g3IsQab1BIt";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mark Brown <broonie@kernel.org>, Tim Harvey <tharvey@gateworks.com>
Cc: Jan Glauber <jan.glauber@caviumnetworks.com>, linux-spi@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <bfa971bb-1217-ed86-d1d8-e353ecc506aa@pengutronix.de>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
 <20171114120207.xbee2cgsai4qka46@sirena.org.uk>
In-Reply-To: <20171114120207.xbee2cgsai4qka46@sirena.org.uk>

--OJPt4AltXt13rjA1heHo76g3IsQab1BIt
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/14/2017 01:02 PM, Mark Brown wrote:
> On Mon, Nov 13, 2017 at 01:17:42PM -0800, Tim Harvey wrote:
>=20
>> When a register is read from the mcp251x driver the
>> octeon_spi_do_transfer() gets a spi_message with a single spi_xfer of
>> len=3D3, a tx_buf, and an rx_buf which I believe is supposed to shift
>> out 3 bytes out MOSI and shift in 3 bytes from MISO where the last
>> byte shifted in would be the response.
>=20
> No, that will simultaneously transmit and recieve three bytes.

That's what the driver supposed to do.

> If you want to transmit two bytes and then recieve one byte you need
> two xfers, one with a len of 2 and a tx_buf, the other with a len of
> 1 and a rx_buf.
To read a register (mcp251x_read_reg()) the mcp251x does a 3 byte full
duplex transfer. The first byte send is the command (read register) the
second byte the register number the third byte is a dummy. The first 2
bytes received are ignored the 3rd byte is the register contents.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--OJPt4AltXt13rjA1heHo76g3IsQab1BIt--

--o7qiMC3WpGcCdQpHm6f4ksauBgA6wOgoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloMHN4ACgkQHv7KIOw4
HPZdSgf+MpniHvwZ4ctg9TfDsS4s4t2z30+8SzARxjln7DVPz9SrLCT1ZLSpTEKy
eBjRvjuEwlnzFTXDbnGmYPgT1440okdX8F1tjQ19NR3myevdGHMZTOAcaT5xg8SD
tBMRWDMDpp5qPA7EYF/huqO9w6rgyP7UT+FZ0IK3blXs7/EZMiJ/Pk+U3FOoss62
7ywP2DZjTjMDKk9riBRBCCX+tf+3BXCfOinXqVI33l1jGyG1f0Y5bYpMC7af//wo
/v9X88EhbNiy3LYD8RiknA936KGMtCJZDQVlPJMgyO6JJUNkTEJzbDXXgPItGcdU
fLQISEaaVIm8RjCaTAixAPywiwqDBg==
=NpGN
-----END PGP SIGNATURE-----

--o7qiMC3WpGcCdQpHm6f4ksauBgA6wOgoT--
