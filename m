Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359243;
	b=vnmDfzQSpYeLyghm6otHtFryH1luPTDWgnAnafI3fqJiuF3b5g872XJ5WSwQ3rmDJ+vJ
	 ZJdENhQ+AS+3Q/enpYtPAAqP1qU02gsPDCPx7fFehRO2mdTYFR2iTFg9p2mNVvWCNE/+A
	 aUvyhhmVUoMMuZJJzuwIf3sFWLvhWPO/DvzWEBx9aKZkCXTvctLQfmleS9bmfytPgYwi0
	 8jzOALZwCs1n4XoNxitV4ytswkbhitKw4Qda71og7BPdCk/xkUl5QUqSXTQ2g74FnAAoZ
	 11ah4A4RRCinO6AX5pFtW9jLQm2umLureL3wQgQklHFTA7orAufH63Xs48wOC4NiWUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kA022g7KQybNzRUEnZcuUM/LgZ6Doe/PgmD0oq3A7Qk=;
	b=dP9hE1xhA5Hpg5Cjg47aS03vSumAhtLPEfJrIuFUJiqHK/wnZJwHk9BbQz5f7qiNp5uz
	 7SsFY2l6cBxrkeRM5acC2Hm2TBaQSOndfHyqjLZvQDxyTeNeafVNemItbGaHFKraxkFU2
	 ZDobwDdszUWJyHHxiAc0WoZlwMnF++bDyt/+PoABrSr/6J2D/aI091aiC+6gNBoaVLnxf
	 xSy6YA54Pg8P1P6kJIa6Vjzvv4D8fW4MR3kVphg9Ps0z1lU+XgUmlF1SodpT661muFFKg
	 GjroNxQI7CX3GPv5wMyJQCkbv1MyoiNW+hK3DtL/Esb1/F6Uv4lqOQWcGLCSsRYhMVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=euBpbDHI;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AC5606A327
	for <linux-can@vger.kernel.org>; Fri, 30 Oct 2026 11:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42AC5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=euBpbDHI
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso400621f8f.3
        for <linux-can@vger.kernel.org>; Fri, 30 Oct 2026 04:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793359242; x=1793964042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kA022g7KQybNzRUEnZcuUM/LgZ6Doe/PgmD0oq3A7Qk=;
        b=euBpbDHI8MidfO+H5M32k8tnJOgC6l6To+qZeBqfakmyjEHPb+Jm6N6yMm/tURZ7WL
         OI30/aCjFv8YdrXR4fAOjii2q1S8fqduBIB+VDyMT8+HWnFXYtfCISvWTipUBqZXXEyQ
         +N1gByyS32lXXUdy4MRJfNsTaeih/mppPVaNphVQWfHdlv1QXyZoxx4PZo/kipr0SyPR
         5TazH/GTZuOZY7d03NO4sb9Yg6Zv5yGb4mbso44InCRdRsHNJKEIBGZdLOdaMnlMMM1k
         WFrzv7tP7AbS8PGjHJIaLMWZOzEMmaKg2WS/OLg3pbjThU7ukQNpB/HF3yrFRUq8m7Mn
         klrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793359242; x=1793964042;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kA022g7KQybNzRUEnZcuUM/LgZ6Doe/PgmD0oq3A7Qk=;
        b=ryKyondL79mQabgJ4fsMrWhZO7EvGBTMkz0b6gyn4nwO90uw9aLVuDJGloTmCKALIM
         IZJW+FtVOjgqnwoh76rygID6sKDHBzS4xTdh9nLHVO4toE4Po2qqDn7IqwnCu940P/In
         W30RELDWvaoifaVDc8e8l60ItVj8G2J5zMwPy2cStxrPD8cjvIm3QT12paT24/eOXbT9
         v13TSul2EfzIF+nzQ4GiWpCJTJdYYWrEr2VG3u2wJn80hKre6QD1oXJxd7QOFPtRRGxQ
         vQ6pUg+0UTRwr5FI4giNaMpVKt4ebaIT6b23spubxmt7AEVRQCzMf/IiCmbKIFwd2CuB
         pmAw==
