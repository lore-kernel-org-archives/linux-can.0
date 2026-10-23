Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785246;
	b=aZicj/Wxl69YYhNKhydwiSDMiJUlXPTfOCP79rXj7S4OYaMKtm+CbzTma9gGSol9f503
	 WqWLzSCxmLJ7f6NoASy8I959JVeK6swUlMYxf+4YwPF0OzqSDBKqW4Oaaj0FVbvt8hVFa
	 8XrY383VJWSn+DqtDUcb5Rk2vSWpzTWHnn6msZHpHNrMas77r0Hg8L11lg5pmlBbYxcO9
	 RKtp39Ua8bTOyhIIUtVqB8rro0ZQPzEgJOikrR+sjdUNH8CWWJY4K/ukZPYFRR9npm5dZ
	 GfDZuMxEeRc0A3mhiYFcfIG3Rz2YCDbQvvLTYR9EVLnZyFsYrAQEdbN/+qw96L4uWOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y/sybD6YF8pEOR4iuvpSchqYgceX2IuNdq94snnQsys=;
	b=HRb3ymOundq76dwLKDHGZWfnqquWwBqe6NfkcYVnBd9TM6ykDDhoUveR8IGFYGL4Gaf0
	 W66lsYhVDJpj75rEVbtGtuVhEwH28lwgEkUZ1bB1sB1xY8QK226iUwiQDUe/MpwgjgGri
	 79B1c5vSDkPFZRuCE5trlHphOwGNeFI5MzzCM10dwbycBpAE0UecS2hKGGAzDFvtuBFk/
	 MmLuCoBjbBjyejHhsHaMbZbrfVokfVrwwoJ5XA4iYWxzZ6ZhvJGTuUbjPGWNsAEZDXlUU
	 UxOJNsyB6mpDekou0mXd4kgjIQlN8jHUcMXfrPmCturwQ514TNCBQ265azmzShMzXdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kDO2j2Uw;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1224C606A31E
	for <linux-can@vger.kernel.org>; Fri, 23 Oct 2026 19:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1224C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kDO2j2Uw
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4be28b82so1009661f8f.2
        for <linux-can@vger.kernel.org>; Fri, 23 Oct 2026 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785243; x=1793390043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y/sybD6YF8pEOR4iuvpSchqYgceX2IuNdq94snnQsys=;
        b=kDO2j2UwWFwvGWxii+D/B2dwST5vOkMFB6995qrsjTpInhR0p6cgLFf4Lf2aWKB/8X
         f+EKWq/GcAckmE/XvZ2gRMPLfLy1i6JWD8Jvp5GDw+SO4PRkMdymfp5W1J4iMwjoKCTA
         XHmuL6M7JJrIbNM6LD+GNe/+i81Lj0UuFBb74ghiyyYdlix8Hnb8Wv9Xh/GGp6ZWaxVX
         2p2eUhWIDjE1AeEUdNk2e2i2Cvm+fUdWgkJF2dinLCopnrFwe6X7vxwRlfw4NX7HPsjt
         ImP2VGg/vPvAJhmJaNrznreRs1+/6m/sXheKiTH8giYFD7Yf59FNO2bB7fbDqY2C1KFf
         1iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785243; x=1793390043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y/sybD6YF8pEOR4iuvpSchqYgceX2IuNdq94snnQsys=;
        b=ydMIsZnuToify1fzse3kp/N7cZGnzWw7RmOjLzBkVHjjwBhETvHVjEz41nkD5WufkZ
         6XuvbTwU7H8T5oFoLhJHbqxFbvoyj6aiUZxmBLOF6kcV+y0/ZlqAvxefP5KoAd7/tebL
         usYa9S7jBOxp6wTQu0hZh+SsjHmtJifg9jcllBPFLFQtEFmOoXDEFwfXxQHrh1TBO6YE
         DnStfC+hyrmjx21RQ1fRirggZiSRX5rRmjhpY9HxcLRVIwByfl/BdfR8tNZQlRai9mUu
         dFGsdNecJj3QXqPcRjxwm9RrWgyobPEVhVeubZvoXmQ5ukOyzzVKthSXfgt/fgByHXZM
         YHCw==
X-Forwarded-Encrypted: i=1; AKwUvBxode5idveMhU4jk2sGti5muNEaSMlr5I974+3DPifOQbu402Ygs25Py4u0+FB6gAiywGpEUfyIDiI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrV8AcZvzJ+U4Zms+K/xD37FfKuk3YyeunLGFhxiyfpAHy6jpg
	0g7fgZVTzQyQRAZFoUdowCpj/lgAmrfzJ85MGagv9pKKUzDHKlUBdx0rRF2D
X-Gm-Gg: AYBFou2XmUrgE1EzfprlrCMJ1eyv85FKyDoCQUgsYofp5etFDiFAB0IQiSbIOD13Mk4
	BVriWIkaz63ueTPlMYJFbksp36fA/Y7CH8SBUooxyR0y9KNeLWkQP70SCkHWJrdymX/BuePMzeO
	JHMEKRWTWp0gyB2+Tltx6mETq3louUNiIMR1LlRbRaMKRHTK60BfUYvLrrrN/9wjWQk4Jtw+c9X
	lkf+aXZU1S2KADLhuipRCH/p/W40GORu0/pFYFCAt8hGD8suX4eVBV8krLTTzKlR2Hjoa/xdoib
	82lriE8cn5RmauiMcugScSPjtQcwDgMX45WoETgkKAQLjPRPQxzZN/aqZ7OdM8ydNaALRh0Nfq+
	ECvSXWfcCEqC5TQm0WG9IbeNBUCEQD3FGdz/T3FEJPkVRVIFZdreReEpa79NhHWGxKum/J7/80+
	pfyAR3GR096JP3nnCAMIGw1OTJFZJ9CVim9ZJwDTRTox6qubtQoQcM+fJMjqbGyxsQsRdPgylLl
	p9ckTcRLgyo5j3F0xXfkdHu
X-Received: by 2002:a05:6000:4011:b0:48d:c29e:40c3 with SMTP id ffacd0b85a97d-48e3eba80b2mr57511f8f.33.1792785243224;
        Fri, 23 Oct 2026 12:54:03 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece13aasm32783f8f.58.2026.10.23.12.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:54:01 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] can: peak_usb: add missing dev_free callback to cancel restart_timer
Date: Fri, 23 Oct 2026 19:54:00 +0000
Message-ID: <20261023195400.3531721-1-tristmd@gmail.com>
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
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

The PCAN-USB adapter uses a restart_timer for bus error recovery
but does not define a dev_free callback.  When the device is
unplugged, peak_usb_disconnect() calls free_candev() without
cancelling the timer.  If a bus error armed the timer via
mod_timer() and USB disconnect races with it, the timer fires on
freed memory.

Add a pcan_usb_free() callback that cancels the restart_timer,
and register it as the adapter dev_free handler.

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c328564..b0b3c76b2ccb8 100644
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
@@ -1051,6 +1059,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
+	.dev_free = pcan_usb_free,
 	.dev_restart_async = pcan_usb_restart_async,
 	.do_get_berr_counter = pcan_usb_get_berr_counter,
 };
-- 
2.47.3

