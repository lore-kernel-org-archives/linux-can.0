Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61418309EF9;
	Fri, 17 Jul 2026 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254472; cv=fail; b=O5UoajL9WKLvP2vQJ6+gx8aSR9QtJM9i5P5v1vx78pxawUzfH86+Z7420e4S0bnHlJgNv7aj/xAGwjDi4xHFDhwdiHTbGUIpL28tYdZ6SwrbYFczNqisbljayX+H37rJU7WoAbzDjw+lcZlPz6DxcSH6SlWqEKrKV90a+aSye6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254472; c=relaxed/simple;
	bh=ZVvFzjoRJ5quFftskh6lkV4OmC4uCH/LM1bFqTDhSo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmjvMGUXN9UXi59jqYpe4l6HrceM0H2Rk+RdlYjbrWH7S9+rNGYAG6pWoZrYfmXM9d042YGWTQpFIpIQqQiPKqDI8bl4AZdUJcfEuWUOLK9Xv4xJJJKxM4LFPXw1052lbBNPWdB0n9Kxka+MsBIqXPzCdFLUZHmO9aEmN9Dfj4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MvbA4JDs; arc=fail smtp.client-ip=40.107.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MvbA4JDs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWExeWtl70tswMPJyMbgDCxBfGHQU36SuFzzP+7H2X6KWM8TjJfPkpSI7A/9sKCQ1OWxxkvfKRhTK0NjPmgJNc8q6OzymUmeGilzqUu/nUSUSHY8PkRymK5E83PDqSc4ic9e+l2vtFaZv3leXD7+CddxXzqs4N5fT62a1ztmU8LE2iexAc8WIkY6DomZ5e4hQr37d5eDTa4O+ABzK/93QMZrGUg4Dgtavs61VSr6mS6/l0K6X7X6onywEGXehPM6EigttA6jGywdF7bMexm+DkB0skpXk8x1vTQnjsDtYkNRfNEqbBzpMq5x3DSxvmpWF5rs18YrSS/Jxpx5ykGR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bzmzQewjfwDu4E5gKomq/RK+aH/kjgwok5bn6RtEHo=;
 b=r1uVd5a9aXEjOdSQlSxxVg0ZkRsBOlzFIAmbwl55GMO5lk1hJB9lNYJG5SEkxWq7AiPfUwAlmOIKJ3LcX+tZSdGVTA6ignNS8380AYIGS22MUcpIuBRgcCZzDjuuyAnnmMeSlzv9S9klmkg/yQvp+4uPHDS4esVzTi2tnSMaT/7xH+iwhm8w65MUujjqJesEcf2jbpeEz1NIafhdRxx+dxuAQXHv6JLxFukBFFqw7RL/RT32cKNpNwDD9UKl6iK/DQCFrnutnuYZ1Vbe198kEuueJzCAjnqHmBezvR+aE44jAWg1v1a66NVJDJoIgV0yJVS/ITvzRfWE4xQKZezuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bzmzQewjfwDu4E5gKomq/RK+aH/kjgwok5bn6RtEHo=;
 b=MvbA4JDsOMmVdQmpqiAuHg3MCdcHkTH5TjodCvBTvPGrdz2IhBvCNgwwkkz5k2j5+YJDLSFKPe2JVRKZbDFctKgc+1h47W/j/3nalFuZh9l6DFLp98EE2M7Rl9uionRmwCq/hIS/n6q+VEGdeY1P7ZzatEYsQhbBt16izBQ6qGw=
