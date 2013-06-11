From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] ARM: imx: prepare for removal of flexcan_platform_data
Date: Mon, 10 Jun 2013 23:12:56 -0300
Message-ID: <1370916778-4406-1-git-send-email-festevam@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-gg0-f173.google.com ([209.85.161.173]:42579 "EHLO
	mail-gg0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab3FKCNL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 22:13:11 -0400
Received: by mail-gg0-f173.google.com with SMTP id k3so743825ggn.4
        for <linux-can@vger.kernel.org>; Mon, 10 Jun 2013 19:13:10 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

As there are no imx in-tree users of flexcan_platform_data, this patch removes
the possibility to register a flexcan device with platform data.

The functionality to swith on/off CAN transceivers is added to DT via
regulators on a later patch.

Compile time tested with imx_v4_v5_defconfig and imx_v6_v7_defconfig.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-imx/devices-imx25.h              | 8 ++++----
 arch/arm/mach-imx/devices-imx35.h              | 8 ++++----
 arch/arm/mach-imx/devices/devices-common.h     | 4 +---
 arch/arm/mach-imx/devices/platform-flexcan.c   | 5 ++---
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c | 2 +-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c | 2 +-
 arch/arm/mach-imx/mach-mx25_3ds.c              | 2 +-
 arch/arm/mach-imx/mach-pcm043.c                | 2 +-
 8 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx25.h b/arch/arm/mach-imx/devices-imx25.h
index 0d2922b..769563f 100644
--- a/arch/arm/mach-imx/devices-imx25.h
+++ b/arch/arm/mach-imx/devices-imx25.h
@@ -13,10 +13,10 @@ extern const struct imx_fec_data imx25_fec_data;
 	imx_add_fec(&imx25_fec_data, pdata)
 
 extern const struct imx_flexcan_data imx25_flexcan_data[];
-#define imx25_add_flexcan(id, pdata)	\
-	imx_add_flexcan(&imx25_flexcan_data[id], pdata)
-#define imx25_add_flexcan0(pdata)	imx25_add_flexcan(0, pdata)
-#define imx25_add_flexcan1(pdata)	imx25_add_flexcan(1, pdata)
+#define imx25_add_flexcan(id)	\
+	imx_add_flexcan(&imx25_flexcan_data[id])
+#define imx25_add_flexcan0()		imx25_add_flexcan(0)
+#define imx25_add_flexcan1()		imx25_add_flexcan(1)
 
 extern const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data;
 #define imx25_add_fsl_usb2_udc(pdata)	\
diff --git a/arch/arm/mach-imx/devices-imx35.h b/arch/arm/mach-imx/devices-imx35.h
index e2675f1..780d824 100644
--- a/arch/arm/mach-imx/devices-imx35.h
+++ b/arch/arm/mach-imx/devices-imx35.h
@@ -17,10 +17,10 @@ extern const struct imx_fsl_usb2_udc_data imx35_fsl_usb2_udc_data;
 	imx_add_fsl_usb2_udc(&imx35_fsl_usb2_udc_data, pdata)
 
 extern const struct imx_flexcan_data imx35_flexcan_data[];
-#define imx35_add_flexcan(id, pdata)	\
-	imx_add_flexcan(&imx35_flexcan_data[id], pdata)
-#define imx35_add_flexcan0(pdata)	imx35_add_flexcan(0, pdata)
-#define imx35_add_flexcan1(pdata)	imx35_add_flexcan(1, pdata)
+#define imx35_add_flexcan(id)	\
+	imx_add_flexcan(&imx35_flexcan_data[id])
+#define imx35_add_flexcan0()		imx35_add_flexcan(0)
+#define imx35_add_flexcan1()		imx35_add_flexcan(1)
 
 extern const struct imx_imx2_wdt_data imx35_imx2_wdt_data;
 #define imx35_add_imx2_wdt()       \
diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
index 453e20b..c13b76b 100644
--- a/arch/arm/mach-imx/devices/devices-common.h
+++ b/arch/arm/mach-imx/devices/devices-common.h
@@ -50,7 +50,6 @@ struct platform_device *__init imx_add_fec(
 		const struct imx_fec_data *data,
 		const struct fec_platform_data *pdata);
 
-#include <linux/can/platform/flexcan.h>
 struct imx_flexcan_data {
 	int id;
 	resource_size_t iobase;
@@ -58,8 +57,7 @@ struct imx_flexcan_data {
 	resource_size_t irq;
 };
 struct platform_device *__init imx_add_flexcan(
-		const struct imx_flexcan_data *data,
-		const struct flexcan_platform_data *pdata);
+		const struct imx_flexcan_data *data);
 
 #include <linux/fsl_devices.h>
 struct imx_fsl_usb2_udc_data {
diff --git a/arch/arm/mach-imx/devices/platform-flexcan.c b/arch/arm/mach-imx/devices/platform-flexcan.c
index 1078bf0..55d61ea 100644
--- a/arch/arm/mach-imx/devices/platform-flexcan.c
+++ b/arch/arm/mach-imx/devices/platform-flexcan.c
@@ -38,8 +38,7 @@ const struct imx_flexcan_data imx35_flexcan_data[] __initconst = {
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
 struct platform_device *__init imx_add_flexcan(
-		const struct imx_flexcan_data *data,
-		const struct flexcan_platform_data *pdata)
+		const struct imx_flexcan_data *data)
 {
 	struct resource res[] = {
 		{
@@ -54,5 +53,5 @@ struct platform_device *__init imx_add_flexcan(
 	};
 
 	return imx_add_platform_device("flexcan", data->id,
-			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+			res, ARRAY_SIZE(res), NULL, 0);
 }
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index e2b70f4c..e77cc3a 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -279,7 +279,7 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
 	imx25_add_imx_fb(&eukrea_mximxsd_fb_pdata);
 	imx25_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
 
-	imx25_add_flexcan1(NULL);
+	imx25_add_flexcan1();
 	imx25_add_sdhci_esdhc_imx(0, &sd1_pdata);
 
 	gpio_request(GPIO_LED1, "LED1");
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
index 5a2d5ef..14d6c82 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
@@ -287,7 +287,7 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 
 	imx35_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
 
-	imx35_add_flexcan1(NULL);
+	imx35_add_flexcan1();
 	imx35_add_sdhci_esdhc_imx(0, &sd1_pdata);
 
 	gpio_request(GPIO_LED1, "LED1");
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index 8bcda68..13490c2 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -249,7 +249,7 @@ static void __init mx25pdk_init(void)
 	imx25_add_imx_i2c0(&mx25_3ds_i2c0_data);
 
 	gpio_request_one(MX25PDK_CAN_PWDN, GPIOF_OUT_INIT_LOW, "can-pwdn");
-	imx25_add_flexcan0(NULL);
+	imx25_add_flexcan0();
 }
 
 static void __init mx25pdk_timer_init(void)
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index 8ed533f..b726cb1 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -385,7 +385,7 @@ static void __init pcm043_init(void)
 	if (!otg_mode_host)
 		imx35_add_fsl_usb2_udc(&otg_device_pdata);
 
-	imx35_add_flexcan1(NULL);
+	imx35_add_flexcan1();
 	imx35_add_sdhci_esdhc_imx(0, &sd1_pdata);
 }
 
-- 
1.8.1.2

