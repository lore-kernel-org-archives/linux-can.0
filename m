From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH 2/5] spi: implement companion-spi driver
Date: Fri, 8 Jun 2018 06:56:23 +0000
Message-ID: <bb9540ed90e944c7a8e27287e6df25d5@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: de-DE
Sender: netdev-owner@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, netdev <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heiko Schocher <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
List-Id: linux-can.vger.kernel.org

Hi Oleksij,

> > > > +               if (slave_is_not_busy(priv))
> > > > +                       return 0;
> > > > +
> > >
> > > > +               udelay(READY_POLL_US_GRAN);
> > >
> > > Should it be atomic?
> > > Can it use read_poll_* type of helpers instead?
> >
> > Yes, it shall be atomic because we need to reduce the latency at
> > detecting the de-assertion of the busy signal. We accept that this will
> > cost CPU time.
> >
> > In case the Companion itself is very busy and does not reply quickly we
> > are have second polling loop below which sleeps longer and is non-atomi=
c.
>=20
> I can confirm, this make huge impact on protocol performance. And this
> protocol is not really the speed runner.

The challenge is that the protocol is synchronous and without back to
back transfers.

> you can send dummy message to set CS.
> +	struct spi_transfer t =3D {
> +		.len =3D 0,
> +		.cs_change =3D 1,
> +	};
>=20
> +	/* send dummy to trigger CS */
> +	reinit_completion(&priv->fc_complete);
> +	spi_sync_locked(spi, &m);
>=20
> see my ancient unfinished code:
> https://patchwork.kernel.org/patch/9418511/

We will check it out.

> In general, this part of the code, can be provided as separate driver
> which should be called as "SPI 5wire protocol". 3 wires for data, 1 -
> chip select, 1 - busy state. Since, the slave cant fit to normal SPI
> requirements, and can't be ready within predictable time, busy signal is
> needed. Providing this as separate driver or part of SPI framework
> should reduce the code for many different drivers.
>=20
> The actual datagram on top of your spi companion should go to
> separate driver. There are similar (almost identical designs)
>=20
> can :+
> char:+
> dw:  +
> gpio:+--->some_multi_end_mux_protocol--->spi_5wire_protocol->spi--->
>=20
> In my knowledge, only data format on top of spi_5wire_protocol is
> different. See my notes for similar topics:
> https://github.com/olerem/icc
> https://github.com/olerem/spi-5wire

With 5-wire protocol you are referencing to CLK, MISO, MOSI, CS (all
standard SPI signals) and an extra BUSY signal. What we implemented is
a 6-wire protocol. There is an additional REQUEST line where the SPI
slave requests a transfer. It is like a level triggered interrupt
request.

Yes, for making it more generic the code in drivers/spi/companion
could be split into a generic 6-wire protocol driver and a multiplexing
protocol on top of it.

How does a slave signal that it has data to be picked up with the
5-wire protocol?

Greetings,
Mark

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
