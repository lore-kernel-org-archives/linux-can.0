From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/5] can: enable multi-queue for SocketCAN devices
Date: Thu, 7 Jun 2018 11:49:53 +0200
Message-ID: <bb1b5a1c-9f62-a35b-040f-d212d88ffa6c@hartkopp.net>
References: <e8c47bca2ea64b5ab900f4f1e98bb405@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e8c47bca2ea64b5ab900f4f1e98bb405@de.bosch.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hs@denx.de" <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
List-Id: linux-can.vger.kernel.org



On 06/07/2018 10:06 AM, Jonas Mark (BT-FIR/ENG1) wrote:
> Hi Oliver,
> 
>>> The driver suite consists of three separate drivers. The following
>>> diagram illustrates the dependencies in layers.
>>>
>>>              /dev/companion       SocketCAN                User Space
>>> -------------------------------------------------------------------
>>>            +----------------+ +---------------+
>>>            | companion-char | | companion-can |
>>>            +----------------+ +---------------+
>>>            +----------------------------------+
>>>            |          companion-spi           |
>>>            +----------------------------------+
>>>            +----------------------------------+
>>>            |     standard SPI subsystem       |
>>>            +----------------------------------+          Linux Kernel
>>> -------------------------------------------------------------------
>>>                  | | | |      | |                            Hardware
>>>               CS-+ | | |      | +-BUSY
>>>               CLK--+ | |      +---REQUEST
>>>               MOSI---+ |
>>>               MISO-----+
>>>
>>> companion-spi
>>>      core.c: handles SPI, sysfs entry and interface to upper layer
>>>      protocol-manager.c: handles protocol with the SPI HW
>>>      queue-manager.c: handles buffering and packets scheduling
>>>
>>> companion-can
>>>      makes use of multi-queue support and allows to use tc to configure
>>>      the queuing discipline (e.g. mqprio). Together with the SO_PRIORITY
>>>      socket option this allows to specify the FIFO a CAN frame shall be
>>>      sent to.
>>>
>>> companion-char
>>>      handles messages to other undisclosed functionality beyond CAN.
> 
>>>    .../devicetree/bindings/spi/bosch,companion.txt    |   82 ++
>>>    drivers/char/Kconfig                               |    7 +
>>>    drivers/char/Makefile                              |    2 +
>>>    drivers/char/companion-char.c                      |  367 ++++++
>>>    drivers/net/can/Kconfig                            |    8 +
>>>    drivers/net/can/Makefile                           |    1 +
>>>    drivers/net/can/companion-can.c                    |  694 ++++++++++++
>>
>> Please place the companion driver in
>>
>> drivers/net/can/spi/companion.c
>>
>> It also makes more sense in the Kconfig structure.
>>
>> Probably this naming scheme also makes sense for
>>
>> linux/drivers/char/spi/companion.c
>>
>> then ...
>>
>> If not it should be named at least
>>
>> drivers/char/companion-spi.c
>>
>> or
>>
>> drivers/char/spi-companion.c
> 
> We intentionally left out the spi in the driver path / name because
> only the drivers/spi/companion/* driver knows that that it is connected
> to SPI. The others (drivers/net/can/companion-can.c and
> drivers/char/companion-char.c) only know the API. This could also be
> supplied by a driver which talks to the Companion via a different
> interface. Actually, we started with a UART connection but switched to
> SPI due to latency issues.

Ok, got it.

> Should we still change it?

At least I would then vote for

drivers/char/companion.c
drivers/net/can/companion.c

instead of

drivers/char/companion-char.c
drivers/net/can/companion-can.c

as you would have companion-users in different driver subsystems that 
are already clearly referenced by their path.

The modules itself should still be named with companion-can of course 
(as-is right now).

Btw.

+#define DRIVER_NAME     "bosch,companion-can"

+static const struct can_bittiming_const companion_can_bittiming_const = {
+	.name      = "bosch,companion",


Is there any reason why it's not only "companion-can" or "companion"?
The fact that the driver is provided by Bosch is visible in the source code.

Best regards,
Oliver


> 
>>>    drivers/net/can/dev.c                              |    8 +-
>>>    drivers/spi/Kconfig                                |    2 +
>>>    drivers/spi/Makefile                               |    2 +
>>>    drivers/spi/companion/Kconfig                      |    5 +
>>>    drivers/spi/companion/Makefile                     |    2 +
>>>    drivers/spi/companion/core.c                       | 1189 ++++++++++++++++++++
>>>    drivers/spi/companion/protocol-manager.c           | 1035 +++++++++++++++++
>>>    drivers/spi/companion/protocol-manager.h           |  348 ++++++
>>>    drivers/spi/companion/protocol.h                   |  273 +++++
>>>    drivers/spi/companion/queue-manager.c              |  146 +++
>>>    drivers/spi/companion/queue-manager.h              |  245 ++++
>>>    include/linux/can/dev.h                            |    7 +-
>>>    include/linux/companion.h                          |  258 +++++
>>>    20 files changed, 4677 insertions(+), 4 deletions(-)
>>>    create mode 100644
>> Documentation/devicetree/bindings/spi/bosch,companion.txt
>>>    create mode 100644 drivers/char/companion-char.c
>>>    create mode 100644 drivers/net/can/companion-can.c
>>>    create mode 100644 drivers/spi/companion/Kconfig
>>>    create mode 100644 drivers/spi/companion/Makefile
>>>    create mode 100644 drivers/spi/companion/core.c
>>>    create mode 100644 drivers/spi/companion/protocol-manager.c
>>>    create mode 100644 drivers/spi/companion/protocol-manager.h
>>>    create mode 100644 drivers/spi/companion/protocol.h
>>>    create mode 100644 drivers/spi/companion/queue-manager.c
>>>    create mode 100644 drivers/spi/companion/queue-manager.h
>>>    create mode 100644 include/linux/companion.h
> 
> Greetings,
> Mark
> 
> Building Technologies, Panel Software Fire (BT-FIR/ENG1)
> Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY | www.boschsecurity.com
> 
> Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118
> Aufsichtsratsvorsitzender: Stefan Hartung; Geschäftsführung: Gert van Iperen, Andreas Bartz, Thomas Quante, Bernhard Schuster
> 
