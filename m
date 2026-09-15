Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26E440F756;
	Tue, 15 Sep 2026 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488589; cv=fail; b=SWSK1N1C/qau9E4D8cnynIL9s4FvxvnfMtSlZ/o2gr0hl77xmnhqseGBMaW2hAVqsh4QKz2ej+UkK5jMT7EiBwWUtUzsJyiW1+BamSPn3HHYiNnnFHh68z6rJqZLgIacwMYghufiUX7BSYeqU1s/krOR/STCrnQjr2PNHKGNciY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488589; c=relaxed/simple;
	bh=lfkPHnvXzsrwH3MIvb4eO3UOhtEVntM7rx2Ykrmp+DM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMDzGcLrgy7w0xC+rRJKpTrwPBY8CJliNkPbUA9bC0Hme1BVXaX5vv9jCT4pRKdZXpuVAsy79iqe97NAqSfDf68e+bzGrAWV7AM5RKnzPaHXLUW3C8e0KpXhlrZ8omyEKrM9JgOVvCBti9ULht3MXfH9oajXjkdA0MvK0aHdZtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=dEvKOXsR; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tRUIF4Ag; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="dEvKOXsR";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tRUIF4Ag"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68FF6YCC329914;
	Tue, 15 Sep 2026 11:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=8GyxHw9Aw0QUtPK
	6ljVrLxl33J3zXMQqx8gbWnj4t8w=; b=dEvKOXsRTJOWywV6WJXqEFLAD1bnAgm
	lUU4pt85QoheSz6YC6bNm/9dUctXDlJB5kbyh/ozhbenTgAjgCLn+jwvuF2DHAfK
	rL6ZrojGkUj0YIte6fD8+9vW9Lu+WWiOzuXm08k67AjD98ZgOhDu2+e5uCqUCylh
	32+4g4pjcB4PBEJZnKttR+zpvEq6wbmTeV0S9O1PmOPrks0qjUpdEde1/UEsMYQP
	S0Ba7awA1NuhAtylB1lBt4v9KcOqUujzTmZbo/YgHvhs9m7eqtNsjfCjmNZ3m7Ev
	nlPKZFWlNK/eeGwBTs48ZB56+Ayd6pHytxqRbi/YgHgDRKxMcAIoxpQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gq58jhxrh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 11:09:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCMF4CFWj3mS4AxFGjearCfUgEgB6ryBtqTlj56kZApWrXbTgkM0+lXEKUKZaf3lGsmQGQ8P+qnFN5oJ3uc4r9KBru5r1eXzJF0QpU5NQ24rSEAvnBBFQXB2HopCV0ln49rug1JWdtZLRINKXdqOdEh1D86q048lVW/IVGfJ0OdRt6OuZRX7uTWPhd/O8zOCX7vCmPRfNunNBulPABy3r4n3I41kuBoliyWUEfOyRhuu8Mpk60a1SeWVzvgDcZ2wqSaXXipXb2fMc0W4oy/wu/QVptOnyxfwrkM+UpSpYCTg58ncvdfgoqspgosLG36pwxakYUO67L9vATw2+3re7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GyxHw9Aw0QUtPK6ljVrLxl33J3zXMQqx8gbWnj4t8w=;
 b=Qe0ENjNiPJ7hngfyi+Xv9qEK6sBzxdPnyVC8VgIJnhEYPkOGJhvgbvWqlLOlLtRShds9Tu8MxQEUohZTh+pBodUgCyNoip1Ktald2dG9gVOQzvqPN8Ftnakc5qT0cvyYBs3xtXfhFxkCtXScdSZQWCywULyeefzEwMd7ASqXFkEKG/3+qOJ07bTeXmR0u/4FOzNBUtNOvRS1FXPyjBLq8gpgZTUiWzQ95GTp1RkIOavF/qMIbK56DId6KCO2h8jcIyOl6oHHTmoghN7GFfEzGGLL3jZUdyYea/3nRqi7qN+uIkrJve7Na5VWi57PjKQkBeMTjdJ7GYgnHZCsIUK78Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GyxHw9Aw0QUtPK6ljVrLxl33J3zXMQqx8gbWnj4t8w=;
 b=tRUIF4AgXh2iDL9dXxSU84f7gRHbeMA6uCmiUE/NM12EXQTBE1aUHb5LcPWxpKazJFxTuBPpRQSAa/GtSHQIRHy4v1/RwJ3kr3oisDRfVe1nXNvyK6OXSVGtjL6xBk8/3TAgOC+OTboV34V3l6yTUzqLXlH5KUAPw5SD2juDOX8=
