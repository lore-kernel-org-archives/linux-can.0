From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/11] can: Remove redundant spi driver bus initialization
Date: Thu, 24 Nov 2011 16:29:21 +0100
Message-ID: <1322148561-25138-11-git-send-email-lars@metafoo.de>
References: <1322148561-25138-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322148561-25138-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

In ancient times it was necessary to manually initialize the bus field of an
spi_driver to spi_bus_type. These days this is done in spi_driver_register(),
so we can drop the manual assignment.

The patch was generated using the following coccinelle semantic patch:
// <smpl>
@@
identifier _driver;
@@
struct spi_driver _driver = {
	.driver = {
-		.bus = &spi_bus_type,
	},
};
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org
---
 drivers/net/can/mcp251x.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index 330140e..5e10da5 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -1185,7 +1185,6 @@ MODULE_DEVICE_TABLE(spi, mcp251x_id_table);
 static struct spi_driver mcp251x_can_driver = {
 	.driver = {
 		.name = DEVICE_NAME,
-		.bus = &spi_bus_type,
 		.owner = THIS_MODULE,
 	},
 
-- 
1.7.7.1
