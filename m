Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263F94248DA;
	Fri, 21 Aug 2026 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328494; cv=fail; b=l0mceohNBsTH648mof3ea+yBaGol8VqwkgqZlN5JwxwungJhfTn5hWduOMYCdADhqbu8RrW1kEniVYd3wj8atbZdWwlFOJSR6/2WkfZ1UFykOsVN2zfF40aWQOzdqjdbBc4mAkiqccIi8A/V1DPFz4ib6ay89gqC8d8G+67GylA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328494; c=relaxed/simple;
	bh=gjYhUz8yAfuj7LurBp/eRjmZH0WAl/5Zui+fQkQ2zFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lUNC2Ix2kgXkGKVUG7h7EGPx8JcsjDN920IoifB/CcyzmIjkALp8FHWtjaxIvmYjYWx2Uunc9IqHkkiz+JNHb/qPGYaA93g7/C2BCpyCxtvaqqSvOl8FZ1lyMXFXTPjxtjFYmfeSJbAVBjkUFVWuA2rnS8xvNaGkMnaEuxQHEkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=pxOk+TSJ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oCA4JE6o; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="pxOk+TSJ";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oCA4JE6o"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67LFoINS4004483;
	Fri, 21 Aug 2026 11:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=WiSC8CR1yzXq5ivaZxAOFyjZ6e0xV/fRibgXvuxhO
	rc=; b=pxOk+TSJiVWqWHKB8L5W7HBlmmlDdQE0Q5dXHUfXOIqye/2t77/gNE4JG
	Vv66rvsegzYIL35TVgUPIfuVo3jtXZWAZ/+eR+5/SN/VHhYji+P/4u8umws5+xjP
	sN+2ORuZVWMZ8E1zvLjVuO8Wqkg0lOD5uRUQAGUWcOtFVNxPO8d9zbUA+03amJtc
	arfsIDH6RrLNmf7GEM7fekT+LwNsvp1zYTjVlqQTWR7+WWu3JAR9vUvV56mlRhnq
	9xfnJmxsSMaNMKWSXUjYx4fOSvlM0+Zyn1hfUd3ghX/OYTMe07zVWoaymKXGrWSN
	Izx2+/VzIWz4AhkK4/jqpoacQDh7w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g6hfk2tgd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 11:07:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klfq1TuJy0etU1SqMi9F1djNsPEuPUHCT7CJv2oIUbJUspClhhnLyfF+DqI3sf2R1JFoXxpD9CmqdWGaOI8EY0wE1ebUQrI4oexwxRLUVBvLaV6948m7map1zRiXAIzrT0el51SjGkRzaKE8DknHOzyNteZN3xwh+BB5G9d1ul4mHHdfQYjAF+f9nPGKhB8jrk3m8PTQ6gVeRHO/PAqz/lGxcaL5pmpKsgBE7A8nkLBp7WASSUDGDQppZPm+CgZWVn6o9av2Ff5jnFh4Vlo890Ttgv9mCdicVS6XU3kz8RNe/LE0TQgVRj2LqImPLjjJL4p6yYXp7D68XgWqvK7rZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiSC8CR1yzXq5ivaZxAOFyjZ6e0xV/fRibgXvuxhOrc=;
 b=EN0uxSGCaVWVbyBGj5LdKvSBT1kuxYpvfV7zsb4E9Ofsmu+6cp31BWA4Yvluh+Q59L1pdpXP3Bn8ukVRHTV4F/YdjVrLmLoWisA+VGoQsQQ/V6COkLybWn7OLKgB8ZNx76zXBE/1xf9mPKoIyOHRtChBCBnLlH+sEpAAb8n5+gN5bb/3ZxPstpv5roqUPx1D6lQCbdssRWTeO7X2n7IdE2mJPtcem0FKoV2KwWqe+/ukrrpI0KrwcCJBt47nccnm2Cz6XD6IcUD0QP7TXV02C3jNHF0al4/dszQDwWy10HewZzNKfd3WsduFs49IjoRqePehtgy4/NjKkuCLtrHSEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiSC8CR1yzXq5ivaZxAOFyjZ6e0xV/fRibgXvuxhOrc=;
 b=oCA4JE6oLBNlnqJKqIu24Po26CS72pOf3jP4m8SDr5LEcDhDfnHJJaoj+vmw+sV8a7CbqRyYN5mBbqPrVjR/2W3l3s2QlRgvKMiXeT/V7JYOkx5VcK+NDsDrzritdwy4t3HIZ73OFEOQCEIHmbWehTJogoJ/ox/UADS6zqkFpNc=
