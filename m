Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731663911B6;
	Thu, 16 Jul 2026 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217412; cv=none; b=ALgg1tYCTwhFVh/8YXldIqmxjuBXzFUxAvEXLlwQEZUcTfNjlmLk9rRWvumhGrQOm/4DHJfovIWhsK4W4TIShRdT4tQ8DyOORxGhA4YLNjOxAUlX53suQZSfTT40fKs3CrjpgC85ldFCFgJIe7l8YjaSkaUbPRyy1vzj1AfSx9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217412; c=relaxed/simple;
	bh=VAWY+fBdAS32eKaTIpI7QV0bLusHQW2cvVRj/SOJPuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciKcvj+mciPwwhUxEkCXJgvYxCQRX7Zjb3MAWDhXFZ1YskHPHZZmkBoWi8BjW0GNo5pKC1EuuBQAtDZzFbhpUjMi1wcQ8mMdb/9sNDJN4gZDt0ab4fFnHODwz1csD2XnlLlB5R668l0KliZH75VZYMi92J0wODkF/+rrozEoGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 73045202285;
	Thu, 16 Jul 2026 17:56:24 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wkORk-0027on-09;
	Thu, 16 Jul 2026 17:56:24 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7A78856C3D9;
	Thu, 16 Jul 2026 15:55:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 05/19] can: peak: Modification of references to email accounts being deleted
Date: Thu, 16 Jul 2026 17:47:30 +0200
Message-ID: <20260716155528.809908-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716155528.809908-1-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Following the sale of PEAK-System France by HMS-Networks, this update is
intended to change all my @hms-networks.com email addresses to my new
@peak-system.fr address.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
Link: https://patch.msgid.link/20260410124251.40506-1-stephane.grosjean@free.fr
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .mailmap                                      | 4 ++--
 drivers/net/can/peak_canfd/peak_canfd.c       | 2 +-
 drivers/net/can/peak_canfd/peak_canfd_user.h  | 2 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c | 4 ++--
 drivers/net/can/sja1000/peak_pci.c            | 4 ++--
 drivers/net/can/sja1000/peak_pcmcia.c         | 4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb.c       | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  | 4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.h  | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c    | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c   | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h   | 2 +-
 include/linux/can/dev/peak_canfd.h            | 2 +-
 13 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/.mailmap b/.mailmap
index 12f3acdebd72..918fcd6575b1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -825,8 +825,8 @@ Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
 Stanislav Fomichev <sdf@fomichev.me> <sdf@google.com>
 Stanislav Fomichev <sdf@fomichev.me> <stfomichev@gmail.com>
 Stefan Wahren <wahrenst@gmx.net> <stefan.wahren@i2se.com>
