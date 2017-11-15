From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
Date: Wed, 15 Nov 2017 14:31:45 +0100
Message-ID: <1feffea6-00de-6e73-309a-bd9619c19666@pengutronix.de>
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
 <20171114120207.xbee2cgsai4qka46@sirena.org.uk>
 <bfa971bb-1217-ed86-d1d8-e353ecc506aa@pengutronix.de>
 <20171115120754.GC3011@hc>
 <36b04940-83a6-93a7-f7e1-d0acc8c135d9@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7EcQMGdN5dx7bVDLkjala2K87BXIUuBaH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39987 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756759AbdKONb4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 15 Nov 2017 08:31:56 -0500
In-Reply-To: <36b04940-83a6-93a7-f7e1-d0acc8c135d9@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: Mark Brown <broonie@kernel.org>, Tim Harvey <tharvey@gateworks.com>, linux-spi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7EcQMGdN5dx7bVDLkjala2K87BXIUuBaH
Content-Type: multipart/mixed; boundary="ewuJDVoMq9PFOvAA181Wxte86GWEffqAe";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: Mark Brown <broonie@kernel.org>, Tim Harvey <tharvey@gateworks.com>,
 linux-spi@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <1feffea6-00de-6e73-309a-bd9619c19666@pengutronix.de>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
 <20171114120207.xbee2cgsai4qka46@sirena.org.uk>
 <bfa971bb-1217-ed86-d1d8-e353ecc506aa@pengutronix.de>
 <20171115120754.GC3011@hc>
 <36b04940-83a6-93a7-f7e1-d0acc8c135d9@pengutronix.de>
In-Reply-To: <36b04940-83a6-93a7-f7e1-d0acc8c135d9@pengutronix.de>

--ewuJDVoMq9PFOvAA181Wxte86GWEffqAe
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/15/2017 01:40 PM, Marc Kleine-Budde wrote:
> mcp251x_spi_trans() is called with len=3D3,
> priv->spi_tx_buf and priv->spi_rx_buf point to previously allocared mem=
ory
>=20
> priv->spi_tx_buf has been filled before calling mcp251x_spi_trans().

> #define OCTEON_SPI_MAX_BYTES 9

