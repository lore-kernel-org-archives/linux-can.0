Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010035.outbound.protection.outlook.com [52.101.228.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE67495ACA;
	Thu,  1 Oct 2026 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841480; cv=fail; b=Fx5mBixNQLqxda2ESIXMywvLjtUauVz4BKICxH/dJnqEG08Q48euYOlXd7XpGKrJfzNHZDKd6OvK9ZJ86Y8oZft4uOl6l/7dJzaI5wAyndrNLePwjgr9bXgS5LUNFBWr+rJo0Alj7rn4+o/SYuF1AIEoVt4xl4A+eLEe62MxKho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841480; c=relaxed/simple;
	bh=mt4jHPhDTEST1+SXBcXWiF3IcMuiiIr/pqAxPN2IdSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LGV6zu0GS8XgDTffZV+J2GQ0WIdykDTkBXWrp7itMY2THQ5dwNqWpNdRyHlA8zkNmW5Z4BAl+WSMOh3RqEu+NPTJEuSTcmG9dz4vCcb1ZpThLZJNVVnCBN/V4FCinfp0lRmapnp0/x45K4ayy29esejNvrDd7+7VUMiDU6qbGic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=jRXpzbkx; arc=fail smtp.client-ip=52.101.228.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="jRXpzbkx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAwPswxWUaMEHDeXSp0u5tgJpsBkKzrUEQ/a0YFrlPq28LUZ+o37PaFxnNSQm9nN1W1sA5SMOv85BGyVtHu2aJrwsA1OVxmcr/SYVOAXhQxf9ACDTseX7MVZHp6DM9lZU3gvuMtTxjbFVZ1/HuOfyYyha9cMPk0F6F7B9zztTSUoUnLJWgzrDl21qYeQTV8F4jF2m6RX93OrN8ArsofNtr5S0Aad9GL8HGGVO1QPIveTD+NRyCn4d1p3/ZKuCRE4w6cTBhwEsOm2XrF+9AtbEC11IHdzVgIe5iTZq6ZVobiQxFZ2jC9udoImi1r1mof+XI5vH1DNYZiZSXBg9lNLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeQy+t+ofuMi5tEjx2bfMmBuDjovr0V3JJgFko6VQ2E=;
 b=KA6rIsLSB7CmGGJfOJ7Q3WMMhMpbTekbqewMHIe6sMosmkMKQczJTq1uwNmH9x3imBC4Ntnf+G8EmjrdWyEQIomIrMAlVVN+7xt0i8WDPqtJ6jPFFTngS3WguUvB+YJ+h5GNndnSzz+xDKfXNNTLRyV931e8E8ufWS4tUlLvnTsXUaGojCHu0KXGF9oKIT/K9LPXnEF8bU3jfMffzHm937bUtk9c2Evt7tK5vJWPAJufWjrDLLJzxfBjFkg+8FwGef0ughDipuFAC1Lhgp3gZB/5TCkrpbG/Yb863tMNxn9guC269VsCRyAJhhfOac7QaLXO/OPSlL2s2XG9IWk9vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeQy+t+ofuMi5tEjx2bfMmBuDjovr0V3JJgFko6VQ2E=;
 b=jRXpzbkxIG7apn9T6k9vXCGNSYfR5r8+HG2sTEGwb7gVKcY9yL21tRTK9P/FNvLFztip2mqccii9m+B/l9FXTmuW/6gYkVS9JHvikD/SBa+ZdMEoaw449XImKe3teMzIplM7AmMn2lcRy/UAg0P4bGpETysLPLPflXrx4aOP/EY=
Received: from TY4P286CA0044.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:36e::15)
 by TY6PR01MB17916.jpnprd01.prod.outlook.com (2603:1096:405:349::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 07:57:54 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e:cafe::54) by TY4P286CA0044.outlook.office365.com
 (2603:1096:405:36e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 07:57:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Thu, 1 Oct 2026 07:57:54 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.93.25])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 7064C3000253;
	Thu,  1 Oct 2026 16:57:50 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 0/3] Add support for Renesas RZ/G3L CANFD
