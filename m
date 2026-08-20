Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD73DB980;
	Thu, 20 Aug 2026 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262016; cv=fail; b=C3hw14QvhgpfJxj2SQ4CW+Q2FGEEeLQlTpXYVD+bEpkR5/0I/gFTm5z1rz/eS6hvhxx7pYTPPAJTT78F8wF0NoT2r2iETntP4b45KFhxXPmOVs4gZOtcp9G5nDyHSAesrGl9t8OYfMTDhqL6+ebvc9aYAw+5PMmd+Vf9YOk8DBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262016; c=relaxed/simple;
	bh=MtUAX8P5QjXWkwPDHFJRNOn+xrMC4pjcLCRTIp6meIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c8DJg2C5CbOz/Ql/PmQrO6fjXFZkeTXsskNH8rNh2us1XcAylRHf+yJOtQLhn/ZPIxHl7p+WHzl0nJF8A0TEy8gL4zwmLXTq4lbww0t3HHQu9fYU5sJTvbpCLDooDMN3Hfi03dXyduO6nGgd9qEVJdzkUqgaHrSPfNIUSzwJ3uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Hy9rVaKe; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A2zsdgZh; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Hy9rVaKe";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A2zsdgZh"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK6p681537859;
	Thu, 20 Aug 2026 16:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=6LEyOx2H1Mkb3udaVrvSfOOCbakUtWZgki3SMIZZq
	48=; b=Hy9rVaKeoV7pUEFYSTZVFoOkGh7j0M65TIXYr/zT6xSJQfk3ChvSfpXph
	9nEQv4o6PI8Uub5yr0DCzyW5i0g8mc/TjTkhKdOLbphM49YJjp2GQvjYh2EI1BcH
	YRfzRysgr5tClEJ4SQQRTLcoDWy8isyvzsatpFVyjyILXmFwipEsP1cHo4UtqH+S
	11zsADUxTQx8MeTt6JCPeanEiOpUnaXn52PvVipg3jF0KnVSjorW5mM+kniCbtM5
	8EXkluPoWdg1cUk0e5KpsxLegvp9V3n4s4dQ/IL5j+s7kxx06NjnUjtVjwbxIk6u
	KWCV/lRtR/brASLjAzAnWxG712PEg==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g5qrkej8y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 16:40:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfYk4LfSKXt1MxDFr39eeRVx6dOZ2FBrrGzCz/UKXGAkx6dmxYlw26EiwJVM7gCg3KSSrtwJqJbxa0HHRNavy3+ZOue4Iwo59E5vtvy++mGLXyp0l2hubhvxx1Py8Wx71/zPvjTUJBhsWiHNe6vdYOv+cQsQ81L/RGunF7b2CxWdvSklKvkhq6Ox8w6Bj4vLqJu0HsjWMxoD5KVcB+alhkkcdhjHHjyjwHPbRcqP3QVey9n+NXe7LYqX65lMuUxl6RIMcXgrk/x3dcTUw127A2cPnCXt0qoZLkICvPqvAopqs1hvcXW4tajznJPa8piD4/+keBbVEt467pFlfZp/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LEyOx2H1Mkb3udaVrvSfOOCbakUtWZgki3SMIZZq48=;
 b=LB0caVsTlFoupyZKDRLTzfKFi1DbEQG2strcGhi0Y6WZ3VaexqP+dTRizckCzACQeiBkakIceGmlcKjRBVVzHdkRYkwOXqSQvqtjNXV1KpaDMeR0pcKtzm8e6JhZknpPJztwjE75zI8ywgxwBTHrMRpXvNtXM9rHCHSKE/dMr1H+0o0N9VcUgk7tahVQMK91R9Fwe/OicBHqA1m3culybH7crq/6hLH2+wYw7sN1piOZH6yo8bjfJEjvU4hcpBdzBSpPRRQ/69wJaUWBpDm/0zxiSE7/ASDvW4/iRpiSie9qXxOv9Z/AcOo+XAHdbY1JtPxDYWD8/qmkIBwRlBLDhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LEyOx2H1Mkb3udaVrvSfOOCbakUtWZgki3SMIZZq48=;
 b=A2zsdgZhK1XZ19h+WZyXAw/H0wog4gx/KGjt3kmfznqZRGTF/vBQurOEBn4d3xOx0ABVcUlxVB2exU9k1raz5SosX5ivZiW+lD6SAKgxVzKxFdAnT9Sy0kUfA9RgQCqqMRcjbLk78YKD25UzZB7Py5+HulKmn/ESmgC2sleypxU=
