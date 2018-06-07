From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/5] can: enable multi-queue for SocketCAN devices
Date: Thu, 7 Jun 2018 09:22:35 +0200
Message-ID: <e27cbd23-f922-218b-b314-ff99e1401609@hartkopp.net>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jonas <mark.jonas@de.bosch.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hs@denx.de, yi.zhu5@cn.bosch.com
List-Id: linux-can.vger.kernel.org



On 06/05/2018 08:43 PM, Mark Jonas wrote:
> Upon request by Marc Kleine-Budde this patch series does not only
> contain our patch to enable enable multi-queue for SocketCAN devices
> but also a driver (Companion driver suite) which makes active use of
> this feature.
> 
> The driver suite implements
>    - two CAN interfaces
>    - one generic command interfaces
> and offers a SocketCAN as well as a char device interface. The
> SocketCAN interface supports multi-queue.
> 
> The functionality bases on an external peripheral chip named Companion.
> It offers two CAN interfaces, each has 8 prioritized transmit FIFOs as
> well as one receive FIFO. Besides CAN, undisclosed additional functions
> can be accessed through the char device.
> 
> A standard SPI interface with two additional lines for flow control is
> used. The Companion chip is the SPI slave.
> 
> The driver suite consists of three separate drivers. The following
> diagram illustrates the dependencies in layers.
> 
>             /dev/companion       SocketCAN                User Space
> -------------------------------------------------------------------
>           +----------------+ +---------------+
>           | companion-char | | companion-can |
>           +----------------+ +---------------+
>           +----------------------------------+
>           |          companion-spi           |
>           +----------------------------------+
>           +----------------------------------+
>           |     standard SPI subsystem       |
>           +----------------------------------+          Linux Kernel
> -------------------------------------------------------------------
>                 | | | |      | |                            Hardware
>              CS-+ | | |      | +-BUSY
>              CLK--+ | |      +---REQUEST
>              MOSI---+ |
>              MISO-----+
> 
> companion-spi
>     core.c: handles SPI, sysfs entry and interface to upper layer
>     protocol-manager.c: handles protocol with the SPI HW
>     queue-manager.c: handles buffering and packets scheduling
> 
> companion-can
>     makes use of multi-queue support and allows to use tc to configure
>     the queuing discipline (e.g. mqprio). Together with the SO_PRIORITY
>     socket option this allows to specify the FIFO a CAN frame shall be
>     sent to.
> 
> companion-char
>     handles messages to other undisclosed functionality beyond CAN.
> 
> Zhu Yi (5):
>    can: enable multi-queue for SocketCAN devices
>    spi: implement companion-spi driver
>    char: implement companion-char driver
>    can: implement companion-can driver
>    spi,can,char: add companion DT binding documentation
> 
>   .../devicetree/bindings/spi/bosch,companion.txt    |   82 ++
>   drivers/char/Kconfig                               |    7 +
>   drivers/char/Makefile                              |    2 +
>   drivers/char/companion-char.c                      |  367 ++++++
>   drivers/net/can/Kconfig                            |    8 +
>   drivers/net/can/Makefile                           |    1 +
>   drivers/net/can/companion-can.c                    |  694 ++++++++++++

Please place the companion driver in

drivers/net/can/spi/companion.c

It also makes more sense in the Kconfig structure.

Probably this naming scheme also makes sense for

linux/drivers/char/spi/companion.c

then ...

If not it should be named at least

drivers/char/companion-spi.c

or

drivers/char/spi-companion.c

BR Oliver

>   drivers/net/can/dev.c                              |    8 +-
>   drivers/spi/Kconfig                                |    2 +
>   drivers/spi/Makefile                               |    2 +
>   drivers/spi/companion/Kconfig                      |    5 +
>   drivers/spi/companion/Makefile                     |    2 +
>   drivers/spi/companion/core.c                       | 1189 ++++++++++++++++++++
>   drivers/spi/companion/protocol-manager.c           | 1035 +++++++++++++++++
>   drivers/spi/companion/protocol-manager.h           |  348 ++++++
>   drivers/spi/companion/protocol.h                   |  273 +++++
>   drivers/spi/companion/queue-manager.c              |  146 +++
>   drivers/spi/companion/queue-manager.h              |  245 ++++
>   include/linux/can/dev.h                            |    7 +-
>   include/linux/companion.h                          |  258 +++++
>   20 files changed, 4677 insertions(+), 4 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/spi/bosch,companion.txt
>   create mode 100644 drivers/char/companion-char.c
>   create mode 100644 drivers/net/can/companion-can.c
>   create mode 100644 drivers/spi/companion/Kconfig
>   create mode 100644 drivers/spi/companion/Makefile
>   create mode 100644 drivers/spi/companion/core.c
>   create mode 100644 drivers/spi/companion/protocol-manager.c
>   create mode 100644 drivers/spi/companion/protocol-manager.h
>   create mode 100644 drivers/spi/companion/protocol.h
>   create mode 100644 drivers/spi/companion/queue-manager.c
>   create mode 100644 drivers/spi/companion/queue-manager.h
>   create mode 100644 include/linux/companion.h
> 
