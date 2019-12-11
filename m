From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v6 2/2] can: tcan4x5x: put the device out of standby before register access
Date: Wed, 11 Dec 2019 14:58:52 +0100
Message-ID: <20191211135852.320650-2-sean@geanix.com>
References: <20191211135852.320650-1-sean@geanix.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191211135852.320650-1-sean@geanix.com>
Sender: stable-owner@vger.kernel.org
To: mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

The m_can tries to detect if Non ISO Operation is available while in
standby, this function results in the following error:

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
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v3:
 - Fixed fixes tag

Changes since v4:
 - None

Changes since v5:
 - None

 Sorry for the mess :)

 drivers/net/can/m_can/tcan4x5x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index dcfa85edc787..8ed2813f227e 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -482,6 +482,10 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	tcan4x5x_power_enable(priv->power, 1);
 
+	ret = tcan4x5x_init(mcan_class);
+	if (ret)
+		goto out_power;
+
 	ret = m_can_class_register(mcan_class);
 	if (ret)
 		goto out_power;
-- 
2.24.0
