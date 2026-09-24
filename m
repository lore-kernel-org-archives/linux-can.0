Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED274EB847;
	Thu, 24 Sep 2026 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286918; cv=fail; b=eA/ssgnENADZfLufeP+QnnP6qWpo3NlIZUWjV7SjMvw+3YGZkEAz13ahsnD1/hboBEcpjrRcrrEnaqqbdoSoODxSgPfYTxr/rU3/DSjOtqZVYP8BNUsqTb7z81OZxcgpehLkmegdTQGRN1i/YDvv/ZYHfprASR10pjysP+a4glc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286918; c=relaxed/simple;
	bh=Lmp832RXdm44fGe31GvTOpUgBufYNHo04Sozsb5p1Tc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=bPqQQzfOjKYhNMLoXHEWIFu9u0yLvirK7/wKOdtRUFizThPwjdxilD8l18A7UnO7gWQ6KgdA1NlCiWIutvbkhKnoHGshX10zFIujSi5/b4nu3dQNpVczBsELPSejHkKUo485t9QFgragljHHEp26bEg+zFVk+hogIURG2eF/gAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=H4LMzCYT; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=haPTDYs0; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="H4LMzCYT";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="haPTDYs0"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68OIeqK81294590;
	Thu, 24 Sep 2026 16:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=F463ofG6GsjG5
	2EoIvrS1iU+SeWTg6mVU3u5rN+CHHA=; b=H4LMzCYTvOoDAFT6MlleamcOQcK6E
	WLRPxxvd6GokAZ8wRTPHkpj7dESmpySWnvfbh0jFtSF+b9uOQitzRK/TBO/waFaq
	XE/BtOpWhjAfXY2hDzlM7bIW3PaDQhIvO974HRk7BPg1n/VkgQSN+o0F7g0+fPPE
	j6SkGuT8s+Q0T6N0jtG1biw8QM3z8KGpSfDT8XJo2RSs5XIF9yaQB6rCKwq5I1jg
	aCKgoFoNEcpNWtbnWM2YbTm02Jhc9V+FMrYEHpdRnTARDj5i61YK7vDf4wZZK/rr
	3lciAHyvI3JOVsfAy5duatW4zJ+V8/+bXfpHE5s0SCep112G3bUo3SbaQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gw13tmjce-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 16:55:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qN1C3AxxFd2mbvWfT2DTc+VLQqdLT+A7NQPWrv/KgeYeKRpKDyox2MK1KJZxfapqqd8vlp29lImb9vUUzPc3k/KgrcPfiEwUg6ccf+t1sC2E89NTcIIEgpXvv2yA3tPASiozTm/Qw7tYLlG3W4MgpULRXAtVnS4UmpbOqDXU773OyciHn0t5hU6uxHln5a4x75YGdAa6dU5xuE+hQg/TGNCUjabvtgPGuNq2P8wPDkUfOHrjfZBBpeX2QlTFUFbImAgYJHD6Sbrdb6QTxwq9tn+UMqQKJ/g9aj9KDPWWNWNJcAy6nqVumoCZSkG7kTChJMXagAP7uVJSPKQkS2AnQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F463ofG6GsjG52EoIvrS1iU+SeWTg6mVU3u5rN+CHHA=;
 b=lsoLB8LmZi+6R1HvCiYhrfsaivCdd6BNj5XVIeh7skQBUJsrm8gTKN3KaXD9sEEwCNxwVWO4tLzc4pomLdlpr9l+MKjxknnOWSUvCXnyzoiTFG6+0wLGjM4zBWAiitLj4qvOyr5dSIRkImj3rsNZfn9FkVDWwG59oUDzGBybpBbJeJvrbPM0ARPjVBMuRCEEd6g3nTU7NQnNhzTyqkdrUFKsfQ3bOhFuqJ3TpzRI/0OKQAQEx1WTyj87K5yXDgiJASAC+MRlG70zJMpHmSXX75p9R6HmzcRpTUVf4pIqGnALholOitfDAT/bIkhwt8dN5AWhKixP7mldomLS02hzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F463ofG6GsjG52EoIvrS1iU+SeWTg6mVU3u5rN+CHHA=;
 b=haPTDYs0EL0S9NH/PyGeujAlsHf+oLuO4ZOBFHtZMKO1Ze0htXOk2M2xUAs+ArNO3Zm6imzGlhq3RHH486V23gnqoB5ME3+ubXMR9XHv8KiKweTK5qJze3bYFZ8ZcDoV8n4zOLIIDCuNqFQujNHoufVCt4MxZ8aqvb2BzKPRi4w=
