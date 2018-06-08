From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH 2/5] spi: implement companion-spi driver
Date: Fri, 8 Jun 2018 09:05:05 +0200
Message-ID: <20180608070505.gmirhvtqdr2uzvtw@pengutronix.de>
References: <bb9540ed90e944c7a8e27287e6df25d5@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g2iqv75r7rvnlvzl"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bb9540ed90e944c7a8e27287e6df25d5@de.bosch.com>
Sender: netdev-owner@vger.kernel.org
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, netdev <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heiko Schocher <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
List-Id: linux-can.vger.kernel.org


--g2iqv75r7rvnlvzl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 06:56:23AM +0000, Jonas Mark (BT-FIR/ENG1) wrote:
> Hi Oleksij,
>=20
> > > > > +               if (slave_is_not_busy(priv))
> > > > > +                       return 0;
> > > > > +
> > > >
> > > > > +               udelay(READY_POLL_US_GRAN);
> > > >
> > > > Should it be atomic?
> > > > Can it use read_poll_* type of helpers instead?
> > >
> > > Yes, it shall be atomic because we need to reduce the latency at
> > > detecting the de-assertion of the busy signal. We accept that this wi=
ll
> > > cost CPU time.
> > >
> > > In case the Companion itself is very busy and does not reply quickly =
we
> > > are have second polling loop below which sleeps longer and is non-ato=
mic.
> >=20
> > I can confirm, this make huge impact on protocol performance. And this
> > protocol is not really the speed runner.
>=20
> The challenge is that the protocol is synchronous and without back to
> back transfers.
>=20
> > you can send dummy message to set CS.
> > +	struct spi_transfer t =3D {
> > +		.len =3D 0,
> > +		.cs_change =3D 1,
> > +	};
> >=20
> > +	/* send dummy to trigger CS */
> > +	reinit_completion(&priv->fc_complete);
> > +	spi_sync_locked(spi, &m);
> >=20
> > see my ancient unfinished code:
> > https://patchwork.kernel.org/patch/9418511/
>=20
> We will check it out.
>=20
> > In general, this part of the code, can be provided as separate driver
> > which should be called as "SPI 5wire protocol". 3 wires for data, 1 -
> > chip select, 1 - busy state. Since, the slave cant fit to normal SPI
> > requirements, and can't be ready within predictable time, busy signal is
> > needed. Providing this as separate driver or part of SPI framework
> > should reduce the code for many different drivers.
> >=20
> > The actual datagram on top of your spi companion should go to
> > separate driver. There are similar (almost identical designs)
> >=20
> > can :+
> > char:+
> > dw:  +
> > gpio:+--->some_multi_end_mux_protocol--->spi_5wire_protocol->spi--->
> >=20
> > In my knowledge, only data format on top of spi_5wire_protocol is
> > different. See my notes for similar topics:
> > https://github.com/olerem/icc
> > https://github.com/olerem/spi-5wire
>=20
> With 5-wire protocol you are referencing to CLK, MISO, MOSI, CS (all
> standard SPI signals) and an extra BUSY signal. What we implemented is
> a 6-wire protocol. There is an additional REQUEST line where the SPI
> slave requests a transfer. It is like a level triggered interrupt
> request.
>=20
> Yes, for making it more generic the code in drivers/spi/companion
> could be split into a generic 6-wire protocol driver and a multiplexing
> protocol on top of it.
>=20
> How does a slave signal that it has data to be picked up with the
> 5-wire protocol?

The request and busy signals are multiplexed to one wire. So, it should
be easy to implement both, 5 and 6 wire protocol in one driver.

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--g2iqv75r7rvnlvzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlsaKpcACgkQdQOiSHVI
77SLVQgAsKUqGPKHriKUVOOkpbR1bLA+4sdqYwgj3oxuRFwKxw1aCiGWsV4r3tZj
C2wkzpXdHn0rN2ddX7vHscfB9/3+hKJWlTXP9g3b/69ZjGEGS8rfsSYqLf+rysQ4
C9VtrvxqbhFdU/IvNTUDYJUFF+pAWDDQOBXu8LhlUnaB9ppO9kpDnFDt9d9I9yn9
cf9EvzFMrS0obQJm0SECPAwI3B/IyAJxUYaUh5leOnsTSlBJO9Tj1FgvRAlSITsU
Vbxpleq6x7t+Z3RqwyNKUPBzZwPZJxUeDzauZcWjmLdx4ExyJBPSrzEmkHVd2j+z
JAy7nBstyT3zu8dkQMc1WajABMPETw==
=Oh2u
-----END PGP SIGNATURE-----

--g2iqv75r7rvnlvzl--
