Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B04E3783C4
	for <linux-can@vger.kernel.org>; Fri, 21 Aug 2026 03:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283330; cv=none; b=ieZgmVkbsPkm1kZjYrJ6M4oEap6n5HNKIYidb4SPpNx5MMmn1OKb2r0dNtQO/MR5h5dd3PbRBSSEpA5TrMRMKSyUUvfnvWLEtA3LkWbqClh5i6Hh/uukiAk3nt1S39xBJcV4S+j+VNd7ZwBhnCLCtunNXnUshSV4Kj9FePPCo5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283330; c=relaxed/simple;
	bh=B1ouq7zNk3OffF9x05iRPTwxZeo6B5tYmbwVJug955A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZII340wXzhWPmnX7gl+PspM88G1xCIE0C1ZcJvC5opcrpokeALikxBNYT/ZNLv1cCcfy5gKleKaiYawaaweUU2XZLVSzn+/OtaiTTnseAMWHmXed4JDskH82Pf6fEdnpBhXSLyuGsU6wCAM+WxqHgaFJS1+FY5lThCO6f1eNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnrhaUv2; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnrhaUv2"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbeea240819so344000a12.1
        for <linux-can@vger.kernel.org>; Thu, 20 Aug 2026 20:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787283327; x=1787888127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlQ97Apv2CPkVoHg6S8Gou0Qv9jKg/Qt6XZBOTaFmHE=;
        b=VnrhaUv2dYCrSiZGhJIvCZ8tV7LnOpm60K2LIMMZzCw3FFjMuT8C23WKtg6yl1fowv
         W5Gq4KwK7y/M29WzGPX73wNw3JgxNFkyny25CZgqnicLG8hki6jRIpcVeE2WGMXz55sJ
         0TJSG5KKG/u3W8orCNz/nFQMDrOLV39Lp2np5I/T6rGhTfpOKMBJWT5lvGRpbgrSnBqG
         IHK1GtHuMOR+xspbJ4sIKQg6xECz6Wh3pU5Im6LU9C8TMK9YamK5ZmrrgAaPhNaJggzD
         2CcZiSauWJAymUfd7ZnbKzdTJRDdicXFiobBfjzv3j8CJb1uPjq4VQjs4Nzih+E57HKa
         cnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787283327; x=1787888127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OlQ97Apv2CPkVoHg6S8Gou0Qv9jKg/Qt6XZBOTaFmHE=;
        b=j6tIit9U5HQ56jrd1fonTQLF35DdTWoXCH2BLTtW6TgFp82ZLfeyiCH1odbK9Nmuck
         L7bssgiM9ujcXfoNxfLjcFEWiIK1FtGq/5fmz/hA19CqvGsYwgP1ZcJn5jwGT3vFe0rV
         Krmi181HvNrHdzTnfqZFFpJwp/GDypp0nFJqMwS7c1ZOEAPM+5pDlKwFitOxkGNv+Fhm
         lSw7dVaipJlvByFvX6e3zDos/IHk8jRrxl/ZfxIJISuWNRIZzJn5Ro+Ul8HEx5xNeeeC
         cs4P0ty4fEzc8nCjKcixqMgf5tQPDnW2pQqZJmRYLeSOWDl94rtF6KFcYt99GNhIZTQ/
         ZLWA==
X-Forwarded-Encrypted: i=1; AHgh+RoF9KOsRkSf6dB+jlgRb8RznLKzmfBP7XWuQ+7cCld28aKiEzqwEC+AhPqiaLbutA8vLvs8CVZYUcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyicDgIPZuHz+OWYn8r6ZkJ0sAIrTB6El102Wlkcld+0sFWE44M
	LtyXqtYzrKYjXpqKjSyMoM1a9iezEwrsugXU4Qv0kh59OrKbEQQPN5b8
X-Gm-Gg: AR+sD112L344m53wWqM2RlDxwUAOxVHm7jMniarhY1nl7kqd8AJSRV/UO6G7b6TcsLK
	rAVN1tw4TP+5aW5zS703G3bZD2ReoTqwrdCJ7VoR62uo9uK6EQ2droc0z+uZwYoaofSe+qNJM9t
	mycyFYoweLGtyeDBhDjf0w9ZHH5tL9RMbqPclSpQpNKKGKHZ0SHaMPMqkEOp5xVxhe+8r9pKnhr
	Y1GhNPKFcWMQG/70dw5bGdohCa7lnokbEFsJRnTF2Z+3Ev6pbPSjblgwUj9x4K4kFMapAYS2qiv
	GvvaSxaWDq7rz5O71DPWQNDScOyOtryN87DuxAluU3i3b1yAd98y+bDHux6knCV4hoyzu2AmyJF
	6kLUnZ0NiS3IWxugXuPRGJUpMtXtCJs6EIbMFTTkD//TonZcdSf8JIpI0d2o9h1X7PDeCBnbz1+
	TJifS8dz4SqhJ70qAmH1iqzXm4bqD6Z9WHc7yelAiONk7i5gcsakmLJvnb62LXBPlTFmvVioMIn
	0/gTc1OV1/Qt6f9JARa9nh79mMjPDXWDL/7CWI5rA==
