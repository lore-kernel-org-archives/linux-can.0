Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794950574;
	b=0n1yyukY+x5lFmA/e1Pyn5rlmIniVFUjCGlLdFWnTHopkA6Hhe7SiF+BZv13beJY3Rlt
	 gIoOhG48vdDadmNPCTsRnQhWNk34GtrksNiV3flczPkXW/SyJoUk9/df8Usoylt5a68lE
	 3+iMDkbYY5heure6jC/r9tnTrXjf5bwz1Jstfu9FtUzO/S/EGV/PouawbZWFWnyFIEXo3
	 KtVYEIjub+zpnvoJqNy7X6Zasp83M0NfvBJQW52wjXSPANu9nJMQ0ctGqkXJSJgnHvH5+
	 kvLVp1l9R2ofK71novDvPE3dE+c6Rhlz4Vzgh+mCd3UJNyGvTiX+viYBNJzk6bdZxdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950574;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TyMWMRgVmuopD23N20wrSP2QWBfFOsn8pGLbQFYzhoQ=;
	b=D0RRYy8DpO+KBc+Fr8dzejtFptDomXA6BZs2e/uHHhL1hprlxM156rPM6l47bPxU50Mt
	 gI5132SA+6N4x28MAkDlZLfsF5aqEW7atn/GDlZkSqBZ4q7yDb1Mdo5VBnykJVfi1B/Yl
	 shxwiP+MO7iXJ3FARJansK2hKGzPH7dCE6/JnEcmMGsUruKUbZsrH+vo4lEjE+aXJM15i
	 cf2fZWXjjDuFwAl+Hm5EU7Lcn9gUt2YtPNYSB9ERadB/TBq9lOWUcPP8syH58q/itNG43
	 autVICvTKZwa+/5pkmdjrZia3kxrgNcBxxUeyf5e0XHuPx7tOmozUyKq1KFbNS0VuFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=FmjffDSE;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ZHj66kRj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02436606A32C;
	Tue, 17 Nov 2026 21:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02436606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=FmjffDSE;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ZHj66kRj
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHKM0pu414005;
	Tue, 17 Nov 2026 15:22:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=TyMWMRgVmuopD23N20wrSP2QWBfFOsn8pGLbQFYzh
	oQ=; b=FmjffDSEBbLTM/Lxpvsz2Yr80gIEDn34WH69C898awQsmvVWJzFkmh5r/
	wdUF10NfFWwqa71AHXkjZinqp6I9DpFfP+XHkHngFAYq1PiBHvM/HL86Phs8M9S9
	usAOX4eJ+PCfrcryM50t8C6fouKhT2xWgXJp1IVDQqzL3REKQnDdy3Jw1nHd5Ui7
	9qkNdB80KZv8QA2grneOi1EuO7z5zac4IacJj9u7bKjyKgYN5rKMaLya9GiFeUYX
	+P/gHN86N2RrOlX5is1dxmAr3W4H9MKMcQcyD6uMV2pjz5Ci5YBs+9LaawheZvtd
	z00Ny8r9JQi4OiHDYxpz0oOvtY7dg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j0sy79x2e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:22:40 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Witx8ryALo1V1AFRhwtOf2+m+4rTbAxCEH8tzyYSlvftCodkxWV7Y8n9lg09il+kQtuBWmrVNiG2mSrZcgOEV9gPdmEjsRaVK9ZXutUIRLor0JULmSmWUpAltE/qFhOTArXaaYIc8rQnYCKSVP2Xj67oUT7rup0b9qmtD6MHKKMebhm/u8lBkBeBbGStQkDVwdNvyIPdtcOLsUqolV4lzYlBzDavAKMgWr7QvLHicKyRiEmqpS6n3YeMdU3eIfwiOIDGKXcZYmJ29dCLcINJfDX8Rea9M+wqOg/GO4zy4RqelIZYWwbLrRrIUMaB6j9JKkVDkTSvB7Zynh/lylZtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyMWMRgVmuopD23N20wrSP2QWBfFOsn8pGLbQFYzhoQ=;
 b=BgXcVHZMvXUvr6nMmtWEX0H/+/68PLEQzh2GjENrcGMpH0iz7YBItIcCYk/m85hAw8YKWzNiYfQDJmGVmbsSLyr4LACFRRO4S5bG8mzxdWUzm2bcPo8q6HH0VwQjuEpQA7xie4bQ0YpjKD+grJxD+sdQpyg3DYt06gXxECOHNgogb1FLJzB443rXG5C50GSrjGNJKfp9zeR2fFN/mWT6D3sYIcrpBrSDRmdOWNUFcrKunmFhA6XUn6QOSLK4aLB8hQJTby8zONqCODA+8VwvNyBPLFssK7xgCvm19cXTNaAaA79VnomSWsC/j/54jJHBpHAykJ/AOsxRIQB/F006RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=samsung.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyMWMRgVmuopD23N20wrSP2QWBfFOsn8pGLbQFYzhoQ=;
 b=ZHj66kRjtG98VQJ2RT+9m+wiIjxj1on1BOuwEolStXQFkO5dFfcINxvWl57eEaW4XYZRbphqkUK9Zfr05X7Ji4ZXbrwhnX3xE2S6h+I6i/vCBgBn5TLrPas6nOi2dVhBulit7CxfjRyxYj/3zFQ6y2CZh3XQA5fYSZ3MsO0z0jg=
