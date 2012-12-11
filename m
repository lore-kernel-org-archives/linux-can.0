From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC v3 5/7] c_can_pci: introduce board specific PCI bar
Date: Tue, 11 Dec 2012 22:18:52 +0100
Message-ID: <1355260735-18994-6-git-send-email-wg@grandegger.com>
References: <1355260735-18994-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59239 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab2LKVTQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Dec 2012 16:19:16 -0500
In-Reply-To: <1355260735-18994-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander.Stein@systec-electronic.com, Christian.Bendele@gmx.net, Michael Pellegrini <mikep86@gmail.com>, bhupesh.sharma@st.com, Wolfgang Grandegger <wg@grandegger.com>

Also fix minor issue with pci_iomap specifying size 0 for
mapping the full range.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/c_can/c_can_pci.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index b374be7..3a2ac45 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -31,6 +31,8 @@ struct c_can_pci_data {
 	enum c_can_pci_reg_align reg_align;
 	/* Set the frequency */
 	unsigned int freq;
+	/* PCI bar number */
+	int bar;
 };
 
 /*
@@ -87,7 +89,7 @@ static int c_can_pci_probe(struct pci_dev *pdev,
 	pci_set_master(pdev);
 	pci_enable_msi(pdev);
 
-	addr = pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
+	addr = pci_iomap(pdev, c_can_pci_data->bar, 0);
 	if (!addr) {
 		dev_err(&pdev->dev,
 			"device has no PCI memory resources, "
@@ -195,6 +197,7 @@ static struct c_can_pci_data c_can_sta2x11= {
 	.type = BOSCH_C_CAN,
 	.reg_align = C_CAN_REG_ALIGN_32,
 	.freq = 52000000, /* 52 Mhz */
+	.bar = 0,
 };
 
 #define C_CAN_ID(_vend, _dev, _driverdata) {		\
-- 
1.7.9.5

