Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B543E07A;
	Tue, 15 Sep 2026 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496205; cv=fail; b=SAx9vi1JKqksHwV2yQ+fkQ+gsGDlrnAv/zW012oxSQIjxgmsdTuisFNyfqAIuduODZJmYIpPY+WQDrK5/Swz1nLsVmsYCdHUKdKc8vMkprEyiEUYm0+8dwBjzwDtli8tHlrSpB8GXxDiTi/eTwFliREmMUaUfCTRw0JxAZ38uPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496205; c=relaxed/simple;
	bh=c6yE6OF1XrjPATS6ob5A/kTFC9Vb7Y7Nb++Tz6aO5HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jUenr6cVJbSGCc2wchBZwaK+ZGPD8ivlQcTgiKj3phNp1WOSiTmNmx5HD9a5PamGRG1D6vzYbCiR7p/RDCKsbqQoA7+XLeo9uDB/wFgoTUWV4tg5FuVkK56ZfyfQCIdxHRRe93CiLuEWNDe2S/spubhlB+nIlP0DoNwPL0JZqHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=cyat6YRE; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DnY2pmi3; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="cyat6YRE";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DnY2pmi3"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68FHp0VC2407392;
	Tue, 15 Sep 2026 13:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=932D9RBiMgtetSIQ0gF6tUdqkf3STUthcdFgcM5uw
	Fs=; b=cyat6YRE0N6yU0dYlOvnupKnu8hI6KztD/Ix6RZrEpukYbYQKDv3sdLVX
	KSVPZsqz8yxCiKIJzF2roQPNdIGoS+Y6iJZlXUZ4xVEvqaFtafXMaG7Hn9F+Q2xq
	71aB/Vp9H7Qab5k6Gp8Al8ea6pVI6wpqYQh+5DG6YdYGsrD4TrSDjIlhXL/AB3qL
	5lZ2Iv5RHiAdDmfBdBIqTPrCXeHO//RvwOhH8pO5eJIWfpe4fgacxDCQKX5ljNNT
	Byd3mKXlyJspFaZd9V8JlHIAwETV5A38avWNmt95/+UGDXft2VD5LDGWo1+0S7kZ
	hG1iVnhfkqH0tqqy5dyCo+PgOZLfg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gpvpa5x65-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 13:16:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGbl4yhW6vWAlkSOm2uIGEsQlfxCwFrOZsxa9TKPZ7iDK0n/4L+fvbHfRx1FOetmHlaxgVIEyQ3Ks+bkabH/Hikj5LsyBtJy/HRQGpb2YSJiARqKEbz5h0aZYfj0LKo+6u5/KHdlvNJ9TcKjR7sNQlKdKQPRdHTu3/ReGRfBWQQklovo3Rjwi4TEOjfETldWTPHTZSrSxm3Zg3Qj1Em/Vjl2kEPPkLac2PZAlHjm6JJJoZv+x0FmzxTc6VMZ9YBenXSfaV0/EPd+G7JxFbMO6lWaL1NwfC9FDZa0ETou1/I0aqESSBSr6vquqOZ1Oj56ornHEC3AVEh5qUWFRX8faQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=932D9RBiMgtetSIQ0gF6tUdqkf3STUthcdFgcM5uwFs=;
 b=S6SwtcCDIbniHW00HlmUTbqVTiqi/a4IaFsmVxRwTp9fz0OUSrW6UfOh+4PXirI/EYA8fjIE37SkVUe8VV++Jyx0FFV3IO7r6Hnxiy3Yofv2cR46w/3+XsxYbwn0uVQmKmXVDHdgnr7S2AF8MMGxanwGECgZFggKKsc7k7G1dWsy8PHQKG7dEUsV8mZEDUmCmqWKW7P5OZiKQcHYBu4J8WDy1mHgSvRSvcEVAU6KF5p+vO6ECMcGzbQ15FY+99Mi1AS1N0PBkZgOP+Rm8Cs1YraLQKbS6Tht9V82WNOrdMBGuRE6b6bSdusWav3DKLTubKlluTLcQ78/b6Qt4TPYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=932D9RBiMgtetSIQ0gF6tUdqkf3STUthcdFgcM5uwFs=;
 b=DnY2pmi3K4ew6Dz/mBMiPLmDdPFRuaAmZl7z4nHv4Z0xwz0eD5cRkCmP7DtRNIzkzjTneJVOPdCAw0vEakdPzsHSmPIqrEmkjaMuNymmew3RcnSu5RMkOOoK/gumXjYlo5sBGJjhZ+cfJbGdknQ+kMbg284eXnoQc8GanRrhyE0=
