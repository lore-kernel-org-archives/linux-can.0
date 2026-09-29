Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BCD503BE7;
	Tue, 29 Sep 2026 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676754; cv=pass; b=AMDXoPhWhBSVZ8xnrz0fm0Pc2Z6Avm1DuhrKYhnH+FpmnYWhObCcAkHwntTbVIlVPqd1kIkAfIFuedLV2V5Qvkl/GmXWfempq25jUFIyIoyC8dRW8LeQr2ix5yNUXGotHGxoZQ+XIW0WwgVcq5OqtC2ebsbY2tdkIV9DbXSQ2Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676754; c=relaxed/simple;
	bh=XyIitUiP6AUCSd6cqj7uqBLAVwkOBK6aH7GJ5I7MbyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XBgjcjCOaiKp6RfD9igMvgcN0kXVw6LIJ/dF8v1he+eh682Xgd6u1sasUFcJFU+82YJscUBJzAPbbctx5mdy5djnkXU3nXTZnnZDCqIbn/W7ICUC7+e8Z+xOudcaVTvEda85tLpeg+353/jfoYaHLT7c8JDqwS7TH56VAb1TTlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=K2OlS5Bf; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="K2OlS5Bf"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EF56C200B4C;
	Tue, 29 Sep 2026 12:12:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790676735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ICjddjREjuGejT0MXNRqZQvp0TG3NvKLN4PVTJSpvsM=;
	b=K2OlS5Bf03hIV61YHI135mvuHxFIRMC/C2c2s8mSWieBxoULSPtY1b8pqY+RxATSbJeZnk
	Oz0JdTAPShqRSjA/i873w0rcIumurPABp9WZfwtXds1+puqtu4j/pXHaIKlAFGioaUcF7O
	HikTr6R3tFXjvIxJrjDqZKIoZd5BdmRQ4qEL6xiT/aNLHSeQTJGsFVJ0F6bFXbNzMlGHcg
	QRhDUGFBL7P0Tk6HZPeOD8Ud3mCtU83de5sXDQ6BFDKD6KhtM5jOCvm69YLlyH8ndBT9rI
	yf2PaW83NKy7I1yItliD8D/8peDJct3yhwLw8759NjXdtm6RhSyCSjvUP2HH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790676735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ICjddjREjuGejT0MXNRqZQvp0TG3NvKLN4PVTJSpvsM=;
	b=C+ibAJWp0dkSBX6OlGqOJHeacYC+Mm3XtTHvBeSD2Yh3LlC0rEwNkfftYt+xle/ecdFTEs
	CiQLe46Xzq7+GrBDZnhfcjxtNxlRupGQBjRCZmnQhwJfKCMNkA9DEZ8P30AWgqbkpKcL4I
	/LT03K/xJW+Wg8ih/3fNJmg7a6/T9iEA682TTqGGziXwn9mWGRSl/4mdOzPEw53JODPTlH
	Un1Y+Mm7bSXcXdS497OwMW5yb0LJy7E682+972i3Aw24iIsULy1ZmweKLdTFtnf5yU7m9V
	mthZ5hPX4mdaAQ3Vd8r0x4SgLuXX4uBT26gmi1H3uS8JBRSLeFPnn/zrn4gJuw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790676735; a=rsa-sha256;
	cv=none;
	b=T29zZEf2+GRat34bISic7Ny9b/NIc0oeyuCAPci7Jw5A3lDfe3zOXf05gJPl8NGXTAperF
	tcfC9MPs6DvYwazUmeFVH0wurYcGS66WNkBeJ3zV1jKSuP61kMATulCCDiOYlVNf2cVHDA
	HMJFC7DuKpyiABA7vfty9TJVOxemsybBDXFWVHLWXzR/Etj8CoCXhg5BQlfgBNbBT51fR0
	NNRoh0LfyAJiXY88Cu+e7Araf0hEOtYVZd44nJKMEn5BcLYv3iJnoTs7XV4Rvb220XuoD/
	p+iEX8IV4jFWhFsty2jxRnfxBqyMyoasG1fzi0T+sbGrrfoA1fkYtmA30nrJWQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBUop-003NBO-2o;
	Tue, 29 Sep 2026 12:12:15 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 934325B3469;
	Tue, 29 Sep 2026 10:12:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 29 Sep 2026 12:12:09 +0200
