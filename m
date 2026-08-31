Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92E41A547;
	Mon, 31 Aug 2026 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193404; cv=fail; b=grglh0DK7ny14e9Kelsol/Kf/uPL7lxEszfIlx0ORC0/k5BkWRL+Rh9gqy5KeczBBHYO+PHK4OfVbsW1AiOao1g1rK1X/MR+cL0TuN0Hx1QE+6jVNyqJJQ8USZUK93FDFQDWuIjPcJsJohis/NnaBuNGx5Fmu70OBx6tyVfUW5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193404; c=relaxed/simple;
	bh=TSktc3S0dlKiAXIav3jsSJfN8fUwh8t488rzGTYO93s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1B83dTqfefPXcUgD6oMFWGIb3nY4F3qs5d/aaDUDQLRbLiY5Ejvh+v2giVKsO/5vq57lyuJPaYbOydouOkV1ZLALA53QGxeInuvZMIsvRAyhvKShgF6YngVLNTd5/TT8YGK9LAi0kPscuGPTaUXK7L0kSo/bNnyjVgdLjSPQBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=UNTH2dzE; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pp4H624G; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="UNTH2dzE";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pp4H624G"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VFjgR61504823;
	Mon, 31 Aug 2026 11:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=sSSrJn1skXJhs7O
	rdr6rkwV5e0LBiX5buuB95fVjIPw=; b=UNTH2dzEvVVc3Z6lewGfPh9NEBEeXpn
	UML45FDyMncHmwwpiMXD3UllTewuSRDM+4wbjrNE9Z3W6l+xz0iDlcpirAEiT5Yl
	tUsT8iOK+n+M02vvs/rMCyv0KaMBpJP0YEyou650+IIQ5Nk60Z1lnaz4pCuxSdOM
	1RrXUivxfNnD+/yUMpoNN4WyfIb94fAnLJ55xrh+WK6PJv9CDlv+pEHtd5vbzNIq
	5IJgjjXUAm2gRn8zw0rAQ1Fs7wjOwUPPwEjG+7o93P4fAD5fMuEMiFQXoVfPVHO+
	VnFtLMhM7/y+fkCxpSwp1m2sZuyzvIl+4M8HKtnVPiP85qdCNSlJjQw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gcet475jm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:23:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwG+YTjn3Sjh8aO99pWS42pwIiO+uix7E/57BiENI+7rbGCfkuFdgcqZMil7bLgs0BEpcv1OtPyspStgg4zTPqkabt6Y8fyt38gAGPvh5x+f8KcvUWyjlDkR/XnMp28ot4WJT3c0exavXwNXWAhKwH8EdA1276bSW3TqiKVsJJcB+rsVINkyvnIS4mTWb8whydwi45H+lG8FEYTStcuUdC1rnaWHoJWS78NwknZ3a/uMFXoXCl6K3XgpYkx0OqrMcDfsj6VrJgKbFPwlWVlzC2kJZZtHxoa0VesdRSSlSaqI6pFhlTS0kNPgWlRS4VjE8SN38k59pa6ZTHPAr3Re9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSSrJn1skXJhs7Ordr6rkwV5e0LBiX5buuB95fVjIPw=;
 b=p2EKIo/P9NXWJrdjGhq7qsfe2gRf8SyvQvFl069/6TVOCu18yFskpN4XTWxFvHFqpOyDRLCX0zj77ezcV8IQHGG+XheYfRk5tOUCzMSy3gmf7hsziBZaiyXzSTCBJPEWzIVQrS6XpymRslJvMlTpXidSY13q3yupQIX7FtRl+s4lRWaIU68aLKNLdeWY3odkh8sg2Ef5Z0eJtIqNcOyYvsS+Q7e/CP1YScNMewjWc59ZTvo2smJH8O5eSb3k3zrs3X9D3R9bVy5/eHjv3xg1W+e54SUUzHkIEZeTlD8YHIIBGQzHG8ge+GJ/kVv1zRV/FKVwJ0KF+6J8Bd519IlU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSSrJn1skXJhs7Ordr6rkwV5e0LBiX5buuB95fVjIPw=;
 b=pp4H624GiDo8jM4l1ZaZmEbfZSvtLGv5v8YQPVq9qnkyklSTqNhMWvkFbdf4bpx96q4jgwGU1biBOhcotU73FVXQAEPwwzPp1dJsd90gbhP7HYlA2y1M3SO1MBK9YcpdjYwA7uUJaFQ95w7XB+z2oWW/vsA1QOECYX3KDWcAtyU=
