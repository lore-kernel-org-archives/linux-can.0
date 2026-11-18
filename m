Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794994339;
	b=BVOp8JY4L+1pw081o2hfki5FTt04WQ1BStz9Qj6H5Ci0aLGJMeDx/zTkvpunSr0JdMRS
	 1HFFeMD8o5joWm0JXcRCWYgCaB2LFQoWvrsZ5EFgINH7jxuVLbdn9xrGq2gKrL36yCWbv
	 ocRBcySV9hdrQh9pL2iMglQs0dQeCbTkh53U74cNlEBASSzA16eGoKt+QdkGDJC+cImAg
	 +Pq+OlEY5x+lZz2J4so8MPP6XuUgOxL3JDhBHZR9f6oEOigROlmgIYPosUjuORtvy0DJ6
	 KMktihmex1BqVrUZTLfKIg7QDVaV6s0F5GuKU9GnTaX7ZgIOG5NJdY8V6XbFbULmTnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TZAPHTUbf8VMhHAsUTnJRsNjeERe8BPObML4Zklpl5E=;
	b=x9AvmlasZdMDRDNKc+RFX49IGGEms2DcAui+SpCaLtCyVrrS3b77pCy7OSUVTm4rnTeR
	 a1A33mgmTao7NnK/AFweio1INiIuiYTxrZVOVITwMkUSJ7+Fn9128FLr1GqT0LOXXaXR8
	 sqkuPmXRAwape40xjAWYmbRN0jnNE43zojCS2jB8k30FxK0eKU1PYrnyRikKeRmdx1juz
	 +wbqgEPDlqkIFJ3bIexXp2tgUTSeQpD6mVEmxBTaldsrbAaMZlVZCwpC1oZb6OTJr06f0
	 Tke432S+HbEOmik4y8FkQyvcGTfw/eUWw8/utP2Bb5cR7mpxPLNkdfwYq2b6QeM5TVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=A1MKB43L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9317606A898;
	Wed, 18 Nov 2026 09:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9317606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=A1MKB43L
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7564E205ABC;
	Wed, 18 Nov 2026 10:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZAPHTUbf8VMhHAsUTnJRsNjeERe8BPObML4Zklpl5E=;
	b=A1MKB43LHM8iEebn8nwEVdAM+wti1MN6qyjkYuanHIGR3FNvVgrYoH8Uyxer2apgqkWWmr
	gF1n8Ev8FJF+kH6h9MMdUilM3NXz3NIshwXEjc8jJnxFvNooQnda3MBfqu3BEOTVZRbfd0
	HcfIaHlcNRC8WM3eYd8/Hd8mtWevqCxbipN/JoRwx7evrVmxCBB2WnLCT0MF2D3QwS2O46
	t7HuEwOg49eIA1uanCnv4uoU3m1F7B/zm5fdBSQ7s8n9o6DDOHtyQ3qtsLaA9XTvyXrZKj
	sTxdWr1T6aO8cy3bECGgY4CCEWaUE2vGTwB9FRDpEP8hkvrblunXQy4VxPm4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZAPHTUbf8VMhHAsUTnJRsNjeERe8BPObML4Zklpl5E=;
	b=Z+aGidAYE1QOT499k36YLbQQdzIxqYoNmySnuCqjhZuqJzdDRqpEY9Arm17U4p0qH0+Sm8
	bksAbR5A51kxTf5F1nyE1TnupiZJOvYgUQ3UdtfvtGsM8q7BPSQbE3UshmMvsQr1lHSvnv
	W08Y2ip2cZlGfkxZTWx3hutMgRTLUsMISezBvHZqxgEDSjpfeB9XJm0cddhqIuxux3mta5
	cWGRCwhdf+0NiNoUihhlRR08KGjAXPWpvP9FkCNV05vhA/ocaBHD8KF6cNH7GH7d4azg47
	uA7qRohhTj7hBpn9s+cvKAvBEpQPEp1da42hsBR01qDZMd+2wy/8t80gXEUL1A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794994334; a=rsa-sha256;
	cv=none;
	b=SomMWlW2TwvT4UqEaCxcXMn+4IeGfeFhgUzu1rNY4R2oeiXLeRcv1xpizOMoZrmjAAZwSK
	LuPN3i4swmoYS/lqmq4DGqQuOzgRgXav+VN3bYzcLTofR086BukW/x+COFOF7T5zdagRJD
	9POZX/4FKVpR1zWxHA+qBbC61np1KtAge1ZWrquNINaiHeIytcZV7TPL2/zcJToxyGFXiK
	zYBm9hSp873ZzV3sjjEGHpNwg/Se8vbs5XAbAV5ZogesRPvYs0BewmFC7HO97/Eqkh5MC0
	65GDj9+Arc8W1s8tdwMOQPdBrPGr+VBdDW9WwBK5mFVaUl7tJhtMEyWyffCQrw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTc1V-000KID-2b;
	Wed, 18 Nov 2026 10:32:14 +0100
Received: from blackshift.org (unknown [185.109.152.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EEDA35EDC8E;
	Wed, 18 Nov 2026 09:30:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chaosheng Qu <quchaosheng000406@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 05/12] can: cc770: don't discard the IRQ lookup error in probe
Date: Wed, 18 Nov 2026 10:11:38 +0100
Message-ID: <20261118092955.1283165-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118092955.1283165-1-mkl@pengutronix.de>
References: <20261118092955.1283165-1-mkl@pengutronix.de>
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

From: Chaosheng Qu <quchaosheng000406@163.com>

This is a robustness and consistency cleanup, this issue has not been seen
on real hardware.

cc770_platform_probe() collapses every failure of platform_get_irq()
into -ENODEV:

	irq = platform_get_irq(pdev, 0);
	if (!mem || irq <= 0)
		return -ENODEV;

That discards -EPROBE_DEFER, so a probe that has to wait for its
interrupt controller is never retried and the device stays unbound.

Return the lookup error unchanged, which is what the neighbouring CAN
platform drivers already do (c_can_platform.c, flexcan-core.c,
sja1000_platform.c). A device tree without an interrupt now reports
-ENXIO rather than -ENODEV; the driver core treats those two the same
way, so the outcome does not change.

The memory resource is checked first and on its own, so a missing
region no longer triggers an IRQ lookup that cannot succeed.

This patch was created with LLM assistance.

Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20261009105556.301821-1-quchaosheng000406@163.com
[mkl: clarify commit message]
[mkl: convert Assisted-by: tag into prose]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/cc770/cc770_platform.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index b690167c454f..c714a80ffd91 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -156,10 +156,13 @@ static int cc770_platform_probe(struct platform_device *pdev)
 	int err, irq;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (!mem || irq <= 0)
+	if (!mem)
 		return -ENODEV;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	mem_size = resource_size(mem);
 	if (!request_mem_region(mem->start, mem_size, pdev->name))
 		return -EBUSY;
-- 
2.53.0

