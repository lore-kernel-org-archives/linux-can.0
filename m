Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A13D1AB3;
	Tue, 15 Sep 2026 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496215; cv=fail; b=kCaef5SS+JSaRymA5z3tzsWTe5DsR7CNV9V5IXqMCWI3D3+PNQjdeN4Mt87/dJgm+0G7adEUwOprsKussYewoyWI18Ht+0/8U3CQEFo1Sg2G5jbURLVXjNMa6/vVYMzB6Iwp+Jv1bq7tSdqbrZRzN+HyW6uPeoxTPxaX7qDWtf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496215; c=relaxed/simple;
	bh=08VR900awuGx5jIMqORKv5lQYS1+5vO+R1+adBIH8O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UNEf0osP8PPa9HR8ZsET6aTQp7tEelgy9MGDEtHFG4ILUjMvLo9kgAV+v+6VyIje3uW7+Cz5zSXP+P4oKz7XyBh9bhVBwa6bqXIxrUrj0RlVFASTNhv2uU139oLgg9/UyMo6GEiXZHXj7TQ6+BsA30mY7cRMqq0ZYNzr6bDDBbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=GzURV2lj; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qdBjAHPS; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="GzURV2lj";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qdBjAHPS"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FHqm45970958;
	Tue, 15 Sep 2026 13:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=RvQYVMI/Jrqhn5l8yZaFA+svtJ5+ouKsvPHJRmGO+
	GA=; b=GzURV2ljhsnxt6cp7RBdkBOZRiNjWeidJo8Q3iPtzrZwni0jONnjX2E6t
	SEpcrMie/hm9y3E+blGrW/wsd/x2OjcJm29pEEvxrpuNQZ6DXNuV6CFGOENCsutH
	PMMcVzZc1oeL63F3vjvJJMRm1aYm+M0/fQ6QD/TeTlTp6hK3wbtxrZJ4wsJmfA5S
	01T6ndONhmGnRPjCjx7Jq/WvRzNCXD/B/ukAApkpPi8+N+8Db2x6gEi/j8thpc7C
	61Yd7T9HNzPWq4aXhQLDofHbvkKO2+v4KnQFeOgLy/uNSB8PZhbehS/XeQ+bnY1L
	xVNHGyXwfr5DSSG2TXc9d53ijkbUw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gpvpjfryg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 13:16:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaHvT+gMoF8YvBSBUt5fFjScks31rAb5iS0FPYn2IqGADCW3IvNaMatLY9H2qIBTFgL9EjI8Zkk45p+mqUNTHD9wMrKJT2Kxyg26zjgrHLR+sGagkvumiDS3ksxUCzalgXQmCD+0O4HnIqdYP2KlQMrTDaGChguB0kIrXorNi1DR1Gzqd776dl8PObu7Aa9cJhaaLZQaN70HqqX8G9a2GMenNoYvlnSSMBtt7gmk6Zkf3Rh7pUP6YoDUm4Y/9yyamK+0tKZ8Y+235o81kx+7wrGjWmYAbN+twmU07q8Dk4ONPwmXWYcsdtrB3cGVBNEyINp3+cqTKNqbLc+MCXDyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvQYVMI/Jrqhn5l8yZaFA+svtJ5+ouKsvPHJRmGO+GA=;
 b=WVDAzkgK/ulyixIo3b0p6dLF/zGVK7ojyBbg56Hq/QpSmEOJQ9oeuxplwtvSd3XBqenSlVpW4q+d6QinEaGYQisHqnZUHRFyIis/ptkeFCc0/6iMKJsS9VUC3HpJ/ogVOR7jLVns4+sJ3XrZhWUcLjJ/C+m++QwqGzp7WENTXOseOzt+/hHmun/ZcIKs4T5IE61F5ED7paqYdERT7n9gVgbQflVKtkRNy1zYw1op2xkEqzdVL3QKn9hCPIwEJR5pmMxS4jxsfQAdzaJ8fMJ4AprBkkvYR4HJ+++2Uq6GEl1Ykgv6Tm3YhYKczZ+mqKWNXPtrEy6J78vYTIyCP0QyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvQYVMI/Jrqhn5l8yZaFA+svtJ5+ouKsvPHJRmGO+GA=;
 b=qdBjAHPSOZ1Le2zCADpeuIamRJ8YdYVkhm/k0L1E8VqYDSX+W7XMDEri3bJd6/rIJAwrWb/RHiwGRfSpdyu60KAjLbM4T9SRoJmwV2dBImQfM+XGI3ra0N3tydUUA17P8RdfuY0H5GipaA0+tRFnMjauMp/iT0G0IGyrggbx5KA=
