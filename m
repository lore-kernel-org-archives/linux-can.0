From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 1/2] can: flexcan: add support for DT property 'wakeup-source'
Date: Tue,  9 Apr 2019 10:39:48 +0200
Message-ID: <20190409083949.27917-1-sean@geanix.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can@vger.kernel.org, mkl@pengutronix.de, robh+dt@kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

The flexcan controller can be forced as a wakeup source by
stating that explicitly in the device's .dts file using the
"wakeup-source" boolean property.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/flexcan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index c46e6ce22701..df3d2abd98e4 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1373,6 +1373,9 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 
 	device_set_wakeup_capable(&pdev->dev, true);
 
+	if (of_property_read_bool(np, "wakeup-source"))
+		device_set_wakeup_enable(&pdev->dev, true);
+
 	return 0;
 }
 
-- 
2.21.0
