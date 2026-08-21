Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F198F36F414;
	Fri, 21 Aug 2026 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328465; cv=fail; b=UK6nFSyzWUJAb+EUF7KXrnc8JwYwB8fWX8fSCO8wZtrNhl7kfmo5BUTm9vUpB19u4stjk88DI5BAGl1iMhHKzOl3xoVXN9WG+dZ7Ojp5fNitZinJG9pFuvxbEEZQDz2bbmnqrjHSLcYQIk6TC2WENxo84HCoQlgAdZ+snWoV+ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328465; c=relaxed/simple;
	bh=hpZbBUEhUg1bUxBjBn81cQ4iPEnkCpHU9ngrZUw0wzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kmtkFu9M55t+DecgX/uwM9Enweemz+eLu5EZpXgnGqvlGH7VlVg5GfC11AQgoDufnbIEork7dBo6pcb+ttH9VDoNSVmCN0+OuYAKXm4wtFrj67K8AbKlGqkv/kgXz9mPhHduYbHcGaz6FkMVZgWUW00Mg9MUiDmS0wHwVe0TcV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=BXLtkhvG; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jVEXA+qV; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="BXLtkhvG";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jVEXA+qV"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67LFoJAC4004523;
	Fri, 21 Aug 2026 11:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=dxBV57PDhRhixlJArVTFjDk6C4okhgJKlzErLVZ4o
	Ps=; b=BXLtkhvG7VYh5w/q2WCa9LzlBV4rrY6MMuD4qhaKZq2Om+/tW3xoqJ2//
	JVPm3faBzJiwz2obWS/xzwZNF1VaCZXwrBxHKv7lPEvLYiJYnDHgipoYEoQI1+tq
	WOtK/Ksc8pmrTZUVH0rq+e3tIg3B34jHhkmCUwdROHvOUfXupSo8MRyfnxgYqlkI
	jt6ymC+HtO5wK8EoM/xTzfk0WHWLnvHaNLBm/05XcwmsqN+OnorMeX8Wk4HQ4gvh
	E7s+8mMW1ifV3SUYz6LN/eE+wL4OpqPdKjV7TBomDPEClWghVJUUrNXP3dIL6/OW
	WnyQwhZd725tyPCQWlDZDpzALkIyQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g6hfk2tdg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 11:07:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8x7zlt85/E4OlxBvpUiiBGlHW91y74DzCyPpLgw6BYKekAkovEL19ZkipDDk1KkRs1Xx96JnbGOy6PHV6hoe7c/P71x6heL9VtqD8/KEiVujf+kfZGgQtmFzVFELGmixIx2B6jJz9eNJfsR/xrM2ydstNEAPAezbmry/DncEau515e82kqx6cGdM7d0O+XArvcteAUU7Rcnu227TXrWO6usIa9N4PFmsKocs+mW7NrieErCKfdIW9lHEmnuhAKfC8khHtMVSyz+8UbcAR/tF5oaZcm3ber5/DOvK6MtbLQuebUaYzZ3PxHvAXVI1VeTWAOA+5a9arcGHZYs5Be2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxBV57PDhRhixlJArVTFjDk6C4okhgJKlzErLVZ4oPs=;
 b=YyaSeuQottAxEBKv0Fzr5xtdFM+S+8fj2iEYgstYQJs6uXblDxY/f6Zgpms0us26RfTvgOJgy/BnqA0dIVFv0afUXdFfx/Pa65VGEA2crQEQ1p1P6LmW+bwFlfLJjoCWWmYViVegKDRETSCfRsLgnPO3QaK8luqwLU5ome+6tvd93FquXoWxh+nHrE8fPHDfHY7574O1J8+7EtyKq1HUT6ecyjOfMxFZqvSgnXrgohKCeHH2WRz33WdWm5LTBfWv3TkytcGVT8Wk+1+PpWD4WjnlBSGUv48OURz54G1Io9oNSkW4mp5ATeDHwPJ+qAn+R0A3o5YSZMY0t3/eX/91ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxBV57PDhRhixlJArVTFjDk6C4okhgJKlzErLVZ4oPs=;
 b=jVEXA+qV3APxclHCSejqjN0+VLL8bF3LHNOBF9GRuxJtXgNYvc7HuovM03nTTeG4fPMOTnSYu0qYePxcFgfMeYMBSa/hXxgHyxT6Hh2//C7OfGC9m6jfPekqTnRWCwIbSYWBTn/mpO4kZMTZjotBN66aJXqDePuV+TxoMlsHiyw=
