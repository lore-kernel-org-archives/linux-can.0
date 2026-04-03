Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C939DBED
	for <linux-can@vger.kernel.org>; Fri,  3 Apr 2026 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209821; cv=none; b=u7MJAPY2wCSHDtQ2EPXk27PHMoO4I00dyulYK0Y/m6VgBh2RDFpSNiHpKxa0oNQm3d8StOFPpLsrgWgjyt27N3TgSIwK3mrH0BjYd6sn5lmaQwOhAG26oWqjO7cN75VMP5pqm6daTjNEb0mF6lLBag1J58vQebq7whN02JIWn1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209821; c=relaxed/simple;
	bh=wBHTUA9/Q9wUcSwmgIxuQFvTHWzjq8YLywECfpWPKo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahbi6uVwaP8SUop+XkoqYN4DZrNIRGgRZVE2PFWWW4uC1GlrlKGkRJBzn6ITJySNKPFPUt+awoSQRKlzJtpsGSzuZvhskkCkuWMbWHnvIIhNRJKv6LrxodmJU3vvw7ha/VJN9jIJGSWLYC+8bVun9dPps3ucD1Dt6VUXeuKhP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYxKyvUU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYxKyvUU"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso23814065e9.1
        for <linux-can@vger.kernel.org>; Fri, 03 Apr 2026 02:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775209810; x=1775814610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENtFbNBqdLLLzbNzxsoOSr+1U0jkqzi5wmYuAW8qLKM=;
        b=MYxKyvUUbrqUIDCvWaTRkI2DxM/WBDHInVLHPzqdGwI+1lNRSfWcTjTQUYdKuVYDms
         s19WKB9pGZifP9jiyfBm94pvi3aWWtp+P3/l1tHyqzdkuwrSDJPd9/OlnunUY9FWY7PH
         L2uCBkNbFThefG7hbIh4q0xVAkIKhzGXCZ/GIBab9uz6LvmX/zlbFdZ/8j43TPdCTY6p
         cA8xVtH9uB4LSUy11//gP7RsHlcu/HNT3Kwo+6BW1UjoRxZuS/9fPwHlnN8NsRFeJ/KL
         k3hDnOs9chuxSHGObZyEZB1+cNZvWJ6etM+nz4bKpZqQKHZW5DbsxgqSYF0mc6Bz5ygl
         Yf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209810; x=1775814610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENtFbNBqdLLLzbNzxsoOSr+1U0jkqzi5wmYuAW8qLKM=;
        b=God5cP79n2A7SRYgmzA416GZaldyUR4JuIcXL6O1MnSiX2RaKXoo1PL7OuUP+Uh7fX
         qR/z81KCFXPQGIjs6cYg6edwjKLIbFtbyHlCHyUHlBVgAfR+Zw3CNPQl2ibj2zjijPdk
         lZpXb3KdSpX6zMXKAbx7/oQ4CgVvfwYYKbmepAFF8F3cZ+aFGmXdM4+lMfpb86vM7H6/
         k6yfPOe1/y4XlGB74hj07mHxHYYLJ7gsKbweyMdJtcNucVKhvp6g3GNv3Z7HEVeV99Xu
         DSo+4/zLq+OfVufxV6+o1FcUbH+c79W8L5PtA4rnR+HSVxbYe8SMygvjocyoLmT92rBR
         xdbA==
X-Forwarded-Encrypted: i=1; AJvYcCWraykqiQjRbbSLnJmKcC4Dr/ILArzdD6TBTOEDJlAoy7Kh6xPTbaWoK5zJh5MlYeL8NjVYoPeQI1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGngJRkn4GPHF5JFmlNs0We8kqje9tGNagQVbZCv48CCKgkkg4
	CaDj06DJt7Gz7KVAeKJNoNBrb/cI2zec3tbVAt6OMAk3ud/QhXvHH+YvkLapkQ==
X-Gm-Gg: ATEYQzwgTo8kHZYxleuTsOIsjpER9pV3mSLGB2KkyWzgg6Z9Vi2/KFGDbrzBqLzrcfC
	cjpm2sFLIcaWm/GUUV033rzmQD7tvtBL96KR3OiEeH12efuw9TuZvmrCsoaqo+rW5tCjYc8pAx9
	pg6y6UB3yqR6JiFLjiKUn4V79fsvz/4kbO9fuD/BE1mgDB9jFu6CWPrz0K6hlso+Kk6GZqrh+Zl
	JZkWRKytRhw1d/14ff2E4XaSleR5Crpk1Pknk7HSNovr7U/PtzXRG5fsKUvAm08Qtyr89BomWie
	Zy5p87vIk8b8p8Q2FdtBn+6i5eZsJ+g3AVuzE+99qPEu3/l02DEvdpsRYqcozmvpalr88QUYZnq
	IrMObAjBW7EbY4b0TM92BrOI6e2YZ532UnDT+iGW5xlasomPu8TCl/oDpfthWWWC3HWf78tTkPd
	UCflElDDCIvJ6wTg8FtM/rQXXWby3xoCPhRFp4rkr6XwqsuR/u
