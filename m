Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F45013B7;
	Mon, 28 Sep 2026 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624009; cv=pass; b=eZsVAJ0LFjmhuaBC07r3Ac7czZebBjBnp/cDUa2tlbKvxvOS573vN+hvGyj+TlRJbZtPhb4twg2l+h11/gn8HuDJ3Dx3pzFnWEvopU38/a72LolBTrNBkEME2nJ1A15F9pnWaU778gMA8quP8spdbrrdWXSaFzuKrdrBmnItbvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624009; c=relaxed/simple;
	bh=kSOlSIscQZe0306aX5k+RsvHBJbEK63sxcx9zWwRjpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuLeKCSb412rdb3ofIPIRLBICSB5ld5Ai+PbQ2ndzAcwLNHxl3uQbihz8iAujvW310ewm6RD1AfuieHJNeRdihZLcOIohulaQaOIYPNkUQdAe6DTwfRCQ6RY/sKhCxvhO6JYcwQk6ZIg7f++ggHTA3WkwwnPP5dBpwo0PUCAq/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Sa6QBIMH; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Sa6QBIMH"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 013AA202001;
	Mon, 28 Sep 2026 21:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtUvUZbNLfqn1T3lWZNOWw/wCRIPBTy03FF6Y++Q/So=;
	b=Sa6QBIMHs8psRvW9WNRA61QEU6+GCTRoEPXLvrn0bNLVZkOsdwvxzFJYpAifcfh54ZUOJ6
	HkQHwmCUrOlAdrHpNTxhy3nsuF6PgkC3diJTC69KBvWj5lljuJsTPhDKPyj1O1YW3+uSwB
	BD1ttBrAmvg3YQYTpmsbfM9aapTyp5uk4m95+Ab1Ap1mXFpAAdMf60Zg8Stac8GKatyMBr
	sm+dC2n3aHvCzup05j9UjqqP9FzGLPzkxJRu1G196mjZyrZlzaHOPZEEZ/jyz/3is+2UXE
	17ykdhoA+kMJr6lspMQvBLEnU1Mzt12JYRiF9/3iri6S8AagXGNe7TkTUAAGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtUvUZbNLfqn1T3lWZNOWw/wCRIPBTy03FF6Y++Q/So=;
	b=eI+fpfNguteseT6/jn03ViYc5YvmzpwvXjhjLzy2m11WQHlXxaXdjhBMBY/R83oiItled4
	uvvTPGZCdX0yHOPyU8hiN0cHaJ4Cp75ISImG7MRtfXJVHpJxV5PH91LoAhvp1Q63uHe8yc
	HO6LcBlRarLEExHQZD698FOodu+eiIF2BRDu3CESyvZCDP8EyTBw+Z+jn0USgSpAEr214l
	9evxq6KJ++IVnWPxTJcyVE+d3XmHmrnkz+LesZ0jT4vqoPtN/BB0J2EWw33KA+hmx4LHaf
	W9UKpl6MTmpG86m3EiVgVVTRTsdW1zRb73Q8U6a1SPJyVZE544mabIeU/w39ew==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=DUmEpFuwGXS2rr7mHKhTT0/CREykORHM8joy9aS1yGVQlYJRYRO0DNSNY21qdL/E30nZQU
	jCdsUAKDYT0g1VFUAbgBnh8NXfieAtBkkF/e6l/nKagUXZS6qV3gAe7q3YQ8MCee0ZPYpk
	gbsp3BX/+3LLT2XRKIDWXlwyw9oLMeXJ7GZ4Nf9qdGmmqUCSi0cVG8wnAOD8ET8NK7KazE
	ZM2QhhQA8Va0QVuk0DPBs3PAjETX4f6mDG5qXutb5lgEeBTOtNyd6jUbQBRYv77ytfpmH+
	dfY7bgN/JPq/OAjFvrr4blESJ13Zn/CYxr4f9E3zJ+exBU7mzHnWJOEr/88evA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6B-003H65-2d;
	Mon, 28 Sep 2026 21:33:15 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 83F7E5B154F;
	Mon, 28 Sep 2026 19:33:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Quchaosheng <quchaosheng000406@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 08/22] can: cc770: platform_get_irq(): propagate the error
Date: Mon, 28 Sep 2026 20:45:15 +0200
Message-ID: <20260928193312.553632-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quchaosheng <quchaosheng000406@163.com>

cc770_platform_probe() turns every failure of platform_get_irq() into
-ENODEV, including -EPROBE_DEFER. Return the error unchanged so that a
deferred probe stays deferred, and keep -ENODEV for the case where no
interrupt is described at all.

The memory resource is checked separately for the same reason, so that a
missing resource is still reported as -ENODEV rather than being confused
with an interrupt lookup failure.

The same pattern is used by other CAN platform drivers, such as
c_can_platform.c and flexcan-core.c.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20260914055611.495105-1-quchaosheng000406@163.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/cc770/cc770_platform.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index b6c4f02ffb97..ac218acedb10 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -156,8 +156,13 @@ static int cc770_platform_probe(struct platform_device *pdev)
 	int err, irq;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -ENODEV;
+
 	irq = platform_get_irq(pdev, 0);
-	if (!mem || irq <= 0)
+	if (irq < 0)
+		return irq;
+	if (!irq)
 		return -ENODEV;
 
 	mem_size = resource_size(mem);
-- 
2.53.0

