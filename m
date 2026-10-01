Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F821255A;
	Thu,  1 Oct 2026 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872592; cv=fail; b=rLfocRHR4mq0TSp7VnFyek34IBnp5cr70Jj6G0HxyRKQwOzV2oec7qiFCS7oLPX9rWYDOiqSjptUizuJWbThozX1yjZa638qfGetu73CvD7XHWYsQIdl8OGRtIRahaAs46nCFWbCIohDD0KgUjR+3Z91TrSZLcn8to2GW1k+1Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872592; c=relaxed/simple;
	bh=An+tGlk3k9I75m7k4TL3FsLQeqlMY2cMHiwy4tMrKD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LYoZexbe+e5GAqHNCqAtEKJnjsff413xhogUcFYdco8dI9UpC1RnHwwnRbWVdmNRyw7kBq6X7XMBNvYJ0JydAcZhfibKAvZuhtwhJ8/TvtrKKhEeTOgcvEZSCccrubkob0mvW1iPS68X5na/tFBJ8l5deUvGHzHzrc1eP9J3+Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=FiI6NFoJ; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=U4CfZXsS; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="FiI6NFoJ";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="U4CfZXsS"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 691FrqBN2132915;
	Thu, 1 Oct 2026 11:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=YVuMC1IX8Bsad6XKm+3z6nNw731tkYxmqzRLWAP9f
	gQ=; b=FiI6NFoJwp+j5NgJIt5YatH7/wFqnIdHTPRv6UetcuLlJgp1PahV3k6mP
	5NUvs/vUEcLioq/3OOaA7RvsGkfhxpGaJxsuVi6hGZ5S1OuS8KvxqoQY7QARrglj
	dceZmeiXdYXSZmwX+DluUOVqfPlvxGhs7N2e+SPLmhdDZTMnpnsJgpG+dJ4MbeWU
	ydmAgLRtp6Yw/AnkR+2EZ3YzCWHvP9lzuWRrSaj/Z/qYnUIEqgSWVmWH9g6+K+v2
	uSDCbhgCAIXgloAlIWzw14xeu5GdTDSTXDiRKjga7hjo2jCUdgRmre8C2q7dO7V0
	56Lfz3KLSt2D9I4mPiqSW5CJ0QLug==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	by m0380145.ppops.net (PPS) with ESMTPS id 4h1kqyk37c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:36:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYWODfwIV1j7DmLPjdRdqIMGk2kRY2ODkL1zDWCzXA8Sz5+gygZj4m+3MDHAICV+9VdVbHP0/O+/Gvhg4TflqqnDwUohmoXAeky1KyHl4ntOBM4oYEDFE4Df1BqCATcRP5xH1demPis0sg5kIWHxwYCnToxom2t6oFJOVx/oTqgYpYTS6D73uyZ4oS1HRPvJQkqlACvRmrDgRPVPvkXMD9EITbkZkzeXH0SUSSj/9QD+GpDUbYyjICAU8OcJAM7C57Y8m9NDcBOiowYtOJVaiHqIIMrRzvU23PqZaTyq5iRL6OhxvY+cOIY0XpU033WvSu7D6tIKzxhvtM34nhUPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVuMC1IX8Bsad6XKm+3z6nNw731tkYxmqzRLWAP9fgQ=;
 b=XWOC0Dhsn89CTYLueF7c8ZCfFn3Qy452FY5EA5+lzEessM0CQpZ52gSkplNHCJ91I6Rh38VVTzUl/FSGbUSED77n9j/rv740iyAR2da2eLElFGdafmK9uFzE4DwrQqDi28uBL7d6knKtVgZ70u+WxPlVvOiUPD5ER/BZzUN3XQfP6DPKH8MdIdRkaGwRDLB4uvI0d4zwK7FzPm5i6Urt/l0gTmsQH1VkT938JnaZdHI+MBwwU+M5MxSbJp/zo1WsaS73rdFmnEA3+pggZqbyDlhsZ79v0UgqmrluwaS1Y9QJxgKsE5z1XksEI1A9SA52h28oGZ8QC3h3mJt79gdnDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVuMC1IX8Bsad6XKm+3z6nNw731tkYxmqzRLWAP9fgQ=;
 b=U4CfZXsS6ksZFWPl37xSjSg4voyw3W+MwLz6AixjbFJq8TFlcl4yDbKQ8DPdXNY8i21atMEAu0feB3KfcyduIqy648aJS2y0IEhtd4F+uiIK67lGfhhIvlcb4GXof7fb9F22OeKD0//45P6Rdv8Mxu21ZGSA8gsajblNK8lsOf4=