Received: from MW4PR03CA0292.namprd03.prod.outlook.com (2603:10b6:303:b5::27)
 by CH0PR10MB4939.namprd10.prod.outlook.com (2603:10b6:610:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:07:17 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::33) by MW4PR03CA0292.outlook.office365.com
 (2603:10b6:303:b5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:16 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:14 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:14 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LG7EEc2409002;
	Fri, 21 Aug 2026 11:07:14 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Fri, 21 Aug 2026 11:07:00 -0500
Subject: [PATCH v3 1/2] dt-bindings: can: m_can: add out-band-wakeup
 property
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260821-temp-v3-1-9ac1f8806929@ti.com>
References: <20260821-temp-v3-0-9ac1f8806929@ti.com>
In-Reply-To: <20260821-temp-v3-0-9ac1f8806929@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787328434; l=901;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=hpZbBUEhUg1bUxBjBn81cQ4iPEnkCpHU9ngrZUw0wzE=;
 b=ipB7o3RkA6ohhnyhyP0q/WO9pOLhfxffRooZmNGUpW9zf/Muz4cm842O4esfwwjQWE/yxhI8x
 Ab5RHAcAJVXC0B3StCBpnJKbPNpo/u3tyj/WRfyt0IaDYE5J7W4ds1v
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|CH0PR10MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 54247037-54ca-4776-cd7b-08deff9e456a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|82310400026|376014|23010399003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H5tv/F+sjVXjGxF72NpCCFH/kWHGI3C2eHiYzgGgYRZG9akvUXERYNJwiH4TrDarhYBojSjWDGh1H9MiC5jd2uasXwfyVpXH4TMfmcWu4aP9wo9duoeQISbGuDZYbJisSxxPwxZswkIF3rB3B5ZQFznqYr4fVulvK86DNx6nRVLagImepHnjRn3XKni6uNH9M69VGrD+ki9S3Dm98ic7dIfDdGgZX/cWACiMeBGeEKPY9viENyEw6hs/NFD+/6g9KR1hOa5gQN2G2xGkUGsWeAju83nWuh/RPyFQ3LHJefw/jG1KNI0CceIzTXHrsZtHSlgZpt3JhOxoTo3EIXmU231GuntCffofo6udbDj53h3CzKcMbPcEbu/ga7ODrtfyR/DV7UiT6k4WWt7faq1+xVG0NB9o+8m4HQEqPd3IArr/5uv7r/qbIpywcYzb1CUks8D0mtrZ4OqSAc8C9WuD2cJOP66kFq0jUQu/Aprplaw6R65/jW9PiWQxYu6xoHCGJPCVBPDJcZvki1CTXD0Z1QK9Br6wKGJzuZWIDTUEUBPXtKYmKZAzNTNbNHoGzaD23HEtm/D5/d62wlv0YO3z5AdCA0t1XdSl+ZT4EA437eXlvIDrQ9iQdIBMqQ566EhMQbTGVx88BvQyRSUyM6bHaDktE5W2yM4oaD9JZQnWIQXH+fs8hxc/vA+lQupmkHsqniEEuiMiOLhlpBveb9RQ3g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(82310400026)(376014)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yYkokSs3DZSfTqTSmEI9fMMzmR04ojZ/xMoFfPYLxjXrgPc6zKrLNBmq3BQ8zdL4dsWA1cyQBI71P+XHcRdLzc0zNirgCrYXm6zpJlYjw5pGXODIrwO2ao1xRJxZRPcaExZ9Plqm+sVg2I2EGE9Sts3wsnMz+eK1HRKB0Zl4rSSs0yH8TU68faBZyy9RU8oK7mJA3uMTfRo+zbS+eAOGK/I4T/7JnRm8UpkNKXKq+NTPnlEmiEK1BIR3eJhNvGFJX8Qlt+/187UnXhPodOewDd8IxPMch+XYeJ8ghLVFN488dERs+XP2OCiKeb/B+TxM3iTmdkOb8RpcB9lLsJ/VSHWJPsDwM3ejlP1uKS39uj9VBgp6TsMC7wu2PyR+yv6M8Cof/NkbBiTm1KFHQjFj6WPpmKDPVuCuAcHZZxa/4PaGR5Zp4U7G3Dsr54CdiDE5
X-Exchange-RoutingPolicyChecked:
	U8T015/1srmNLGQUM7NkJodiNwGKIuDvBqmRG+F+gi2M111eFBvLFTnfbZAotRxpRj+OVxpuddtFNwBxaf2B3R/vnJLYvSqp6mZzSTyuclw50x48NPnH9Q+fxRhSsuUam8JKfry2UUk+HPcuKy5U3ojfwXkrcbjrxIBpaX4FS0M6S7oE7C7sbdDpgnWqkm/7rYMqHO2RS6+zVV0dmC12af2XeVDXhoTnIkkJeWq5oevGWWa/vSJZi0RwQ7wo2KYqjZkw/3K6pPCyGTEZmKh8yDWWwqBVqjJExcMoeiTO5sYVHK2J9nPQDWmi1EiMBYfovv/4ybiHBvOvTLIk83DuAg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:16.6436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54247037-54ca-4776-cd7b-08deff9e456a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4939
X-Authority-Analysis: v=2.4 cv=O7AJeh9W c=1 sm=1 tr=0 ts=6a8877bb cx=c_pps
 a=wVrytDogCwW2gNy9sPioUw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=vAQvwV25VcAFoIRaZAYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: g6kuEQqNoMkSMGKRdCKWxiuAtRO9XZ9P
X-Proofpoint-GUID: g6kuEQqNoMkSMGKRdCKWxiuAtRO9XZ9P
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfX0VuOJbux55yP
 kiPp+vSu2MatKESS6XPngfI5ugjRa7y8JWc93oYodcH1ySCiBgazULi9fr30/gorayGJeF2PgUD
 sKYAiAyrBYXlZM4abrVxzKHROWBCpQM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfX5WEa6NDShD3c
 sNPYLpE1SoGjo2OZKnW5cbyO8XRYoCICVBJ+KDWf/JvOFyDbkROa5ZcIhmUISiPzuTGArVUUz0w
 HHyyJ7LgHqys5nIbUwFtoV4Ho/XcdjeLOfqQzd6D2TB0xhu97Bxks8RG05URIQnYM8lpVV0V0o4
 gFyL5tp+7RAkj2uyBg4C8uGt2bafhLmwGWTKaYLg9unWfsxpjVcuoPuALnjuX/fGYS6IlICAUan
 s7yHdOAlq2kIzO6cEO5fG/UvW+rpl9eSqk5RjuJVJfvJGfdWOKGpUw7EP8V873CQmpxz1bBEUte
 bpY4mPRWuYE4aKDWoyO+uRRceRtRpZbx9LWqm5y7393Sni/e/C+3ra7qwu18t275F1iAt85Zuyx
 PIzZMhQpD6fy+KXEcO5xU4JvMtZCNarAksyLVp27CCe+TR28GoM6d/gv0Ep9FOY3AZ2M2wzIjqI
 AJErsmNwbbEq3GNk7ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210126

Add the out-band-wakeup property as a possible property. The property
indicates that the device can wakeup the system even when its power
domain is off.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index 2c9d37975bedd652b3060ab11ba75c37565edaad..0663beaa532bcc4a71cd6ad01520a4dfea294d0c 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -150,6 +150,8 @@ properties:
     description:
       List of phandles to system idle states in which mcan can wakeup the system.
 
+  out-band-wakeup: true
+
 required:
   - compatible
   - reg

-- 
2.34.1

