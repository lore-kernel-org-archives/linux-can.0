Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D72341ADD;
	Sat, 12 Sep 2026 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789248457; cv=fail; b=AS/JJj67p19+w4Xe/tMGYIqfsBz2luO9CjTOPydHMlEjqTkt3MX2psVCY++y3IFhpGXfst8sR7R3qif+oYFAWn9pqbQR1KRZEKHa/eAc6i8UXUnRO1evY1G1+USZwwfeCvlSi8rGs6f/KRV+/vW2EiJ5dqK/OV2LZnYUBDPawjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789248457; c=relaxed/simple;
	bh=NVyW7qcJe498ZTClfYtTXFdCE+yq7mVtcd+YNVj+SvE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=vDZMlJ67Jv6+PgOZybpq3zZuZHfDoxef2CvGQ77g2wgGhckrXgXbz4armj+FCDPJqq8Y8NRzO0TVfRq5HBoI0BsI8iAbu6N+jTaNgZP+66s0DMZToAsbmhhck3FbpJCySKn5aW79Zblb5D3LxIEeyrgKRoXFV9Ht04J0qFCK+JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=l0lGnned; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lt/OExjZ; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="l0lGnned";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lt/OExjZ"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68CI1b4c2894940;
	Sat, 12 Sep 2026 16:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=UsLH1lwxtRVIh
	sxDXYvS/anQB2rjAUoidel81QkWPKA=; b=l0lGnnedEEyXyerFhm7rb8M4Mkerf
	YFw01zv51nwm6OaGSs1d+SvkeUbUYOXNgtoF9m6l2CLvvSRTXa4YIihIagKvK15z
	YB96hWbYeNuGEphcB0iMhOe/8aSHzgZVEvxSH0wcV2sf1NX1F4Wc2Gn3rUzcG/vX
	wZ98GE+/ucpzNvsDkkDgWbc5gnSsDY673QI8HGMPPNZ0DQfVdOMRQivmHr7JwNiv
	Ip0j5t3PbuaPci8936LhmS03Jh3cIiqb/W8D+GVhDWpSk2SLPFR/IkN8WuPM50Wm
	cBylf0NdQ84YXu+9aZwwipo55ePUIDpy/TISCfdyIpKN/hYMhTXfzoBPg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gmy5d361u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 16:27:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ts7rE9wzhB7qeu7RP+Xswsnb9DTzANaQkHPKLq/rhurBkaKbJvt0b0mesXe15WtLk121IfM06OB+dbNtzitCp3WjHgBqlBGOidiD4HxrGyz1bvR0Ikr8wXBjXvD4dr6dcwa6wPoza3UDOIgqncrPMDE/Uvvytg9cg6AEfX3hluR4qQH2DBmQgaCCAI4Y6+kqy8sihPvln4tJm4N8mypB97w0q1t7uMSG4AS927GDFEAUbDGB3VME9UcWsvNYz0CA7HLxO7kVJCPDad9FpC1vXkPKHQucW1ey6HEl0xP0KVPB4Wr3AcQEZssKTi3U8OhsX2Yp0MIUEM2Vv60wuprlnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsLH1lwxtRVIhsxDXYvS/anQB2rjAUoidel81QkWPKA=;
 b=LWimZzSRDEfGg9vnK6wAdR08IJcira1vU7jr6uLPogayMiSsFzU653Ki3P9o9djz6E+R6OMF5oILSyEdA1/U/LiSG9U5rEBTQaIebMVBcFfikcB+rRXy/L46S9y7AgdJHwncb1xE6bR7n13SeMMS5t/WpsxRD6wCLIhlmn65MggPrhDDG48IrdYjL9rByXziBJ3HBbGMNgXXJKT1DOpxtz0WqPMNj2DH/kjUDLA+Ef/Nv462Fb2VmzV6LNSGjw4eiB+5lPlWjy7lM0jxvwWKAXgbkGrlni+3uf3m55nTYwNVIfi9W7dkjSmX3pIeE58pzPOVyB4Dody0vhRPba0y6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsLH1lwxtRVIhsxDXYvS/anQB2rjAUoidel81QkWPKA=;
 b=lt/OExjZ8AAolBXr2RpkvuTJbe+RG9YcVRIMc3QCbYhE+ASX5/DvmY0c8OTGT5ROQoEgYiWR83kj4LHlcgHULOxQIb3QpOrP/rSDxHGngNOsb80dB8+wTS75+VJgRp7cZi6QinJnX85yMKkxB5Ue7FQVZ+G1B6oTEuziRIYuXmg=
