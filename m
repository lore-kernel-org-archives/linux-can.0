From: Pankaj Sharma <pankj.sharma@samsung.com>
Subject: [PATCH 1/2] can: m_can_platform: set net_device structure as driver
 data
Date: Tue, 19 Nov 2019 15:50:37 +0530
Message-ID: <1574158838-4616-2-git-send-email-pankj.sharma@samsung.com>
References: <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
        <CGME20191119102155epcas5p34ca3dfaba9eef8de24d1bc9d64ef5335@epcas5p3.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, dmurphy@ti.com, rcsekar@samsung.com, pankaj.dubey@samsung.com, Pankaj Sharma <pankj.sharma@samsung.com>, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

A device driver for CAN controller hardware registers itself with the
Linux network layer as a network device. So, the driver data for m_can
should ideally be of type net_device.

Fixes: f524f829b75a ("can: m_can: Create a m_can platform framework")

Signed-off-by: Pankaj Sharma <pankj.sharma@samsung.com>
Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
---
 drivers/net/can/m_can/m_can_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 6ac4c35..2eaa354 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -107,7 +107,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class->is_peripheral = false;
 
-	platform_set_drvdata(pdev, mcan_class->dev);
+	platform_set_drvdata(pdev, mcan_class->net);
 
 	m_can_init_ram(mcan_class);
 
-- 
2.7.4
