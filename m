Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908540927A;
	Thu,  1 Oct 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870877; cv=fail; b=RZcmBeWcVLucj8z+LNObh2Rx5yi9ywnrqc+mJjZfMslUMRU8eYmPWvJGzHyJP6XvlxGQYVZGSY/djiynISvBfNuHUPs1ZtLIfRbwN/58JsIfd2Zb8+PeN3Nbxfbzyc8BfUNPb7OAA6GmEdUcGr/MUM/TBKfdudHdYMWH73lsIhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870877; c=relaxed/simple;
	bh=VIUg8UKtO2Lb1bPm0uFLOj/W8ULNQC4pLoNrAnuQzyA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LD788crq4p8Nn+hcQ1tgKstZrJL/FO+/TvFgz9L1/IbQuuYtnUWB8IaB36MP1Ow6KGk3Cx5/2Z/+M82LIftmGJxWnE4p1BgmD00674Hz6pGHKC+sQ8n5rqbKgwuYqdtnYg3ZuiZ2XesideSFhobJCv8YXhtRhBl0eJm9I1aPMNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=TqSFSHZ5; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=UFrRXHI1; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="TqSFSHZ5";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="UFrRXHI1"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691FsRgv2350580;
	Thu, 1 Oct 2026 11:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=mGfdVULzHPPz+Wb
	UCzp7W5APXzJyRtcmB88L2GizIkE=; b=TqSFSHZ5CGOkSJ1fw2URW9ILhaMfG9b
	083YfEw/Z6BuzlMr1klOKwliJ+UvYI5mrsiCCmPOa05+rUhOnwLIrQcTudvpnMLj
	/Cy4Fh3fzZh/3PgoIHqJUtXxipoh++DT30eeIo8VXUbvCwDzhy6Aqx082gN97Hj9
	pr8Ff0rgZJ/K2uZF2+SksvO1rzCKE6BUllq8Wi0CREYh+IWb2R9F48CUTJy/WD+f
	ILqCPuQ9XOhpXPGASLvN2EReKUwTSalGQjp9rZhXDr9KHRx2IHDhqofs5kuZAWTo
	oYl7GFrSnCAcHXP+pr4BctCWGlmnb7MU5TDUCqhkfTq4JvD5v8Kyqgg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h1eurcdhe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:07:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VetbXqmX+QsLBa7FmEdVOYRUBXnCqI86Ci+sQkxnDL0OvXi4TKHNftlFngiG3OxqVNyrnhfFMJrtbRIYsJgjL2leCxroUMwtv9latkC8PZFkgfhTkbQ8Mr6oiOnBC7K+MPUs9J+THyNhykc5N2g92Th9e8fjxrS2d3kFOfXG4D+VmKyazkWBps1cgI0k1iwReKuX1suwtiFfa3WnSeQB4exPAYsvDI39I1Fj3lvSwwsJGkNbZttGVfQ6cTBM9i1f+u2881/NXoMrUuxZksKEeA0emczQzwXHj5KPo+BwkpZwIKwasVfV2kHlKOBY39ltrGPmHCvwwt/gPY8Q/uVl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGfdVULzHPPz+WbUCzp7W5APXzJyRtcmB88L2GizIkE=;
 b=oMD46Dvi6/OdSJJr+BIoExUxStj+93HJvHk2ttvMDCSDKbSeOOq8ePHlz5vo7fH27YW5na50WESPFbwwhc3/KYqJHlB3l8w9wf4Mlsp+YoUIccK2wsvWTcPe+7HevUqX0WgafH8V6oihz6PM7P2LqNMeXFwMfXfjV3rYbV5I4q8l2TVm78phSF/pzMsaE+1jZR/hLXkh8OVf0+NubDnvvyFn8+QhkFDOE4axGas0NoqB8/dQl5HmEj5U03Kbf1oz/ziGoHTLLo+d/yY/5NZPAAXH+XAU3ARwcb3rFwK2XUk+IW80vl3a81EuoaP915LjEjmPBnSH7tWfOrW+PAsoQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGfdVULzHPPz+WbUCzp7W5APXzJyRtcmB88L2GizIkE=;
 b=UFrRXHI13l0fypz1np20enVzrPBkjKjIVcJWNZLBJD+RHmFLLlaj0cFUbRxH7X9gOf45vZNHVDu2u3li9Bwh4SXxZK6isUfT9zGUnuK5Jlbli5KHEVgPZfucgHcXWNOru0oTU0xXH2WHFfR6eaCUn+Tz5hU4bHKgIEo7ZPMgRWI=
