Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9532E151;
	Fri, 17 Jul 2026 02:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254474; cv=fail; b=PXURRwC8deh2yJ5HxIa2v90SZ+NmsZoB2Cn9H2Fnygzv5gAfLWwdWq5lNqVBTK/eq+2K0+RZfwme43fuNHnoe3w2oRiNjRAfJWujZ8byUq557dWYm6MfnPhAeGkPB1jCYkV5epwS9MCTNkpTCtQX5mb/8mkt6kInZsgXFByfxJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254474; c=relaxed/simple;
	bh=spGI+u/1LTb8ppnRbZBAfg65rIVVGgOHWgrGK5tU7hk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqpKXYYvHrGNp67iLzobCQ2PJR0uyS7zDzl+fQb6/UjBK383JIQeUnjAoLdQULfWfPMPUGzKVT1mj6ZTBqgltc+mtDwey9F/fO2I21pXv8FAbuojFmJXdti5uhHXAsTvRWfZo+okTHjW/ahaWzRiqg3dpw4QUgsv+cNIgJ5htkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DkoKzexp; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DkoKzexp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WF1OEHF2B0qm+jBRbNrKd4jjchTA8NTi763SNkTqGUJnYQdR+r83FoHjUamsIux1oUUN9+44Ch0VbeneG+mgKynbjg06iXN0tWyym8aeNwp6kgbfnmmVLjbloOJQt6zsC6Z0XiAPzxdqr3uGuKHL74uO/+WRV2Ajy97fX1QqS4DBvDrgX5UbSS7EDposyXn9mYqar68Vvr32x7PHhyPwZbUn3ymBl1F9S2kzPJJ3OyB0plRh7chmKsMGZpzPKz6icItLF25nZ2d5jj6FwPq3A5MlsZatvagXcbg2qTJI2Oge5oLwVcXD79mVmFq49V8t1vs7pBmOkElo/XTs/G597w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP5hGp+Iyfyjl3bhjFZtDZFPCQSt9Imr8X/nypO6sRo=;
 b=nl9z8RwT7jqCyMPfF7viOU6dQE5/iEeKHSqkILg7Uasc5M1/IoH6jjx3wmuZDDn+EQZgF/Sem9jwbK/2aM7SZhjAT6xTmRaNF1+cb7zQDn8TSBU9s7sLa0CGerydQDfyDhZbdRk7N7ojU6fQQtspTVHxC/vM6ce+R5ywQxldmKF8CxnL+dExodycYymRueL0RT/vQ2gmTRJlpYnet745jWucQzZtd6kHhfQNaDRKXGnXWbIcSMl744PaTNRYiXmkYqLa/+YOkpnRb9ZiXqT2afp+RNV3A022j+LVA0v7JFD45KPjUtxk0VynZBTp5sDnZJg5fMlrzjk1tdIi1nAmWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP5hGp+Iyfyjl3bhjFZtDZFPCQSt9Imr8X/nypO6sRo=;
 b=DkoKzexp8rF4/kCpAmsZKLlYpAo63B9jFPg6DMkvAqBRcHzSnHsbi9mvCybTw6C+V5+65rCfb/gUSSJMAFpxeIb7lYVuVzx8SyH8BcdUKhzsjqBOcWbSlPbtoU5U3b+jsbcn3yaeO6qx+sxI1Ok7LX4l+bliVO+XFa+nuP97JRo=
