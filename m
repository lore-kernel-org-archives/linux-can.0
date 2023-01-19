Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA62C004D4
	for <linux-can@archiver.kernel.org>; Thu, 19 Jan 2023 16:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjASQID (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 19 Jan 2023 11:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjASQHs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 11:07:48 -0500
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8ADDE8B30D
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 08:06:56 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 0D01CFF24E
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LEWtJUxRKj_V for <linux-can@vger.kernel.org>;
        Thu, 19 Jan 2023 16:46:29 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     mkl@pengutronix.de, linux-can@vger.kernel.org
Cc:     wg@grandegger.com,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 5/8] can: ems_pci: Initialize CAN controller base addresses
Date:   Thu, 19 Jan 2023 16:45:25 +0100
Message-Id: <20230119154528.28425-6-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230119154528.28425-1-uttenthaler@ems-wuensche.com>
References: <20230119154528.28425-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Added CAN controller base registers

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/sja1000/ems_pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 338233a5d337..c32f4c7e8844 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -343,20 +343,25 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 		priv->irq_flags = IRQF_SHARED;
 
 		dev->irq = pdev->irq;
-		priv->reg_base = card->base_addr + EMS_PCI_CAN_BASE_OFFSET
-					+ (i * EMS_PCI_CAN_CTRL_SIZE);
+
 		if (card->version == 1) {
 			priv->read_reg  = ems_pci_v1_read_reg;
 			priv->write_reg = ems_pci_v1_write_reg;
 			priv->post_irq  = ems_pci_v1_post_irq;
+			priv->reg_base = card->base_addr + EMS_PCI_V1_CAN_BASE_OFFSET
+					+ (i * EMS_PCI_V1_CAN_CTRL_SIZE);
 		} else if (card->version == 2) {
 			priv->read_reg  = ems_pci_v2_read_reg;
 			priv->write_reg = ems_pci_v2_write_reg;
 			priv->post_irq  = ems_pci_v2_post_irq;
+			priv->reg_base = card->base_addr + EMS_PCI_V2_CAN_BASE_OFFSET
+					+ (i * EMS_PCI_V2_CAN_CTRL_SIZE);
 		} else {
 			priv->read_reg  = ems_pci_v3_read_reg;
 			priv->write_reg = ems_pci_v3_write_reg;
 			priv->post_irq  = ems_pci_v3_post_irq;
+			priv->reg_base = card->base_addr + EMS_PCI_V3_CAN_BASE_OFFSET
+					+ (i * EMS_PCI_V3_CAN_CTRL_SIZE);
 		}
 
 		/* Check if channel is present */
-- 
2.35.3

--
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
