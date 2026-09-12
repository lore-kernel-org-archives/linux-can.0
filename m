Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE2349CE7;
	Sat, 12 Sep 2026 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789248457; cv=fail; b=GaLhvSBl5FbVwacW9g3IoLnPWKrx7Pav8WcJ5WCnUdUeApWp/CH0wTipOyCpcxHnr5iZBh96JM5O3FPlKhju3g4LUyT6a9NAEKjhiyrAh1ZkeFjWpwgD6jWrqadZs7fsbNXI3wfNtODrOQtRXW2Xa+dVHyMaZu9hKP4L2H3Ldo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789248457; c=relaxed/simple;
	bh=6Pf2l7CsbyPBG2U+GEw71uKo1+3zRMxmpZuX0cVC6Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ET5DO6ldaW/awJ0YZepxu5bet0LeZsLF76d/+BKYufM9fk31mdYgllKWEiEXxQwaW4DZ/LG/yqaYkCP5CaGirgNe/XJvAMjUNh2nz3cO3o5xZKpCTkn3hY62qsGTzerk4nydP6uhdzRsuJPJv0PM02wXzwMD2PfxRAk9GfJESew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=e75BQwhp; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XKpzmPfe; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="e75BQwhp";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XKpzmPfe"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68CI1kVl2895356;
	Sat, 12 Sep 2026 16:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=TPx4hUmbtFPXEoTrkXVy1Kzl9zecjd1Rq8wEC0kWv
	WM=; b=e75BQwhp5q5cqdQVEWhh3pl9E9CxJ6qMlYbJVZafb/K6cgZws9vp/vk86
	qwacyl0tiP3G2KNDPzBM2KEEGlh0BEjJDHsEuHIWhAumFkI1jHCz4MWyOMlqcKav
	gvHPf4QuZ/At5F665d9jcr8ly/h/iaOGiUpHrhgE05nRRrkQc4MJhd9cAk/xbe5L
	MJqzTk6YzJbnjEAVHzQ6Ye5QJp4Lx4W+z4MPhDa2omie7J7WAEMpcAsXrx/vV5a1
	ViqX+dWRFKa6SebrD4T4zkfCNMuQuZvxlwidnUh/jBCQo2+aD9CREvNP+Bjk3gNE
	1LSAJiPBKfafnvZrCaLHAzPQFtGbw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gmy5d361t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 16:27:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhYrXtb2h3OdGxDjKw1iJsqjSW01qMkIzwxtKLW8Gvc5Gyi7PX22w9EOTLua0qQOt55Mo2DO7adrEEouF4k9NqF68JG54cwW1YfDmJBKhqZAIBIDtPoX+JKqM6thHBl8EhGpd0I2LmLX+B12npHgLa3p5xFtRUzYBm5+va6SJ8l5XereTiXXj9elKTbltzZ0IOPd4dyhayNgYM8bu0lR0s5c4ob0yFfBFh7KWehN8FE932/MVgE+w4hYld/4g2Hwqi0zOdQAmC6lPoMnQD7aVvS+s3534pjIV4iQ7rIjz6e+SIP3NFpZsT4dsU+MiLmg1XpDjPVCF9qClNl+MJTFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPx4hUmbtFPXEoTrkXVy1Kzl9zecjd1Rq8wEC0kWvWM=;
 b=xMYImTYTXD+HUoEda7UXP1lJRRwNF1MWZlTeW2LEAO2MbiJa7+R2kuUElJ7o4s1be0BYOGtxHLoo+qSqj5zt3HTenwLiyoXeWRZ7yQ8ZgkEg533vssuZpY6+xqngdSOI90uP2DRfr/1gukJoIorn4nAGSk2JQWx0829dG7AT87lCnkV2x1yJ8/cLjOk0DuaVH4vQNqGoukZz5UdZJS/zoqc99Nbel8f7Uf65tKN+o4ropxx77iXyQsTUGt4ZqcgRDlVX8eSXu+0/Kz2Hnr/XZtWLjdbozf5FDODzjXhgKTkdeJckNUBFn2MG/GBO54lMplco4KnlWtE7akkHZA0x/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPx4hUmbtFPXEoTrkXVy1Kzl9zecjd1Rq8wEC0kWvWM=;
 b=XKpzmPfeTH0ovFA4om6j6S5Ajw4WCFebkKr+DB2zoCcyVc/jak+LUikaFTn0lz5d10ZBFUZDQeJs7icVPFmrR93gKWs/Ad7gB9NFmJw5iNOZyR5XMWqiZLH7vdB1hl01+jQ+2bKfaeVvK7WVWvxTUMA8GJNItnweDH7JKtns8Hg=
