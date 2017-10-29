From: =?UTF-8?q?Richard=20Sch=C3=BCtz?= <rschuetz@uni-koblenz.de>
Subject: [PATCH] can: c_can: don't indicate triple sampling support for D_CAN
Date: Sun, 29 Oct 2017 13:03:22 +0100
Message-ID: <20171029120322.22197-1-rschuetz@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from nsmtp.uni-koblenz.de ([141.26.64.14]:50113 "EHLO
        nsmtp.uni-koblenz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdJ2MKF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 29 Oct 2017 08:10:05 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: =?UTF-8?q?Richard=20Sch=C3=BCtz?= <rschuetz@uni-koblenz.de>

The D_CAN controller doesn't provide a triple sampling mode, so don't set
the CAN_CTRLMODE_3_SAMPLES flag in ctrlmode_supported. Currently enabling
triple sampling is a no-op.

Signed-off-by: Richard Schütz <rschuetz@uni-koblenz.de>
---
 drivers/net/can/c_can/c_can_pci.c      | 1 -
 drivers/net/can/c_can/c_can_platform.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index cf7c18947189..d065c0e2d18e 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -178,7 +178,6 @@ static int c_can_pci_probe(struct pci_dev *pdev,
 		break;
 	case BOSCH_D_CAN:
 		priv->regs = reg_map_d_can;
-		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 46a746ee80bb..b5145a7f874c 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -320,7 +320,6 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		break;
 	case BOSCH_D_CAN:
 		priv->regs = reg_map_d_can;
-		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
 		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
 		priv->read_reg32 = d_can_plat_read_reg32;
-- 
2.14.3

