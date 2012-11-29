From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC v2 5/7] c_can_pci: enable PCI bus master only for MSI
Date: Thu, 29 Nov 2012 15:39:45 +0100
Message-ID: <1354199987-10350-6-git-send-email-wg@grandegger.com>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44204 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab2K2Oj5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Nov 2012 09:39:57 -0500
In-Reply-To: <1354199987-10350-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: bhupesh.sharma@st.com, tomoya.rohm@gmail.com, Wolfgang Grandegger <wg@grandegger.com>

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/c_can/c_can_pci.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index 7b73f90..320e371 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -86,8 +86,11 @@ static int __devinit c_can_pci_probe(struct pci_dev *pdev,
 		goto out_disable_device;
 	}
 
-	pci_set_master(pdev);
-	pci_enable_msi(pdev);
+
+	if (!pci_enable_msi(pdev)) {
+		dev_info(&pdev->dev, "MSI enabled\n");
+		pci_set_master(pdev);
+	}
 
 	addr = pci_iomap(pdev, c_can_pci_data->bar, 0);
 	if (!addr) {
-- 
1.7.9.5

