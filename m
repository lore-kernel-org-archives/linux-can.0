Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011013.outbound.protection.outlook.com [40.107.74.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE49411FA1;
	Fri, 25 Sep 2026 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324542; cv=fail; b=bksgdaEwhcE06g1YCWxRFXSRoh6hLxoWjUDvQlv21QBbtcOKJWqzo/q0s1IJrMxBYOEJmfoHLlkDaIuCkdn27qEJOqV+S2byW2KrT8etaXzyko9NAd88MHOVKNlLsiiHHJhH07t9l2XxJFc4KL4SAuEDWfAYZqXQIkI783rbnIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324542; c=relaxed/simple;
	bh=Pge3gXK5Tcqz0vW0a7cQhbE99Q6FayqZ1FaltN43mqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOlwBS80IRkFS1B/rgUeOzhghA9EmxbQLbvxqu2n9JfDbx1hHo/VqdlJjr8IeVqDZCA6PpOl7NGpn4zuyIXlIefWABXB4KQbu7MCBObkZdnj605IfNfBMILE8+eNEXFizJmTde8FpNzlHXVdxNYs0+/GcS/uJPvTK82As4rd1AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ZO9e02RS; arc=fail smtp.client-ip=40.107.74.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ZO9e02RS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI39EPZJkc/yDqOOxAIgq7avDFwckCd7GhK7di0lcrExGlOaYgFTH1ZMmJyrfBgljZ10U3COROOcnsBIvReVgmoOjzkJkbCl/r/vhCYXy2XK+iXeKOlq/rckVEPiK65cNUJTbF/gNX7jfXLqUbTF8WaRFEdxZsNxh82qiUBqMwCkqH2SQ180p6XYHh0RsKgNnxYvR85ZXhtip18b/DzKQP7XL7JEkPU4jpJMbWVDmDLL3e/3FdAImZTS9Q3J0vsdH9nGBocoAam7CvR2x/nnMLyT7Z6bLs+jwOq5u1EUpodh0PFmUJNb1jyoD5CyPP+hYiO6wNd6drAHVEDKF9xSfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/v0rmzujasX+ernplT+Ewkgbvss81xMJzdZUxVmFHNU=;
 b=FKGLC72beApfQolEnkSRx3rhKKaZDaATV0uuziZHKwpywsy5M946dVzBm2Y8MWECykyZxRizLnIOF7EhEJVUhQE9eAvuo8u5H3q0vFBqcybNg4J8+BVxeCIsT5TiMqeK8Hzqrcw1eq/EJGauQnEfFBitpHP/liUIWZkH6wrNQAAwM7WKUg04PUHEsFkb/TsB9EhfuhZr3uF5GzMxCyPaZkS/SNr9Mm5FmZR4jVjH8JpPLpW+IGaXgkyRYH7SiX/BNmsjY6pMvSu5lfENk9yNoCDrNaglz62tZUPvBhVTA+BfpGdTrHlOcYPUO0BhairMik8PxISTT3VfX4so7ibUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v0rmzujasX+ernplT+Ewkgbvss81xMJzdZUxVmFHNU=;
 b=ZO9e02RSrwDHejfUiTGW4sEfC4HcxXUX/ixOatqzhhBh7IpSlR/UE6FlJ1vhRopwUTLjIOgjkdu2NGTbougjLGjxfabRNfq60RpFsy5G11DoqAeTnzWozmESkRVFPKUAwhe76fGxJD0mJFhW5T6SL7c5WWpr8rU39RbTaWPI7TQ=
Received: from TYCP286CA0337.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:38e::15)
 by OS7PR01MB14894.jpnprd01.prod.outlook.com (2603:1096:604:399::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 08:22:09 +0000
Received: from TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e:cafe::38) by TYCP286CA0337.outlook.office365.com
 (2603:1096:400:38e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 08:22:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005623.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 08:22:09 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.93.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 5B967300021F;
	Fri, 25 Sep 2026 17:22:01 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
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
Subject: [PATCH v3 3/3] can: rcar_canfd: Add support for Renesas RZ/G3L
Date: Fri, 25 Sep 2026 09:21:30 +0100
Message-ID: <20260925082134.146015-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925082134.146015-1-biju.das.jz@bp.renesas.com>
References: <20260925082134.146015-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005623:EE_|OS7PR01MB14894:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fc2cbe0b-3a61-4689-ab1f-08df1ade17bc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kSK9Redb2II+v6nQxs+QQpI/PYpZ/DcP1H2iUzk69nGLfaRmekludQQCVpC5qYMpHb/cHdYY8RjrpgJwdb2mCcHftAg51io7ly/qTXvSgsccroOnXHReCGd8ZXMDE0J7vk/G4sx+qzSTeH1TweolM8uX27XV2ZnHX9dUhwJL/uk6aalXXjVdshx2wWu5m5TP1qx9ixVIvcga9dbMlXOcxNXAKDQ4Zw13AX6ajkmZjwVcTCwFjTLo4qs7Qx82yE4N7geoKuM6o0WA8EdLRZLaTrlmrZUseMkvqmLOkiwGGpRt8tK49Wxvf8MacHkrq3pvHzIH4XvXN88rijapM1NoDnAb7ydzNxovRXUUfSa3qiW+OoELdXYtKmgtxMUGm590snMk4Y9P8plVCBzH98rTTqqoLEu2neNhSrobsizyTP/gz16YUeZtyy1PothfcgUxKe+VxPHjsjvHE0xvT/zFMheMPxMwslF21+EA2fsoAnVVKd7ClqwewL3vYsmQOLiW4SO7mqXq5QJvyHSua01TV968WnOpFZso96UjYhQPqVXSIp+oJrtKY8w3wMOPiuLOk0guX6Njp5yWvAGgR//cVvkiCK6LilAEevwaaGrUvBtyZGvkiqyPuCcqfGSeNlKtNFe2RWT4D5Cj/xxIl4YlDl+YIXHWb0/kvk/mHRXdKlHNm3OFcZJuoA2yTlL8TRGViYnm6UJwkKX4Rx6Rtj7FxQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nspj75H2iBi2SZ+z5f8wQJuEGNynrJG4D3a2Hr4/BEH82k+gQ4wFKvoeAaQtXwvCc4hrYtv7AwKOYzMtPuYHerqhfxsY+1foMzA2AFfp9lyNVqFPcjL+PjiASlqk4v8B8Pqql8cQtu47abtt7LXlBQt2pFGTLecuTPAy3VmkJdqbLao3JR6CsG18Dc/lz7dFi7I0VrIEuCU0ubl7Ur7gIHPYgzvJeYeRJULuIGWkV60aGLJkaemAUOv6kGM8HOtC/zZ2/u+hmNVFYMArpOzK9SNza7Df7OmFqPwMF81uyNlJcnhnipXF2kbJMTeP04+eVZA5t0806VP1IwI1eO4ga40J2BfdWace5SCmcuVFTXruQ5ebFVZdfIquiMZaItGQe5HAvB2fuyAsinLiQY5Mr5UuZzOdnbGOafqL4RR28eoik1x2oQ+J4rjI1lyaZjRG
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 08:22:09.2705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2cbe0b-3a61-4689-ab1f-08df1ade17bc
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14894

Add support for Renesas RZ/G3L CANFD IP. RZ/G3L has 3 channels and
11 interrupts, compared 2 channels and 8 interrupts on RZ/G3S.
RZ/G3L has 288 buffers compared to 192 buffers on RZ/G3S.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Fixed the typo 198->192 buffers in commit description.
 * Collected the tag.
v1->v2:
 * Updated commit description
 * Dropped RZ/G3S fallback
---
 drivers/net/can/rcar/rcar_canfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 41c395118949..c64387967368 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2403,6 +2403,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
 	{ .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },
+	{ .compatible = "renesas,r9a08g046-canfd", .data = &r9a08g045_hw_info },
 	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
 	{ .compatible = "renesas,r9a09g077-canfd", .data = &r9a09g077_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
-- 
2.43.0