Received: from SJ0PR05CA0034.namprd05.prod.outlook.com (2603:10b6:a03:33f::9)
 by PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 17 Jul
 2026 02:14:24 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::60) by SJ0PR05CA0034.outlook.office365.com
 (2603:10b6:a03:33f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.6 via Frontend Transport; Fri, 17
 Jul 2026 02:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 02:14:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 21:14:21 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 21:14:19 -0500
From: Harini T <harini.t@amd.com>
To: <mkl@pengutronix.de>, <mailhol@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <michal.simek@amd.com>,
	<appana.durga.kedareswara.rao@amd.com>
CC: <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] MAINTAINERS: Replace maintainer for Xilinx CAN driver
Date: Fri, 17 Jul 2026 07:44:14 +0530
Message-ID: <20260717021415.2234865-2-harini.t@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717021415.2234865-1-harini.t@amd.com>
References: <20260717021415.2234865-1-harini.t@amd.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fffaca6-6841-4a2d-c021-08dee3a91e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qK2yaNDr+sa7Hn3nbv+y9aDJj3dSBwlGusWLDZDPtjag6wK0kOBcBbUcHCqIFKC+oDx6HYBownYNvCh1lWL3Er59Xi01W74boDoage7sChmwReTD2eVe/uO4MMEsuZyXiGc+gGWS/sf1ZxJFLb3bCrhYU9YO2Vm5p7nITyvq1TiHMIW6x8qeJrhP55iELCsj7TARvik1B09L/adK+3oicTp2ohNwmgzIAUCgLGFGd61gsnsTx6xLN7aDCeS6h6xfR3OYpoAbJ0a5MPla0veHcf+ma+z8l8UvTvGk4BQaVgFOE2lWtH5c7kV834gq4fr4WX/sfxETDAaiJU5HBBFwbJf81zv2Y8x/vbrKGL7Xk59zuu2M4is9em4CZ4lhe9iVKSSSfMsAiGeXjcH488B27Kl3QBYqzLaT1eHDacXh+mskMXECSK1RZjvWFuaS+sItrf1pDNcP8xBgAAvUuXBL1qSfRgpja+/e2+VDg8X5sSiL8CrFmqnjKgYELN/gPcP1+jj5ynoOjuBgD/DvKtn89aW85B12mFOR3LgyEdEUEFKCo+FF/cI7PGLt3tpEL+A4ZpdsVtKnFp3XSZBDPWIEMJVP9kNHSqQwG5CrCQ43H4x+Dbnm2NK2kvyuYNkYlAmX3bMyBKOakBKsTk21JGxN/L4dtb/3QenuW11e3XzKWZDznXP7iC3ZPKQLNAi21axv1hGAheq8hHOMNxXaA6NqQg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L5u2WS8SV4oM/EKbVvgzXOzWYFmSFfjHtgwnoA5CHsqgTld0byCEbZmBsgxRtvt2TRfnwpdC6B7VYh7CX59p4iOqSgrCFzl5jssxunpcC3ANhlTP+uJbNdZJQAHROeOmIKdcxYHQxFc0xqym5MX3Q+iiGOZVsYjklKqo1jxNR+EjNfJhDvx6/DHZi1nlAVLLxZoyCe1/Jgn52Z8JR9/Fuj+zNJuNZun1LJHzGk0ZdaKnULxCmdZbr3AnDiYmCmN1gBfsI1mIzCEI8gxgPx1ZxM6aIX+KoCh+0tPS69dQ19VNZKc5VtbXQgYuo89THx2nb5OCweTVIuZrP2H3SYv5s1y7tyXYWfIbyBuxTy1wAjS/5K1K+qdK9YKmZP1qkpR15cL3m4xensk5PLUnLKvygHod+ac0HntEcso2CDf8OIAPqcCS2vjhuDaGm55Bo3T7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 02:14:22.7999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fffaca6-6841-4a2d-c021-08dee3a91e39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973

Replace Appana Durga Kedareswara rao with Harini T as the maintainer
of the Xilinx CAN driver. Kedar is no longer maintaining it.

Signed-off-by: Harini T <harini.t@amd.com>
---
 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 2 +-
 MAINTAINERS                                               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
index 40835497050a..e705c719f7b5 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
+++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
@@ -8,7 +8,7 @@ title:
   Xilinx CAN and CANFD controller
 
 maintainers:
-  - Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
+  - Harini T <harini.t@amd.com>
 
 properties:
   compatible:
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2ffd9d37d5..db619dcaddbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28874,7 +28874,7 @@ F:	Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
 F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
 XILINX CAN DRIVER
-M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
+M:	Harini T <harini.t@amd.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
-- 
2.34.1

