Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010042.outbound.protection.outlook.com [52.101.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69C49B5D0;
	Thu,  1 Oct 2026 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841487; cv=fail; b=NWZw0N6uI2QyzabU+hhkAGZgtqHR+bR4g78WjURsKK+FZp0jSkFFffSFmcsePFA1KwuhGdCroU9dcJVK/aJDCgoPoYrpng+0CCXMahxodYc1kvA5oG3BVJW0LsuZuE2tXlrFbEO/Z0hBMbCQJsbKZBukcrZX/VvpT3IOcHDUX5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841487; c=relaxed/simple;
	bh=810Rl19x9pgMfE7s/gfvZewp8rad8l4Tub+MYWJRIGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcGW+238NKn2IHFKoY34tmhpI0nPmogDwLsEEAwMuLMLbWxAav+uKS5Tm7501VYK1zed1PN/oykdGMsuppCNABpB+7KENzCIoIKeW+8vjUcHAT8BkjH6v3weANfXrhEumpN+tZmsOC1utonnVrA9ONwBPth6cWvw9LfQ2uUvlDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=cLmAosxZ; arc=fail smtp.client-ip=52.101.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="cLmAosxZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nR6AOzPI84m0mtezzIOqtYaJfatwDXGoiHGHtWwiWNl6W3JEbjdSOlWT3eXtQrHfEzPiH0Rks9y6att+gw3aOfufeNuoE5GSEU4R/XYn8rIeQT7Nss/s+9eJ5PvYIvvY4M+R/Uh5KxOUhBlK5bEucPfYVi6yZrQG1W3sXrFbB/3aHNZqJVsNKGmotlFCL4DMheutujkszsSbTi0MPb/2r08cnvnBac69qGnqk5nY3cCdOx+DaOIZyQuSVdcPFSgN3yClrPtCvwy78u7JMb+1NUghh+NZNvbaYNT087y9JxQZfxJj0+pmYf95inYzaWA3nCYIbrj2YbrXFHw0pKoOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqqI+dV6Zc4Vy2VQWBGS5hKqFc2GKJW/R7zUUFCAJkU=;
 b=QhcJAAVVrRzVqxeOJrdiFqoJHWA60D4ArLPnnjy97NcJlIlfeZv8Fsyli7Fhs4EF/8PBxSCLZQ4FXZsfIjVwpu6wS+IccVGOScZnIeO4puU/bak0Z16NLVAW589lUg2gHxrVKDrrYdMMHQwyiUhB1blZyoY/8fKx7dPC33/zK+1AZgOQlPRTUyY2DYXpXYoJABsAbmMnr4V4xctuUjpmBHam5npezbgcSvG70a9Z0JBjwGWgA9PIV6gaObA3ipS69QwL1L2hNauEzzzWLVhWBl8gVvK/xkvFA0d+nl3Jg+LB2pyCXQ5iB2eM8clYIOqIub0UHiEliqq50tV5suDWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqqI+dV6Zc4Vy2VQWBGS5hKqFc2GKJW/R7zUUFCAJkU=;
 b=cLmAosxZ/NXi9A6F2V/nZ0kjepRiMMDGnlDGMD4hfN889zIlgNaDafbFzuxMRQFnplGVfrX3zA2eHMfa+heXAtW4sliTpytMRegrcEXRN8sWgD6jXJhacmlDI8iCdoZOQKiJXrUp8mChsQKA/+WfXeMAqQOENKz5B3KEdLDUH5E=
Received: from TYCP286CA0264.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:455::15)
 by TYCPR01MB11126.jpnprd01.prod.outlook.com (2603:1096:400:3c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 07:57:59 +0000
Received: from TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455:cafe::5a) by TYCP286CA0264.outlook.office365.com
 (2603:1096:400:455::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 07:57:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF0000501F.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Thu, 1 Oct 2026 07:57:59 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.93.25])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 064983000239;
	Thu,  1 Oct 2026 16:57:54 +0900 (JST)
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
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/3] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
Date: Thu,  1 Oct 2026 08:57:37 +0100
Message-ID: <20261001075742.21961-2-biju.das.jz@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF0000501F:EE_|TYCPR01MB11126:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ad30c0da-aac9-432a-b403-08df1f91b602
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|23010399003|36860700016|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2yBAwPM/hfA6BIsBRRl+XeZeeWmDculDwcc24phq4Kn8yz+HVAYR/FkFwgRWcDv4jWeWOFUAwcmmFAUo+4iyNAJiHAhm1XakEAn9+ghYck0BQwhPxfswJSRk3BPbAYho0GhZBwWB8p+GYTtE8tECvP3Feox4I35gSNr5kUbYK0rmd7aEnCunmfrr9BMpIKG/ktnhr4zvLwNZwstZMcu3wLQyfkRwM8mMR6imGSBO3Oh5JKQK0Hhh283rAkuA90HWR9aScWziG2P4KI2HqFyeGDkpruBHXZzi0yZnVl6W7UXrkH8a7LNYMLXTKb9Vu6EiA/nujTT604L4nCQRGn/yWydnn9SeONPVJ6QNlEOnF0o7O1GPYZR0EgtCbmmSzDjB24O1G6eHk9h/av+UpUoUB1/ZQoA8WO0SCn/ZtKbsB+LfCPgZS2qlG49GxUKD+/yoJ0E/Cs9JJHdj7jwu21v7IfAtw7u7oVddocHrA5tF6AfifpMMJscErEF9LpsdUhlaEhuaHpjh3RC/4+u6AYPz8Ehi2aeYt7GCcj097iz9plAFFDD3cofXj0bLcwpNpR6ZLW/yln//T1NpAkIlarYmS/IVknQuJGhGCuIgkry8nHgNzonnklOmzariHPzEU3I5Uslxnq2TTFX2DBvoHAAKZVCkQEryYSe8pqB4Uj2XyhGz/jucSIZe8sL7M4pWQVYDs5Mb5quGDYWzkx0QRgYLDA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FPl/34eGmWWXaQYW8CTWgds+ZiPZ0S+Pv8wSG/cCjIBcAX0gb1zGJC7WvPfwf1SepxySYG0Mlv86sIvMsP1oLjkaXCxwOeUxR7WeNHN5+ZcpwZ8IhDOzAIm4D8vRfqHyFJqJFOn6u08oI/V9dS2I8lWZGidaLcpDnu70XGPHC2gT4i3xsGGSo4LP+owl0Ar2CPxtVSWdBwcCbM6SiHHQEE/WGTIQOU+jqugC54Zd3P849DxVgoqhSNC7CemxMW+sq3bQnaehlu+pe3kjfYhDMJZFq3GUtqg3HTMZRB8w1vLy0vPJCUKR2cVfPnZxWHXjJGMvRC8rq4A/OHgAwMOhc7GKmICr7DJQ0eL8ktEXcjrCFoJvyQwyUavCCWsBtWwtYDazeNAYI5lQpMHJtsr4pVE+wLOm41XwGha1FtvvemI/HdrUFXJ+jWFXcjOFYPXx
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:57:59.3757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad30c0da-aac9-432a-b403-08df1f91b602
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11126

Document the RZ/G3L (R9A08G046) SoC support.

RZ/G3L has 11 interrupts and 3 CANFD channels compared to 8 interrupts
and 2 CANFD channels on RZ/G3S. RZ/G3L has 288 buffers in total
compared to 192 buffers in RZ/G3S.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Dropped maxItems from interrupts,interrupt-names and resets.
 * Collected tag.
v2->v3:
 * Collected tag.
v1->v2:
 * Updated commit description
 * Dropped RZ/G3S fallback as there are lot of differences.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 1a7a9ce45e97..4b94bc8d911b 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -14,6 +14,7 @@ properties:
     oneOf:
       - enum:
           - renesas,r9a08g045-canfd        # RZ/G3S
+          - renesas,r9a08g046-canfd        # RZ/G3L
           - renesas,r9a09g047-canfd        # RZ/G3E
           - renesas,r9a09g077-canfd        # RZ/T2H
 
@@ -294,6 +295,25 @@ allOf:
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
+
+        interrupt-names:
+          minItems: 11
+
+        resets:
+          minItems: 2
+
+      patternProperties:
+        "^channel[3-7]$": false
+
   - if:
       properties:
         compatible:
@@ -358,7 +378,9 @@ allOf:
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

