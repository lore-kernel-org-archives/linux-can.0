Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8133C09E9;
	Fri, 21 Aug 2026 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327770; cv=fail; b=GsvSz8wEuEfoKJ+r20iJZn0Rwq/9xj/E2bHs67UlVhQdU2BQpz1DWoaUjUfruoe34yJfTLNyUlJiYIH+SFLuRTtQJAkgdtQWkAkvpUxbtUF4VH1BqShrFFl8WuO1ldy3NSyxnW7/EIbWhKr4cBnCwGVZqg7RYYTjljO4+PiL1sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327770; c=relaxed/simple;
	bh=ZYRsMlIk0CGuCafv1t+pz0BxtQFHA0ezcWFRm0wfDCI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNnezJKFF/Twk/aFO4JMVqYs5HBMNe9Ius7XgJhWAUifKvkYbEp+gD9AB+SEkmZFDPiuM5L6Urusq3dwBvG1Dr8Wmw1MNIftwv1Wl2jHmOCl2imQutnmoNKC8A/HjFormWPh7F0BC2LOOgr6m3MQ7F024YUo6yWUT3RUXfvOniI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=GWFl3Pe5; dkim=fail (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DDXy73A6 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="GWFl3Pe5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DDXy73A6"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LFpbcr3808909;
	Fri, 21 Aug 2026 10:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=ZXvfYMIT42Vg4QVjjro36fK5BhdBnfY0Hau17hJV1
	Qc=; b=GWFl3Pe5AN7mvN6a5OfTLkYBfidOEdiAiqpmtU/pzXOLzS47LPq/Q74B1
	CnyrnEymkj0I6zC+HhvOOylnHUXChYYtpiKef5GzZnJ47wRR8SDpFrNvafnIJEYz
	u9fJ+klDWFQFjNVNwBXSvON1ioqUmvokD4wL+qmZL1KR5UMcSrikMzYcN0d1vest
	33wn5cUDNofzEtl7/WnP+3hGNHjOZn8kkNzxPdiiXNFLTql28hPoZLpgsxoWgsqK
	6Q0Eb0KOWMcE3zks8LLYP530X5gmaN6i1d9SgtkdscyBxbJqxGD4yih1ZKWZnkmf
	Suv8NGrppfvNPC9OJGd6WBa6tVvBQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g6c9c44m5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:55:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1yrqP/CcDE1PnxLrsLGuqxzwGKei5MFXg+23auja36hp05Cmn1nzCnHxx6tIgCdrGVFfdOimhFgjh3ThaZodzgfcDdrSHXBCyUGPdLfw8EwfM99s0i/1B7ANjrbOZ8h4AvOzaQZgio10YWzCcW6526DX93j5zKKH5q9Y1aMD3n7hlKYqi693UeO9/bBXumk9tbNFnRRHGxVCgsZL1ZiFGmvBbfv0o1uL3tJuMkWZov2gHVV2ooh4wqvsvK4w55+eqz+bH5p6PjCv7N7BLEHdnsRJ6/iBNP7mDv26z95xcTkZ4luU0porV0jdfGDowVnBjRKJ+1lijDXfwkoRM/QsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AKYGBi7Y03eKnqHCzm0m+b/Drr/BXiENJzd1prjZps=;
 b=uqCN/VDPClcSMVFIQJR1BfLaEi3EFlYJR7aOTqCHYwOHlMaTQIu2v6GMbyFmfcz57xikpv5c8g9xB7lqOUXWx6MrsXv3vU9BQOIv2LjxDWX7HM8PER1hfbSHLNbRDFeAfxSzr6uNZL7XP616BrVOxUQ4eTCgAEaO9Pm+XHxiwtVZ0dfKlT91PIEteSmEqVEAPuF0oWovA8zM3dqrFRwfUVK5j1esckRZ41bAhTByqtE8DRbgmRUs0S2OW70hLTnS3Khb1AnL9LeIz3W03qkpOtO6UsVvLVvyg+dehFYXKSi3tPQVavkqtNr0I2mK7b8MJANnznE1YPST1+UJjPxlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AKYGBi7Y03eKnqHCzm0m+b/Drr/BXiENJzd1prjZps=;
 b=DDXy73A60aj6WZhLDhlMXKk+PmwXh8guZrpv00+6tfCdUGeW3WF1SxMhjp6vijWO9oKYnpuRmrXs7S5Kqb+HIl2dMLY9XGtDWzMthtf1jofe0jOM42eCSCOOFUzXjB/37nhDIW/SnsEWgPzCLntzU7ZgJKYRaDdn0OdkYEdQQeQ=
Received: from SJ0PR13CA0165.namprd13.prod.outlook.com (2603:10b6:a03:2c7::20)
 by DS3PR10MB997701.namprd10.prod.outlook.com (2603:10b6:8:344::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:55:38 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::52) by SJ0PR13CA0165.outlook.office365.com
 (2603:10b6:a03:2c7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 15:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 15:55:37 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 10:55:21 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 10:55:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 10:55:21 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LFtLOO2390988;
	Fri, 21 Aug 2026 10:55:21 -0500
Date: Fri, 21 Aug 2026 10:55:21 -0500
From: Kendall Willis <k-willis@ti.com>
To: <sashiko-reviews@lists.linux.dev>
CC: Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp
	<socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol@kernel.org>, <robh@kernel.org>,
        <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <conor+dt@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: can: m_can: add out band wakeup
 property
Message-ID: <20260821155521.pn6rq2qv4xp2ihyp@uda0506412>
References: <20260820-temp-v2-0-dd3f8cacc15e@ti.com>
 <20260820-temp-v2-1-dd3f8cacc15e@ti.com>
 <20260820214857.712A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820214857.712A01F000E9@smtp.kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DS3PR10MB997701:EE_
X-MS-Office365-Filtering-Correlation-Id: e096aa38-d386-4e2f-20dd-08deff9ca4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|10067099003|5023799004|4143699003|56012099006|22082099003|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	l0eS2ia0lqwkFEOaC5p04mhPmJQizkTdlqV8GP4y2ACNWbVEpM7DniSr92UEfvl3esdKiHOXrSo3VQ+0ZhdEyiDEcU6NIQE3483h4v0/kwjwwG/PvIk2nLd3NF7o0nI1CUSAhtTYPckeDscPOawhFqr6ep8ALKkJyd5KsWVMHaUGDfuIpTexQrp6MYfYIj3aJtwMlwpYR8PmWbzET/uIWEESf2S0WQx/6ccHoroaYYewXAIOFF+1FYNq9+vf0gknIj0u1u6mGfaT1ZC3ZdQKBNxiAvhPhPA+TZKyko73pb4xSW/4aBK+6JJ+iBdoM4Qfs7XW3TCi/e1P7SnkHQS5+GCay03KaZL8Rdy9ImSn3+BUPw2H0NtRHpsDtcoKyEynz7TUz7K7EzDTnUtjdtKGXAm4l+By9hPtjqky4+2LfEHKRBlGIsR2f7LWTC+YiWr3BXH51MNRchW+Wj8mSt7DJscOnD9I+7lEbfGFZv72jjycZJjyUFVzsSclwwWQXD9oeO26E2DVUEx5n5I9nm5GhPqoWRL57DAf5zdTYOVUYqzHj87PRqaZ+dKRdAWQgXOc971uFCtDFF2llBRhUC5YYklGk76MQsjsmcyhZD1BCtIAW6eE9ygbJD0N640ecmryUe/2mAqGgqiqLvafeNCfug==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(10067099003)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G2q6ED9f6Z+uIx0fgAhQjFZPJOCDgweQsJBr/3UVkaRwL/U3gpecCNIqlTDQsOaW9fW9tyju0YnEtxzaDhKDIBsGaWDPL1VhuT1rVfDM/okRR4ij7S5M1gRdWs3GjFuJwkepN+7G3eo+kmFXQnUXEqDnKHxeRvxyTXaK/nQ6+p+71lrs5tl2yCda47gChpLBkGimGznC7liFotT346iePyc5VvMUTYXP19VhzR3MPh8LA4e3i0FZkoGJ3uk0Cm4Wp5iZIOPpQElu9rcVByO9Z1SgDqYvSRoUguT0kVq1RNx+Uanh9bVrhIzTNuldUhCd4JUYKraiOFPoUnJoKMK6vqIRZ+tS8E1npONw1U+gbJXy+2waRGAACL9L8xeNkpwB2pJZXwQbk/69xBedrcWNrp83Ej21OnZJW69P86/MPoquBKgnXcDD68Qdrb8eNc7m
X-Exchange-RoutingPolicyChecked:
	IJIQMimnd3MbSx07BC67F280ywhgNSk0B9/GNMlHFi1tal4RUhCVSAsKqeHBkAGysRW4JSne1++iDLSJWQsgfXP3slyH67OT5EOYDgKsXPpV9Ev2rzG/zi/vpk7YdyVe8AIRdFw2VTP7RzaW29pmWJsY79XYhCYVvJaLyfdwAuL1LZc0AoXTiUFkCEjWSgR61/IOMlNk8/CC/VmrhWyFHhFodPZx/FlLaDy0ze8PNcHXrlp6dY9l9WSEHpwmBT6VlW71H7lqy/kXl7o1ozKrB32VggKvArSvQ3NRz5m7sY2exUCY35WhS84pGXccmxE3hr2+zGJLEBYtIF7otihNiQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:55:37.6489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e096aa38-d386-4e2f-20dd-08deff9ca4c8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR10MB997701
X-Proofpoint-GUID: WaetbwXAiUGrr55ppPJt9WpbrzOFWAG3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyNCBTYWx0ZWRfX32wQsZPGJkKJ
 xlg0EDihoKzgvtBrdU2v6E6gTCqYoP0TSq8C0wo03n3kFyIo36dGs+6Xzhu63pQzKsS9i+m5glh
 pudKBczw+2/M4YaK8cDHhRHQemeXfnE=
X-Authority-Analysis: v=2.4 cv=eqjvCIpX c=1 sm=1 tr=0 ts=6a887500 cx=c_pps
 a=eQn4vQZDn50HuGbH8T6KOA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=NEAV23lmAAAA:8
 a=c92rfblmAAAA:8 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=B_hBFdqMBuDyzTqD-bgA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: WaetbwXAiUGrr55ppPJt9WpbrzOFWAG3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyNCBTYWx0ZWRfX6pda2BPjflTy
 1nP8saFeUkfu0kjhXe9eg9cZFZJlI5Nch+GKdrcTnMbgI+vAz0tKI/rtyYe3a312SkPS+DZqHwc
 303I6ZAjVn/Ro9QPUlkL2Xj4e+Z8V+tToVR7Kax6IgG2uCuNjRjCPuGkTFy3j33Gi5PmlWBNw7U
 ss3+lKg57s2V2VmALwOExDgTR8zGF//IboeUjqR1b+pKApFWChpzHotxvRSfSDyMJLBs6LwfzTH
 aMXSm5R94KmBpQL3QKpic3ZnHTlzX3q9hc2IdTK277OR9sZRCITTxORnKCQd+HzFWuAIj4ZxuFJ
 JXN5j31NbyvMRzNQO45YyxhgQB6c18Mt2q2yaLTvro12QFhYy1i3wABtLcmob/8MJGfrxOQQ6ya
 Pw6U70P8/f3ZzslwbFoF6cTkPpU0wViiddqqz5u6WOMCDVxxTrkkre9n1YHwL6WKpRTYNAdbqEZ
 1TO6a4ZaNnnyZrhUGDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210124

On 21:48-20260820, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The newly added custom device-specific property `out-band-wakeup` is missing a vendor prefix.
> --
> 
> --- Patch [1]: [PATCH v2 1/2] dt-bindings: can: m_can: add out band wakeup property ---
> commit 66d860c00379089f5518db1a67a453077a6864ea
> Author: Kendall Willis <k-willis@ti.com>
> 
> dt-bindings: can: m_can: add out band wakeup property
> 
> This commit introduces the out-band-wakeup property to the m_can binding.
> The property indicates if the CAN device is capable of waking up the system
> even when its power domain is off.
> 
> > diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > index 2c9d37975bedd..b6cb945c225f1 100644
> > --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > @@ -150,6 +150,11 @@ properties:
> >      description:
> >        List of phandles to system idle states in which mcan can wakeup the system.
> >  
> > +  out-band-wakeup:
> > +    type: boolean
> > +    description:
> > +      Indicates CAN device is out-of-band wakeup capable.
> 
> [Severity: Low]
> Should this device-specific property have a vendor prefix?
> 
> Since this property is not defined in a core common schema like dtschema
> or can-controller.yaml, the Devicetree specification requires a vendor
> prefix (such as ti,out-band-wakeup or bosch,out-band-wakeup) to prevent
> property name collisions.

This is a valid point. I sent a PR to the dtschema repo [1] to add the
out-band-wakeup property to the core common schema. I will be sending a v3
to fix the bindings with that PR in mind.

[1] https://github.com/devicetree-org/dt-schema/pull/205

Best,
Kendall

> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260820-temp-v2-0-dd3f8cacc15e@ti.com?part=1
