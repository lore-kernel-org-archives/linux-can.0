From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 0/4] M_CAN Framework
Date: Fri, 11 Jan 2019 11:32:32 -0600
Message-ID: <20190111173236.14329-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, b29396@freescale.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

All

Well it has taken me a while to get this working and ported to a provide a
m_can framework that manages the Bosch m_can stack and abstracts away devices
to use that framework.

The m_can.c is the framework that devices register to.

The device abstractions can provide read/write capability as well as bit timings
and also provide any other initializations that are device specific.

The m_can platform code will need to be updated as I have not tested this code.
The tcan code is working.

Dan

Dan Murphy (4):
  can: m_can: Create a m_can platform framework
  can: m_can: Migrate the m_can code to use the framework
  dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
  can: tcan4x5x: Add tcan4x5x driver to the kernel

 .../devicetree/bindings/net/can/tcan4x5x.txt  |  37 +
 drivers/net/can/m_can/Kconfig                 |  18 +
 drivers/net/can/m_can/Makefile                |   4 +-
 drivers/net/can/m_can/m_can.c                 | 765 +++++++++---------
 drivers/net/can/m_can/m_can_platform.c        | 212 +++++
 drivers/net/can/m_can/m_can_platform.h        | 163 ++++
 drivers/net/can/m_can/tcan4x5x.c              | 458 +++++++++++
 7 files changed, 1253 insertions(+), 404 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
 create mode 100644 drivers/net/can/m_can/m_can_platform.c
 create mode 100644 drivers/net/can/m_can/m_can_platform.h
 create mode 100644 drivers/net/can/m_can/tcan4x5x.c

-- 
2.20.1.98.gecbdaf0899
