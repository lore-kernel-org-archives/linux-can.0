Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A833B71AA;
	Thu, 20 Aug 2026 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262010; cv=fail; b=ZnETRaod1YhvwkVt/cHj05UdPDi9CL/mykr6u0YMMFszOv5hArswiok0TlC7M22LuzoKJCYuUmokgYOrysUdIfqNkfXJZ3Avfkqlm4xkpoiQipkGaiBD4FEY4m+Qiq8p0kSuOv8VrAPnITf9lqnEQ5wppZeLf1EYDXDTizxtcbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262010; c=relaxed/simple;
	bh=gjYhUz8yAfuj7LurBp/eRjmZH0WAl/5Zui+fQkQ2zFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=t2CqzUoxJNdijfeeJZPWNIrdbRKYoHPNAOE1s5mTpVei6SNmB1QXK7VOBo1AH11DgWxe8dy7ijXTo/rDVy9+0nMeBOualWt2o02UjTVIht5uM8Y4pzgTtXUsta3xMxh7dt9mAgeMkl9kS1VaoPSbFQZPyjsdSb/9Py+3tdD+wOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=lnoYUHWh; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CZcgeklK; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="lnoYUHWh";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CZcgeklK"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK6mVD1901773;
	Thu, 20 Aug 2026 16:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=WiSC8CR1yzXq5ivaZxAOFyjZ6e0xV/fRibgXvuxhO
	rc=; b=lnoYUHWhinAneQEvifUjMiOiGnhOSywJn2O3bLShasgbR8d1i78ASbLSR
	ZBn0UHn9oJwH4yFaKdh1XykW82YrZZ4ktE/dTmLovm1XJb2wu08YOiegD/BpAMRy
	URVtF3J8rQog+VvtY+bYyneiPaE0pbJrIMmMwVJtVsodlosChFBbCMMF7hqSzLL0
	I4mGOMhxYXEVKmaJun81Hyo2N5kPZ67/YgtoUN4Vi7TWggiH52R2+qbNpEeNE4FQ
	cjcrfnpjXdg8iwSFjzcwz+Er92WIa+dFSDQvn9PfXSH8h6EzebSdb/Qe6xn433Ho
	nrqPvxG2NgzKV0j4fi2OgbmJh+6tg==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g60gfbskk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 16:39:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL5RvMwcn27u8lJL2Ym554/zX8h9Liq/C4p+zQE4xKqRvM/nvbMH96qNNT4/SPTyCyYasVvo5I8IvgaMU4JNbQpmWljke+2aWFEIpOUdI6WKgyD3IdtiB1YRENWfVT0u8gHbod4J3YYl0ZrrueO2XgdhYj6i/XavA++PxJ/Y7AZE70Vl9nh9eIVEdOHeVJ89FjEgMSPyZIxHA/IUFOO3hB9XqZe5Cvi/cGyiZzDaEUcE0JBSNl/dbTZY4ZF3FlzTT/6wyfhKb27pkdndK1u/25cb6IKDdtwdLyVeGJdVfZExjkJKY0FLROx43N76vVQHPw2VtyGx1Wiy580Q3wjuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiSC8CR1yzXq5ivaZxAOFyjZ6e0xV/fRibgXvuxhOrc=;
 b=R+02nacb7VZU9e5xaR6+2pp9ZNni9Ecs6HnM2Eq6OIRp6BmDoJLQBnjOqAlG78H9qRtgfkawWHeU/LP+O462+VOdZARcvZm9BHAQETxbEi7mWOe88klv453a7jNm0MRaUxD1Y8bFyv7npe8J9TyPUDDrvWGAKPaB+wixcjnPDGhWG/+z/Uh4V8oYi8Mm+tLevWOWGWwbWlVDNE/+Le80GaOGY+alJMi4h67HjaldAwU+mLJSdnZXfiCUvmouP0D95fLTLaPh3Z3+tvZed0+sDGxPy6FzwCsRQHi9/oPdSDeq6ucGfhwWOUkyrgE0FI1Ohba9ef6gyAkVZIIcPHOLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiSC8CR1yzXq5ivaZxAOFyjZ6e0xV/fRibgXvuxhOrc=;
 b=CZcgeklK/zzMClvlgWhyFCDom0kRcUPoG4uxy7qnkm0UZHiFuPouXy1Evp84Y4GWyuntvjof22uF3DmXk/nelFfukkoQsQjNXB8nzmde1weR80WuU3m9V6GHstfy8vQw3ANWlzejSXltoUSFQIVTOeRFvMsKxbCq+AvMfbDSDts=
