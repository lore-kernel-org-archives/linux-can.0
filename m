Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A447A886;
	Fri, 21 Aug 2026 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328462; cv=fail; b=c01+KeocX+1YLcD7XTZoJtozsVPY5PR04KWzCD6BS6QmdVZnZGO7JpUAyQGTB7lpHz4psxOyu6FIEkm7ZyrpNn789xz7haXfAy3E3SpGZ9sTVLMqbrE+lu7KXWrP4M+RPyi5RINomS6nc4JyO17tnC7TVPfvEJxs381eu8PUygU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328462; c=relaxed/simple;
	bh=8jd+D6V7uoYn4Odu7Z7pvYbEJB0TQr1fjMaTNYxfsxs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=YDpgiOHiArn4cOuk2ZeyjM8wDJ8AXms14/oVijS4MyzMDMrin49azOs7PIcNrDDrhXkO3ABhJhglHoPr3m/z95h4XSCCHOBsXjfZHDfbByLSK5fuLj5xhkPqk27HwEsoZ/tyeBZg4Q9rY9U614bcPLOCWs/XIQ6kBViJ8MZDR18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=jB+AC21I; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ufUY/b7W; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="jB+AC21I";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ufUY/b7W"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67LFoGCe4004459;
	Fri, 21 Aug 2026 11:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=b8IeowTLCSBz3
	LXSixCHAihPekARDwQ0x1QlBlS33O4=; b=jB+AC21IqpJbimtdY2lRuJHG7ujUO
	8ck8oAivmNQ/HSh5CJMkAve/poSOsw0O0Ip921I21ceqhc2TWeaRhR4TtIwZP6T5
	SpqPXP61V/xLkq4CTfsGKeXvfrBRU9p4KupRBSnqyv2H9jXgh0KOJRJqNYbR3vPq
	j6xtlD1Jc3xz6TLRNmeJrXyZ5dgUVM3ycixGbRKlqf8heNHTJuHOjK0pmVhj2QBy
	2GGHz5jcCWmns8EExSF0gQa5G/IxoDwIAjlouO7YjHQcO387x4ES6mGUZWvTLOgb
	YhRYOkcF7YzhWE+zVdAeSiM771gDR3xWIkZk0KFR4A6xMSVlocfnhDKfg==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g6hfk2td6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 11:07:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7Lrk0QtlZ/SMxDt1d1m0VQ+vWQMMfuIW8BYyoQEK5l8HyhsaXPQMoqznMZjOeO0GKXQVT4JI8U0NCFcZ5kConrcxt9DpIdqfGabAwALMBmnecL2svHnBd7VUVutJobT3mWHRXX7LwDymz/hG1guLQxaCTc1dHSTBrvt6SxArYYLdEnsoiMflnvnk/qxUi9SKwvoB4ulUsba7tK+5hVgirMrCsRLonTyw7IA3V5AhyNPnNFBzVWiwL3P+3R7tEK3q10gMzLkjzdPQTM1HUNJtE/vdDxW7K5cM6kdhxGqGOuAca88BdfMMdv+dsTBxjePpFYId6wY03CbpZPN9iSjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8IeowTLCSBz3LXSixCHAihPekARDwQ0x1QlBlS33O4=;
 b=G8evQ0OLGZJvb4N6ylXckbarO3ayNL8YHXs2CnDKQ0dLJfD2jlwfselqOjRAn+wNLyRzwcM5dx0t5fCAQ/KoB2LP7n3flw6Hdza3zzSt1zN5gx8oSK9dr3gnicKTHLR8vyhgd1Bugf1cBPtypa9kUqJLDxR9m/frVEdkws+R987kW3cp0Lc1qWsOIW+J6Y5jOYd+kVl2UR6JBnKuzCqwhpydj5ghQwyFRShd8n5EQy2VhzqeiniRS4YOYh5C5twACa9i63x/VEOWpbxxgKus7StB2Ds1a1SS8sz8v3r6j3qBXnt088Tl1+vCKgYQLlopOrptCRcY3+euInQJeivpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8IeowTLCSBz3LXSixCHAihPekARDwQ0x1QlBlS33O4=;
 b=ufUY/b7WC9EzbPuPzcTHFYIC7tREtF70HAN57b9CTN6EiaKpB+uz5xElXZdKslrqu3FkbT82X/2C+7VLoyAHd44TN61OUwDnufus4Tfke1m3zan3s0CQP92uB5qMV++gl7/nP+4DAzhB4h5KK7k/ciVYI4/XW6OzASyrbu5CBLE=
