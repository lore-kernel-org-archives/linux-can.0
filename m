Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794994337;
	b=vTRAUq85JHqAJCFTaTA+g0ywtH8aAv7Lx33NInkyPAKK+BJjmVgLZdItkyAqUTwN5nJx
	 1e17QKFlBTbBYTJV7Pkai1LoLgjN4eHeAky7ozga02xSyj5ivnQZwacOxsNxXDy1uv2yu
	 c72jWyQZ+0hWhQjgrn3mfcA1zsDRWIkGz0g9W1Ee/FvHSk5nHP6Nb9gRu7/zape1QhfSY
	 Ibm7k6jozDZqvQdRD2M8RgcXPvMy8JEYnk0go7EuR18mauPIlQXEnXv32PuCLagULLLb4
	 MrcYz9na9aW7ROuIdccRic5b9URRx2W/Y3sQgRbzT+FNNGhkNqjMBCjWwwiZGbHMYUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994337;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TrF8SM/o18Ay8gTAWiTW2vjlvxDrCKkFRmyiAg2Es2g=;
	b=XNPXrN3gdgLN+W1c8N2ldKsGvigCZ17vPPklEiSJQaqQzL6fPqBDaQAO5kFFC4Uj4yNK
	 3PgHeGipiD99fwb3yXOX8/shiloEPDAEDmhUjl3fAq2QI2yOYNSZjGzaGQ0ufsPfuBfa0
	 rHtFv+fS/YsbvTXDRbgBLJv1jLSscfVow516QQONE/TOCM19q/D3QxC2dyfETU7HQL4Bl
	 iB+8KqDorVQo8gQJ8DcGFltpdKmzE+W5f6rw83UCWiobBmLqdyMpxLlxQP1CrPDHvamAZ
	 X/67voxKDKp04M1LxqAO8QVNPOIXKmlYVp3rOV+CdZNoViIC22eRRnGtDBkz2ITCxwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=a0FBNH9c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28592606A32C;
	Wed, 18 Nov 2026 09:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28592606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=a0FBNH9c
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1078120497D;
	Wed, 18 Nov 2026 10:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TrF8SM/o18Ay8gTAWiTW2vjlvxDrCKkFRmyiAg2Es2g=;
	b=a0FBNH9cE/LVOlGTh28iqEh5gRUVVS3Vyvi4/ss2Im/lUBGURpQGVenEuHF6wMtd5M9atk
	cfu8FX9tixkwYzVdqSWWt8lQCzWjonzFoeQcwW3BLXjwyW9nBTEFHwiKPnPQyWchfMaDob
	LBk5oXX94/m82PcKXj9wmvSghQz9lgeu2flWiA+sei9vw5jXVp7w/xh2VGPCZrGCztm8By
	/pF6p1SViH2YsQt535JtHhBLgmZCYQZzcnwPJdQz8jVJF9R+QI9VkW7oW07H2lYNW2UdNb
	HrBg3hXbEy4TXj5oLocedDZ4XXzSX0p4cl6fK4es2D52a6p1l2xQixDl9xLGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TrF8SM/o18Ay8gTAWiTW2vjlvxDrCKkFRmyiAg2Es2g=;
	b=UORUUyR0khqo9ya5s1BH53/+LjXV/mN8h7yuInzc4s13FI/3657FQewz0UlcsTWSKbH93N
	CI8LHoDc5GeVEjYz/Xn4m93himxwq8HtnePi9fXrHv/gaSa+mJYH6EvcGu8NZgmVPtgaKp
	GBZ5csQc2RpXc9RGj76DM1f/ICDUci0h3bNrsE/JzRaJ9EbH39Irbu9B7eewXS5edEiF2n
	k1CgfH2YaowP5gMtMOn1OUihpgSoW2yfoDX+pvxbwcrDTgA0+E1SaxXyu6X/UReJiSXCtD
	Bk8E1H2PIcgAuR+6R5dVtb0dw9XmyqWwG961FYShMv1eJyJkh5RxDoBM2VQz4A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794994334; a=rsa-sha256;
	cv=none;
	b=Ax7k8VmVRwTVw/rnP8oVAgohMahVHNxecVi48vbVw+wQT9D4FMnuJYxLVjbLmQTai28kM2
	/Nqsbx3/FwnBKhYp6Jj+kQt3l3vcfPqVPTc0VgJgdjHTZJOQh5lpZqCGVRdMjEmIxb1bpz
	F+DQ7B9945D1dYOVNaap/TqjBU5HODhxlnPVCAYlP1n27BKvYJvPKzwf79ClQ1uQ7aqFJJ
	VRCmrYkqDhnTcMINWFFRkzInHThfQ60XTbeIfVSLcnwFdZqvThNWL2VHOzlzHcvUHYOy53
	RbU3l0nVVlrVu49ljFcUuvvG78NuTVCh+0/B5s7/0Yk/dxsZMwtVmX0iW4koxg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTc1V-000KHv-1M;
	Wed, 18 Nov 2026 10:32:13 +0100
Received: from blackshift.org (unknown [185.109.152.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1E6465EDC90;
	Wed, 18 Nov 2026 09:30:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chaosheng Qu <chaosheng.qu.linux@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/12] can: sun4i_can: don't discard the IRQ lookup error in probe
Date: Wed, 18 Nov 2026 10:11:39 +0100
Message-ID: <20261118092955.1283165-7-mkl@pengutronix.de>
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

From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

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
platform drivers do, e.g. previous commit ("can: cc770: don't discard the
IRQ lookup error in probe").

A device tree without an interrupt now reports -ENXIO rather than
-ENODEV; the driver core treats both as a failed probe.

Build tested on x86_64.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Link: https://patch.msgid.link/2a7cb6e4e1b494efd4da512abbf307c19d9d1467.1792118040.git.chaosheng.qu.linux@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sun4i_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index af52285d5a4e..80be48d0593d 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -853,7 +853,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		err = -ENODEV;
+		err = irq;
 		goto exit;
 	}
 
-- 
2.53.0