Received: from MW4PR04CA0094.namprd04.prod.outlook.com (2603:10b6:303:83::9)
 by CY5PR10MB5986.namprd10.prod.outlook.com (2603:10b6:930:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 16:07:32 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::12) by MW4PR04CA0094.outlook.office365.com
 (2603:10b6:303:83::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 16:07:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 16:07:30 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 11:06:43 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 11:06:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 1 Oct 2026 11:06:43 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 691G6hN51291367;
	Thu, 1 Oct 2026 11:06:43 -0500
Date: Thu, 1 Oct 2026 11:06:43 -0500
From: Kendall Willis <k-willis@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>,
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
Subject: Re: [PATCH v7 2/2] can: m_can: add ti,am62-mcan compatible with
 out-of-band wakeup support
Message-ID: <20261001160643.idj27xun22ow6s4w@uda0506412>
References: <20260924-temp-v7-0-f40defe5957f@ti.com>
 <20260924-temp-v7-2-f40defe5957f@ti.com>
 <DLTEQW8XYO30.3684CENKEUSOQ@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DLTEQW8XYO30.3684CENKEUSOQ@baylibre.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|CY5PR10MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: df51a246-be26-4697-e0cb-08df1fd6188b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|10067099003|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IbYcKJvOJkkgQR8dXly+xj68Ov2gfVDsvhJ/lLx3oivliuznVwPeZ99h+2CZgRc22XtMFFToi85eGp9kk45HTk+olzZzpiwOdOzGmKb8qdkE/miEjQfZjAMUe16xApe2ueMpdRJFzv8IKsUQClHyBUKQ6TmfoTJDbnz0DN/Z/Co8seSD4WvDvNzVFf/5ZnqBxDpWyABsV7eGzrBvuJ1n5Ah/ztGZvFPklEWszFao7xrS1z9cbLCy6DsmXTB1OvElL2lRWn7LWxekFn6yeNQDpk3/x1DIM1gZ+sF6zQI/u7bKVehaVXaosSs+5X+IcBI5ImGGZESDtqU//6slCYLihHwIh++TbYNpTFtzGjTnR46KyFujdmdZuPe5tK+r588yZJY14YVkNfsaFN9wV6EvPwMOfhDrC9EbsVUqlox/oezRCUm1TysQM37dYVMlRANvidvOAdQHvWb5gHnS3BIQupmC0Iizpp8VkAmAN4ajg+54lLuOH0FzpSbW9V9zE3fLvdMagCXV9+hcj8Gwe1EnkQyh6vqCU8UxsIIRYHskEIwgxPdXaU7k2KP8xWzVE2yU1mABwUWO3Z4hclrdqKfe/yR7kUu6BuqrI7WJuJTd4hqh/y/yQO70MGLElw8+8pDqQeqNxDIGa8mRHilspW3cFxC9pgYe8bmhzGLaq8GTu+S4AOYOL+kIz1ypTX8eKkXhR7Sbkia4etf0V8/73ijGzA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xN4WPAtYJuO8k/B9YcYdikYeVyCqupc+e9vEmqIxkD+vbprWaHyMX96eZux3NfSF8K58BHAp95qppkfaa079YVLK12nl7NaXaZkabUuKY8z4fUeg93C/JyjzJIZFJu1G0/H78w3Ag3IdPu8ucU96eIut8PJlip0dbFjfS8KPGn+Y+68NggeG9K3f/tG8ju//jndiAEl6jKe7lj1hi+WWQTFG7e9wSrbQH08ALMCXmRzZONmclJXvUTTM36+K1BQca5cpFFyMlckUObLOEUuDk98KH8SS4X2sjdnfRsFpi2G+nHrFfrLm6VIUgj/aMCxZ6CS220CaEZrTFSdF7HCvTWAVgNF8gmQ+AFhdpU2pBbJ944tWzCEIj4ymO4pcbjJsnaE9QKbaLZfp4QKDS8JglCHEuqq4CdGfZQEKHl5vVZmrwGbWQTSfddpzzBTwCAcr
X-Exchange-RoutingPolicyChecked:
	wacXjE4fvkHs+yjyUu2mgRJqV/fk3ukNSIzNaJX+TxOcWHlQg2BOkY4UiNIc4tiKBVjaJPb5Wp6iZrP4ecjsu8BjAQD9F0Z9Ld5ofXez/KDVyfQaJOQcRdfGPK/oUd77AcDjOMdzdgMNVag36arvFuUVhnVnAATBpoiv0kilDZW7ICTgNhkGPOlRtR1rSKhveCXER92DGgNs88pOls8gzeb61/1tQoMoB5wFa3X/XDPYYdeUCV2mEKEf/0rfAqsWWXy4lmxRmqzVMUXY4eU0RzKUDLqOPTyz/ACPIKGgWxdkJMaJ67rdrYk2Oru4fkAOXxmdgr30IGtlFqzUpsMb1Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:07:30.3854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df51a246-be26-4697-e0cb-08df1fd6188b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5986
X-Proofpoint-GUID: a1ChqtsRoCRm0X9a-IxawCCvvLeq0MTR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NCBTYWx0ZWRfXwMXqdP4oQyyx
 Xo8GMukbBhrM9luxdN6507bvJv3TJxx7WQnMAgBB+TGbz5eeeTWZ+kvdGTm+LFVBfuQ7+3tk49C
 X0+86LvHHF8jzWoT8dCRX8hkSuaOOQy8BL1hVpNPlSBbDtk0GhQifJIdFiCYlNe2sEBKhUPxOqe
 +1a0O/u4S0kT/apH/WzgW9nIesiatAGkJ3Nf/YArE9fK8tM4PD+A4Vf/i0DtWSKPdKUbvznwlDy
 Nv3OydRGaCQsIs8mQkacaeQZ58yVIEy074UIsBcF4MnMrJoSJFQwtYrrDdHedKRPjmr5YNkv35F
 9kgWerxUfHmh0isThTdK9YVD8xdGt/69eBqL1hriWcdBgxPQI9pbqga/DRm5/32piG8YpkeG+ku
 NqubIaF8tt9WxcggUNfTefDBX7vgrLkmLM9Wi2DA678x0bw3l1bSG66917/HNw1yJWt/aZa6CyN
 1pGzYZShw2Jh3xLZMmg==
X-Authority-Analysis: v=2.4 cv=KvzYSmWN c=1 sm=1 tr=0 ts=6abe8547 cx=c_pps
 a=0JRlrhwbVVPmsaj0kffiDg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=pmgOy9NOvdzOA0mfTKsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: a1ChqtsRoCRm0X9a-IxawCCvvLeq0MTR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NCBTYWx0ZWRfX3U6ZuiA8r+k/
 705R8HyHZv68XdQNntrQ6CDGRJndlfw83iZwM9KwdQOx7owLc/rtqDWEIi0Qpdp1/ArYJbeLOx9
 3k/90bAj9G72g/Ld7qVR7jWH62KnGWA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010064

Hi Markus,
On 11:51-20261001, Markus Schneider-Pargmann wrote:
> On Thu Sep 24, 2026 at 11:54 PM CEST, Kendall Willis wrote:
> > In TI K3 AM62 SoCs, the M_CAN controllers are in power domains which are
> > OFF in the deepest low power states. However, the m_can pins are able to
> > wakeup the system from states where the power domain is OFF through its
> > out-of-band wakeup functionality.
> >
> > Introduce the ti,am62-mcan compatible with match data to identify the
> > out-of-band wakeup capability for TI AM62 SoCs. During suspend, set the
> > out-of-band wakeup flag when the device is configured as a wakeup
> > source, the "wakeup" pinctrl state is present, and the match data
> > indicates out-of-band wakeup support.
> >
> > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > ---
> >  drivers/net/can/m_can/m_can.c          | 10 ++++++++--
> >  drivers/net/can/m_can/m_can.h          |  6 ++++++
> >  drivers/net/can/m_can/m_can_platform.c |  9 +++++++++
> >  3 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> > index 91a0c5eca260c19fa97c6f5724341cad0c1c95b8..815a11531ff47b8460aa3efa3075804b4f769848 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -2628,8 +2628,14 @@ int m_can_class_suspend(struct device *dev)
> >  		cdev->can.state = CAN_STATE_SLEEPING;
> >  	}
> >  
> > -	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
> > -		pinctrl_pm_select_sleep_state(dev);
> > +	if (!ret) {
> 
> I guess this !ret is from an earlier iteration? Code at this point is
> only executed if everything was successful so far. So I think you can
> drop this outer if.
> 

You're right this is redundant. Thanks for pointing it out, will fix in
next version.

> > +		if (m_can_class_wakeup_pinctrl_enabled(cdev)) {
> > +			if (cdev->out_band_wakeup)
> > +				device_set_out_band_wakeup(dev);
> > +		} else {
> > +			pinctrl_pm_select_sleep_state(dev);
> > +		}
> > +	}
> >  
> >  	return 0;
> >  
> > diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> > index 4743342b2fba3823819b9e2bc5b085cc0fe6d1e2..da64e6bbcef2a721a330e67fd852ca4a703c5794 100644
> > --- a/drivers/net/can/m_can/m_can.h
> > +++ b/drivers/net/can/m_can/m_can.h
> > @@ -132,6 +132,12 @@ struct m_can_classdev {
> >  
> >  	struct pinctrl *pinctrl;
> >  	struct pinctrl_state *pinctrl_state_wakeup;
> > +
> > +	bool out_band_wakeup;
> > +};
> > +
> > +struct m_can_of_data {
> > +	bool out_band_wakeup;
> 
> Can you please move struct m_can_of_data to the top of m_can_platform.c
> to keep it local to where it is used?
> 

Will fix it in the next version.

Thanks,
Kendall

> The rest looks good to me.
> 
> Best
> Markus
> 
> >  };
> >  
> >  struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
> > diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> > index 51dd41dbf2c9a971295994946e190ec0187addd5..dbd59730c0bc16f519cb2c40bcd8093ca1bcb369 100644
> > --- a/drivers/net/can/m_can/m_can_platform.c
> > +++ b/drivers/net/can/m_can/m_can_platform.c
> > @@ -83,6 +83,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
> >  	void __iomem *addr;
> >  	void __iomem *mram_addr;
> >  	struct phy *transceiver;
> > +	const struct m_can_of_data *of_data;
> >  	int irq = 0, ret = 0;
> >  
> >  	mcan_class = m_can_class_allocate_dev(&pdev->dev,
> > @@ -148,6 +149,9 @@ static int m_can_plat_probe(struct platform_device *pdev)
> >  
> >  	mcan_class->is_peripheral = false;
> >  
> > +	of_data = of_device_get_match_data(&pdev->dev);
> > +	mcan_class->out_band_wakeup = of_data && of_data->out_band_wakeup;
> > +
> >  	platform_set_drvdata(pdev, mcan_class);
> >  
> >  	pm_runtime_enable(mcan_class->dev);
> > @@ -218,8 +222,13 @@ static const struct dev_pm_ops m_can_pmops = {
> >  	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
> >  };
> >  
> > +static const struct m_can_of_data m_can_plat_am62 = {
> > +	.out_band_wakeup = true,
> > +};
> > +
> >  static const struct of_device_id m_can_of_table[] = {
> >  	{ .compatible = "bosch,m_can", .data = NULL },
> > +	{ .compatible = "ti,am62-mcan", .data = &m_can_plat_am62 },
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, m_can_of_table);
> 
> 