Received: from MN2PR01CA0044.prod.exchangelabs.com (2603:10b6:208:23f::13) by
 DS7PR10MB5087.namprd10.prod.outlook.com (2603:10b6:5:3b0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Tue, 15 Sep 2026 18:16:29 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::69) by MN2PR01CA0044.outlook.office365.com
 (2603:10b6:208:23f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 18:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 18:16:29 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 13:16:05 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 13:16:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 13:16:05 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68FIG5ST481480;
	Tue, 15 Sep 2026 13:16:05 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Tue, 15 Sep 2026 13:16:02 -0500
Subject: [PATCH v6 2/2] can: m_can: add ti,am62-mcan compatible with
 out-of-band wakeup support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260915-temp-v6-2-ddf1411d63cc@ti.com>
References: <20260915-temp-v6-0-ddf1411d63cc@ti.com>
In-Reply-To: <20260915-temp-v6-0-ddf1411d63cc@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789496165; l=3456;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=08VR900awuGx5jIMqORKv5lQYS1+5vO+R1+adBIH8O4=;
 b=F3C3vL3X1/Nb/+2SxjqU/8QbCx2rHwHFOiln0fE9ftw/c+REjHJ58thL2UCJnn4ny6gkQ1rkY
 jsDJFmBfl9xBqkFjgK9qnHvBN3uWBNleupG1vJPF7wdC/wy5HHteZKW
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|DS7PR10MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: f2db5200-695e-49bd-a701-08df1355769c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|23010399003|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XDdX7X8VAilCB0mNrC1nxvUdt+khU6jZ5Os7jRQC8uc7uwgUED2fUT/Ofi8xXKRg6VeyVWH6xnZ/6RB5FYbyh3oHrfWCoPHwB5KGh+vBjaJImhhsAfSEl2HKrbNGQF0yUiwlgQPgGQ1pDHyTz4DXrzEvapx0ezMV0K4roCL+EVXuhbRI5xxbZv6c1ZUBc0ZvbSRKJmICGWie0BYCl29Nqw8NrZHgINW0XSNSKglc4oTlAl65Q3gu4nAGJ7Q5krfK0BxRdgGMWHfwsawhoc1HPkygYMIRBYFo2JeE3AFNsu9HVZG0fwFHGTnlcQIFVjtsLMC7TXo03oTANnbpfu2bvriJ7jyIO09pc93SXdjMtzzPBX3gq+YRhskOyQBgK0wOipYhhG6aD44LNAxDUsQAZ2XV65Tiw+e1goOjJZAkLJoVMTptGGCyxrJZ6PL5RcwXAQYcuA5HAYxz/My6m0XpZUpod3V7v0STCYwYwQIoI8r4QPvxTqVZ0yfv2XfxNH5W/NJmzbTNQ+OKzCKFCMP3G/xXt45b/V7UbHQTabMbn4yhUmh+XLCsGeTVa47XQWaPeqquq8fmnpzv1+S0JI8rOFlz4EeONTgpOEBWzue6qaGzJuU5GqK0V4EQtYk+jBSs/SUGgJOnXoaSaAiaFxt/BzWfa2jTcGVK2PcAZHo8WCSqZkBwSz1U4ePCMPvUDQZ7Tf9AsojrsSWNc/H+hsf89g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tgWt+PxnrX/0BdOmipupJMcy4AfS5wC9c/YXeOeNglOB/QJdv6NIGlFCgY7Qqorc9dwSdxc7q8QUcaDl7tht86KPVDoYaTGAkKmaOXBjuLOoj+9/V7lffD2Pn30HdMdHN0NBbUAbj/8H78vcfxZa8yXvR2v9a6Pl7sCK2U/XnjXvkZ6ETSwEXstYauTjpxiJdoOVa5aCwa5imjWAO9mNBQdtixaiC2X218wWpOx4rWkRoBvfo7R2fRx9OUMOcArcohJKhZRuZewSAPu45r2CR/QwiMld5IVpTg1arAhbENiFs9fOwOZcJ7zuqRYsw1/i+dvAyeyUDf7USA2aIkq9aj568weBsH6tPp3pbGryMYUE1b+OBepCcceNvraGGaeDuV0fFzwnVJN8mdLnnmKRHay5AMia8q2x3GTeHyih2T955lNKPOuTJMUj80jz+vEW
X-Exchange-RoutingPolicyChecked:
	mnawVHbpWA4M4HIu39l7AOJlev2mvrTLvr4yje4cS4oEwN/snZnAwW85Kbz+92bxZkS60rutAQNeie6OFH56dtJQ5A6XBkfHRJFrGYmrD7gKY03mTaFSMjLwStwsnY49p0uNpIj3CtLeTLeSdlhH8qDncgKGLZR2DnkiF2gp3ZtOtfw0RG9AD9Wfj40RXMr4kOH8wfjK1oF3heG16VSSnBx4JcRRj7FByxy1NQsV8UisQ1NGbYjt+CNlofyq+sooLHmsnDmkjSQ1YiB1ei5Ost/UlfaraA7zK4nDIkFYkMTTibXlQri0tCD5KNqUa+U7V1C0oAOIgnZdfE++Kln69Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 18:16:29.1788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2db5200-695e-49bd-a701-08df1355769c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5087
X-Authority-Analysis: v=2.4 cv=KvnYSmWN c=1 sm=1 tr=0 ts=6aa98b83 cx=c_pps
 a=x8GZ0b2gSoXatiKXRdBC2A==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=q7fBzAs-YHYjZ8l8ll0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jk5pfJqUy0KKDc80UUgL8MP0Z3xPKFnx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI2NiBTYWx0ZWRfX0P5qcTEaMRy8
 B+FY6VggUlxMMokk2Q6WH53s1KosSH+YvnKZqnXpPr2Jjei3LIwLxFYRDv481YEkFv4aDd9b2AX
 vkUEh9kC0/KyauH7kFiouwzC/VU/NcoyLnuyo1cAS4Aweol6bJMX/p5mqnDxQGRS/KlJnwm/aDS
 FaptklhijZlR160j6Ti8ho1/q8My2/1diXVlZgDAyo11KtLDrokTu6OYLvk7Y6Pyo5YikCVYn9J
 YAJ7yEwVoxn7EnfcxlkGYBzp/Y4imgpb4Qe4DPXeP445qjvTPYxyDahzhTGBvKYxJ+o+aFAnrWP
 bG2mi6OtD4ghkyMyyMNXf5RE33UJLMRMP4ePdmgpjNVTndjFZAmXuGwlUbaMOVPhXk0XWm2qDOI
 3Z2P8iBddtgX7sj6uHqRaZeu/BoK+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI2NiBTYWx0ZWRfX2uXocv445W50
 SurPFy8S8SPZmSPGOmzBFldZE50/CSFPQK0ckfGQzB2rCTYFcs+TUSZvH1kUed9L32IBTKR9qRZ
 7orE3F3sWF4gMu1KLLXJjCBYtUKpj2c=
X-Proofpoint-GUID: jk5pfJqUy0KKDc80UUgL8MP0Z3xPKFnx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2609150266

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
 drivers/net/can/m_can/m_can.c          | 10 ++++++++--
 drivers/net/can/m_can/m_can.h          |  6 ++++++
 drivers/net/can/m_can/m_can_platform.c |  9 +++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16f80607e150e2ca2950616ff2c39b7aa13710b4..67ac6995a7f27c412b61bbe235b4aa0f5980688e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2622,8 +2622,14 @@ int m_can_class_suspend(struct device *dev)
 		cdev->can.state = CAN_STATE_SLEEPING;
 	}
 