X-Forwarded-Encrypted: i=1; AKwUvBwYfalJKJSOuv74HI/M4Qg0KtOnNBq4rRkSr84u3XALQ+SOg9IkbKOlL75STIZ9GNmXJG1V3uU5ZZw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQe1ShFpmUN3mrmdn/5mfTh2mFJb5TKzDlqWXNiQxLqRGChumO
	Qvy9iUDWYf+g5TKOuqIIwGqcGVYKBCD1Jpttu0NBqqzXRSkG9WPWOB8=
X-Gm-Gg: AYBFou23YKxbKhY9sa81eblUv6Kg1wdYlDnEaIdqIM6q+fJuEa2BfEjzal7M75zCEGo
	kABRMIvzDb9MwDKXSbs/xAM6Jf2gmmWjUn5o4iAfT+NAIkTXsuLrnBLPVsYNxPmUJHtSrgKa2TO
	hoo2bUGQDo1ZHJZ8dMWXzDb1WRUoVZwL+XfRSe6XEdJ5k86BSI1StMzYac3xWgbtujSbPc0zn/V
	whr4X4uUFZFxHTw9htPNpS1AIh1TQvsOR/HR791PRrLiBMNwG/6QwqR16yeJLcKi0zCVq3qRQih
	sP6qIrzAlYIbiZKv4dfbyZHKglYUAgN+Eb6aseKag28LcWhKhtCZ0uKhWQvIFYrLIC1iq3NQJGp
	lDi/Mr0eAIIg6FcZUH6Qy6kEWZ6RjEfbTaAxoeVEIeAASmFZeFXsdvMP6EJoIeM/JvY1xd9oZmK
	H+AGwsf3PUW/fkNg6pWmJFPv/TJGiHy1sJmgszhcfTHqCgAAhzYXFgUubsWNt0bNxekRRbUUPKN
	nsyu4YztfKe6G8IoLgdXrf5A8zX72VCa2u1gF+1eLbM8+sJCk3ut8D9dIm5IR/tcfSqH/8jIg==
X-Received: by 2002:a05:6000:490f:b0:48d:ed96:e995 with SMTP id ffacd0b85a97d-48e74871c39mr807789f8f.28.1793359241515;
        Fri, 30 Oct 2026 04:20:41 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3e9sm2889544f8f.6.2026.10.30.04.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:20:40 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 net] can: peak_usb: fix use-after-free on PCAN-USB disconnect
Date: Fri, 30 Oct 2026 11:20:39 +0000
Message-ID: <20261030112039.422849-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

The PCAN-USB adapter uses a restart_timer for bus error recovery
but does not define a dev_free callback.  When the device is
unplugged, peak_usb_disconnect() frees the candev without cancelling
the timer.  If the restart URB completion handler
pcan_usb_restart_pending() has armed the timer and USB disconnect
races with the timer callback, the timer fires on freed memory.

Add a pcan_usb_free() callback that calls timer_shutdown_sync() on
the restart_timer and register it as the adapter dev_free handler so
that peak_usb_disconnect() drains the timer before freeing the
device.

Found by code review.

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Cc: stable@vger.kernel.org
Reviewed-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
- Restrict fix to disconnect path per Stéphane Grosjean (init-failure
  path is addressed by his peak_usb series [1])
- Fix container_of to fit on one line
- Add discovery method per netdev-bot request

[1] https://lore.kernel.org/r/20261022-canfd_check_channel_idx-v6-9-197704231551@peak-system.fr

Changes in v2:
- Use timer_shutdown_sync() instead of del_timer_sync() to prevent
  rearming
 drivers/net/can/usb/peak_usb/pcan_usb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c328564..0926e9affa95a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -882,6 +882,13 @@ static int pcan_usb_start(struct peak_usb_device *dev)
 	return pcan_usb_set_ext_vcc(dev, 0);
 }
 
+static void pcan_usb_free(struct peak_usb_device *dev)
+{
+	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
+
+	timer_shutdown_sync(&pdev->restart_timer);
+}
+
 static int pcan_usb_init(struct peak_usb_device *dev)
 {
 	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
@@ -1051,6 +1058,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
+	.dev_free = pcan_usb_free,
 	.dev_restart_async = pcan_usb_restart_async,
 	.do_get_berr_counter = pcan_usb_get_berr_counter,
 };
-- 
2.47.3

