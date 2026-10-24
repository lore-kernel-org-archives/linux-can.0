Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792812361;
	b=BevZTUroup+IQ0Ji2WrFtXWK+ucOgu8w5QZxI68dqUw6Sn+/UzG32bFfp+pmbImdaUzv
	 y+llq2rJhzejvE+cRMz52ed/+sWm6S+Px5cMQNxyxiRABCNQyKyQ3DMqIZyvwn2IQaqeP
	 NzwC0eltR6Ap4iNuguTDOoAE6zCrmUY5oZCXguferpatKQadkGhFkiEOeZHvU1K4BKQGC
	 2z5XmtSfjl+08qfb4uaIfRUfhNB4KCGmTe4SUgEK9GBLW7wLVT3JQHe6BKtQruhQ+gJv0
	 55rN/LwwANld6NI8Cp3OmEclJlx7FVz6De0bXfMjjnbZMJmRkgYgvyCGm6z0bAtJsRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812361;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MWV6+5zn+RjBSwcDk9b+oTGETFILpuuQWvyHlonME4s=;
	b=SVqUG6cyx8Uuo7PIKQ3GsWsbE5eNdNoSHGbvjN6f5PIFVCbmFp/Z0TaTJzXWE1SIfoqG
	 bYl+bBWV9j6L9aDjTcnbZF5TazKRRXHZ2XcSDReGLj0tYeAeAap02m+829ZOfkakwcjtw
	 opzOgofpR5vdRfovdbZ7WdyfJc4H3h4HkxzeQRC4UCncKvQH1wFzC5Y8RLl8CB0WpEvhI
	 UEGY7Z9S4myLdBiuqt0A0Dy7lVMOWll56u+QDvl9ri1wxgr46v5a/y86XmSAGeJ2mI5YQ
	 A9tdTjgGfmkBpcOinYkQXRWVKG+I0GV1jBDAaCmAXCXUXBu/sdXfIyXYjnCVUbfJTnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=LdRlRADm;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=VUcrJ+ME;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE35F606A31A;
	Sat, 24 Oct 2026 03:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE35F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=LdRlRADm;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=VUcrJ+ME
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69O1rMtE291679;
	Fri, 23 Oct 2026 22:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=MWV6+5zn+RjBSwcDk9b+oTGETFILpuuQWvyHlonME
	4s=; b=LdRlRADmySx6mG27ajlG4rS3q5jpob9mYIbt5lt4r8TMTUo+SUA6N2mYy
	gdh+l4ES7+VFd1KlHX4UIY5aellhtpbiqMJL4s8MPYYEYe219a2cagTXUGlfxsOi
	t93d3Sn04FPfMF5qBKrD8LUQ0EH/XiayaG74KbstLgSjg4f4kWQ3gwZeLbewNCn4
	aI8b4G/QLMyg0+R/h6U0U41oeexK2k+dMsipW31aRWVCab4nqO2AELudcXP7l6FJ
	1z/nRIlfWFcD5+YKugIj2mvknYRl7GqYhdqAA3IEa6NfDtzaQ3uIsdpCD51J7CmB
	Lbu+8uLOyosBDZh20Ipdi25WIgIKQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hg4v5mkhx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 22:25:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pxt00xsIrDHX3zlo0aeCoOYJJHhT9PiOMGqVFk41VEEPygfJsQi2LBxMFnldqGuHDtxgamerEJhOM7k4QNDHjyf+j8mfmz4o2z+1aMJUpxCJJdX8hJiRBllxrmWrMUCHKRY93RGvur4w36rqppPFT6qYqYp9a+QXvZdDJFeZzafa8yRksNXDm83fW2fGZoptY55jAF1AB0BI5fwMUO+88Bm3CNbeLBP2xWOcXaRwjYpk3o5nm72bdwgCoL7tXhYtCSPKFVTB6WcaqsACc6KjdKasLLUQhjda1IpQl3FgiwotmKilxDBalS4ttco2tOk6NRtzgeTPUGrNgW4WG6qx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWV6+5zn+RjBSwcDk9b+oTGETFILpuuQWvyHlonME4s=;
 b=uMlUQqvYZk7yIohgUIX/TIkN7JY/Pd1RT5Gg+JxddR6fuc/qGhROGNwvNsRxK0/i8iDp1KPsc9sPicfJl96h7DCBLOk+wtT3M+PFGxbCJlbZtqH0QsMx2VMSh04VtuWYDcEpbVOaktaNcE1onzuq7qN+e+vyLsmPgB0mpD0SfHDNyJMPqYSKqcS3u5IUeeZmiW1bv0Gl25OA67dYqkz4FDSDiqbRMm4z57fDMRmcdL42hYhaG1kbdWxhMUtsKjU3+jexPUFfgTTlFrhwZd+14ObqZ26kSodk28cUBEyBg2/bYq7tgQrA1OJfgObkX8V/uwfyBfR5tpvd8vguKSj9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWV6+5zn+RjBSwcDk9b+oTGETFILpuuQWvyHlonME4s=;
 b=VUcrJ+MEO4Csqzaaud329H5gRmug+rWiTUcSpvyLOib+WYk+rCINYlRtXwtSrju4BCntd+o/3Q413Oo+e5L+CD2VEsB/ZpTA45TQ2aKbPUZ6WMdfSO7gIydYnaaW4etzoq2PkidxrYTv5cAilB81YlmHJQJ05q4sKSz8+DJhwuM=
