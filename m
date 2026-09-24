Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E863563EB;
	Thu, 24 Sep 2026 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286917; cv=fail; b=C6ItPTiY3LV8fUtr7kmA9S/4yDeeYjjFLzfwyXWI0CCwMtvS0aMW4/XdtPR13EVPoTeDyidDsPhI8UOTW3Y4gIY7DqacxzMuGmTZdTQ5BgZkI3wHPkBcKQ+PvPpeG/gDQ+/97ag/vhdqPRQxlwq3Gy+gTPmm/TYo+eWZXIVGfs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286917; c=relaxed/simple;
	bh=5RItXA2wXp0jEY2Rd1XEHsucZ91An3UBkU9Fu0R+3Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XP/Stp0WyHgEWwX9pbY4obhR3HIyiK/MH09nKeb0+PUOnQk1Ov1iKxjnkREKGcVkXMushjS+emsQNyS5FPPfXtzgPZDoiVg9ORyJDRHKOuu2WXN3I98Ee0m8F1SQZr0W8QKlu5qZI2J6J8W8s0Uht3+GP7q8REoFl67I0ybZGTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=EDCfk6FX; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Egx8eaY1; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="EDCfk6FX";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Egx8eaY1"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68OIexNY268736;
	Thu, 24 Sep 2026 16:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CfPOYvf6p+b0drmeNi/u6XpXWJGoJuXzhWNdkOPZ+
	WA=; b=EDCfk6FX2QiJMSRo8SmwSlgO0xAUoTtSN5HlkRLmEd1EBeyJHC378rrzQ
	H0d6arvIN2gNg6j+jv+tHkyvA7h1oqhXDvr5wQyANYAG5FDEmnjuQSx97j4GnsAn
	C0MFg/gfSEfTAO8t2w7NN4FNkUCuhvg9/MhI0CJa5npYcX6GxPTpgAmWPwoutox9
	UZC88D5la5amNzHn8gQdgz3mdQEU7zIkwHSImBJt844HhI2AyKm8IJvikgbNYeOn
	+21aZcLvowK8jm9AMbjphNtp3dyqqTQEy3bGR03ttPJKQnkbBEvDbnFwFU5NY5mH
	MluWS3BY92HKrsGgDhNCVXjBAHy1A==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gw13rckht-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:55:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dolIf/PoNR/xOSxfeDnfeZxxR7v8/oYH1HxKNt4R7GVhWZHyD2unxzOio/08PfnfBLYN9//Rg8rwMNNETECbBnlmJGi+92eD0RT7GNNpcNLxiNCZUYe9jBx3vROdLaTwrT6knsxnBA/+rFjmUYu9oxvJbFW0GZRy2js0r3IbKY8H/5qIP643MexHIPpS+Tg29eQlUmO7Rz7WEcdXaAIWgA9oFU47r8feAlwX2K5yfLbRK0KZnxMKScN4AwRIMugOnW20Z2wBcfojgzeHsDw27LInjWP8kadVdzysBbrzmijUi3NfJblux+V1ezMEvT8+3auGRhobm2i9lYPZvIJBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfPOYvf6p+b0drmeNi/u6XpXWJGoJuXzhWNdkOPZ+WA=;
 b=H8NTmUp7MFE3O7i8rKEmDLBlOiveU2EwKYJJVkwHcBU2DKRQBU5ARcEv5MQuaLXvXeCNOrrT5dVGmFaTzW4fHRvUQsiADxDRQJhZF73LjtjY+v1rfEUd53Sx51We40AUMkmsYewBCD5Le5xwMGuJExK2rLYjKeTUFM7Z6CzNm0CHjG4jlKPXPzkF6OmJwI7sDCsiyZ8AygtJ6vJxIOeMulsa3VhrU7Y1YKuGmkHRFt+zFeejn2syY+S2bKekQ9uqUmLzrIdidmKTqX6PVVMa2fUhr78oBIt+rJNe81Dm/vr1G39X5aJoWvkY3LiK7kkaA/qxVQrEq+qX8bclyXkeFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfPOYvf6p+b0drmeNi/u6XpXWJGoJuXzhWNdkOPZ+WA=;
 b=Egx8eaY1RoJ0/oxfGRkzXOLfA+o2f6bgNMGjnOIjsiXVhE/eyeGgQWKTs931/lwhV7rPFZRR158ElcQZ5Zzd7uYOTgd7vI4s+ITEkDKriOCTRg6Cz1Q4OcZuoiCTOR98RwAFao5fW1wShcbLvlQf4c4qW0rFxBqdVMJPPo54tTk=
