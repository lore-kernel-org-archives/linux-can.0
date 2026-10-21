Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571536;
	b=sF2zRJaRThtrpD4WvmcCQtQOtpl06br0n/6GSBbcsTXTKiqv4j1GUk3APVnJBMslvgO0
	 wZYuQiA7af4v49C/15zVk/zQ9doGslZf4+k3wLU/zNOcy4fSVYDeOEyhbNYURs9FQhdWf
	 jt9g213sv5z1HctHi284CdJbJu6v0Ab0TkxnCzlrM9J3bSFWkSwMMcBosJoSlAijYqXZG
	 ekWHAzuDArCYTizi24uQ5wkdIizoESi/eF7SsGkKI1neu07pKnrhF+QosKIBWz8Vl+ipC
	 01D/qzZcKIRsb8A5BBdzBertKw0IFMZVTTcyD/kcm0Mm5M0Z6dAIUI0QqdifuvfVL1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5ULIkKvwaWQI67UTt7sKZLeHrIi/qSx+LiDlZeAM51g=;
	b=MNTokwikRcIWb21zzq8UUQQD5/OKav1D3f8ujZQ3cRKv45tNJeYmGb76Rc+I/duycR1j
	 4O5XvNexzq0g0F9HVbz/Lq06xqrOaNC2Ari1shlsm3YMnekkYpvl3M+CZO7Se6bglHC5e
	 hBtvF0jcsFURhZh4liz46ZGYr8sUxc3JaSz8feacsycs8PySS/4TjIr/IHL9/ZXlBVFK5
	 Ht1ZcBQYierEKl+E3aEvrL9f9n2ALXmzjVWcyOzEllJlhDQI3vF0m02SWPnh66fYYQl2q
	 uB4CHH3C+4rW272lmf0b9LUFOz+e/FlmhyRmsBwKst3+77wl+RZ4Pe5sonLVkYsXhmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TPSX9hAw;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22978606A32E
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 08:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22978606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TPSX9hAw
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1efc90e7cso8831335e9.1
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 01:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571534; x=1793176334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ULIkKvwaWQI67UTt7sKZLeHrIi/qSx+LiDlZeAM51g=;
        b=TPSX9hAw13viOJ51MNDDNRuYGgwsMMG9b9960TUVTwW0asT/XwBFzC7DJg5Y5Peabj
         91HTzrQvV1PI2hLa6O6T4lacbs1jgOGec6/feFrabTrNqTJYF/NV0UhIvenxKwlZR/bc
         Cd/LzWO04/dqXMClE3G52rDFlZJyVk/4ZiTsc80K1pqeGZJuKRuJwl6pRTqyd9UUl8VE
         XYOCxBx4ldHP0LQP8W1JW5HsP0IWezqoqy8Soyzu+UA68GZTmFR/EZhI56k779BrIZes
         Gtq2wXXS4V96IeLSGF+FLGizf0L8uih0qhYlTrMmhaVsAq/FH4qhxAOAlzrHyDoL9Vgi
         Emiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571534; x=1793176334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ULIkKvwaWQI67UTt7sKZLeHrIi/qSx+LiDlZeAM51g=;
        b=PXvOKjyBlwMJo3DxjJScZbvELAL+k0NA7FbDgUsmt2GmT4LKr9x3IwWfSishYSprYT
         MPxhNN2l6lUhWlcgQ3f8D7aVNSt1uHaOv/BvhbLR/s4s/GKJ3EW5ErEqEYnZlrmNLFE1
         mVIZVT1samUeXvi8QgmZilQnjcDiV2eZrtKuxPFi9+fGmvCi/gL6eGducdysSwLIFrsy
         nADI4q1Ff+jqMs7puuePgba70IRyfQyBJ73PdxP5HiEw663awfNh0hM4x/vsDxjG3nhI
         njaalh03bMW3+WV56jDBfNwkWe89Lip/Hc76QUKXvQ0MovCu8FBhu6ygn7biUuPBb/8D
         s4FA==
X-Gm-Message-State: AFq9FYJqWagOh/Frn4z/AZKC8kgjn02kj0FCINci+loQRmXJ9amosPDf
	l10zrnyDEfJcnMQQ3GOEMT46ckqCdYESd+9hrv1NYcMsYXzhBbWnyvdE
X-Gm-Gg: AYBFou3t5iCUK+1R5IhmKmMjkQtAmf8EWw16BvPuPKzsC0UnPQJpOzN4pnLMvGwSaL8
	3KkmfRMHreOClBpaYA+IcmlZaLtlAK18tJ+R9NZ/WzA2xA5EwSsUIgO4HR25Oq6TAG/57HRcvAM
	KxVAsw3+q5sbh6AszcUcJdQYpp8uSJgCuVaCnmiypKaBEAZ+JPa4k1CIhWXrR76ZOavO7A0unnI
	QiZOL6CsFb+YH/GoFLFqOsJfCK+sp40RPBNb1hzBmxiIF5KtWfpjEZ7QOTQGmH5EYIQax3R3VpC
	PpZvBW43MklSdZtzGEvq67efRl2Qkxl5KI3wuD64V6dgoCIHhqFs2LEMRAG9NBg/EanPm2+YlaW
	9lCzYf/HsHLSJAvROnm76P8IVwb+xiPoRkqXqYgfdiz9VIcjvh9iifJ2YpCu9WKkbvt+cKPXjCc
	jMNErjn8fG7BwQep5sZsmxmzo+EprZjsIz3MYu+/zHc+wWfa/Pwfcql9rDOglkkSn5r3RDqJhlp
	cR/Kkml83dWe5ofy4Y61iXvUt/k7lDmBTK0odnUV4psYLAC/VUD3vwxT6avjurywR56JoZXoH+i
	ZhKz//UN19plj+c13NpxWiM=
