Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010011.outbound.protection.outlook.com [52.101.228.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D83D2F0C7E;
	Mon, 21 Sep 2026 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996810; cv=fail; b=lyVmJ7OhKKvp9F4fL5K+4Et/NCS+jFNNyXI4uvqLP8w8sYK4Vty6zmZyb//Zihcf2EAZMZls6QUgpFLLG9OiJYkXofmVFQFECKyCXcaGq2EU1QSuxluO2rjNM4VP8YLWXeu1wbZOShmcqVX2Ow9Iqe8zSOosV5Mw+aGk/Vllk5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996810; c=relaxed/simple;
	bh=Bip9zYhobFQfeWJt/05xSm6KkAEyfBjES69EqwKxjmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KpKdXz81jVGgpJIbZbMjInlXMVWizPveqC/VEHYjDPKBZI4xZgN9w7KWLRWrMKZUwZqeZOPe9240fl13I2Qtetb/coUUwU8QJ5FJbYOLnbE/z2OItQkzLZTPFmh3HyDgdIAFh7afxPaxxZHTYEW1lWhHk8s/hWZRXJABfg/HX3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=SUQXyljE; arc=fail smtp.client-ip=52.101.228.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="SUQXyljE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwBSSpv7AxqI7NVgASHE5gYpn/U188Ke5S4bsDBOf6OpXCWADFADQuDkiAxsNKIiq4Zpig7sJDF2aLkqKreO6upxDnVkihpD4lJGJlMKyYtdsZD2UmomtNpdGdxOFJQ4EWti7nBJl1mPCmaoDv4u6svmRTMwVTVWCmeGrN98ltdHjOCR4/ErjFVi6LIFCYY3s11Rv7+gW7w9hAUMarEp32ggUdolo+PMIafKf43gj/E9555oNDAxWn5PrMbfjCsmDNIpNLe2Sxm80mTrwnYlckaRTBwOKN0QfQxt+VWxro4J/vmrKQJvHpuKcJZI3aBYmcOGgCKGkHeWt+i0ypFHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BW9egZ/yUzFCcnAcsD8oscbxMw3oZ34KyB9TCMfgR6U=;
 b=Bvg8PiC7DQGzplh3kKl52XPe0mI+KEtq19WVWokLYzjKnlKcBFZNKWZYtUphRZ9Gba4K45FLrbAlw34z5XlwiR608nMQ6Sbtx7/Y+PTi+bFpxY7JK7QBTCMw7HVrnrUdaxa/5fOtFREoAAnN7UraiVWnNyDLC1vVdss+rmv8DxvYLGj3Rwgb/RbS4/U5E/lztcdqQpTiGEsKPd2PFRdWOr4sWKnw5zdkyfkxG2sj52pHt4RRuaUqWxWZuUk9A2peBRCA6Pwcjac+LPnVMQ3V7h+q3PMvdo09aIUUCG0PUIE5+uHqgqvnLoWXgfBd5h8hRbAp38RZyMoGFiRZS9apLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BW9egZ/yUzFCcnAcsD8oscbxMw3oZ34KyB9TCMfgR6U=;
 b=SUQXyljEkpdp+703MvUjVNbav1B1DAOHv9GMINn1QW8dn/ai7v3BVl0InaBCvdJu7S7dy9q80a0cP6zrtPrnibtvMtS2SylAQJ/ppn6bORpmQE41ZsspaUxnpVoUcxwSImOolAtknPZAt/U2XEWMHnGoxf4wBj3hhnr1o2RyWOA=
Received: from OS7PR01CA0213.jpnprd01.prod.outlook.com (2603:1096:604:252::14)
 by TYWPR01MB10409.jpnprd01.prod.outlook.com (2603:1096:400:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 13:20:03 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:252:cafe::54) by OS7PR01CA0213.outlook.office365.com
 (2603:1096:604:252::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 13:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Mon, 21 Sep 2026 13:20:03 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.93.82])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id C302D3000283;
	Mon, 21 Sep 2026 22:19:55 +0900 (JST)
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
Subject: [PATCH 0/5] Add support for Renesas RZ/G3L CANFD
Date: Mon, 21 Sep 2026 14:19:42 +0100
Message-ID: <20260921131951.187981-1-biju.das.jz@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|TYWPR01MB10409:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 34ae93b3-2d57-4fe3-3dd7-08df17e30bba
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|23010399003|10067099003|56012099006|6133799003|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	0hnV57q2jiEFZ9V5/Iv+76PGJFvfYXmu4+Hqy3tOQgLqUf37n7NWo3xjV/c5jf1KmZdXcyFiH9pSX0oW454L5v/NbKM8zj5vuShJL+FKPdr2flnBNEppdiCRbdhuYuWj/OFmZt8eEcvAe1GRaoX2zA/4CEU7BGAVMGZfi/y1pXLgVv0C7t0lEcrmVtDGTPgZcyI32OGuhZm43SR00gQaC6VfiNZV7E8jqTIRI/2LVwmWgaJIRTw/5wpmfAR56wM9eahxdYZCiEtQF7h2RseB+Y3I0hdsIw85XrIQv3Z7tAuVsiqnS3am3PAG0gvE/kx9fGef211EVtmIrvA59De2rcgzXIuaoNsJTFIuJdMVq2JaJmlwCIE47WG+y98hjjiyZCLBiviEUYLIch6VoLeSYXzSuin+6fgOSOm4i0idSPhHfneBUm+8fRUa6mEkaRpG1dVgMYfYUKTRIaq9MW0lnvfa6phQ66kDCE7oUvvVFoBUFgR4baVup5fYef59xHNLQZCgM3APM+Zi3tE6D6ziSrvfO9k00fbchFU15Wh6PlAPtRh3+aZs0w+I8QbsUnT5AKas0lz/1FgLqCeIoWjsCyxR2ak3m5WuoveVlDOHsPO4uaDzbSdSzqqUQjElait7jhObd/OX7BwFI9F0pFHMXvUsApxauFOf67YhqrgjL5Q=
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	atA/YzMfkiYyWVHsVvc5nxGA9ESK8gweLIab1TT79CzBjhPeAQ7AfCOnVEHYXrAZG97vD0EwQIsxrf4Wr0jQ9oH6IXJmI5XNssDDU+w8Mm4qxPhFspHpx7C2mNjUVffiqX/0vyWemC32UIBz6R22UkSqS8NkzzHoZ0XP1VujptZMmklldgvFAav5NHfl8Ww7NZfHiGuZQHWeJXWAZClpSkmSUqWfk/ygQz3MdNGbMC6ZRQmj1+BaZzHh/OC1R51bSTovr3MYTzpfNLbQcYS7WZVWj9iZpwNA+HMj5jr2fgu+yp/85jaArQRzT4cZiWVmGLW/oIUrWddvlgHufpCEdY/yWJgevekMNuySFHvlc9Z/P3jSJL4TQBIXrD0MjOQutt8TcBmPVrgQT5ydoZyoYjcx5fctRnvZO1gHmoScU3rMgDOgQfxF1iVNNhdQU/9f
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 13:20:03.1034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ae93b3-2d57-4fe3-3dd7-08df17e30bba
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10409

Add support for Renesas RZ/G3L CANFD.
The RZ/G3L CANFD IP is compatible with RZ/G3S CANFD IP, but RZ/G3L
provides 3 channels and 11 interrupts, whereas RZ/G3S provides 2 channels
and 8 interrupts. Update max_channels to 3 to cover the RZ/G3L
configuration.

This patch series depend upon [1]
[1] https://lore.kernel.org/all/20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev/

Biju Das (5):
  clk: renesas: r9a08g046: Add CANFD clocks and resets
  dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
  can: rcar_canfd: Add support for Renesas RZ/G3L
  arm64: dts: renesas: r9a08g046: Add CANFD node
  arm64: dts: renesas: r9a08g046l48-smarc: Enable CANFD

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 64 ++++++++++++++++++-
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 43 ++++++++++++-
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 46 +++++++++++++
 drivers/clk/renesas/r9a08g046-cpg.c           |  9 +++
 drivers/net/can/rcar/rcar_canfd.c             |  2 +-
 5 files changed, 159 insertions(+), 5 deletions(-)

-- 
2.43.0