X-Received: by 2002:a05:600c:5292:b0:488:8c89:cfaa with SMTP id 5b1f17b1804b1-488996b021fmr40270225e9.3.1775209810200;
        Fri, 03 Apr 2026 02:50:10 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:58b8:b4b6:c8e1:8690])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fc89c0sm25965355e9.1.2026.04.03.02.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:50:09 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 2/3] can: rcar_canfd: Add support for Bus-Off recovery mode selection
Date: Fri,  3 Apr 2026 10:49:59 +0100
Message-ID: <20260403095003.104542-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403095003.104542-1-biju.das.jz@bp.renesas.com>
References: <20260403095003.104542-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The CAN-FD IP supports the below Bus-Off recovery modes:
1) ISO11898-1 compliant
2) Entry to Channel Halt mode automatically at bus-off entry
3) Entry to Channel Halt mode automatically at bus-off end
4) Entry to Channel Halt mode (in bus-off state) by program request

Add support for Bus-Off recovery mode selection via the
renesas,bus-off-recovery-mode device tree property. If the property is
absent, it defaults to RCANFD_CCTR_BOM_BENTRY (entry to Channel Halt mode
automatically at bus-off entry) for backward compatibility.

Replace the individual BOM (Bus-Off Recovery Mode) bit definitions with a
single GENMASK-based macro RCANFD_CCTR_BOM and use FIELD_PREP to set the
BOM field in the channel control register.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index eaf8cac78038..1d6d667b8816 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -114,10 +114,7 @@
 /* RSCFDnCFDCmCTR / RSCFDnCmCTR */
 #define RCANFD_CCTR_CTME		BIT(24)
 #define RCANFD_CCTR_ERRD		BIT(23)
-#define RCANFD_CCTR_BOM_MASK		(0x3 << 21)
-#define RCANFD_CCTR_BOM_ISO		(0x0 << 21)
-#define RCANFD_CCTR_BOM_BENTRY		(0x1 << 21)
-#define RCANFD_CCTR_BOM_BEND		(0x2 << 21)
+#define RCANFD_CCTR_BOM			GENMASK(22, 21)
 #define RCANFD_CCTR_TDCVFIE		BIT(19)
 #define RCANFD_CCTR_SOCOIE		BIT(18)
 #define RCANFD_CCTR_EOCOIE		BIT(17)
@@ -135,6 +132,7 @@
 #define RCANFD_CCTR_CHDMC_COPM		(0x0)
 #define RCANFD_CCTR_CHDMC_CRESET	(0x1)
 #define RCANFD_CCTR_CHDMC_CHLT		(0x2)
+#define RCANFD_CCTR_BOM_BENTRY		(1)
 
 /* RSCFDnCFDCmSTS / RSCFDnCmSTS */
 #define RCANFD_CSTS_COMSTS		BIT(7)
@@ -470,6 +468,7 @@ struct rcar_canfd_global {
 	struct clk *can_clk;		/* fCAN clock */
 	struct clk *clk_ram;		/* Clock RAM */
 	unsigned long channels_mask;	/* Enabled channels mask */
+	u32 bom;			/* Bus-Off recovery mode */
 	bool extclk;			/* CANFD or Ext clock */
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
 	bool fd_only_mode;		/* FD-Only mode for CAN-FD */
@@ -891,8 +890,7 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
 		rcar_canfd_set_bit(gpriv->base, RCANFD_CCTR(ch),
 				   RCANFD_CCTR_ERRD);
 		rcar_canfd_update_bit(gpriv->base, RCANFD_CCTR(ch),
-				      RCANFD_CCTR_BOM_MASK,
-				      RCANFD_CCTR_BOM_BENTRY);
+				      RCANFD_CCTR_BOM, gpriv->bom);
 	}
 }
 
@@ -2110,6 +2108,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
 	u32 ch, fcan_freq;
+	u32 prop;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2169,6 +2168,11 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	if (of_property_read_bool(dev->of_node, "renesas,fd-only"))
 		gpriv->fd_only_mode = true; /* FD-Only mode for CAN-FD */
 
+	if (of_property_read_u32(dev->of_node, "renesas,bus-off-recovery-mode", &prop) < 0)
+		prop = RCANFD_CCTR_BOM_BENTRY; /* default */
+
+	gpriv->bom = FIELD_PREP(RCANFD_CCTR_BOM, prop);
+
 	gpriv->rstc1 = devm_reset_control_get_optional_exclusive(dev, "rstp_n");
 	if (IS_ERR(gpriv->rstc1))
 		return dev_err_probe(dev, PTR_ERR(gpriv->rstc1),
-- 
2.43.0

