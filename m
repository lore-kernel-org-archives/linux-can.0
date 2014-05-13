From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 1/3] can: c_can: make {read,write}_reg functions const
Date: Tue, 13 May 2014 15:40:19 +0200
Message-ID: <1399988421-19429-2-git-send-email-mkl@pengutronix.de>
References: <1399988421-19429-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59069 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933429AbaEMNkZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 May 2014 09:40:25 -0400
In-Reply-To: <1399988421-19429-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Pavel Machek <pavel@denx.de>, Thor Thayer <tthayer@altera.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Pavel Machek <pavel@denx.de>

This patch makes the {read,write}_reg functions const, this is a preparation to
make use of {read,write}_reg in the hwinit callback.

Signed-off-by: Thor Thayer <tthayer@altera.com>
Signed-off-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.h          |  4 ++--
 drivers/net/can/c_can/c_can_platform.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index c56f1b1..b948b55 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -176,8 +176,8 @@ struct c_can_priv {
 	atomic_t tx_active;
 	unsigned long tx_dir;
 	int last_status;
-	u16 (*read_reg) (struct c_can_priv *priv, enum reg index);
-	void (*write_reg) (struct c_can_priv *priv, enum reg index, u16 val);
+	u16 (*read_reg) (const struct c_can_priv *priv, enum reg index);
+	void (*write_reg) (const struct c_can_priv *priv, enum reg index, u16 val);
 	void __iomem *base;
 	const u16 *regs;
 	void *priv;		/* for board-specific data */
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 1df0b32..0b44f4d 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -47,31 +47,31 @@ static DEFINE_SPINLOCK(raminit_lock);
  * registers can be aligned to a 16-bit boundary or 32-bit boundary etc.
  * Handle the same by providing a common read/write interface.
  */
-static u16 c_can_plat_read_reg_aligned_to_16bit(struct c_can_priv *priv,
+static u16 c_can_plat_read_reg_aligned_to_16bit(const struct c_can_priv *priv,
 						enum reg index)
 {
 	return readw(priv->base + priv->regs[index]);
 }
 
-static void c_can_plat_write_reg_aligned_to_16bit(struct c_can_priv *priv,
+static void c_can_plat_write_reg_aligned_to_16bit(const struct c_can_priv *priv,
 						enum reg index, u16 val)
 {
 	writew(val, priv->base + priv->regs[index]);
 }
 
-static u16 c_can_plat_read_reg_aligned_to_32bit(struct c_can_priv *priv,
+static u16 c_can_plat_read_reg_aligned_to_32bit(const struct c_can_priv *priv,
 						enum reg index)
 {
 	return readw(priv->base + 2 * priv->regs[index]);
 }
 
-static void c_can_plat_write_reg_aligned_to_32bit(struct c_can_priv *priv,
+static void c_can_plat_write_reg_aligned_to_32bit(const struct c_can_priv *priv,
 						enum reg index, u16 val)
 {
 	writew(val, priv->base + 2 * priv->regs[index]);
 }
 
-static void c_can_hw_raminit_wait(const struct c_can_priv *priv, u32 mask,
+static void c_can_hw_raminit_wait_ti(const struct c_can_priv *priv, u32 mask,
 				  u32 val)
 {
 	/* We look only at the bits of our instance. */
-- 
2.0.0.rc0

