Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794950582;
	b=wm/IrjezOJlDEHjDedKoMx2uE0psNDrWujEG1nBSnbZkDTe7jKmplyyTEKiWLIgVm6d4
	 oXwzqlMgIu8tEek4wnTy2Dv8xKbxzyjW3YjiheYvsk6vBsO/t7d5s+ue/KZtjTThWpeYW
	 1InYQDYMiIDHkdDqYJ6K42Mb2dQy1yS2Iz9kvmdEk/Ng+z/x/l9kjFJnJxWI9HHUscW54
	 lHk2H6hMewRZ3mqOqJito0p+tpaVy3rhdmBLCcxjAk+eocf7NnbgY8BauHYV4tjHd2cAd
	 05LcIeF7AQgsQeIHkr8Qj2oDCzLGK4qSyki6E+aDzFxqUUnHnuaDqt+ech5YxoIlCew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950582;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NTh6rr71c36pJmie0XuIElEvUmDIuBrzKZ7fxlQIssI=;
	b=IZ/uoT4LobR64MAV/ZW+rfB1+kSqrOWZhVsfwaUfuDh57kNYP8DhfvnIhN4nLUC7Ntz1
	 CS6Ko4s2Tj79lbItHlJBObgSsIhoGY1BuJZKjr27kg/ddNvVwTzcWbqWO9w3QXgEFJX7i
	 e4xWpYY+CkUS3JzVF4e05FIv5mYGCi7zuQWiDg+U5T/pU6c3PUR8ZS1+ntfSeaXgJlXS9
	 yzNLhoineVp/IHxMwh4ctFTO/pnHLIY+Sa4WcizMqMu7GC2OyvhWfa9S8w+uZHZeoFDzC
	 OOuayDPDYkZMHoAwsJE1QinvegKw7ihi9jRyaQ5wUDvBnHjU6dShrbWVzOTitN0sNVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=RTRtlk+T;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b="p/kLdrkW";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1B606A31C;
	Tue, 17 Nov 2026 21:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CC1B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=RTRtlk+T;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=p/kLdrkW
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AHKM2xI786155;
	Tue, 17 Nov 2026 15:22:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=NTh6rr71c36pJ
	mie0XuIElEvUmDIuBrzKZ7fxlQIssI=; b=RTRtlk+TI9BQAXVaC3q5OfhEKPCvB
	Xmk9k9sG/XN5peymxT2lMwlXrPYnR7hy5pD161JKSDgJB1BSTMUkKdI5SiaVnVSK
	8Xd+DV89g8NmcrTUJUa+1ynrUGGZW/1UKqNkAR0xDXHJn6gYsechSXywRxbEpSgE
	usf80b0F7o8EX60m0GSLPXt868cfYD+0y1Z8hio/qDiXQDZiVwydQo3QjNAx5vl8
	4gQprh2ChkVRpiOHk5M4FbP2H9NIjK3cFINxhV+wzIxYZitBFXgRW7QpSS1lGunN
	0QryAinNd3Lk9jlpTKqJdkaqfDxPlebXcABlwaKqqykIYn+hpA7OQ4Pcg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	by m0380145.ppops.net (PPS) with ESMTPS id 4j0kye47ua-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:22:48 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFXmcMjqD4b5ThMUf1nqpzXqoIyvb5RJlvD1L/yngihMK2t3hM/xHj4+b0l1py/Wq04FOvC9ayWWMOGxskP/rTK9jFZv4EJXc6ecniUGf2u6tmBlwONqOn8AesNYvuYqWcxSWKR6m+96dDSP86jBnzIn95to2oVdFfsUvfejD9SVgd7VX+/6MRe3xqG7oxqZxv3ldsm+X3YzSG+NifRDRPMZJ/XGFSwnVzpYnhSjlUAuAfwQ54x2XhQTmfunGSubpWW6yeH7xHVwL7ijaAWN0EOc2u+radWqiHK8ukhg6loFmD482LYdi9mYurMF88iRMeujABzLriFQGWX9MH9G1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTh6rr71c36pJmie0XuIElEvUmDIuBrzKZ7fxlQIssI=;
 b=IaV6WtMrXsOfq6T1VuVn7SFz14ih1oGz/X6rq8Se/IDfC014G7jU3WmsEu2ShW18+RisCtCJQfyslrNZGw8fL/LwEAVGUGa118WAxKxeyjgxaR63AXK97BgQX0OhHSt0HHPGAXTd4ogqYUjhMdBKFKldUBxNGkiwc+Zs3uzWiJvL4wykXGTByqAg45KeAzDSZ3XQwBdwlZLqWq538XVwDB874fIF6yWBMS4IsutlxziLEoVOGh2Aj5U+NQjWwrRynAtgCld5kCBcSC//XPb6jRd4M93Gv56D84HIyVkcUAFoZhKWVyA3SxddtaFonxrl/It3EPOxp4KFVbi2M4fn2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=samsung.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTh6rr71c36pJmie0XuIElEvUmDIuBrzKZ7fxlQIssI=;
 b=p/kLdrkW+VKc1ldEpYP1pIpuRegu3Z/HzXQKmjb/nl5j/gsFRvOTODtgX7NQBDpPso85OwLUSBTHfZpFrKgFYZtsOUvYMSKzANcGtcffwGMZHk2qzxGSaqOjhO1lTMBXq+E9Q5iQ5/lmJrSccfEpPCpi9ZmKbaqSIDI8/t4gYGs=
