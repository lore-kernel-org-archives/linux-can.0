From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/4] can: mcp251x: Make use of device properties
Date: Tue,  3 Sep 2019 15:42:55 +0300
Message-ID: <20190903124259.60920-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-can.vger.kernel.org

The purpose of this series is to simplify driver by switching to use device
properties. In particular it allows to drop legacy platform data.

Patch 1 switches driver to use devm_clk_get_optional() API.

Patch 2 unifies getting the driver data independently of the table which
provides it.

Patch 3 drops extra check for regulator presence by switch to use an already
present wrapper.

And patch 4 gets rid of legacy platform data.

Changelog v2:
- add patch 4 to get rid of legacy platform data

Andy Shevchenko (4):
  can: mcp251x: Use devm_clk_get_optional() to get the input clock
  can: mcp251x: Make use of device property API
  can: mcp251x: Call wrapper instead of regulator_disable()
  can: mcp251x: Get rid of legacy platform data

 arch/arm/mach-pxa/icontrol.c         |  9 ++--
 arch/arm/mach-pxa/zeus.c             |  9 ++--
 drivers/net/can/spi/mcp251x.c        | 65 +++++++++++-----------------
 include/linux/can/platform/mcp251x.h | 22 ----------
 4 files changed, 36 insertions(+), 69 deletions(-)
 delete mode 100644 include/linux/can/platform/mcp251x.h

-- 
2.23.0.rc1