Received: from CH2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:610:4f::14)
 by CH2PR10MB4344.namprd10.prod.outlook.com (2603:10b6:610:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Sat, 24 Oct
 2026 03:25:26 +0000
Received: from CH2PEPF000166C0.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::48) by CH2PR18CA0004.outlook.office365.com
 (2603:10b6:610:4f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.20 via Frontend Transport; Sat,
 24 Oct 2026 03:25:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF000166C0.mail.protection.outlook.com (10.167.252.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Sat, 24 Oct 2026 03:25:24 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 23 Oct
 2026 22:25:06 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 23 Oct
 2026 22:25:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 23 Oct 2026 22:25:05 -0500
Received: from [10.249.135.178] ([10.249.135.178])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69O3P0773924271;
	Fri, 23 Oct 2026 22:25:01 -0500
Message-ID: <99a12aa2-f88a-4f92-bb25-9b0c03801a6f@ti.com>
Date: Sat, 24 Oct 2026 08:55:00 +0530
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: m_can: Implement workaround for errata i2278 and
 i2279
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: <vigneshr@ti.com>, <gehariprasath@ti.com>, <rcsekar@samsung.com>,
        <mailhol.vincent@wanadoo.fr>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <msp@baylibre.com>, <u-kumar1@ti.com>
References: <20260514065511.3573223-1-a-dutta@ti.com>
 <20260514-tiny-koel-of-order-65ade7-mkl@pengutronix.de>
 <9787fdc5-8a51-4567-a576-a3b9f4fcc59d@ti.com>
 <20261022-spiked-pigeon-from-mars-3f2786-mkl@pengutronix.de>
 <5cddfb8a-8ffa-4578-b2f1-3e57e82b2c95@ti.com>
 <20261023-classy-cuscus-of-coffee-ec348f-mkl@pengutronix.de>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20261023-classy-cuscus-of-coffee-ec348f-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C0:EE_|CH2PR10MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c5af68-3672-489d-d116-08df317e713d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|7416014|376014|1800799024|18002099003|22082099003|10067099003|13003099007|56012099006|4143699003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	kjqGLF9cl0mdFt0DM/V8dVQsuDDj5CK3lzL1ik6XNtrSaZ+z2JfT0OUxs2JTsBiHR4ioz1JVzwmu0dizHRhEwauRzsXtm3KLzV4ZmcyIuziitMv7CJes2QdExJZKn+4yYlDlsApzza/DmJLgOaRsUK1DG8MUYgBWYoyQPdOSIP3GmdxRC+18tZN3HGNn+cuEamqInbugTPEvVgCXGfPJ4GWn9YLSK3iKUJtqWizCuJOzPvEeGgeCmh8GeTjG9msK8vrEBoJDh/oP1W3XZDE95lCjYPbMmczk5u545IbHlvxebSILwy5iJa+ziGiZREu+k8fk6sSXt6oSXG0zauxTMFmfuMjtwpeU1htktcyZgoD742T1BqG68c8YWzkYXx14IeN49565S98T4joG2HuStXRawsMQyhW9TZ2JYNvYBlaDG1WbIk/iQAhsiVODZ3/rQ9KjqlaTJX/ZtBbMi5ijTSbYYV3EHhrFvLIcNx+az6FkFGp4/w5txDYlnAwBWVa4the0U1CHB+UooL8rnns+VOsH4/6iuOX8M4vmHvETmVnUvaP9kOzlJiHivHpnvocIPpkupdQJlEGEt/OeaG2jTUXpaq5JavmjjG8ayLaoHvgxASfRQRUcrv7hp33O6uQU6DyilOf+t2V/Xsks2GRayw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(7416014)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(13003099007)(56012099006)(4143699003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IuFB6adTR/umJWTxuq/GH28cMKe64Fq4urJk3W6xdfqmmrZBkg6qmHDneBrAOGbFbHGeYHT0ruTkvmgyhleJPrbrLMxa+C+i4B4QnbuEUmxSogTntWbaY0WzxYsprvpXE9LeGoau85yBdGQ6+ZHUfNcvHCretwpPW+ZuPkb0p059y7zmHzet3VP8x4CJPzl6X2XbK5O/j6NIiaZG/n3ZyTP8vHHPkzR8eKpzhcXxBlhBm3RnLW2CMXzumo9SXB14cxZ6woMZ1D+4KDUd6u2LAv40C42+M3JrP2kjU+NACcaFSMc/LavppNQ8A96Dpcpd+xBlZTELKXqT6TH19SaeIW5GkzJoKJNafLsJt7LCDj0+LvMql6C/a2RWuVvw5CYaA07QtFzdYdxHESvJt5y9yRyoGRUP4ZM1Yy5aBX5ui7Hkh9+NC94hu9xEz436tHFs
X-Exchange-RoutingPolicyChecked:
	NkfJxyvzu6LME+dgV9an5uFL7ge9lNqQx+F8XpbJH76m4dRh0NceenO2Ly8MQdpXbKH3tAdRy1VwkL25ilPLNx1QjaMdzAFeWpRETSReCtIeeBLIhZF24mkeCmWj95XJddzSbCpNp5PtmeoWkf/WZT4C4pqiySnv4iO4MvpYarjr3sHt/eFqSBfmc7yPAILMXl9phTKuBxSfxEAFa5hmoL6tmoHWzxmuBkO2Yqn/Z61Yij3pCdu8YzDDr9GuYL/Xhw08fGqv4QmwMZDaBeIR5D3L5RGP8EbwG0rAb/8b6TKRWgu6LMVi6oJtZBKRN7+OHLRvaySU8Lg9F7jsSA6E/A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 03:25:24.4411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c5af68-3672-489d-d116-08df317e713d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166C0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4344
X-Proofpoint-GUID: vnAgjjPj6fooP6V3jioCYy-A4pftZENp
X-Proofpoint-ORIG-GUID: vnAgjjPj6fooP6V3jioCYy-A4pftZENp
X-Authority-Analysis: v=2.4 cv=NfVzRGD4 c=1 sm=1 tr=0 ts=6adc252a cx=c_pps
 a=VUNJaWZlx74G+l0QYBOIDQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=oVRYQsHRcIjnumQUXZgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAxMiBTYWx0ZWRfXzWSYjHynds4n
 TdfzqbrrKyxWZYUnWAoYjBVGlmfsw1NytM/j7Rj8rkJamkyz+5ma20fGi+I7ZJKry3UkCGuwX65
 Y5U/WCTXOE/piVYNUUaEs5DYjggQhkM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAxMiBTYWx0ZWRfXwCWSJwD+Swo4
 kndpOTBNjxzXcdtZ3i47qrX7elPHXW1yNP2QPQwgK71A1hOK6Su8uXuHfAP934xcBA76HxAdzy9
 T+mzaCuU9FLc6cYfphpJN0vNCGG8vtiEPGPXOkizmUGRDmXwRFZeY1FRltHH/mtmkpm6muXF9oO
 OxN1ikcmNhTSZzQyQ8wXm+a2LTZTs2zZALpx8dDGgbcp6lgoEzXLfUHVy0/O8nG5u53ZEkX+4fp
 unYo7FPjzxIw715Prlw/zYUfsY5EDA6MUCRbhq7kwh2EVMGKxdouuyiqQrGtPauAUEFFXgEoe+i
 O8IT2abgK3Y1pqtq63tPXSkdA6a7O3ZUjk7rWht+0l5+2T47Y6+B8B/zd/ghBuQvNIGX4RiQxJD
 v/JEohRMVC7AFAoCH2uLUeS7Qovy2OAQJaqfPNy49RzhSzVwP11fHhNVPfILLcsDzEI16Ry1J5E
 bphyhbXskBDSwyTiAKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240012



On 10/23/2026 12:18 PM, Marc Kleine-Budde wrote:
> On 22.10.2026 20:33:52, Kumar, Udit wrote:
>> I believe the Bosch errata document is subject to selective disclosure.
> 
> Sigh. The VDHL code of the m_can core leaked, but they still keep the
> errata closed :/
> 
>> However, the most relevant public documentation I can provide is the
>> Bosch user manual [0], which states: 'The Tx FIFO enables transmission
>> of messages with the same Message ID from different Tx Buffers in the
>> order these messages have been written to the Tx FIFO.'
>>
>> For our public disclosure, we have the TI SoC errata [1].
>>
>> Regardless, I believe a v2 is necessary.
>> What would you suggest as the best path forward:
>>
>> Apply this errata to the TI SoC where public disclosure is already
>> available?
>> Or
>> apply it to the MCAN IP used within that SoC?"
> 
> The original patch [1] Anurag Dutta modified code paths that are only
> active for the peripheral case, i.e. the tcan4x5x SPI/CAN chip. The code
> path for the referenced TI SoC stays unchanged.
> 
> [1] https://lore.kernel.org/all/20260514065511.3573223-1-a-dutta@ti.com/
>

Hi Mark,
For given SOCs we are using m_can_platform platform driver.
Since this patch changes TX handling only for the TCAN chip, please drop
it from your queue.
We'll resubmit v2 if needed.

Regards
Udit

>> Do you know if TI's
>>> tcan4x5x is affected by the erratum?
>>
>> I am checking internally within TI.
> 
> Thanks,
> Marc
> 

