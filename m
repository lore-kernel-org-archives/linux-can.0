From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/3] can: c_can: remove unnecessary pci_set_drvdata()
Date: Tue, 10 Sep 2013 20:08:15 +0900
Message-ID: <00a901ceae16$0c2d1e00$24875a00$%han@samsung.com>
References: <00a801ceae15$bb3daa50$31b8fef0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53383 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab3IJLIQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Sep 2013 07:08:16 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSW005JOPLRP8B0@mailout2.samsung.com> for
 linux-can@vger.kernel.org; Tue, 10 Sep 2013 20:08:16 +0900 (KST)
In-reply-to: <00a801ceae15$bb3daa50$31b8fef0$%han@samsung.com>
Content-language: ko
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>
Cc: 'Wolfgang Grandegger' <wg@grandegger.com>, linux-can@vger.kernel.org, 'Federico Vaga' <federico.vaga@gmail.com>, 'Alexander Stein' <alexander.stein@systec-electronic.com>, 'Jingoo Han' <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/net/can/c_can/c_can_pci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index b374be7..bce0be5 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -160,7 +160,6 @@ static int c_can_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 out_free_c_can:
-	pci_set_drvdata(pdev, NULL);
 	free_c_can_dev(dev);
 out_iounmap:
 	pci_iounmap(pdev, addr);
@@ -181,7 +180,6 @@ static void c_can_pci_remove(struct pci_dev *pdev)
 
 	unregister_c_can_dev(dev);
 
-	pci_set_drvdata(pdev, NULL);
 	free_c_can_dev(dev);
 
 	pci_iounmap(pdev, priv->base);
-- 
1.7.10.4


