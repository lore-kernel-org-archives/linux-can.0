From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH] can: mcp25xxfd: add listen-only mode
Date: Mon, 22 Jun 2020 14:20:47 +0200
Message-ID: <20200622122047.9494-1-dev.kurt@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:55746 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgFVMVW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2020 08:21:22 -0400
Received: from zotac.vandijck-laurijssen.be ([213.219.130.186]) by relay-b01.edpnet.be with ESMTP id M5C3DTIBV8sL629D for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 14:21:18 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

This commit enables listen-only mode, which works internally like CANFD mode.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
index c744a0bf2faa..f3bc7d0f1f94 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
@@ -392,7 +392,8 @@ static int mcp25xxfd_ring_alloc(struct mcp25xxfd_priv *priv)
 	int ram_free, i;
 
 	tef_obj_size = sizeof(struct mcp25xxfd_hw_tef_obj);
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+	/* listen-only mode works like FD mode */
+	if (priv->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_LISTENONLY)) {
 		tx_obj_num = MCP25XXFD_TX_OBJ_NUM_CANFD;
 		tx_obj_size = sizeof(struct mcp25xxfd_hw_tx_obj_canfd);
 		rx_obj_size = sizeof(struct mcp25xxfd_hw_rx_obj_canfd);
@@ -807,7 +808,7 @@ mcp25xxfd_chip_rx_fifo_init_one(const struct mcp25xxfd_priv *priv,
 		MCP25XXFD_REG_FIFOCON_RXOVIE |
 		MCP25XXFD_REG_FIFOCON_TFNRFNIE;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+	if (priv->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_LISTENONLY))
 		fifo_con |= FIELD_PREP(MCP25XXFD_REG_FIFOCON_PLSIZE_MASK,
 				       MCP25XXFD_REG_FIFOCON_PLSIZE_64);
 	else
@@ -857,7 +858,7 @@ static int mcp25xxfd_chip_fifo_init(const struct mcp25xxfd_priv *priv)
 		MCP25XXFD_REG_FIFOCON_TXEN |
 		MCP25XXFD_REG_FIFOCON_TXATIE;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+	if (priv->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_LISTENONLY))
 		val |= FIELD_PREP(MCP25XXFD_REG_FIFOCON_PLSIZE_MASK,
 				  MCP25XXFD_REG_FIFOCON_PLSIZE_64);
 	else
@@ -930,7 +931,9 @@ static u8 mcp25xxfd_get_normal_mode(const struct mcp25xxfd_priv *priv)
 {
 	u8 mode;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		mode = MCP25XXFD_REG_CON_MODE_LISTENONLY;
+	else if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
 		mode = MCP25XXFD_REG_CON_MODE_MIXED;
 	else
 		mode = MCP25XXFD_REG_CON_MODE_CAN2_0;
@@ -2778,6 +2781,7 @@ static int mcp25xxfd_probe(struct spi_device *spi)
 	priv->can.bittiming_const = &mcp25xxfd_bittiming_const;
 	priv->can.data_bittiming_const = &mcp25xxfd_data_bittiming_const;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_FD |
+		CAN_CTRLMODE_LISTENONLY |
 		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_FD_NON_ISO;
 	priv->ndev = ndev;
 	priv->spi = spi;
-- 
2.25.0