Received: from SJ0PR03CA0365.namprd03.prod.outlook.com (2603:10b6:a03:3a1::10)
 by DS4PPF194C7D93E.namprd10.prod.outlook.com (2603:10b6:f:fc00::d0e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 21:39:49 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::67) by SJ0PR03CA0365.outlook.office365.com
 (2603:10b6:a03:3a1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 21:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 20 Aug 2026 21:39:48 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 16:39:47 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 16:39:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 16:39:47 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67KLdlXW1940503;
	Thu, 20 Aug 2026 16:39:47 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Thu, 20 Aug 2026 16:39:40 -0500
Subject: [PATCH v2 1/2] dt-bindings: can: m_can: add out band wakeup
 property
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260820-temp-v2-1-dd3f8cacc15e@ti.com>
References: <20260820-temp-v2-0-dd3f8cacc15e@ti.com>
In-Reply-To: <20260820-temp-v2-0-dd3f8cacc15e@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>,
        Marc Kleine-Budde
	<mkl@pengutronix.de>,
        Vincent Mailhol <mailhol@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>
CC: <s-kochidanadu@ti.com>, <a-kaur@ti.com>, <s-tripathi1@ti.com>,
        <vishalm@ti.com>, <k-willis@ti.com>, <linux-can@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787261987; l=1255;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=MtUAX8P5QjXWkwPDHFJRNOn+xrMC4pjcLCRTIp6meIk=;
 b=8IKKGhpPqiYcCYnT7yHwzSS07D1ouvX60jy2VRN6C3AywVodJtZmjHWBsqdMLZ5i2/D8pyoa2
 NioPlVWEUuZDtTR1ERBoiCqbC1b1mixiy4SEMVpfgXmgDUyYblQSB8z
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DS4PPF194C7D93E:EE_
X-MS-Office365-Filtering-Correlation-Id: f186404c-2514-4c68-77eb-08deff038f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|7416014|376014|56012099006|10067099003|22082099003|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	mhMzNVZ7dfmY+KP9PKEvJKhkUhS1jjKfr4JEAAHcqDuctbb/SHa377PRWoXGS6fHp+cWamqE0PdL496CRG+xqQmAQsR3MhOgh35286chfqLMUwkp8kugt0sXCVxrmiopLuxcwt0xwhpIZLCUzYv/uDxN18//rYyAdg4+wCxP+zfsHF0e+QOSsIDaDzWrFCi2anfuzaKhoYDE+N5lWDMRqYi//+g+SHki4WqGp5z4lRD6OLQhgSIhP0TbAqw07x1TcNAKunXQSowf2mS0VqVlxIYKy9ArsmlVV9leX6X8TWDdzdWPHPvsZiPgAQSZ1F3i8p2xsqtvh/PjTk4xeN9tCLaKo0zQN6UAHY3ZhVjuIQLKNCEh50vXWZWmpLwcFFvPI1ltXnjvXvxQjUQNWDn8lz8qnSasfap0+xcNKf3euakp03VUyUDERA8zqPoeOGIz5zn/Reyin/3JwX8Kv2mWNFwDC1agv8gC9tO40Ya6/hHx9yMXJcBEf2wif99S+46TtZvsrW1pnP5CWiyxnNSqpElRWtiSAFY5MRy5stv02F+2OT+UHoXQuOrfLvVNwRvJGjyshEWbDZoa4R8jmDO8KHUIzhVNbWFyDd79236QBqHiEHr/5mdRWb2X0IR42s7hvNQmwZtY5+Ug09jeeLMO4zS2oQlKXMtoVp37lyU4sIzpkCnQuAe5DMPb8ZSXurrDgKe6SzEtmZn7X8ocEn120g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(7416014)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k4yRSJT7IFhQMOFWGJFZuxfGDREenQENC6ychCc21bRSgp3UxsF+AsgyQ544OhsYQEBH9rJ2m88C1jPQmF79fzim+D5vywtlOozhgKAbWhUzhjCkQ90MNlwSzIkl0UtY1j99OYKklKsU+EePjIlfer2RP0kV8w9pH54/DSvYWdHYVbHrit2DEOZpz5q/5j1kkJPT5mZ/E++x33xdsvExXzPYGToESeeSElwsXhBZWqCY2q01XnlOl4Brd264j+uIJ+wyx2t0y1PMc7abSbU7zol2t3VlFMHog7/OFpwjwsv8dnrLv4dKkYPX2Z8kBYpvq+ycdD7cs57RaHRuHsWipoX36Ilbx0M2rKD8Bz+gXOXEpfCp3DedEkC2AQAIUkkQ0G0ul7oetNMG76ygtW2q/61rVjxQw8x09/iY9e4DT1A9bYBi8ey8nvQw63UW27Wi
X-Exchange-RoutingPolicyChecked:
	RbRXlxwUNtVEIh2NKDFvDacuPB+xfdfcFg6spSVx8p/XLrvtqCYWBCUAN7qz4JsHhvFePEKsUhCTr+gz3ucOEwSZIjoUCrUo0p/Fgor9MtPyAh03PRuKQ1KLvJXvO3jli8hyDLq3dNyWnMLvqhWDK5EmCOxqo71TMHZi+JQl1sxbFukK5r/IE1VLa+2dRBwiNV/O8wYfNx7bEw/LivT5HLmCFciT0TGZN1srj+rmcZxAqg42sRNzx/blad0188PtsJKVuxG49xkvk/UKKG0tvKg0X3atsUzezMV+HnveD0BZTVf4aGcjSbORk11bZKEqdO4wb7N+j8YsD7SFlZQe3Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 21:39:48.4632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f186404c-2514-4c68-77eb-08deff038f37
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF194C7D93E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX/nIMgHlCoaQA
 Ut1467jcFE3XQyko7WqOCWQ0AqkCAsGzWhm5pVeKYodP2HTnN6WpfQDyvXZlccdIqDZsCh5esuR
 s5oHeODMJYOosyaJ9mJzKBg34Jh/zR8YeAYvxZj6bE2GjOoXILGKJa4pLlwNkgPR8gHOUE2sV6O
 vcfoHssR6unQ9Fbih23z9l9Hrdg8fTR6gqN0d7vBssp4kP54O9ypB80I9O0vSp3NPDxbb/0ZHBc
 woXqbBw0DK5SF3/otAsSZnYOQRXqTKDaFk0V/CT+aKJ3tEHHAffpirmInlapYRzD3LmMD/ngUyn
 +XYc24sCko/2UW4/RaBiLwzBP8t3IN7BTWdCY+xEc1EcVZpWCk/djxooyL/QMiHKdN7f9fxDMEk
 gj4wBpuSSmoQv8Vc/WalKUnua6aBxl91EQDwqWK1cCxjfBcSJCV/uH+G7IQZVky4oSGCsWCLjCT
 GRopwzHtqMM1hEq7GWA==
X-Proofpoint-GUID: YiZQOXchO4LAwpeEX8uEAR2aJU-Z1ZDb
X-Authority-Analysis: v=2.4 cv=JprBas4C c=1 sm=1 tr=0 ts=6a877433 cx=c_pps
 a=qNvklhu79FbMMzLDwJ4KEg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=VzEq8f0E5t-KbXawafkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YiZQOXchO4LAwpeEX8uEAR2aJU-Z1ZDb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX/GESCK+Nq9ll
 RiYt1Q5hWmrXn+575wVcseyMqahDid6fJVKsOXSbrd13VszCNUbE7iMIlOEJoQk8YzdZrHs847P
 TJ9xWFprfwaj03X+hEgHWZfRE1R9YJA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

Create out-band-wakeup property. The property indicates that the device
can wakeup the system even when its power domain is off. The property is
only used if the device is a wakeup source.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index 2c9d37975bedd652b3060ab11ba75c37565edaad..b6cb945c225f168533f714b5db08afbdc4ebeb93 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -150,6 +150,11 @@ properties:
     description:
       List of phandles to system idle states in which mcan can wakeup the system.
 
+  out-band-wakeup:
+    type: boolean
+    description:
+      Indicates CAN device is out-of-band wakeup capable.
+
 required:
   - compatible
   - reg
@@ -158,6 +163,13 @@ required:
   - clock-names
   - bosch,mram-cfg
 
+if:
+  required:
+    - out-band-wakeup
+then:
+  required:
+    - wakeup-source
+
 unevaluatedProperties: false
 
 examples:

-- 
2.34.1

