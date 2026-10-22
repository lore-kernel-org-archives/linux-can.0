Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792681526;
	b=kwuTWSwCP3w5UZh08ZbcFdgLNK6krNKlsTCfXIpthlvYSt0kipcGh82yBtPoyE+a29HK
	 Gh9999vQGvIjWprehPiNpFJXDxn7dzmFQUa7ydJM8Pe21Spd9eQzFr4adFdZ2iNerTmcM
	 KcXFPcxZyTJbneAmGhnk6y97nHoRT0vabYJv3XxJXNCib4Geqxq37vdyV8vtJXZUGCweK
	 XYWh+1PZK9WsCUNEUh4FERHW18xgZvTnqernD3TGI3yKI7+ZA78Fazxp5nbP8t703Hk9S
	 6C5JkBtwv5pKC71rfwq57Dkmap/xF86SnIHhlnRPuuT7kMO+0CiSd+YH0M4SSU3LGiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681526;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ZUiVooNbtOW2seOJTJZEHpvrzgF2YZWWYiLnk8Kxn5g=;
	b=pGTwUt0UW4KeXNNXgJhgHEKWBGT8wnVW2wRFlB6Cuol4ev6HxXiJoMLcp51H9w22qMGS
	 RedqZ8OPvrLcHpMhge0Pxf7sdS2jpH3ka+EnlZ5Hw0fJqiwwh5n/Ll0HBgZkfBJ1kV30K
	 IBxdF8Hl87lat3Z4Yy0FaVtZ+CgC+xvluBalAyRhV2NnhHJJ9uQnavo1GF5J9MeqWD5pc
	 g0jJcNY6zsE6H+Dd+3n5F29+eESsyvFLN0DB3ToB+WpDaq0+8pZf7jEyHfCZ8kxqcegNf
	 Vjfcv7wFx/X+y0AKuRFvt5ZhnQWdisCKd4dW6COo0Sm29S+v2JtqU93QV5fSCPhD2Lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cxbeegPa;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=QjEGQkE7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B6D606A334;
	Thu, 22 Oct 2026 15:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5B6D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cxbeegPa;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=QjEGQkE7
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEgHHA650230;
	Thu, 22 Oct 2026 10:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=ZUiVooNbtOW2seOJTJZEHpvrzgF2YZWWYiLnk8Kxn
	5g=; b=cxbeegPaXlrU4ER9UOgUoHdEa+nNmCHlpO4i78dEdJWsS189lPQ82NtQK
	YXITVkG7vUfH4wM56u0FADB07lN0F0mb9OtlOTmUM2Mkt3NONIt6VQ2WZyQRIWax
	YxQVdAkAeUxbTMHyGGrgIKniVBVnsokMxuze5fwMur55Ya+6jAM3hgTBmIA4OPQc
	VxBC9pTXdEvb0eZA0YW+0pYi2uvmxvNuHrwWgwHwJSMBxdKmWQcXWhw7IixTL9cM
	NJiE231bNYQSHbpRi2rZd3QNm4sByXWpIrxw6rF48iMoI2MqWhHXKpgr+zJ5IWEM
	HxNoCNC069j7KeCFX0rCbSLU4M4hQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hfmg005q2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 10:04:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJiUKxOzBBblBfkYT82YpvVdOB1Wn2bqMeEKHoMjROkmWsmCBvjjzizRUX2BIU4ZF2DCzkzxcpXYM9UnWN3agQhnE0o4tLgjnHbLXsm1/DiKrBMFlt2UlSNFNxCvzf822PWGouO+/LjmrFd9UcwpEIZ5x9H0t1HFWaf4BQOIvZ/sfaeuYKrbOaKKsH2iyyKGois9XV+CX6o0SMNO1EbYgCP+IbOvD3GgavRfYpqSzO3oM+IrODj3bWnAUu36NswHi31KZeA8q+/3/3v4NrECESBuWACm+bSd5UOQIAub7nLGLWMgU3QkQ9fQc9LZAKG3WBVrERVXfqgGi/FhempIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUiVooNbtOW2seOJTJZEHpvrzgF2YZWWYiLnk8Kxn5g=;
 b=QYF1UmXvv/iC1VKu2Ud3DB6UVBYz61JSbs/kuC3iGuQsmGPZwMUqTpUpLz0dcfPtJqOMUPlTNt00OPkVrIuOWEwf2Ugj4yVkQzeQTL5pOmUlH5hpRRB7n/jcnsFpA6u4cWZCHNMe1ui9nLU/45jlrVyeq8O/VMG3AYmna1d9+eXl96bMe5MItKqFfG+p+4uYxC3G6AA63id3fW9nh7EPiG+jZNI+ZK1qD6zFP0zoJlFTjO9LI5qatAcdPM2UOTXq17PMs/LHR/8JcgAw3pmtOH6GMga1eO1pn4ZtKGIQOvouGsaGgH+i2vFKk08ysTbPShC/GNDXX9tLQVRFpDRu6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUiVooNbtOW2seOJTJZEHpvrzgF2YZWWYiLnk8Kxn5g=;
 b=QjEGQkE7WBHUFAR16DBefrul298Mgwv5IrnlDWBGthrVxFEi9PwevXueZoyxMhicfSp/u1Ei7p7uy5XuPbmuAyfLr82NJ1gbTDhuIDtjCzGc6bRGKWKTpKQ4gyqUcgj+kyu4g1+jnye6qmtIJ89hZo7rb1ZU2NYeKG/LIjR5l4U=
