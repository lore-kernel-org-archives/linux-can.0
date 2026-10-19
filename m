Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC364E9C2F
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411358; cv=none; b=lNJlaxnIBgXCg52sp/8663T1RrTIbHbUuNMgtzyJSrA7bINdav3grnGRmj1bBx/yOrCbzayzcuyBzXViu7vYV3Xrs9A/hyrEauVXExMbmEN4CebysoArfwCVPiX95fJ8btgJ6392Q5BdsWbZnu8s+viH8Xshokf2TN5bn1sYNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411358; c=relaxed/simple;
	bh=uQVh0hH9LOiQFkWJAC47ZRmPalYF0Gm3+xtXrFHsiRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cffR13tMRtepJ/N2NGHuKlMQUIezJzSEFkIHAavdw3cBFlYWdgNGngaRXdTYEAca4/jWF/PuVpgHJoR0KpJRHU2MYIWtZ02msGThhGIoPRjnklWIhnsjbQxaYb4TboYiSemhvQ3cXyIVuwkNIduXRls2oyyMirTxEYVOmrAmYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQgwj9W8; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQgwj9W8"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a60cb94b80so21801181fa.2
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 05:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792411354; x=1793016154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+FzSQIUgeH/VfYQMyxj7ZxdUI60Nk5bXsA4TNJtqzSI=;
        b=QQgwj9W8gJjPPyM8JX98hYEUicFNI8FtzFM3y8YBgERSW3mMxL67Yd9ccDGOZSSzAV
         voHwThf2v9pGjNPyCiFKOFjj62Ik2nlvsftXxkwa3m46fSt+XAV07dOpyF9V6mgwIGQQ
         kE+zF1aFPjvahStIx6OLkwbIqgwJR3bVjlPMPKAYaQBqNX4YcDNTLZ+ZAspsq8SwukWh
         HCunsOTbYHQLqpYqZxvLwfv00XrluLYzHvMwEUTteEZv70LWIxnJMblpBCCFDt2blDjK
         uOYTuYSWrErYHjPHl3YZwPq6y7w92Gss7lO2o84DtcoXBi9P5pCR0pS2nEJdfQHB80kh
         iGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411354; x=1793016154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+FzSQIUgeH/VfYQMyxj7ZxdUI60Nk5bXsA4TNJtqzSI=;
        b=LCRJhDMWuEzwVvAAU+UmR9r+3e7YgXlLCqJP1GrvnnG6t7Q8X/G08G8mULK/GtvzF9
         ydC06iv2qzlxLawH2hCLLNZQmFbI7KSgc9KqPVG6yrJltx3taCWE2HwvqUTfFrTY5Eir
         ay9y0iC0p8sKCGxc76qNgZpG+vRkbFrvuz3moMo9S2Y7hHXUJj3Os2tgOWQ+KXlgqHOg
         lxge4vvLnZGYWpHeWfxY3P1XCYSheXnGIJiJB2HYDu3lZvZUtrQGdau3NFB43x8+NZv/
         A6XV8We6ecmxXerPmgPdmv1CYxEK6EhIRCRrhy6lsmSUNQvGcbFMNqDto1yvaXQ9ooME
         RAUg==
X-Forwarded-Encrypted: i=1; AKwUvBwK23lE1/x8/XOOGdvUkN6vqAc1q6ktzmoMw4U/FXGPM2NuhyM22F3t5QUlUntmCXXyi0m8howjcUw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuNc3hreFpUnPK9h4Mr5Rln9AB6LZTIAFsE2/gbC+V9RuRPuvg
	ZRQCqaX1mvzAwt24q28rX5iKg+OlVVLkG5QmZ+Ya98ctXYDreHX83sg1
X-Gm-Gg: AYBFou1kLqJH9AnsZFi/wCxRurj3pnx0JLaVfKlEaqaUla/1JaS3hhYrBoHtRcJfcaZ
	40VGXMiMFSolgCzwOmdFiBf7Bxgguipoc0166WL8sQbZKshHNwMZKraGoxE51M7L0R2Vj5sO4Zb
	0Kc45F/dwTp5nECfpdSixfKBoVdKUEjuu89Y/y5UjGZEyi8KYJOQntouFYi+kuJG/HR8UBKeZ7P
	yAEJb0qc7n4JHn0JGjzYKwpkAogGOM1uhBxMCgX5E+MGnI9FlRkTTVIRvu6U2dznfHOjcI9fbLb
	iJzJkzjkkOnPmppeM8zZIRqJWfKXg7trLeX/N0epmf0XMM6RtAUsXgnzHszhAVYzRsnwUAbsrnm
	g0FdnNg32Y3dmeJwkUmNHMGEcfuaLBIT7RMWIHOZM4/XH62fd41wTed0c2OAYFIKKaPAZ/39sGf
	UazXcxfCk38IBxF1pifWjGzXUS/SCa6xwa5skOnHVUAxdjsbRNb0yFejJNwaZv9IP+WSmkQiTIA
	39TL71+Fb4VCB64QocwIK8U7NGsL6U/ezTH5Jz6gGtWTmc1v0TbPX4=
X-Received: by 2002:a05:6512:68e:b0:5bc:b659:2d94 with SMTP id 2adb3069b0e04-5be50a9ac85mr2378131e87.54.1792411353642;
        Mon, 19 Oct 2026 05:02:33 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:1439:c865:be43:6676])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfdc4eecasm22400720f8f.13.2026.10.19.05.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:02:33 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Tu Nguyen <tu.nguyen.xg@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v5 4/4] can: rcar_canfd: Add support for Renesas RZ/G3L
Date: Mon, 19 Oct 2026 13:02:16 +0100
Message-ID: <20261019120220.166163-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>
References: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for Renesas RZ/G3L CANFD IP. RZ/G3L has 3 channels and
11 interrupts, compared 2 channels and 8 interrupts on RZ/G3S.
RZ/G3L has 288 buffers compared to 192 buffers on RZ/G3S.

Like RZ/G3S, the controller supports only CAN-FD mode and update
the comments to note that Classical CAN mode is not available on
RZ/G3L either.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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

