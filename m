From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/6] can: ifi: Check core revision upon probe
Date: Mon, 12 Mar 2018 11:04:06 +0100
Message-ID: <20180312100410.10404-3-mkl@pengutronix.de>
References: <20180312100410.10404-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180312100410.10404-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>, Markus Marb <markus@marb.org>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

From: Marek Vasut <marex@denx.de>

Older versions of the core are not compatible with the driver due
to various intrusive fixes of the core. Read out the VER register,
check the core revision bitfield and verify if the core in use is
new enough (rev 2.1 or newer) to work correctly with this driver.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Heiko Schocher <hs@denx.de>
Cc: Markus Marb <markus@marb.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 2772d05ff11c..9fd396c3569a 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -136,6 +136,8 @@
 #define IFI_CANFD_SYSCLOCK			0x50
 
 #define IFI_CANFD_VER				0x54
+#define IFI_CANFD_VER_REV_MASK			0xff
+#define IFI_CANFD_VER_REV_MIN_SUPPORTED		0x15
 
 #define IFI_CANFD_IP_ID				0x58
 #define IFI_CANFD_IP_ID_VALUE			0xD073CAFD
@@ -933,7 +935,7 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *addr;
 	int irq, ret;
-	u32 id;
+	u32 id, rev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	addr = devm_ioremap_resource(dev, res);
@@ -947,6 +949,13 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	rev = readl(addr + IFI_CANFD_VER) & IFI_CANFD_VER_REV_MASK;
+	if (rev < IFI_CANFD_VER_REV_MIN_SUPPORTED) {
+		dev_err(dev, "This block is too old (rev %i), minimum supported is rev %i\n",
+			rev, IFI_CANFD_VER_REV_MIN_SUPPORTED);
+		return -EINVAL;
+	}
+
 	ndev = alloc_candev(sizeof(*priv), 1);
 	if (!ndev)
 		return -ENOMEM;
-- 
2.16.1