Received: from MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11) by
 IA0PR10MB7256.namprd10.prod.outlook.com (2603:10b6:208:3df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 18:16:28 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::af) by MN2PR01CA0042.outlook.office365.com
 (2603:10b6:208:23f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 18:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 18:16:28 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 13:16:05 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 13:16:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 13:16:05 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68FIG5SS481480;
	Tue, 15 Sep 2026 13:16:05 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Tue, 15 Sep 2026 13:16:01 -0500
Subject: [PATCH v6 1/2] dt-bindings: can: m_can: add ti,am62-mcan
 compatible
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260915-temp-v6-1-ddf1411d63cc@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789496165; l=912;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=c6yE6OF1XrjPATS6ob5A/kTFC9Vb7Y7Nb++Tz6aO5HE=;
 b=1vD+z4COKj24mJXkq1wQH+80tItfhHwYY2EqKWOx+LhOnJlYZK+2ErpFf7Y6G4+uTst6/fFOo
 NRQUQBw3wnDAlI/QK9vh38k2kqKdaOjOTOKK8UbYVIAs4mREGbErC3V
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|IA0PR10MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: c8200ba7-2017-4a1b-c945-08df13557665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|23010399003|36860700016|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3TLNswsitAlCGwAIcqreulSbL8RueTQOuV5fMRoGvDwIQFpld/ESPU9kRQlOl9rPKIrZ8Qa+OcR66R6kQlPH1UPvXLHHntvTSfB5/gfUMVJh9boLkiM2VMSlPMZ79MyAq83XX4hCF/YoB+PpF5WNE3sIRi5bT4dhIfaev+SDIBerhjpJFyZQMukIkiVGmXlZxO3V8uOo5KGU594tQTZqLgRSNWOyt0XZwQrKTgwO8XrQfhK2wViYEiycnu84vmfmO/JKWCcxbS+TGzSXHG75HNrm7WDbOJ2bAYrOSIOyPSMQUnv1ctJpkd8SLr09bmi3NO9HdAAcllrBIom5pqqgcccvzt6LOvfIzMTURazYOmLTap+n/y9qhDVrIy+sEVtnqWZav45ccqHlvyidjLXvmkRPIh1UPJbxt6dm5emN4U3Bv9Lo3obvQhvjbYIiY8g3w4Qcdep4+k/wAVSQod/A9icOgq9crRqSiz3+/2jHq6yK/g7V39ORnkyt5oyuBPRwKudB16CBxjWO0Ytl1UpEpn8twD7aHvC5Cf1+Obx6yD1PvRLK650YRSCrIICdeDuWrJ+vZHFTyfzCTcl4LFwLkmfrxvcMFQgZEG9/EpEzPTMdT4fkRAkufc0CqWtZpgv1iraNH5E1Xk/GHNSkLM4PWX4LZzaPlWhT6xujfESq59XB3v0jktwAcAxMEZ0EkfZtSYjaCsrl9yUX2HQDAaruMw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(23010399003)(36860700016)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s7ucnHAm8vEz9z8zEMCfr5N8E6UMo7QvZ6+/aBmnzUhcNQM4YPAojOY4kPLmVNxhK/X6qs0n5teuDUxYNb8Zjc5P0YPf7DOrhBpmfzn8zAZL2D+6KeP5rPq1b02ydTWHpuTsA1LXbKofoI3j8rd+g3umvimYepOP0DVxXs7FiRKc0Y/8VBeReVIrsvSJ3ph1+/WeeCQA/hcqk3a+Ayu9DjBHNjVetb3W2BAeTjK9hoe8c9bTDglfGFKHBOc9W7hacijiF38t0Ler/jAneYAM+yUrN1U9akANx0DjUDZX4DSBZSWlTi+IxnQ3s49OtsYrLUn3d0Q/itC3AlsPi2OT+DNDihUYDcvLNBfA5RRPEcj/+T20SDzXlVvRbi5Sp4K74m8G7lno83cos3qcEovE/tQHdWNQvWRCnarQZdr8qUH66KKEP9vbpMdzpSR2d710
X-Exchange-RoutingPolicyChecked:
	L70RiCTSz4bLFByCTkD8oq4wajwa8x6mJ1fSdp34HJlsmfA+LdMr0yjUpo3U9XMh9stMs++Qt1hvEZ6zhDyPhqvpc+ToNr2PKPPryUq9ReHEcf9m6QH9rn0DxvH8CuDXV1P0HZJ7kHLNJy4kLg9n4tgb6c5nHxgQm9Jcr8sFthbpbR9Bah4MFKs+X3eYsMbw1tY9wlFAcB49LGeL5GEUCd1KcFJMrHGHQNFCzUkjSFsPooylMgFUViO5k46Du+rxaFu8HoKhwU6YQfYUgPTQJq0v1a7feTbjc9ZJ3kmdgiB0uZ7aaTW81+Yufdm6NQaLLfbYfSmsedXcsDTdhkTo8A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 18:16:28.8262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8200ba7-2017-4a1b-c945-08df13557665
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7256
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI2NiBTYWx0ZWRfXzq0Jfxxy6Yqe
 hwZ5WFOulkUFeyZUMomW75rmaqHTg4WHALYUDmvWqIZWFKCR6dR9hE5d6ILEsWUbF4BMhE6XY4i
 dCmf4HNugTN5ZbzY8SiuCheuPARBinTICdicQtBT7TcXhdzSACuqRIU8iE32dmPlnrkpuUEQDxN
 apqzgXzPZ0ysuIAGp32Rqy31qSZ/82eDzmBwe8iuEn+205IsNdq2srBlNENloicq5a/44IL7oee
 6r8b/frC9W9T1iGMjbS5YulZPrOHa5RgcO1voA3cXbjncEWPl0YQbhdRqY8E1jQUEZ33XeIF3yd
 Dz5uAPWSYVUuyma8Ox92TpqniG+H+ipLpngZb92TA4qXGVSZ9t4uiIotkLj9TspA9aXC3kbDO3Z
 z9eIqwaa3aqMspsDhwhXT3WTqJUEIv8eUUXtX3qW1mVcMySyCuF1r30Nhnj4gZSHGdAMFkSZ6zP
 n/34I/2uPGOYNdK50FA==
X-Proofpoint-ORIG-GUID: qMpilez18qtd7srlZZgLmygVgc2soSiK
X-Authority-Analysis: v=2.4 cv=U7cHnuru c=1 sm=1 tr=0 ts=6aa98b7e cx=c_pps
 a=Rayal3q6byrlEF75E5QjMQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=OmYI-GrVpSx3wQj1XFAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qMpilez18qtd7srlZZgLmygVgc2soSiK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI2NiBTYWx0ZWRfX3sBIINn6eU7+
 blwzSbQrBTkZYXQ0ydAa8pa0hE1TPdqH5Nyp4CsuSNr+Dqn8HDGo8W7ppL+HYgXQN7iBAMaLdBY
 WKNB6gGMy5ao69rqrWeX1PZ4YrIaX1Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150266

Add "ti,am62-mcan" device. Device is fully compatible with Bosch.
The device supports out-of-band wakeup capability.

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