Subject: [PATCH can v2] can: esd: acc_start_xmit(): do not touch skb after
 can_put_echo_skb()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-esd-fix-skb-deref-v2-1-542e3e19fb25@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NzQ6CMBCEX4Xs2TW0BgyefA/DoT9bWE2K6QLBE
 N7dgnePM/nmmxWEEpPArVgh0czCQ8xBnwpwvYkdIfucQZe6LhvdIInHwAvKy6KnRAFNTdWlUhS
 CvULevXPJy+F8gDMR2l8pk32SG3fbjvUs45A+x/OsDvjPyaxQYTC60k2wxnl3f1PspjENkZezJ
 2i3bfsCUtbXJs4AAAA=
X-Change-ID: 20260929-esd-fix-skb-deref-a6e5351effb7
To: =?utf-8?q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>, socketcan@esd.eu, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2384; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=XyIitUiP6AUCSd6cqj7uqBLAVwkOBK6aH7GJ5I7MbyQ=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsja3fc3PqlS9ts+du6Qmv1TTjNpH+tUPbS89dzfkvWcP
 3VtP+pKd5SyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAiEvMZ/inMfWF1qNNEbP6X
 V3ZZ3zNW3SqLs1/hJt9f39znNmGHjDAjw7HTuz3MHvf2O3+LiPJY7CNXyD5T8O8Fp2qXG+3h80R
 tmQE=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

After the call to can_put_echo_skb() in acc_start_xmit() the skb should be
considered invalid and not accessed anymore, but acc_txq_put() will access
the skb's data.

So far acc_txq_put() first loads the CAN data into the controller then
starts the TX. Move the start-TX functionality into the acc_txq_start()
function.

In acc_start_xmit(), first load the data into the controller using
acc_txq_put(), then can_put_echo_skb() and finally start the TX with
acc_txq_start().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- acc_txq_put() remove unused acc_id paramter
- Link to v1: https://patch.msgid.link/20260929-esd-fix-skb-deref-v1-1-fa2529fbacdc@pengutronix.de
---
 drivers/net/can/esd/esdacc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
index 73e66f9a3781..05d41ed34a02 100644
--- a/drivers/net/can/esd/esdacc.c
+++ b/drivers/net/can/esd/esdacc.c
@@ -62,14 +62,17 @@ static void acc_resetmode_leave(struct acc_core *core)
 	acc_resetmode_entered(core);
 }
 
-static void acc_txq_put(struct acc_core *core, u32 acc_id, u32 acc_dlc,
-			const void *data)
+static void acc_txq_put(struct acc_core *core, u32 acc_dlc, const void *data)
 {
 	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_1,
 			   *((const u32 *)(data + 4)));
 	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_0,
 			   *((const u32 *)data));
 	acc_write32(core, ACC_CORE_OF_TXFIFO_DLC, acc_dlc);
+}
+
+static void acc_txq_start(struct acc_core *core, u32 acc_id)
+{
 	/* CAN id must be written at last. This write starts TX. */
 	acc_write32(core, ACC_CORE_OF_TXFIFO_ID, acc_id);
 }
@@ -287,11 +290,12 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 		acc_id = cf->can_id & CAN_SFF_MASK;
 	}
 
-	can_put_echo_skb(skb, netdev, core->tx_fifo_head, 0);
+	acc_txq_put(core, acc_dlc, cf->data);
 
+	can_put_echo_skb(skb, netdev, core->tx_fifo_head, 0);
 	core->tx_fifo_head = acc_tx_fifo_next(core, tx_fifo_head);
 
-	acc_txq_put(core, acc_id, acc_dlc, cf->data);
+	acc_txq_start(core, acc_id);
 
 	return NETDEV_TX_OK;
 }

---
base-commit: 37e02c42a00be692c06343e11779aadc45f45971
change-id: 20260929-esd-fix-skb-deref-a6e5351effb7

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

