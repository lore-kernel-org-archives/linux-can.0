From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH linux-master 0/3] MCAN updates for clock discovery
Date: Fri, 31 Jan 2020 12:34:30 -0600
Message-ID: <20200131183433.11041-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
Cc: davem@davemloft.net, Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

Hello

These are the initial fixes for issues found in and requested in
https://lore.kernel.org/patchwork/patch/1165091/

For the clock discovery and initialization.

Dan

Dan Murphy (3):
  can: tcan4x5x: Move clock init to TCAN driver
  can: m_can_platform: Move clock discovery and init to platform
  can: m_can: Remove unused clock function from the framework

 drivers/net/can/m_can/m_can.c          | 16 ------
 drivers/net/can/m_can/m_can.h          |  3 -
 drivers/net/can/m_can/m_can_platform.c | 37 +++++++++---
 drivers/net/can/m_can/tcan4x5x.c       | 78 +++++++++++++++++++-------
 4 files changed, 89 insertions(+), 45 deletions(-)

-- 
2.25.0
