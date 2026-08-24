Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA6334F46D;
	Mon, 24 Aug 2026 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561599; cv=fail; b=tAkZYLGLJt7Yurj484m1hveoYQNukx2TZwaekYsMEDQHeQ4WKsvRvo1hpYtcezyeE/9xvTmf50P7WeTpko79G3RkQlGybC9cPh7OV3c+pWtxsJHZcc/HXnMa2pVzdbIkN/uIxthOL17AXHcAfPhP+2LH50p4Kzk/TwZCYAhhfcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561599; c=relaxed/simple;
	bh=EZgIjF57ZlCInfoUvWnovRvsLfGOEY8tBk7i8Lphm7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bbW0+mSbwN9SCdG384gp4d8ZXeWNgxoKOEMrXHKgG4XxCMinxetXc5/suWnukz17CXzRxQ4QE7ijXSBVrML0/XeBCYM5vxCKVWujeKkGOsYK35FS1enRmnqsj6VBrycBLlK/uvDwZCfU9tVT910qjFbsySIlPB44SBdbCcm+TKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Enw+Xe6v; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Enw+Xe6v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qz/01lqgZ0UQm7hENY1fZXdVJ13zoqTHpKMzxYAwRsP8WQ/hk/kxMNJl77T1tft3HTJGhxNdWxmVmVkiIg/8n8MWgt2AcKTkTfLOl0CrjBhe5oaM2E7iBFKSl7euivmKjqElId3Lbe7JrIQjPIn/TcN4mgpGCRi3jokTJgUHtwZVzVyMHpNK6F6+rC609p11TlTAgZyjGN4Tu3Wmm+SowXn2lsL111vq+pJrMTC0Yt4RQ0tHe4Yc+osBSuUfJX1IHN2bvJbYWUy2VKeZceY+T2Ra8CiGx+x2Jct1gHsnACgk99k3wytX8ZFLwHCF2Z/W85PGb/Z3OljONmcG7Nz8og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12zBfk+he8jQA/690UiN7e3xBqzbLg50TypwV+mLoAw=;
 b=F1YoZLvMpa5LYJDNTA4j1DxTGGxaoU2bNSpCGCK4VX96g9IS8OIo1NAUsIPbroS3JUMifrbheyFRdAZS0T3lFLXiLFWOhM0mpII9dXqrmbfXrfG81LxzytfH4crfobg66OvuVH00V/VF8aNO0JDZVzk9kfJBry3eQwvOA/RjNt9FYSZh8f0hFBlelD0AA5TJYu+qcrf6F1ybUwMNi4dKMdITcL3KFI1r4DaAbpdHu5BhW2V14Ik+bGPpVxh8sdrd+JI3mGXUjeMKEEsMwVFpeNXBN9X8bYFX9Dvi7sjnqDgSus7+aSxcNXxxbjq/TM/LU6Q0+3gKFPaMgcnTtwK2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12zBfk+he8jQA/690UiN7e3xBqzbLg50TypwV+mLoAw=;
 b=Enw+Xe6vRn/0gNlRUyOpZe6PSzpQT2oFassA9G1eUsyTMLOeDAhzoHP55O/XCT2J9sio5NDUBd4R7pZ0w04qg3ekk9afRCSBjurvjl2u83H2S+20wek3P2tV8xeFccBanp1kTWmlyRkmAKkfGEqoMiWL0knPx/LGEjv0eCiJ/u257zftDrYnAqTbzy+j5qORwAzFezR9/PZWcYcIU9vuqSfpMGgSeKEGZdRYvwfacxsIOSsrAULS2hqZFUNqKGgCz5HkOCW84vn+j6IE2tWHoDlJa+B/Jd3CbNTOoI6Jni4QLvf9aRnZCOcBeHiOC++uuj7eYwCJ8bOCDp6+lq0p6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by GVXPR04MB10874.eurprd04.prod.outlook.com
 (2603:10a6:150:215::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:53:14 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 08:53:13 +0000
Date: Mon, 24 Aug 2026 16:57:16 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
	linux-can@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org,
	Frank.Li@kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, conor+dt@kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/6] can: flexcan: disable all IRQ lines in
 flexcan_chip_interrupts_enable()
