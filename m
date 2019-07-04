From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [Patch v2 08/10] net/can: using dev_get_drvdata directly
Date: Thu,  4 Jul 2019 10:36:33 +0800
Message-ID: <20190704023633.4781-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>
List-Id: linux-can.vger.kernel.org

Several drivers cast a struct device pointer to a struct
platform_device pointer only to then call platform_get_drvdata().
To improve readability, these constructs can be simplified
by using dev_get_drvdata() directly.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Make the commit message more clearly.

 drivers/net/can/softing/softing_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 68bb58a57f3b..8242fb287cbb 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -683,7 +683,7 @@ static void softing_netdev_cleanup(struct net_device *netdev)
 static ssize_t show_##name(struct device *dev, \
 		struct device_attribute *attr, char *buf) \
 { \
-	struct softing *card = platform_get_drvdata(to_platform_device(dev)); \
+	struct softing *card = dev_get_drvdata(dev); \
 	return sprintf(buf, "%u\n", card->member); \
 } \
 static DEVICE_ATTR(name, 0444, show_##name, NULL)
@@ -692,7 +692,7 @@ static DEVICE_ATTR(name, 0444, show_##name, NULL)
 static ssize_t show_##name(struct device *dev, \
 		struct device_attribute *attr, char *buf) \
 { \
-	struct softing *card = platform_get_drvdata(to_platform_device(dev)); \
+	struct softing *card = dev_get_drvdata(dev); \
 	return sprintf(buf, "%s\n", card->member); \
 } \
 static DEVICE_ATTR(name, 0444, show_##name, NULL)
-- 
2.11.0