Received: from SJ0PR05CA0053.namprd05.prod.outlook.com (2603:10b6:a03:33f::28)
 by PH0PR10MB4727.namprd10.prod.outlook.com (2603:10b6:510:3f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 16:23:01 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::5c) by SJ0PR05CA0053.outlook.office365.com
 (2603:10b6:a03:33f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 16:23:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 16:22:59 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 31 Aug
 2026 11:22:15 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 31 Aug
 2026 11:22:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 31 Aug 2026 11:22:15 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67VGMFKp095530;
	Mon, 31 Aug 2026 11:22:15 -0500
Date: Mon, 31 Aug 2026 11:22:15 -0500
From: Kendall Willis <k-willis@ti.com>
To: Conor Dooley <conor@kernel.org>
CC: Markus Schneider-Pargmann <msp@baylibre.com>,
        Krzysztof Kozlowski
	<krzk@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol
	<mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Chandrasekar
 Ramakrishnan" <rcsekar@samsung.com>,
        <s-kochidanadu@ti.com>, <a-kaur@ti.com>, <s-tripathi1@ti.com>,
        <vishalm@ti.com>, <linux-can@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: can: m_can: add out-band-wakeup
 property
Message-ID: <20260831162215.a7kd36gyrokifia2@uda0506412>
References: <20260821-temp-v3-0-9ac1f8806929@ti.com>
 <20260821-temp-v3-1-9ac1f8806929@ti.com>
 <20260821-regulate-recharger-2e984e9591ef@spud>
 <20260821190511.jwdgox4uocbf4brd@uda0506412>
 <20260824-public-mashing-252473f928c3@spud>
 <20260828-antique-lumpy-donkey-51ff42@quoll>
 <20260828-ladle-hurry-d6f63c45fd19@spud>
 <DL0SRC0352S9.2VXHSPLXP6QZR@baylibre.com>
 <20260831-guise-nastiness-23b5d1cbc25d@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260831-guise-nastiness-23b5d1cbc25d@spud>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|PH0PR10MB4727:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4424ba-0c80-471b-6dc4-08df077c1fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|6133799003|3023799007|10067099003|56012099006|4143699003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Bvfoyo4QT9Rh42zi0o74TTj3hrN6OUxhqJf12CFgWnczLqwjyd4Y10kATDIcOwsS9tbhvaYkBrwXKWYtm2iIDDVdHW8N4mX1S9BGB1vkr4ISx53+y4L77o/u8x4xCtq8137EM+nZ/Xwd8WIBIQOfvbEzS67wKleOmIBfc4LZ3CcM0m9ZKCVMjQAiSaJKbFkSrBf6tIw3RTpJ/FnFxAC8fuFhTmgUg81wJo/wFP+nLKOcHwgySk70el4wcFk8toNIi2XDOn1iK+lChkO7QzdFP4MIqUcst0osLgfDyVGat901w+nzlVh9h7YzPzvQzOjyktx6Q4w/vP1y68akX9L7hY6wDyGFXWlYNnk6WDFDI9DmGRFugQiMwN2rkSPJnPihXAtasYxovjyhFXEyic9qSJau6zpl2wAo+kjDxSfWEWgmDDUEoZ3CMVgYrAn4GHAHjPryA2omZDZpFufH9I6AdetLy0MufCbm8H5g21hBiKpFFDeQoy4qKvFCarrgI92VJhd3DX7b+sVFuhfLL4sqgONK6lqJ9sk5CgE5PgEo1WnqUEvZR2gBYWD2nwa7ccM4fnF+mjhrLIcCclAQyW0ff3l9Xz99kNQPnnAH4H1zx4dOuzAh83x7k9SnlQEpNUYdrQLIoacemBsLXWvpDpDpFuv3N40VW2mT/KsbCDbyfj8MA/uR5Cw6UWgXhesQCxAQ72gFH94bnZ9sAB8DHUrG2g==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(6133799003)(3023799007)(10067099003)(56012099006)(4143699003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8nlY2NqWk/BgHyJZZK7Z6Y5bC7AAjcd8YwWwYtoid0j9YByzYSSEcPMk2yNV1Z5t/bWwmIlbhp55U0nl32qdSM0w+Z28G0ac6MCrB97LSeWu1gjrEKCSVZzZcjJnqFwhtCwqUgixNFQyny/BIfBEdy2FEVC9ZA5KOPQM3Y8P+rPXfxJkXfP5lJm2H6iblnVAhqCoYrHvaanbEhGS0w/aSmVc3BApRYySUnnVNSseDmL4mPeVEvoUAZipZWedE8jH7EBoy3eZ1Q6wOW5lRgEBXlr7TSpToyn4sTOo3pdlrGILn5wF346NT77wOoJfWeA2KUw/cHGTHWtHj4bdoSwp5QW8l0becyOvNi/ExOBLFTRJIeEmv8XP6qxmiysgM6Sb1HLGgk5jiKvU74CZDIxjpUHrHX09lmoW21rHrxSP5tRpxb5TNcI1aqB0Di51mjCU
X-Exchange-RoutingPolicyChecked:
	mTWx7VaCKx8E8OwNlDTW7ZW9LK9x1Rt7WnTGWyo4H6d+djX8io04EYXp/vXXAODXuJDeAgGLsh7B2OX7jyoTr+yR5LuNsFPbZ4aB7/IGoUCoGwqcx4Uo9c32smSatf5J8b/hOrUdyt6IQcq7sX50Xq0QePCvmZFYGGGnYt19u1T2FWqlRa2nWCkmUaP6qChcMl10ErVb51c0YQEf4tvkDHCGAr0wXxkmHHIZNJORRTyYCJoZ6RIp1L3I+OP8pv5MBsKJUjiB+Xe0EaprFdNLyVw1vcEnx/Mv/XW1K+psSouNThuSJUP1v+4hgiwU6YccLP6FvtTVMbH1W4tGrwD5QA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:22:59.8214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4424ba-0c80-471b-6dc4-08df077c1fbb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4727
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0MSBTYWx0ZWRfXw1KeugqPUUzC
 E725G7j5+6JkiPoauNhy/pOokFQ28v86KRTpz6LLnH1NMrT2D1vDp7DU4qRU1eBEqdf8ou9bqDs
 LJM7hFbThoxmmKEhUWffygwE00TYCBwX9sZomRiZsAmLbkdbX/2p+WkwYR2Xy7vbbuuAYzbYMRC
 Jp/L0VV9TjZ/0zZvOUhkFQNngRywaqYY79fBBCrmV6pBlN7cAkWz1/l/7WJnCfq0OE6bnlHuwx9
 UiWH5Ao60pf0vd6XKZflPm+etTrVIOqNDShr8x2+meU6ZgkGDusFmBAmJKp0euon62TXXPxhe49
 r8nSHFqGKUce2Y4BCobKRHdFh91syZlehcE5nLl5+NEjn7Zmt4c/Qxg1sJIxYq+Zf9gxafPgN8j
 4FYQ+HaknRDMW8UMf5wYzblMfpjfnE9NgHa9F0u0KCR5hqllry0+BSu3YUkgnw8UW7vkaN/F7AD
 A9Ie4tX7V0/jhS8CV4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0MSBTYWx0ZWRfX3S2debXfZMCk
 ztrEFD0gUx3pBeZAEjfWgJEryfctZHAi2vcKsUCBBKkujiUe8SYmKXNJ5vZtXCloKl350Cfl1Ku
 2BDkTH38IZBDOPHiJlvMFBXU1Q/Zvr8=
X-Proofpoint-ORIG-GUID: tng74Y0CNvD3mT0a86VjRe5mYV-juAjA
X-Proofpoint-GUID: tng74Y0CNvD3mT0a86VjRe5mYV-juAjA
X-Authority-Analysis: v=2.4 cv=LrSiDHdc c=1 sm=1 tr=0 ts=6a95aa6c cx=c_pps
 a=wPn5mG08gX1eKnPfDThLSw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=RAdpDvgw08RNpHOOFqUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1011 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310141

On 16:13-20260831, Conor Dooley wrote:
> On Fri, Aug 28, 2026 at 08:43:30PM +0200, Markus Schneider-Pargmann wrote:
> > Hi,
> > 
> > On Fri Aug 28, 2026 at 5:46 PM CEST, Conor Dooley wrote:
> > > On Fri, Aug 28, 2026 at 11:07:29AM +0200, Krzysztof Kozlowski wrote:
> > >> On Mon, Aug 24, 2026 at 05:50:20PM +0100, Conor Dooley wrote:
> > >> > On Fri, Aug 21, 2026 at 02:05:11PM -0500, Kendall Willis wrote:
> > >> > > On 17:45-20260821, Conor Dooley wrote:
> > >> > > > On Fri, Aug 21, 2026 at 11:07:00AM -0500, Kendall Willis wrote:
> > >> > > > > Add the out-band-wakeup property as a possible property. The property
> > >> > > > > indicates that the device can wakeup the system even when its power
> > >> > > > > domain is off.
> > >> > > > > 
> > >> > > > > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > >> > > > > ---
> > >> > > > >  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 2 ++
> > >> > > > >  1 file changed, 2 insertions(+)
> > >> > > > > 
> > >> > > > > diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > >> > > > > index 2c9d37975bedd652b3060ab11ba75c37565edaad..0663beaa532bcc4a71cd6ad01520a4dfea294d0c 100644
> > >> > > > > --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > >> > > > > +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > >> > > > > @@ -150,6 +150,8 @@ properties:
> > >> > > > >      description:
> > >> > > > >        List of phandles to system idle states in which mcan can wakeup the system.
> > >> > > > >  
> > >> > > > > +  out-band-wakeup: true
> > >> > > > 
> > >> > > > Where is "-wakeup" defined genericly, or out-band-wakeup defined that
> > >> > > > you're getting the property definition from?
> > >> > > 
> > >> > > I sent a PR to define out-band-wakeup in the wakeup-source.yaml binding
> > >> > > in dt-schema repo. I figured it made more sense to be defined in the
> > >> > > wakeup-source.yaml binding to allow other drivers the option to use it.
> > >> > > 
> > >> > > dt-schema PR:
> > >> > > https://github.com/devicetree-org/dt-schema/pull/205
> > >> > 
> > >> > This sounds like something you should be able to determine from
> > >> > device specific compatibles for these platforms. Not sure why they are
> > >> > not used for this particular device, but this is an indication to me
> > >> > that that is a mistake.
> > >> 
> > >> Yeah, it looks a bit too much replicating Linux PM detail. I can imagine
> > >> that some devices on some board are capable of waking up the system even
> > >> when power domain is off, but this does not look like a capability of
> > >> the actual device, but power domain. Device does not have different
> > >> wakeups. (by device I mean this individual schema - Bosch CAN)
> > >> 
> > >> Happy to see some bigger picture through DTS or board layouts. Actually
> > >> DTS, showing same Bosch CAN devices which are different on a board -
> > >> some are wakeups and some out of band wakeups - would illustrate it
> > >> better.
> > >
> > > As far as I could make out when I looked at the patch, "Bosch CAN" is an
> > > IP that can be integrated on an SoC rather than a device on the board,
> > > so I'm doubting that there's any difference in capability to wake up the
> > > device caused by the board at all. If there is, it's between different
> > > power domains on the SoC, as you say.
> > 
> > m_can is an IP that can be integrated on an SoC. But it is also
> > built into external chips, like the TI tcan chips that connect via SPI.
> > There is also a PCI connected one. Also some SoC integrated m_can
> > devices are coupled to the mcu and not the main processor and can't be
> > fully accessed from the main processor, e.g. they are missing
> > interrupts.
> 
> All of these things: soc integrations, each specific SPI connected SKU
> and the PCI connected device should have specific compatibles. Per the
> series adding these to devicetrees, it's all mcu connected instances
> that are growing the property, and not devices on boards that depend on
> how the specific board has been wired.
> 
> 
> https://lore.kernel.org/all/20260820-smth-v1-1-e1738a38d58e@ti.com/

I'll respin this series to drop the dts property and use compatibles
instead since there are no examples for TI K3 AM62 devices that have
different wakeup capabilities for CAN. Thanks for the feedback Conor,
Krzysztof, and Markus!

Best,
Kendall
