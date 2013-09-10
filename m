From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/3] can: sja1000: remove unnecessary pci_set_drvdata()
Date: Tue, 10 Sep 2013 20:12:51 +0900
Message-ID: <00ab01ceae16$b05be8d0$1113ba70$%han@samsung.com>
References: <00a801ceae15$bb3daa50$31b8fef0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:57372 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab3IJLM7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Sep 2013 07:12:59 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSW0081FPSJSNC0@mailout1.samsung.com> for
 linux-can@vger.kernel.org; Tue, 10 Sep 2013 20:12:51 +0900 (KST)
In-reply-to: <00a801ceae15$bb3daa50$31b8fef0$%han@samsung.com>
Content-language: ko
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>
Cc: 'Wolfgang Grandegger' <wg@grandegger.com>, linux-can@vger.kernel.org, 'Oliver Hartkopp' <socketcan@hartkopp.net>, 'Jingoo Han' <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/net/can/sja1000/ems_pci.c    |    1 -
 drivers/net/can/sja1000/kvaser_pci.c |    1 -
 drivers/net/can/sja1000/peak_pci.c   |    2 --
 drivers/net/can/sja1000/plx_pci.c    |    1 -
 4 files changed, 5 deletions(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 3752342..8359213 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -207,7 +207,6 @@ static void ems_pci_del_card(struct pci_dev *pdev)
 	kfree(card);
 
 	pci_disable_device(pdev);
-	pci_set_drvdata(pdev, NULL);
 }
 
 static void ems_pci_card_reset(struct ems_pci_card *card)
diff --git a/drivers/net/can/sja1000/kvaser_pci.c b/drivers/net/can/sja1000/kvaser_pci.c
index 217585b..087b13b 100644
--- a/drivers/net/can/sja1000/kvaser_pci.c
+++ b/drivers/net/can/sja1000/kvaser_pci.c
@@ -387,7 +387,6 @@ static void kvaser_pci_remove_one(struct pci_dev *pdev)
 
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-	pci_set_drvdata(pdev, NULL);
 }
 
 static struct pci_driver kvaser_pci_driver = {
diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 6b6f0ad..065ca49 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -744,8 +744,6 @@ static void peak_pci_remove(struct pci_dev *pdev)
 	pci_iounmap(pdev, cfg_base);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-
-	pci_set_drvdata(pdev, NULL);
 }
 
 static struct pci_driver peak_pci_driver = {
diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index c52c1e9..f9b4f81 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -477,7 +477,6 @@ static void plx_pci_del_card(struct pci_dev *pdev)
 	kfree(card);
 
 	pci_disable_device(pdev);
-	pci_set_drvdata(pdev, NULL);
 }
 
 /*
-- 
1.7.10.4