Received: from MW4PR03CA0290.namprd03.prod.outlook.com (2603:10b6:303:b5::25)
 by CH0PR10MB5193.namprd10.prod.outlook.com (2603:10b6:610:c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 16:07:18 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::4c) by MW4PR03CA0290.outlook.office365.com
 (2603:10b6:303:b5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:18 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:14 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:14 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LG7EEb2409002;
	Fri, 21 Aug 2026 11:07:14 -0500
From: Kendall Willis <k-willis@ti.com>
Subject: [PATCH v3 0/2] can: m_can: support out-of-band wakeup capability
Date: Fri, 21 Aug 2026 11:06:59 -0500
Message-ID: <20260821-temp-v3-0-9ac1f8806929@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKN3iGoC/0WNyw6CMBREf4V07TXtrUBx5X8YF33cShe0BLDRE
 P5dHokuz2TmzMxGGgKN7FrMbKAcxpDiCvJUMNvq+CQIbmWGHCuuRAMTdT00EpvGEGFtarZW+4F
 8eO+a+2PlNoxTGj67NYstPQQoJHRWR0ivCZIHo6ODLECA9pVyF1vW3MjbFM42dWwzZfyvFfLjP
 iNwcE56ZbW1oqTfYlmWL2zpzXzTAAAA
X-Change-ID: 20260819-temp-93299bee27b7
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787328434; l=1826;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=8jd+D6V7uoYn4Odu7Z7pvYbEJB0TQr1fjMaTNYxfsxs=;
 b=c3i0E547FBGw1VV2YDB1eo1E7keR8brg4PU/J48h+bgOqFpviayzgfmu0lqFTETeL3abAn/4I
 xWC25MxYo7mBK3vgmodoowMlG5jDMk6VrQqnAMHYFqIDlTIW0cZc2j1
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|CH0PR10MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6167d6-12ee-413b-6096-08deff9e4650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|23010399003|376014|82310400026|5023799004|10067099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	fIw+AhYBQm4MWHugrOee28ZHyHhH0qsm4e8jlLt+vD2cQjqc85/nrSP3/TXrr+3hLdAunijta2cEPOcaGmWnySuoTVophqgq9ep6NNsPplYAdcFaPNha4LeLQrc2H5i81uTX8dCIPVmEjP2uNRLL5WrWQ94sXJkxxud+EcmLUZprdzNMo9Fj9rXNvowVedd/piYCLM0btMV3nqY6y7B5XmEGd48MsYR8TTkLlycbNCbkpEXwUld3lrAZlMd0rwXqp2lHv5T2qaszA6GZte8YJaveJY/BhvlVV+mZpK22tUAqzFax1gBhHSpMeUAGAgNvRUMymtdIJ9tsFEK3qdawfPyGVc3sBjiIvKnWnr97w3wlrCpkaOtAOkOxYKutqGdhiVDGD5HoqN8piWuG30l6+WDepWOZRcrdZT93w6vN5X2Lcy9Ao2nv7UeQEcH9c1zc/of4cXk1rMX2jdLHUxzvBF+eTTe8/EZDCWyqGPM/oJhZdWRaC44ubz3HvWOIM7/WTS6FeUkckGZZr903T4IyjO6ph6lu3KFlJRjk9e6PVe4VOY42qP7j0qz86/ogZoxd+A9CP/JhSGHvHmjS1zgfqD/pYNfTLw/l65eu3f6wzOegmeFrP0vYSbuZzzHv2AA5JrCpNkPxzZpHVjEBryE7URj/u1HobB8tOlcw/QVvJ/84wtt22gM94+hI6YlGYwerPt5ADtzRbctGT2NWKvQttQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(23010399003)(376014)(82310400026)(5023799004)(10067099003)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Vn8qBPmpZ3cnuH1/QHrk9e+BAU+GQOt3fUzvrdmxCCehqHJgSNk+99SVbWgigOReHezdR9J0adD7wLDqGTPB46bviCjZoFr9xHUWyW3z9KmgGVvsI39eqfv/wUQwaX0aG0clRel0KKw6SCFsJfJAIn85R1+Tyf2U+3Bw0M+2T3RfbxLGN4TydBAymk94tsHo826CZDmDEtSvOhvI8wD1xbZe+MFmdzkQiyW8kSQ+RCjg1/hmtqTh66pdMs6x/+WGqQLBHeDubvEb/33/a3f3/iH5Yan7tDz5eilfJFOo9AWyLVV2rPNh+RtJ66iXfxN4s578S2f0O+VPDDMSaU/ZTVOM69/fORav+phJi9ZLNOGkra3Aroki2bYUiDfeEdbMyxSaDcQBMumOliK4VEnodGwEMyGsYJPH5i5DHeI3MqAMuJNxZL3H9ee+pXGfe5m
X-Exchange-RoutingPolicyChecked:
	nCN8W2HpZwrZUa1vTwV/vaT09wB1Cq2cXWlFoCng8vQCqsg4RE3zTH5pRYjT2rn9oMSEHuI/pgexoiYxZrrRd5ChBEGVybd4sh98MofcjcR55SERneuthH6ddNtRpM27jXAsakDYKszERj1SG9wi9IiPyhwuz43nLSdyiE4olpDzaTq85rCLUINK6Ku00fXJ3KfGX6EJ8HpSVGNi+qJwlBPvxcGOW4pqwaWqy4GbsFrTA/XoqGoUPsSl6QTg0sHZE5Qem5y6cyFw3vdSamjnro/1Bax3bu0ZEsKDyG6Dr1g8L3GJfgC1ExLUJ7mUUj2HZDuCQyDy9TyMeOw08fDQ/A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:18.1553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6167d6-12ee-413b-6096-08deff9e4650
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5193
X-Authority-Analysis: v=2.4 cv=O7AJeh9W c=1 sm=1 tr=0 ts=6a8877b8 cx=c_pps
 a=ZIPBhjw7PX4DPdPA1Kx5nA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=kuQUhFgK7Ee4HvU5YUEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Etk1mE5cKzALRy4Yg8cmAaWwddcXbBdU
X-Proofpoint-GUID: Etk1mE5cKzALRy4Yg8cmAaWwddcXbBdU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfX1gZx3WFiD/fe
 KfI6MvbI0R9sz/ZF98EwU69UDVYbbIMg8MeuY1EUYTMDzdxs4lWIBL7LbaOu+AwuQoyo29N0Gg0
 7mS8Hc4ZkTtiZo3KjBbY83hvg/BkuYo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfX5+ZjwJ0DVUPI
 HkqKbooL/fXo20X3p5clnIx9VR6E6nB1UoodE1z+ltn5cLov3S6LHgW3WHNA/MkrOHR0hs7eVdC
 g4yuOrm6n0fZX1ifQ3e9H0JIbjcMyJvql2P/1pLRJesMfWZGvOrEG48EulqjlySjwBo/OsZrM8C
 jU26WkJixM4/R/536R+Q4XnLUUeodtP5IYIDX+8NkmB7ri7lzNKNI4F7JscHMeY9RQKa7d+uKhD
 q10ZQXQt1RRv7gXGMqg+29Veerb0iHwHvma6KaxeSwpLf2DJ76e7CFscx/cqfiJl+neNvbbWM1V
 HnjpeJ0U2iye+tAXjifuPo5TNuluLQRPiX+XTz9klwpudxk3VmNuuSCjb9NrPQ8FfX4j6DHOqT3
 39GicW/31icayX5qErSKf8vNB7QzOwqystgO6Ept5SiLeWDIh/2zPfMnFm8liPgdspiVl6WObh8
 A1zQ/cZzgc1gl/RNEGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210126

This series adds support for the out-of-band wakeup capability in the m_can
driver. Some CAN devices are wakeup capable and can wake up the system
while being in a domain that is OFF. Allow the driver to set the
out-of-band wakeup flag during suspend if the "out-band-wakeup" property
is present in the device tree.

A corresponding DTS series enabling this feature on TI K3 AM62A, AM62D,
AM62P, and AM62X-LP SoCs has been submitted separately:
"arm64: dts: ti: add out-band-wakeup property to m_can devices"

Dependency
----------
The DT bindings are dependent on this PR in the dt-schema repository,
which defines the out-band-wakeup property:
https://github.com/devicetree-org/dt-schema/pull/205

Testing
-------
Tested suspend/resume with CAN wakeup on AM62P SK EVM.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Changes in v3:
- Remove definition of "out-band-wakeup" property in dt binding.
- Allow "out-band-wakeup" property in dt binding.
- Link to v2: https://lore.kernel.org/r/20260820-temp-v2-0-dd3f8cacc15e@ti.com

Changes in v2:
- Create "out-band-wakeup" property in dt bindings.
- Use "out-band-wakeup" property to set the out_band_wakeup flag upon
  suspend.
- Rebase to v7.2
- Link to v1: https://lore.kernel.org/r/20260213-mcan-out-of-band-v1-1-af68d4c570b3@ti.com

---
Kendall Willis (2):
      dt-bindings: can: m_can: add out-band-wakeup property
      can: m_can: set out-of-band wakeup if wakeup pinctrl exists

 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 2 ++
 drivers/net/can/m_can/m_can.c                              | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260819-temp-93299bee27b7

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

