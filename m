From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Date: Wed, 10 Jun 2020 13:17:05 +0530
Message-ID: <20200610074711.10969-1-manivannan.sadhasivam@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org
Cc: kernel@martin.sperl.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
List-Id: linux-can.vger.kernel.org

Hello,

This series adds CAN network driver support for Microchip MCP25XXFD CAN
Controller with MCP2517FD as the target controller version. This series is
mostly inspired (or taken) from the previous iterations posted by Martin Sperl.
I've trimmed down the parts which are not necessary for the initial version
to ease review. Still the series is relatively huge but I hope to get some
reviews (post -rcX ofc!).

Link to the origial series posted by Martin:
https://www.spinics.net/lists/devicetree/msg284462.html

I've not changed the functionality much but done some considerable amount of
cleanups. This series has been tested on 96Boards RB3 platform by myself and
Martin has tested the previous version on Rpi3 with external MCP2517FD
controller.

Thanks,
Mani

Manivannan Sadhasivam (1):
  MAINTAINERS: Add entry for Microchip MCP25XXFD CAN network driver

Martin Sperl (5):
  dt-bindings: can: Document devicetree bindings for MCP25XXFD
  can: mcp25xxfd: Add Microchip MCP25XXFD CAN-FD driver infrastructure
  can: mcp25xxfd: Add support for CAN reception
  can: mcp25xxfd: Add CAN transmission support
  can: mcp25xxfd: Optimize TEF read by avoiding unnecessary SPI
    transfers

 .../bindings/net/can/microchip,mcp25xxfd.yaml |  82 +++
 MAINTAINERS                                   |   8 +
 drivers/net/can/spi/Kconfig                   |   2 +
 drivers/net/can/spi/Makefile                  |   2 +
 drivers/net/can/spi/mcp25xxfd/Kconfig         |   5 +
 drivers/net/can/spi/mcp25xxfd/Makefile        |  11 +
 .../net/can/spi/mcp25xxfd/mcp25xxfd_base.c    | 177 +++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_base.h    |  14 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c | 538 ++++++++++++++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.h |  52 ++
 .../can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c    | 305 ++++++++
 .../can/spi/mcp25xxfd/mcp25xxfd_can_fifo.h    |  16 +
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_id.h  |  69 ++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c | 674 ++++++++++++++++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_int.h |  18 +
 .../can/spi/mcp25xxfd/mcp25xxfd_can_priv.h    | 144 ++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.c  | 233 ++++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.h  |  18 +
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c  | 653 +++++++++++++++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.h  |  86 +++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_cmd.c | 226 ++++++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_cmd.h |  84 +++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_crc.c |  31 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_crc.h |  15 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_ecc.c |  74 ++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_ecc.h |  16 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_int.c |  71 ++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_int.h |  15 +
 .../net/can/spi/mcp25xxfd/mcp25xxfd_priv.h    |  50 ++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_regs.h    | 661 +++++++++++++++++
 30 files changed, 4350 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
 create mode 100644 drivers/net/can/spi/mcp25xxfd/Kconfig
 create mode 100644 drivers/net/can/spi/mcp25xxfd/Makefile
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_base.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_base.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_id.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_priv.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_cmd.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_cmd.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_crc.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_crc.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_ecc.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_ecc.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_int.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_int.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_priv.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_regs.h

-- 
2.17.1
