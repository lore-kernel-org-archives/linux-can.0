Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C0145D908;
	Tue, 29 Sep 2026 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716061; cv=pass; b=nPmzffBgawtSGeLK0cgWX+wfrw4PUNV/Cl1eunY1h+TyfZkcDx5ALhp4CJK/jPj5C+SMbWFsSQe4Ribhhsw7yrVb9CjEQpgrbyzUDHW+fQjY0716aKiPaYAVTrLw1EDVRab4Bh99KL9sAb7fbsp8jF+RBWDzQqGkEPwc/U9I0bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716061; c=relaxed/simple;
	bh=KDe9fHVSNEr529q5iusnG0EQmQ/8PUuh3in0I4G5Re0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCPjHA+Hks1lNUjuDgDRDz1/iZWwT5Jl4bAF7GZwinyQcwGpuSLumaxALk3kN8/REE7sHtUxIFpeHeETM1Hyf0TPCqh9IZhY+kV9O0gHGyxvfcAQTN4Ygi04ZBBSuhyG7er+NMSAKAfM4aLpUtmOhNEyRjvG6BXXE5SLus6/2Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=fG9QXBLi; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="fG9QXBLi"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2D5F2201F03;
	Tue, 29 Sep 2026 23:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZfGkW2/1hivBUzl01QmbV8IEUXpupiMov1cfpC61a4=;
	b=fG9QXBLijz2GMfnQbDZuKlRJYL/04LGHQU5OPgap6hCC0hbdZepy8VoKuHHDQ82EG8bZx7
	1PQU7SwZzIUro5t1ZoJk0dt/YvvlLmbR8flSotThBR7klvzaBI/1YD8ZXiB9qd5xh9176Z
	NfEzQlcjrpVfd1JYxI9zU3T+6NCSbC86MvZms69AtDuQRb0B3ihEGSuW2/WhxutNymSeQT
	ErCxi6QP7EOTY0oVwvtMgYj+1zstMUqSXws9FWYY63AaYSrawMNjSYyEKnc6FMpU/vCezZ
	mV/97KJ/cMQI+tC0rNVdJf6kie63nPT1HHi1Mrp59uEHsTcKnQsBbt6bD5tUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZfGkW2/1hivBUzl01QmbV8IEUXpupiMov1cfpC61a4=;
	b=V08mKC3n2dMmSyeAjlp+Jbxc331vC0iVQKiL6EE8M0XZ1Y+Px079CGGOtfbSGQ5uKysd+I
	m4zmxJ6gxZDE7BcS4oXBG9+8qwpDGXqWix/UV94ZKer+SLFFs1y+l3lzt924KQyqVx9Dya
	SpT8m+K1Sywy3bzgBovcw4BJ0Sp6W8oXbqIYW7DDW0jk1BsmuctfqJYjQjU6niw8AZSnfT
	S+F+t+ZP35OlFCefSiHj9c7rQsRv8PE4wS8rdljOTZ48BrDNBJzg6aAhdfeYhmNvffmHHe
	eJRq2U7x6ssg+p6LGnzZnHH6Ezlg/lJH+CPKH9pkOVSPqPLZvmZBqMl21WB5wQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716024; a=rsa-sha256;
	cv=none;
	b=JkegYgECMcWckFyg6fPzMW1HVzKUe9hwsZ46SIXwHhDapTORUWV/Vr+Yk4fHhgTof/ZVGc
	0+uOmZHSP2qgZRQHEZ3LXWClGvoXjwKwD/ovwsZAgiym2nciaguDZ+JjRCPNfO+HiF6msM
	4QVGMKJH4MypvISkokgiH574u/7fLgmH7fb1Pway+wnUqtHPJWfhVHEpyXi73ZlFhWpy39
	70xnnSE5IgN/CaCkaOb2Xu4MYVIGWUoK9OXM3Fo7KilGVBU8eZdab5MlNgn279QFYE+8fx
	md1LlsZND3CdNcs+laTMhkMkfrI7FZIHB4AYsqolPGFe8qCsQ59pUn2JJxWlBg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2W-003S4B-0A;
	Tue, 29 Sep 2026 23:07:04 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C4E255B4CDF;
	Tue, 29 Sep 2026 21:07:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chris Strong <chris.strong@flocksafety.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 15/16] can: rx-offload: add IRQ queue flush predicate
Date: Tue, 29 Sep 2026 22:44:05 +0200
Message-ID: <20260929210700.1183036-16-mkl@pengutronix.de>
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

Drivers that queue received SKBs from a threaded interrupt may need to
publish a partial batch before the handler returns. The existing overflow
check covers only the NAPI-visible queue after the IRQ-local queue has been
spliced, so it cannot guide that decision.

Add can_rx_offload_irq_queue_needs_flush() to report when the IRQ-local
queue reaches the NAPI poll weight. Keep the query separate from the flush
operation so callers can finish processing related interrupt sources before
publishing the batch.

Assisted-by: LLM
Signed-off-by: Chris Strong <chris.strong@flocksafety.com>
Link: https://patch.msgid.link/20260929-upstream-can-rx-offload-batching-v2-1-3b587c519f5d@flocksafety.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
2.53.0

