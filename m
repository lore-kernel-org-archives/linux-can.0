From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Thu, 03 Apr 2014 20:41:24 +0200
Message-ID: <533DAB54.8010008@grandegger.com>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:38303 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbaDCSl1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Apr 2014 14:41:27 -0400
In-Reply-To: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Marc@systec-electronic.de, Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 04/03/2014 04:14 PM, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Acked-by: Wolfgang Grandegger <wg@grandegger.com>

In my patch stack I have also th patch below. Could you please give it
I try before I re-submit it. Thanks.

Wolfgang.

From 8cc3c5fde12d0dc36b658483433d5b12be693492 Mon Sep 17 00:00:00 2001
From: Wolfgang Grandegger <wg@grandegger.com>
Date: Sat, 4 May 2013 22:28:43 +0200
Subject: [PATCH 07/12] c_can_pci: enable PCI bus master only for MSI

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 c_can_pci.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/c_can_pci.c b/c_can_pci.c
index 3a2ac45..98562c2 100644
--- a/c_can_pci.c
+++ b/c_can_pci.c
@@ -86,8 +86,11 @@ static int c_can_pci_probe(struct pci_dev *pdev,
 		goto out_disable_device;
 	}
 
-	pci_set_master(pdev);
-	pci_enable_msi(pdev);
+	ret = pci_enable_msi(pdev);
+	if (!ret) {
+		dev_info(&pdev->dev, "MSI enabled\n");
+		pci_set_master(pdev);
+	}
 
 	addr = pci_iomap(pdev, c_can_pci_data->bar, 0);
 	if (!addr) {
-- 
1.7.9.5


