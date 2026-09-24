Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1DE4457C6;
	Thu, 24 Sep 2026 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286925; cv=fail; b=PuyzoRPFkAGjO/0tuKjjQ5axX/PDw9oLpgXURJxROXyO2RdFyG9EeZRDa8oSs6lvjxzzURvCT4F5fuIoJ05A8K6w/25jOZmsumBb3YG56HVD3i+7KJUiIkma/sYveHl6XFNZeFq0p+KRcFkAwBXhka0VyKCbRAYQlgoS+rGP1dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286925; c=relaxed/simple;
	bh=9kJNhrnBNSSZr0GNgzQSrJwJfikalNYUCy3igbIupRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ICgAc1M5SHjXxhNdMBjYwjVskT3v1UuzNnkPsoaHDi54BSjX1mkh0QUPSdcrz2MnqAe/7NxjaX0jdrxM7hcH6h9DKyi4Fz8k2okgIjzl2C1Mc1Wono4UHvq5feC0k45C6NgWBFKGzUsnII3facPOHasREQFodfsyHOYCuDLJhnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Fl/Dfdpg; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SuA/qamE; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Fl/Dfdpg";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SuA/qamE"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OIf7os064553;
	Thu, 24 Sep 2026 16:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=TyMWMRgVmuopD23N20wrSP2QWBfFOsn8pGLbQFYzh
	oQ=; b=Fl/DfdpglOfTrfZ3R29G/tRb2ELvPqBqSswzquMzZkYYpJ9M1UvYGddbd
	NXjP5dpPNvPxohvAaL4L0T1ovTZJfkQGWLX8mkUxAp0dGEqIPVcoUAaiktRRzJs1
	81a/TczGKkWKyCYQjgBdWN/19os6H5sWaXIodEAkeCvLxmUzJ5QN1PL37Zcc8T/V
	oZ+IG6UnlNX9Ej714+RncTr890tB6J7PPCYbZAc5HQr5FSLZ2XGYW2z0f2qRG10S
	LmLdHmEQLtL9420PrjrHX5U2hTQkjhN6xeSZ68J5t9HIHkF4QCMYjnSQo8vqKZ8a
	t7Yi5zcS/aaEfaNeS4Jsg9pQPpuUw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gvwm35mgb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:55:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j92Sh7huzILlqWIQYhpQdbuyWB3MlZuQZtX2ckDH6j92g8wTDlxa4ORhiQxsuCSEjhNnK+YvI2N/gBiqsNQqSMdYM0vmSlcd1H3xbY9KYQYzQLunO+Yedokq2GVRVGXS21p/qfoc060EssHDTCBDh2uGhWAzNwhmM4J/dKCiJvmSeqrGpPFiSfgJpY1hLQXvnpbGASMvlLK25ygzGTW1yvPjabK0M50FFyWwwHIlAdMf0NpoF+5Mqh977ocfacx+inH4rE2DV/sdImwPd/b0NDJmnyDEJJZMqWtBlABqDfuBZET0XO2s7w+vG6mcNaWatN0siMOhyW3OUX29pbVdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyMWMRgVmuopD23N20wrSP2QWBfFOsn8pGLbQFYzhoQ=;
 b=ugB3x/7MYot9HZpxMMgnDMEOtzENTbWniwAJIvu0xcwHTc4Eaz+NLTmL5m8JS8etSA937JUVvPdApwApusXOZDp4wnolW/8Vd9aMNK/Bk1NjWe+L9BpCN5/stePyTFq7ibFLnTdE4SBp08L2NhzcP/Wd020IzGh+4PpPxn+4Me/VdkXePWAAbjwq9coDn0BLiFm+2h/VmIpX6xV6uDU3TwqsgnReFk+OvdLB+BHA2za7xF+xGM0C7goDfpJzbV1ghwoF6oUvPt/NoVi434bhcZTvvULFZq3vuqF1AKvmPn10RNy+T3H8gw1j8EXHhoBhZmxVZyxlIXceAMuZEqSrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyMWMRgVmuopD23N20wrSP2QWBfFOsn8pGLbQFYzhoQ=;
 b=SuA/qamEbsyv623V//Fusmc0sQ6I4fuo5JbL7jm3Qn5D+R0vfVI5BuEMvcoFArmLjH2oEKZ6dg4+E3KbMQMsU/gt4QuUIIRM7+LnwAdXsZ1j+BsDNlU+8fGMU37BUIQZz9wcWYU6zKPSmhg0HP06yuAZYHHYjYPxT2qVcvVmMb8=
