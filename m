Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010026.outbound.protection.outlook.com [52.101.228.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48B3BCD3F;
	Thu, 24 Sep 2026 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790227693; cv=fail; b=lj0r7R350lnwZwfF2G8zj0rEutP3SU1gAnQPiVOVYna/JB1GjLr/VgDwnE+ylyj1gMBxtPv2JDYhn1NS2QLxQ/FbBV6iQjdjhLw3P42lCa5xLOv+/B3g8VWjzW/CL4VqK+Vx+Muq1JjpOHVbiYyPTNYfp213cIzb1chqahLyZyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790227693; c=relaxed/simple;
	bh=zeCJtQU4JjDnQe7gPs9c8CFYwmdfxTDthb8sSmeU9ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aF2CYbqIK3JOBgMwWUU979/W4NB54rEuHbKkMYdCpy+BkWm7ReccBYnVSC0PgBl/6R9FMuDP5nMLGXW3uNBFinL0NrVfvD4l9WRgFaZ4IFDzQQdEUGQVHRM7ybR/wc7IlZN7j/0yHStFOAMfPzwW6bvVgVr5Oqb5XFaUNROH5Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=fAsR2Rjx; arc=fail smtp.client-ip=52.101.228.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="fAsR2Rjx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+P4lkSh1tk26MVAWrI8+vHMkcie7CrfRANq6dfTL4UjoUhQXlq3IMmLgEQFXxtrku7i3dtHqIxCLH3Z+nUe0Ws/NTxfI+RnXfdjyqP32HMJ3HaPygbeuAHJYpzzwz87abMyXKp2ZeeOccXaEGomaq9hh2GXe0VSdHjPwIyyg4Ej4IXyFLCKGKXmSkVAmj/cnazu57kV9+1YaZp8VpiqOgQhzgIJio8rAU6VQFbNhazDrKK6Oq9JBo4iVxkHm0mUYwDIpDCJ/gnaPGOOtFawQQndDLR7QE5zh6WwJXh2Z6Nt7qf3uCWfE6pHnYlJ6c0RtVj1/o2sTSYIyQAN2lGDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t96QUvKBylx7pzo+f1qf07kB0tUfX+75bKVYD2+z2XE=;
 b=skGW2MY7WR81OMMag2Z1j7mCe8TmsirBSJ3AeVkj1FxZLv6BUNi4vzOfzwtt9SAG40awiVuBnyYWMlRKkla5qwzfoeyLrwJNO17G5GHVgbZ6hRXj/lxWj3FKpBAMNJ45Pg+CkdMYrxDLihTIHAt4HKgd4Wxjv3dTFz4E/xQpY2pxZOo6L2VqGiSodxaYV7oQK5vCTlp9oParm4c1l3ry7LcKPzlcsLt0LVQTwvbOfMf/B72sTpyZ02Jt1iL08Q7C/o0Mo9uhiIC+ADnkkT3n7u6F6b1ISzQZLPxmHhGlGcnqgtbVSb/yzhEcU/q+e/rh6VeL57TxObB00oFqJoeEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t96QUvKBylx7pzo+f1qf07kB0tUfX+75bKVYD2+z2XE=;
 b=fAsR2RjxrZE/2oMGbR/hmP6JCJCCY96fGsYrgbFRytO6D8cZSQfq1zpOsM6XLkRIrLPNmwKtMcRWxV7dWhXM+6CDNjt04p8c3scS0yKp6fMBYNrjslVSVD2hBp0UqeD+YJd+FJEOVlf2fUZZECp05RCCmkDnwnJJtJtylx/hZf0=
Received: from OS7PR01CA0259.jpnprd01.prod.outlook.com (2603:1096:604:255::12)
 by OSCPR01MB16258.jpnprd01.prod.outlook.com (2603:1096:604:3f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 05:28:02 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:255:cafe::3) by OS7PR01CA0259.outlook.office365.com
 (2603:1096:604:255::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Thu,
 24 Sep 2026 05:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 24 Sep 2026 05:28:02 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.63])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id AC08A3000265;
	Thu, 24 Sep 2026 14:27:54 +0900 (JST)
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
Subject: [PATCH v2 0/3] Add support for Renesas RZ/G3L CANFD
Date: Thu, 24 Sep 2026 06:27:32 +0100
Message-ID: <20260924052741.130658-1-biju.das.jz@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|OSCPR01MB16258:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 631bd1a6-07f6-4de0-8747-08df19fc9abf
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|23010399003|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	GP95gaWpYpc2hYn+N4ra63SuhnMxkSzbzs+RfmfOg7DC/YgljuGbfs71w+Di2rC0mf2fdn5Dvqwpo2Wyl1EYNLX4z2G6SK6Nj4tniN3iIKvGlAJDKgQ4SLYuLiK52X+dDeMmGZL5zIifW5Zqn+Jkb87Pm1XH37LCu26plp2jOmxH2V/ibV/OLCKTsUxhbiPQFuRgWbK8smwuEmX1T0ep/Kd/2f82urMcV3aaP9/CO3VuBFNAUqx4xMnQHu9ZLZdKq2NXxYSk0CWeu0+nmUgIRtKFnLDVxyZKlD4HDR9GxZynlEob1o41qzCA5oU5rYd6S+hgcSle/AZzz5H/4IDNWzIJ/ldDNhoHxvxu1So/A7pDGLT16X1AD7glCMalFqeWzxayMHrPxqYCivACNn+wk2B6yYKzwuN1c/DQBHTllWNJomJF+wBc7O+fa9YGF+Iapd370LgmHGTW60yJ2a4Fjfd3iYix4e2yyoXIXO/E0qon9e53cnffs4JkSliWGwB+aH3HMqI63fIW7CGAyZjZ7hrPBDiS2nk3FF8PXYWcy19mYnO+P3oPNuaWdQ/FBexztJ6NGm/IqhLTmTF0xCVxijp5nWXSZB+TZGuBd7uYZQGvGf4m5ss/Kn2hNq3lzTVooXzkdcJeByfk6KCAxpWEK5IRcZPSkmwUQNSIvRPYbBA=
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(23010399003)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	trZBNqQol7Hwj09RjxgsHctxaKOngc3Rp7VE9nU5AN55VXY9PQvc5aBFwIvpB1gQDsJR3y3zn2iGJAqf2ONtcHPuNTUlI/UeTrCZHXa8zmGmUe8RpcERseHcqu3R0VWnG3surJ5mjS/Cg1uIQnYp4PhN7Q4xNiy6DtwWIYJa+SNg32nw+6kEvqqPhixDG6qt80e9vl008Yn7jP6QR5sMWiX2DDPYFg1hNul1WIZjKxX4qpcH9pa1VHBeI3dQy5kh60/GHjzXUcE/vWp+9iWcgUrNCSlFxwIQ3J1WKVMxCUvkqeSTWJxyhXUL9sQyOxUvhR7V0noEVDTYlkeUiGyL7SBeohcSUy8tdec2iVqEaceAMyPKPdDPBNhJtHqXKLFXkH22m6HZW5LHep2EtyidoIuLQOF8+W5pxpVAVg1BxjeOB8oNkwm/DGL+eTjpcAVa
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 05:28:02.7978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 631bd1a6-07f6-4de0-8747-08df19fc9abf
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16258

Add support for Renesas RZ/G3L CANFD.
The RZ/G3L CANFD IP has 3 channels and 11 interrupts compared to 2 channels
and 8 interrupts that of RZ/G3S. RZ/G3L has 288 buffers compared to 198
buffers on RZ/G3S SoC.

This patch series depend upon [1]
[1] https://lore.kernel.org/all/20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev/

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

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 27 ++++++++++++-
 drivers/net/can/rcar/rcar_canfd.c             | 38 +++++++++----------
 2 files changed, 44 insertions(+), 21 deletions(-)

-- 
2.43.0

