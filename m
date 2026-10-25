Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792962180;
	b=TPz1Vc3qOfFc29cqECVBkOSC+ixlQFg9DeeeJCA671kXUg2R2BPsthVAK+sATgbz/ZfM
	 +Luht89/BSoyN7Enc1DbrFOI9UYXOWe2kY/Gs1KH5i+URs1PS0/dcsKKgMttVh4n6dfSe
	 /S9Gmd1dAwoRphlia8z9cbzsH5gpgB651oMOsz4AYaXbZ/FkzOJcVFzNid9psTix06oUm
	 sSAIC7x1TP25vh2+AmWhFKJSAKz3sXzQVsaxJwJ7tmyf3iP+ZumHIWGnGvJYjUeGZpnRx
	 FoQcl4fJ7bIQlWOHp0UtdiHdKj5rwpWRQByq1gfguKX94gOtsus0mUQFh0OfOpaGWsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792962180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZvdM/zwudCibbhvG92/DAjuffztDVUyeE/Q5y2G9nAA=;
	b=4n/0rLbD2UzAUqfvfGUyVSoe/ZHaYTQQBUzC+dDNUoFF21hnPkAg1+802/szejjRZ00b
	 WePwZ6Zqo33DL9ng8W0+/znaj6tDo5Un0jIAyuXqQ89p46zx468EEhcxpQHN/2X6VlGVU
	 wXTAEioLlkzEp8CmDpKwlgaw37mGuuOVh0lZe+G6FdocjV5/9gIAUHEUd0I8O1BdEvgn7
	 qG3Rifrk7qeHITOFGy7yzHSypTa26EQK1dWATRHX0goBMcCt5UiB2CjM4YzLRvuuBVvD9
	 mR+wdrM8jrr5OeNTjMeVE1nqoi4XsHdSNEgn8Z36S6vFLsJdbTHXI8wdVVCquUDr6VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C6kwohrd;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87347606A31A
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 21:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87347606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C6kwohrd
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c5358fc28so2214897f8f.0
        for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792962178; x=1793566978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvdM/zwudCibbhvG92/DAjuffztDVUyeE/Q5y2G9nAA=;
        b=C6kwohrdRBvofaSx1qmnvQje7E8iuZTJCsv53d4XxPyaSu4EcbbdgBCp9JFbmvFlhy
         YXNyoy9oAMVj5h5rDBeBAATHEMAbXMhftcsNERr5mCx5xsu0rrnPYIauxlazNmaaxEem
         xaLd+2K/zAOl5wGuoqf2lAuBdBOEt48a8AUcCNYFlI13TnS+Vfvay1nbvRIRgq6QAWm5
         KokiwBqbVbTd8q7lhrEwTLewDBLXNaUXIQm8UpDf6LYpUTv4LvZ0xMJ1MDvITkmUGegb
         4qeC+skOZmZm0phpdCvmjbjLf24Zdcn+aunV48yuwYoPDqZAsvgo07aNobvzsdTUnVdN
         DqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792962178; x=1793566978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvdM/zwudCibbhvG92/DAjuffztDVUyeE/Q5y2G9nAA=;
        b=pk/lT/y+K+CaFjyrCUbPZ0q9J2PVtPY96I1kacqoyIHmO4EL3m81tKUk6LvCeTCSYA
         5NkPWnZRQNMueHspPmu5F7yZ11v5v2rD8DMCjk6Fivgy9UA7YWvnEVWHSigR37SDgPIh
         YuKpq+W9pdAzmD7xBHw1uevNHwOrrIJTh4/dkbfNSZkPGMmB2giOTj63HR/7K8V1JbZh
         rJPJk+G0WCHyd8FibCi0YwVxedqraVk7zWev+uUrDLwnqO4nToK3TbKi0hQOe04EvJOO
         ncarMjhdOqG3GMHNSOxKxq7iQhRjZOT7lLDeokzas+ohXyTZrXyFVPm/mK90DC3Tl6dt
         xmuQ==
X-Gm-Message-State: AFq9FYKbiCZMUDcPJx7NQOBOCXWopPo8SNUX+Y7kEYC45I84mHDxkFH+
	fz6fmPNs9Do18nu6sW3pPBc3ipR3VWeCZcGgDZ2bM5xYlRXG6KRF/01fAbLE
