Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F073043787A;
	Tue, 29 Sep 2026 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716060; cv=pass; b=kdxLDabQ0ekMhl0rV5zmeH5TbTJ8NVjWKPimCVHYBsv+WgVaua5+O+EF8lIIxOD2MNYNKLWP8n3cdCtViWAItUHnuzf0ug/Kbe6YORSUkcszXUmLzahljYVqynNz/FwpoZuFqspWxngWi28nrWNh1wiaNX1BzgDxfGQelacJlXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716060; c=relaxed/simple;
	bh=oVtn4hjTILP4WfJawsId+8nWCMEuDrQvefKqr1eOG3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n09g0M8MdJv2p6/8tSoNkzxZAscmqqI+0wCNu9DMt55lQqAP2tf+mYq9iD5cfawIJgcKrkgf0AqSt8iurxnMZwABPn0GnhWtz3jC6nZRqP+lSiBxNbQqVVdDFcrmDGYpjD/xS46Q2r9euTeyhlW2e3tkvu400qKy5u3ytZl7U7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Em9s91LW; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Em9s91LW"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4595D20228B;
	Tue, 29 Sep 2026 23:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Px51A8V/hWNf0E0AfB0vilaoFyAZ784PRuLHBIiLo5s=;
	b=Em9s91LWV2qSsSNxejFNnzGRYksDbJgJf+ob41NhU2aXWzwsLteQSgJaUO5CNJi10gTzSR
	rEGutmY5SvOaPqjkkia5jEde9kO8GBqeKwTe6Ga4kIzX0CjWTjdX2jnTM4d6LSEenMoWg6
	oB8YdASyDry8KQE587H9xaA1j61mTadiX+YPMzKVi+1AoFTnyMvKoPQNOsCUCdYdnE+yUw
	EvcXPxQUgGUqJCOSOv7rcIdCADyFMS6yM6AjBmgau0eBolEGwc70nx7I0q1we4cu9+wxjg
	+P4IdM5HJLCDOOdDyuqJLandL+xnlpJPQtOCKhLo1EVbW3KLEx861JSq24k7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Px51A8V/hWNf0E0AfB0vilaoFyAZ784PRuLHBIiLo5s=;
	b=gl23tRu/nX6NtqYRh5Zz8aJsn9Sk82ug9qjJXjT/TqgWLuoxl7vTkKzc30b7P25524De7n
	1DtaScla5/dXKVfBLVQXMS/eqedcC+LH8j2JZy+bPdvlyeewRX7Jc5DChz6+rqRYEgaMng
	+fjHz3NhV4yVP1lVZ+ytoylkcGtq2xS4SVVhcufgOTqfvuZFmwyU3G5XxB6UBAIFdxNxMn
	UBOOtTOyy5PsWnp8cOOQCP1PR42/b3K/Kcgb6ZfIQKki+cV9/hPaCjwsN2H2bO/rGbXPpa
	8GcKIcxd7B9KHkPNSUOCYFaQ30CcarFdF14AvM98WfGTcAHtPRa9Cgofj4U5/A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716024; a=rsa-sha256;
	cv=none;
	b=YwXMteoRE81EwJf78+LIWiDQjM4OCavnd680akHHsPyGrTqFixQLz86HEDXFVIvnBGNaxE
	+Do7an8PH1z6rFuwz0rJKMMRwBlTRXWMtCH/wpkJ5schxZzGQ0Q1XjoyZgqQZ6OvFrwQ5P
	yZPylP5kpA2TqRVlflosBLNovZM4SHS2okDnGS2FQsbejXfXlWn473TRhrH4MhtW2Q5Ys/
	cQCvxd/pg6tRJCYAAMG8MwByOmsZN+9j13Abkh9kqC+RLVfkN/pgiXwBB7Tkoksf6CBKOJ
	VXQUrBPtGOu2T7X5oufm34l3yLFTC+TZCfU9ezfxU5RTgla964Kl8WyEnCWk2w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2W-003S4D-0U;
	Tue, 29 Sep 2026 23:07:04 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D13545B4CE0;
	Tue, 29 Sep 2026 21:07:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chris Strong <chris.strong@flocksafety.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 16/16] can: mcp251xfd: flush RX offload queue during long IRQs
Date: Tue, 29 Sep 2026 22:44:06 +0200
Message-ID: <20260929210700.1183036-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929210700.1183036-1-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Strong <chris.strong@flocksafety.com>

Under sustained receive traffic, the threaded interrupt handler can
continue draining the controller indefinitely. Received SKBs remain in
skb_irq_queue until the handler returns, but the overflow checks inspect
the NAPI-visible skb_queue instead. The IRQ-local queue can therefore grow
without bound while NAPI remains unscheduled, potentially exhausting
memory.

Stop the dedicated RX loop when the IRQ-local queue reaches the NAPI weight
so TEF and other pending interrupts are processed before publishing the
batch. Publish further batches from the main interrupt loop while the
controller remains busy. This bounds IRQ-local accumulation and keeps RX
and TEF timestamps from each controller-status pass in the same sort
window.

Fixes: c757096ea103 ("can: rx-offload: add skb queue for use during ISR")
Assisted-by: LLM
Signed-off-by: Chris Strong <chris.strong@flocksafety.com>
Link: https://patch.msgid.link/20260929-upstream-can-rx-offload-batching-v2-2-3b587c519f5d@flocksafety.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 8759bc05bd8f..26d6a0d4b34b 100644
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
2.53.0

