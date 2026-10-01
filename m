Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011070.outbound.protection.outlook.com [52.101.125.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF4E3EA957;
	Thu,  1 Oct 2026 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841495; cv=fail; b=lldjexxLbl4FqNEBp65fDBLExewBK/3JWA8nRfkq2xsEf9jbjfJN6s37kWse8EU2GzCLEs1A00WIGQht3xY2aXwqwQnES5llRpVp4u1aFSIJ6d2rZm4izv/vZyftUYKuo8lvJ/f+WyVO2Ol9xPrRMfgEeNW366NUFh0XP8AyvTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841495; c=relaxed/simple;
	bh=mDePCJKRrS1uLVZ5n0x05bdhwiSaUq4hbDYlMi5pgOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+61TlVVlDDViPulNYyejjKCiRqeEYhCZ5Piwt76+KlA/WCeHZhuLKN76DAPna72DvCQlj35BoCvU7QZecFWSsUaBn3JFLTDx6R/RMbmaS0iH5UkjzoaDVR/rowS1fS1a4OPuKMj54JXd3e8z+YemRmpI+Z06emMwefwUq2IHCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=IUEIRt2l; arc=fail smtp.client-ip=52.101.125.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="IUEIRt2l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLKqOTeGiAm5GVXjPCCpduvATJ1ATwn1WnqwWConf3A3HePUMWqnZ21qbUHKKKmomVEx8jYiZcnt3wwWIZJfn+J+tdKYCeUiq91+RAuirG09VL2NNQDXET+GxqQtkRDclG48tJ5H0zH0cpHycbKUyt10QO7pF79y1grg1dfF5xM6x+PBvqW+bqEjdlFiUvWHRyb69m5OALjoiOEs7DSeOE6540BGslorb+jN2mtMDg3HD8GfKF2hlqQYdgSfl/CTIPAnOln40qgNNOmgTNUw5pyOfABNz5HjsAJfm8b7SrszuheK54T6h5SJb21jGQ01S+KTwy6D2rwGv6F99/K5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JCW/mMdlUCA71khaQTLuC2TX9ZpvWmszYg/I1AHOs4=;
 b=k4lttRk5lye98bhonWBSaDQOX2qj03eGNoXzK16xgm4lsgrkkCDukr4Jsywm/V2UZACh3vpq3NyC0pZCLU9uaVi3P3CpnFm6VLwv5XzvDDLfoHRe9sMZwTopUoCK2nJW7seBAFioBaf/YqdXkUalTmswpv9ZNd5HifhYxJGJEd9Rh65GDX9uMSgYlULCFIAw8uJng7Pb3iOsHDnVU77La5A3/9Q541BK8xdLlANwhB4dm5NraL8kUSYWalGjEr+HFD34xyU9QJvO8KSs7hOMxHamfBrm7RUAX/wiYErdvS8TP5riEKUnhH/CZiHZd5P1Qh4nx06n4i+SPfshfQqSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JCW/mMdlUCA71khaQTLuC2TX9ZpvWmszYg/I1AHOs4=;
 b=IUEIRt2lb7Fsy41QuFDC/youIf3kWaWFeovEk2wt/vWG1q7sVWdIZoqOm6XVYEOYT18YwCZZ54NA9XaENPfpCeAmwscuaRJRLOeAnrNCKPdEic9CPmbodM+JW5tAyGRjc8BDwqosWUKKUuFH2+TCnhki0tozrbef0fzjVhUPqtI=
Received: from TYCP286CA0258.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:455::6)
 by TYWPR01MB10933.jpnprd01.prod.outlook.com (2603:1096:400:38f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 07:58:07 +0000
Received: from TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455:cafe::32) by TYCP286CA0258.outlook.office365.com
 (2603:1096:400:455::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 07:58:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF0000501F.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Thu, 1 Oct 2026 07:58:07 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.93.25])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 986A8300027D;
	Thu,  1 Oct 2026 16:58:03 +0900 (JST)
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
Subject: [PATCH v4 3/3] can: rcar_canfd: Add support for Renesas RZ/G3L
Date: Thu,  1 Oct 2026 08:57:39 +0100
Message-ID: <20261001075742.21961-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001075742.21961-1-biju.das.jz@bp.renesas.com>
References: <20261001075742.21961-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF0000501F:EE_|TYWPR01MB10933:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c8d17ab2-ceaf-423d-7ae8-08df1f91bab5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	W/CZs9zEAgWH6bWWakJiA8RsV6aE1WecYMCJAjMlo7iRs/hKM6SWWCavIcChsGSJ/SpADW81Av+PSo/tMJ26yv1V49xsGgvC+YM/quyv3li5cDiHtjxY1cgDmsYYKC5o5kOg3n1kepxEdYRlMiBCwlYRMht0GZDZ5B9iyrsCTTX3t8dUedpYSF2Warhi2xHO/NgUytCbQgcQnJnDnkybo6l/qdKXnIbx/7y9makm3NvbExzTVIUC+rgdvaxkPQIYffBqMioPoNMaP85ZB5XsaINi61oNm3wIRKPZOxU/lA5zxdj7Ovm5m5e0yqBkRAuMyQcyObO3uHa8NZdAGo2huC5yBjXTXF21fLsOkYIbb9viacmWaiX2ZN5zIna7O0mwV72rwFibXUrn4VXQEdWXdXxuI91r+jUxJHXt7KMEYTQUKu6O2sRXM6szGxJm9ctxc3ETMnY6JOSppIa2ufLFsN3tELkBYSNOibKUua5kGXDGoiz1e031heVgqmXNTg5k9jgPrg5VJWq+OMB31WslohaW/1s5/+S+v7uhjS7/L0kUzhLJrcR9y10LsX3V6WNB9EdDHlP9fDlRZ5hkkGAQIayKrPM5uWXQkheLB2a87bIQmnxpgI5aG1upvFv7+I1OXQzbXznPvDFU9YaPEBVZWcBCb0ttuUBAyfGcjvd7Bze+Sk9smCARUqKoWLn/mBBe
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mJiHqB9ynU1ycotwOfxZ3TsgEynloUkxwho/5ZaW1RQxeR8AY0FF84VV90bbYjEychCmDcUCPxJ59tRPK+im5lVHlRtM+5pZaD7f530Z4Pmv82tzd4VZUg41VbiuGOA8IZto/jD3seeKW4DGAn/hkV3q2V1FCq9TUnqP0xQtP+1mfnzMQOf305uyVc4aOn+ODH7DQxe6E4L3wsMM+nD8hmhZ4eOo2NYD4FQWO427yJzshJ3ltp+1p4vaG/u7S5MDhfZio2xtnnhjqfq1OVN3hOhvDg40AcUhn+aq1imzyS8hz0fWvIkcRhs7tsQaI7jIw5HO8gBdzNeSWI5NzaNOQ0K12QFhTGPf4kjtTs8ycvRjo1RbdA0pulRiyyNnnrSLqMep3/D+1myUkDcu+ufB+V7wefj+Mc8kMSSXDHTpIxoc/gGFIobXgdgkanB6dTJo
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:58:07.2573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d17ab2-ceaf-423d-7ae8-08df1f91bab5
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10933

Add support for Renesas RZ/G3L CANFD IP. RZ/G3L has 3 channels and
11 interrupts, compared 2 channels and 8 interrupts on RZ/G3S.
RZ/G3L has 288 buffers compared to 192 buffers on RZ/G3S.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Collected the tag.
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

