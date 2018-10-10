From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 0/3] M_CAN Framework rework
Date: Wed, 10 Oct 2018 09:20:52 -0500
Message-ID: <20181010142055.25271-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

All

This patch series creates a m_can core framework that devices can register
to.  The m_can core manages the Bosch IP and CAN frames.  Each device that
is registered is responsible for managing device specific functions.

This rewrite was suggested in a device driver submission for the TCAN4x5x
device
Reference upstream post:
https://lore.kernel.org/patchwork/patch/984163/

For instance the TCAN device is a SPI device that uses a specific data payload to
determine writes and reads.  In addition the device has a reset input as well
as a wakeup pin.  The register offset of the m_can registers differs and must
be set by the device attached to the core.

The m_can core will use iomapped writes and reads as the default mechanism for
writing and reading.  The device driver can provide over rides for this.

This patch series is not complete as it does not handle the CAN interrupts
nor can perform a CAN write.  If this patch series is deemed acceptable I will
finish debugging the driver and post a non RFC series.

Finally I did attempt to reduce the first patch with various git format patch
directives but none seemed to reduce the patch.

Dan

Dan Murphy (3):
  can: m_can: Create m_can core to leverage common code
  dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
  can: tcan4x5x: Add tcan4x5x driver to the kernel

 .../devicetree/bindings/net/can/tcan4x5x.txt  |   34 +
 drivers/net/can/m_can/Kconfig                 |   18 +
 drivers/net/can/m_can/Makefile                |    4 +-
 drivers/net/can/m_can/m_can.c                 | 1683 +----------------
 .../net/can/m_can/{m_can.c => m_can_core.c}   |  479 +++--
 drivers/net/can/m_can/m_can_core.h            |  100 +
 drivers/net/can/m_can/tcan4x5x.c              |  321 ++++
 7 files changed, 722 insertions(+), 1917 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
 copy drivers/net/can/m_can/{m_can.c => m_can_core.c} (83%)
 create mode 100644 drivers/net/can/m_can/m_can_core.h
 create mode 100644 drivers/net/can/m_can/tcan4x5x.c

-- 
2.19.0
