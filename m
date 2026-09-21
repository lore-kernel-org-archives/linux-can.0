Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011065.outbound.protection.outlook.com [40.107.74.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4552F24E016;
	Mon, 21 Sep 2026 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996829; cv=fail; b=dKmWUoB0IVvsCFe07pBYTkS/LlN4Cs3zll3E6fmk7Bj1rweyClmXm/+AlWfQfAQaAowC8cYOOKHZ13eMw2AdJVTsmJYOL1n7cS6KVt7hFacZMgOmRY4hjzYovAiC+LvSQQroWr8WGfvA1SmCZBuKz84BkwrwHxhbzKyeTsels4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996829; c=relaxed/simple;
	bh=0ngeTXenKhSVzxaW3vhDuUxmtdM6CBXugMwbT0wSJ10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntZP94VlmcSymKZUD7GiZ9s+RIZx7AwxR6OPngDSBlg7UnhSkjhJgtPfYNs/3yzh7F/WGh1E3Sd6wDitfof+4i/xl5j6HngGkez0DbTTt7FPtdcczhIGCy24/6gzYX3f6oJCoMAoo+0KXiPKUJJ6s6Flw7QOrGXAzNMrudfd6aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=PGDSsFx9; arc=fail smtp.client-ip=40.107.74.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PGDSsFx9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nETbRAMOy2bZZQL8dnhKoTarDLOQpYj8uSaax+4SwvuYr8x+YZHEQI0oVPxPF3TtmX+yR2/DODcwoAL9uVkj6DarmEcoBJHbsDHYhTI8rEGKNt/ABakqpOMM+wyjLMc41KilfhbG4DB0x2dqG0KecTRfdh3aLoCRH3e1MPNG9FaiD4M3Vfw1zxNIVeXhbqIz26JM/chAvzAeCsr955E3zoSJ3nh8hus2Pe65FFV+/S6ZB2YECjKg0TrVCLMclF0eRs98iWeTVEYD8EkMi3k5vpZGgO5l/EbWxrQjuFi6Ig8plD0NXc4GShn6xnqLeA5w98UBMCgKIs/LQx0sAkgdfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+r3xvqQR2KWY3VqLchmFRZRuE4i82guCjdDwwFriyg=;
 b=pcatCJ1OolSXFscntypNDvXWwdcb/r8nVesqcP2CUTfEit4jqtKE8Ugxu9GZnlm93H2f2+bYyjHXmDXFCQHz3BtnlAR5PSfcU2vtt+HfBo0CdHFpP3jk/XnLMjKWV8P8GittlyisbhKhGEovLWdIm9VWj1vA0iiSrINXLnSUpxK5tf6+Mb8+qFbJuIlSMHPBcYatPSJTiQ2nX3YfaHuHLsbyxoIV1Qkpbfchz30OtCvggyripjf5USbHunRyCqB5VO5ro3NqRcLlXH0Tx1CVcJcraG/7IatnFGkcBmJkciFtEWli/YiaiuTCd8oLIDjwHxP71ImkUYlRJC0gM+rSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+r3xvqQR2KWY3VqLchmFRZRuE4i82guCjdDwwFriyg=;
 b=PGDSsFx9UzMAEkbLSQunQYE4Uk8tHiJUPxPfHAoKkqOc5b7GClHVnib0q4UjBwQvjAIbJ9SI2kGk84J+eAp7hj2cTHq/LhPsnSVkkuAyPmPYdfin8qMemlI9Efi8c9sT7IpPxT3RaRN3N10AK6UYUImEzsrwsTQqL4l6R8uedwE=
Received: from OS7PR01CA0111.jpnprd01.prod.outlook.com (2603:1096:604:258::7)
 by OS9PR01MB14003.jpnprd01.prod.outlook.com (2603:1096:604:361::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 13:20:23 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:258:cafe::4) by OS7PR01CA0111.outlook.office365.com
 (2603:1096:604:258::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 13:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Mon, 21 Sep 2026 13:20:23 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.93.82])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id CDB6C3000283;
	Mon, 21 Sep 2026 22:20:17 +0900 (JST)
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
Subject: [PATCH 3/5] can: rcar_canfd: Add support for Renesas RZ/G3L
Date: Mon, 21 Sep 2026 14:19:45 +0100
Message-ID: <20260921131951.187981-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921131951.187981-1-biju.das.jz@bp.renesas.com>
References: <20260921131951.187981-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|OS9PR01MB14003:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 54b6ad0b-38ba-4d8c-4227-08df17e31812
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|10067099003|6133799003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	0gOYwGtJDAiP/x5vdKWXoVExCQRKOav9YWphIA39Vu2qK+D/iUlPhbuC88K/hQyxb7hJ8y3ucwEcwNay+gNKyr2W+h9EKPvZI/Gq33brDIDQHI4BE26OUWfmwDeIYjDsFp95zgrgOaJBCpHU4eb1Uns1st4xADfjsNcui/r8GOZysIOkmxyyGaZShvWUyEvk7T4SKgHOrUvZRWIfZ/3PuDzaJNXwEoIuJu3YWGulwWC9rJoBtaXNBQllpZYV/Xv2bqkyK7UfED/HQAH0atEJGkfdy8VgRoGH4TM9enrqV6QwxxtBKIOPmpAqeyYZPwgN5th94gK2EAC7bprTZU2138RQEfCiR1JDX/UKnAJKUg9VOnB5LljPfK52GXs3Oi89Ts986vudJoMKRKV1jvZeJzOWcooLJHHbTaeW0iAQrLTCtYSzqFDl1PGR+11sm6Xes4W3GiTC0g0tZFWpAQAiR7KfpA1qteWqjpLHnjOY6gSCkSgW4OHTqmO1nUAEW7IVVWboaVghgtAmVXsx10C/lVn8jDmepUkCGPTFM589mnv18Oxt9EhV2lEh3idN5y7+K1OddrT6mb17umGHoqsvwnN5Qn9MAANxJLsORIRFUV4dJK7txHf8+1uQT98vN6HZMp+MPpTrBzPdIPfhebP0j9D25sXhrmoJLnaC3Y6SQ94Dtyb+5Akwf+BABVOAfOVsydc5yGKr/FXMSK5b/L2qCw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(10067099003)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pSux285Zg0Ak6apdpcz5Dun49aldX16Wm0mhSWwPn2p43xLK2yZ8jdWNHCexr5HoBNFxQH19e++ZVk8/YkmiVdAu0Sxq9Yho4vMWOHTQyzTWAfZuK5+eQ3/9KRYB+6QZJw1vAOxcH1lXU3+6nygn/v/0H+Vd/BCHTPEiptBvycmzuL2hbTudpyaXcghAszuKCLFH6O5RqIkNfGW1/IwDTJHMgMWyyjCYEroYbKc6PX+RpEfdIpP8i468MXgcbJY+xS0vMB1wM1ljePQTRUdV1/+JNjIH4/daTIjnhiSkXoJgJV9XRtUJ4xszc2LBLpldz6c5oXYMBXt+dyDZHs3XmdGTb3SLdJgmpXUJbOIRfBbMOVrhxdkwC9o75g20Cb71gdHXQ9B0+elyImSPVoU5kfMuImQQuxIWKT4bRXWCo+H6Obx2atRuH252hqWpjvts
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 13:20:23.8106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b6ad0b-38ba-4d8c-4227-08df17e31812
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14003

Add support for Renesas RZ/G3L CANFD IP by reusing the RZ/G3S
compatible. Both SoCs share the same IP block, but RZ/G3L provides
3 channels and 11 interrupts, whereas RZ/G3S provides 2 channels
and 8 interrupts. Update max_channels to 3 to cover the RZ/G3L
configuration.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 74c3c3f20991..f35c235b49a8 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -670,7 +670,7 @@ static const struct rcar_canfd_hw_info r9a08g045_hw_info = {
 	.rnc_field_width = 16,
 	.max_aflpn = 15,
 	.max_cftml = 31,
-	.max_channels = 2,
+	.max_channels = 3,
 	.postdiv = 2,
 	.shared_global_irqs = 0,
 	.multi_channel_irqs = 1,
-- 
2.43.0

