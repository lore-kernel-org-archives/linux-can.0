Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00B341ABB;
	Tue, 15 Sep 2026 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496231; cv=fail; b=NzxTxGZSeCLYBxsIa13ZkCNOM5SsFNHK8ibfusGTLJA1epvMIKFJmuYjvvIaaRqbr8s7qIUXuZiCIuzznwsWrm3Et414qI+hsvNKAZQ9aq+qmo7lhUvl0KnZDmncT05bSEC4a6HV24x+Jl2wejPjBW22MgkTEFktYLImUPej4IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496231; c=relaxed/simple;
	bh=8z96YX+UYisJK+nYdhWUj2obBIL3jzW2wY4zl7ki33g=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Zd6KLX497uuEhtPt9S0imQhIEtk9pqyTLUETvhWAZ6qbS3Dvu6ixE3eVdi2+BiVMr+1UzNuHDLQjNHAJgECwfeeaEAjjS+JmrC7YQ5MqipaArvWykVfDwtgLIfGQo2HMs753DzyT3NQX9nLRTBf/M1dI78vP0bkufC4MWhGaNJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=LHbBPeDg; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OXVr3j9n; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="LHbBPeDg";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OXVr3j9n"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68FHpXru2408481;
	Tue, 15 Sep 2026 13:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=U/ei9QBxvBTfK
	nwnwgKXICeqnbUCdvEf0chYPxH1fYs=; b=LHbBPeDgw1hL+kEbcqYXbn88k4NoB
	C22xtz+cUeQs3grXCNwpDRnctdSW3jKLrAqa0HumGysOS/LJT+n8TZlO4J+zbdFc
	yVv5bMO2G+qVt741gpFhiI0/1sr7D2DhXCQ7z6APXVUpRVGQGkHWm09CcI6MPK89
	BieeT9UTGA/q+UFxA9oAYrq4hNN7wPxtQ94qXYRZKEgRvTM5tMd15UTK0B4xzx//
	C1lQbBZ8kzbcnc6tn1JQN6m9eIy896iFKKwJMyXHed6ByVuGxcJzyeP53Qwy+o/L
	dF9qqr3002RasGAvHCqreEpc0d8RZ1uCMmTnkNjaJOOa2kweUDsnQSYVg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gpvpa5x99-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 13:16:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIgDTmvFU673PgnMTPF3Wb/QO8Q0onQEZvpfxi72R9Vucj5QWIdM8BuIQzUvbUOYyiConA77WfMzI8kPoOr63R3+392S65Oluj3q5B32uIK5McZHtuCnR8LmgxOlpRs1xh82VWG306epx5gFntV+/smbIK8U9XzWl4xsgEQgG30+TdN3SWjdnls3Wc2JWeZe6b19r+wTU0KUPOuM0Sq65OLgGr+oqUPGEdwyJ0t2gTaDP8/N77VJMm5pmdOmEz86/33NC+ErBrvQFe2nhc5WxWAciNwnXSEYMcoHoqb6DBCUExxI1cQvpdLqS5B6WUOE/1UCYf3aB2K6FQ8ZbMkszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/ei9QBxvBTfKnwnwgKXICeqnbUCdvEf0chYPxH1fYs=;
 b=RepN7b8DBTI6gkNhIxNGZY+z4IGOkCjJooAVPCLdNkdCXylNjkNIf5Hwe7gpfdtjRUNRCLj45DGOUDIlWTSCaDjVWqLu5mfvRQrcj1zhP8No3jSuKkSKU9hvZJ9F5z9WjFnNAfd90aNPJMq6eE1XQEWmU3gwoqDYXR8NLLammb8UESp59euzO9jMBnBLM8JccAnG0mEUR1G3CsrYeck+ALMVuYCKmOLbveUn2x3l3+1Un2/4otbCBjRZqtbozRk1t2gv2S/6p2jJKPIiGlmC20bz5DkoUKWgNVbaqeZnEbQP4iT2cMioP7YBHv+qQsmeiVQRZJ8VGSTaVEkXx8LEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/ei9QBxvBTfKnwnwgKXICeqnbUCdvEf0chYPxH1fYs=;
 b=OXVr3j9nbVAlWYVBXx4kWf5OcEP0r2rO0Is3s9yQqgjPCDsRZtGp5w1ux9knuklF1fB0exk55K1zovEdDUOM5YpmNR1bcV9uYIE4bbq3HPaedIjOU8wj5mUUj9Hb8wHhQHt8Na35edt9YzYAJGnQJIdANPB+0lU5ICsGrDv04NU=
