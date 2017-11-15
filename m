From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
Date: Wed, 15 Nov 2017 13:40:04 +0100
Message-ID: <36b04940-83a6-93a7-f7e1-d0acc8c135d9@pengutronix.de>
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
 <20171114120207.xbee2cgsai4qka46@sirena.org.uk>
 <bfa971bb-1217-ed86-d1d8-e353ecc506aa@pengutronix.de>
 <20171115120754.GC3011@hc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AMX8lbbd4OF9hdNSiI0Fd2FvcTHoD4XaT"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59575 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756926AbdKOMkM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 15 Nov 2017 07:40:12 -0500
In-Reply-To: <20171115120754.GC3011@hc>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: Mark Brown <broonie@kernel.org>, Tim Harvey <tharvey@gateworks.com>, linux-spi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AMX8lbbd4OF9hdNSiI0Fd2FvcTHoD4XaT
Content-Type: multipart/mixed; boundary="lE7HdI0HX7WvOOc1Eefx06uA2ve3uWLOX";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: Mark Brown <broonie@kernel.org>, Tim Harvey <tharvey@gateworks.com>,
 linux-spi@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <36b04940-83a6-93a7-f7e1-d0acc8c135d9@pengutronix.de>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
 <20171114120207.xbee2cgsai4qka46@sirena.org.uk>
 <bfa971bb-1217-ed86-d1d8-e353ecc506aa@pengutronix.de>
 <20171115120754.GC3011@hc>
In-Reply-To: <20171115120754.GC3011@hc>

--lE7HdI0HX7WvOOc1Eefx06uA2ve3uWLOX
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/15/2017 01:07 PM, Jan Glauber wrote:
> On Wed, Nov 15, 2017 at 11:54:20AM +0100, Marc Kleine-Budde wrote:
>> On 11/14/2017 01:02 PM, Mark Brown wrote:
>>> On Mon, Nov 13, 2017 at 01:17:42PM -0800, Tim Harvey wrote:
>>>
>>>> When a register is read from the mcp251x driver the
>>>> octeon_spi_do_transfer() gets a spi_message with a single spi_xfer o=
f
>>>> len=3D3, a tx_buf, and an rx_buf which I believe is supposed to shif=
t
>>>> out 3 bytes out MOSI and shift in 3 bytes from MISO where the last
>>>> byte shifted in would be the response.
>>>
>>> No, that will simultaneously transmit and recieve three bytes.
>>
>> That's what the driver supposed to do.
>>
>>> If you want to transmit two bytes and then recieve one byte you need
>>> two xfers, one with a len of 2 and a tx_buf, the other with a len of
>>> 1 and a rx_buf.
>> To read a register (mcp251x_read_reg()) the mcp251x does a 3 byte full=

>> duplex transfer. The first byte send is the command (read register) th=
e
>> second byte the register number the third byte is a dummy. The first 2=

>> bytes received are ignored the 3rd byte is the register contents.
>=20
> To support this full duplex transfer the Cavium SPI controller needs
> to know the receive lenght before setting up the transaction.
>=20
> spi_transfer only includes the total length, so I don't see how this
> should work.

It's a standard 3 byte full duplex transfer. Three bytes are send while
three bytes are received.

> static int mcp251x_spi_trans(struct spi_device *spi, int len)
> {
> 	struct mcp251x_priv *priv =3D spi_get_drvdata(spi);
> 	struct spi_transfer t =3D {
> 		.tx_buf =3D priv->spi_tx_buf,
> 		.rx_buf =3D priv->spi_rx_buf,
> 		.len =3D len,
> 		.cs_change =3D 0,
> 	};
> 	struct spi_message m;
> 	int ret;
>=20
> 	spi_message_init(&m);
>=20
> 	if (mcp251x_enable_dma) {
> 		t.tx_dma =3D priv->spi_tx_dma;
> 		t.rx_dma =3D priv->spi_rx_dma;
> 		m.is_dma_mapped =3D 1;
> 	}
>=20
> 	spi_message_add_tail(&t, &m);
>=20
> 	ret =3D spi_sync(spi, &m);
> 	if (ret)
> 		dev_err(&spi->dev, "spi transfer failed: ret =3D %d\n", ret);
> 	return ret;
> }

mcp251x_spi_trans() is called with len=3D3,
priv->spi_tx_buf and priv->spi_rx_buf point to previously allocared memor=
y

priv->spi_tx_buf has been filled before calling mcp251x_spi_trans().

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lE7HdI0HX7WvOOc1Eefx06uA2ve3uWLOX--

--AMX8lbbd4OF9hdNSiI0Fd2FvcTHoD4XaT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloMNaQACgkQHv7KIOw4
HPZp1wgAy1lWg5+Rtc3I4QBni0Yx08CSOwFdKeiN+7UpX6e1jRVsRuXjlKfMIqII
hgUBowUrd9pUXH3lsL3zHwa//k5eyx1c5EwZgWcL+JlwrOe3i6HGBLn+GnWuGjZI
eAEe0Qq2QKgWL/8KYITp9vhRBE8MwTJo4DwD00ZOWbNjYhGaI9DKnNY/pTIy1WFg
4b84/u0EXszV8gG3ETjSXfTG4MIhUd4ulSXGk4cpCCVrlxrkgSY054Al8/OAEHGe
xqdYGfTay1D7sqW7iSMY4ZWBIar1ACp1S7WTICH/kQEoEM2yQKzcHqkICpbpOJtc
Kx+sz9sXSlQC9qOT5ldX8MsIk6oAnQ==
=N8k2
-----END PGP SIGNATURE-----

--AMX8lbbd4OF9hdNSiI0Fd2FvcTHoD4XaT--
