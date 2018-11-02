From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 1/6] phy: Add max_bitrate attribute & phy_get_max_bitrate()
Date: Sat, 3 Nov 2018 00:56:11 +0530
Message-ID: <20181102192616.28291-2-faiz_abbas@ti.com>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181102192616.28291-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com, faiz_abbas@ti.com
List-Id: linux-can.vger.kernel.org

In some subsystems (eg. CAN) the physical layer capabilities are
the limiting factor in the datarate of the device. Typically, the
physical layer transceiver does not provide a way to discover this
limitation at runtime. Thus this information needs to be represented as
a phy attribute which is read from the device tree.

Therefore, add an optional max_bitrate attribute to the generic phy
sybsystem. Also add the complementary API which enables the consumer
to get max_bitrate.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 include/linux/phy/phy.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 03b319f89a34..31574464f09f 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -72,6 +72,7 @@ struct phy_ops {
  */
 struct phy_attrs {
 	u32			bus_width;
+	u32			max_bitrate;
 	enum phy_mode		mode;
 };
 
@@ -179,6 +180,10 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 {
 	phy->attrs.bus_width = bus_width;
 }
+static inline int phy_get_max_bitrate(struct phy *phy)
+{
+	return phy->attrs.max_bitrate;
+}
 struct phy *phy_get(struct device *dev, const char *string);
 struct phy *phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
-- 
2.18.0