Received: from BY5PR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:1d0::21)
 by DM6PR10MB4171.namprd10.prod.outlook.com (2603:10b6:5:21f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 18:16:54 +0000
Received: from BY1PEPF00026957.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::19) by BY5PR04CA0011.outlook.office365.com
 (2603:10b6:a03:1d0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 18:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BY1PEPF00026957.mail.protection.outlook.com (10.167.244.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 18:16:52 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 13:16:05 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 13:16:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 13:16:05 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68FIG5SR481480;
	Tue, 15 Sep 2026 13:16:05 -0500
From: Kendall Willis <k-willis@ti.com>
Subject: [PATCH v6 0/2] can: m_can: introduce ti,am62-mcan compatible for
 out-of-band wakeup
Date: Tue, 15 Sep 2026 13:16:00 -0500
Message-ID: <20260915-temp-v6-0-ddf1411d63cc@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGGLqWoC/1XPz27DIAwG8FepOM8TNgmBnfYe0w4EzMohoUoy1
 KrKu4/+mdIcP8u/z/JVzDwlnsXH4SomLmlOeaxBvx2EP7rxhyGFmgVJ0tKghYWHE1hF1vbM1PW
 dqKuniWM632u+vms+pnnJ0+XeWvA2fRQQKhi8GyH/LpAj9G4MUBAQXNQmNL7tZK8+l/Tu8yBuT
 YU2bUg+zhcCCSGoaLzzHlveCfUq8ClUFdZ5jMZIbcnuRLMJK+kpmiqUsTp2AbVnsxPti8B/0VZ
 BrEiir5/K7ca6rn9ECFKeaQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789496165; l=2818;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=8z96YX+UYisJK+nYdhWUj2obBIL3jzW2wY4zl7ki33g=;
 b=eNR/b81JtqXwF4/SDaj3L2whb+C2BuPZpYmkX3X5PkCmurBF2KtfLDk9cdtQ7af/z7PpZ9Eu4
 UZeKMZdgumhB7345kaMq7oUf49jAb6lOgOgxMtQUq+of1gybe0twLjt
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026957:EE_|DM6PR10MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c0728d-15b9-4b48-8100-08df1355843e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|7416014|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	etE2EpWG+TKFL2fLnWF5HKpeeFiOU6YXnc5t2AvnNI0xz+D2LYkZqu6+qYUFqr7FmyfO5zX/1ZeBb3gnPXnBRHHxiyHCK2YgIuybpexHV0f3PSurqkN9EP3lkoATHgTzjQ53ktukC3afqflI2YG9Nq/K/q0iqljYPGnBpFY05x8zlQWWEdzcmDNFg11gkQLwBV91O9tbSJPUP7ZEOPCIkuBqZe5l3Dw8PbPXJR4rAxCnXe0vn7BwD/OUbodQnQnDrEAISZ9ZBUbbVTruEZMMbS0eOnzHdAGemJn1PC0Zk1b09agGQn2wy0E0hnG5a0panskDQ7A6gv0Hxy15N1d7Kvx5Jw4WhdaU96k4RtuxqWUtyBPLYsMT3FZX4wMg0UO8qzQuZXzF9O0J/6GD4nKAEPJJUkzL4HWKZk9JxOY0WK9QlK5Ft9nusWCunBNq6/CSuEsQ2n6WgpXeM+yHi/PXJuICYdhb4PP2O5JesZSdmFAy4L6QBlSdVtJ0XRD9U/vvCMXNB9crFZlhNNWkskxn98zqKz6XsAFw3BrbH+IQUHIjsXNsjJ4Jl1+wsGXatLbxuFzvI3cW671rC8J2d/eDJwngX188Eq2pcy02f6AqOWjRLF39RaLgUCqCPbpqXf58X28hiVlzZGngSI6MicTq+7K2aesMJf+H+ZL8hLWC83etP1n2ryNWjJLNipQnQ4o/6ctGnZHZJrbCO7BSM8h7LA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3J0Q2HMgNG36i7kKpushTWYgM9G/ESV30/Gb5nxzkxWQAoOENHee1YVeDIncn4Kxo1hwcVhEICbttNErzCFaQ3MDSKB9TdDcJCNJN354Zgene4R94mCrrw2JAmmFI+fyHv8FNvGdgwCMgJSEA0tSizsMS0DYX3JVDZkztb2foxn40A5rIQB/pOvSUvS51rpC7etsC/hqUIwEFhRzwzQS+bmoiNjWziJW3fGH+HYbYUh8SqQGuDvkU2J57gyHMz/5/PQZa0CyZd/oSmm46J8EN05iM6JxkK3leXOYH/d4dkprPI34yU77l/KvRz6OtDlLKzlOz2eix7rZIG2cwv8jo/oo+nFtCTVjDMnjQGYt76qB5PjWKKGjkGkNzQJaj1pzSY2KmLiZvF2h+DRT0u+Zm+V7FUBYPfEHCdW7r8eGQ+CfO69nT197Dz49eA33GHec
X-Exchange-RoutingPolicyChecked:
	oWBRnPpfyLWevzigy8DwGdjNoPneXdYVnWTXtEf1j7TOX1fC66a32eVGizxnVcZefmMorw/CDn7bc5skn55xQ7WM5j4IdTVWbbUzHwTV0JaGDOkxz6J7vCjHVFNP6OzKvZQaE1L1MCkcLodZ8CV7B85OIEKl02qGb1xbsZGuDNxAkOnc9bemOwxBao8aWD49zrTNOBSegRGjgXZLptFNrCOkNZtpqbajmUanYJjhTxJf89n8MekZezb7CaHYoHRBY6d4t+sUcQyDEG+QaUeKByGNnICwuaBSAxYZBaFr41g5vs4+sEulbiCHwTPXqZtgDX55z0vk6e1yUtFADzzT7w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 18:16:52.0461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c0728d-15b9-4b48-8100-08df1355843e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026957.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4171
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI2NiBTYWx0ZWRfX7kiUoNN6Zrbr
 Pz+nBfUaHkIWMJfNqM6hnLJallAXaulmY1RKVdIWpI99WBbUZIjyW+Ptnej7n3t1feqkNn+m4y5
 o8jHUZ7HGQJuY1kAgac/zdW0KObv2gLWpS4pr7ubeSF5EZx0DLEEfzb86BfCmjR+WH7pe/bjIhO
 vRQTdqx2cG/Bl5pcCTu3ZPJDyDFsCCcrSTjpMiGhV37l3uI3BHAc7aRIu2PcV8ogmlt35stTG6t
 TML1DZE/oraB9m4eA2aAJ7+6xhiq9aeUyVglHGPWyQNqT9rkhSxgGnlQ8BOsU09uFcUiJ7fSeHu
 KZOYvfQJwIK2LuhDYBmYW3YWsilCNze/nlDwvYBwsnCc+vim+nWL/DgmG46dpMBQYNHahU6KEsu
 KNQ2ZOcqKoQYTobsTb4Urjnl9zA8cs6d56h9f7Szlbws7n6KX1q5OYYJb8YYcSVRpFTuSWLd1gn
 xDgShRJzR738XKkpfHg==
X-Proofpoint-ORIG-GUID: yXlYYOtrTkGjTFZkGGOPvcHU2Hu12Gc0
X-Authority-Analysis: v=2.4 cv=U7cHnuru c=1 sm=1 tr=0 ts=6aa98b9a cx=c_pps
 a=25df8hqnvvr9QcO7WBwFwg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=qQodJB_2RY7VTpcDHEYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yXlYYOtrTkGjTFZkGGOPvcHU2Hu12Gc0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI2NiBTYWx0ZWRfX1luZA4NhujAw
 fOSuHirBr4gRw2YqGDX64DVgzrRqgntWx2hOjk6NFmImNBTOPW/CQlPWaI3A2r5slgvdfILizRZ
 V4tJ9jks4tk4/5qSGFmUxpjrFu/hLGM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150266

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
Changes in v6:
- Fix indentation for items under the compatible property in DT
  bindings.
- Link to v5: https://lore.kernel.org/r/20260912-temp-v5-0-2e3201c02109@ti.com

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

