Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013010.outbound.protection.outlook.com [52.101.72.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C58E2441B8;
	Fri, 14 Aug 2026 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719067; cv=fail; b=ouTZrmVmffsAIrvA4A7mxh5zhP6YUEm1zuSHbEfarO280INnPLM877+1mlmLb/ZtrWuHWXW5yQXjvQioh/bDVa8W98GO/Qu86E2zv0/F0aYfghEQ4CvXzd8QdBDDe+dNA/xOLnINxM2hAX5+jYxbhf/hVHKcvfc+eAnJF1F+G9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719067; c=relaxed/simple;
	bh=ytdQyXJO5EaJZx8lCCIGGTFmO+kFqYpHzRjt7aOyAHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jgpRnMeQuB/m2ocAi24MVzkhlswHRzgy6w6DnDO2QgR/7402Mqn8Tu+M4pnJNmTgJ2VfzLkH5HnsXU7mEb0CB1etj/fTo+QSIhbKNml8+SQal9cxlxvoTp9mueawMjVQqr3rgL0MCXSaT16Gq6f9Oikwvk7xbaja7ZbASpy+bp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eAy0q9Qs reason="signature verification failed"; arc=fail smtp.client-ip=52.101.72.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eAy0q9Qs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LguZRnRieGH+kRk7mzKUvTGgf6pCJCMK7LufYiDR3chIN2dlAr9hxYCzRTUD8AtQWKAdFLGpgvD4QCSqfM8CGcmho+qKgIAG0iGw47KpkK9Lh4nPwsupDC8eSfBuDf4tSBKani4RKwakwvmKFrdWF1b2UNgarPw/TeEpmxya+u5ozS3GhobMGP7387ZVEr9B/UQ5Zs6DanbkMbf1v9qoZhNcotwIvHTkJFd/LkwqYGn6+tZgBOIC8AclcjQsPT2RWKbGzjuMp0XNNe8qcq6JnDVGQgjKV/ezXqEsIoXROLcTZQ/OK+lbfvjskt9LpcR6fYQ+H4kaqXggh9s+cBQzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywPg+TZW9+jAI2UUnXmYW1ySlp1Ggn9e8lp20qr2nbM=;
 b=SzI51CqnspWCSb0nwthdMNpBSKCHCWMlw4be/ojnlj/A5sjKZ1CeWJM73DZXY58Tq2DFUvlph+2NyD2s5MZ63z3AsWLEu2DGY9A1K04WuYNsbjvWiEyYczH94bl5R7HEKmGicAzq98Yz6yegYGE5IVMBJNroDupPtVuUGD/fW8J3hwrrYUVavQYRIhmK1FR4nOuD0j7Gv6Esw68HDRWpI6mPGrRcyeZ1rym1YqYdoJ7yZb2H9V+kY2uPdCEGnIasmNmUi+NBzyFHbScS84GXqVsaU+sbP9ZgkGSHiJRL4WZk9Ov0NM9rn7Ru8nBT4q6hGGtaiJ7pH37MWx8e3iRLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywPg+TZW9+jAI2UUnXmYW1ySlp1Ggn9e8lp20qr2nbM=;
 b=eAy0q9QsFiLu21Ya8EhvNVR7H2PBx6XMQWeQxhsHh1h0XnF8/7PLbsgM+HOnz5L0vZWUB4Ux56YkqJ0mGRlZQq0HYbT4QheyN3/kR3b8gFl+A8qdgXm0RrFIMGH6umuxHm830fvcBSL4mht3Ig5ozp1CnsSfdsHRXhLNUhd/BrPGT4a8si6DuwqFHRIdJHkJavGFhDsU2rzz2ldtdgtt3Szb833WU1pniwbLQU94bXqrbMFRRm5KzLMkzRAgVPKSA98Z2LwEgv7n/vnnsmFFBUBP7UIeDMyeVhnketGUgc0grdNr0x7YMqACtSbhzwt5+YYeDBs4rZO4UoGiEaBUXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBAPR04MB7462.eurprd04.prod.outlook.com (2603:10a6:10:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 14:50:57 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:50:54 +0000
Date: Fri, 14 Aug 2026 09:50:44 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>, imx@lists.linux.dev,
	Oliver Hartkopp <socketcan@hartkopp.net>, robh@kernel.org,
	Frank.Li@kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [RESEND PATCH v6 1/6] can: flexcan: use dedicated IRQ handlers
 for multi-IRQ platforms
Message-ID: <an8rRKaadKgTdBFS@SMW015318>
References: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
 <20260814090324.647898-2-ciprianmarian.costea@oss.nxp.com>
 <20260814092027.86BA51F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814092027.86BA51F000E9@smtp.kernel.org>
X-ClientProxiedBy: PH8PR15CA0016.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBAPR04MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 961a66ab-fdb0-49dc-9712-08defa1370fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|7416014|23010399003|6133799003|5023799004|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6yXjjTO91Olx2AW/xyNnyB2TRtxocSj3zX34Rppb03XMYtnMwXqWE3bOu5CCI3W3hATJjonWNXKTg/Uc7vaVBZXvvmVS5ENMXGInoz7933VBsdjDhuA9e/hEtRA83HZO/nUJSOqcygYzhdjcS18z+YspFL5rgwUfBfhxIPhh5Nt4Qx25y1pJbkdwLBpPf973W1DW92QCS/pZ0+iFefFzuETH35pK9qaCa0G3nwHojTNT2wGlLhfqG+Ec4Cr8zxAUwQOgQyJ/zUht0kAA4iNQuXBEO4a0ADEd9sV+wRjUw3+rscyoCxmSRMi1ukKm2BkG1CNKYl2QNMFPOvJm8j8vTuVTbFtVuH91xbiXOEcTEjI9jMNgd1UT51x73YNwaWcpzhJHtMKJ7Q3YdxpC0n6niZKpmAiwtIze3uR9wUgXAICVTLTi22tFWszTRzQn5HkN6pJA9sGDwzjxI6tLejjBtjVhcWOjs7LOWp+5bbmFo94fzVXkM9gJDo/iYzYrJgqgS3eZaytuxXwRYG448Je2OWgsW96+xk0KOJ3DtmXgiSNT5hsUte0Ak8pASqktOjGovbc5TzDAtdWmJND1BFmWprCvisyyrGd/0z+MSQqBIJc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(7416014)(23010399003)(6133799003)(5023799004)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?/7NP0nyscA62za/tQL/NTy7bCGxMPBJmfhDFjVMYWTopd021eXvHuNb1XT?=
 =?iso-8859-1?Q?3fiSRtgGW1n8KjrzNM/aOay3/Q/IDsWbgrMKGmE9YY0mYdOmcQParRpM0W?=
 =?iso-8859-1?Q?E41HKjPGF4J1otWbHfYLLz1Sm3syRaxno8SrJxEJNvK7J5720nCQ6YfsSt?=
 =?iso-8859-1?Q?mXx+CZvPsV1wuqm/JHFy19cOUWV9cg22AhZy3MVp/QrDLW5zMoBw38NoV5?=
 =?iso-8859-1?Q?NVxPqRpkwv8vUa0HlXEWTPMH1tRTCxiwJ0BYxobMf0UkTsTK0inW0V7XxB?=
 =?iso-8859-1?Q?bn1NzQsiQBSMnZiwJkTDUPKR2LxY8jOxAJ4MRYRAoX8mAx0xCimMqV9TJ+?=
 =?iso-8859-1?Q?1mo1aNFYrak5N5VsUfQPSuO7Ebgl9pj9O6buP+Ujyco0VhOqYkSINKK5QL?=
 =?iso-8859-1?Q?doIDH7+sk5ZeQKqTg5oNU33t91le7+ty2uwtIzlW0bwJ1FhwCHMkppr/BI?=
 =?iso-8859-1?Q?VpwDhhBJbl18UE1zpr5mwaJMGdxrrFsdErgTcrz3rZ6cn9LApMyyIxcJ9U?=
 =?iso-8859-1?Q?gw6pgZ5SKmVgYk/hF74/6nX128Q+WbErDZ86E/mxtB2um1zZDHLKszOxRY?=
 =?iso-8859-1?Q?vnXELz1KRamTgfIxqEneHkclvulc02kOMhsFOg9AR0eaZxAPat1RABa80a?=
 =?iso-8859-1?Q?A+N39x4UMtONIZTp4Sif3CsgQhdl4RNa5110eToQfTIWbLydCaPglsfvDI?=
 =?iso-8859-1?Q?gqgyFrUWsu5eWG9JVPC9ntx2Tdog1GLBRwbocBA9/tvEKTDLrjGJ93wIOj?=
 =?iso-8859-1?Q?r7zm+NGkbIIpGBWlg2LYTbG3eRS2MMc7+1G5UUrF8QIeU2GX41m+BEtNys?=
 =?iso-8859-1?Q?RLY2cmRDvgxGC2oNk0coQL+8T4c3/sypBsu6Aa+XIcA+IpA04iQdD5jXMk?=
 =?iso-8859-1?Q?MeB9mPZxmxQnS2sIPV71OWTXs31zquBrG8GswMFCutWOJ62NiI+FqoLks7?=
 =?iso-8859-1?Q?amS0Y/yO46d3sIVeevS/Zt7ghCqcuRiu2BmXu3Gqb9SJyK8nDDSK0GCOkx?=
 =?iso-8859-1?Q?fHO1SS/RYFOgY5yzoCNkrHkA4m78FnsFB2+RA1f0+4etSbOu6GugLkXBTy?=
 =?iso-8859-1?Q?ir6J6TKhKnrqqwD8NHW5+ZIy3pLsOOHqYegYAlsG8Yk98/0canqj5KgE4r?=
 =?iso-8859-1?Q?NkmWvtJgS+dMSdHc+tJUrXY5IUiPepSCG0C+AcAr7U6KPAmt8Y9h2wSDAg?=
 =?iso-8859-1?Q?Rt9WwoiPyRAOYcNkyNUQFS+ZTSHxWjKJJM7Nx5Q9FeEhsok53WCNq1Z670?=
 =?iso-8859-1?Q?qW/l6DlpLOv5YbHryhjMzM8AS8ec7nnVjkRWkAn98khjxMVH2IELjeh/mF?=
 =?iso-8859-1?Q?ZAXuTqGQBlMKmdTPVFxa0qtFSrqWmjpa6ZqwaEGrlyqI+lJfwWntp9Dob/?=
 =?iso-8859-1?Q?WTE0IUdwl51OeI3rwj5HmmhEamRHcuI4PAgvcS08iBKmZt+F88jNx8BDYE?=
 =?iso-8859-1?Q?TDCVgWF8FB8ZIsq0ZbrDbFUj9dnqITfnfuNN8yG7Gc2wDt0gswaP8X24ar?=
 =?iso-8859-1?Q?Vj1IC6R0IRJz9ud8rnXWi4QdfCpuLNSz6ZtJzZc5W1AQxjoS1INBGi0gu4?=
 =?iso-8859-1?Q?D44/cWdmF64S+HLst+v5tUXIPviISB3M5fU7gv21Va6qdL1HP60/nSSXMl?=
 =?iso-8859-1?Q?aeqgF0UZkz8O73RHGXLykDso7BLsEnSTB1Ndu87Ds9U/BEaR3GEvT6N9kH?=
 =?iso-8859-1?Q?agq5hEcn/jzBZht8I4cTZBwnSMWoZX+z48iiym8cRJKgvG0V1DvjeDk5Rs?=
 =?iso-8859-1?Q?M0ErlNCGa6RRA35sHEpHg4U1BcpokRJ1SOQ/x+bAX764kXfs78BK9+K9Ml?=
 =?iso-8859-1?Q?CKe0RZnjnTT0qImS9L8hhDANlB37Owpf/9Od2BuNb7Emggt8W/bI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961a66ab-fdb0-49dc-9712-08defa1370fc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:50:54.3173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCuzxxBQJVMffCe4sCGix9Jx8cfb3dFpN5jdQHAt8kH4C5uV1qEyOjAMzaJmdEtSsTr4tDRqTwEfeqcgyqtKpOpGNvLCMmuQ2Fep4fTia2i1wj6XFgRr1xtnw1I1H7IJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7462

On Fri, Aug 14, 2026 at 09:20:27AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [High] The split IRQ handlers break the FLEXCAN_QUIRK_BROKEN_PERR_STATE workaround on multi-IRQ platforms.

Please check this one, You can fix pre-existing issue later.

Frank

>
> Pre-existing issues:
> - [Critical] Concurrent execution of split IRQ handlers locklessly corrupts the shared `skb_irq_queue`.
> - [High] The patch fails to fix duplicate frame processing for platforms with multiple mailbox IRQs.
> --
>
> --- Patch [1]: [RESEND PATCH v6 1/6] can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms ---
> commit 4696683063946bcc95216f931b7fa509b55610f8
> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Date:   Fri Aug 14 09:03:18 2026 +0000
>
>     can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
>
> This commit splits the monolithic flexcan IRQ handler into dedicated
> handlers for mailbox, bus error, and state change events. This is intended
> to prevent duplicate frame processing on multi-IRQ platforms where distinct
> IRQ lines can dispatch concurrently.
>
> > diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> > index f5d22c61503fa..f73ff442d5304 100644
> > --- a/drivers/net/can/flexcan/flexcan-core.c
> > +++ b/drivers/net/can/flexcan/flexcan-core.c
> [ ... ]
> > @@ -1131,25 +1129,57 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
> >  		netif_wake_queue(dev);
> >  	}
> >
> > +	return handled;
> > +}
> > +
> > +/* Process bus error events */
> > +static irqreturn_t flexcan_do_berr(struct net_device *dev)
> > +{
> > +	struct flexcan_priv *priv = netdev_priv(dev);
> > +	struct flexcan_regs __iomem *regs = priv->regs;
> > +	irqreturn_t handled = IRQ_NONE;
> > +	u32 reg_esr;
> > +
> >  	reg_esr = priv->read(&regs->esr);
> >
> > -	/* ACK all bus error, state change and wake IRQ sources */
> > -	if (reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT)) {
> > +	/* ACK bus error interrupt source */
> > +	if (reg_esr & FLEXCAN_ESR_ERR_INT) {
> >  		handled = IRQ_HANDLED;
> > -		priv->write(reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT), &regs->esr);
> > +		priv->write(FLEXCAN_ESR_ERR_INT, &regs->esr);
> >  	}
> >
> > -	/* state change interrupt or broken error state quirk fix is enabled */
> > -	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> > -	    (priv->devtype_data.quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
> > -					   FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
> > -		flexcan_irq_state(dev, reg_esr);
> > -
> >  	/* bus error IRQ - handle if bus error reporting is activated */
> >  	if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
> >  	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
> >  		flexcan_irq_bus_err(dev, reg_esr);
> >
> > +	return handled;
> > +}
>
> [Severity: High]
> Does this break the FLEXCAN_QUIRK_BROKEN_PERR_STATE workaround?
>
> Before this patch, the monolithic flexcan_irq() checked this quirk and called
> flexcan_irq_state() on any interrupt.
>
> The FLEXCAN_QUIRK_BROKEN_PERR_STATE workaround relies on enabling the bus error
> interrupt to catch state changes on platforms where the state interrupt is
> broken.
>
> Now that the bus error interrupt is routed exclusively to flexcan_do_berr(),
> which never invokes flexcan_irq_state(), won't state transitions (like bus
> warning or bus-off) be silently ignored on affected platforms?
>
> [ ... ]
> > +/* Mailbox IRQ handler for multi-IRQ platforms */
> > +static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
> > +{
> > +	struct net_device *dev = dev_id;
> > +	struct flexcan_priv *priv = netdev_priv(dev);
> > +	irqreturn_t handled;
> > +
> > +	handled = flexcan_do_mb(dev);
>
> [Severity: High]
> This is a pre-existing issue, but does this still allow duplicate frame
> processing?
>
> If a platform has a secondary mailbox IRQ (FLEXCAN_QUIRK_SECONDARY_MB_IRQ),
> flexcan_open() registers flexcan_irq_mb() for the secondary IRQ, and the
> primary IRQ registers either flexcan_irq() or flexcan_irq_mb().
>
> Because these can run concurrently on different CPUs, and flexcan_do_mb()
> unconditionally processes all active mailboxes globally, won't both threads
> still race and process the same frames?
>
> > +
> > +	if (handled)
> > +		can_rx_offload_irq_finish(&priv->offload);
>
> [Severity: Critical]
> This is a pre-existing issue, but does splitting the IRQ handlers make
> skb_irq_queue vulnerable to lockless corruption?
>
> When flexcan_irq_mb(), flexcan_irq_boff(), and flexcan_irq_berr() run
> concurrently on different CPUs, they can independently call the can_rx_offload
> API (like can_rx_offload_irq_offload_timestamp() and
> can_rx_offload_queue_timestamp()).
>
> These functions insert SKBs into offload->skb_irq_queue using the lockless
> __skb_queue_add_sort().
>
> Additionally, they concurrently call can_rx_offload_irq_finish(), which
> splices the list locklessly:
>
> drivers/net/can/dev/rx-offload.c:can_rx_offload_irq_finish() {
>     ...
>     spin_lock_irqsave(&offload->skb_queue.lock, flags);
>     skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue);
>     spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
>     ...
> }
>
> Will this concurrent lockless access corrupt the skb->next / skb->prev pointers
> leading to a kernel panic?
>
> > +
> > +	return handled;
> > +}
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com?part=1