Received: from PH7P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::30)
 by SN4PR10MB5638.namprd10.prod.outlook.com (2603:10b6:806:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 16:36:13 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::a6) by PH7P221CA0022.outlook.office365.com
 (2603:10b6:510:32a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 16:36:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 16:36:11 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 11:35:28 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 11:35:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 1 Oct 2026 11:35:28 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 691GZSap2285140;
	Thu, 1 Oct 2026 11:35:28 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Thu, 1 Oct 2026 11:35:24 -0500
Subject: [PATCH v8 2/2] can: m_can: add ti,am62-mcan compatible with
 out-of-band wakeup support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261001-temp-v8-2-489dd82e4b50@ti.com>
References: <20261001-temp-v8-0-489dd82e4b50@ti.com>
In-Reply-To: <20261001-temp-v8-0-489dd82e4b50@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790872528; l=3607;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=An+tGlk3k9I75m7k4TL3FsLQeqlMY2cMHiwy4tMrKD8=;
 b=UFISNTCte33M8ojhdAW5EToZyLmMO9Cuw1jBiInWNpxFVAFeHC964QSUq8iYD9gXdUnS3Yx7Y
 sZ5b23pHm/0Dyg4gvx5I/t0hv2d7+jXdHDBFhR9Yrm3OXnOalNsVFU7
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SN4PR10MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4bdff5-83e7-4b7e-1d69-08df1fda1a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|7416014|376014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AtaEUBRnL+tT/KKqauxQHwGe0lP/n3rwWqBHTnPlngP1z5Z4C+TGPh2y7y9dlzt/bp3eezslYiyQczzyv2GTHVAM9ecCQC/VfzTYkxsuaKTkU8j5ByCRUMsZGuJjzAm/I8d46VmWUPsj5pStp22az4ah8h3F5fmEPF2OrbfOz8KRzlq7oG+U4rbwL7VAvbDGub5QjggsPRPKeFFTEJRXY0jPI94O6828cNOCgZgQjxk4FlIjxB3QdoTF8/5+I/zhyha4lm9wARUl6IAFe5hl2bsTm9cpbtqc1Ow6J6K1gWKiI+o96ecO6NSE6GRihAK+E6WmhZkn5ZLySNHu8/J/cdUVm9wyqFcBsyE7G2LA94IuzoGfi4Tg4zA27RrhE6Bk0a0umGKFOONq1xjkXic3x/nj3cwhLhTsfJ0NPCu99F/5MATVoSTyitMBk4pXMY81tvYphp29IVfqEdmhj1bk8GthG9hNwTxKZ9M2pZcMd88KI3VgKDk5UXTKTBK+fFyuQleEoqQxNpSGdEKQxrwI8yWGmgrREScfeWbG/UB7Wa95YOuGCsbETHejFIoMtWSYW/0klyIOFTjIOTCXQJqFddq2PGuQ5CPVWmvr1bGSJ36lQ81yD/MFw1HSae73aPIrQ5a8RLfSl8lIOGN8BeVo4n/KjtvpJQxiTPQsYU76ZULyjMMiEGRV0/VLXJ9pfsCCutDviFphia78zdMIjwEqkA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(7416014)(376014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9FaMR4dm2bFQkbzYIDrZQGGdApisJy2x7bXUgdIQFtTGcLnadmevGRjODT2WHB/kDD4zuOiCbH2KEY/rDKaNVH1gaGMIeGNRNVkgIUr/QJvLGcyzL/bfHk+leJqHeddDd+90fg3KnF6QGNKHz1jXNTRAQGRomIPEPPxEpbMZDmi2N6TwmOy5crnJ/0nY+Mzk61hpqBKw5JrfwhUvyvvdtEMsa0GrJkBJ5FLv82BoBr4exvy8FMLvOSfRKD5dcuR3P2E1hJK+fRxy4QFERKPerqDDPSz0apdNPU4U1B1v2xdO7mpS7i+enEcWFoMEeMyRJyAQG0itFPMBNG7DmJCBG1cpoO7gz7CkZ+mctGffd1LBwoQckt/btd/yHQ5TkiTcK60N4zl9Lti7CT4yzOUnCqxc7DCO/YjVgXhwoDk+JPm29c2VByE6jiuym7s/i3yL
X-Exchange-RoutingPolicyChecked:
	LDKQWnVHvw5cU21BwvsMBtni5UQC4TwCt78GmuQ1gyqKipIZan35pi0qkSFUKAnsFUIxbbpOKYeX450YiOzfjbqVDliJUvvy73XBAUvCHrkZRfylQUGv1zkJOePmNBMjqVwTYafc4Bg/CvvqRcDzdtRqkAPLEBEIG4LMSJ1UK5I4ofiI9mGFhuTnPGJLLDqIXnz1zvx60CMi+HK5xXPrI3lmIkvGdviBM9DhE1/ScZjyK0uK2p+2TtPPPq2Z+KuxGNyBeUATtlAFuzlc3kRG+gUna3kakyRcIU6623tMaY59BaK4YhjHXCxY++jSj2hh2iGHuM5aNFp5dzfH6/HBxA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:36:11.4902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4bdff5-83e7-4b7e-1d69-08df1fda1a68
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5638
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfXwok9Op00r472
 k4Nkj1bs+NwfiCPjG467B9WeVYFaYFrZz1KX25OJtY0WAygqCdo3vg6a7HiNcqhoNqJ0Ww+Jdsp
 8tsv33O8fm2d5++K4fgWu9rbciOsXtA=
X-Authority-Analysis: v=2.4 cv=a6alZkSF c=1 sm=1 tr=0 ts=6abe8c02 cx=c_pps
 a=Ho/Krdd5x/ljPkV1+9yTnA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=q7fBzAs-YHYjZ8l8ll0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX1Ex4qe4Oh9Ys
 yXcNF7GNyBchlQ8UWriJvwzI8tPW28/tvVnf0w//Z9v+xKFY2OQQ/3CUhfx0beugaj3TxxgL/R8
 R/1aHsoMtSKWIQKaZRp+jvKSgk7vQzzVBaJ3b2ecvx3j7HmAAoEDGNfrEfDhtm+QxhAhm/tMXYb
 RwHt2UxeoPlK8h6JvBIhvN963UP09CXbGPIKncYMUjh9c6EDtswpYipEnXD9mAv6KwaJ32hrlky
 ZjXnF9/Q8XrFeJsHxRY4zMe+uXUwOpUr3fod8SxOrwkyRfKHjP7RrB5/6CNV8nfUkazV96gjwUy
 W3ZS4Vvb+wp704YF3BOwvFM7yanoPmFLGRMoYqs5dWDnAOeway8WhwT5KxSD9TbcLIdwoLWW2R0
 RrWhRHzqPJKRxaozQ6fxkrNrDUvaBr3Bs/vp/q5V44t9mYwkq+DBEN69BxqS2ednivKRzMNJTbL
 PpG7JKnP9UZfOFSsS6Q==
X-Proofpoint-ORIG-GUID: REUEReJXLBeve69X1pWgC5vN9oG1W90o
X-Proofpoint-GUID: REUEReJXLBeve69X1pWgC5vN9oG1W90o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010066

In TI K3 AM62 SoCs, the M_CAN controllers are in power domains which are
OFF in the deepest low power states. However, the m_can pins are able to
wakeup the system from states where the power domain is OFF through its
out-of-band wakeup functionality.

Introduce the ti,am62-mcan compatible with match data to identify the
out-of-band wakeup capability for TI AM62 SoCs. During suspend, set the
out-of-band wakeup flag when the device is configured as a wakeup
source, the "wakeup" pinctrl state is present, and the match data
indicates out-of-band wakeup support.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 drivers/net/can/m_can/m_can.c          |  6 +++++-
 drivers/net/can/m_can/m_can.h          |  2 ++
 drivers/net/can/m_can/m_can_platform.c | 13 +++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 91a0c5eca260c19fa97c6f5724341cad0c1c95b8..ab2e869df62de00bfd2a475f38c38cdb703a5962 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2628,8 +2628,12 @@ int m_can_class_suspend(struct device *dev)
 		cdev->can.state = CAN_STATE_SLEEPING;
 	}
 
-	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
+	if (m_can_class_wakeup_pinctrl_enabled(cdev)) {
+		if (cdev->out_band_wakeup)
+			device_set_out_band_wakeup(dev);
+	} else {
 		pinctrl_pm_select_sleep_state(dev);
+	}
 
 	return 0;
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 4743342b2fba3823819b9e2bc5b085cc0fe6d1e2..7b5466b02666a4e1d327e3c8d8a4b57efd0c6eaf 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -132,6 +132,8 @@ struct m_can_classdev {
 
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pinctrl_state_wakeup;
+
+	bool out_band_wakeup;
 };
 
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 51dd41dbf2c9a971295994946e190ec0187addd5..eaa76c98ad0c603ef9b9dc2b78863217d9c62d99 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -18,6 +18,10 @@ struct m_can_plat_priv {
 	void __iomem *mram_base;
 };
 
+struct m_can_of_data {
+	bool out_band_wakeup;
+};
+
 static inline struct m_can_plat_priv *cdev_to_priv(struct m_can_classdev *cdev)
 {
 	return container_of(cdev, struct m_can_plat_priv, cdev);
@@ -83,6 +87,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	void __iomem *addr;
 	void __iomem *mram_addr;
 	struct phy *transceiver;
+	const struct m_can_of_data *of_data;
 	int irq = 0, ret = 0;
 
 	mcan_class = m_can_class_allocate_dev(&pdev->dev,
@@ -148,6 +153,9 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class->is_peripheral = false;
 
+	of_data = of_device_get_match_data(&pdev->dev);
+	mcan_class->out_band_wakeup = of_data && of_data->out_band_wakeup;
+
 	platform_set_drvdata(pdev, mcan_class);
 
 	pm_runtime_enable(mcan_class->dev);
@@ -218,8 +226,13 @@ static const struct dev_pm_ops m_can_pmops = {
 	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
 };
 
+static const struct m_can_of_data m_can_plat_am62 = {
+	.out_band_wakeup = true,
+};
+
 static const struct of_device_id m_can_of_table[] = {
 	{ .compatible = "bosch,m_can", .data = NULL },
+	{ .compatible = "ti,am62-mcan", .data = &m_can_plat_am62 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, m_can_of_table);

-- 
2.34.1