Received: from SJ0PR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:33f::26)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 17 Jul
 2026 02:14:27 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::2b) by SJ0PR05CA0051.outlook.office365.com
 (2603:10b6:a03:33f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.7 via Frontend Transport; Fri, 17
 Jul 2026 02:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 02:14:26 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 21:14:25 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 21:14:22 -0500
From: Harini T <harini.t@amd.com>
To: <mkl@pengutronix.de>, <mailhol@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <michal.simek@amd.com>,
	<appana.durga.kedareswara.rao@amd.com>
CC: <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] dt-bindings: can: xilinx_can: Document phys property
Date: Fri, 17 Jul 2026 07:44:15 +0530
Message-ID: <20260717021415.2234865-3-harini.t@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 19965e6d-ce3d-40a8-3463-08dee3a92097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|3023799007|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	1gK1pHwfL8XA2Wpteb0bHdriOp31FEHAC024DwiH6rFyn3mOn5IHWplWm0rb772PlDGO1TcaMjed5aN1Q2eQurxtOdAezb++c88eFsHPZ5rpD6b4YhN6uB+z2t0qvUIZJDJGzp8HknmAb35l00ouTlfWTJy6wQdJYCLo3aOPF0n7x0msLm/69ypC+HiUL14iUYGSngyHluFAa4HbiquZJIfmM2AUq+5ACJ9dQ9Ze8hluf1LsZsS2NURmSRkJL3of0DTrJcrIlJHzcKAhi2++/4ed+M6YvbyKXFjHpp2dNWJVYWaxZCuO79BSyRuFmdF7dU/W9iog1yCL1JaoGuTNSyvm9j91TWgpDxMYrOR5FaXI4BfS9ohZSp38nfJX8NM2CHX+1vB490eZk9FV+5abdutDIFugaKoBO5lBFp5D6ngtoduN9DsTvV8k5UK6bg/CJqYETaR6DfMS7RahQROxWyzeDUVUKMzT5AZtQKi7uwMk64uVWghfD+M24wqaTmrLEOuFpTK+Fd/3cBCxTJo1HQsAY2jhNGFi3MgJ/bM9UcQGzPAKQDuUBAUm1JkaztwGQG96njqH6IMO9TlEDFCktxSOhH156m4MCOdZLSvYY5UpzdwjuNSS5wcxwcFAeJTzQvWQTl3E1yAsp5QefgPq1AzJJXXRc/5nZQd3wUw7zpkCDmV6+d3yVwPziWhRghnmPe2Nk3mRMQv1MrRPrI2q9g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(3023799007)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dF2hniPEM8Ajfp8xdYC3wYg/s3m0ChxblzXDcXg7N2wO0liVREr6PlrPLy2hDFOorf+k7FVpHSg1cSpEF99QaD/8TMqYBLHAXe1B74Pjh2PQ3C+ywqNPz4Gk/dXdAkIbJ1bqfuzssdiKzRdewYZ/EeA9tXkeXAWiNOy1DHoJGvQMAVGBlNi9ILNUZhPsVLMvppsFjSDoFwGhBvaci6tYVllINjI96aHxl7A5P4tUDgixVlpJkHshOMvo1Wt+NaBC0Nexgn2ZjRiu8v+IqLPimYc+CmwF1bhhEW5faF9y/AKaiM8cInLG1csf2mdIhBe6tU0/NV0MljtjI+tHnFcpStT4LS0LhWtg+Bet+dKwYTWwdDXB/piuhx9zw92SYEqhN+jlcQxPQl0lGgwH81E0Khk/6dEDf9O4bgbceetn+AuavFua9xuXAahVwAC0D5z0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 02:14:26.7924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19965e6d-ce3d-40a8-3463-08dee3a92097
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760

The Xilinx CAN and CANFD controllers can be connected to an external
CAN transceiver on the board. That connection is described with the
standard "phys" property on the controller node, pointing to a CAN
transceiver PHY node which models the transceiver and its control
lines (for example the standby/enable signals).

Describe the optional "phys" property (a single transceiver PHY) so
the on-board CAN transceiver can be described in the device tree.

Signed-off-by: Harini T <harini.t@amd.com>
---
 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
index e705c719f7b5..18015e60fd6d 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
+++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
@@ -53,6 +53,9 @@ properties:
     $ref: /schemas/types.yaml#/definitions/flag
     description: CAN TX_OL, TX_TL and RX FIFOs have ECC support(AXI CAN)
 
+  phys:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.34.1

