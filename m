Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010071.outbound.protection.outlook.com [52.101.229.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64143BFE5C;
	Thu, 24 Sep 2026 05:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790227696; cv=fail; b=a4X74dGhYo1KRaAsX1NN1HG9BloqjnN0qB8NB7i79RNJZalB8z7Ba0CAOvs0I1/dSAigTWqbf1bpILbA7FMsr+Ngy/C0CA7eRl9AFvRUHuoCuwXVk3VR0UJyzTqcpcCGRUWg21okvIVmpiEU80QD3ESToaKDyR8qwaRa0hydTz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790227696; c=relaxed/simple;
	bh=BEgcsDK1F2uKJl+A+IdfitSHN2AQku1o+hFOq9ufwRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3GjRyjUr4WfD/roCgyK4Nl8U2vHkV7nLq7XCXsbu/OZzWcYMc0se/MWk405OGYpxIMOwhwEr2PaWsafhPr47y93JlsDKPAO5a1aSR1To0mpXR5d9xquS+jiXAAA/P1bUeFuqPHbST9vIEFd4DhEjUB9PKa9wD6zjLFYE7xWbD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=iEHHk8Nq; arc=fail smtp.client-ip=52.101.229.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="iEHHk8Nq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+iKTDwMY3HySSaLiYDD6qMGVzS8bRktAmg/54jjWzEsHKX5qVoFWH7d893kih8qs+P+RC/pR/1coCCMfNityq3MD7m9X24pKSuNyM6Njw3vbF+MIpFjCbKMKdnsCvPkYKNjMeAfn6Wsgp/6q6nLo88O8Wad3I2J8Wf9I/NmA4V+GpZFgtCCCen+q91o6r/QCIxZtRHp5U8wguXlN8pI8vIYWxMOe66qClKXTIImzfBUAKflrCrvXXs5qMB+gBK8umA/l4Osx39ZdGLtjLpsNEqFVCESke2g1lJrMHxrXIe/q7wmrj0HROkmmyDTYcU+2NA8tDs/FYI72lI1NO6ePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ky4f5ciUpIWqd9F1CtpvhkvbNR1ugG2A1rn41WEwyzo=;
 b=HSk3KIAjVmnn3vavNgrC9AArofoTTw7gT0wGo1QZRsYkLR+kgZIt8iaOXlaHW6//f/dRymV3pqSol+4YCd/gTAWKzgQDTV5VyqJKkvoQwyao5pcs7ZSg3lba6AU1PLiRH7dkiwt3FEtaCdzerypFrpzFdK4Xch9Ku8+OldVZN5QBKVy/2O9Huqd9pmRJqdFNO6SQZ5FO/eLaqjbTSjugd/payxtFpwtDON28u3Wu35YdWFlhmVzqsrGHjOtiOKhMepX234ponGvhaV4lm/Vh07LuHTbhSeuy4iR/+P0cmQTvdTE+rirHhnX26c/zs6yZOCJJZNIt8SMbzXbZJxUJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky4f5ciUpIWqd9F1CtpvhkvbNR1ugG2A1rn41WEwyzo=;
 b=iEHHk8Nq9aTy8LUxEbqqTdtvWibKu97tYqW7R5e3C85YfsyvpIy9ptRWaISnItAGTh8J41HDO/0corcxeyjnPNoEBD8foqBqnNZUEoEwWb+2pPGQIAMtSuP748jS3Po4lMPnQMBBOp1E6fOHJFtMB2lB1QfiEdStiiQamYlXqxY=
Received: from OS7PR01CA0270.jpnprd01.prod.outlook.com (2603:1096:604:255::9)
 by OS3PR01MB8113.jpnprd01.prod.outlook.com (2603:1096:604:163::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 05:28:11 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:255:cafe::2b) by OS7PR01CA0270.outlook.office365.com
 (2603:1096:604:255::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Thu,
 24 Sep 2026 05:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 24 Sep 2026 05:28:10 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.63])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 86DF33000256;
	Thu, 24 Sep 2026 14:28:03 +0900 (JST)
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
Subject: [PATCH v2 1/3] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
Date: Thu, 24 Sep 2026 06:27:33 +0100
Message-ID: <20260924052741.130658-2-biju.das.jz@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|OS3PR01MB8113:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1d81b547-07e0-4367-53a5-08df19fc9fa0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|7416014|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HXnXu3sNL4c2fALHAO7fZoSN9sr9qM0OuI+GK4JUjDkkUh7dUVUJMA+yPl7A56Ua6Gf+dsC56qP5HKxMQ2gor7TtHdSCcN+5DHeRIHnIxTLelD22kusOnoh809wsQxC9yGc31Ga/I9iAkrl6Cv5mJAokzdLuk43xQKW+mTpwgs/Hw2Z4zJfeRA7OkmC9WOOxIb/UgJyjp9Zvr0cviUqxJOQhaYSFMEzTI4JhxxzsoyWZkucY1VlnvGgezqMG9x91OwoJMk5uU60OPhIa4D6OjyXBKk0oteQWInJ+gMTSUINsbPxZoXPfOXyyNaclifaKjz10uKQPCKu4VmbPU+0Qy9kpANIv78mNt+KKm8lbAewiU9D6qRQkyhEVHuQZT1I0FnWwvIqEqVOW9fA0XVTRrGs6CmbO3GGG/f5NPUKZ1ODrEh67NdNjVa9/HTtDFDtbgRVCpEPvohZCzQ4iX5Pv7gUN8mBs3K/I993DA7yTkZcCIUuJCcpWLWEBhomrx4vUGpWDAxabwmW5LAaCJ07rn4g5llniT8+7k8vOfkPU5RdQY7qK1isMRBm/YRfnHgNvUfCI7zB1nsKrYdej111T0kAg+hFqbj7a+jSpOVP9oNcxf++CZXRY8v3A8ggtDmSUlzX1Stp+Q8c5Mrv2DkyfTUcj0ALuq9wLf+fwAmvfVKRK2SklIJ5EIvHfIJxHIYMJxgrJuKd4us/yJtJOcZyuzg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(7416014)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zKtzIzXlGkBi5M1bdd45HsQJJi4yLvrhp43wALkglLFJmIDJ/GuOfyoQ/OSNo7+78VIQK9MOqBd8JHJ0Y6xBCdZglWVsCVaA1dAJAUd7m7NXdd5+8i5XzhCQZyuIWs9QpBDtVvZjcDSAbabe2Uc3omZ4TpCIZVVuOvm8sNobP7J1HGYAasm+UoLxWJ9pMtMHIyW7vJm1pXqVowpR5pd7pxZo9s9BsA5jWbXMi00ZiSDFEf27eR464pCusy1aKwNnvhT9wqBmJUbjwBA4RmKWvXgxSAeMYpNXYMrk5tnPXzU0nYK8ytvz6FXIPrQxx0uU6xO4LqxkseolZCbMJEOSTfyXsVVVQs6lUa3IXu0J07n1LQgfB5ACrPDi2IdHuyewPBHloqpuv8GV1x1gV30PS/6y2a9HLq8RBD06vGD2masqtMAZFXp6u0sSwhHgoLqX
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 05:28:10.9797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d81b547-07e0-4367-53a5-08df19fc9fa0
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8113

Document the RZ/G3L (R9A08G046) SoC support.

RZ/G3L has 11 interrupts and 3 CANFD channels compared to 8 interrupts
and 2 CANFD channels on RZ/G3S. RZ/G3L has 288 buffers in total
compared to 192 buffers in RZ/G3S.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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