-	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
-		pinctrl_pm_select_sleep_state(dev);
+	if (!ret) {
+		if (m_can_class_wakeup_pinctrl_enabled(cdev)) {
+			if (cdev->out_band_wakeup)
+				device_set_out_band_wakeup(dev);
+		} else {
+			pinctrl_pm_select_sleep_state(dev);
+		}
+	}
 
 	return ret;
 }
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 4743342b2fba3823819b9e2bc5b085cc0fe6d1e2..da64e6bbcef2a721a330e67fd852ca4a703c5794 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -132,6 +132,12 @@ struct m_can_classdev {
 
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pinctrl_state_wakeup;
+
+	bool out_band_wakeup;
+};
+
+struct m_can_of_data {
+	bool out_band_wakeup;
 };
 
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 56da411878af0185ff9cc512e325137428a68255..9deded10e8a6a99eff5ff1a78696f660db443db6 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -83,6 +83,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	void __iomem *addr;
 	void __iomem *mram_addr;
 	struct phy *transceiver;
+	const struct m_can_of_data *of_data;
 	int irq = 0, ret = 0;
 
 	mcan_class = m_can_class_allocate_dev(&pdev->dev,
@@ -148,6 +149,9 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class->is_peripheral = false;
 
+	of_data = of_device_get_match_data(&pdev->dev);
+	mcan_class->out_band_wakeup = of_data && of_data->out_band_wakeup;
+
 	platform_set_drvdata(pdev, mcan_class);
 
 	pm_runtime_enable(mcan_class->dev);
@@ -218,8 +222,13 @@ static const struct dev_pm_ops m_can_pmops = {
 	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
 };
 
+static const struct m_can_of_data m_can_plat_am62 = {
+	.out_band_wakeup = true,
+};
+
 static const struct of_device_id m_can_of_table[] = {
 	{ .compatible = "bosch,m_can", .data = NULL },
+	{ .compatible = "ti,am62-mcan", .data = &m_can_plat_am62 },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, m_can_of_table);

-- 
2.34.1