Received: from CH0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::11)
 by IA1PR10MB6169.namprd10.prod.outlook.com (2603:10b6:208:3a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 21:22:39 +0000
Received: from CH01EPF000BE946.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::94) by CH0P220CA0021.outlook.office365.com
 (2603:10b6:610:ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Tue, 17
 Nov 2026 21:22:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH01EPF000BE946.mail.protection.outlook.com (10.167.244.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 21:22:38 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 15:22:22 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 15:22:22 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 17 Nov 2026 15:22:22 -0600
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AHLMLg7563881;
	Tue, 17 Nov 2026 15:22:22 -0600
From: Kendall Willis <k-willis@ti.com>
Subject: [PATCH v9 0/2] can: m_can: introduce ti,am62-mcan compatible for
 out-of-band wakeup
Date: Tue, 17 Nov 2026 15:22:13 -0600
Message-ID: <20261117-temp-v9-0-1d094ff918c6@ti.com>
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
X-B4-Tracking: v=1; b=H4sIAIXF/GoC/1XRy26DMBAF0F+JWNeRx2P8yKr/UXVhxuPGiwQKB
 LWK+u81jzZhwWIQ547NvVcD95mH6nS4Vz1PecjttQz+5VDROVw/WORY5kpJZaQDL0a+dMKj8r5
 hVraxVfm06znlryXm7b3M5zyMbf+9pE4wv10DFKC4ULiK9jaKNokmXKOYQIAIybioqbaywdcxH
 6m9VHPSpB7aKbmun5SQIkZMjgIR1LwT+CxgE1iEDwTJOWm88juhH8JLtQldBDpvko1giN1O1E8
 C/kRdhGJUEqjcVO53mGdRb8Is90igAaJBop2wT0LpTdgikpaRE9e+tulf/Kw19Px5KyWOaxePD
 k+HbbWeM1CMbZdp7WK4DR2XHkqDy9N4jeUPRZc4nUp7c3AY6bykGKqlDQ2a4FAmQIhgKVgtEZV
 T7HxkcgHTrJowsCiHu+TxdJjsEUVPupz05xeeDlU9dgIAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794950542; l=3770;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=HFWRe3/spU/Bu/2jxNi8krA9l9n97nRBkUUY4b6ygVM=;
 b=puvSSCSztJLL20EDIE4QD7czyA1VyTmSFi5HNCPqS9Pqb98KQ+U1Sn4Ex32ox7c/SUjkC3cHU
 9HloOGYDP2KDVAu9hGoN3Kc9+ptdvRFwxw5Y57MhWl9KSYPKY4TCzPz
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE946:EE_|IA1PR10MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecf1149-e3f7-4729-2fd7-08df44f0e840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|18002099003|13003099007|56012099006|261022075727099003|261028144727099003|261022113327099003|10067099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003|261102123227099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	I+H57ak4rTrPL/q6rEYxaGj8TxBOkfFx/m60HzCyTb7G/zMk4d2PFxQI5ppDR+4hCOKKSiOIdaHS9iSLZ5na6TzVsLqiK/aD4tbv85jOUL4+VOlP6+RzIIqZEYDrVw1CqyTZnWv1wdjG13foeW6p88yaOXmFv8U0rJCl3KVZD3O4t6CJwvfQJBB5sdvbDI6YtYAGxPUvnhIsmRyoDwv+bE/ydbQtr6CcFXKH9HeB5aY17qYDktibVLtDTvPvh/2K6+Rmk60KXmV6w87LW4RfoywR7elvYPdqj9XhSCvDaK67vNZULm5+7pGjnKC4JbZIbtOQcd5Z9AzvO6oGIE3oSGXUutV0cz6PNX3jMB5pUqoeQvNeCPWJf0jtAq6XZovt5E65wyzBTrAZFGeeLHCtctDmCuv/zGCuNBg4kLOphbS9QZ2p+ABZvzedoDOChIq5Jnh41dtSSZtOFk68O7zq/LWa215eDiKqoE+IqU2+SWTJ1Ne6tf8CIP3vVa8lbl6351XYkghK2JGAN2nZ88wsrJ7N+vQtBNYaFJPWjVjX/B/yeyz68ugRsvOWy3L3xQ22sTvdiGFWLBUKSgplcns1WFPuav6dXtFkSYIvvIo+Bn/scUxnctyYsTXOfehLdDfiMBBmnlfohoMF0kEZHoCtAg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(18002099003)(13003099007)(56012099006)(261022075727099003)(261028144727099003)(261022113327099003)(10067099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003)(261102123227099003)(261022105027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Qi3A5dqHhcTGOjbURNnp3agumRAXVbDm/N50BRcIViN+kDtV+0i7nYXIIEo4dAR9J872BbfCrWyDiW2mXdgaDTY+u56++qsMqYwmwFu+XAEHlAvcWq5UbRCiqcwbDhwX1Cf/EoiYDGvFoASHOhIqVyXU874IPFbOu4xlkmKJ7yPEPZQMb+MCt1a6irX+J/i6fvt/K17/nQ8ipRIEDifIvc4o1E+mmTw/GS1ovBg3ArofVvbJoWUcwNznZfiVg1CbJOPoQpkox9ZSdB8OKerP9CTiiA7IDTY5/8NiQxIiT2bwkFkjGSI4XwBwTPw/x5ttWdgJM5VaGAc/S1+uQOgWTTJLvgL2DxsJbmrpl365gjn93RPFaHOxKMSWZZwDbOu+rSp4WiQBOaT9XOmUuv7XVdyErzpdjEwMoYehmBf2gZtz743qRxTR1thq9e1aiCzP
X-Exchange-RoutingPolicyChecked:
	VpKj+ToSfH63gzsG3Mi3eo2s3AAT6zApR0v2JGq4V/kHX3nZCPQLsPIlqUXlVIs46r0fqteNpHf7REqyC9CK697blr82bg+Y0pfxA8LrB1tJx7KJOXNFwpDWHf07ACBVzLuFGph9btPpjB/r2MDFvP2mRsDOd8QIgHWMpB0itY++jlLwQHApR18CrZ3FZTPXUOaXlfIlLMFyJMKsoh3vCT0XtAoiUIbjoL/FedPacam2gmF0yjsM9K4SpJNTcbUlaUkSNUdgYkrmlVZQ7IJFasTyjeEGoz7D8V1rzjQlHQ1BREZMp8jMKL+jCx46S9atP6M7oAZRg8nedrmvIcbJag==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:22:38.8296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecf1149-e3f7-4729-2fd7-08df44f0e840
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE946.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6169
X-Authority-Analysis: v=2.4 cv=bsTZl0ai c=1 sm=1 tr=0 ts=6afcc5a9 cx=c_pps
 a=UdDD+omNl1Ext3Jod4IcCg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=IOcPGU-4WoNUi0UXtpYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: U5fhVYd4VxknLEYqOTefqo7rOP_uWmtx
X-Proofpoint-ORIG-GUID: U5fhVYd4VxknLEYqOTefqo7rOP_uWmtx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4NSBTYWx0ZWRfX8yV+cuDuGp7j
 47G0q3nhgpIqs77Ejes6gl41aUork7IJ7hl0vE8I6hlM8E5AfJBezja4rSwf6bHZ0o/qdZKfESj
 VqajCF1DZnAxFu8BeNpT/00LvUoVPu5K+D1FUcNunskdiVGkMxm8jVinBl63VOCzaBEAi/6mNqH
 xcLkQEpLDLXl+2azadX/WfPjZChDLrEIQycnW0rG2zz5RAdysSqcWPJK5/LRRyd8tilebLc6YDV
 g65j5H8AHe6tV2i+W1CSQnFS80BEuvXmvnc3xcZrVRALAESIiX9oX9zfd3LCRj/GcpyZK7EgYy5
 THuc7XO5n/JBuNJAfAgqRXMTjN1TN4M8MbuYrb25/xhOsuTWXHRMag/vF8oLpLRBiMbBAxzaSo2
 rENw0K2HiOP6m1Fktc8+KneTtje0ApEOme00dNus7r/mWeW0L14gVsT/C6Gcr3SLJh2uF0iJtUD
 RU/6DLKiqeJzZcsRidw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4NSBTYWx0ZWRfX9JBOmrjygaLt
 I0QD63LuOER0edw3IHSKgTXy00+Gg9EsX4XhIiCe9q4k0PfMVev/ozyIBdkAP49YmzQBePGFFbD
 fozzRkOkIpQAldCYh+57qNfWRjRrXn8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170085

This series introduces the "ti,am62-mcan" compatible which adds support
for out-of-band wakeup capability in m_can devices.

A corresponding DTS series enabling this feature on TI K3 AM62 family
of devices has been submitted separately:
"arm64: dts: ti: use ti,am62-mcan compatible for m_can devices" [1]

Testing
-------
Tested suspend/resume with CAN wakeup on AM62P SK EVM.

[1] https://lore.kernel.org/all/20260912-smth-v3-0-6fa661ae5a4c@ti.com/

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Changes in v9:
- Rebase to v7.4-rc3.
- Link to v8: https://lore.kernel.org/all/20261001-temp-v8-0-489dd82e4b50@ti.com/

Changes in v8:
- Remove redundant error check before the logic to set out-of-band
  wakeup.
- Move m_can_of_data definition from m_can.h to m_can_platform.c since
  the struct is only used in that file.
- Link to v7: https://lore.kernel.org/r/20260924-temp-v7-0-f40defe5957f@ti.com

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
 drivers/net/can/m_can/m_can.c                              |  6 +++++-
 drivers/net/can/m_can/m_can.h                              |  2 ++
 drivers/net/can/m_can/m_can_platform.c                     | 13 +++++++++++++
 4 files changed, 25 insertions(+), 2 deletions(-)
---
base-commit: dec005ae90a2946656a090f37bf1cfbd22f08e57
change-id: 20260819-temp-93299bee27b7
prerequisite-change-id: 20260914-v7-3-topic-mcan-suspend-fix-fix-b943929d8fef:v1
prerequisite-patch-id: d60701b698565843ed0630ce15cda0c46c35cb39
prerequisite-patch-id: 6c507ab36a830f131d17ca74033282e89dec8a3f

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

