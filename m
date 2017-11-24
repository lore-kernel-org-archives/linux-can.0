From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 0/2] Microchip mcp2517fd can controller driver
Date: Fri, 24 Nov 2017 18:35:07 +0000
Message-ID: <20171124183509.12810-1-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-can.vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

This patchset adds a driver for the mcp2517fd CanFD controller.

Most of the features of the controller are supported by this driver release.

The controller includes a few features that the current core Can(FD)
implementation does not support:
* Transmit Bandwidth Sharing bits
  - this waits for a configurable number of syncronization bits before
    atempting to transmit the next frame - for the moment controllable
    via a module parameter
* SID11 with CanFD frames
  - at this moment not supported by driver
* 3 transmit attempts in addition to ONE_SHOT
* transmitter delay compensation configurations
* micro second exact transmission and reception timestamps
  - used internally by driver
* variable number of tx-fifos
  - exposed via module parameter at this moment

The driver has been heavily optimized so that it can handle
a 100% utilized 1MHz Can-bus (with 11 bit can frames with DLC=0)
even on less powerfull SOCs like the raspberry pi 1 without
dropping frames due to driver/spi latencies (still dropps
are observed in the can/network stack).

To achive this the driver includes several code optimization
Two of which prefers continuous long spi transfers over multiple
small individual spi transfers of variable length.
This is an optimization that would favour spi dma transfers instead
of more expensive PIO in typical SPI controllers.
Both of them can get explicitly enabled by the use of a module parameter.
One of those is automatically used in the case of Can2.0 only bus
configurations.

Finer details of the implementation and rational is included with
the driver code it self for future reference.

The driver has also been tested for basic CanFD transfers with
BRS up to 5.7Mhz data bitrates - the available transceiver did
not allow for faster rates...

The driver itself exposes lots of internal data/statistics via
debugfs.

The driver implements a lock-less design for transmissions
making use instead of prepared spi messages submitted via spi_async
for transmission in the start_xmit_start code without requireing
an extra workqueue and the corresponding latencies.

Martin Sperl (2):
  dt-binding: can: mcp2517fd: document device tree bindings
  can: mcp2517fd: Add Microchip mcp2517fd CAN FD driver

 .../bindings/net/can/microchip,mcp2517fd.txt       |   47 +
 drivers/net/can/spi/Kconfig                        |    6 +
 drivers/net/can/spi/Makefile                       |    1 +
 drivers/net/can/spi/mcp2517fd.c                    | 3733 ++++++++++++++++++++
 4 files changed, 3787 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp2517fd.txt
 create mode 100644 drivers/net/can/spi/mcp2517fd.c

--
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