Received: from PH7P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::6)
 by CY8PR10MB6468.namprd10.prod.outlook.com (2603:10b6:930:60::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 21:39:51 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:510:326:cafe::9d) by PH7P220CA0030.outlook.office365.com
 (2603:10b6:510:326::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 21:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MW1PEPF0001615E.mail.protection.outlook.com (10.167.249.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Thu, 20 Aug 2026 21:39:49 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 16:39:48 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 16:39:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 16:39:47 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67KLdlXX1940503;
	Thu, 20 Aug 2026 16:39:47 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Thu, 20 Aug 2026 16:39:41 -0500
Subject: [PATCH v2 2/2] can: m_can: set out-of-band wakeup if wakeup
 pinctrl exists
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260820-temp-v2-2-dd3f8cacc15e@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787261987; l=1254;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=gjYhUz8yAfuj7LurBp/eRjmZH0WAl/5Zui+fQkQ2zFg=;
 b=ofOhSg/eYGiojYnisTBjrTSId0hte0mQEVzoojgrs3z5hIg5a8cswUI3KZAuW6INx3InzmbRm
 W1aq0ArxV0kC2LdObtK8OZInr8D8mERrk3crwBjYSQrsWI8U8YSWHNr
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|CY8PR10MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: bdeb616b-5c86-4f2a-c0f5-08deff038fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|7416014|36860700016|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	50syPWSw0TBsacD9Xj/6BIxiRpq8h1TGqFwRq5S2ckKZCUmr7lT+9Jj4eKpzdE6fI704UcP5mqUCoHw36kFk5BU+8T7gG8pPybH9ADwJOuhmkQ2F+TeaYOUzboiCjIKjcshyNNgyEyNwwc4rO017Yon4OC/0va7rU0iLbJbll0bP49ljS9Sqpy3DXA8MDT6Z4NPqaFTZes0e2hpWiM7Kg7RAMn1GTi+xBO+Ur3Xxxs0gREMAJRsdmhmQC1VbbvPgipneMnWRGRvoPI1NcavJj8PhtZ61CTIntqLVb3nt8qe9EsP2ZDELH7elVFpXtnHPZrxl8rifsoH2c3MQ5kV4kpZ0Pf58a5henfu5+/nwcUExTfeNP8XN8ekf4WeqNvKzBr7zqG+7PDJgH6osNATYkAjkb9WRlk0H6ogxaRt/SaLKCdn/6Zzl74asTicoouDZg4apSR+UH2LScv3t1LOFfoLb6PoMi1fOAcdspVIVBXLMk9pnkUO/AGRPx4Vi9Fq+6EGIn04pjJJdjSRtF0w6C9wiw9dzhE4TyVoY5mV0GXbs+rfSNqZI9bN0/McY85MUg7nhGjfdX1zPLuxloy8VMDdNc2/TtPbfEuuK/njgQ0N1Mpk1tB6oi+Az6+o57mz2mBN+P+gMf1n2RWI6JCYL1k9piVkkq7t0KNCos7iS1m70BwOPqPYzpowxbqVsLbkNgK/H0QJkTGYvJKsAlqdcpg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(7416014)(36860700016)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	92Cd6N3yURlxEQMVIDOOsWJagZdgAoQQ+K8BSzzapWa/RQivzYYo8+QLFcSrSCAwIrl9hlT0+RjR/+StPihIHfMogVXsj/aVA155iae4BZ4Y73Ljkpr02rMsIE7xmfRGlFVH2ZFDBwXPn4uVieebpKyuQmZOSw2ATfMywERRGAXxRE7jzn0WKfhO4gqtdwXuI5myrSh35dfRWag9+jtX9qoWci9QjfYMMCH0iKpHPq2FpPVB/sSW18tDwHIjQPd4Lld/yDjCk1Axfd8RFG2OEet/Kzvsptva+zZnmkGmCM6fNhga60VkIYVBLZ1P/XqJKPTZsOhwcvIRuffXUcCPHIIwJ/VE3XEwo/Om3LFL2B4gbeqHrTUhvuw3FHnyS3KnpCUEvvj/zjMrEpVpA2/et0H5qex/V5c5rARa6OMr36O5HIRwqEmq/BGW8/8UPx02
X-Exchange-RoutingPolicyChecked:
	cROCjlWIz4fq7w44u66Xbb6nKLiw/AgAjtvfcgg/vk6NOZz8HgDIQo08BA2anSsOwJOs7ckzhjWypq87uLSGd2pwsKRwSuH7VYjNSvi+35O6Jx28BnBHiSiBOyMF9lTxDV2nNjJezbjoKEwNGEc8a/N/0Jl3Au/wjdDtLaiygbUTsg1NLCnuGgWnvj78234fAkFv9jLNa75PBErza6EwlrKjwbV7HCaNK9wZpW3zTrbN+W9NLR4TllyDbt3DvaBSTcJC4PODvhQYsRHnl9Shep1tGRQcIW021MaMktJ0EJ9o6mSy5wj0TXc5slahF2R3j2wB+VfkwiGdZbCSYJ4M3Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 21:39:49.4549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdeb616b-5c86-4f2a-c0f5-08deff038fcf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6468
X-Authority-Analysis: v=2.4 cv=N8MZ0W9B c=1 sm=1 tr=0 ts=6a87742a cx=c_pps
 a=MlxngMRGYcnGG1Y86Hm5lQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=DS1XZwbIN9SMuCO4tYsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YHDkUQFlvvWD3l72Nc3BRXqnjwyGMS-b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX+qtVQuvCG04m
 zH4GJy0O7pIo2aBtoI92n02zRRp0bifSnYRr6ZinyOxggO6MJzaKPI3vQ3PUYkz/3UnH7AMClMl
 M6KisdJUkh8rWXRHB9JwgqQ3eAlYnmR+fCOa5FMtoZG7Ov8vzWTAcBuyxrXvbFR22plrf+wYs4B
 p6Z+0sxlgSMs5xwU3/6kfPq493tM4KCPshbnQnmKFpkie5pqUOlNmQ8t9KRReVqlR2P7gFtPtXX
 0e37yJLPEJJyJVC7Rb4a8bmft8vb0aX+OMGZ7YsDzr27vvP1El+74HTzHMKVByIhksxRtM5XqJd
 Zg3qVqS34O/WRqWVO42VbrZkCem0g2q3gEMZe/GcYssWimbOEK4oYOKV+DCYSDe9LntanOIWUcq
 oECh1WwQzmFwgEuwXa8Lr/HdKQ2u8LgZ4INiOKJtJbs9o67yd4spVYzruWaFBc6xsc8hJIvM7lr
 TIRWCHDjISR1zonn7ig==
X-Proofpoint-ORIG-GUID: YHDkUQFlvvWD3l72Nc3BRXqnjwyGMS-b
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX2MwE3DNFcNvw
 AR5AJPn6sfUD8w0zodSDdnM3fqvUl/ypwLPYTJYU0KA0Xl1BiRHD79QNMOtjvMlJKrsC9kImjIN
 KHeUGtKNtfvSHoaFZMMqrsMFaNbqMi0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

In TI AM62X, AM62A, and AM62P SoCs, the m_can pins can act as a wakeup
source in the deepest low power states. However, the m_can pins are a part
of the MCU domain which is OFF in deeper low power states. Since the m_can
pins continue to be ON even if the MCU domain is turned off, set the
out-of-band wakeup flag if the CAN device may wakeup, has the
"out-band-wakeup" property in the device tree node, and has the "wakeup"
pinctrl state.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 drivers/net/can/m_can/m_can.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index eb856547ae7df27a844b236a0c1d4498cbb8b60f..e745660fb3eb311de70635fcfc016a44e62d5602 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2622,8 +2622,12 @@ int m_can_class_suspend(struct device *dev)
 		cdev->can.state = CAN_STATE_SLEEPING;
 	}
 
-	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
+	if (m_can_class_wakeup_pinctrl_enabled(cdev)) {
+		if (device_property_read_bool(dev, "out-band-wakeup"))
+			device_set_out_band_wakeup(dev);
+	} else {
 		pinctrl_pm_select_sleep_state(dev);
+	}
 
 	return ret;
 }

-- 
2.34.1

