From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH v2 0/5] can: enable multi-queue for SocketCAN devices
Date: Wed, 11 Jul 2018 17:00:49 +0000
Message-ID: <f858e62c59754a0c9f785b3dfc7aa50f@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hs@denx.de" <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, "Petrovic Petar (CM-CI1/ENP1)" <Petar.Petrovic2@de.bosch.com>, "Baetge Stephan (CM-CI1/ENP1)" <Stephan.Baetge@de.bosch.com>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "socketcan@hartkopp.net" <socketcan@hartkopp.net>, "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
List-Id: linux-can.vger.kernel.org

Hi Marc,

> Betreff: [PATCH v2 0/5] can: enable multi-queue for SocketCAN devices

You have been interested in seeing the reason why we are proposing the
"can: enable multi-queue for SocketCAN devices" patch for the Linux
mainline. So far I have not heard from you. Do you now see a chance of
getting the patch accepted?

>=20
> Changes in v2:
> - use GPIO descriptor API
> - make error handling pattern consistent
> - use more kernel helper macros and functions
> - fix coding style issues
> - remove superfluous subsystem name from filename
>=20
> ---
>=20
> Upon request by Marc Kleine-Budde this patch series does not only
> contain our patch to enable enable multi-queue for SocketCAN devices
> but also a driver (Companion driver suite) which makes active use of
> this feature.
>=20
> The driver suite implements
>   - two CAN interfaces
>   - one generic command interfaces
> and offers a SocketCAN as well as a char device interface. The
> SocketCAN interface supports multi-queue.
>=20
> The functionality bases on an external peripheral chip named Companion.
> It offers two CAN interfaces, each has 8 prioritized transmit FIFOs as
> well as one receive FIFO. Besides CAN, undisclosed additional functions
> can be accessed through the char device.
>=20
> A standard SPI interface with two additional lines for flow control is
> used. The Companion chip is the SPI slave.
>=20
> The driver suite consists of three separate drivers. The following
> diagram illustrates the dependencies in layers.
>=20
>            /dev/companion       SocketCAN                User Space
> -------------------------------------------------------------------
>          +----------------+ +---------------+
>          | companion-char | | companion-can |
>          +----------------+ +---------------+
>          +----------------------------------+
>          |          companion-spi           |
>          +----------------------------------+
>          +----------------------------------+
>          |     standard SPI subsystem       |
>          +----------------------------------+          Linux Kernel
> -------------------------------------------------------------------
>                | | | |      | |                            Hardware
>             CS-+ | | |      | +-BUSY
>             CLK--+ | |      +---REQUEST
>             MOSI---+ |
>             MISO-----+
>=20
> companion-spi
>    core.c: handles SPI, sysfs entry and interface to upper layer
>    protocol-manager.c: handles protocol with the SPI HW
>    queue-manager.c: handles buffering and packets scheduling
>=20
> companion-can
>    makes use of multi-queue support and allows to use tc to configure
>    the queuing discipline (e.g. mqprio). Together with the SO_PRIORITY
>    socket option this allows to specify the FIFO a CAN frame shall be
>    sent to.
>=20
> companion-char
>    handles messages to other undisclosed functionality beyond CAN.
>=20
> Zhu Yi (5):
>   can: enable multi-queue for SocketCAN devices
>   spi: implement companion-spi driver
>   char: implement companion-char driver
>   can: implement companion-can driver
>   spi,can,char: add companion DT binding documentation
>=20
>  .../devicetree/bindings/spi/bosch,companion.txt    |   82 ++
>  drivers/char/Kconfig                               |    7 +
>  drivers/char/Makefile                              |    3 +
>  drivers/char/companion.c                           |  360 ++++++
>  drivers/net/can/Kconfig                            |    8 +
>  drivers/net/can/Makefile                           |    2 +
>  drivers/net/can/companion.c                        |  693 ++++++++++++
>  drivers/net/can/dev.c                              |    8 +-
>  drivers/spi/Kconfig                                |    2 +
>  drivers/spi/Makefile                               |    2 +
>  drivers/spi/companion/Kconfig                      |    5 +
>  drivers/spi/companion/Makefile                     |    2 +
>  drivers/spi/companion/core.c                       | 1185 ++++++++++++++=
++++++
>  drivers/spi/companion/protocol-manager.c           | 1032 ++++++++++++++=
+++
>  drivers/spi/companion/protocol-manager.h           |  341 ++++++
>  drivers/spi/companion/protocol.h                   |  273 +++++
>  drivers/spi/companion/queue-manager.c              |  144 +++
>  drivers/spi/companion/queue-manager.h              |  245 ++++
>  include/linux/can/dev.h                            |    7 +-
>  include/linux/companion.h                          |  259 +++++
>  20 files changed, 4656 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/bosch,companion=
.txt
>  create mode 100644 drivers/char/companion.c
>  create mode 100644 drivers/net/can/companion.c
>  create mode 100644 drivers/spi/companion/Kconfig
>  create mode 100644 drivers/spi/companion/Makefile
>  create mode 100644 drivers/spi/companion/core.c
>  create mode 100644 drivers/spi/companion/protocol-manager.c
>  create mode 100644 drivers/spi/companion/protocol-manager.h
>  create mode 100644 drivers/spi/companion/protocol.h
>  create mode 100644 drivers/spi/companion/queue-manager.c
>  create mode 100644 drivers/spi/companion/queue-manager.h
>  create mode 100644 include/linux/companion.h
>=20
> --
> 2.7.4

Greetings,
Mark

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
