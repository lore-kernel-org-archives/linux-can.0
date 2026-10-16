Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6C386443
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131118; cv=none; b=Py6h4zsJJwKM1Limk4M183kvGn/+Tm4mO4nAYDoLUiZQyC3vFcU48pijCdMt+6bJ6wKQOQxg5ktiI3KrcJ5EbCQNVcSnjlMJ653ooPVt8AXWeqraltgafQgNyHEPEUNdPz24BB6nohBSibM2o2PAi0ekbfnTjLPmT+MGxvGvtzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131118; c=relaxed/simple;
	bh=Z4ApbuOXeZFJ2fusE4nluHa9lroahiFieVjdHR5r3b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxqVhxwXg5zIzGZsf7GyFLCFN5iUCJpDSkSKDhyJq806uWluzbm6VHcmmOF9sNFne7/kEXs/5XHWIc4V22lgkwG20Gy1KW/Rs2tRM5IjUxMU1spJ80V52m9+vl+wKCZ39DbdrHvQXS/Kjntu6rNNKgdpU3h1/02K/gGjquF84KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdD00T7e; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdD00T7e"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4425915eec.0
        for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 23:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131116; x=1792735916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z2FM7jcIWlJ4PIwiCNBi2mvobRhODT2uuOupycVzBlw=;
        b=WdD00T7eTXdQ8s2w47F2v4DDeG+Gg47XVcHOwQWpNYhOMG292i8l7ZdEG1lEoDQEEL
         r6RMLdAaDaF50cf9vGxEwHR76xabpOnB9ZVXLECmgkJzyQForDkKTb0StXl8c9hGAGlX
         acj/ctzJSWTTmrQwoSAU46gcwUpHkYVmWKKIb19Ekf1Ykahs8mjXbztJfoH10hPCdvBS
         0dy6JKKn46DAQBV8DinG8/bxUsvukMPjBhx5tXUxzhsGHhckxO9vwqPd9PP61sNsFxMa
         moBCGyx/XwgKzuZ1camU7iaG/rWNhNFbZzqSH5aChYmCWzfJReP0b0aXu70GVJOk6Icf
         oIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131116; x=1792735916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z2FM7jcIWlJ4PIwiCNBi2mvobRhODT2uuOupycVzBlw=;
        b=V6mDieXL4199QwOhEDxP0GyQY8EWGVSaacWWDK2MekHqqyCWXCHrYIu7Dugc6dyzin
         dZXXELXW+yPTe1xZgvLBdYto4aCTBDjT19eYpMtKJcbdf+PcQQfQzt66/6flj0RdEP4x
         oZBK9fJpE3wVGbbQwoic70VoubzIjR0/g6q2o6Rt06qGcbUrN+xk8DnOsRTMfaWePBtZ
         4DyKE2W7l0jGi/3uy8waFRTdrbsL/0FYCl+3x4C8axK7s0KieuVRRu+1zL3pRY+naVY4
         dI/PsXbBQyCNActji3WCvNJ70t2TCOFLvuWuFR8TlPdyc4JI11JiFdrLtBOvzR2UhgHa
         xaAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwEtzIZwgn2jaMUuSXnu5Wevv2Swa2WeiApBLTnf4QcdYsbO0ChqK0FdY8YOGVIFQcrPo24hit9DBw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWl5Pbba3QLxCszLwR8n+DtHWuqvj1A5YnzqYDDzfq4xzISame
	VlX2Icb1pVg7W9VRFg3VdOftjMinctWWg6UDRnrD+rNydxtYKl7oQGkd
X-Gm-Gg: AYBFou39Ftd58e96dCwt8OcVfdn5EPqJ5bowQZLG/HIXS6MOdkwMZU3tbskk6gKLQHX
	J6iebou8FPVxCR+6nV+DsoSYvXINjl+hUJfxz2nH4cQDBjuNzLRzLX8Xw8qb7ZfZT2Zz6uuiqha
	IhGaRjC1G0U0TLqs2nxB1yGqnhVgE8aF5qlxZgtiJv29oknvgSrLNcn42MAUgJl55yQaWetV8O/
	VMp8EXbYRuWfISPc7bZvbIezzFiOnFuskbv2+6WQH4U2DrpRERijyJXaaqnJISV1k9SNouNBqp4
	f5GJ2p1wHeFiUN0WHR7LPymFNi9q5tuFgd2kPssQPxnnb2Ea5jBKtuPb05tPNKBIPdAWgBQSLIZ
	T6ZtUr02cwd8OWScw5s8Rf8uaxelNhWjg/xVQiulYd3hWvDoLa3suMmFhJosLiq2/i4PppFbHjd
	7SZV6S4+36obLRw6BmXH9uuOs8ga8HUriNeJfGrn7GfnOiYYivu1flrknJ7PugAGBQssmwK8hY4
	K+xveZWUznRCqKBP+dEoBf4CcFPKEWQUy1pEucVVBA6+VI=
X-Received: by 2002:a05:7022:f512:b0:16e:4723:5f86 with SMTP id a92af1059eb24-16e472365c0mr21571004c88.29.1792131115688;
        Thu, 15 Oct 2026 23:11:55 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm3755480c88.13.2026.10.15.23.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:11:55 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/4] can: sun4i_can: don't discard the IRQ lookup error in probe
Date: Fri, 16 Oct 2026 14:11:36 +0800
Message-ID: <2a7cb6e4e1b494efd4da512abbf307c19d9d1467.1792118040.git.chaosheng.qu.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
References: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun4ican_probe() collapses every failure of platform_get_irq() into
-ENODEV:

	irq = platform_get_irq(pdev, 0);
	if (irq < 0) {
		err = -ENODEV;
		goto exit_put_clk;
	}

The driver matches through an of_match_table, so of_irq_get() returns
-EPROBE_DEFER while the interrupt controller has not been probed. The
probe overwrites it and the driver core stops retrying, leaving the
device unbound even though the interrupt controller appears later.

Return the lookup error unchanged, which is what the neighbouring CAN
platform drivers do, e.g. commit 057bd6168d98 ("can: cc770: don't
discard the IRQ lookup error in probe").

A device tree without an interrupt now reports -ENXIO rather than
-ENODEV; the driver core treats both as a failed probe.

Build tested on x86_64.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 drivers/net/can/sun4i_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 76db6d09d1e6..a6c761506244 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -856,7 +856,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		err = -ENODEV;
+		err = irq;
 		goto exit_put_clk;
 	}
 
-- 
2.43.0

