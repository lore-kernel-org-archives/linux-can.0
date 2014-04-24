From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 01/26] can: c_can_pci: Set the type of the IP core
Date: Fri, 25 Apr 2014 00:00:04 +0200
Message-ID: <1398376829-6771-2-git-send-email-mkl@pengutronix.de>
References: <1398376829-6771-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46155 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579AbaDXWAp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Apr 2014 18:00:45 -0400
In-Reply-To: <1398376829-6771-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

All type checks in c_can.c are != BOSCH_D_CAN so nobody noticed so far
that the pci code does not update the type information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index bce0be5..1b7ff40 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -132,6 +132,8 @@ static int c_can_pci_probe(struct pci_dev *pdev,
 		goto out_free_c_can;
 	}
 
+	priv->type = c_can_pci_data->type;
+
 	/* Configure access to registers */
 	switch (c_can_pci_data->reg_align) {
 	case C_CAN_REG_ALIGN_32:
-- 
1.9.0.279.gdc9e3eb

