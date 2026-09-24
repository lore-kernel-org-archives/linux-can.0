Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010031.outbound.protection.outlook.com [52.101.228.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ECF3BCD3F;
	Thu, 24 Sep 2026 05:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790227711; cv=fail; b=VBwMcRL3RjYOzQAVyINKYKvsSMdBNlG/kMOW8M2yigXZLHL6N8uf3ix0XdoxRrblRgbhSYFnmW9LDBBUtCxAq/shLg9SiAahabGDDSh6xQFroeOUmqBQC0UqGFcPLOOTpgEOAxgJA7WigjMBWrOLKpKehro7JR2u8hui3vvx/Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790227711; c=relaxed/simple;
	bh=AHNiZnt2V6uL/NavRXJ6ThbKuhtQ2T88riJoV4IKVS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/h9Gb6PziAuVeFFxBgYTWb/5xlTyukfNRSKAWD7Vs8E3ai2iUwmI82/vAjeM0G4B4jf6+V01QW/rNrCtgEusul6RbAGvTT1qaC3CS3FOVYnDfVLOkRlK+7RiLhsSUbnXMijMRUhTsjdjD1PyZJJTqPJxcjzqsQTbszlSRJ8g4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=UYrjNw9O; arc=fail smtp.client-ip=52.101.228.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="UYrjNw9O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBgkLuNtfzaKSEmDh2+iGkLpF/Hf4+II62/UGZboZFMm6IsDzWXY2CEt+khynL3LTgqWGv+W+CUqwc4SdnBo3RY2oMs1MZxP5rCp+uhZDIiCIdXhwTxyHwZnCB8zghrUPJrinfe7b9EycN1ym4F+kbKYpdZbQp/7ZxwYq2ZLKZeZCZ96kyiAjCMb9rOLgzSR+jfolJSdhlBkQKkWxSU917lVh856JUkPX/Fi5WP4Q4H+sb4Y1+qwg7m/DUbwscRFXFa6SthGC8po2izadljMJR7VEclsWsGOOan5GZmiP/7iGksMKLEmtlBzIhizjJD76gjkNqWhKmYtfz4lxmvUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jhS0PC3ZPPmo/iXe2j9awDg4G9F6zeOQy8FILu/0NI=;
 b=lQJt3APda2qhSpXKXwQ4jiXyTCiPKdqYeqXmZJReQUfnqNdWxSFznFtT4bvBxEHWeLcxv08jR6vDrkLD7nYJc8CtnG2mOxQDdkbPJSlg2Rb5NrcgW9Fde0Xy1tH5V50FoOl/Wud8JRYpKC76laOzyNeZGIYX9LOvOmMJY+JgjhogYLbWut7f7x4xQW/2rO/+pceZO58rcW9VljZ7FM7mi3M2VNnPfs/l8lbIREWitBj7Vm4nG0PZ1vrxejGX5hjveRpc7vpg/Nh4qrYUVT18PEpvT/sAdAh4Ql55rd+wzzQlhezb8Hltd2dx+DOB9lNe9hfXORR0W3bWHG4tNPVxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jhS0PC3ZPPmo/iXe2j9awDg4G9F6zeOQy8FILu/0NI=;
 b=UYrjNw9O+kRJXSiknzWBD+hIyO9nh2aMo5pxSv0VfZtJv8U56EPY5/Td1YLAprOII1t4AOJm3v90scZWQdJnqUZSZ7kK8p9vNKTw2rYeqSoHvgPxlNkFpqOpHohIhOF+kHOfupL++pFiCJsVwmzJ0290zHVZTl1ObtRM6/xtze0=
Received: from TY4P286CA0046.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:36e::13)
 by OS9PR01MB17980.jpnprd01.prod.outlook.com (2603:1096:604:474::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 05:28:26 +0000
Received: from TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e:cafe::a) by TY4P286CA0046.outlook.office365.com
 (2603:1096:405:36e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 05:28:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD8.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 24 Sep 2026 05:28:26 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.63])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 87DA83000256;
	Thu, 24 Sep 2026 14:28:18 +0900 (JST)
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
Subject: [PATCH v2 3/3] can: rcar_canfd: Add support for Renesas RZ/G3L
Date: Thu, 24 Sep 2026 06:27:35 +0100
Message-ID: <20260924052741.130658-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924052741.130658-1-biju.das.jz@bp.renesas.com>
References: <20260924052741.130658-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD8:EE_|OS9PR01MB17980:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bec82f57-0d2b-42ba-24de-08df19fca8a5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rofQ9dDJqyYonkogb9GwSbNri5ZXJrr5vvnTHVUmLpwI6fTIxmtjkqfVG830VfmTLtUJfH8Gj4g44rQgUnYRAYNsseCeXlIImj+nIsO+0XRKI1T5IrTCkJveZOWHB7Ht10uqIIWvxPcfrNdtw+Basr7RXROTeicc7askqwi0tlvFvMoTfXXRjsgxfYwLtYw7uSH5tWP18Uo2bN7iykW+ublrIphqH8zEXQ9jTf1/rHKHct4StYOL6fpPyX85fZN/YrhSnSnZ0aSSPeyA5FP9Sk/3gvrNcJRSpO9CuP7vqVRxy+SA+M6mvgHTUh7+TFYp+cYpRfp2aouyevF9V0hjgJe7ZLBgsiBqvJ4oU0dFrmNxC+xq8tWnhrsChapaAJ4S3qelLoS4LCGrUpIlZTJskC1Ws+toc1DSkOUpgLJ5vbFmfFrcPnmMgIw7PG+SB2Vgjcf9YAFwPlpWEERcy/oCsTHdFFhdBLrUvSILkrzytBiZmqvQqE0VOk5zlZK74Nn7+ipqKfFs3xMpZjU2sRPvog4NRQK/KKapqdAsef0SssfFeQuey4O1sP/u9W1UZE3MoZt2DRK9UgL8Cy2TaPwEUuhzEStCadj6FAYZl8TD6yAyeCGO5djnxoTJ8YmwT9eC0PSU/EJzgmnG++gZ6evd+Py2dy5yEx8NxQXQdFdfpe6XE/fMKkXBKKB0bukM+GWu
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9MFX5DsCGvh/mXkPYU1FuvKcp4jyz335clx76egjF3HBbPySMWhB2o3CoFSgoYBnALGwm9PQEZtcbLLQFGYv9zqXEiPUuYDUdrTysoObSWTYfR/fXB7JdbJH7nQQCq0gDA0mqpMUlK7xubzTBR04oGYjtusoG72hc1MlBHsbFRKOI0OwSi9D8ymzXaaeMT2pLMdP1wrJ6WNp1Yo373tg6lxBXHWzfxJPekzjy1YlovLPOATfyfmwlOgNzSxzgIiHKHp7ZS2OHEmHEk3z52/48RAJfIcFwLh29S2JxuYSMHKveMvyRqOkCcgQPvefjKujfN/j6Sal6B+ToR59OxASDCt4IXqHdnFsNLNe2++EdAUNert9uW2mPa/mCV7f32vw/vh4ToMcfCLngN6xrzaynoS0kBrohd6y4mlvuoAGi3HgPMev8DuoSrub5C5e5PmS
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 05:28:26.1253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec82f57-0d2b-42ba-24de-08df19fca8a5
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17980

Add support for Renesas RZ/G3L CANFD IP. RZ/G3L has 3 channels and
11 interrupts, compared 2 channels and 8 interrupts on RZ/G3S.
RZ/G3L has 288 buffers compared to 198 buffers on RZ/G3S.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit description
 * Dropped RZ/G3S fallback
---
 drivers/net/can/rcar/rcar_canfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 721099cb113b..0e30134b2edf 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2401,6 +2401,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
 	{ .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },
+	{ .compatible = "renesas,r9a08g046-canfd", .data = &r9a08g045_hw_info },
 	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
 	{ .compatible = "renesas,r9a09g077-canfd", .data = &r9a09g077_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
-- 
2.43.0

