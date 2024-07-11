Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E115614BFA2
	for <linux-can@vger.kernel.org>; Thu, 11 Jul 2024 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706681; cv=none; b=B/M/M8DG8MFCDLVFjjfwPKN10L96DRISRXLTyC3rSXBsbehmFuRhn/dfnF9fPG5Jy80+RtUIXJfYvzNwr3r7wggTD+mL695Jj4IEk7oCOxnQh4j8Ohmi4Hu1Xaa1pRHW9HvQ02ajXyqEajprmPqmcHN6jfpSEOv/0eHxanQpo8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706681; c=relaxed/simple;
	bh=NimSoyk6Yq3yt9JUMAaSii8X3KljSmyIAmXh3rHDB/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTbHnTPInFRlYeCKIs7x5J6P/eC17ed1F0LnxciTiy4h9vlTG7l2qir5TgALAhQPgqBAK8vf+VZeuLqTAJffsKtotLTpo43uYDHtGvg+LY1xKAk7g3hmQZ1V39lxSZXOc4A4a6DBQsSWppTAhVz6FkeXTBYeRLKKea4WTyFet60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=d6iWeT9P; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="d6iWeT9P"
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id 4C543E00FF;
	Thu, 11 Jul 2024 15:55:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kvaser.com; s=qmail;
	t=1720706103; bh=NimSoyk6Yq3yt9JUMAaSii8X3KljSmyIAmXh3rHDB/U=;
	h=From:To:Cc:Subject:Date:From;
	b=d6iWeT9PGirSBiymGj7iOWxd+yOiO78MwIXvKxzHLh8htye5s8wHLEJkteFk7Js1B
	 XGXKUzr00nzn5unETOJkUPGMr8Pj12yqP7PfWYv5B+F5qVX0GQJLi9Jl3Xfq/cOMXI
	 P9QX+iU/b4yafTf9kXEy/+mjj13SiIlooQafgCPKQqSu72EGiEWKNiK6THgdmAJQ51
	 34g1UrnYrv/C0GZTX4McbY7CvCvbLjSYWrMBNjT/yBuCB76VSjjeBdygeP+qnygnfF
	 //EiIwoqyuxArW+GY9bHACBR9BCxiAKNjkiAbmlKRXLvNNhStOO5gYeiIWZmlbVWBI
	 R7HOOGLaDDsLw==
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH] can: kvaser_pciefd: Use a single write when releasing RX buffers
Date: Thu, 11 Jul 2024 15:54:51 +0200
Message-ID: <20240711135451.2736466-1-martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should return from the ISR as fast as possible in order
not to mask a new interrupt.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index a60d9efd5f8d..9ffc3ffb4e8f 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1686,6 +1686,7 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 	const struct kvaser_pciefd_irq_mask *irq_mask = pcie->driver_data->irq_mask;
 	u32 pci_irq = ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR(pcie));
 	u32 srb_irq = 0;
+	u32 srb_release = 0;
 	int i;

 	if (!(pci_irq & irq_mask->all))
@@ -1699,17 +1700,14 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
 	}

-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD0) {
-		/* Reset DMA buffer 0, may trigger new interrupt */
-		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
-			  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
-	}
+	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD0)
+		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB0;

-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD1) {
-		/* Reset DMA buffer 1, may trigger new interrupt */
-		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
-			  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
-	}
+	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD1)
+		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB1;
+
+	if (srb_release)
+		iowrite32(srb_release, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);

 	return IRQ_HANDLED;
 }
--
2.43.0

