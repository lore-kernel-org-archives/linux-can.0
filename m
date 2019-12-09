From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 1/2] can: m_can: tcan4x5x: put the device out of standby before register access
Date: Mon,  9 Dec 2019 09:48:07 +0100
Message-ID: <20191209084808.908116-1-sean@geanix.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>, martin@geanix.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

The m_can tries to detect of niso (canfd) is available while in standby,
this function results in the following error:

tcan4x5x spi2.0 (unnamed net_device) (uninitialized): Failed to init module
tcan4x5x spi2.0: m_can device registered (irq=84, version=32)
tcan4x5x spi2.0 can2: TCAN4X5X successfully initialized.

When the tcan device comes out of reset it comes out in standby mode.
The m_can driver tries to access the control register but fails due to
the device is in standby mode.
So this patch will put the tcan device in normal mode before the m_can
driver does the initialization.

Fixes: 5443c226ba91 ("can: tcan4x5x: Add tcan4x5x driver to the kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
tcan4x5x_init will now be called from probe and the m_can call.
Would it be better to move the mode switch only to the probe function?

 drivers/net/can/m_can/tcan4x5x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index cb5fdb695ec9..7f26c2d53f8c 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -456,6 +456,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	if (ret)
 		goto out_clk;
 
+	tcan4x5x_init(mcan_class);
+
 	tcan4x5x_power_enable(priv->power, 1);
 
 	ret = m_can_class_register(mcan_class);
-- 
2.24.0