Received: from CH5P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::23)
 by SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 21:54:57 +0000
Received: from BN2PEPF0000A805.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::af) by CH5P223CA0006.outlook.office365.com
 (2603:10b6:610:1f3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 21:54:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF0000A805.mail.protection.outlook.com (10.167.245.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 21:54:56 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 24 Sep
 2026 16:54:50 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 24 Sep
 2026 16:54:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 24 Sep 2026 16:54:50 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68OLsnvl1562647;
	Thu, 24 Sep 2026 16:54:50 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Thu, 24 Sep 2026 16:54:32 -0500
Subject: [PATCH v7 2/2] can: m_can: add ti,am62-mcan compatible with
 out-of-band wakeup support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-temp-v7-2-f40defe5957f@ti.com>
References: <20260924-temp-v7-0-f40defe5957f@ti.com>
In-Reply-To: <20260924-temp-v7-0-f40defe5957f@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790286890; l=3452;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=5RItXA2wXp0jEY2Rd1XEHsucZ91An3UBkU9Fu0R+3Hk=;
 b=SLqI2QmBMJ4C4uZvm2gLxPSQGNOWL1lYU4TO4PlUi29hWhyBhOwBcXL/8ojrkgMf1Hx+soTt6
 I9lQbmy2IO+CfHvi66QcQwdeWPH18Z2+PrrhwIlPL1wYS08r/pap73G
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A805:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 821e3a64-5412-4189-ddf1-08df1a8678dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|7416014|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	sRauQ434nCHYy+yrnQ6c/xnNXQap39nPlZyWW5WMeMaACRU1uKGs06JsdPzc5whaqFQsHCxkKcIQZiAInWK50QiYkjUcJF76/hPLjF5F6TTzi5QI73x5lbSAJr22mfuP75fEab/Gso2XX4XyXslgpm33B4W4/vkil/I1bXm8sONEjBZee4lFH1euiv3Ounj+6BIDVmwQ55/RyPh18YUqhaMxHCNLvN2li2/RP/kF/EVLMApUfaJGwzLg+ZJXiAJ9B0yKu84MR9H6tOONOVxoJEAaOJ2IJrgwAz3VmStfFFCqyanIqYL8n1Oxg1w1s/pdtkh/GCqTqxuS+1Sz7mA8jFk6gEZ8pNFAb3Je9xiYIUZrTYeYIJhMMNKse0FM3DsnK+9aM9QebP0Ae4NgUTN69zKs0kbHpFovYEWYUYqbtLYDqs6YGaTegDQLvu2ySkmWYZREZYga3cAJdwOdhpI2Yg9PpSOI3dv3+5gTt7lwDF5mhFX8isYIoV1IZJuEhwoKvfXIK2wzKMsKg0omGP/a3O1ioGb2uVNMu6kl9eZ0muJLe6M91SxAgtK2OlU2EpxfMyIXpUlHvGoW/EJaaVZYvBBmt/lHuAaR+YEzKX5nGqTlIWHimHiSIwIPzus1eZmMo9kY9P1TUKNE4wECeKxaFmD+C8M4uWA456ARhV3vU+znUzCen5swkcOcraPWopBhpcFDvAjttoiHcDHG7B5wQQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(7416014)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NwzQ5hbXHibuqjA5H3gal2W866HR+8N4rzllUqTLkoqRXQX7G4z3NeXU6dctWUrtoPArRiIb4jKWzbMH1DXR09sM29G1fa3mUxYm1xeadJnMCCsPlnAv0lezlszIlVjln9J3Fzqe2AyNjIiWuLOYCynH5YEjmwsXKpEyYuANwy0tww+L6O2Fnk/owZWx5MXjzGyNBLt90cCYwRAwoWjpsprQny6lUZ6LayWcoHxHQlStM8cA7TUTvIC+9UOvmZCKMs42ro+AU3eoVJixq5ELEiDy/JpuFBIEdRG2oMydiLujRaYpKtO5TorcATfWMGW4yPWPFnu4o6ZGPpJx5ydK6coiyWP7tuiIZxJdrGw/P523CA64MYQtipV+TB56NxA1RJP21LDfLaeRJZf+ZCUfYXbmcojDZcF0IflGXoRNOJqydkJ0rcKWiYjbFwVqp1YE
X-Exchange-RoutingPolicyChecked:
	qfWzUKpuE6b1qEzJYbZGZT2P+OyXgaerIe8oUZkBb6D18MqRyNS/zlkTT5YXIZoJGuAJrFCOzF4BsbzIdIFvhNFrlSB9HuzLV/Irdqgb1MRmtID3Xflu2IKEDsW2aMXpzKz8sWRHy+67e8eFpzYDNoHUhIvzqbGn1bDM4GbTHLUyNlqWLNXgOTmRe5+xlZFyyv/Q9+mCtPjNhpK5fTjuzfhnuy+opzVHVZwGRneKfwqTUmmHLUMTIXbtb6W4qKlUL+21ybBf4qQcQCGubBHs+Pr7RuaYq0/5/GLS/CRcjfWEw/Q/vv//AzyyclxPiUl+03rqXNVrA72SnaYb5eqL5g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 21:54:56.4501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 821e3a64-5412-4189-ddf1-08df1a8678dd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A805.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
X-Proofpoint-ORIG-GUID: gQZ9jQZj75BuClpL8HOeNEPl-D9SVw__
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4OSBTYWx0ZWRfXwuRLyE6bd5X0
 QXeg4em7MPK5FqV/c5MYaczVI4tSq1vy/LFjOHVFcwwJrpwc2KGuy6jJfEGEL3XD21OzoJZLzqX
 hEo1LjG3Ow6DwymfZhoFlQNNSMC9g+blIm0ghdLWr2V51+wDAOzXSR0tCYo/J2WStjfwT19Dkyp
 ncxaLeXyHb1CLWaveQblL2Zh7ChPSVPmbrJVxM/yoDxfobdmxRodpdkWtNrthKuR4pPhWZ+OTaS
 5qchwEP8SkuWAxsSUR5D0oKu/ved0LuYgloeKv9KGtGYPKKUvWkGec6RZ3NUYxPhhtqRuvYGWtq
 LsKPthNO+7iSeTyzR5Fulq8JxkPSDWlChuix+mwbcYn+8uei/O9tLU0hyeMLgDAevsPGNi9Up0h
 1enqFE1E3ngxxkF/4ovLyccdRKxHiwJl3+nZFBidXqSJhecObwvziPdqA/7NR3rIKkpetB6Ard0
 DLtxXx3rfjpHpifckAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4OSBTYWx0ZWRfX1Ou6htPIdRWH
 AOxJ0w2P2rWO3yJAf1GEDVFeUW4c4I1ngUIrwGyrdohrZH/lu6dYNh4pa1oTV7cSk+TmdWihF5V
 8xqysBpRMvovj165Bs1Vg63aLMGHrqU=
X-Authority-Analysis: v=2.4 cv=OICyTiaB c=1 sm=1 tr=0 ts=6ab59c34 cx=c_pps
 a=xx7W88v/Jz1hHwbI4fXbew==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=q7fBzAs-YHYjZ8l8ll0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gQZ9jQZj75BuClpL8HOeNEPl-D9SVw__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240089

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
index 91a0c5eca260c19fa97c6f5724341cad0c1c95b8..815a11531ff47b8460aa3efa3075804b4f769848 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2628,8 +2628,14 @@ int m_can_class_suspend(struct device *dev)
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
 
 	return 0;
 
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
index 51dd41dbf2c9a971295994946e190ec0187addd5..dbd59730c0bc16f519cb2c40bcd8093ca1bcb369 100644
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
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, m_can_of_table);

-- 
2.34.1

