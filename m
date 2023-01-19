Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC337C6379F
	for <linux-can@archiver.kernel.org>; Thu, 19 Jan 2023 16:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjASQIG (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 19 Jan 2023 11:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjASQHz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 11:07:55 -0500
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A26A8A70F
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 08:06:56 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 3ACC8FF3B7
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:46:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fvebxly0fovN for <linux-can@vger.kernel.org>;
        Thu, 19 Jan 2023 16:46:33 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     mkl@pengutronix.de, linux-can@vger.kernel.org
Cc:     wg@grandegger.com,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 6/8] can: ems_pci: Added IRQ enable
Date:   Thu, 19 Jan 2023 16:45:26 +0100
Message-Id: <20230119154528.28425-7-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230119154528.28425-1-uttenthaler@ems-wuensche.com>
References: <20230119154528.28425-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Added IRQ enable

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/sja1000/ems_pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index c32f4c7e8844..dddbf290c98e 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -373,14 +373,20 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 			SET_NETDEV_DEV(dev, &pdev->dev);
 			dev->dev_id = i;
 
-			if (card->version == 1)
+			if (card->version == 1) {
 				/* reset int flag of pita */
 				writel(PITA2_ICR_INT0_EN | PITA2_ICR_INT0,
 				       card->conf_addr + PITA2_ICR);
-			else
+			} else if (card->version == 2)
 				/* enable IRQ in PLX 9030 */
 				writel(PLX_ICSR_ENA_CLR,
 				       card->conf_addr + PLX_ICSR);
+			} else {
+				/* Enable IRQ in AX99100 */
+				writel(ASIX_LINTSR_INT0AC, card->conf_addr + ASIX_LINTSR);
+				/* Enable local INT0 input enable */
+				writel(readl(card->conf_addr + ASIX_LIEMR) | ASIX_LIEMR_L0EINTEN, card->conf_addr + ASIX_LIEMR);
+			}
 
 			/* Register SJA1000 device */
 			err = register_sja1000dev(dev);
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