Received: from BN9PR03CA0509.namprd03.prod.outlook.com (2603:10b6:408:130::34)
 by BLAPR10MB4915.namprd10.prod.outlook.com (2603:10b6:208:330::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 15:04:54 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::9e) by BN9PR03CA0509.outlook.office365.com
 (2603:10b6:408:130::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu,
 22 Oct 2026 15:04:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 15:04:53 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 22 Oct
 2026 10:04:00 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 22 Oct
 2026 10:04:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 22 Oct 2026 10:04:00 -0500
Received: from [10.249.135.178] ([10.249.135.178])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69MF3rXP644359;
	Thu, 22 Oct 2026 10:03:54 -0500
Message-ID: <5cddfb8a-8ffa-4578-b2f1-3e57e82b2c95@ti.com>
Date: Thu, 22 Oct 2026 20:33:52 +0530
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
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20261022-spiked-pigeon-from-mars-3f2786-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|BLAPR10MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a75350-b615-4278-c35e-08df304dd3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|7416014|36860700016|18002099003|22082099003|4143699003|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	gCG1VurcN69o+lT2WASxR4A/c5iawrXWMSU65xWdcCBpEadeJQ2K2VvrOsO006+IAyGW/RPiSVgtz4e9Au+kkhipMTIyLHM0qXtMoQildY4RzyiWpknyrY5o1P3UgBJdpXFcb1RLcj7Z5Mwx7wA5qsVdIRovgLoyIpCxLG95aXHwSCU5hkndM3RKpOV2Uzfu+dGo35lEqkuW73kPVXxxhNqhHJ/pDc4uHXis3OS8rLIKGYgW9n6hnOKcMiWCb21BTyikh8tcvpKYskeYbcXG88MENIWpdT/o9Kvvb+miVrx4yZxVIo6ujxWHTfuuVsb+CSQaC0QagP0g2cbQqtC9q93KLpKRBN4cWNXP78XF5Gcqzewgh7r/b9AdOIgLC/ib4qY/cd/ypknrm0FKFvw6V44+994XpeQXf1DLYJqkK6dAONldbU4RSo5Kja1TWXyqPaZQEtEgkP7a6YuvoOWr9n/KV0E2l6mBBxaMx1f607quYZwgSckMkB9PTo/qFyOXvqmMSfwN09jIHVzWfoy16yGVLn1AuBIBRxqWADwat9Lfqh2jDs/9+7A0yoU/Ipl8ZzaPEd4dh4jFOrrpZ7T2N0xfqwzrUDIFeWOCchd6+ZT+7mQQOhJFSqsylosjfO08SrL4BfHRQHgyiyPNZL6TTA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(7416014)(36860700016)(18002099003)(22082099003)(4143699003)(261009223027099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zo3XJIxAWYlTk2W4n0evHMHqImuVJjCrysFwaOr69f2z0Q2Q1UhVWnNb71sok4pa1i51Yd/z+F3qzAlRN6lVuhsTHVdd7c+bpenjMIfvPI1/Qxpf1XmCtN63qSPIyHDSZIXO52G3ZmeLww8hDviY02Y2tpVW2thm1WQxpUJxU8UyrGwHgrw5ZzD5fO4VyHsJeVVH9TX4r1mY5B9ySTBxNc3hHIo827cOk5thDecTfIvhvX7tADU9bsdqFAX+zZvEjIVjEsVftpL4Ej5YPXiI3iUBLSh2NxPysNh+b+oxQiCSv2x0BzSQeCUjAH5zt5XXepvdqNdJfm5qFJRBls6HG0ANprRNcF8i0X96kA7t/wncwHiedRppCKEyERCvwdBbSxsux3tz3V+rdAUGftW6J8xnvpc/YCV4daCAuUtdPlV+ley9KWY0+fztDwnNRHXr
X-Exchange-RoutingPolicyChecked:
	vj6sjZXbNC31kZXTzoXcv8AkbEtDnuctIGOUaj5QpWX/z5nudwPYbCzOfG6kCE9yzvAx4aHdmZlnN+cQC5DnBo1g16gIYsPiUu0UsdyZjTz2XXK4MshW9Fh7NYNRXS/2qa/hSvThAXNET2KOLrZzJquraL6DuqpVQtOUsaRIOqpTA3Fa9J12PSmmd559eiV4Rq0HwYYFu1msBGIMjUrIJ7EC/daCvCGX08UXBcSCwlmU5ILiW0bqFg88+qyQ84IvIk8+yDnNwPjSyoGbKVyy36gHbW0ur9ZY7Urd+UNr56grwNsKSrbSKcOEVze5KshASw4oL9CrjdRifSSdhfEJbg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 15:04:53.5145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a75350-b615-4278-c35e-08df304dd3f0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4915
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1OSBTYWx0ZWRfX1KX3a7/zxEb8
 8WwA7LQi9Vxz2lKkpPoEeQ503+VLsOhW7dr+8izZG7fUZzxvMVAGc7oEraChc4DEk/DGjwqm7cZ
 xgsGQDlBa/cLZp1KEAIWa6BrFHzaxjpDMBKmuA2YnDjJlXi4KmE7BcR9knnR0rRcx7bpHMN2Q7+
 tMtiCDN0wzaANOA7kKAR34ucKYeBlHjyGLUGUhXUQDw897mcjVvYxEF3solkKvqeUXtgwZFjJLN
 /BlIb9eSHvljrDuyexK9n3wcLMIagV4xyvQsaBLiZjgWrgF+edcC74H/LFk2MxeJ9+hapweeMUo
 5KwNY02pWHwkJbY19xaE9pvcuJWU0yongsOLxD7f6obJn3D9uEug66Fm121BwkukvMRj/1q3f64
 JwTRulBAvVKHc75N/XBnEz5q06ffB6OlzBW5wGWsdnVQDgsahOn3CHg3hr1tYsiaFw4FEBLe6Te
 1UTwdCEoBZjhdOhQ25Q==
X-Authority-Analysis: v=2.4 cv=QIL91QLL c=1 sm=1 tr=0 ts=6ada2618 cx=c_pps
 a=+gGuMjfID3j0L7k8h/8w9A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=V_sKlfSfAAAA:8 a=sozttTNsAAAA:8
 a=e3Pca7t6iPUCcC6mgncA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dD--MePgUL4pqIuaHxJJKuQ2I9QZKKo-
X-Proofpoint-GUID: dD--MePgUL4pqIuaHxJJKuQ2I9QZKKo-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1OSBTYWx0ZWRfX+uXhoh71J3BL
 PwL5OVF6wBRmDPxsbGO5Tn9xPVWnLYwGTBt/IVbF+LJD0wHZpYPXIZbwcZzMKtZ539w8AddBkMg
 6VM0sYwi+aB/ZchCvYriwxTVdvJj9dw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220059

Hi Marc,

On 10/22/2026 12:30 PM, Marc Kleine-Budde wrote:
> On 22.10.2026 08:49:22, Kumar, Udit wrote:
>>> The latest Bosch m_can documentation doesn't mention this problem,
>>> neither the TCAN4550 docs. Can this be an integration problem of the SoC
>>> on TI's side?
> 
>> this is similar to Errata 22 from Bosch
>> Message order inversion when transmitting from dedicated Tx Buffers
>> configured with same Message ID.
>> page-29, release doc REL20210625
> 
> Can you give me a link to the Bosch Errata sheet? 


I believe the Bosch errata document is subject to selective disclosure.
However, the most relevant public documentation I can provide is the
Bosch user manual [0], which states: 'The Tx FIFO enables transmission
of messages with the same Message ID from different Tx Buffers in the
order these messages have been written to the Tx FIFO.'

For our public disclosure, we have the TI SoC errata [1].

Regardless, I believe a v2 is necessary.
What would you suggest as the best path forward:

Apply this errata to the TI SoC where public disclosure is already
available?
Or
apply it to the MCAN IP used within that SoC?"

[0]
https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/m_can/mcan_users_manual_v331.pdf


[1] https://www.ti.com/lit/pdf/sprz530

Do you know if TI's
> tcan4x5x is affected by the erratum?

I am checking internally within TI.

> 
> regards,
> Marc
> 