X-Gm-Gg: AYBFou3t0pZd3PsjfSnmPhWAeTTndtR0DC6wxkBQ/AqVBGTIDINwSBSfLE87SplZx+H
	li9PDhDM+y6TP1PVKMVvhFCs7FvuXKchjmBgyAZdjclGmlUzteYynBuA1e+NKmfNcqvGYrgYZJq
	pgqH9CdxX4FH+vEgIHLTs8SdDD+dN9GNvS1HWfuwPQSC08hD8KBB5fUDb/V2ZND6Ti3b8/h8c1B
	vJ+1eXnfdBYOkmw+ailpe40bM5Nlh0uUe04f046cK/EHhzUaS0jV+OBXR5u6B0StDnQWSLj6OXc
	f9nwhMnepilZyYRpL4MTqEfXrEajjTh6HdQTkajulWLsHkTTWsTPc19VkB59xGu1PNeTJE16770
	PwooLtXUcyK3sl2r/R0OcoRVWqP0WkSiZfiz5CfVlJRJrCfFVRMzeos71/l7bIEEW2UTW3WI5mL
	ST3gOONra904MQUND7zo+N6x+2Hvxl2FCjL4NPvY5/35PezjQ6ZAT+LPH6SIn9MZAhwp7nQ17Vm
	Km1RUx4yWhS71tiCMGcd1c0vfY2U6778rngpA==
X-Received: by 2002:a5d:4743:0:b0:48d:f249:82c3 with SMTP id ffacd0b85a97d-48e3eb8b816mr5791876f8f.30.1792962177683;
        Sun, 25 Oct 2026 14:02:57 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f36asm12289177f8f.1.2026.10.25.14.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 14:02:56 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	mkl@pengutronix.de,
	socketcan@hartkopp.net,
	s.grosjean@peak-system.com,
	stable@vger.kernel.org
Subject: [PATCH v2 net] can: peak_usb: fix use-after-free on PCAN-USB disconnect and init failure
Date: Sun, 25 Oct 2026 21:02:56 +0000
Message-ID: <20261025210256.629830-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023195400.3531721-1-tristan@talencesecurity.com>
References: <20261023195400.3531721-1-tristan@talencesecurity.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCAN-USB adapter uses a restart_timer for bus error recovery
but does not define a dev_free callback.  When the device is
unplugged, peak_usb_disconnect() frees the candev without cancelling
the timer.  If a bus error armed the timer and USB disconnect races
with the timer callback, the timer fires on freed memory.

The same timer is initialized in pcan_usb_init() via timer_setup(),
but on error (e.g. failed USB command to read the serial number) the
function returns without cancelling it.  Because dev_init failure in
peak_usb_create_dev() jumps to lbl_unregister_candev and skips the
adap_dev_free label, the dev_free callback is never invoked either.

Add a pcan_usb_free() callback that calls timer_shutdown_sync() on
the restart_timer, register it as the adapter dev_free handler, and
also cancel the timer directly in pcan_usb_init() on error before
returning.

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c328564e..440d8e2cfb6fe6 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -882,6 +882,14 @@ static int pcan_usb_start(struct peak_usb_device *dev)
 	return pcan_usb_set_ext_vcc(dev, 0);
 }
 
+static void pcan_usb_free(struct peak_usb_device *dev)
+{
+	struct pcan_usb *pdev =
+		container_of(dev, struct pcan_usb, dev);
+
+	timer_shutdown_sync(&pdev->restart_timer);
+}
+
 static int pcan_usb_init(struct peak_usb_device *dev)
 {
 	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
@@ -901,6 +909,7 @@ static int pcan_usb_init(struct peak_usb_device *dev)
 		dev_err(dev->netdev->dev.parent,
 			"unable to read %s serial number (err %d)\n",
 			pcan_usb.name, err);
+		timer_shutdown_sync(&pdev->restart_timer);
 		return err;
 	}
 
@@ -1051,6 +1060,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
+	.dev_free = pcan_usb_free,
 	.dev_restart_async = pcan_usb_restart_async,
 	.do_get_berr_counter = pcan_usb_get_berr_counter,
 };
-- 
2.47.3