Received: from CH0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::18)
 by DSVPR10MB997845.namprd10.prod.outlook.com (2603:10b6:8:45c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 21:22:37 +0000
Received: from CH01EPF000BE946.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::af) by CH0P220CA0012.outlook.office365.com
 (2603:10b6:610:ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 17
 Nov 2026 21:22:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH01EPF000BE946.mail.protection.outlook.com (10.167.244.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 21:22:37 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 15:22:22 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 15:22:22 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 17 Nov 2026 15:22:22 -0600
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AHLMLg8563881;
	Tue, 17 Nov 2026 15:22:22 -0600
From: Kendall Willis <k-willis@ti.com>
Date: Tue, 17 Nov 2026 15:22:14 -0600
Subject: [PATCH v9 1/2] dt-bindings: can: m_can: add ti,am62-mcan
 compatible
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261117-temp-v9-1-1d094ff918c6@ti.com>
References: <20261117-temp-v9-0-1d094ff918c6@ti.com>
In-Reply-To: <20261117-temp-v9-0-1d094ff918c6@ti.com>
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
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794950542; l=985;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=9kJNhrnBNSSZr0GNgzQSrJwJfikalNYUCy3igbIupRg=;
 b=IlLjAYO0ATZszBpMin1HC7ZrKDippp1nLs6wq0CZ0B5Y5+GIV+cYI+tF8/LGqCJGLOh7bll/b
 pS6LLZPX87XDY/aBC41EWbwf1s9oVLAiBbALhFkJy2gb2Pl8HvoL7Fd
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE946:EE_|DSVPR10MB997845:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b44f21-7dfe-4184-3d43-08df44f0e735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|56012099006|261021123027099003|261021121427099003|10067099003|261102123227099003|261009223027099003|261022113327099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OYC9yz6uJ1CyobuUEZM6Jl7m5t3txAl0oGaZEhHESm4OTsJvULQWKOJjtmnnpMB/rYvI79MuEVM337CRr4zK4Xt5TVX/9g/Exn7iy6+MURFNuTyARZw08TRfj75rRgyf55yv3gzJyMhWnNG8xpdirfwq2vXr/WX9ihhDV0rv2ei9Pkw784+4UkeofLOu2z1X0/uf9NozH8kPkBETMhlGawksbeJtV9DxNGHGOxVm1QloJDX58wShXLXUCL0vXDGNRVcY+5r7EMjB4R/fgC/XLDkD8pXnaNXHf/7BTOh+sOZtSbOcIzldnl4X3nnzcfGSthyKW4l4sdYHPIY6BwTHbbxlbyBHqSID4nJV+6YwZhkY7q6r/vm0dmezHv0NGzQS9MeDtcK7i34yRdA4H+f6cOShH2zBXfN/PbZIWt1foTRpR32RIGYSJLeqBabglDw/P0UBeia9f15MnPxEXYQnvoZ373u2IGibf8dFJ6QwsFrSg1nPumbwkUpypXAicIh3b3bf4M/c/ssIP0d/1c4a9AEAdX23t8XupK4OVb/EppYtpMbb+R9Ad0m8NSV4W/c5mxiRVrmCKGav8L88RasTjUTAVnrcFcnugtH0TLje/8OWL4XlOzIqqtdAhqJLdgCFhs7BjwUE4g/nRW9P1q/bgWVuuP3rfBahtYBBJy4Hql2ciIdd+Nn+dLkKY+2eZSwKAUULgkD1N68v+AJpM3cP+w==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(56012099006)(261021123027099003)(261021121427099003)(10067099003)(261102123227099003)(261009223027099003)(261022113327099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lMi5Ozn/qCcKBnBgEji4yvg7N1WYVkigqWj/MHkn04lWMeuDWnOevZ5dMBhwexPv8yrzpMz0p85uSWghpkW9Q+RnubbyCsyizEizTFjxE8bvfsrACof6fuHVpMGX3MbmkvwEEOQlxtFByMxW+E2tA/4RhDj2dm9ETz6iYzojR2hmFQI6rdHqNuDVkC1b9nxbGsiD+xRTlmMTjB2sbQn7YTkkSeI1HbR75f3LRsBJ4yeMFhQmVMmhGZWhMIz1wB05/r5T0G53Y113FLfeqJN4kljN5+iUrhY4cUcq/jIGyiQ+mrtS66qTUJVJTijPstM7VLoy2ddC0Fl0R8/6px3TQJt8BTmXusp+kKPueVOazZR4CL/FRwc3TU0qtPPlB6ZcIUe3rMqXHhuJLLlVLM4SfCqJhi+Ky7a7Km3YgvTsLST4UvLz1mgCOA0f2aVgfVjV
X-Exchange-RoutingPolicyChecked:
	UDBBxkFOn1pqWJaPz9/N9RZKIqV+Z2xUdkvWa8pDbZFFbLneRVZPshAINe2OGI71l+vGoYbPtpoJFJTYOK/vAAif+brV5Uu5EHIXOWJmOY+5Lel4NfYf0xmL2wAgS2xMOOuXO/3oTDI6HKoP4tEUav2CRDU2Lb02+LnlwTXwZWqVOU1UDZVHUGSBKqEbXjQdxPxWezKSAW6tZh2+3mIZsZo33yb68Tfli/9f/twqIb691eSLS/NWW50/jxFuyz+QyBBPhZmfqzn8KdIJoTCiChMDby1JWdr+MHFAr5t4rN11waeZlv0Rky6vnAAIy0oVtQE9FY+pcHVIDXadwL0gbw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:22:37.0681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b44f21-7dfe-4184-3d43-08df44f0e735
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE946.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB997845
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4NSBTYWx0ZWRfXxfYAlfNzBJ7J
 Kng2zoC3Ut8Z42W+cMXMS5z8Z6VqzdP11/qpjKw8z2rGMJnyiBRWh1jAG4DJN0dY3GL1yvmX6LG
 Rzh8XZdleQ62gZx83Gyy30f2VkO8iEo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4NSBTYWx0ZWRfXzfsWjNHYKlkw
 O8p6x+zQ0JoZcIMKsz5s32vV4wwx1sAKFk3uzMbz5gQJAkvtOyI/+06EHBo9XEDpUSgZLuIMZKy
 y/TTh3hFPj8gGEACdxvCGWzxUoD9/9GMpON7MoVSYHUcYHACSm4t58t/WsiADdtt34IgiZ7CpoW
 qAWR1p0y1HPhomSJWTZmsUd9DnfeYDpIJrfm0jcu8LNhZ3j3+hUB+ZNX5rH+WrPRJYa8FekvJOa
 Mmy/YgoeqgYRskNtIqq61J6dWe16tXARni3sbuJzJ0vNCeSl/oCV/N0wVTZreHMvvrApMRyPSZc
 5P23xTV3miTZpp7xhdLqKA1jftzLDsbgJpDZZTaKlLb2HRv5AY0rCnxjlsxjGtVLC/1jYj+FG31
 zx5z4/d9vUyjrQgp1ZjnAyZVB/4B+a8Y8PBGeV3XLbnwmvWj6TT6vXxYKfKX2aHmcRBumnlNNL9
 JIEfWqPd/CxjgQHB9pg==
X-Authority-Analysis: v=2.4 cv=eotKXYpX c=1 sm=1 tr=0 ts=6afcc5a0 cx=c_pps
 a=eZaJmiuXqmfvnt2b4sL4XQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=EUspDBNiAAAA:8
 a=sozttTNsAAAA:8 a=OmYI-GrVpSx3wQj1XFAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hyXlF5UyiKAKrFKsVEM_6uukTNRTSVrt
X-Proofpoint-ORIG-GUID: hyXlF5UyiKAKrFKsVEM_6uukTNRTSVrt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170085

Add "ti,am62-mcan" device. Device is fully compatible with Bosch.
The device supports out-of-band wakeup capability.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

