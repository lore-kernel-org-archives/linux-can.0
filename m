Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2671047C0F8;
	Tue, 29 Sep 2026 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671295; cv=pass; b=M5xT5YKbifPoLocQaECLICEr77h6cvBYBZxuRzy4yMb+1O+Jxbk37ObOSEb+0Jc7AY2dK1Zyg5JZ+eZ2h3722yQuqhvFQUeHYK7+jZh21b3kqZfKNRmxvw/GG2cS7etVZmUJM3KwNQQp84cMk6z2IhkENIrEBIBl7WnU5dKzZA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671295; c=relaxed/simple;
	bh=ifyLTMeuVsDv458JUi7PRhLOPSp/EvgHwNpABos9HrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IlIiAAVGWS0sRpFJHug+mEd5MB/KhtLSRWZ58b/MRk2vUXUAFHfEHogdZVyYHt0W/gHZ3NAzkDgzD3mnZo90qTR0OIRkT9jxLaRyRR29hRaZv6RUHP32aHwvdwHPuMA/nGKy4VnfnSprWIgjyJx8Bzri3tUrgQ8E85f6WiHg6KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=WK7ifxOk; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="WK7ifxOk"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BAF31201E6E;
	Tue, 29 Sep 2026 10:41:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790671289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dP0/8tUZqbkGFMkFxlQW3Pa2i+aTX2eHvc6W1tWwX2k=;
	b=WK7ifxOkcVdKKf21R4Hfgadrml9iukZE+adL+xhRAxkJ1G+2qavtQXw/qPumtxfeXPq1ua
	x6JyG4TJSt3wXgmyxTpRr9LSdY3gwIAmvkqo/KZRnLaa0L/5su72UtD2Out3v3g8m2Nq7W
	OiPPh+5ovgXqGjTV0mYWqZlQHxyWBwRnWC+VWyTpge84ejum/WhogtLkgLiPjT6bp9bW65
	peBdo4hPBRwajWEj8+q6ISwlv0Yx/T+m2gcEE5xxESxTI6hD4BlOta+TRE3sv8nQn8ARCl
	K8gIGq2VhAwHMzECNvB09pCzsmeXaFB0Zth2xaps7QFCrVddCXOXae3/kgza6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790671289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dP0/8tUZqbkGFMkFxlQW3Pa2i+aTX2eHvc6W1tWwX2k=;
	b=H2fMGd4gRvE8maW4OF4zYJxgeefCHLEm+Ww39n7oIpj5EIgwjRt0Wy319gSYLEVY4TZ0aX
	6v4bTAW1KRR5igfuGKP6p5gLuShLBgutOivXRZslszMyys4LniBBIHeA/akmFhFtHxhhwM
	fXpLnl3EAaNUDkE0IK7QTS41CpzKeXkiQq0NajIiTEzlzSXo14oG6Taif4qcA555+LunxI
	gTHWxcA8kNtxvl9/SaohdBgrlSKF3kp7V09ZP4nvSe4jWNXrzY4fEoEDPeMRP+xN/WvTDD
	d6ZJZiienerNQH7+WtNfvjQXExfmiv8ff2uxSNljfF/5XWhYwds2NSNWzupj2A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790671289; a=rsa-sha256;
	cv=none;
	b=RcHS8aNCR5lX+vB5bLbTp0z4RB18lauJwP2+6D5qDJytg9KChK4yL2NdUMpVMviYlSJ42y
	F1V78SqbS8kjj3ucFjWOazKyCLgFT5Wxgz5yijTKlvXM+h/medAboQs0L7hFzA1I5SdgsT
	5wTfma0i0dhVkK26p1SbWoORKDlVEBaqE6nyl8nhB3G3LCqBgcuYRALDEKAmLX4Cgmukwb
	6R6HLlmaDb6kDkQW5s01L6ei0BVS6TL+rzEbTvUWDB9l3hoqrZ4vUlbDZLkOcIWVpPKn/p
	Pta28Vs/+GpCU/6IlDcS+gVUtlCWclSiU0w3aXLLq210fztRldPrqUc9e9sE5w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBTOz-003MdW-2A;
	Tue, 29 Sep 2026 10:41:29 +0200
Received: from hardanger.blackshift.org (unknown [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5C46D5B32F1;
	Tue, 29 Sep 2026 08:41:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 29 Sep 2026 10:41:16 +0200
Subject: [PATCH can] can: esd: acc_start_xmit(): do not touch skb after
 can_put_echo_skb()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-esd-fix-skb-deref-v1-1-fa2529fbacdc@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMzQqDMBAGX0X23AWNaNFXKT3k50u7FdKStUUQ3
 91UjzMws5IiC5TGaqWMn6i8U4HmUpF/2vQASyhMpjZ9PZiBoYGjLKyT44CMyLZH13YNYnRXKt2
 nSFmO5428TXQ/pX7dC37+32jbdg3h+MN6AAAA
X-Change-ID: 20260929-esd-fix-skb-deref-a6e5351effb7
To: =?utf-8?q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>, socketcan@esd.eu, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ifyLTMeuVsDv458JUi7PRhLOPSp/EvgHwNpABos9HrM=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjaXblN+fxevUz7s6y3g4qnMXh8Ud39McDxdhqT5D+Bv
 in+3A52HaUsDGJcDLJiiixLf5xQFAh0KO19mTAJZg4rE8gQBi5OAZjIWwGG/5W5uUdXdTGLMe/Y
 +FlDuUT6XmeX2z73tc+Vuh7WPsmuesnI8JpvfsJCq16dqalGFXzTHjYJhafdc5EXvlM/vfCz5nc
 uBgA=
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
 drivers/net/can/esd/esdacc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
index 73e66f9a3781..2a02dae3be9f 100644
--- a/drivers/net/can/esd/esdacc.c
+++ b/drivers/net/can/esd/esdacc.c
@@ -70,6 +70,10 @@ static void acc_txq_put(struct acc_core *core, u32 acc_id, u32 acc_dlc,
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
@@ -287,11 +291,12 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 		acc_id = cf->can_id & CAN_SFF_MASK;
 	}
 
-	can_put_echo_skb(skb, netdev, core->tx_fifo_head, 0);
+	acc_txq_put(core, acc_id, acc_dlc, cf->data);
 
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

