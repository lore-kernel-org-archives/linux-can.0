Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794311483;
	b=4QF+Kkc4dYTgaWgAPE+lF1qAqKNJsZNfgFvOmq02QHTXepNuPKt6Hhr/GjaBXIgv4gWX
	 5zQsSsyzZV9VLurzEUhEcS7cAeKTbs7vjWOeghb1L4BUN1+CqvKfoK9fRxgCAYjLBcUn/
	 V1v5OdQkAzAO6yrg5eOnEkDvlaoIkGKLJDZIPwjYhRSXHgXnY3zjJNnxwgVaxsZO/H9e1
	 zDKM0+8kFObMwQgivkD5zO2aXRDmjgQ2r4of6taTRqEmrPfILfW5lWVzBA1SGzX2L2hFv
	 QdZXMW8H2of54fykeF7Icjpo3QIjfm3eXk69jDst5FE8EaQjrlG5uyVhNDufD+yTThA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311483;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4EbClzWfXuXWyJ7jn5Hru+m9QYjO1tZmClnuorpE37U=;
	b=xTXa12gWLVI4GXBUlxo0nhMf8aFvVHvIGPjyh9IW6RKhvz0IU8F/VjnuhYMRb8vvs2dD
	 mHsaQS8DkDqiJCaSmil5IhiIfJUOT4B4mcKa04aPrfhXGkh9P07I/0ZQv8jlKqynUSD8b
	 KiyVgunvWEH0+oBm1/lnWg9anBjJsmbuRDqaJE1x5+ngB1q6/2h8MfiC1j6A6SwGVMKwi
	 Tmzk17y1GWRH+tfoUO9BEyqal7JdOybJdDiGF3rG7yDsEs4xVi0aUx6d8PSAWwrnXpj7C
	 IzaU8ybTR5jHj4kiE6JCnKa3vg9FEXFHVWroGqMQdk4RXom9RFLxEhd2HYaH8NgIbsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UWiJ68Np;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1243606A332;
	Tue, 10 Nov 2026 11:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1243606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UWiJ68Np
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4DBED20282F;
	Tue, 10 Nov 2026 12:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4EbClzWfXuXWyJ7jn5Hru+m9QYjO1tZmClnuorpE37U=;
	b=UWiJ68NpvlylL8XdOYYbQJd3mHj0LJ6aR955E/9cLK8vziO5HlwcRM7rGlo+loi3/W0CvO
	DjFVuxH2sRjl0wnFLn5dONV/QKF//Hjg9Z6O3ZNSnFd217PokylQd80rl/oVJbD+/bH0f9
	hzwmHRnvEvyph4shj/DMJhAWz+ARroIG1cZr0t8FeZjBMnsIdd0h+qB9ziGJXMDByXc3Sj
	Fu+lIieBZY+pXXYaUw0RdBh2BExzfFjPTCds8u/uU7GuJhLwJaVUyMpjA19twab5mq10+k
	JD5Cb1ZihIsWHQGVGx/+F6zJiYT7lyx4QPEMf5CHFdoMt3pAm1nIWZFsIUwBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4EbClzWfXuXWyJ7jn5Hru+m9QYjO1tZmClnuorpE37U=;
	b=DOAwMs0ILrL3B3HfqonbYApm5eLEW8EV9PaPP1UwVS9o1CfTUkotnCBI70+9A2nV38jcgn
	0sblKou/5WRHVMjz5666i8z/jqt1ivjkZz5c5pWcXR2dlv/68FbVHPZ9lYoqxwGvhKZcgt
	cs+dIL7V4u16ANSe/e8x6i91aL8hNxI2kQt6qIJyXvKRs6AqFJLxXvHPNsy7KpAUPBqXky
	YdKVI38bsQPefenWGdPAkftMi9O/uRr1XStWRhTppzOQduywxyb47I5SBr0xY6LpVCO10g
	AIJf1cVpdzVktu+Jf+1BJExALCJqZn5Z5tZ9tlzred+1YSg9yX4+9CiCUyfDDQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794311477; a=rsa-sha256;
	cv=none;
	b=EYx+eDzz3L3DTVbUmVedv0PCXDVQ0S5v1jvV+vVtPdXtxcgcGC2cmdpXcmzgxRHRgYhJXZ
	LZwgLUri36VHjx7tM50WTGDTRvdoCgF5hf0Y4jBwlqdegIwubL3B8j5mhcqVjtapv4PMiw
	40tUk/Q6WE3pTtM9PWyLubR07nlffP7tmQgIkk21jtF3hchSD/5Ft1+JAyBwJQe9grFib2
	LsNvxIV0LugO4lKNLovJ9CoYzbDE13FoU0rnNKu0jKzmI6Nh7hoggncVxuP1U4lQEpfnGZ
	2+mm7d4HaiAzt2oDXbFGNWvfKVMjUCbfdr7BJqfFf+Qj5PadHNSiBcA5iE51Og==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQkNh-003UFB-0f;
	Tue, 10 Nov 2026 12:51:17 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BBC4C5E6893;
	Tue, 10 Nov 2026 11:51:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.au@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 10/12] can: rcar_canfd: Document that RZ/G3S has no Classical CAN mode
Date: Tue, 10 Nov 2026 12:41:33 +0100
Message-ID: <20261110115112.3807247-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110115112.3807247-1-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
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

From: Biju Das <biju.das.au@gmail.com>

The header comments in the driver describe Classical CAN (CAN 2.0)
only mode as a mode the controller can operate in, without saying that
this does not apply to every supported SoC. RZ/G3S does not support
Classical CAN mode.

Update the comments to note the RZ/G3S exception, so that readers of
the driver are not misled about which SoCs can use that mode. This
matches the corresponding dt-bindings update.

No functional change.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20261021-canfd_rzg3l-v6-2-b4abfdba8e70@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 4f5cdfa8211d..072987316cc7 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -6,7 +6,7 @@
 
 /* The R-Car CAN FD controller can operate in either one of the below two modes
  *  - CAN FD only mode
- *  - Classical CAN (CAN 2.0) only mode
+ *  - Classical CAN (CAN 2.0) only mode (Except RZ/G3S)
  *
  * This driver puts the controller in CAN FD only mode by default. In this
  * mode, the controller acts as a CAN FD node that can also interoperate with
@@ -247,10 +247,10 @@
 #define RCANFD_CFFDCSTS_CFBRS		BIT(1)
 #define RCANFD_CFFDCSTS_CFESI		BIT(0)
 
-/* This controller supports either Classical CAN only mode or CAN FD only mode.
- * These modes are supported in two separate set of register maps & names.
- * However, some of the register offsets are common for both modes. Those
- * offsets are listed below as Common registers.
+/* This controller supports either Classical CAN only mode(Except RZ/G3S) or
+ * CAN FD only mode. These modes are supported in two separate set of register
+ * maps & names. However, some of the register offsets are common for both
+ * modes. Those offsets are listed below as Common registers.
  *
  * The CAN FD only mode specific registers & Classical CAN only mode specific
  * registers are listed separately. Their register names starts with
-- 
2.53.0

