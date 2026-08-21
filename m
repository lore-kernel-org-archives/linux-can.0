Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEB63DC4C2;
	Fri, 21 Aug 2026 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787339135; cv=fail; b=DbBHnIIBPjk1phw1bQ3LOfyESxu9uXCCYODd2ocFV5kPoEpVPTJvdqa223b7VM5PNdn79XciWCiXNOHII7It2Y5ERZMy9POSgJYdG7qDXbh7SHyxV8/tCul3tm45HgiaxyZ0n3845eU2vHrpkxqFEh2fT91WyjnJLUDE5J/Pv+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787339135; c=relaxed/simple;
	bh=5S+IbJ4juzUneuPr3DVINrWF0f9zRXdwjTGDpxRsH/o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kabf8F9jK2K/L3vGWSkr7aewSIlAEbndHpBCMJR7mceXiRyZ1lVEGAAb8q4nA/VoN0FWQwDqa6XiyvADwHBEIWBKgtulUNlpUMIN8bvF/3lj+7HtnkE5l8Y2GfIWvl/yEpxSYm9sxvxChmHrbqLTC5psYPBErpl+BLixSO2o8+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=aomvXlIX; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uzd5jkXY; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="aomvXlIX";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uzd5jkXY"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67LIFseu082756;
	Fri, 21 Aug 2026 14:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=DkZG9tVz3AaxkZO
	nawJTfCf/DuLKv4Pd940phBdI03A=; b=aomvXlIXT8YJB+UdQ4im4WOElFg5lXX
	a5d04ddfVEHGOuI44k1ojdaxjj2DWSxI6smWj0n24KJBnjS0nRow7g7Ig6jml1U7
	xQ9IEisiTiULqX2YSP214p7nR4X0h3J4+lysTn90Trc64Rxefr2CZ8iSU09jkO78
	hqok8DXWMksoFvQyqdXv8zBJ4yb9eNTJSlxb5WoEK5cQhBSKdNWhsFZgHucvrY5r
	ChYxjO4cfiq9Dw0ubfAqZJ/MNh4xY+kLIp0sdOcxWeSFjYsQdVTYjWIvTOxTr9fF
	HdB9qw0W4EWKrzSK1AIRAXECm3Gy+Z1nFXc+TpP+npK4P/PlPuRUvuA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013008.outbound.protection.outlook.com [40.93.201.8])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g6hfk3rf8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:05:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFJ2x/4K/1gcNreoRmag9t11iSApIT1aZVd9fnfiAgJXKW33SSjt33rmRHUrF0rYPntlDQ1edjEuro/QdjA/8UfF5rfXBsvkOJSrX1aJs3T6XjGGSZxipPvfuBXUsLuUcpP7yepdfVA6S3IEWXD7bzf7JsBrg5MRJ4t6QatQ9N8WbBjNBGag2jb9G8JMx0BzpDNE5VaFEr3YFO3NggKuXEqgrWirJUOinaXaMkxjp/e1En063JRJUEwk3go/YtGmJR/O8jr0sxXsAn2EyD8qOX/yMqkSMZUUUc6YzRhmulAvUAZMHipvMR1RdMYBu/N8tUQYuJ2P60ju4Obtlq1OEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkZG9tVz3AaxkZOnawJTfCf/DuLKv4Pd940phBdI03A=;
 b=NYxMjbpRqzmExnpWAV7T4R7d3FlwzpyKFwGhByFFOoDJ5VT0+x8zpfP6jD9mNWYpUGLFnXjzNm/F4mtfQ99TgwCFAO8XiMyFZ0h0fE5vB85ACikNQVAPFIaeF631hNsrqlGZNyih56NrH8P5FeT7EgqifzhvN4eRaurbAoe+7ybgPqQs8T9kUXq8/j6yII/QVv4w5UA/xDXbfuSBWenrFPwB3SNteQ+QZ8lOnWV6Jlp8wqq5nOYndxVM/xgxR6aYTrFyJFnYVjUvzkVjyqUsuR/gT9l+7hEN/X9Zk7Y5NYHdny5+x23KRftM5eSyG+W9tBNYeet32UQimAOXxksGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkZG9tVz3AaxkZOnawJTfCf/DuLKv4Pd940phBdI03A=;
 b=uzd5jkXYOzBFRRB2ojxLOItnu/67wF1J1WZl/k9MhPAtCHu832fD9GbZ6Sijyg7+Yjn3gPfxWNqT+kPH/HdGINMPSuyZA1hQNUiWVLWDSeoZUbS69r4viXYAHtw7byxLPPoJKQm8A+NYDGpNWToYKB+PaubDvWuWZJa/49WtAMI=
