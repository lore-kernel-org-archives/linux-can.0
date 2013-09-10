From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/3] can: pch_can: remove unnecessary pci_set_drvdata()
Date: Tue, 10 Sep 2013 20:10:35 +0900
Message-ID: <00aa01ceae16$5f9f1de0$1edd59a0$%han@samsung.com>
References: <00a801ceae15$bb3daa50$31b8fef0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:15221 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab3IJLKh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Sep 2013 07:10:37 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSW009IPPP6QOZ0@mailout3.samsung.com> for
 linux-can@vger.kernel.org; Tue, 10 Sep 2013 20:10:36 +0900 (KST)
In-reply-to: <00a801ceae15$bb3daa50$31b8fef0$%han@samsung.com>
Content-language: ko
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>
Cc: 'Wolfgang Grandegger' <wg@grandegger.com>, linux-can@vger.kernel.org, 'Toshiharu Okada' <toshiharu-linux@dsn.okisemi.com>, 'Tomoya MORINAGA' <tomoya.rohm@gmail.com>, 'Jingoo Han' <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/net/can/pch_can.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 5c314a9..5f0e9b3 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -964,7 +964,6 @@ static void pch_can_remove(struct pci_dev *pdev)
 		pci_disable_msi(priv->dev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-	pci_set_drvdata(pdev, NULL);
 	pch_can_reset(priv);
 	pci_iounmap(pdev, priv->regs);
 	free_candev(priv->ndev);
-- 
1.7.10.4


