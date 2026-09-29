Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9743D8107;
	Tue, 29 Sep 2026 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696110; cv=none; b=m8XCzyW9QDC8Vcsow8Au+59Si5xsW+RCYkvzQGuj2EryAtZ5CmxnBJ6rIkQu0BWEd1QSiE9XfvlLWhayho3pg+LRP7DpV+1yL38pCY22ZlmW685GFzWi6gzPf4iPxZ2BSSZe/k49ok9LH2KBja3pnTy9VXZOJ+riMJgZp6r70V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696110; c=relaxed/simple;
	bh=QDIUcGrm6sHInJWVG6jW09uegE6SNxPQxqSUuSMvpoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMXt7xmrWXthfBg80mvQkxc36h4xLqHjgMoZxtSWKI3xGTHPi53p4cxz8ECQDqHlFtQW57lxf0b7s37lz6As8k9NZyjurnJCFXx3tR0gDIsrxtsfXEKfmA9EQQwZ0nV1eYCg582kCls9hLqR48BXLfHKnNBPaKLy7c3mF9M73Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKefjkNk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKefjkNk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9998DC4AF15;
	Tue, 29 Sep 2026 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790696110;
	bh=QDIUcGrm6sHInJWVG6jW09uegE6SNxPQxqSUuSMvpoo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DKefjkNkuoIGS4rE/D5LULbHzbg6eZeKd7el/jlVETLVNgAle0xTOc0H4p+44UXRE
	 dVPguG3e8MAyblIUJT2kyLfH3w13O6h6jBY+U2cHwNrmwbpIK3YjQfNgF43u/XAayn
	 ZH4SnxVtIKyWdLVLUO0GDKF+RoWrDk3aWNBlMY7ddF5FY7ORKi/9vnvTPrTgynqeGM
	 xxF2qZ0y1g5aigRNeSa+D1IbK3IOL3CU8Kq8st7G7NF0oDugKMt/ZqZ6IdFYcVRp3O
	 Pyx+YMrK4pGa9ddWHIUeHhHv7Iz3BZiD7woqPQi5P/R76RwQop9bhjVobJP9vvHSkf
	 rYTaDuPqoXpSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B979CA5FAE;
	Tue, 29 Sep 2026 15:35:10 +0000 (UTC)
From: Chris Strong via B4 Relay <devnull+chris.strong.flocksafety.com@kernel.org>
Date: Tue, 29 Sep 2026 11:35:02 -0400
Subject: [PATCH net v2 2/2] can: mcp251xfd: flush RX offload queue during
 long IRQs
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-upstream-can-rx-offload-batching-v2-2-3b587c519f5d@flocksafety.com>
References: <20260929-upstream-can-rx-offload-batching-v2-0-3b587c519f5d@flocksafety.com>
In-Reply-To: <20260929-upstream-can-rx-offload-batching-v2-0-3b587c519f5d@flocksafety.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chris Strong <chris.strong@flocksafety.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790696109; l=2363;
 i=chris.strong@flocksafety.com; s=flock-workstation;
 h=from:subject:message-id;
 bh=Irg7Hh/rvvN2ZObBa7XWor4c8mF34tGo8/fv+q/HTp4=;
 b=3CqhrRsFq8VMT7W+g6O72MKf23v3bAJnQUYsrntLTjq3NGoHzf9u3IhG1UDHuS4Sk1OT4y841
 j0cDFcdJ2JZBjR32/0nE1TRJ4bw1wVuGIJDGmlAIJxY0NtDU0t4jfW+
X-Developer-Key: i=chris.strong@flocksafety.com; a=ed25519;
 pk=IaEYd0fwBUeOKjqZzp2UKZY1tn3CLcPh6JpOKznZyRE=
X-Endpoint-Received: by B4 Relay for
 chris.strong@flocksafety.com/flock-workstation with auth_id=1045
X-Original-From: Chris Strong <chris.strong@flocksafety.com>
Reply-To: chris.strong@flocksafety.com

From: Chris Strong <chris.strong@flocksafety.com>

Under sustained receive traffic, the threaded interrupt handler can
continue draining the controller indefinitely. Received SKBs remain in
skb_irq_queue until the handler returns, but the overflow checks inspect
the NAPI-visible skb_queue instead. The IRQ-local queue can therefore
grow without bound while NAPI remains unscheduled, potentially
exhausting memory.

Stop the dedicated RX loop when the IRQ-local queue reaches the NAPI
weight so TEF and other pending interrupts are processed before
publishing the batch. Publish further batches from the main interrupt
loop while the controller remains busy. This bounds IRQ-local
accumulation and keeps RX and TEF timestamps from each controller-status
pass in the same sort window.

Fixes: c757096ea103 ("can: rx-offload: add skb queue for use during ISR")
Assisted-by: LLM
Signed-off-by: Chris Strong <chris.strong@flocksafety.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index f441f2265299..d8078895b6d4 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1498,8 +1498,14 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
 			/* We don't know which RX-FIFO is pending, but only
 			 * handle the 1st RX-FIFO. Leave loop here if we have
 			 * more than 1 RX-FIFO to avoid starvation.
+			 *
+			 * Once the IRQ queue reaches the NAPI weight, process
+			 * TEF and other pending interrupts before publishing
+			 * the batch, keeping RX and TEF timestamps in the same
+			 * sort window.
 			 */
-		} while (priv->rx_ring_num == 1);
+		} while (priv->rx_ring_num == 1 &&
+			 !can_rx_offload_irq_queue_needs_flush(&priv->offload));
 
 	do {
 		u32 intf_pending, intf_pending_clearable;
@@ -1615,6 +1621,12 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
 			}
 		}
 
+		/* Keep each splice into the offload queue near one NAPI poll
+		 * budget when a busy controller keeps this handler running.
+		 */
+		if (can_rx_offload_irq_queue_needs_flush(&priv->offload))
+			can_rx_offload_threaded_irq_finish(&priv->offload);
+
 		handled = IRQ_HANDLED;
 	} while (1);
 

-- 
2.43.0