Received: from SJ0PR13CA0139.namprd13.prod.outlook.com (2603:10b6:a03:2c6::24)
 by DS7PR10MB5054.namprd10.prod.outlook.com (2603:10b6:5:38e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 16:09:26 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::9e) by SJ0PR13CA0139.outlook.office365.com
 (2603:10b6:a03:2c6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 16:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:09:25 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 11:09:04 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 11:09:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 11:09:04 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68FG943q3538193;
	Tue, 15 Sep 2026 11:09:04 -0500
Date: Tue, 15 Sep 2026 11:09:04 -0500
From: Kendall Willis <k-willis@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
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
Subject: Re: [PATCH v5 1/2] dt-bindings: can: m_can: add ti,am62-mcan
 compatible
Message-ID: <20260915160904.upqi6jvbvdlzgsmi@uda0506412>
References: <20260912-temp-v5-0-2e3201c02109@ti.com>
 <20260912-temp-v5-1-2e3201c02109@ti.com>
 <20260913-impartial-mongrel-of-speed-662ea0@quoll>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260913-impartial-mongrel-of-speed-662ea0@quoll>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DS7PR10MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b010539-08b9-4271-0e24-08df1343b6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|23010399003|82310400026|376014|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JLb8G1U5tvpQ5mhzgAtBB9On84pgvcH3PI9BbvbxQUAQv/OGtPxG+VkAqHVwWZVDmK1BPgs8Gh99071jf77n+7Gyx1kPtTlC6Vumiyn+QjI1+KoHBpoKK84JNX/hoAVSDan1fi5TqEP5jpGbXiYDDWVvPIJARI+2OkHkECryrFro/tj8J9eKPOKZn3qyDZJqHMaeabGPJp7+bSs0lnBeyvBvQwaGPBlsWcoNufvrjyVZMAfMnk46nAlsfo/6LeVHCgJWljZ0O8wivdjQbA18HHg5LlydUmC/W+FbxKmVis/aSvEwlNEQNY0kZXlNMgFz1NDFw7zVnXmqp58hMdSuBGYP/95WH3uTp8Q/cT33S4arXXpSoLH0o7q3L49zsVWEoUt7Ehe20MX93uqkzQj8fCi7HyRfczgbWGkFXV0ZhHj0+zfeb4C7KHE4aikr32EHu/zYAuEr1/meaVnGToBfAjwXDLBvUiQVSeYvI18tqlaTnI1Sp69C45IKNOTyD02vBm+URrHB5xZmG6AyBR0bhbtr6WoxC1EzPO8uzbu5pDZlmOFrzOIkMUDH0SrllhkxaDwQcANlX37ItN1o7ltsO4BkpVIMbH2zC5fmFA6hjdD1q4eYaYWC/Zr8vOdq7qkmJ54VjbZ7iKkaFcFxULaih5dBJefTxRfprF5wl37LzWC8Uh6sK1Wf4FQ56F4Kw2FTtNIcGb2XwRNo0HhCiEcNnw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(23010399003)(82310400026)(376014)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+TSM0UUTc5M2ZQnjQpYEFQOYgn7Hxkw/muGUYEu21/GsbNRjKx3eDzQFUO2937L56+C4BZ/+rJKFwqrolcFKsEE0sWuAXAF/WhrP07bTWatKpFrQKBB1mMoIlJ34tiKjECylrbVdXNaVuMsoUx8+AeGopN2d4d1NJWGLF11GCYAtM4gvlO+RI00X1yjqSgRe78i1+B605EIzGd3N4xE3ifvrS1aa1XjdeNSbJH1kHdQaPaIoR/AjBWrK6fgc3d2ul1OVHcUSz4OXEXXKlf6WZqBdV9IZFY0fpvaZswLAZTezoaJOxQvk87aFKs18NxkdHz+3IYQi3ye48J51WjvXOaDXEAe6JuFGLN2JWp2sftvEVZXtR9iOaKc6dA7bL6w0xL6NkESITgyX4956e1daebBBWWS3QqzU+4vLZpVaGFz7YvKMvy8fAwOmssyRVuu4
X-Exchange-RoutingPolicyChecked:
	vafvUpF4lDCQCEeyUTpsOcBTwPe+k1DwiM4/HHgrGQ8ZdEotldbFetAbM1a0myNls3A1esSOIb9nQEMsn/VzPLjiyVXAqN/kr4o9nRyCcjNy2kIoLDB6Yn70AzEWnxlWe5m3JrZg+JeudYQeyT8uT71KVBQ4gOl0hCb/cH2a1v7/alQnYzfDzrQO2FYuDlG5r9Yl8Nd8bC27XyHOn+KRjL5FfGMwiP46YZonpv/HQVd5BMg7MSm6SBI1g2fvtXe2rP6VHHlSM0HV0zPb4qF3YVMmDhOfm3NsNsdAEyc/SHKHjwYqsHWc9+kMp6YInWXYn8JO9Qbn56YL4Kkx61HfBA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:09:25.8198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b010539-08b9-4271-0e24-08df1343b6bd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5054
X-Authority-Analysis: v=2.4 cv=FMaOVOos c=1 sm=1 tr=0 ts=6aa96dbb cx=c_pps
 a=KRP2IWdqZ9jDnyY58Ngf7Q==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=EDNX6AqFofHscsgubBwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzNSBTYWx0ZWRfX31ksyHJSWr0c
 eGYKxcch9kp5MzbijiCRoH5irzo/t+1HZPZH1Z41U5NT6bdD4jmExFylMROYLeBa8TinpBUsTxr
 dtFUfHtlqprBBUKhPTlUfvTJEmC7A3ROLF0uY3w/MzqJzP6OU6Zfo8WGxRVOuRI3XL6VdFcKHxY
 9EBjI3RAJb2r6ysYoB3SxO14dsnH3fxmsd2ST6Ox6CqzJl4A9fu8VvLz+YYkH3zBE692pJ7feh9
 pr8Ct0LCYsLwSKYfQeiXvZ+szDseDZTmlYXAhnI86EvS4ePd8iHxJx7gCNPfH8xFssYDEsYV+va
 /sSDZkuMmXNLC8E8cvJAvdM9zzTfe8G2siLKLTJmeItHSbMdfhaF7Lj3i0kf7hjoDk6C/zcNeuu
 656s3hXtk/b+bNgTuPjH8j9exSA5uLE+0Tz/T70GOnRxC7aB1pj6T52iAVIU46Wb0HAk66sTxhg
 SZvQNJOeC2/J8FDtQYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzNSBTYWx0ZWRfX9oLyNO+mmEo+
 uv+JWLfiOyJVpmtVA+vWJKZKE99iFsyUSG3jMT3o4syRO8jDR4yTnIENtAZgSIUn89WzFhrzTrD
 jQ/G7Gba7u1+uYemuVbhrKeALD5nwzY=
X-Proofpoint-ORIG-GUID: aLo_TaWmr5xxi3HK-vLAXUZzhsqLnm_8
X-Proofpoint-GUID: aLo_TaWmr5xxi3HK-vLAXUZzhsqLnm_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150235

Hi Krzysztof,
On 09:54-20260913, Krzysztof Kozlowski wrote:
> On Sat, Sep 12, 2026 at 04:26:55PM -0500, Kendall Willis wrote:
> > Add "ti,am62-mcan" device. Device is fully compatible with Bosch.
> > The device supports out-of-band wakeup capability.
> > 
> > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > ---
> >  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Fails checks.
> 

Oops my mistake, will send out a new version with the fix.

Best,
Kendall