Message-ID: <20260824085716.ejrveo5udehy4ijc@shlinux89>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-3-ciprianmarian.costea@oss.nxp.com>
 <20260713090705.9F7671F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713090705.9F7671F000E9@smtp.kernel.org>
X-ClientProxiedBy: SI3PR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:4:297::19) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|GVXPR04MB10874:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d903ca-3d98-4546-8efb-08df01bd21cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|23010399003|10067099003|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qc13qZNLyR64CvIQikIaiS99TtR3BgMqxA/3yUxjv4qM5+uaNwd3T9k6bDxDN72Dd8fp/Eg73H4UwEIZQ2z0uUDn8vXtxjjBasMg1Hp++SZt+2VelYtfRVYySACmNJ17LaSWOJEFZDzNlaO8TiHozUusKKGYS/bNu5g0IoCsAJXU5933FArkMpwq//ejcs/cw58zXxgVH3XA9h8Bj0y6wmEFCoU2kU8C4YktZMMSxDdH6Qu/KvBpsVpdLPRcX25Omryq4lqfSMKF8LJSYV65piJWGyPK7lLyvYvZIGg/AUU33FTtCaZEd8jGCLOuh1HL12K9uY3uWh/L9b0i4cX+ClTI4pAfIY8829jz/OgVKfiJQbVNYuAdm2V9Gg5SrQjCTcb6/BcoMr+2HDIEw7xtnO6hYOwSxEfbTrv06JLAVf/W9lpe0UDN96sT1tFN+vSBPvaO2WTmSoLy5qLqqS8eoudPAkQuxQvNxuD7NB0SkzYjUnEkVkTJ2GOp3a7ivUSPZbWBmqqvlE+2xwHcGcCy0VdI/tJez6JTzvbtGP/Y8UkSvN0/zoiborp0NqxIFSa/JWNSVeGwZFq306EKs8P05PNjowXc/McKO3d9r7F52rI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXFBQWhVNFhWY0wzSitxWklnNi9JeURzSjNBSUFDRTVCM0cyMDBKT0Zjcito?=
 =?utf-8?B?RHpDcFlwZS9MTTJQTmRaaEdrZG5Ia1FMd243WnpmV1hqbmVLelhWV25GeUVG?=
 =?utf-8?B?ZG5NRDNma3B1VW9Fank4SlJEYXIwZzVuTENmR1o2U1hYMW9RTVpoVWlsQnJI?=
 =?utf-8?B?ZG1tMkZEaStTS3p2YXE1TUVmL2xMOEhOVDNUd3VLMjVLUHRPVzUwK3hCTzJn?=
 =?utf-8?B?TFYyL1lFbmpIcUlzWm1JaFk1VWZHL3Y1VzRUWm5zREJKTlNXRElxWFRsTjNV?=
 =?utf-8?B?K1ltVkkxbDZwYWVYWWlKb2paRUVjU2VUSW0xSU9ibTl3K3BWalRnbW03VE5p?=
 =?utf-8?B?Mi9ZRlVVOXZ6T3pvRER5N0JES2Fma3U4VUVIYThNazNxYVRyQVVIc0JoOFBr?=
 =?utf-8?B?TGkvNVRpMGtVTmJJaThlaWw3TFRQTU4yNkhVV1pmYXl0c2kwVTE1SkxFSVRm?=
 =?utf-8?B?NWpIbk9aSERlYWxDVStuNmU5N2tlb0Z3OVBJQWhHd1doNWRuMjlCY1B2WlRu?=
 =?utf-8?B?Uld2Ym96eEllWnA5R3ZGdkFFMUllQTloUldDVC9sdkFNRXR3VWVBYXEvWFJF?=
 =?utf-8?B?N3hWSzlZYm5qODZlT2dUWUVWTHRzQjJGZmxhMVRFVWhKZlk2bDNRWmFHSkd2?=
 =?utf-8?B?RVFXcTd5R0lIOFN4U1JGU3FreVIwNHZhTjRSVkE5NDBmMnRtalFvRW5IbWVy?=
 =?utf-8?B?L3JvSUN1SWZ1NE9PdHVwSm1vcVhKOEVwV3R2enJQRldTc1FXakFhV3Q2Vmk4?=
 =?utf-8?B?K2Z1SGFzeEF3OHpOR3VGSTNSd2U0NGNHb2p1RmhLZXhYeldNYUE0NWM4dmVM?=
 =?utf-8?B?dm5CUU5FWWpOTGpueFlETnFDYVAyOFRJc3UxTDFSNFdFY1pvd0QyQnplZkVJ?=
 =?utf-8?B?TFRCMThocTljVmVlZlBMT2VqSENybnRZcmxBdXpqRDdsTWhjdU04ZU5VU2RE?=
 =?utf-8?B?Rk1ZYzhQZUZQbVpOU2Z0bzJBN1VFS0pGMHIxN0xTeFMwejMyc0ZUZUJudk4z?=
 =?utf-8?B?L3JYWGYxb25ubi9idkE4elA0c2dXbGNmaHVSNm5mSWtoTnhHRjRKUHJZK3J6?=
 =?utf-8?B?bi9vc0VvVkxuNHhjNFQ4K1RXSTFxdDRCUnVUMUJyNGhvYUhGK2ZqWTFmQ21x?=
 =?utf-8?B?cndodEhsNS9Yd1JrNFR0a3h4RnRibWx5cm9CdHpJbnJ6alhpSmp3OHh0SFVi?=
 =?utf-8?B?S3RYT01JL0MzdWZuRDFFQzFFaVpheHNaOVIrQ1A2NHJkMTgzMDdoMWxjZGNW?=
 =?utf-8?B?Unk1eEhEYURGQ3Bmd3dKSS9TcWpCcUxtZnpWT09XRXB5RVc1SS9teDgzMUVJ?=
 =?utf-8?B?LzVrMEY1d0lGc21rUmVUeU1oM2NMeWJmTEl2MVp1WGhYSEp6VEJ0QmgvYXZp?=
 =?utf-8?B?UXh4Smx3a3Q0eGgzNVU3aGxHWm1ZaUE4SVhMaFc4cjkzb21xTWVRenZubXlB?=
 =?utf-8?B?K0p4aXYvQ3hQNEd5RUx3T3JSUTIzaGxrcmN1MmJoOXowdWRxU2JMQWdoTWtj?=
 =?utf-8?B?Tnh4bndzd29nbmpNTXBxbnVmYUp5eGwyZVNJWWtSbzY4TURCTldIOStFeHFQ?=
 =?utf-8?B?eExYQmM1RjVTYVJnUTJQRHlWaE1ucU1jNWhjVW55SVhRc0poRmJhOC94bUVx?=
 =?utf-8?B?Q1Q4aFpaQnp6ZHF5WGtGdXZZUnhwU2NZZGZyTVRqMEVWVkUxbXVMcUdlWXoy?=
 =?utf-8?B?djJqYmduUDkvTmtML0piVE0xQXRMNHNHTjJ6UndEUk56dWJ4VXhvczhISGVz?=
 =?utf-8?B?TWZ1SEYvcmFIMGdTcGY0K0ZrOXlrWGZjdjAvbWdBVTAzbFhwR21RbWIzckpQ?=
 =?utf-8?B?NFdSdEtLVTBZZzlQdUlobWR2eGh0bndVMDdzRklOdytZNVZrN3VieWJjYnpZ?=
 =?utf-8?B?clZRckxEL2dlTXhLWXpOdzZvOFV6WkNPZ1E0WG5ZMHdwVHF3WEtocVJhNGhr?=
 =?utf-8?B?c0plTXFtK2w4dTdpSytmb3FzeEJaa0FmYjFVZS9VQWdFb000RldyZEkzc3B4?=
 =?utf-8?B?MU5Va295QjV5c0hFSURVRDVMYUpjVlAwYW5acmF4TGR6TVhHU051SUs4cXdp?=
 =?utf-8?B?TkdOQ051aFdCeExoZ3BFSjNkZVRHTjVrVS9mOU01V0kyUVZNalQxeWdUa3E5?=
 =?utf-8?B?enBGdGhXLzJ4RFBETFBWOERMNEMrZWlZYUZWTW1MT2dFSnNRdjdlb3VxbEJH?=
 =?utf-8?B?MnRyenE4R0JYS0lyR3N4aFVaWkhQQ2lMTW9JaXQ1ZmVyTUlyZGRneUt0aWtD?=
 =?utf-8?B?aVZLWFg3Q1lucE9nTWU4VjJ2QTFPWlFHSUxvYmNrcVdxeVQ3emtOK01xY3Za?=
 =?utf-8?B?VElqL21vMWl5Njlwc1Q4VlByN3VMTzMxUDROT1VlS3NjdjZHTXlsUnhkSWdQ?=
 =?utf-8?Q?++sHVVW63plMf+coUNeoLW+e1M6++OD2FOSu2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d903ca-3d98-4546-8efb-08df01bd21cc
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:53:13.8771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5yCTdtAAiDM03I8Ei0fBYubeNmj3ONV0aygSyGMb7LffA5RpSQ0RwcrK2lKNFrMw0Yay7afBQV6OZZpeSbWE/uP0caw9NC5d/eTsKOVAIDPsoTPRtVrWZn3CzB0ylup
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10874