X-Received: by 2002:a05:6a21:3a46:b0:3bf:63af:855 with SMTP id adf61e73a8af0-3cd2fddf03emr6085839637.1.1787283327385;
        Thu, 20 Aug 2026 20:35:27 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15891a04csm2204271a12.15.2026.08.20.20.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 20:35:27 -0700 (PDT)
From: a0282524688@gmail.com
To: lee@kernel.org,
	Ming Yu <tmyu0@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Andi Shyti <andi.shyti@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-kernel@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	mfd@lists.linux.dev
Subject: [PATCH v7 01/10] mfd: nct6694: Move module type macros to shared header
Date: Fri, 21 Aug 2026 11:34:56 +0800
Message-Id: <20260821033505.4017901-2-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821033505.4017901-1-a0282524688@gmail.com>
References: <20260821033505.4017901-1-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yu <a0282524688@gmail.com>

Move NCT6694_XXX_MOD macro definitions from individual sub-device
drivers into the shared header include/linux/mfd/nct6694.h.

This is a prerequisite for supporting multiple transport interfaces
(USB, HIF) without duplicating these definitions.

No functional change.

Signed-off-by: Ming Yu <a0282524688@gmail.com>
---
Changes in v7:

Changes in v6:

Changes in v5:
- Split from the monolithic v4 patch to follow the single logical change
  principle.

 drivers/gpio/gpio-nct6694.c         |  7 -------
 drivers/hwmon/nct6694-hwmon.c       | 21 ---------------------
 drivers/i2c/busses/i2c-nct6694.c    |  7 -------
 drivers/net/can/usb/nct6694_canfd.c |  6 ------
 drivers/rtc/rtc-nct6694.c           |  7 -------
 drivers/watchdog/nct6694_wdt.c      |  7 -------
 include/linux/mfd/nct6694.h         |  9 +++++++++
 7 files changed, 9 insertions(+), 55 deletions(-)

diff --git a/drivers/gpio/gpio-nct6694.c b/drivers/gpio/gpio-nct6694.c
index a8607f0d9915..53bfc5983648 100644
--- a/drivers/gpio/gpio-nct6694.c
+++ b/drivers/gpio/gpio-nct6694.c
@@ -13,13 +13,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-/*
- * USB command module type for NCT6694 GPIO controller.
- * This defines the module type used for communication with the NCT6694
- * GPIO controller over the USB interface.
- */
-#define NCT6694_GPIO_MOD	0xFF
-
 #define NCT6694_GPIO_VER	0x90
 #define NCT6694_GPIO_VALID	0x110
 #define NCT6694_GPI_DATA	0x120
diff --git a/drivers/hwmon/nct6694-hwmon.c b/drivers/hwmon/nct6694-hwmon.c
index 6dcf22ca5018..581451875f2c 100644
--- a/drivers/hwmon/nct6694-hwmon.c
+++ b/drivers/hwmon/nct6694-hwmon.c
@@ -15,13 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-/*
- * USB command module type for NCT6694 report channel
- * This defines the module type used for communication with the NCT6694
- * report channel over the USB interface.
- */
-#define NCT6694_RPT_MOD			0xFF
-
 /* Report channel */
 /*
  * The report channel is used to report the status of the hardware monitor
@@ -38,13 +31,6 @@
 #define NCT6694_TIN_STS(x)		(0x6A + (x))
 #define NCT6694_FIN_STS(x)		(0x6E + (x))
 
-/*
- * USB command module type for NCT6694 HWMON controller.
- * This defines the module type used for communication with the NCT6694
- * HWMON controller over the USB interface.
- */
-#define NCT6694_HWMON_MOD		0x00
-
 /* Command 00h - Hardware Monitor Control */
 #define NCT6694_HWMON_CONTROL		0x00
 #define NCT6694_HWMON_CONTROL_SEL	0x00
@@ -53,13 +39,6 @@
 #define NCT6694_HWMON_ALARM		0x02
 #define NCT6694_HWMON_ALARM_SEL		0x00
 