Received: from BN0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:408:e6::17)
 by PH7PR10MB6626.namprd10.prod.outlook.com (2603:10b6:510:209::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Sat, 12 Sep
 2026 21:27:16 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::22) by BN0PR03CA0012.outlook.office365.com
 (2603:10b6:408:e6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Sat,
 12 Sep 2026 21:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Sat, 12 Sep 2026 21:27:15 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 12 Sep
 2026 16:26:56 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 12 Sep
 2026 16:26:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 12 Sep 2026 16:26:55 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68CLQtTV3503647;
	Sat, 12 Sep 2026 16:26:55 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Sat, 12 Sep 2026 16:26:55 -0500
Subject: [PATCH v5 1/2] dt-bindings: can: m_can: add ti,am62-mcan
 compatible
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260912-temp-v5-1-2e3201c02109@ti.com>
References: <20260912-temp-v5-0-2e3201c02109@ti.com>
In-Reply-To: <20260912-temp-v5-0-2e3201c02109@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789248415; l=908;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=6Pf2l7CsbyPBG2U+GEw71uKo1+3zRMxmpZuX0cVC6Hk=;
 b=IyzWiEf789F2eGZhJFTu2xfbMPD8GLy7ZjRq8ipzr0NhbD8amAnX3osrgrLmPM4kslXS1YHq8
 0C99Cjw3J2+DieYQc91dTbgLjXOoOUFkyQOGLEqzDTcKUjk3KEvz0ga
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|PH7PR10MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2da1ab-5c46-4b9f-694e-08df11149dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|7416014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WDWe/uOS3MPXykGYfqLO9RhGwDenTCvcEp6Za01fSDjRU9xJSQRKSQySRVh3Ji5xVaIezjmE3yvd1/iy+3BiivFrJ44KafM2yMVONB35+R0aL1RBOPkpT5n7swMAyXxfYvKjp4r36SrEbbKHt+CackjM1f2n2I90VYswN4OkDLPEXpDp0/8a/qZ+r1HKZg97bmfR+pSySpiam8u7j1qWorU4xfPUhW2E+wT12Cd37atsimW5H9GW8x0RKrqctbvgOej/wXJDwUifeNQtA+Iqrx+z2KRrJgoN3oKqOgTOnjAo+QXMsI8YjvfQ1hKj3ibqKddwM3s+iS2nfqySw4a7GVLNThbS98r/bdPxKesJNkhOB+C/g7CcR3ngPAtIM/OE+8F3wyj1nsCCb1Qzws3Q6xNMS5GWytfXc3BrxD0x6cwRaCOt6eY/14dig0a1CpZXJiP/3yo8atHabaPeqDnKGnv+Gl6rWaP9jgair5MAJIotPUKQeil/4B5oYn5hEM1iBEya8SqVYC2FVGJ03w5QCScz28ggL3HJAFqKHatPiKlfM2ady4g6czvhsz2JNF2lQWVu0EdQFCKBmrrE22WV/7pqE1Gquj+EqxoJofZSrReVqjpkai5IM59E3V84Ym+sJmQvVz6LFOMXp9DIqQZ91qv5bk1tYFBmZPjwOMGkuP9rWXAQZUuoKtp+XSSmiB9RpLQ6t4Xpn0hIZ36ogeY5rA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(7416014)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lsBjDve1uZV0uh265O3uS3IGZUrgzSb0cjwhdhc6lo2CUbIFpzFzn4yZSQrT0G3Y9plP5l+YXJNPd/POs9Y7kr3t3bFUT87O5jRiBRtYbaCESNtdNtUPVGxO2WBqjejtH5qOqhaxypWj+eNs1IHC1Y/flAsJr+nk73/xcrj2oFBNT9apwDBdPsOcJdPugp4nxomrthzJbn3WGyxJK9Hs42RgeAyoA+ud2H8rruQxjZKTV3lxrx3wVMjAUoVRKUp1O18X6y9TvG3NN+B9U6MfUqhfQ7GTL+0FwUZEkCZww5A8QzRTUvP6KIdh4hFR6u/k6M/JAFZAnUTWfP93F+PBhOpUKzlKYwDPxV2nmElktqaPoeqaY2u4zTK4ZrXLnK7cXOXs8kBZe741X3Rbku7OLYEeumzmxXDPy9zHh2rEU3bVX33cLMEmzNqgqspO7mxE
X-Exchange-RoutingPolicyChecked:
	22XYr+fhBhNOMA3TDBTqiC1bmRp7pPjEY/LT7Fk7rAHjDQaXBJgZ3IMTDacc34Sru6fnGeVkEMBWVS/UI/RHizY6bFsJZntQmRPt5mYdIgB+grwpRLqaQnNI5YgOj9+zJNPpk9Xm6nIwA++y4QI5cliQstbMGJs7FNldgcTSpebTRVuQTwPSYI93mNF4V+J9H0jNi7wET+iF9KUhg0Lbuvy9mxWqnsOG5c51/KK9qRUAuNECeJlraLOGE/2MqBF+kWRQtOHLA5rRvQy9EBsPJN3ZGeAA06vySKlAGM8YhbQ+7JiyPlh737KduRxcavDbnjy+kwspw/3pxVZ96n+Oug==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 21:27:15.2174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2da1ab-5c46-4b9f-694e-08df11149dbe
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6626
X-Proofpoint-GUID: 3iz2plKwepK72nA9TDKtdlmdbPO9fGxl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDMxMyBTYWx0ZWRfXwO5eHOaTETOo
 s0Zj4KEoVe1CmuNCNBAYW2+CgwmWAr8fIaYjAKENEWismvlxSZpHTQnMPLJdgOGNG8xAfzWBmu6
 tzAmh2+HqqTRyHGdDfu82qJDO1n1cjZa0v8+kgHOEMuphiU9GnL80PWWOwQH7kLIeMnLITTpcab
 QHOHxLIDW4K8iPnRsyh/DQGihG1jrbwJavKgiPk73yFEhAQIK1nBF+4hpiiTQivKUbpGO9jyDlx
 WU+1VCUbxJPWjavWyugavWZv4yVd+C1bohW+N4y9edTtzPEeVW8dEknJnsqwQBZ6ggAsBpFWtcW
 C2V1bfWs8uYEzn3nGOW1jfxzlg9NuLXK4L8v2Sa7eAlknBQWs+CArIP/8lArE+gabVADY9/2pDw
 8l8PTFLS840evuwXNqZgX3OfaPuCkhg87/V4u2QbvUTEOp05rmGsC2dIcWYnoQB+C9wnZrNlzpo
 j40AUEx+coC6wHdO4bg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDMxMyBTYWx0ZWRfXxN37gvHEhGFo
 2KZWxmdLLFTcXoL2JiV2BKtZO8BevVFB0QmbSLhW1B3LUtDovBijhXqEG6xj2B9mQx4ySwX3YkS
 ZC4tNeyoUFvNLXdLHBHeaDQ24TRlBLo=
X-Authority-Analysis: v=2.4 cv=F6vC5ahN c=1 sm=1 tr=0 ts=6aa5c3b8 cx=c_pps
 a=WJg1qJ+8ll6SXBP1xA03Zg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=ZZAhWbh7ve9bke59XMMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3iz2plKwepK72nA9TDKtdlmdbPO9fGxl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120313

Add "ti,am62-mcan" device. Device is fully compatible with Bosch.
The device supports out-of-band wakeup capability.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index 2c9d37975bedd652b3060ab11ba75c37565edaad..e0ac14de54fb20b46c29edf96fd9cee647df6283 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -16,7 +16,11 @@ allOf:
 
 properties:
   compatible:
-    const: bosch,m_can
+    oneOf:
+      - const: bosch,m_can
+      - items:
+        - const: ti,am62-mcan
+        - const: bosch,m_can
 
   reg:
     items:

-- 
2.34.1

