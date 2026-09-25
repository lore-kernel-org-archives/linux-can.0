Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010050.outbound.protection.outlook.com [52.101.228.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E97477E3B;
	Fri, 25 Sep 2026 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324528; cv=fail; b=uQ4P/LHHWHuaWu4OBC+w/LZ0grt4zD76BLG8WfW1dO3aSOJMzMvREDO9s/zUFmtgH5ZYdT7rfnNCBSmseWj5UjdsQ7vFW+UtCdtwiOUujOfYnb2XrdacLHomvYXveu+jAWCRaviWZ1GNvnwHtgKl2ySyks88dF6ns2aaqIGsdy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324528; c=relaxed/simple;
	bh=V3uaMC+iP9UHxK6ij2y16dotT1apQJSpFe/9SqtkW2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tON5X2Ni/ba4Vt38t4DMRAwtog59TiFD8bSALjwYYysKh5MQ4atAg7b9w72gfZMECjeiXwRoAqYZad9fjg66ErFXx9L4CieHaOBagYiqZI0kSBLfy34JGyDPEeFBxwcPDuQrKWls3hvns4t0QW1FAJTyAe+ENRMxZk4kRRQYiy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=R6S9ITkv; arc=fail smtp.client-ip=52.101.228.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="R6S9ITkv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMfAKPXLAdbahqd6+cfufg99KYDjuQw5ZWmIwb4uYELQoSawOElNav3h5plDeW7/tBivNcY8o1UGBXSg7VAGjCJ2yEwllmLuLaDzy0TBl7d9jJjqw3FnEuNJdMARIDEcn+PqOQ5JsgSjJu+7eGsE6Nf3CF4lC7Q2PdDkPBmMzZTn1gWcGomPPt8gfaAGVTgJMhTldRL/biVSY2x5JEz1dpIXaqZ/9FJ9FxEBu3prTP34cqq0xEkhVGIBOJOijsWhNnt3UzaKXAlCmhSBS8/dZw56dV8lOl80SPHr3aa11w3GbgB9W5X73iMdn32GS5A5XQVjISrm+0PPJaC+jvg+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KLZAgc1ze1prQ+sdem2/cGqL4vBdwvRjB0ok/deEeA=;
 b=M8VuBeJ/o6X7rD3lG0KkgR/tMuD1Z+/mgQ4EOtAbWJWH4Cs476yRda9JenSxpxWzfp7iHMJeckcFXrBfaU7eQvCJA9dSARjiy1lO0eT3FCVeBEQS3x/qgZOvS4NtWwGjqhijHvtFOfVRBe9epiV9SzfiMySD1BufN8uZollroCiwXVISOwW+6Wxx+YnSLJJt1/+9msyEFGwKZh0q7MB3LjIbezLF3aqFrAybKtxLe8Emd1yJExjlEyj94T1THcP+nYM38fLhbbzbjAkHUBGvC0XA3/GREI0OOEur7A3PzRlAf3D4lSKI8tGBs2OGZmtFyRrZeJbEL0y04zg3jL+N2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KLZAgc1ze1prQ+sdem2/cGqL4vBdwvRjB0ok/deEeA=;
 b=R6S9ITkvkK7mLAMyRUEBU6ke2/xKmGmQEFsRbWmbQSNC5yVbcYYbxTaUiVcaK+PCo+4mv8aKs5dc3woNYfBtOjuui12l8PtAhs53ZkvRPpfihL7nxih5Eu1q3rMXbLWNJZsFd6MLU5StaqyIqOA07IpY5Bor6onWanxOl0uwACk=
Received: from OS7PR01CA0233.jpnprd01.prod.outlook.com (2603:1096:604:25d::11)
 by OSZPR01MB9360.jpnprd01.prod.outlook.com (2603:1096:604:1d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 25 Sep
 2026 08:21:56 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:25d:cafe::44) by OS7PR01CA0233.outlook.office365.com
 (2603:1096:604:25d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 08:21:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 08:21:54 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.93.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 2BE3D300023F;
	Fri, 25 Sep 2026 17:21:46 +0900 (JST)
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
Subject: [PATCH v3 1/3] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
Date: Fri, 25 Sep 2026 09:21:28 +0100
Message-ID: <20260925082134.146015-2-biju.das.jz@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|OSZPR01MB9360:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9def9696-65df-4fc9-f42d-08df1ade0f05
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|7416014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WWbhNx9F67YolfasAO3xUXdl4sgfZXDzcVZFod2p6SkIlqmDDx3Qfc+v6V+z4FWzb9z1Kh6vXAbdsDahySrnByAKLuQORwpKbWTFFE6pXRN4d9wuyxf3vNp1T0kkSRyXgidv/iduL89KOWgJmCB52yiye4D8F78T/DXYNd/URvA5JMmMrzDDIqQFDVcfRvmoRLPxqEpG6jfQ/nqalXukgHjHD4kLDeNQNtfdwESNizeio0bKxo3fQafuEVAOceH1bafvr9VQYopFJpAqaRA1A+4TIrJylIFwWDOnke82rhQGcLFbLqwAl5TSFIDaLDAysaqmvVFqkfnGFIaTbasUxh4AXSNnI0UiIFZy37nfWC/97/GO2TZcc2MqL4drZPnUO5sFgx8zCUYACLsMKKVH3F7dOO9rehJloc9/rnoUEXJ6geR1V59LASPOiljzqVNIHPRCKdU/kEm5CyaQ7x4nlC18tGxBSW43CLVY9jQtl5WqxdHNdRPVkgo2R3c4ugVuNfMoc3KnFTYxWuIhbyRdZ+PujGRVvm0NQ46Xm5jYWNiQ9ct/JlBztYNJygVwCC2HelONKkEgTck3HBxqp+nQdMHadsGT1ztuzTvjMAuEBt7TGNt7w9PRgX7hzc4AaSCnrl+h0c46/MN3jf2IWBY77YYqEpxrbH5PNqrXMnPKWjAIOx7WhljWUMS3kbsjo7aKeo/27FPoeAbB0qYP+tAENA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(7416014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dlF6SjkPuFVri86th8vfY4vwZt0hkspsv/MPNBbROqrBymTDQHoOPTJ6XDNhhHgFXeqPY13cEfZGpLQbcLVX2bOpXlwgxdkS9+CBxh6RKC/1QNWq8hpDBQvUL8/3OVXppIiLhTUSZOo92hFQ4yNkWuolmh6kiiNLzgdHLvEbuwmg3FNVTmOzpJK8G6vEW3fH3YKx38KgOJ/mGeIctLGgmzaE9c5itCs+JT2ecuvulqpWWTiJGk5sm63JRBllhDzdLoPfMvdhZQepZ78TXMnMvxyWcW3Bbwi00uBl+hwxHwsIfNFStW58TW+mBqOxJOjm2k0RtMBardh2hxq5wgQaoQthTsBuxMisf0j94/PMnX94OlxTUTIrfJnWrCJ/EqBprHx6kwVg1YKtEv0ry0wGPmJXRP5kANAdRS4N7ZWHJBIF4uqRQCZBWjkvy1CwMo1T
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 08:21:54.6376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9def9696-65df-4fc9-f42d-08df1ade0f05
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9360

Document the RZ/G3L (R9A08G046) SoC support.

RZ/G3L has 11 interrupts and 3 CANFD channels compared to 8 interrupts
and 2 CANFD channels on RZ/G3S. RZ/G3L has 288 buffers in total
compared to 192 buffers in RZ/G3S.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Collected tag.
v1->v2:
 * Updated commit description
 * Dropped RZ/G3S fallback as there are lot of differences.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index bbaaef8f4282..71b756c26cec 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -14,6 +14,7 @@ properties:
     oneOf:
       - enum:
           - renesas,r9a08g045-canfd        # RZ/G3S
+          - renesas,r9a08g046-canfd        # RZ/G3L
           - renesas,r9a09g047-canfd        # RZ/G3E
           - renesas,r9a09g077-canfd        # RZ/T2H
 
@@ -292,6 +293,28 @@ allOf:
       patternProperties:
         "^channel[6-7]$": false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g046-canfd
+    then:
+      properties:
+        interrupts:
+          minItems: 11
+          maxItems: 11
+
+        interrupt-names:
+          minItems: 11
+          maxItems: 11
+
+        resets:
+          minItems: 2
+          maxItems: 2
+
+      patternProperties:
+        "^channel[3-7]$": false
+
   - if:
       properties:
         compatible:
@@ -356,7 +379,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a08g045-canfd
+            enum:
+              - renesas,r9a08g045-canfd
+              - renesas,r9a08g046-canfd
     then:
       properties:
         renesas,no-can-fd: false
-- 
2.43.0