Received: from SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::20)
 by SN4PR10MB5560.namprd10.prod.outlook.com (2603:10b6:806:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Sat, 12 Sep
 2026 21:27:17 +0000
Received: from BY1PEPF000264B6.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::64) by SJ0P220CA0013.outlook.office365.com
 (2603:10b6:a03:41b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Sat,
 12 Sep 2026 21:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BY1PEPF000264B6.mail.protection.outlook.com (10.167.242.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Sat, 12 Sep 2026 21:27:16 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 12 Sep
 2026 16:26:56 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 12 Sep
 2026 16:26:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 12 Sep 2026 16:26:55 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68CLQtTU3503647;
	Sat, 12 Sep 2026 16:26:55 -0500
From: Kendall Willis <k-willis@ti.com>
Subject: [PATCH v5 0/2] can: m_can: introduce ti,am62-mcan compatible for
 out-of-band wakeup
Date: Sat, 12 Sep 2026 16:26:54 -0500
Message-ID: <20260912-temp-v5-0-2e3201c02109@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ7DpWoC/1XNy27DIBCF4VeJWGcqGGwMWfU9oi7wMCQsbCLbR
 akiv3vJRbksz4jv5yJmnhLPYre5iIlLmlMe62i3G0FHPx4YUqhboEQjrXKw8HACp9G5nhm7vhP
 16WnimM63zP6n7mOalzz93apFXa/3ACoNA/kR8u8COULvxwBFgQIfjQ0NtZ3s9feSvigP4loq+
 NIW5f37giAhBB0teSLV8ofQ70I9hK7CeVLRWmkcug/RvIST+BBNFdo6E7ugDLF9inVd/wH22/9
 ONwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789248415; l=2642;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=NVyW7qcJe498ZTClfYtTXFdCE+yq7mVtcd+YNVj+SvE=;
 b=OHnNoacHIrFru2gV7SJZ9I1ytbuKtYBNBMZ5p9yHCVVmTJrIAiX0SIOu2cAUyOn7O0x5oRvj4
 A1rdzurZObCDBXWINgMuvIJI5nJvXKRk9ImQG4MaWL5r7r61cNQiOMk
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B6:EE_|SN4PR10MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ebeeac-3af6-4fe2-3bba-08df11149e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|23010399003|1800799024|10067099003|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	wzQt77ZFccPr+626VXB70t+Nem0Jzl/PtmEZl+vE4iu/VYA9/R/U96ZYNjQgdUPCNEYJs6G5yp4oy62Estw1SKApfUWkWZOGbJ+vg4L4WkgoxauaJ8LYZfEk3VKtJguvvdsTAHK3IY6ybKhN67PYUOOzGiUzWP+9qZaKj88gGKPfDdEbFrvTPW0AwELdZSGZv++Ic98sRoZAhoNotNogxPsAg8laFNOEv9+0M5EfPXsh2iq+8QDGUoI5G8T2tYF8ddiv+X2IQXBg2A9Jh32YIkibEFmdzjcUgFCqNZ1xrkpU6TgWxSyNUDsyosA8XryS/nUDFnopQKhn0ms/1fT4rDPVOwhHWEFMBRFkAQVADDBBTJ2mYpJDsecOsQ5BF0Ue3I0apKJWDCIgSyDUfsYP47E0a/5I+3XW+a0fjxJdc3nQu3/9vwFNCpORZ9pikJWuU3B6xJODBN3Ul27xTWMeInyzHX9iyrLE9pAdCHjOgdBVlLHMjhrZELryn+fueq5E9ZWDHuUmXLoPrd6ed+W5r73UImEGZ+mcK3DksbG7Yb01TqnOm1nyMAtP1RrRl3eR/ikfjFPHddZ48AJmlgr+f/39+nE0zHQ8g7pba27Aq/xOUKpbFL7wh4m63izyPEhJOJjktxqS2TYAuVlW7x01YqfDbjNfxVhdScqQqQy+WLY7SnrVL+ce50tx6f5RcpqF4wQo1piEVChO1vi0WnCrUw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(10067099003)(18002099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pA5TwAiY+sSGhblET7gfIZ+3FgVEvMCCpXe0NVLHSPJccIHZrfw5jU/lt7iHhXrJF0TAmJddCfrK+u/YOE5YYTp2MHBTp1i7gHE8IekX+TxyDJAnBB9g0eNzJTIrDXTW0SDuZw1eOzVj3ueRxgWI92I8E/v3PVN5IQmuncRFlCeJB0CeggBfBRDnF330iFM+XDJJvRmQDlO9QjrfhnGqki9/WDje5eyeGAofqh9sXcpHMEkAHSysqVZr+Za7yuU2IdoXuepVNx08RDkLJCoulYf79pOE4/UIOFzdC5/JRYifEYFkO+CluhdGvOb/7UUZPjXVq40tqtraEa6+i79iFkdnKWUf0rzrV/IqaSPFAz4HBtipvVG3sIiZCuDBU5UTMGkc+pWeHPO9+uGj1Ht6N0Z7M5SRPiv/p6nGSbFvvJJlv/6HBWrhqNw0QhAN8V/1
X-Exchange-RoutingPolicyChecked:
	D8dpQuI1KqtX+14BmnQzP5KZp6qrJT1QRzEJcgRUcqGc9WD0W+kyghPExpcZWXVWumYeRujZ4mCPZ7hdCpUEd9DSXrqI2NFgZLSNBQa/ZxWYAj086rwn6q2iu4uDf0cMK21iJIDzgbCjgppOFdFP5zWrktC4CH2bb44gJm+A2j2IWEQjpM6iGMdWweUDUQ5xw9E83KPLIG08oAqdMBS+/WnPYzjNKoyf77llSAZ96iA+nfqEP+soYsHFHW1xtCbNfDb/9Nh8qVlNgemFnNbSLyXkS7OThFoOTUGz88EG+KIo+Bzs/VECQbr+7x48kSn9JzKFCKSETdiACPr3gJn2sA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 21:27:16.5486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ebeeac-3af6-4fe2-3bba-08df11149e8c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5560
X-Proofpoint-GUID: I6X3OkEhmNXw5AH3ZaYDoXY2TbyThWpe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDMxMyBTYWx0ZWRfXy5pzchj1xsYT
 2ZC33OATMKumAfw1ocuI3RWaX4beQxAL8JU+fAuGBP1xqSgtQ/mmuyn3xYLTuqJqf80F0nm7a/1
 aGiU0OL5mH6BAB0uZn83AcNF/nenfdP/xztTdZIFtR1ONdNYQIvQN8mRyFrsu4Kna29S4M7kaOC
 TCXRVI++aNVjXxIYTy1NGC4hnShAxZjKcWgrxNeYXekdAH2vpIr9XyX5tDk2fYQIQccYz4vsRVZ
 FtwKZ1KD+re0Z6BL+sfoWuxXG7GcwkgtMgYEk9fDLA0syITbNBoIxC75fsCRQi1MXu80pauOP9p
 iWNDykzCaQIWySFwb88gGnNnDmymzTEiMLZGm8IPm078oi9AyXubaKRVRMxRoYNUKsON0CwTdcI
 wtY5iOIlEOJ46KCdohUPz9IqyLFSh8EwiTQyNiX3Ia5G6AnR+DOjZR/IaSVdEB8oPLMmfqLRhMn
 hW0leQZZv54urRBEtAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDMxMyBTYWx0ZWRfXydd9VfIvvql9
 VxmPWgOv6ap+5pL3U17UCDAloGN6ynE+WPwyd4Kwse+RyTcwn8WUWl6zubXU0EQSwjunFM/dWwN
 Rt8otnJZASb4OpEwyAgye2LViW6NiWw=
X-Authority-Analysis: v=2.4 cv=F6vC5ahN c=1 sm=1 tr=0 ts=6aa5c3b9 cx=c_pps
 a=xHwt0NLWInP9jDJIu2hPAg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=qQodJB_2RY7VTpcDHEYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: I6X3OkEhmNXw5AH3ZaYDoXY2TbyThWpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120313

This series introduces the "ti,am62-mcan" compatible which adds support
for out-of-band wakeup capability in m_can devices.

A corresponding DTS series enabling this feature on TI K3 AM62 family
of devices has been submitted separately:
"arm64: dts: ti: use ti,am62-mcan compatible for m_can devices"

Testing
-------
Tested suspend/resume with CAN wakeup on AM62P SK EVM.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Changes in v5:
- Rename compatible string from "ti,am62-m_can" to "ti,am62-mcan".
- Update dt binding to use "oneOf" with a fallback compatible chain instead of a flat "enum".
- Rename "struct m_can_pdata" to "struct m_can_of_data".
- Read match data at probe time and cache it in "m_can_classdev" instead of fetching it in suspend.
- Add "out_band_wakeup" flag to "struct m_can_classdev".
- Guard wakeup/sleep pinctrl selection in suspend with a return value check.
- Link to v4: https://lore.kernel.org/r/20260902-temp-v4-0-3896f7d16ce8@ti.com

Changes in v4:
- Remove patch for "out-band-wakeup" property in dt binding.
- Create "ti,am62-m_can" compatible in the dt binding and m_can driver.
- Add "struct m_can_of_data" for compatible-specific data which keeps track
  of "out_band_wakeup" flag.
- Replace check "out-band-wakeup" dt property in the device driver upon
  suspend with check for "out_band_wakeup" variable from the
  "m_can_of_data".
- Link to v3: https://lore.kernel.org/r/20260821-temp-v3-0-9ac1f8806929@ti.com

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
      dt-bindings: can: m_can: add ti,am62-mcan compatible
      can: m_can: add ti,am62-mcan compatible with out-of-band wakeup support

 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml |  6 +++++-
 drivers/net/can/m_can/m_can.c                              | 10 ++++++++--
 drivers/net/can/m_can/m_can.h                              |  6 ++++++
 drivers/net/can/m_can/m_can_platform.c                     |  9 +++++++++
 4 files changed, 28 insertions(+), 3 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260819-temp-93299bee27b7

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