Received: from PH0PR07CA0032.namprd07.prod.outlook.com (2603:10b6:510:e::7) by
 IA3PR10MB8420.namprd10.prod.outlook.com (2603:10b6:208:579::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Thu, 24 Sep
 2026 21:55:05 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:510:e:cafe::18) by PH0PR07CA0032.outlook.office365.com
 (2603:10b6:510:e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 21:55:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 21:55:04 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 24 Sep
 2026 16:54:50 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 24 Sep
 2026 16:54:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 24 Sep 2026 16:54:50 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68OLsnvk1562647;
	Thu, 24 Sep 2026 16:54:50 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Thu, 24 Sep 2026 16:54:31 -0500
Subject: [PATCH v7 1/2] dt-bindings: can: m_can: add ti,am62-mcan
 compatible
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-temp-v7-1-f40defe5957f@ti.com>
References: <20260924-temp-v7-0-f40defe5957f@ti.com>
In-Reply-To: <20260924-temp-v7-0-f40defe5957f@ti.com>
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
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790286890; l=985;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=9kJNhrnBNSSZr0GNgzQSrJwJfikalNYUCy3igbIupRg=;
 b=FjqsfuhtaVSZaHK2LcIlSxxMcgnU7+QWeIw8cFOlaxTnh4HuufsV4Y+DlCrsOuDk4MZFFiJew
 REGV9j1mUr5AFx748+f7yuKagpeDTZ12zVPIQYEV7fGI5/B45fu1j+1
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|IA3PR10MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a2f8327-3b9d-402d-db32-08df1a867d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KW5V723NTX8jH7vpeYYKXwwgjgAVkl0puixSJtGQ0FO+Y4Vz3ZnSBy2M3eYL4ok1ymesuU1x1qZiMhpoE3SPlkRQNwPJOuIFfGg90XwYAFhRyczZlU25zZcBrFGqUvODjm6w7aJVhZ67R60W1nl5Z25QefeMwcGYIUYORv+TYQi0Yj+6WZlANzVeptMUNk6mFi8ZKUkw430pZfiiZHXd/xhoLU+OXoaVJZm8+kPeN8xWh5EaJwmtDZerF4aUI/sAOX4J61hFlOJt4SdnnNOovQj4bZhZsWsLxRoKFpvyepVswCP5nBISx3nwTjSrauVmRSJUFveQUUtSTCkFi/d+TgLRjgLqGBvBb59s5GCe+qS0xNpAk25bCBjIEFVFE1hcqPjGXWVfywveRgsqQ9TbGTfvjEs13YCpV83ramwBspqG9iaVzM4sD0oAY/Y9jSfruakSmFS3+DXK2UuvgGw+DdE5XugE7eXG3drcQKGkCtCYYWivZ5jMHAMxeGDP5Trc3SchPor2rg6FWNJUgD8ENMM5GaULncqQj5Co86gIdGcC7kXFAZ4A/YPY6aOezRm6v7oicpfGjBDQImotxHrtEo6SXauqlMp6x1fwlNudnSQfZSXhC/UIGcUZJOR0bZh2MfcXnyWz2WL4E3gNPjAGE+dL7egLKKQ2nq8JXySePlxTB78EsNB5uHIJwcZpybdlZDQUuz2yx5XmDXxMuZY0mQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KnH35YbqTRiOLvcgG3gKhKZIPrY/G3nGFQWLM1GIiX37oZq+HGXLBfyJ8cYPjjBAe9lzXLLuPH4A/777Dzlh5NgAiWjS+jYfAKX/35UhC7SWMMg7SHDwWpTA14d7EWLBLNAX9gHNHXqsS/kLcC/kyCJIMabCXEVFhRdeRd2BrcGZtHF/v/BbXeWcypRJll6MJ3q/oZXlDou30CzQvh1++J53PuTcoidMRtiNCg3k8JzhOsZFteTTk8EhouDrX+j1BLyLqqmH4dOmf6Ktdc53/EIDp6DPl08aDn2Kiw7M9oMoIOQdYCtD/677tgS0nZcBJSPZXZvABtOo5o0/KC4UsX1Atvu8cyG0kZyVz6LsIjFEVyCjcCiYIBolGE37gKxWNjVwAw0FNUWBzpdzHKSYOZ8z5XAHwmpHLYrqaKY+7Wf53bkh+a7Dm/BQvkTmTOJH
X-Exchange-RoutingPolicyChecked:
	BPHhZnkxYorIVkSbIdPeJU+7nhgNk+SNgZK0MgdCOxh9gwuMG6esMh4f4Zt8LPbQ8ug7dTuPQlYs4zchnOJFGuFmHNK4jMuB1AJqS5sHdW4FqY+U1zb3MrQk3SGf5aMvsWD7GJ2hFKjPi6Fw360XYpUIjOpZLCGHiAhLadGGQFzfIeboN0PXlTh/DNk1FleqCJibv3Uhq5DGTzB6vT/c9bTChCMHS7dIEkpqeyS53MGS0Z81KJ8LeWfCld4WRFa2EdsDqklJoIjH/jN6buA4VzP5ABEY7sJcF2K/mBpX8zOn4NiHLUhWQOqqx45q7dVIjS0uly6d58shfCs54SG8MA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 21:55:04.3030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2f8327-3b9d-402d-db32-08df1a867d84
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8420
X-Proofpoint-GUID: -GJwwjGVggzf9TJ1s0XX41hRo7Wc_u3O
X-Authority-Analysis: v=2.4 cv=EvdHPicA c=1 sm=1 tr=0 ts=6ab59c3c cx=c_pps
 a=fm8IUWXzr0h7QqFIpCBYEQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=EUspDBNiAAAA:8
 a=sozttTNsAAAA:8 a=OmYI-GrVpSx3wQj1XFAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4OSBTYWx0ZWRfX0LK8Rj3stJJa
 uKYgiYOOEgFHng923oUt9lIClBcGfRvezgJp3DSv3WP6L9q8yAubUpu2KobFqPo0fX7Kj+d//7p
 hnNk85MoYV0e4gFNMl5SyGu2LN88JOjSAMJWi2dcL8nuSJqn9WaJ5nkgiubo+l5zOrxYKtyVDuK
 ETtNBwm8IlMMt0H2TpbsshZqCsPejw3Lr17TP70Wp4DZq1EecT5qOVwbh8OqmdUHFOvKXSV+lNA
 qUhm1RuKx0e0qmReLD5K2tT+kpkY5F31H83u2l5kZTqBf9HCM3bOgi7+yrfSvpCnaCIxlkUwYXs
 ZYdW6dXSWKfdjJ1TDAq1Q9CflzvBXIuhzVGgMRuJBuOBFubJd1QYcXyuNPls+jdJsAqA7J/boq7
 jWRfKwTpxUbhB60C/t7POCWbBpmRgXZ1nTd9avlmMdea+en4f0OFvysqOQleI2/AMKOzyDHw0yv
 7tpoeNKBn1jknfzfpjw==
X-Proofpoint-ORIG-GUID: -GJwwjGVggzf9TJ1s0XX41hRo7Wc_u3O
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4OSBTYWx0ZWRfX5DbmbG3Q6BQm
 dLUexrzalL3d/ikEZBw2Myjjf4Rt1LDZ1Q0mxKYzWlIIPEaPrHFC04SgwikNtzDHTCJ0KO+mzCU
 Rh1JjCz26fV5oJBc8eHGZqVjWWn8DQ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240089

Add "ti,am62-mcan" device. Device is fully compatible with Bosch.
The device supports out-of-band wakeup capability.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index 2c9d37975bedd652b3060ab11ba75c37565edaad..b1d77b57cb75d8c0b48491f2376d8e186a3ad27c 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -16,7 +16,11 @@ allOf:
 
 properties:
   compatible:
-    const: bosch,m_can
+    oneOf:
+      - const: bosch,m_can
+      - items:
+          - const: ti,am62-mcan
+          - const: bosch,m_can
 
   reg:
     items:

-- 
2.34.1

