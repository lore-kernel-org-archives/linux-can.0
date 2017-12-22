From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v6 0/6] Add M_CAN Support for Dra76 platform
Date: Fri, 22 Dec 2017 19:01:22 +0530
Message-ID: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, faiz_abbas@ti.com, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com
List-Id: linux-can.vger.kernel.org

This patch series adds support for M_CAN on the TI Dra76
platform. Device tree patches will be sent separately.
A bunch of patches were sent before by
Franklin Cooper <fcooper@ti.com>. I have clubbed the
series together and rebased to the latest kernel.

v6 changes:
Dropped the patches to make hclk optional. Drivers
which enable hclk as the interface clock using
pm_runtime calls must still provide a hclk in the
clocks property.

Support higher speed CAN-FD bitrate:
The community decided that data sampling point be used
for the secondary sampling point here
https://patchwork.kernel.org/patch/9909845/

Franklin S Cooper Jr (6):
  can: dev: Add support for limiting configured bitrate
  can: m_can: Add call to of_can_transceiver
  can: m_can: Add PM Runtime
  can: m_can: Support higher speed CAN-FD bitrates
  dt-bindings: can: m_can: Document new can transceiver binding
  dt-bindings: can: can-transceiver: Document new binding

 .../bindings/net/can/can-transceiver.txt           | 24 +++++++
 .../devicetree/bindings/net/can/m_can.txt          |  9 +++
 drivers/net/can/dev.c                              | 39 +++++++++++
 drivers/net/can/m_can/m_can.c                      | 81 ++++++++++++++++++++--
 include/linux/can/dev.h                            |  8 +++
 5 files changed, 156 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt

-- 
2.7.4
