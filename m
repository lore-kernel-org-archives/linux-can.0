From: Dan Murphy <dmurphy@ti.com>
Subject: [[RFC] PATCH v2 0/4] M_CAN framework patches
Date: Wed, 5 Dec 2018 13:28:21 -0600
Message-ID: <20181205192825.11555-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

All

This patch series contains no code modifications.  Based on Wolfgangs advice
I moved the files to different names and committe them independently so they
can be reviewed easier.

The first patch create the framework code abstracted from the main m_can.c.
The second patch adapts the m_can.c to use the framework code
The final patches add the TCAN device to the use the m_can framework.

Again these patches are RFC and no code modifications were made in v2.
I will be updating the code based on this version.

Dan

Dan Murphy (4):
  can: m_can: Create a m_can platform framework
  can: m_can: Migrate the m_can code to use the framework
  dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
  can: tcan4x5x: Add tcan4x5x driver to the kernel

 .../devicetree/bindings/net/can/tcan4x5x.txt  |  34 ++
 drivers/net/can/m_can/Kconfig                 |  18 +
 drivers/net/can/m_can/Makefile                |   4 +-
 drivers/net/can/m_can/m_can.c                 | 479 +++++++++---------
 drivers/net/can/m_can/m_can_platform.c        | 168 ++++++
 drivers/net/can/m_can/m_can_platform.h        | 100 ++++
 drivers/net/can/m_can/tcan4x5x.c              | 321 ++++++++++++
 7 files changed, 870 insertions(+), 254 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
 create mode 100644 drivers/net/can/m_can/m_can_platform.c
 create mode 100644 drivers/net/can/m_can/m_can_platform.h
 create mode 100644 drivers/net/can/m_can/tcan4x5x.c

-- 
2.20.0.rc2.7.g965798d1f2