> static int octeon_spi_do_transfer(struct octeon_spi *p,
> 				  struct spi_message *msg,
> 				  struct spi_transfer *xfer,
> 				  bool last_xfer)
> {
> 	struct spi_device *spi =3D msg->spi;
> 	union cvmx_mpi_cfg mpi_cfg;
> 	union cvmx_mpi_tx mpi_tx;
> 	unsigned int clkdiv;
> 	int mode;
> 	bool cpha, cpol;
> 	const u8 *tx_buf;
> 	u8 *rx_buf;
> 	int len;
> 	int i;
>=20
> 	mode =3D spi->mode;
> 	cpha =3D mode & SPI_CPHA;
> 	cpol =3D mode & SPI_CPOL;
>=20
> 	clkdiv =3D p->sys_freq / (2 * xfer->speed_hz);
>=20
> 	mpi_cfg.u64 =3D 0;
>=20
> 	mpi_cfg.s.clkdiv =3D clkdiv;
> 	mpi_cfg.s.cshi =3D (mode & SPI_CS_HIGH) ? 1 : 0;
> 	mpi_cfg.s.lsbfirst =3D (mode & SPI_LSB_FIRST) ? 1 : 0;
> 	mpi_cfg.s.wireor =3D (mode & SPI_3WIRE) ? 1 : 0;
> 	mpi_cfg.s.idlelo =3D cpha !=3D cpol;
> 	mpi_cfg.s.cslate =3D cpha ? 1 : 0;
> 	mpi_cfg.s.enable =3D 1;
>=20
> 	if (spi->chip_select < 4)
> 		p->cs_enax |=3D 1ull << (12 + spi->chip_select);
> 	mpi_cfg.u64 |=3D p->cs_enax;
>=20
> 	if (mpi_cfg.u64 !=3D p->last_cfg) {
> 		p->last_cfg =3D mpi_cfg.u64;
> 		writeq(mpi_cfg.u64, p->register_base + OCTEON_SPI_CFG(p));
> 	}
> 	tx_buf =3D xfer->tx_buf;
> 	rx_buf =3D xfer->rx_buf;
> 	len =3D xfer->len;
> 	while (len > OCTEON_SPI_MAX_BYTES) {
> 		for (i =3D 0; i < OCTEON_SPI_MAX_BYTES; i++) {
> 			u8 d;
> 			if (tx_buf)
> 				d =3D *tx_buf++;
> 			else
> 				d =3D 0;
> 			writeq(d, p->register_base + OCTEON_SPI_DAT0(p) + (8 * i));
> 		}
> 		mpi_tx.u64 =3D 0;
> 		mpi_tx.s.csid =3D spi->chip_select;
> 		mpi_tx.s.leavecs =3D 1;
> 		mpi_tx.s.txnum =3D tx_buf ? OCTEON_SPI_MAX_BYTES : 0;

This looks fishy, OCTEON_SPI_MAX_BYTES is 9....

> 		mpi_tx.s.totnum =3D OCTEON_SPI_MAX_BYTES;
> 		writeq(mpi_tx.u64, p->register_base + OCTEON_SPI_TX(p));
>=20
> 		octeon_spi_wait_ready(p);
> 		if (rx_buf)
> 			for (i =3D 0; i < OCTEON_SPI_MAX_BYTES; i++) {
> 				u64 v =3D readq(p->register_base + OCTEON_SPI_DAT0(p) + (8 * i));
> 				*rx_buf++ =3D (u8)v;
> 			}
> 		len -=3D OCTEON_SPI_MAX_BYTES;
> 	}
>=20
> 	for (i =3D 0; i < len; i++) {
> 		u8 d;
> 		if (tx_buf)
> 			d =3D *tx_buf++;
> 		else
> 			d =3D 0;
> 		writeq(d, p->register_base + OCTEON_SPI_DAT0(p) + (8 * i));
> 	}
>=20
> 	mpi_tx.u64 =3D 0;
> 	mpi_tx.s.csid =3D spi->chip_select;
> 	if (last_xfer)
> 		mpi_tx.s.leavecs =3D xfer->cs_change;
> 	else
> 		mpi_tx.s.leavecs =3D !xfer->cs_change;
> 	mpi_tx.s.txnum =3D tx_buf ? len : 0;
> 	mpi_tx.s.totnum =3D len;
> 	writeq(mpi_tx.u64, p->register_base + OCTEON_SPI_TX(p));
>=20
> 	octeon_spi_wait_ready(p);
> 	if (rx_buf)
> 		for (i =3D 0; i < len; i++) {
> 			u64 v =3D readq(p->register_base + OCTEON_SPI_DAT0(p) + (8 * i));
> 			*rx_buf++ =3D (u8)v;
> 		}

Personally I'd fold this into the while loop, as there's quite some code
duplication. Of course your have to improve the "if (last_xfer)" a bit.

>=20
> 	if (xfer->delay_usecs)
> 		udelay(xfer->delay_usecs);
>=20
> 	return xfer->len;
> }

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ewuJDVoMq9PFOvAA181Wxte86GWEffqAe--

--7EcQMGdN5dx7bVDLkjala2K87BXIUuBaH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloMQcEACgkQHv7KIOw4
HPYqnAf/Vr+BD2j2YzHGVfiu0vTBfxsMA2xxsFy63kgZF0auc+g/ci1YwkKziBlF
Bsu6XgiO24MQ8iVd45uSc/RC+pT306UuKIai/lraosPFGTQwdhimhq21J8lUwgrY
Uv4o/Lv8o/28PmdEYqXw17Bmoxv7tm4UnZKHPoNdZjWm3S2thi95C2g57T9cx/kf
hLf9rp6/yAK6fqtQd8zh+ZjMpkzFZREc6I7UGYu1jKxmwV10xqzH+1AA+SgCz0QU
Y7LiEslMTyvDSRidA/qL98JkL1BLw16lyvlo1JMrSkoQBojdhUWnLA3W7Pnr1E+3
5OK9UGCPjXAOwshA1rpDM+9ZsfHJ5g==
=fZyb
-----END PGP SIGNATURE-----

--7EcQMGdN5dx7bVDLkjala2K87BXIUuBaH--