Received: from CH5P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::18)
 by MN6PR10MB7467.namprd10.prod.outlook.com (2603:10b6:208:47f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 21:54:56 +0000
Received: from BN2PEPF0000A805.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::a5) by CH5P223CA0007.outlook.office365.com
 (2603:10b6:610:1f3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 21:54:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF0000A805.mail.protection.outlook.com (10.167.245.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 21:54:55 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 24 Sep
 2026 16:54:50 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 24 Sep
 2026 16:54:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 24 Sep 2026 16:54:50 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68OLsnvj1562647;
	Thu, 24 Sep 2026 16:54:50 -0500
From: Kendall Willis <k-willis@ti.com>
Subject: [PATCH v7 0/2] can: m_can: introduce ti,am62-mcan compatible for
 out-of-band wakeup
Date: Thu, 24 Sep 2026 16:54:30 -0500
Message-ID: <20260924-temp-v7-0-f40defe5957f@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABactWoC/1XRO27DMAwG4KsEnstAFG09MvUeRQeZohoNiVPbM
 VoEvXvlR5tk8EBD3y+RvFWD9FmG6rC7Vb1MecjduRT2ZVfxMZw/BHIsdaWVNsqhh1FOF/CkvW9
 FtG1tVY5eekn5a4l5ey/1MQ9j138vqRPOf9cAjQQnDmforiN0CdpwjjAhIIRkXKy5saql1zHvu
 TtVc9Kk79pptV4/aVAQIyXHgRkbeRL0KHATVIQPjMk5Zbz2T6K+C6/0JuoiyHmTbETD4p5E8yD
 wTzRFaCGtkEun6vkO8yiaTZilj4Q1YjTE/C9+1qH28nktKxnXyd43cthtQTVMFgjG7pJ5nexwH
 S5Splr2sXytr6n0G12SdCi7mIPDyMclxXCjbGjJBEcqIWFEy8HWikg7Lc5HYRcozaoNg0B53Cm
 Ph91k9wQ91+WlP789GJWqRAIAAA==
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
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790286889; l=3613;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=Lmp832RXdm44fGe31GvTOpUgBufYNHo04Sozsb5p1Tc=;
 b=NtE2HBSEFVo+FGMwVBsgSWrAfo0DM7qA1XUfgHATDwSjRw5aly4vjXdhywETrIVN4MzEs9AjQ
 NLne/20j2gZADoyVxBJATvhVxMk+ohcXxpCmVz0SkAVO/LTDKHF54tj
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A805:EE_|MN6PR10MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4c9ca1-c3bd-486e-039f-08df1a86785d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|23010399003|1800799024|10067099003|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	WMKZ4IDCK0vRUVakoILzBmiZljbew1V25KKuJaFzU6eu8/d8Cj7t0gg9Hw8isv7czyYEEjUeHe6rELJV1tIVoLq646gnFEoJT6mGbeNbLDoOe0NW9ZMh/1wNvNIlguO4ER59Ddjgk2t5SuvXLMdLMZ/tHtgWcYychrealSVVg9Htanul9CB226qQQT8zI7rj5IJ/wCTu9OtwVO9gQLs5fK2B1vZc7ML7IBGdWLEof43ZXMGnpwuoYTpxPZVOyjDGKbXVklsFULdxe50Z5MHIE4Ae5qDd199azVKMT6yZKETX9FkU4Ek6Fn10t9DqpJnv0yyvNc2WFh5LXJsDpJCpDEUXctSw4v2kbaARY5dnxWMDqfVvMl/CNDCn4K06DHaIwEK0cXFgZUKcYAE8awYoKu8hrCZUmr5cVYmTVeTKRWDXCbhw/7FUwhR34li/zJk/nuzGmpJ23EUaU+Om8Moebwt30K1LBywnnkoOAA7zpdw0KRKaBD1IChpGKRM9AIr+3xTG2aZDqWV9ckZOk1wKOQmXOYxX0JlUrmhiqbF13uNU/TIhLrD654+NWpZqYD1mVNFtw0bkNHMwunkhu+mrHLG4A6Z1OtQaVltxb2ve60iX60J80N7AS48eBJh9/nUIRSLjJFgk35i4CJbpD7NG61NUNIJz2UDAx9q1p3/oKPY=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(23010399003)(1800799024)(10067099003)(18002099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6vYJ8sPDq/RQnX5IU4tSjtSfgF0BN2HhC7v6UvOSGwdhlG1regASWxbdDEOUnn1Yc79NHYiogp6bboIF0d2g29oKbpNU2aNnMHjrWluN1I4oMi9fa0f6XafPsUFu9CVP7drfvluCZWh13VHTIHKHjEMj/GCzknjcWgtiLFyDop6hIAKM3m/AXcnh5Dq3gV0UV6M5wglqbPnYx5/LmpTyNifo1RZ4XTp2eCl8lSA+6XigudISnG0Xt7p/5f4Sm+q71F++qmWwLDR+TYZwjGQ8FmoaWycmv1yeogHuahRrkiFN5JFR/13bdftZGFIOzbngjDviqPdWFw0asmjiKOOCe+DYqAfbdZ+W9/hLI0v0m6QUTpak6tITD+IKVHoOOzuZT0cWxBy364Ow1u0sS6OKVOkajhw73nmN67C+C/aFdm+hJV4lUqXizTMQG5Bg14PR
X-Exchange-RoutingPolicyChecked:
	PN9nVYNOhlgO2p4n8tvU1Elz7Ks5Ba1PWWculMDtgBmmiCEeq2JESHuDiIf+JKQe4GXUSqqYZXxRb2223N1FCEZx2IIgdDJkJnManvRBvbj0lIb+Xz66h9rMWCX/rANFBB6g+TCbdiLPJ52XUvmPbvqhffWGL4TXqHpKG5LeA8vBxy31XJKfe+ZcfLHX4yGojLRwHRVVlcprbwWyt6W5Al7/awGF8ywTwjzWp+thU1/w8ilq5qwGIqQdeqv6k3wGG3+lLMxuvZSYdieggeZa3H3M/3UTfEeFeZYsWb0Kht0oZLFThmjHTFfSgvv/4PHR21J/6Zbl8t+CgsVI1hWupg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 21:54:55.5962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4c9ca1-c3bd-486e-039f-08df1a86785d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A805.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7467
X-Proofpoint-GUID: TBsek6vC_dLHSgrG1pv8PmsaLj8J2CSk
X-Authority-Analysis: v=2.4 cv=YKUKWhGx c=1 sm=1 tr=0 ts=6ab59c37 cx=c_pps
 a=F1HhE1toGRAZ88wdd1wKFg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8 a=IOcPGU-4WoNUi0UXtpYA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4OSBTYWx0ZWRfX8HRP1K0AB3va
 d7FuitqVkoQLMky1helbG8tvQQ+2sUctQnErLY0TXCYj9jDi3mFZF1Qpb25u0dlR9QHrVMuZBo/
 7kN/STUJ92aJuLKjXUq+v4VBt06strw=
X-Proofpoint-ORIG-GUID: TBsek6vC_dLHSgrG1pv8PmsaLj8J2CSk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4OSBTYWx0ZWRfX5Vx8swWVOJRo
 zK2WkkYQ5w1sVtLT/ho1TiU+dgt+WwrgCWw4abdKspaFPUF8PkAUgVxWYQA5zBh9Eex/U2fnIHb
 0+8pKAdS7LfMNbt0hOyYtFwMLdf3BTEiFfb3uFc3mrSj1+avZTtuKddThiFCGTvDRM1uH3zYqTp
 3l6C/NSc3wrGbf6nzjH7pr6s0RjBmAvKUAFJIIkhCY8Ocna8fvOnwHRR9xsemG6jvCNdlb/vGow
 MyHT20W/jQBwHTooQsgozOjGFhfLfQDplyxuZx/30nOPvH/yiM/sNniJdQrdNVO8mQDJz0TA/MZ
 XlXIkUjSxtR8wWDiTKO/GP2s40HEaH3v+yALtkA4e1aaa2xkezYlMgBlKfFPmVNHqou9cyeX63q
 rOMDD01z5xLr9/cQS+v+BlERkS01bnVD35av1gLK4PKUHQ1RqvOS28xZKVQvYwTMwyEuLkBR5Me
 rVakBaXJtMfrGVZz8yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1011 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240089

This series introduces the "ti,am62-mcan" compatible which adds support
for out-of-band wakeup capability in m_can devices.

A corresponding DTS series enabling this feature on TI K3 AM62 family
of devices has been submitted separately:
"arm64: dts: ti: use ti,am62-mcan compatible for m_can devices"

Rebased on top of "can: m_can: Fix suspend deinit() error path" [1] and
6c507ab36a83 ("can: m_can: Remove comma after sentinel-entry in match-table")
so that maintainers can pull this in on top of those commits easily.

Testing
-------
Tested suspend/resume with CAN wakeup on AM62P SK EVM.

[1] https://lore.kernel.org/all/20260918-v7-3-topic-mcan-suspend-fix-fix-v1-1-e24fa70c754e@baylibre.com/

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Changes in v7:
- Rebased on top of "can: m_can: Fix suspend deinit() error path" and 6c507ab36a83
  ("can: m_can: Remove comma after sentinel-entry in match-table").
- Link to v6: https://lore.kernel.org/r/20260915-temp-v6-0-ddf1411d63cc@ti.com

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
base-commit: dec005ae90a2946656a090f37bf1cfbd22f08e57
change-id: 20260819-temp-93299bee27b7
prerequisite-change-id: 20260914-v7-3-topic-mcan-suspend-fix-fix-b943929d8fef:v1
prerequisite-patch-id: d60701b698565843ed0630ce15cda0c46c35cb39
prerequisite-patch-id: 6c507ab36a830f131d17ca74033282e89dec8a3f

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

