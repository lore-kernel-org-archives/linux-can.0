Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800414A3411;
	Tue,  4 Aug 2026 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873374; cv=none; b=GILi6NPaj+vUKuLe7W0aThg4xaAib5m8IXfrc01aVEsl/wqvO8UHAoe5S1xncMRUlPCnYQIW+nYIl2wtaAeHFvER8jivJR3cOuy9bkFZCqZ8oL3AzIKEuUwaFN4MDW/OeCKVhPO12OWMQK5KcS80g4hOkTfOeLZybE0WdANBFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873374; c=relaxed/simple;
	bh=ahPsx1g2Ywd8m3tBn6LylkLvKgOc1aUlGhtKFfuGL/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eC2Z3wPC04q//x21TyNlGdmtO7LnKams+JH0yTr3hbCq1X9uzRVlbElIvT+G1aJ1vzxkP5K76fl6b0b5nRMuk8Ikp7h6XqhJy8wfe9O0ktZ9EA5HrhQbBXxuTz/PmC+Ocwp6pr31RYdaQt3yT8fYjMgOpx+X7BaF5lQN4jNj8LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjCvu//Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjCvu//Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FB21F00A3A;
	Tue,  4 Aug 2026 19:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785873373;
	bh=IjVeu2ov4Hfaff0wpShF/aIsbEhE0AbFx8+wpJYAFT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HjCvu//YZ4DeosjoRcVTgbXDY5UrFynEgJnDQxR1NcULxr5/3gZPaaZfQzsVpOIxu
	 snyt2M3z6O6wYYa1i94TsixROEdlsLedJwaE+8/jlOlkeIJvo5/k0uChF2m2XpEZMy
	 gjKqBa8MFaseKFIOoT7U40Ax1KRafBj04Yrl8xbXLuxn1uIzbo9qb5sKUZLVIDtN6Y
	 7TMo74dBNA+C9BQCv7bsROB5xzuUIY40Q5sqDlme3SW/IthFrnh5J1E+RYCMeSk0AX
	 ljknMtXbR7KyUQv2l9FIh7uvY9aft1HQiismQJRzpS6WeY8quJoa3P6h36c2Huxz7n
	 R7JViwEt0Wo4w==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 04 Aug 2026 21:55:24 +0200
Subject: [PATCH 1/4] can: slcan: do not allocate unused echo skb
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-automate_iff_echo_flag-v1-1-26f06ff0f8bc@kernel.org>
References: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
In-Reply-To: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=ahPsx1g2Ywd8m3tBn6LylkLvKgOc1aUlGhtKFfuGL/M=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFlFzjcq/bruyErfdA+8s7rE5fbBBzNnaCWEtl1ZWiDge
 TBTxKasYyILgxgXg6WYIsuyck5uhY5C77BDfy1h5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 IEPHiIGLUwCmWvIhI8OZZVIB+yXWqQQoWnBP5W40Xqle/uig/dQie53lovF8zK8ZGVYvOf324Ad
 ld8VLaSeETE56/O7yscnN6d2t9KdekVu5hAUA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The slcan driver does not use the generic CAN echo skb helpers. It leaves
IFF_ECHO clear and relies on the PF_CAN fallback echo path instead.

There is therefore no need to allocate one generic echo skb slot for
slcan. Request zero echo skb slots when allocating the CAN netdevice.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/slcan/slcan-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 7439849d5c84..546b9dcb08cc 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -826,7 +826,7 @@ static int slcan_open(struct tty_struct *tty)
 	if (!tty->ops->write)
 		return -EOPNOTSUPP;
 
-	dev = alloc_candev(sizeof(*sl), 1);
+	dev = alloc_candev(sizeof(*sl), 0);
 	if (!dev)
 		return -ENFILE;
 

-- 
2.54.0

