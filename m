From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC v3 6/7] c_can_pci: enable PCI bus master only for MSI
Date: Tue, 11 Dec 2012 22:18:53 +0100
Message-ID: <1355260735-18994-7-git-send-email-wg@grandegger.com>
References: <1355260735-18994-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59245 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab2LKVTR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Dec 2012 16:19:17 -0500
In-Reply-To: <1355260735-18994-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander.Stein@systec-electronic.com, Christian.Bendele@gmx.net, Michael Pellegrini <mikep86@gmail.com>, bhupesh.sharma@st.com, Wolfgang Grandegger <wg@grandegger.com>

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/c_can/c_can_pci.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index 3a2ac45..98562c2 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
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

