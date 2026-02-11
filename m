Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21685309DDC
	for <linux-can@vger.kernel.org>; Wed, 11 Feb 2026 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806441; cv=none; b=cEwVb3mqGOQv/pSckEnE7qt0jWMWCcGC3VjfI3ICw0x5tIr9YzUruWF97ypOztCcqAaB1ve4PovqOAXddZ+p4+RIQBIogRRhf8vYraFKjuhsDDQEPehZ8sBDP44K3F1nsCeHOYjvfsTKKl1QbZG5nDulsL+0CSMLh+f2cJfr9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806441; c=relaxed/simple;
	bh=D0RDPWhiYsD3V5Mh38qNbN/nguKX2Lksu+LvsRSov/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oee8idyHsoE/pDloFoGjeH721QvZmQ86ZihwWKJA92y2g/YAIrKgTEITzVB5n3Ww2WUaujbWP60fNGkHEgjZwaqyU/k8U4trSOdBRe//CmNP5aivBOdVnjcSp9AEXOtMo6TpUDWTW7qV6R4Kgpxf7emlOyS6ye9o8DTPenLbzq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TrUet82u; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TrUet82u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TrUet82u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TrUet82u"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E7765BCC6;
	Wed, 11 Feb 2026 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770806438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CP9q110oDcuSLBo6RpJ+Ygu+0sfHV05K7sd02xWXlCU=;
	b=TrUet82uHbcQUAaKQ5jsTn0LCZwojoPSCp9iyi/tJrIHlnUj2sT1eXfjtMhG302jGXMMji
	Gyv6PBg0AJfjweaRfEvSHYC1eSScn/SCB9ibPksUV0HbNlkuebL/ksBPaZHm8FIjKMugtp
	Vrkb3SIi/YSB+bKOMDrPRNxET+tKqW4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770806438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CP9q110oDcuSLBo6RpJ+Ygu+0sfHV05K7sd02xWXlCU=;
	b=TrUet82uHbcQUAaKQ5jsTn0LCZwojoPSCp9iyi/tJrIHlnUj2sT1eXfjtMhG302jGXMMji
	Gyv6PBg0AJfjweaRfEvSHYC1eSScn/SCB9ibPksUV0HbNlkuebL/ksBPaZHm8FIjKMugtp
	Vrkb3SIi/YSB+bKOMDrPRNxET+tKqW4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F16B13A48;
	Wed, 11 Feb 2026 10:40:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +mYuEqZcjGnZQAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Wed, 11 Feb 2026 10:40:38 +0000
From: Oliver Neukum <oneukum@suse.com>
To: swilczek.lx@gmail.com,
	mailhol@kernel.org,
	mkl@pengutronix.de,
	linux-can@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] net: can: es58x: fully try proceeding with partial allocations
Date: Wed, 11 Feb 2026 11:40:29 +0100
Message-ID: <20260211104029.83860-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,pengutronix.de,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Flag: NO

Since b1979778e985 ("can: etas_es58x: allow partial RX URB
allocation to succeed") es58x_alloc_rx_urbs() sees a failure
to allocate and submit the full number of URBs as a success
and the driver will continue at reduced performance.

However, if you do so, there is no point in abandoning further
allocations or submissions, just because an earlier one failed.

Fixes: b1979778e985 ("can: etas_es58x: allow partial RX URB allocation to succeed")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 19fa51821a89..9dc66932267f 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1706,12 +1706,13 @@ static int es58x_alloc_rx_urbs(struct es58x_device *es58x_dev)
 	u8 *buf;
 	int i;
 	int ret = -EINVAL;
+	int allocated = 0;
 
 	for (i = 0; i < param->rx_urb_max; i++) {
 		ret = es58x_alloc_urb(es58x_dev, &urb, &buf, rx_buf_len,
 				      GFP_KERNEL);
 		if (ret)
-			break;
+			continue;
 
 		usb_fill_bulk_urb(urb, es58x_dev->udev, es58x_dev->rx_pipe,
 				  buf, rx_buf_len, es58x_read_bulk_callback,
@@ -1723,18 +1724,18 @@ static int es58x_alloc_rx_urbs(struct es58x_device *es58x_dev)
 			usb_unanchor_urb(urb);
 			usb_free_coherent(es58x_dev->udev, rx_buf_len,
 					  buf, urb->transfer_dma);
-			usb_free_urb(urb);
-			break;
+		} else {
+			allocated++;
 		}
 		usb_free_urb(urb);
 	}
 
-	if (i == 0) {
+	if (allocated == 0) {
 		dev_err(dev, "%s: Could not setup any rx URBs\n", __func__);
 		return ret;
 	}
 	dev_dbg(dev, "%s: Allocated %d rx URBs each of size %u\n",
-		__func__, i, rx_buf_len);
+		__func__, allocated, rx_buf_len);
 
 	return 0;
 }
-- 
2.53.0