-Stéphane Grosjean <stephane.grosjean@hms-networks.com> <s.grosjean@peak-system.com>
-Stéphane Grosjean <stephane.grosjean@hms-networks.com> <stephane.grosjean@free.fr>
+Stéphane Grosjean <s.grosjean@peak-system.fr> <s.grosjean@peak-system.com>
+Stéphane Grosjean <s.grosjean@peak-system.fr> <stephane.grosjean@free.fr>
 Stéphane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@linux-foundation.org>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@osdl.org>
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 06cb2629f66a..4fd1aefb780f 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -2,7 +2,7 @@
 /* Copyright (C) 2007, 2011 Wolfgang Grandegger <wg@grandegger.com>
  *
  * Copyright (C) 2016-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 
 #include <linux/can.h>
diff --git a/drivers/net/can/peak_canfd/peak_canfd_user.h b/drivers/net/can/peak_canfd/peak_canfd_user.h
index 60c6542028cf..dc0ecb566a85 100644
--- a/drivers/net/can/peak_canfd/peak_canfd_user.h
+++ b/drivers/net/can/peak_canfd/peak_canfd_user.h
@@ -2,7 +2,7 @@
 /* CAN driver for PEAK System micro-CAN based adapters
  *
  * Copyright (C) 2003-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 #ifndef PEAK_CANFD_USER_H
 #define PEAK_CANFD_USER_H
diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index 93558e33bc02..7c749301ea84 100644
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -4,7 +4,7 @@
  * Derived from the PCAN project file driver/src/pcan_pci.c:
  *
  * Copyright (C) 2001-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 
 #include <linux/kernel.h>
@@ -19,7 +19,7 @@
 
 #include "peak_canfd_user.h"
 
-MODULE_AUTHOR("Stéphane Grosjean <stephane.grosjean@hms-networks.com>");
+MODULE_AUTHOR("Stéphane Grosjean <s.grosjean@peak-system.fr>");
 MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCIe/M.2 FD family cards");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 4cc4a1581dd1..69c61ccf621d 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -5,7 +5,7 @@
  * Derived from the PCAN project file driver/src/pcan_pci.c:
  *
  * Copyright (C) 2001-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 
 #include <linux/kernel.h>
@@ -22,7 +22,7 @@
 
 #include "sja1000.h"
 
-MODULE_AUTHOR("Stéphane Grosjean <stephane.grosjean@hms-networks.com>");
+MODULE_AUTHOR("Stéphane Grosjean <s.grosjean@peak-system.fr>");
 MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI family cards");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index 42a77d435b39..c3c2aa21da47 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -4,7 +4,7 @@
  * Derived from the PCAN project file driver/src/pcan_pccard.c
  *
  * Copyright (C) 2006-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -19,7 +19,7 @@
 #include <linux/can/dev.h>
 #include "sja1000.h"
 
-MODULE_AUTHOR("Stéphane Grosjean <stephane.grosjean@hms-networks.com>");
+MODULE_AUTHOR("Stéphane Grosjean <s.grosjean@peak-system.fr>");
 MODULE_DESCRIPTION("CAN driver for PEAK-System PCAN-PC Cards");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 9278a1522aae..8fd058c32856 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -4,7 +4,7 @@
  * Derived from the PCAN project file driver/src/pcan_usb.c
  *
  * Copyright (C) 2003-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  *
  * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
  */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index cf48bb26d46d..c7933d1acc99 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -4,7 +4,7 @@
  * Derived from the PCAN project file driver/src/pcan_usb_core.c
  *
  * Copyright (C) 2003-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  *
  * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
  */
@@ -24,7 +24,7 @@
 
 #include "pcan_usb_core.h"
 
-MODULE_AUTHOR("Stéphane Grosjean <stephane.grosjean@hms-networks.com>");
+MODULE_AUTHOR("Stéphane Grosjean <s.grosjean@peak-system.fr>");
 MODULE_DESCRIPTION("CAN driver for PEAK-System USB adapters");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index d1c1897d47b9..65999f04f4b7 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -4,7 +4,7 @@
  * Derived from the PCAN project file driver/src/pcan_usb_core.c
  *
  * Copyright (C) 2003-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  *
  * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
  */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index eb4f5884ad73..ef9fd693e9bd 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -3,7 +3,7 @@
  * CAN driver for PEAK System PCAN-USB FD / PCAN-USB Pro FD adapter
  *
  * Copyright (C) 2013-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 #include <linux/ethtool.h>
 #include <linux/module.h>
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 4bfa8d0fbb32..aefcded8e12a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -4,7 +4,7 @@
  * Derived from the PCAN project file driver/src/pcan_usbpro.c
  *
  * Copyright (C) 2003-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 #include <linux/ethtool.h>
 #include <linux/module.h>
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
index 162c7546d3a8..d669c9e610c7 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
@@ -4,7 +4,7 @@
  * Derived from the PCAN project file driver/src/pcan_usbpro_fw.h
  *
  * Copyright (C) 2003-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 #ifndef PCAN_USB_PRO_H
 #define PCAN_USB_PRO_H
diff --git a/include/linux/can/dev/peak_canfd.h b/include/linux/can/dev/peak_canfd.h
index d3788a3d0942..056e0efa649f 100644
--- a/include/linux/can/dev/peak_canfd.h
+++ b/include/linux/can/dev/peak_canfd.h
@@ -3,7 +3,7 @@
  * CAN driver for PEAK System micro-CAN based adapters
  *
  * Copyright (C) 2003-2025 PEAK System-Technik GmbH
- * Author: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
+ * Author: Stéphane Grosjean <s.grosjean@peak-system.fr>
  */
 #ifndef PUCAN_H
 #define PUCAN_H
-- 
2.53.0

