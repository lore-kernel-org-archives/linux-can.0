Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794311482;
	b=4JGAocQQnpwwiyuSXkc+ecIepHkOMmJ1D5puBjwtDPUiSJyeXTF/JBP8Agu1azEs8tHK
	 5CzyLGeX8R2DtKdfeVvmfx4b4xRkbW5OqUm3t7svahJfc/Ggt35lHwGQtGZUARISB+dAJ
	 mQWkYVOtxcKn+Rp1mvVpPToddgp/6Fcq9MdV3+0tkaWFOHwwjmV0JDyn2OQC/H4swRGgd
	 vG92XfrAFQV0SWWiDY8sWuIV+SsdIoj+8gi8sxkC3DGIfeQPHmprWn8fIzbgfLBIuhgbT
	 uddtc0uambqD5r0V5aFHv8Ojod81Aqd4bGhuN2DWBZcVLDQejbiJSGCXTgY86qVukTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311482;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d4HNy9wJpg90Hhz9sk2AWur8gvwMQKYnAUoHhj+Xys8=;
	b=ToIcfEfi+Pu9PdhOWosbxZqhgEIhU5f1yC4P4QAgXliA54HFF2C90uVBMWguHxsR9gru
	 iiSAPYNtVNKlUBv5yxr8BI2pFNnGT9cua6uKT1Tx/dB52Y20NMP3UXoDQQx/ltytYzW7g
	 Qrn7tWdhetRkugMjhBB2sA1GBzBqLDO9+wZ06Zgy35OZkzPNO43XajT1yhsciA1+6tPfF
	 EfFq/IufgeAM7XOZn9aau7PODLlEtE3AeMFa4XxTYzTmrl0twShy4S90ucupY009LULI8
	 Qw3u2DkbgMbQjn7fVv9q0N83X2iutb45opaoIWbLS6tReWiWU7LL7hkvYulL1n7rsaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Iob5DEg9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED060A3818;
	Tue, 10 Nov 2026 11:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6ED060A3818
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Iob5DEg9
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 207DF202824;
	Tue, 10 Nov 2026 12:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4HNy9wJpg90Hhz9sk2AWur8gvwMQKYnAUoHhj+Xys8=;
	b=Iob5DEg955dUGrUaccpY4vaxXTcPsbTbnUezCQSZ0tDZ3wRhE8OSqlBzCKHABsaGY/kwpD
	WCB9G/iGZNU6VYGgQ3sMzjEEfDPyLnD3Vapp/T/TTLjVIFo9sgpzpWZbwz8hRo2nGFim3P
	XOkyZC7kD8P+zC/VUMQoO74DcFPVoTKR983lGMd6qlbLSCpH4U1O5JDNQkQXG3bIrYlPor
	MAbnBduHbXHCJnSvFPGlPbfizY85XizITJGFAvvAQeN5Y2+AP9KxlEfO029ta82mtYgZVw
	+iaLqmN5hTCm8aXRMBk9nSV7HLSBEn2OxlC3LveRto3yIUvm2c3fzbAESHpWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4HNy9wJpg90Hhz9sk2AWur8gvwMQKYnAUoHhj+Xys8=;
	b=LKai8KomYOCFJTfdcTDnxZ6oQF0lpmiz53xnjnj2x24lFQtVhXuw1wI36X6AM4g25VvJrm
	gjpCibmOG3pz/wtH3LhjS9AZQNIZvVbsZWm8x6hOEGu7ycDtIf1nVA4aA+6Gj9bGi5mrG1
	dOPJQJQsLLN0VnWkrXKL6ts6KB2LSoGYX5+Xla5iVT3NJiin0PBc8okC+Q6MQOGPTRTAhH
	JpAMSvsBckH4Wz+1o1M9Hahao6wd1Z5PTiQD6vUgINaJMBefVJXFKciGRIFVoJNefjB6dJ
	907KvOlma45KtwOJUbpQltaJoO5pYABtkgrztvHZKVU9xvVwM/if4p1xPfHRPw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794311477; a=rsa-sha256;
	cv=none;
	b=dYMIsZoURMRHRQQ1QvzFHqdUr1T28e/FP7bRkFv/c8cDf9+OJlNatQYb0P3e2q8T6/J7Zy
	vXibMdr4J2gqefYiDJpHN51skDb5PcB6pFF7Bj6yJ6oexw5Mks8kuYXFfnxCZ1NIIjWyV0
	59AZbFxDgc0eBMBMKznjpnpc6YGnILO0QycKEpknE3r2BliavMZWogooYhl8lSoCA9yqQT
	AM8XxoGvOB1rZ4wUXpCXf5rlNHKifw1FCmlz9O6svwZFCP+HZV45SyXj34JPgiYDk16GCk
	C4CrS0GWlp4BYyLEaVBStvfM/38q+wn48WtlD35T7HvD7Ibeh0B2pZK95vNDzA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQkNg-003UEt-3A;
	Tue, 10 Nov 2026 12:51:17 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 83BA15E688E;
	Tue, 10 Nov 2026 11:51:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 05/12] can: rcar_canfd: Add support for Renesas RZ/G3S
Date: Tue, 10 Nov 2026 12:41:28 +0100
Message-ID: <20261110115112.3807247-6-mkl@pengutronix.de>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add support for Renesas RZ/G3S

The Renesas RZ/G3S CAN-FD controller is largely compatible with the
variant found on the Renesas RZ/G3E. The main differences are:
- the RZ/G3S provides 16 AFL pages
- the RZ/G3S supports only two channels
- the RZ/G3S supports only CAN-FD operation and does not implement the
  bits used to select between classical CAN-only and CAN FD-only modes.
- the RZ/G3S includes an internal divider that allows the peripheral
  clock to be used as the CAN FD clock source.

Add support for the Renesas RZ/G3S.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260902141544.565763-6-claudiu.beznea+renesas@tuxon.dev
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index ac5d5959d8e4..74c3c3f20991 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -661,6 +661,26 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.fixed_canfd = 0,
 };
 
+static const struct rcar_canfd_hw_info r9a08g045_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
+	.regs = &rcar_gen4_regs,
+	.sh = &rcar_gen4_shift_data,
+	.rnc_field_width = 16,
+	.max_aflpn = 15,
+	.max_cftml = 31,
+	.max_channels = 2,
+	.postdiv = 2,
+	.shared_global_irqs = 0,
+	.multi_channel_irqs = 1,
+	.ch_interface_mode = 1,
+	.shared_can_regs = 1,
+	.external_clk = 1,
+	.fcan_pclk = 1,
+	.fixed_canfd = 1,
+};
+
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
@@ -2383,6 +2403,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
+	{ .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },
 	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
 	{ .compatible = "renesas,r9a09g077-canfd", .data = &r9a09g077_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
-- 
2.53.0