Received: from DSSP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::16) by
 IA1PR10MB7334.namprd10.prod.outlook.com (2603:10b6:208:3fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:05:13 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:8:3d3:cafe::1a) by DSSP220CA0011.outlook.office365.com
 (2603:10b6:8:3d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:05:12 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:05:12 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:05:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:05:11 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LJ5B7o2640881;
	Fri, 21 Aug 2026 14:05:11 -0500
Date: Fri, 21 Aug 2026 14:05:11 -0500
From: Kendall Willis <k-willis@ti.com>
To: Conor Dooley <conor@kernel.org>
CC: Markus Schneider-Pargmann <msp@baylibre.com>,
        Marc Kleine-Budde
	<mkl@pengutronix.de>,
        Vincent Mailhol <mailhol@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        <s-kochidanadu@ti.com>, <a-kaur@ti.com>, <s-tripathi1@ti.com>,
        <vishalm@ti.com>, <linux-can@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: can: m_can: add out-band-wakeup
 property
Message-ID: <20260821190511.jwdgox4uocbf4brd@uda0506412>
References: <20260821-temp-v3-0-9ac1f8806929@ti.com>
 <20260821-temp-v3-1-9ac1f8806929@ti.com>
 <20260821-regulate-recharger-2e984e9591ef@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821-regulate-recharger-2e984e9591ef@spud>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|IA1PR10MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 8abc3596-cbd8-4102-68e9-08deffb72098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|23010399003|13003099007|3023799007|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SL1ITja1c6uu2o8cQj22jPydTfE2U+L+5hMvF4rypo7QxbZfwqiT+mRg45aHHM32Gud32UmZKGtsiRo6SLK6RqBarAKeD4gEo1ftc82V9QI3sa0MYZzul8J4B0dTKzhw2ueCdmuSmmVT8Sun1LO+mWuOxOKcM7VlEf9NKtRvr1bOeH0Z9NNy8f6OZgthOR+ZNyUCxR9J0rUGumZlVGHBcNndRZieRXe7oiYF016ZH/cOQvROquhXdYcllnNYIWynFcYL/W2nMCpspkoSbwrMrJyA6uIgB4eWJZLEA5yanON6dP1znr6WB/CQ3BEf9ECFBziIO/BiTjpU3sxKl7GxUdDsN6ruXksr89mfbY1rKOikHqzt2tiY3KME25/zEiWRFQfbEI3MtKLFnjkujM5OZu+eOGMTCvkFVzRiarb/FWkbyS4uD5HO6JkDadVPNuhQ0iShuZLiHeZaKPz6tlZOiKWjW1+Bm8OyMj4Fh/MupNhFv8rOTbiOYxxYz1F7vPsHB2Z9sHXKMMEZ75AKUhHBU1IvOh+f6W13JI/kQ/9UCFeQy9knv8z98CiV5u8bjj7rR12OYemZhQRYYlU2IH+R8JXkeKBRtKrq6m05ng5c2G5XK6ybmBy6WIfHePuQpHLEZf/eA7oRYgpUBAD3LTgTImo8DJg1fsi7xHRSmDq3BSA7hXOdFmxg60pEB/N7ddxZVocroXaSRMdCk+BkbACqcA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(23010399003)(13003099007)(3023799007)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JF5Rk8JtURXhj5QE++9q87SBpVb5oUZKT0cOlzhJ6h9lFBNon2YhmixLXuxvrQHSyxNr3Q/6sIQEh3QhqyytUGTCBQl8CpFhQNuFxuJR2WVkKGm34vCQQh6C2QPRgQHdpV4Fh+eB+0N2PwzwfScMtF8sFD43r9fugDTNL31hGCF43Q1P8i+s3BhPYoJ7r0MvUMv2MTazvLA1yPItRNephc1DkzsXRE8HxxCSGJmthZXVdURET+cGUxymXDqIi7k5HkGV8ZfxV2RvlU8A2YW9seVryuPom1OYh43oN8pgB1A5+emrarv3bZK4te1mY6H1yEqzR//t+PlaXQCDTFhlA6/d/hUdePOy3q6sxoC66oRIr5aCONh2qjCPy0SbTLsiKE2twEzKO5rpD6l/+qZOBuJQWXyLJWLyBlPDGrXRa/g9XaZKWbyVoZGTg3cMIfa4
X-Exchange-RoutingPolicyChecked:
	QTQ2Xql/c8PbMQCnzXgfYnZ4uE86DAlGNwXUgSNGF+LXR2tldqVIXalbQvU19t3SKRhCcjfAc1qrdzPgeLOlT86WEn+3+FzTL+EqDdUR1AXb8eIb3uNzQQhRlOLhL0XP6OMkEiLL06SQJNGHhtxRmr4Y8ivxihPcmjBpCFSxj1Xr2lWIQAL6TG6K7ckDs+bx44lOzgPLU46InzUQTaBYxZjlWtYmGmXWCFJ/jneFkm27EwBsr5LH8L1XjofsS0al7cb3ANayf3HEJ8+5k2BwVYwYY+b4wiep8UtUeRSjpkZhhvfMrXt+S+gqt/NNwefi7hTy8MMF9FsEONXc7hSMGA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:05:12.3462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abc3596-cbd8-4102-68e9-08deffb72098
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7334
X-Authority-Analysis: v=2.4 cv=O7AJeh9W c=1 sm=1 tr=0 ts=6a88a170 cx=c_pps
 a=2E9rO6gqkamS8B1JEYjvvA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=NEAV23lmAAAA:8
 a=sozttTNsAAAA:8 a=rSe2FQhvlK34XLNHAOAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Ndl4YBmFpg5NhEJasT7rkLKP0-1MzL4E
X-Proofpoint-GUID: Ndl4YBmFpg5NhEJasT7rkLKP0-1MzL4E
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1MSBTYWx0ZWRfX2cmAAfvkGwmQ
 bdCZAD0Txb0wrTu5Xfcw0+6FNLoPWThdDEhpynosZ6E3anSffXlfqD1MOVHVbYe6LUzrlJN+kz6
 lY+Fi7wdebAXWr8ypJPKXlDVnNZGYIw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1MSBTYWx0ZWRfX6xmbbhXCAhVL
 A3FswbDSyPqd5oh1es93AL1IQr02+zfV4AIrNoIsiYsjZAW/Af6ru0FT1W+3pGeI9RexZikktoA
 uzrk0YntDHLwY0Ellgi3fEeGqdHw5Wir/1KTIRFo+3j6ZNbEZLnGRWVUlfTqMcjK7LSD3DEeGSu
 D+1dQEBMfedjGJ29Ec5Xe1NkZXJvcceFODLSmkMdc7KtwixaGc+s1qTJKy1OIJIu54NqoVpGjzX
 4gc43sc+BIII2qUCFXsgAXGkeMeaqLP79zd4CIueF6Yrj33Ah8e9pQ+oJN0/9QAKlT5V5AE7hVd
 L4F5yHZ4amOrXhODkjlkPpbhyg3VSdeCiwkQAllvG7Zu2HovgM5JCbWTd7kvfB31aiwuOFEmZ4L
 IwLgpezezaK1ph3EZKwBzZ3RfODh5qtkkq+Pn3C2XKUfQwzJgQ/e64co4zBQ6Lqs7DSlNioR1Qx
 Du5WSpKx7/ucOV0YiMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210151

On 17:45-20260821, Conor Dooley wrote:
> On Fri, Aug 21, 2026 at 11:07:00AM -0500, Kendall Willis wrote:
> > Add the out-band-wakeup property as a possible property. The property
> > indicates that the device can wakeup the system even when its power
> > domain is off.
> > 
> > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > ---
> >  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > index 2c9d37975bedd652b3060ab11ba75c37565edaad..0663beaa532bcc4a71cd6ad01520a4dfea294d0c 100644
> > --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > @@ -150,6 +150,8 @@ properties:
> >      description:
> >        List of phandles to system idle states in which mcan can wakeup the system.
> >  
> > +  out-band-wakeup: true
> 
> Where is "-wakeup" defined genericly, or out-band-wakeup defined that
> you're getting the property definition from?

I sent a PR to define out-band-wakeup in the wakeup-source.yaml binding
in dt-schema repo. I figured it made more sense to be defined in the
wakeup-source.yaml binding to allow other drivers the option to use it.

dt-schema PR:
https://github.com/devicetree-org/dt-schema/pull/205

> 
> > +
> >  required:
> >    - compatible
> >    - reg
> > 
> > -- 
> > 2.34.1
> > 