Received: from CH0PR03CA0392.namprd03.prod.outlook.com (2603:10b6:610:11b::31)
 by EAYPR10MB997949.namprd10.prod.outlook.com (2603:10b6:303:2d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:07:55 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::34) by CH0PR03CA0392.outlook.office365.com
 (2603:10b6:610:11b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:53 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:14 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:14 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LG7EEd2409002;
	Fri, 21 Aug 2026 11:07:14 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Fri, 21 Aug 2026 11:07:01 -0500
Subject: [PATCH v3 2/2] can: m_can: set out-of-band wakeup if wakeup
 pinctrl exists
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260821-temp-v3-2-9ac1f8806929@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787328434; l=1254;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=gjYhUz8yAfuj7LurBp/eRjmZH0WAl/5Zui+fQkQ2zFg=;
 b=mvRvphoUJHHO/kPProKoptx0PJ5BSdpcsnEuXI+DXlI7heGlkYWgxBiIlQjwbMPVmXsLKi5bf
 VTHRR5Gv+MLDqmWehRyZGKxPd7q+vbTTOv957qKj6+4guOg4ZjukMZ5
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|EAYPR10MB997949:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cea2762-fdfd-4255-d65e-08deff9e5b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|1800799024|36860700016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Z21uio6PijaOzggwi5cd5RdmuHT71APBwBczxTbrUmAlS6IrWSxnVeQqe2BweHuwwnmv7S4Qm1IksOG0l/Wh9+KBBD6jO1KeCkytJiUMYxDMR4oljvKzQQKLYzHm2fYvBJG2anl6o+6RwfuZBSHrM2xfhbR+cLI/kdOtL2sdlCU1REKwQG9AWGJxGeJ/AhTXnKiQ+8+NuHThiX8D/wfVEptgiGApHXPFa6g6ZHyFQOfA0Rii2FrlSjifSlcUQsnvpuRtAuK45pmw5IGxe1ZuSoZtTobagPDrWvDvoZeLcnUxHSAG7ZE6mo6mKRKghhXOuuhLWLQX1AmNkcGv8HGK0NWLy6pdAdbn/mRqcvub/XCc60WaeXDmciMkB3MBCEQQPxtkFRLNM04aS8HirL5GnnKIqa9qc5XkZ4BvtcTcaOvvPKKRBm0zf/czQFqyoGbS6xQiNLYQyQWP3EXFsn52gBWvts6z8Sw72xiQYuAy0kMJGaAbqXBsV9U7hTt7bdl6+GW2luE4bL7gLqlVwE+9b3ssvOScWjszJFbOPTGlAuXk4GR5hWFrfPEtSLLNwVf4YYmCvtO6dUSbW5H4sp6PJy8s1GqNYvbn/nGFRlyDVRGWkbQPBa0BFqaWf2sJIiSNoil7F0PPuiJGg54/RNw/sKBlOTDRCPrRMrTJP66QVt2nfNzrsx0aRIPKQQKKtuw9r8qIxfMX1GeN4aX1y1Xg7g==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(1800799024)(36860700016)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YpJCmRWf2pk1A4x/LTEI1bYmay3NdfU0I1xTIRAgsG8Zn2sGMUQFL36cxzFHGytrakLhglAdmX1JOwz9YxoPwcqFpCQqz1MGtJm3nIM/R2IQPl3Cc77KsY4kMEiTEOUqdwbxgCPFEqD7ZA7jpDtV3GHMwdEzvemsfIQCDaFinPm75nnBuNjob6UI0Ic3JzWXRmjyYsK41NPPhe92tQROpMeqsGhf5wpan4tVyGQMcHOcqQnd9C6slciQ48qRM5MuFilyq66W+RH1HsrlYLCa/akAaD87Dc5kT3C+3F+tnMwRZ22SO+FNiYaFfNW4ndzcgNwic+89YqEb/HwfEW0KHnzTfAh+giJIViiUOWRaJnrtLhF7m+D4EDIaDq3O13oZ7YCmePg6yO3UWkOdGQOs/aNfQSiX7xrLHnOLqmsElSTPnCFZGA2tyAxEF1ftDlIJ
X-Exchange-RoutingPolicyChecked:
	jRI73U/alygkR9/vYJFhaaBPBAxVZoFaZwTDDXqG8PW+GtiTIv2WHkFIcP8tiDU5fUQDP48D9+cm+hvYNaLvcKce/JHsTYs69kbFU2IoQAwwkMZV/GWSjr0sip0/gzVEyVtzk5McfSYcOX/1+t7EShnryundEbPrabRQlmy1OAirFbRHqTzj2+B72iBemUKtRxxuM1XioE4zg+CiSU8tzwfNzTLHP2Tv3Vk74JlwjRARYO5h96UNlSHtM3amtfu3h7zwDYdKI3wwXcn9liDfbLtAuylBBw4zCSPY05uVA/UzDvl8rCZCSFP1BAdAWxBbm25LS7CrMM4uLhJ8SYDecA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:53.4905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cea2762-fdfd-4255-d65e-08deff9e5b5b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997949
X-Authority-Analysis: v=2.4 cv=O7AJeh9W c=1 sm=1 tr=0 ts=6a8877dd cx=c_pps
 a=3Rvb9JmgCdrss5EpqVD9LA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=DS1XZwbIN9SMuCO4tYsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JnAnoYK2kfpQDRmC9g1N8evmJjRWEklx
X-Proofpoint-GUID: JnAnoYK2kfpQDRmC9g1N8evmJjRWEklx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfX7Q0KqdW2QMUV
 /ZKQefs9ncFdjt2zN3OBoyyRhzGpUM6RzyYx9DX8CeAPbkwaVf4A3ealfDkQiF8Lpqfpy0D57gX
 oBRa/U7438GpjP6KpoONIhzMAfCY2ZA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfX4pJLvInJwhb+
 /Bms6RVQ/s+5yUu+jfom0o/vH8xSFx97d0kyZykx35RNNcGKZk8xS8mW0J/5mR5vE7To6TB+rBq
 a/qagNHFXmPsgiiGnuhytYtz4t7Q3NdV/F2+sXIQKAA/7hmQbuwL4cck6DxbS9r/oAsCaIxNbYX
 MLu1oRtfBqQrG7yCtN8zqBOc+9ydB4HtBYe9AR4xT9W1/hWFz7fh82VfAm+9XAD9zySfNDuTlYq
 WWtjrPdAgiBKoGLZ4Z+S7jyBfRTiSKQsgydEQWzfUnVD4QLAuH7JMyNywjWGo7ISzn9Qa7onqBK
 sGXcmSrrV1HbjDtqcH7YtGZdC8J7y72lJkEXNu/+NsWvQAae1kMtiMs0N4nY8s77SQJGDbqGbuH
 1UVtf2BD5LIUGjEDBMLyqAgcRTW6liUjp8dibJNxFO6C68UuuXjX24uNAJ/4CEmoeMEav61jVGR
 6fuKT9CXk/DPG+GcXeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210126

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

