Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD462395266;
	Mon, 24 Aug 2026 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566310; cv=fail; b=YPxF/73Ai9Fi1b1ZYyTSDq8YWbSx2Ome9WBLksf7engnqog4k9Aj8fN8AOWKLwTvycvtv3t6oqCiaY6UjvXRkwTdtT13TMEpeN/zVkQVfDyrWCC0S2ZZYE+/GFZdFWoNSpJ1B+Mh4rlcgA+83hYDGP7o6rduNPAy5VQWot1VKic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566310; c=relaxed/simple;
	bh=IDUFpC74u14MUb3ysKB9aD4/8X6xOZraFJOJzUJ3iQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CTAfV2Kkc4KY2KTPo/HWuhK3n1ApQDTq1Hqws1o0uHP+V1wcRHu1ttMmkL8nMeeHjPI7+MpJL8VI4dEkn5cjgow57ZntC0JSyQnejYmkUO/Vl56Ibs03lVNR+i6AKNsgVY7Jn3sMqKXQpzmC/+fH6YVbxfwOoBk0dFtZc7RJjiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pksXUGi6; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pksXUGi6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksuLPDEhVPQQQo99kFZJQwYDDto2dTTX9+brRtPMKirjy8sMOu7C7jz45rn4iHrUV6xz5xQZs/7RVN5ZgcCCEPAF/vZNtxcdhRXBXva3i5V+DfZstc51GGX7o3f5vxfe0ReMXCjQSvAD9xCIOTo5CZJMVmiqoA27IAR4SIaNPq8SB/ffwH+/Bzr03DgR6Gj1K4PdP89qHL7TeVU60Q7sSeifJtrMm938589/S+vOG6OtpbqFr8lR5xzBeBX4w9eFDu8Ug31I614dsecWP+qba0aW7LWG+203b6tNBjsqKDpNmy2Cif1rf+2jJ7qdSLcH8VtBJftowdYtBlaohp/qiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YLUeWSEczbXATDPSYFMTObsIv74GoJpQQ2kK9wddZc=;
 b=CfbT5c4w7438UzGnV2tLR9EKAIS6ptJAkxMSQ4a1i3A8Z9/B3UxR+5ZSM25oeh4eUd2kfQT19cWtwgNZfedHwUfDuYIr4xMilesdTashI5ZgllvHB7Ioq+jNb7DajAGOsPPPg2Ak0lytnkvDONYhsdAYMFvbW7fW50g1ZTnxIL3CWpbprt/S66JTphTSkctoXmMBWCoCKJ6K/KLAlubinZLvXRco18RMv1pTeFxewa9iCKPtNiDZlV3UhfquKFxrjfjkZzrnDT2pDV2L54hP5Z9jwblAJS9aBYGjRKv0BOs/L/VXPXIRqOuje0cUcIhSqdHa72qtOWoyLA4N3TrErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YLUeWSEczbXATDPSYFMTObsIv74GoJpQQ2kK9wddZc=;
 b=pksXUGi65HtpRzKtZ2teHKb6PxqKX8ojiE3tUC5dF1ga2e8MZf7U9DB5ZLKjZbd7udu75SQMH5bdHWWn0DZ/LGT4xk+9ME4SsOCGjoJaUZ+w3ZVx9rGMHVRndlLV206RTL8fXGZm42A0ZHZ3h7dLzfUonRrpGyu+tlt1IgS7eYYejNxR9KlnXwjAfgN6r2CvqfKuYwB7DKJc0imkMSj8FU2wqENCUqGXaE36sa/fg6yqtymKXzTVB5m6h/laKahlCQXW3tkWHG8LS+V3aAQQlfDzd+5WsRHDXh0Qlt7cuZtx9AvPjs0WKFtTKDGqA39G/ZJwe6v4CmpJrZAF3b6lnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by AM8PR04MB7362.eurprd04.prod.outlook.com
 (2603:10a6:20b:1c5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 10:11:44 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:11:44 +0000
Date: Mon, 24 Aug 2026 18:15:46 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
	Vincent Mailhol <mailhol@kernel.org>, robh@kernel.org,
	devicetree@vger.kernel.org, Frank.Li@kernel.org,
	linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>, imx@lists.linux.dev,
	Oliver Hartkopp <socketcan@hartkopp.net>, conor+dt@kernel.org
Subject: Re: [PATCH v6 4/6] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC
 support
Message-ID: <20260824101546.suqdpitjqm4v2wo2@shlinux89>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-5-ciprianmarian.costea@oss.nxp.com>
 <20260713091840.322D11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713091840.322D11F000E9@smtp.kernel.org>
X-ClientProxiedBy: SI3PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::6) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|AM8PR04MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e202276-58b6-4b21-3ae0-08df01c8191f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r/58OtT0T+0M/Lwpsg6UTkO7dLBb/p/O/CT83+Y1EetQZIt6tPzZu6RJq3ql8TdEWTPhJ8QNQE42o5Xdnz3XNQC/CO3Uc2e9Ovl5uKlmx9JAzIpsFNukSG81hWURjmftbbAnKQiwbLGgaioKJwHN0FYwTRATlUL9y50j+jiH4aaqPhvL6lLXngWRBfG2SeUcSKLaXy6zmDEsjx+pS6IMabCiVyzkMAnzNZ/3YpQX5W7w9hNUMEkS2HfT3dfEK2OfO3jHsAMQ3I/TnzeHqc75bdeCW056KmXcm2lA4EYqxoPjwnZp0hJaRAMf6zm4txh+pN2x145B4wGdFtgui407y8OKn6bjnHCUxUCYtgmpi2zMuoUIZnWyuay0IVSyDnWLkBxohXecOEFbG7VFFubOb+oNJhxcPhFL7a6LKrOmDf0kW/2wY4Z98+rnTkOECwHUM2aLrr562eDLqIjiII2x5KjuLmqOOf6mUtnyhA4iSRJ3OB4aGS31fEemGEMtvUjSQpJaKAY8jKM84m7XiIcT4/qJvGaNvasBDOn2ZM8ziMGj5VmMDkiHlcVsA1G+man+wPMgFF2nCrdX4AJMUiXX7rjFDg6xW1MCQC2Xc+DRcEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3o5V2ZGZ3B1RXFsNzk1VVJ4dzhuSUYvVjl0SHFtUkpIWllqYUVleStxR1Jx?=
 =?utf-8?B?MG15bi9ocEx3MWw2YS9ydzVnU0hUKzNjY2hJeVpFMnV2NDdXUWNyTTlNK2V5?=
 =?utf-8?B?SjdTOEN1aS9CTWhyZmZLc2l3c21wQVMrYlZUckVyQ0E0NWc5VmFyWi9kUDdq?=
 =?utf-8?B?TjJUZGZQRTd6emR1c1BYMFBhRzZ6MVFhcXNJMk40RFozaW1zT0Y4cTgxVFdz?=
 =?utf-8?B?YlQ3MHAyN3c4ZFZPS1FMSGZKWEJkUWI3cEVlTlUwV0c4UDB6WFNpa1ljQzVX?=
 =?utf-8?B?UENqNjluMFdjaU03azNMTmFubUdKNTVvalBrOE1VQXVweERMbXJNY3NIYmhi?=
 =?utf-8?B?alVIY0JCeWFOMmczTExVT2xtSFZ3MlNINERJYkxxUjJqN2hyVjN0Mk5uVHMv?=
 =?utf-8?B?UllBWmZDVytpRUZndmJBK1ZINktEVjJNWlZiM3Q1VWsrRGozbzROanN0SzVB?=
 =?utf-8?B?c2t5WXBXb25Ydm1mOUJLQlVpMlVFRzlNbG9OaHkrS2MxM2Z5YTVtR214S0c4?=
 =?utf-8?B?cnBoOHBubU9XWThiYWtmc1puaklsN1dUSU14eFJFZU8rYng1dUhsbUNoSFJ6?=
 =?utf-8?B?WTczdEc0azBDSUEvc1VqczEzSUVyckpqT0JRbnlSSXNLYmR1b1B2Y1h4UG5h?=
 =?utf-8?B?eWU3THRvZXh3Q1ZkY2NVLzJEdUl2eEEreWJ3eGZGMjIxRzVyeFFQYTFUeXNE?=
 =?utf-8?B?aC9lUlhTYUl3cFdHZHJ2YmxPSGtNb0FoVlhjbEhsMHB5YitBS2Z4N0UrVXlE?=
 =?utf-8?B?eXNkd1pNeUdOL3VHNThEY1A4MlVMemJDM0ZyK3NNaFM5Y2U1dVJ3cjJYWTJ2?=
 =?utf-8?B?ZURndzk1TFdielV6bGgySEFoeDdxcjVwOU0zelZQd3hlWUhPRG45OXhYZzlL?=
 =?utf-8?B?bUN2MGZqRG8vcUw3L2VyU2dzRlBQWGFtM2h2WUZEdEZ3WndnMFZTQWd2Mk51?=
 =?utf-8?B?U1hHV2VxTmdYbHJEN0UvK3VLOFlNSlIrQ0VWMjJpVlkxNlRFeFh5VHM3YlhQ?=
 =?utf-8?B?NUJlZDdIOFdNWExSSkwvaElXTkt1MU5QWWkzZ1NPNDl3UnlxaFgyZlUycDNh?=
 =?utf-8?B?M2ZTSk5WOWJSdWVQUkN3V0JIOVpvSzNUdUgwNTgwMkdxZmdtTkJiREJrK291?=
 =?utf-8?B?Q2hTdjcvWXpPT3hNcWdPVlNxNjVJQkkxdUtPVnNkRjdOcmVrbEpUbEYrOGJy?=
 =?utf-8?B?a2x4Z0hidXN4ZlhlN21oanhDL2duSUxiTHlOcnNISnFLUG1Gd2tMeWZkY3M5?=
 =?utf-8?B?RENxSmVGaGxkeEVDNEN3MHhsNWxqOVlRVS8rbndLRS9iSkVjWDlKdzZqMWQr?=
 =?utf-8?B?OG9SQWFvWEE5QkN0UEZYTWJxNnZqb09hTEIyb2R3eEtmLzRrMWhoKzd5azRD?=
 =?utf-8?B?aE1mVTQ5S0pOeVBJLzBXcStMaHh4eW5nS3VveExRbkdJTUVwSHlvVW40RHcx?=
 =?utf-8?B?N21La04zSEZzTzVieDRNWjZ6dmZ6bGFXc2lkbVpsZzF4d1R6eHJxbEtyQmxm?=
 =?utf-8?B?RmhDV1haYmpkQ2F6MmxSYTBienlOMjh3K0EyL1JrOExXQmVWSjVkYUYyT2VP?=
 =?utf-8?B?VG1neWpTNUJQbC9BaHBSOWVVcFFyUkZPbHhXdkl1Qm1TM3pYYWt4VDc4dkZS?=
 =?utf-8?B?aGVQZWpJRENRcnNHVjZqT1hncDNib3ZRdzlISDliSVNmYm92dmtUd0p0Y0hF?=
 =?utf-8?B?NEVpTXNqSTdpVDQ1VklHWDJ1YS9STDZPN1VlZUgxS3hweXBsYlo0dGRQV0RH?=
 =?utf-8?B?T3IxblBzNW04WTlwUG9xVWtpOXhzQ3VIeDJsSkMrR3h3OTBma3lsbzBZUVor?=
 =?utf-8?B?Wit0b0JBRnRyK2wzU29IMVpzK3RKc1Vwb3FtdGt5SlVpOEVORU11Y29wRnRw?=
 =?utf-8?B?ekV3T1VuQitoMDJScWJ3RW5pamREVWtmdHJVWk5lZjZ2OFFnbUk4U3VlUStu?=
 =?utf-8?B?U0NBZFlaYXRMdjdWSWhvbVZLcHFYQ2tzU0k0RmNwMlluTGVQTmhPSk9XWVNp?=
 =?utf-8?B?amQ2RG1BNkd4SXczeTF0UVZSQnUxSC9pN3NIOGt3RkxQTithYmxGb25vV2Ir?=
 =?utf-8?B?RzY4MDlrWDZjQWJPVitzdzJ2VXQvYkJyNDZycmdrZWlxY01RKzZjTEpXcldU?=
 =?utf-8?B?cnhZaWljNmFSYks4OXRuSmNXVldWMHRmRHY4dmdYdzNYblRGYU5LYktuWVZB?=
 =?utf-8?B?eTlHbjhwSmk2eWNrc0FSVXpkZWZaNWpOSXVHZmtSQ2tTWXNTbFZZNVF6YjhU?=
 =?utf-8?B?Rks4c0M5NVFGVEZBUzkzbXR3am1FVU41RGc3RWRISTBPQ2ZCYS9KYWwvSTNt?=
 =?utf-8?B?SWN6UGZGUWxqYVJ6dktGbTY2QVhzOGh4VW0xMWtkSDk3bmlNQko4SW1uZFpG?=
 =?utf-8?Q?m2ojjbu0wMq8Vh8ZzrFn3ih7AASHeo2GxYlxS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e202276-58b6-4b21-3ae0-08df01c8191f
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:11:43.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: do9hiQSaABYeCSJSrCpWSx3YU6MokJ8jL/gYTK7FIC+CNUsbtpx5/tFamBZFn4aJqEnGlZB96xl9MosVyvFpauWqB06+68O735+n7KBObd42D5h2do5kjNoGnZVCLCTv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7362

