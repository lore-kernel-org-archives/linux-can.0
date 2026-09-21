Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010068.outbound.protection.outlook.com [52.101.228.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC624E016;
	Mon, 21 Sep 2026 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996822; cv=fail; b=ILKBg0sP5LBVj9L/cXBWdrulD1fPr3YEW1f4KBpsMwEflB15fSnooJsmLq+kxsb6iFaQI2xO1RtqEBTFbxLqdpWHKhghKaHprxqVc+9CfwQ8jTkf6QTnn2bQdXF8BcQtP7EdTp209lG/Qu3CvZQLudpRoMFxQyFGQziF4nN+QHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996822; c=relaxed/simple;
	bh=oEPm4Ul5oqZv484LtdZGpPWC9Da/Zz23TU3yFGXkkMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CH3cXHoP91yEEr7Yzuf68zrDE88DRfYAx8zGH7L4So7VPXvsM2izmSZkoLcjUBCaFZJtjwB65ExpQSliIlQ6UKTafG7AT3F3WohuUKh1PMsqSgk6CuuOHrHLgIzgeJ0vPLuUp3xsHWoQyzsp+2RsvGVnAExjXMGu7cMq7OkwvkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=apF6+0bT; arc=fail smtp.client-ip=52.101.228.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="apF6+0bT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdbF1MPNVrCL9cYopXuMCY4jck9olZcTvOuRcoMkn914WSRb5snhr1ICc5wFMqc7VreOqviCEEL9aWom75LUJx/3PS0MV+E2BBStH+cu6TvPt55VNCxB4pEGlaa5Yh32UmUUVE7A4ZA3pqW2UbmBZnhiyJIJp5bXHLsYPUV5LD9zPY9FcZUlzx4BF7MWb4Vka6QzFCfY9LrgaBjIpBu83Gbwdb25T/RQPMFikU1GwAfwUTN8dwbD/KQ4orb71YdMG/+H2PebJDHa3kxEqOJ1cjidYZ+J5wkiAF+kqTSZ5srISwLA0GtWsVn3M4lZ/+L8RVkSEX9OfVWGFzdvN2fNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+CFoz/asjleNhHHeont3oIVvLBu7eiY3q2GzVWCOKI=;
 b=tjIpNXfkEMXcScELOau2O+GNLoioMk6K6iG6GC5JhzPlPzHvSrj551NPGaZrXaT8nBioLFPjxXnFHwsQdwgMXaKSj3jXLGl8xBOXEXodygzYrYuVJw+wrkVSaxmz79kA82SANHOOz1wFVDBqOTDKZq/VuBlaKyjTWeF4EzEFdwh1UNd9UxEC29HS6ZAc1rN+yRiUXJU3QIc1cFM/1aBp9IEzzxei0It7GiMRETQVPt+6rGODq2o8BTledii0AobWScvy+M/eyjA1BUrT8TSFNUv/3Es/V8Nz0ewx33B4rnjPdJr7ZnInu0YLxoYzPvptpGbFOF9itUNoAT9yhVJJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+CFoz/asjleNhHHeont3oIVvLBu7eiY3q2GzVWCOKI=;
 b=apF6+0bTa528KoWIHCioPq1VF6L86cyr8/bFyBjlDYXAUHnHQwA/LhoyezmKFwsgeN54SEGXiQv9iFoMaSNW2+2vMAY3PxMHe2U2QQTUU5yXoCVTceT7Dp6LbWxvHEAaITwtRyyaAkCKZEP3aq5WDWBGa4RaVmK1V0IOBTJLh8s=
Received: from OS7PR01CA0213.jpnprd01.prod.outlook.com (2603:1096:604:252::14)
 by OS7PR01MB13617.jpnprd01.prod.outlook.com (2603:1096:604:35d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 13:20:17 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:252:cafe::a5) by OS7PR01CA0213.outlook.office365.com
 (2603:1096:604:252::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 13:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Mon, 21 Sep 2026 13:20:17 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.93.82])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id C13D63000283;
	Mon, 21 Sep 2026 22:20:09 +0900 (JST)
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
Subject: [PATCH 2/5] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
Date: Mon, 21 Sep 2026 14:19:44 +0100
Message-ID: <20260921131951.187981-3-biju.das.jz@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|OS7PR01MB13617:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 85918da4-93bc-4757-2b4d-08df17e31410
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|23010399003|82310400026|1800799024|13003099007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UX4DrHRTjRTZnwrSoLwhFdBwA2lq/BTsWhBv/AnfO5NF8nsXROJ92/uP7qu3aJS8jMrhumf8K8WJlHxZTXU/+9qXfQvyDRihNe43uqWKOo33GopcoQ0tnuZKv6lwUcFwiJJJ33c3ixgAoc+eDz1Vev9RNPdBkj1W7R41HWPoNvncajmXZeEq/zC6iao1sKfX6993XIvSTscpBlRd8DiGwlAa/3G+NkBpud0iWynlYtlGl4Yz/gzmXEKwckyUYIa8wDkhurQ8RkJk5DnMNlR4ywRvqD7U3PVJ2MG1p2K/wHKI6KFLKb6wKuzT1gfUnBXVlDFMaEtk+OiEzn9ZtI9/WKpvpgNqLIre7heocOB26R8/8a/7UBaQX7IpgwMpXswAfshLUdgtOvD90bWFQh+7SoEwBOoK+iv1L1UmRr0dw4te4nM4Ro4dzllJqeJSqHJfk/dDWE0+jQ9W4LCppquXQb3Iu4lAafzjfUAMP+Zis2vzqze3Jcfb5cst3OBUEv8AupGTrmscGnnBi3XXvZsDVd24yhQSLrmZhwMH2OYX0XOS8TUviuHDLVBmBM0RGeDFp4kULRNQDUeiWQHb/p8WenFjSbl0nnrO6YKD7pvif9vasrjvepVNVFvwDVOXWGw1op3dhw6hZyNIeyBlxIbpxgwefgQj1FD6fQVirP9iRZg=
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(13003099007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fMrQuf9kHfyiv6bltZjS97oaKW2ArfJwZfB5BiLjWE3jJZ4ANY82kLV1ECWsr6n648nLSqLRELx5WUh2v9M3GLGeNoDPsgY7gElMOzw09/OopH0g6Ov4fjmU71GzvFhLUEza9Cyk6E01faYG8vo0I/JiZ5JwRduvETIf+1/elLCPhsTpyNnMpnkmsjqx9OrvWktHBRDOGdXtdqqjS0o/ukx5334aWyyK61we+5yXJWHTusTj/EuKV1NzpcvoIW1ZaAKr6LkwQ/LIoCZov9ymr2s7PaceBMc3K97FB360U1eW1aH6xFPg03CSrDgPoQF6jlbzRKCimORvLUX4QKYbLI/B60dAfvjV1R3ByKLsrxSvFVH7NPh4GPYyW/2e35DllhWFeWRx5r5ksHNONGzQEOMHi/uiYkN9s+o30qrwE72DhApMwrPfniImEFBjWPN7
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 13:20:17.0902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85918da4-93bc-4757-2b4d-08df17e31410
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13617

Document the RZ/G3L (R9A08G046) SoC support, which reuses the
RZ/G3S (R9A08G045) CANFD bindings as a fallback compatible.

RZ/G3L has 11 interrupts and 3 CANFD channels compared to 8 interrupts
and 2 CANFD channels on RZ/G3S.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
This patch depend on
https://lore.kernel.org/all/20260902141544.565763-2-claudiu.beznea+renesas@tuxon.dev/
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 64 ++++++++++++++++++-
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index bbaaef8f4282..1062a52ba77f 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -47,6 +47,10 @@ properties:
               - renesas,r9a07g054-canfd    # RZ/V2L
           - const: renesas,rzg2l-canfd     # RZ/G2L family
 
+      - items:
+          - const: renesas,r9a08g046-canfd  # RZ/G3L
+          - const: renesas,r9a08g045-canfd
+
       - items:
           - enum:
               - renesas,r9a09g056-canfd     # RZ/V2N
@@ -196,9 +200,18 @@ allOf:
       properties:
         compatible:
           contains:
-            enum:
-              - renesas,r9a08g045-canfd
-              - renesas,rzg2l-canfd
+            const: renesas,r9a08g045-canfd
+    then:
+      properties:
+        resets:
+          minItems: 2
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rzg2l-canfd
     then:
       properties:
         interrupts:
@@ -270,6 +283,11 @@ allOf:
               - renesas,r9a09g077-canfd
               - renesas,rcar-gen3-canfd
               - renesas,rzg2l-canfd
+      not:
+        properties:
+          compatible:
+            contains:
+              const: renesas,r9a08g046-canfd
     then:
       patternProperties:
         "^channel[2-7]$": false
@@ -292,6 +310,46 @@ allOf:
       patternProperties:
         "^channel[6-7]$": false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g045-canfd
+      not:
+        properties:
+          compatible:
+            contains:
+              const: renesas,r9a08g046-canfd
+    then:
+      properties:
+        interrupts:
+          minItems: 8
+          maxItems: 8
+
+        interrupt-names:
+          minItems: 8
+          maxItems: 8
+
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
+      required:
+        - channel2
+      patternProperties:
+        "^channel[3-7]$": false
+
   - if:
       properties:
         compatible:
-- 
2.43.0

