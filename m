From: Amit Virdi <amit.virdi@st.com>
Subject: [PATCH 1/3] can: c_can: Correct register alignment info passing through DT
Date: Thu, 20 Dec 2012 15:35:42 +0530
Message-ID: <4fb69be55045aa390e73c56b215a4b4afb091d1a.1355996839.git.amit.virdi@st.com>
References: <cover.1355996839.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:50903 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751431Ab2LTKGJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Dec 2012 05:06:09 -0500
In-Reply-To: <cover.1355996839.git.amit.virdi@st.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, bhupesh.sharma@st.com, anilkumar@ti.com, spear-devel@list.st.com, Amit Virdi <amit.virdi@st.com>

Depending upon the integration of the C_CAN controller in the SoC, the
registers may be aligned to 16-bit or 32-bit boundary. The device tree
support added to the driver assumes this information can be passed
through 'flags' in the platform resources, however current DT
implementation provides no such provision.

So passing the information explicitly through the optional parameter
'reg_alignment' in the device tree.

Signed-off-by: Amit Virdi <amit.virdi@st.com>
Reviewed-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 Documentation/devicetree/bindings/net/can/c_can.txt |  4 ++++
 drivers/net/can/c_can/c_can_platform.c              | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
index 8f1ae81..7d645cb 100644
--- a/Documentation/devicetree/bindings/net/can/c_can.txt
+++ b/Documentation/devicetree/bindings/net/can/c_can.txt
@@ -12,6 +12,10 @@ Required properties:
 Optional properties:
 - ti,hwmods		: Must be "d_can<n>" or "c_can<n>", n being the
 			  instance number
+- reg_alignment : Signifies register alignment. Must be either of
+                        1. 0x8 or 0x10 - If registers are 16-bit aligned
+                        2. 0x18 - If registers are 32-bit aligned
+                Default is 32-bit alignment.
 
 Note: "ti,hwmods" field is used to fetch the base address and irq
 resources from TI, omap hwmod data base during device registration.
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 0044fd8..451e81f 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -117,6 +117,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	struct pinctrl *pinctrl;
 	struct resource *mem, *res;
 	int irq;
+	u32 reg_alignment = IORESOURCE_MEM_32BIT;
 	struct clk *clk;
 
 	if (pdev->dev.of_node) {
@@ -127,6 +128,11 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 			goto exit;
 		}
 		id = match->data;
+
+		if (of_property_read_u32(pdev->dev.of_node,
+				"reg_alignment", &reg_alignment))
+			dev_warn(&pdev->dev, "Register alignment not provided, \
+					using 32-bit as default\n");
 	} else {
 		id = platform_get_device_id(pdev);
 	}
@@ -166,6 +172,9 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 		goto exit_release_mem;
 	}
 
+	if (!pdev->dev.of_node)
+		reg_alignment = mem->flags;
+
 	/* allocate the c_can device */
 	dev = alloc_c_can_dev();
 	if (!dev) {
@@ -177,7 +186,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	switch (id->driver_data) {
 	case BOSCH_C_CAN:
 		priv->regs = reg_map_c_can;
-		switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
+		switch (reg_alignment & IORESOURCE_MEM_TYPE_MASK) {
 		case IORESOURCE_MEM_32BIT:
 			priv->read_reg = c_can_plat_read_reg_aligned_to_32bit;
 			priv->write_reg = c_can_plat_write_reg_aligned_to_32bit;
-- 
1.8.0

