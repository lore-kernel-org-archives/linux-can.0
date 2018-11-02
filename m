From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 0/6] Add Support for MCAN transceivers in AM65x-evm
Date: Sat, 3 Nov 2018 00:56:10 +0530
Message-ID: <20181102192616.28291-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com, faiz_abbas@ti.com
List-Id: linux-can.vger.kernel.org

The following patches add support for CAN transceivers in the AM65x-evm.

The legacy transceiver implementation has a transceiver node as a child of the
m_can node with a max-bitrate property which is read directly by the 
of_can_transceiver() API. The transceivers on the present platform however,
require some configuration (pulling the gpio connected to the stb line of
the transceiver low) before they can start sending messages.

The new implementation models the transceiver as a phy and implements the
max-bitrate as a phy attribute.

patch 1 adds the max_bitrate attribute to the phy core. It also implements the API
to be used by the consumer to get the attribute.

patches 2 & 3 implement a generic phy driver for simple implementations.

patches 4,5 & 6 implement the transceiver as a phy to the m_can driver.

Note: Pinmux and GPIO support for am65x-evm are not yet implemented in upstream.
So I tested this implementation with some out of tree patches on top of linux-next.
dts patches will be posted as soon as the above frameworks are available.

Faiz Abbas (6):
  phy: Add max_bitrate attribute & phy_get_max_bitrate()
  dt-bindings: phy: phy-of-simple: Document new binding
  phy: phy-of-simple: Add support for simple generic phy driver
  dt-bindings: can: m_can: Document transceiver implementation as a phy
  dt-bindings: can: can-transceiver: Remove legacy binding documentation
  can: m_can: Add support for transceiver as phy

 .../bindings/net/can/can-transceiver.txt      | 24 -----
 .../devicetree/bindings/net/can/m_can.txt     | 24 +++--
 .../devicetree/bindings/phy/phy-of-simple.txt | 29 ++++++
 drivers/net/can/m_can/m_can.c                 | 23 ++++-
 drivers/phy/Kconfig                           |  7 ++
 drivers/phy/Makefile                          |  1 +
 drivers/phy/phy-of-simple.c                   | 90 +++++++++++++++++++
 include/linux/phy/phy.h                       |  5 ++
 8 files changed, 170 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-of-simple.txt
 create mode 100644 drivers/phy/phy-of-simple.c

-- 
2.18.0
