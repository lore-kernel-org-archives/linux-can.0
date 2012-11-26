From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC 3/6] c_can: add optional reset callback
Date: Mon, 26 Nov 2012 09:23:03 +0100
Message-ID: <1353918186-4234-4-git-send-email-wg@grandegger.com>
References: <1353918186-4234-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33881 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab2KZIXg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 03:23:36 -0500
In-Reply-To: <1353918186-4234-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: bhupesh.sharma@st.com, tomoya.rohm@gmail.com, Wolfgang Grandegger <wg@grandegger.com>

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/c_can/c_can.c |    3 +++
 drivers/net/can/c_can/c_can.h |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 4fab6b8..7dd771b 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -1123,6 +1123,9 @@ static int c_can_open(struct net_device *dev)
 		goto exit_irq_fail;
 	}
 
+	if (priv->reset)
+		priv->reset(priv);
+
 	napi_enable(&priv->napi);
 
 	/* start the c_can controller */
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index c683f0d..fd949a4 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -161,6 +161,7 @@ struct c_can_priv {
 	int last_status;
 	u16 (*read_reg) (struct c_can_priv *priv, enum reg index);
 	void (*write_reg) (struct c_can_priv *priv, enum reg index, u16 val);
+	void (*reset) (struct c_can_priv *priv);
 	void __iomem *base;
 	const u16 *regs;
 	unsigned long irq_flags; /* for request_irq() */
-- 
1.7.9.5