X-Received: by 2002:a05:600c:3103:b0:4a1:e57b:667e with SMTP id 5b1f17b1804b1-4a1fdb155bbmr27564805e9.4.1792571534212;
        Wed, 21 Oct 2026 01:32:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:39f4:e118:e272:79d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm36250145e9.4.2026.10.21.01.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:32:13 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
X-Google-Original-From: Biju Das <biju.das.jz@bp.renesas.com>
Date: Wed, 21 Oct 2026 09:32:04 +0100
Subject: [PATCH v6 4/4] can: rcar_canfd: Add support for Renesas RZ/G3L
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-canfd_rzg3l-v6-4-b4abfdba8e70@bp.renesas.com>
References: <20261021-canfd_rzg3l-v6-0-b4abfdba8e70@bp.renesas.com>
In-Reply-To: <20261021-canfd_rzg3l-v6-0-b4abfdba8e70@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792571528; l=3895;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=y2Mps8bfpUVBsT29o/nYD2/x6wtmg90QtO5iKikQJVk=;
 b=pGiu93n+LR2RblBYw7xxK37coY3NAQuHm9DGkEpPyqRsS1oX8i1QBUJLlojT1xwxRTEM7VZwV
 H2x1d0EhllzDCy5iWSWi1jAj8brbokXqPhm+OV6TKoaELMOcyLEDmUF
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

Add support for Renesas RZ/G3L CANFD IP. RZ/G3L has 3 channels and
11 interrupts, compared 2 channels and 8 interrupts on RZ/G3S.
RZ/G3L has 288 buffers compared to 192 buffers on RZ/G3S.

Like RZ/G3S, the controller supports only CAN-FD mode and update
the comments to note that Classical CAN mode is not available on
RZ/G3L either.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5->v6:
 * No change.
v4->v5:
 * Dropped the tags as there are new changes.
 * Documented Classical CAN mode is not available on RZ/G3L.
 * Added r9a08g046_hw_info to device data.
v3->v4:
 * Collected the tag.
v2->v3:
 * Fixed the typo 198->192 buffers in commit description.
 * Collected the tag.
v1->v2:
 * Updated commit description
 * Dropped RZ/G3S fallback
---
 drivers/net/can/rcar/rcar_canfd.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 86fa88ccf63b..0da2fefb047b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -6,7 +6,7 @@
 
 /* The R-Car CAN FD controller can operate in either one of the below two modes
  *  - CAN FD only mode
- *  - Classical CAN (CAN 2.0) only mode (Except RZ/G3S)
+ *  - Classical CAN (CAN 2.0) only mode (Except RZ/G3{L,S})
  *
  * This driver puts the controller in CAN FD only mode by default. In this
  * mode, the controller acts as a CAN FD node that can also interoperate with
@@ -247,10 +247,10 @@
 #define RCANFD_CFFDCSTS_CFBRS		BIT(1)
 #define RCANFD_CFFDCSTS_CFESI		BIT(0)
 
-/* This controller supports either Classical CAN only mode(Except RZ/G3S) or
- * CAN FD only mode. These modes are supported in two separate set of register
- * maps & names. However, some of the register offsets are common for both
- * modes. Those offsets are listed below as Common registers.
+/* This controller supports either Classical CAN only mode(Except RZ/G3{L,S})
+ * or CAN FD only mode. These modes are supported in two separate set of
+ * register maps & names. However, some of the register offsets are common for
+ * both modes. Those offsets are listed below as Common registers.
  *
  * The CAN FD only mode specific registers & Classical CAN only mode specific
  * registers are listed separately. Their register names starts with
@@ -681,6 +681,26 @@ static const struct rcar_canfd_hw_info r9a08g045_hw_info = {
 	.fixed_canfd = 1,
 };
 
+static const struct rcar_canfd_hw_info r9a08g046_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
+	.regs = &rcar_gen4_regs,
+	.sh = &rcar_gen4_shift_data,
+	.rnc_field_width = 16,
+	.max_aflpn = 15,
+	.max_cftml = 31,
+	.max_channels = 3,
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
@@ -2404,6 +2424,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
 	{ .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },
+	{ .compatible = "renesas,r9a08g046-canfd", .data = &r9a08g046_hw_info },
 	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
 	{ .compatible = "renesas,r9a09g077-canfd", .data = &r9a09g077_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },

-- 
2.43.0