On Mon, Jul 13, 2026 at 09:07:04AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] On multi-IRQ platforms, Wake-on-CAN is broken because `flexcan_suspend` only arms the primary IRQ (`dev->irq`) for wakeup, completely ignoring the state/BOFF interrupt (`priv->irq_boff`) which actually handles the wakeup event.
> - [High] In `flexcan_resume`, the network queue is restarted (`netif_device_attach` and `netif_start_queue`) before the hardware is initialized (`flexcan_chip_start`). This creates a race condition where a packet can be queued for transmission just before the hardware undergoes a soft reset, leading to a permanent TX stall.
> --
> 
> --- Patch [2]: [PATCH v6 2/6] can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable() ---
> commit ca7ea75d45df1ecf13f11dcec0bd19377eccf3c6
> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable()
> 
> flexcan_chip_interrupts_enable() disables only the primary IRQ line while
> writing to the IMASK and CTRL registers. On multi-IRQ platforms, the
> additional IRQ lines remain active so their handlers can fire while registers
> are inconsistent. This commit disables all registered IRQ lines around the
> IMASK/CTRL writes.
> 
> > diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> > index f73ff442d5304..7dde2e623defe 100644
> > --- a/drivers/net/can/flexcan/flexcan-core.c
> > +++ b/drivers/net/can/flexcan/flexcan-core.c
> > @@ -1519,14 +1519,28 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
> >  {
> >  	const struct flexcan_priv *priv = netdev_priv(dev);
> >  	struct flexcan_regs __iomem *regs = priv->regs;
> > +	u32 quirks = priv->devtype_data.quirks;
> >  	u64 reg_imask;
> >  
> >  	disable_irq(dev->irq);
> > +	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
> > +		disable_irq(priv->irq_boff);
> 
> [Severity: High]
> This is a pre-existing issue, but on multi-IRQ platforms, is Wake-on-CAN
> broken because we only arm the primary IRQ during suspend?
> 
> In drivers/net/can/flexcan/flexcan-core.c:flexcan_suspend(), we see:
> 
> 	if (device_may_wakeup(device)) {
> 		enable_irq_wake(dev->irq);
> 		err = flexcan_enter_stop_mode(priv);
> 
> Since the hardware asserts irq_boff (which handles FLEXCAN_ESR_WAK_INT) for
> wakeup events, doesn't irq_boff need to be armed with enable_irq_wake() as
> well? Otherwise, the system might fail to wake from suspend since the
> interrupt controller won't treat the asserted IRQ line as a wakeup source.

Yes, this need to be addressed.

> 
> [Severity: High]
> This is also a pre-existing issue, but does flexcan_resume() restart the
> network queue prematurely?
> 
> In drivers/net/can/flexcan/flexcan-core.c:flexcan_resume(), the queue is
> restarted before hardware initialization:
> 
> 	if (netif_running(dev)) {
> 		netif_device_attach(dev);
> 		netif_start_queue(dev);
> 		if (device_may_wakeup(device)) {
> 			...
> 		} else {
> 			...
> 			err = flexcan_chip_start(dev);
> 
> If netif_start_queue() is called before flexcan_chip_start() reinitializes
> the hardware, could the networking stack concurrently call ndo_start_xmit
> (flexcan_start_xmit) and queue a packet?
> 
> If so, would the subsequent flexcan_chip_start() soft reset wipe out the
> freshly populated message buffers, aborting the transmission and leading to a
> permanent TX stall since the completion interrupt will never fire?

Good catch, those two findings should be addressed in another patch set.

Regards
Haibo Chen
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com?part=2