Date: Thu,  1 Oct 2026 08:57:36 +0100
Message-ID: <20261001075742.21961-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|TY6PR01MB17916:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 490177f7-1166-4ac3-6a98-08df1f91b32d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|7416014|23010399003|13003099007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZKucPzj1qeKgTek93Ohx0k42zPE3Cj61f1rO+O5m9JOj84DT4BW6QG8/MRSaUnDxb6bN2bx4wKcoVpxexSzLEqdJvRRPRxAgdD/yd6TO5vPlHlSoN/gUjO+sv/EoX84yQRE9yW1gLGwPeW+ChIiNpW2d8srnQwv2uMi/mCSGyLpoJBAO3Fbdjw3C2kvTaEKwdfbu8yAe2/43+2cORA+ODuRs3nPZJ9kMBukoNP0uJ+ec7vIhCfHYtfbs/u2Pvmg3rsLjm0SBM/LGyQlo43+bqWEYXvarXy0GA9VmTt+W0rfSUjm/n19QajhY6Zuq0etiTlkT/N3T/I7rFCH+WIvUD515mSOAqWor37nDZ8xMi7u6ks/AAykKWS8tzq+7x2EnS5Ju8fAy2vXN8a+fUU9gH80X+3FjLJiqaFgblAK/4n0AenOZbc7deZqNOqikpM8VH1O+GpAoMoUiiSu3PZCVUAFbbRJ714DQKo+nDtB8yPsYuY+w6/eQjg9W8ECdGVUumHftYfotmyRloSsaEE3wfB//CNK0Gig6d3uvviX0NaRFZ6FkdPziKzPTGsg0RaSklWiEpa9ERleKl/1oYCZc8U1pxTpcK2wRiaPRS26qKKqfd5HlYjAMD+N+c6BxGO21tQMB/y+b3zg/Vr9B3IRicvBEz7cCYuDctD70Ffk4IX0=
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(7416014)(23010399003)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	173+uxy7LnTLKNU+94twQwHRS9WKQBCH3IjyTIMupmdVzCo/esp3/mQdIFOMUK0DS5x+iQzY8BvG1IgHp9QalO7F+nOg/1ndAgY7vOO8ocXy8kya7P2ClEKXoZPws3MH9ouK7Hq0yR5brX2p1LcfxnldFBkPqtcpT7ITSjzS+5p8kj5RWDSXFm01Duy0oqDlXqFZhM9Li+AYqY4t4HqDzoi13hjLfQP8d7LbrpwpGvwIBpqzC5TuWg0l9maj9zgPFl9RK4wBTQ8A2msEiNJoCQQcIwoKKrztnRkEYLJ/VmVIxZ4M5aLaVjdRsOLv0FXeTuS91uFvu9CbYEBf4m8rfWbH0KLkeFgEup0Xu+X1oxnfIJEwNfaQ09iLBCCAOGy/HQZdIN10YGdCXipHQzcU5mRtQZd8VnEubCphldNT6wYlSc+nPCBODVvqqxgMK6LA
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:57:54.6222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490177f7-1166-4ac3-6a98-08df1f91b32d
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6PR01MB17916

Add support for Renesas RZ/G3L CANFD.
The RZ/G3L CANFD IP has 3 channels and 11 interrupts compared to 2 channels
and 8 interrupts that of RZ/G3S. RZ/G3L has 288 buffers compared to 192
buffers on RZ/G3S SoC.

This patch series depend upon [1]
[1] https://lore.kernel.org/all/20261001060825.53335-2-krzysztof.kozlowski@oss.qualcomm.com/T/#u

v3->v4:
 * Dropped maxItems from interrupts,interrupt-names and resets.
 * Collected tags.
v2->v3:
 * Collected tags.
 * Added check against RCANFD_NUM_CHANNELS, to avoid overrunning the
   fixed-size rcar_canfd_global.ch[] and transceivers[] arrays.
 * Fixed typo 198->192 buffers in commit description.
v1->v2:
 * Added support for deriving max_channels from the device tree.
 * Dropped clock patch as it is accepted.
 * Dropped devicetree patches, will send it later.
 * Updated commit description
 * Dropped RZ/G3S fallback as there are lot of differences.

Biju Das (3):
  dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
  can: rcar_canfd: Derive max_channels from the device tree
  can: rcar_canfd: Add support for Renesas RZ/G3L

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 24 ++++++++++-
 drivers/net/can/rcar/rcar_canfd.c             | 40 +++++++++----------
 2 files changed, 43 insertions(+), 21 deletions(-)

-- 
2.43.0