-/*
- * USB command module type for NCT6694 PWM controller.
- * This defines the module type used for communication with the NCT6694
- * PWM controller over the USB interface.
- */
-#define NCT6694_PWM_MOD			0x01
-
 /* PWM Command - Manual Control */
 #define NCT6694_PWM_CONTROL		0x01
 #define NCT6694_PWM_CONTROL_SEL		0x00
diff --git a/drivers/i2c/busses/i2c-nct6694.c b/drivers/i2c/busses/i2c-nct6694.c
index 1413ab6f9462..ef3329f34246 100644
--- a/drivers/i2c/busses/i2c-nct6694.c
+++ b/drivers/i2c/busses/i2c-nct6694.c
@@ -12,13 +12,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-/*
- * USB command module type for NCT6694 I2C controller.
- * This defines the module type used for communication with the NCT6694
- * I2C controller over the USB interface.
- */
-#define NCT6694_I2C_MOD			0x03
-
 /* Command 00h - I2C Deliver */
 #define NCT6694_I2C_DELIVER		0x00
 #define NCT6694_I2C_DELIVER_SEL		0x00
diff --git a/drivers/net/can/usb/nct6694_canfd.c b/drivers/net/can/usb/nct6694_canfd.c
index e5f7f8849a73..262b4c26c9d4 100644
--- a/drivers/net/can/usb/nct6694_canfd.c
+++ b/drivers/net/can/usb/nct6694_canfd.c
@@ -18,12 +18,6 @@
 
 #define DEVICE_NAME "nct6694-canfd"
 
-/* USB command module type for NCT6694 CANfd controller.
- * This defines the module type used for communication with the NCT6694
- * CANfd controller over the USB interface.
- */
-#define NCT6694_CANFD_MOD			0x05
-
 /* Command 00h - CAN Setting and Initialization */
 #define NCT6694_CANFD_SETTING			0x00
 #define NCT6694_CANFD_SETTING_ACTIVE_CTRL1	BIT(0)
diff --git a/drivers/rtc/rtc-nct6694.c b/drivers/rtc/rtc-nct6694.c
index 35401a0d9cf5..c06902f150c9 100644
--- a/drivers/rtc/rtc-nct6694.c
+++ b/drivers/rtc/rtc-nct6694.c
@@ -14,13 +14,6 @@
 #include <linux/rtc.h>
 #include <linux/slab.h>
 
-/*
- * USB command module type for NCT6694 RTC controller.
- * This defines the module type used for communication with the NCT6694
- * RTC controller over the USB interface.
- */
-#define NCT6694_RTC_MOD		0x08
-
 /* Command 00h - RTC Time */
 #define NCT6694_RTC_TIME	0x0000
 #define NCT6694_RTC_TIME_SEL	0x00
diff --git a/drivers/watchdog/nct6694_wdt.c b/drivers/watchdog/nct6694_wdt.c
index bc3689bd4b6b..4c06ac105562 100644
--- a/drivers/watchdog/nct6694_wdt.c
+++ b/drivers/watchdog/nct6694_wdt.c
@@ -20,13 +20,6 @@
 
 #define NCT6694_WDT_MAX_DEVS		2
 
-/*
- * USB command module type for NCT6694 WDT controller.
- * This defines the module type used for communication with the NCT6694
- * WDT controller over the USB interface.
- */
-#define NCT6694_WDT_MOD			0x07
-
 /* Command 00h - WDT Setup */
 #define NCT6694_WDT_SETUP		0x00
 #define NCT6694_WDT_SETUP_SEL(idx)	(idx ? 0x01 : 0x00)
diff --git a/include/linux/mfd/nct6694.h b/include/linux/mfd/nct6694.h
index 6eb9be2cd4a0..3c683e317aa3 100644
--- a/include/linux/mfd/nct6694.h
+++ b/include/linux/mfd/nct6694.h
@@ -8,6 +8,15 @@
 #ifndef __MFD_NCT6694_H
 #define __MFD_NCT6694_H
 
+#define NCT6694_HWMON_MOD	0x00
+#define NCT6694_PWM_MOD		0x01
+#define NCT6694_I2C_MOD		0x03
+#define NCT6694_CANFD_MOD	0x05
+#define NCT6694_WDT_MOD		0x07
+#define NCT6694_RTC_MOD		0x08
+#define NCT6694_RPT_MOD		0xFF
+#define NCT6694_GPIO_MOD	NCT6694_RPT_MOD
+
 #define NCT6694_VENDOR_ID	0x0416
 #define NCT6694_PRODUCT_ID	0x200B
 #define NCT6694_INT_IN_EP	0x81
-- 
2.34.1