On Mon, Jul 13, 2026 at 09:18:39AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The flexcan driver fails to claim the newly added 'nxp,s32n79-flexcan' compatible string.
> --
> 
> --- Patch [4]: [PATCH v6 4/6] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support ---
> commit 81a73119cf0179abcfa99d350e69491bfd8303b6
> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
> 
> This commit adds the NXP S32N79 SoC compatible string and interrupt properties
> to the FlexCAN device tree binding. On this platform, the IP uses separate
> interrupt lines for mailboxes and bus errors.
> 
> > diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > index f81d56f7c12a5..d098a44c2b9c2 100644
> > --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > @@ -26,6 +26,7 @@ properties:
> >            - fsl,ls1021ar2-flexcan
> >            - fsl,lx2160ar1-flexcan
> >            - nxp,s32g2-flexcan
> > +          - nxp,s32n79-flexcan
> 
> [Severity: Medium]
> Does the flexcan driver need to be updated to claim this new compatible
> string?
> 
> Because the binding does not provide a fallback compatible string, devices
> using nxp,s32n79-flexcan will fail to probe unless flexcan_of_match in
> drivers/net/can/flexcan/flexcan-core.c is also updated to include it. Is there
> a companion patch planned to update the driver's match table?

Patch6 add this, so false positive.

Regards
Haibo Chen
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com?part=4
