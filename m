Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0E3D9027;
	Tue, 29 Sep 2026 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696110; cv=none; b=oKRItVlp83uOExQ/V67/QVBtz3aMLG3P37dna+KLh+txh0ioXsfp3BzD3KYielnCVh0WcTvdSazYuetJKWLC+IantBraGV9D9B6HxpSKnAUpRM+36f9o7NSjIMIKhGhnGNfk63z0rqykVlsxOrCrBJC6ORE9akq/A9nGcNDtr9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696110; c=relaxed/simple;
	bh=ALOJGjXfEVnBLDMdqzQUkJ/XzdybxQcPb76lLHFJjUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGzeyna65UAm6TB7PS+hZWcb1aT60P8UcGT6raSt1R37TS1XS+EbTxqi/ueiXksjDhbPhJyEZjyMpKGCc3OozK8VdU1ExEP5tp9+pirFrZCWR5aO+7oGivCBxJF9IclRLeXHkOoc365BQrXci9n6PAov3k+O0/wQHfwTpjF0P4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRsbDl5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRsbDl5W"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A182C4AF13;
	Tue, 29 Sep 2026 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790696110;
	bh=ALOJGjXfEVnBLDMdqzQUkJ/XzdybxQcPb76lLHFJjUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TRsbDl5W7ny5i/N3kko98HGS4ikpShpFwkrtUTScpbu1SQF8F2wBuuFloSETzIUhl
	 3ghZ7jI3bT5AsRoFTehPNeF0pFT4uLSd4Z3OFcs30U64ygIB790QjwFZHD2517zqdc
	 Wncdqbbb6zp+d3NcZe4pcnR/8APT8YVwYzuxbN4HU0NmC7LVTru7kHoCNHs1tFqIVp
	 fu+pdFoexFupR6I2Pmb6GDwpyffX2ED8ZJ1xhcosk2+Whukj1oCkTYqdwifDAHp8oW
	 lJfSvd2ia8/gwtKXjCDJdLHgZaD8/ruMbW2e5dvGPQHg9aLzxv1iimBYM2CHT5Ej2/
	 CyaFaEUkzo7wQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC59CA5FA5;
	Tue, 29 Sep 2026 15:35:10 +0000 (UTC)
From: Chris Strong via B4 Relay <devnull+chris.strong.flocksafety.com@kernel.org>
Date: Tue, 29 Sep 2026 11:35:01 -0400
Subject: [PATCH net v2 1/2] can: rx-offload: add IRQ queue flush predicate
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-upstream-can-rx-offload-batching-v2-1-3b587c519f5d@flocksafety.com>
References: <20260929-upstream-can-rx-offload-batching-v2-0-3b587c519f5d@flocksafety.com>
In-Reply-To: <20260929-upstream-can-rx-offload-batching-v2-0-3b587c519f5d@flocksafety.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chris Strong <chris.strong@flocksafety.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790696109; l=1321;
 i=chris.strong@flocksafety.com; s=flock-workstation;
 h=from:subject:message-id;
 bh=QTrXEykdZqhdnMZDN6EuT4udd2059pFwyS2sp8cy81A=;
 b=7KUGkgsxVKmAsKHjJqIG0y2nwS7PbG4PGdycE0YPk7BGX7ro96+RWJlPPDbrwC6m2UvbDEjgz
 7GCjvhX9v3kAXXdhlAbKpUU1Pq7huULOGvcVjqsyANJgE7Nu6vx9p8x
X-Developer-Key: i=chris.strong@flocksafety.com; a=ed25519;
 pk=IaEYd0fwBUeOKjqZzp2UKZY1tn3CLcPh6JpOKznZyRE=
X-Endpoint-Received: by B4 Relay for
 chris.strong@flocksafety.com/flock-workstation with auth_id=1045
X-Original-From: Chris Strong <chris.strong@flocksafety.com>
Reply-To: chris.strong@flocksafety.com

From: Chris Strong <chris.strong@flocksafety.com>

Drivers that queue received SKBs from a threaded interrupt may need to
publish a partial batch before the handler returns. The existing overflow
check covers only the NAPI-visible queue after the IRQ-local queue has
been spliced, so it cannot guide that decision.

Add can_rx_offload_irq_queue_needs_flush() to report when the IRQ-local
queue reaches the NAPI poll weight. Keep the query separate from the
flush operation so callers can finish processing related interrupt
sources before publishing the batch.

Assisted-by: LLM
Signed-off-by: Chris Strong <chris.strong@flocksafety.com>
---
 include/linux/can/rx-offload.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index d29bb4521947..f9b9474f7190 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -62,4 +62,11 @@ static inline void can_rx_offload_disable(struct can_rx_offload *offload)
 	napi_disable(&offload->napi);
 }
 
+static inline bool
+can_rx_offload_irq_queue_needs_flush(const struct can_rx_offload *offload)
+{
+	/* skb_irq_queue is owned by the interrupt context queuing the SKBs. */
+	return skb_queue_len(&offload->skb_irq_queue) >= offload->napi.weight;
+}
+
 #endif /* !_CAN_RX_OFFLOAD_H */

-- 
2.43.0


