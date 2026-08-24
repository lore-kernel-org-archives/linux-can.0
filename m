Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429D3F86E0;
	Mon, 24 Aug 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566124; cv=fail; b=SJRQYiE84sAgKHEAlaXUMUzS7G023kQXR4aV+C4xVsQvbAudFX2w5THxDG1QyNwu5zdvClvjGM7KEoZ3YmJEVGXIjgQcLz1OcZUg+iy7l7RwAA9VCqt3mT+TV9L8inU9iJUwyPCJSbAoz68ZANj2h+T6dgsRhphzs5u/QlUkoZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566124; c=relaxed/simple;
	bh=iHLVF9wSRp06PsjGYbwfhKHXCXlOR1oOahLaXCEAO/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fqqi9GT4PQCme2v7H+VE3KRoFG6pUTTRHKpGtk7o/cQm04yIcTgOmBtMJUuK0BSmKT7e+5CrONkr7ZNY0uDna28cwZzOnlLIhIZ7HWMsp0Xry57JIeINIwJtpronzBKD8mlf1ylUtemVm4h9yWBnjSd2dEKU4C6a4Z+5gbZ6q5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fOm0AYQT; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fOm0AYQT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIITdJmCLf6uW9OKBn9+d1SYmP1V3f8u/d9jZIGutPkmhatuWCRlAX6LQmjNycGt3rjkz430l/PNhuSFQ6dmQ1BGdWiZ0iBXKzlZW7Z/Kcxe+Fl85l16EBgV1YtusGrq9rm3pSuptalgf2LkAMnke42aWSZ+sWLzRH3GceXISiDqnZzLnWEIWZoqjYH23NmAexvIi7OeurMj9j1YwIflqpootbTUI7L8HynfwtFI8Uy0BxGB6IB8dzBljVIg1MASz/fHps46uUMaQ6e8T6TCHCSdIOycIayYFWPdkumU9uWtABEanqA11m7ajzt4IsDsI99+d/wh2PfGg3xKiADhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYVRvnrgg5W1nNO8LGYvsnvX7rcGq6KZ0Axjq/8/ZLQ=;
 b=M1jxvKtvDK1P1BjjLRYbrEHKf8KUFb1y56MC3W+UsFV1DogZO33Ly+P8iMVHPCOL2j2tylqxsVWPYXcV6dD+Vuo8TpjyDXf8ijCsweWjt6E5vzAgbOcULWll5/B/LpV0PkNcCvv88g5QSXKzW3/M54nL0L/sZo3WJ6pAY7C3Oa+FbFhfhM69vGWdOU8RVCaGScMXu0ACbgYIMbgIHpBdwrlBRgm8ynbkkQ1JoWurZe5qOQMJN+JuhFIQR3AleRJ3CHneGLvV0c4XgjKURpF5GdpwZMeI92LcQ2EDp41nt+k87yZt6M+yhcJyTi/5xozgRRd9uPYitZbra1kK5GLQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYVRvnrgg5W1nNO8LGYvsnvX7rcGq6KZ0Axjq/8/ZLQ=;
 b=fOm0AYQTZigptSc0ARG3EW3FTlC12hf8hyCAN6ZYMTOXtHdje1qWqXys8+soX0n19p6HdkpFIFdLDjMjqhfx0IeAjaLk44kEFFyUo5ICjCtlgF0JsSe/0bGQ7AFXlHsaG7wv0DkLb8xOiKQ51l+jYdLGJxDwitEHNtnw52jhH3RyFfT+JpYZgHjzdHpOZnYexviWXUZbbHQzKX91ei9+YtKxtVl7aD7CjzrJ4cDHSa8sb7n4kCTZUHztoWahY8ELGJLsaeHZfE5IDmSPgr3N4IU02xmz39UVNDZhrShqtiB0mn8kYoftPcLKzGJnhFRdT3JSeCbGoETEswHyO6f4SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by AM8PR04MB7729.eurprd04.prod.outlook.com
 (2603:10a6:20b:24c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:08:39 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:08:39 +0000
Date: Mon, 24 Aug 2026 18:12:41 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>, robh@kernel.org,
	conor+dt@kernel.org, Frank.Li@kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>, imx@lists.linux.dev,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/6] can: flexcan: split rx/tx masks per mailbox IRQ
 line
Message-ID: <20260824101241.ysq45swzx4ihctel@shlinux89>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-4-ciprianmarian.costea@oss.nxp.com>
 <20260713090803.CCE2E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713090803.CCE2E1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|AM8PR04MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecc165a-359f-4b3e-4fa7-08df01c7aaf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Rz4FnGhiMFuOuHLWNWQPyxaI5TNTqnmSotn+3gTM6arG4EGcUfGkgaz7gU79vgD1BLOVAVHREVN5lrmEkfVsTY7L0dB+IHSgs5lNyPrZDTaJqlnYkZEJy5ohuUGYkyhOdXanbbDFg1fIDeRAtKX5sSqmvlGKBtHe0oeeuc83ZyXTcBlJOqET+nFQy7181YoBQaIksfUVpSA1692GlZe4oGt8/yMrEuY+KDvjsHbG/44REXeqL6jDv4aLqvMCjR19zzW3igy8umVVDpa5vlaXLnCPXkM9SahMMs4jtgJ1D4oByWcCHI9dD+wkIGIhMPs8tNObcA7g5Usz8FnNZNB04AsPNjlQc+gU6xKdep3NlOOd/w2uYIVo1mEIRFdGhwrF/+/zmoMApHu5nG09pZ3ZMPO/gQNUbD780vejHvQoTgxR68lxH7UEC83WVI44n+TAbvvrZMK6WU9LOuKhx3kW2tK5Ntp0QyuXo2SMCu0VjcJ9w0u49CqAHsebxvpwOzD8+vqeCNgXjXjPrnHlTIOwtOTGKr8rv3hTOFB98tD7UPihb02iTLPmZwa72Vl5xLejJvi3fAYHN6ZndzVZdpZTiR2uA9ALRAl0GDwm1tNmEHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTc0dm9vRXAxL1RSTjRlZVVSRGVBVDFITTBwRWNKTzFFSHl2RXBRaUkvYWVT?=
 =?utf-8?B?RGI1VkFucW43dkJjWnlFb05EM3crMlhldzBLMUg2Y0xoVS8xR05pVXJuSW9N?=
 =?utf-8?B?bHl0NDBxdFBqZnd4SE83SDFoS3pRd1k4bHFoZURaeVM5Rzg5VmgrU2lyQlhU?=
 =?utf-8?B?YmU2TC9aem9QZ29OM1hoWUpOOVBDdEtnb1pINHV0bFd2VFpOODgzSFV5S1Fw?=
 =?utf-8?B?ZHhSSGZENjVITTRtcXhlbVo2S2pJNlVrakFpUGdqYTZvZlo5aEE4RVgvdlR3?=
 =?utf-8?B?ZDdRWjdEampQTU5FQ3I3cmlnSUM4cnhFcWJLakR0cEQwaml0OE5pKzkvdzRw?=
 =?utf-8?B?ZmFVMWxQVEp5SEZZeHJHMmp4ejR3dUlwc1BWRlFpbExWNTVyK043aGQrZlNB?=
 =?utf-8?B?M2owLzB1ZTdZUmJ4MVRJTktZZGZMVzJiQXNNeWNtdnZQMU5pcEF3ZlZRbkhw?=
 =?utf-8?B?SExxamxvNnBDRkFILzNXQlpjTXFtSGxjQ0UwbEZpUDl5MHhSSjFNRGIxV1li?=
 =?utf-8?B?VnJ2Q1RIaUE0azBQODlYa3kyT1RvOHByUUFiT2YrL1dXNW1IOUdQOEpaL2J2?=
 =?utf-8?B?RU5uakpqNFBzT2xHZmNDSUhZMGpZR2p1emp4Ti9rRk4rOEJVTVhydi9KMWh2?=
 =?utf-8?B?MHkrb3RjeUtwT01CM2I1TytJc2pqUkN4QUNSOGZZOGtTZFhPaUpkNUxacG4v?=
 =?utf-8?B?NExhOUk2UjZxc1N3TzBTSVFlZjJ2Sk5zM0p5V1pDL2JqSUZzWVZDMEI0aGlV?=
 =?utf-8?B?MGFVYm9PTWRDZkVZQnJtSHNjVTFoREE4Tk5ET2JZTGVzZzdNVXdKbkozNVB4?=
 =?utf-8?B?WmZsRHNQN3IwWmpScXo0YnpXbDVTalZTYzVpTmVEMEYwRmdnZTNVWEp4T0Yx?=
 =?utf-8?B?Vi9rYkhHa2dJY3RrT0tlVTlYVmN1c3J5dXZBSDg3c2MwT1lwWXVXb1JMaFJJ?=
 =?utf-8?B?QTNJaDBuN2NkazRlbWc5ZmxQbTIrdWx0SEtxWlRJSWhqd3RVT2ozVllzcUEw?=
 =?utf-8?B?VEJJVFl6bmc0Qk04cmh1dXQ5N0t6WHVuVTl3eGFKemMvV3hIV0Q4NnRvU0w5?=
 =?utf-8?B?czFXUUMwcmhLcGhYU3NtSWYvSHVZbVJVaVY3bjRXTStuMWRBMk5yalExQURu?=
 =?utf-8?B?RWkwWGJZS2lJcnpTM2NVZU5vV1hTYVdrTFVOT3pMRXlKNVIzUE91Y05qeWRP?=
 =?utf-8?B?RmFPeTY0YmNoSzQ4MFEwTzRWdENFNEZ5QWR5T2lXdmJ0dHhZQ1hBNU45Q0Vq?=
 =?utf-8?B?RjYxY2VKa0hXNmxCT1Rob2ZZYWZ1TTNIZ3lVL1FVUzREOFJSWFRNTlBHZENl?=
 =?utf-8?B?Y3p1RlBiOVYvK1YxZ29yeXA0Sk5ydGw3VTVSaXZUL2IyL0s0YTBZQndoOFRs?=
 =?utf-8?B?OWFjZ1pqcDF6eHRqSndHS0lIWUp3d3paN2wrTnNCSlVhQkNoNFJYUXJGVXNo?=
 =?utf-8?B?NktOZnpwSGJMUDJoQm5EV2hWZzN6dVhBZGthRFBjT1NvYk11a0U4RzRadmUz?=
 =?utf-8?B?UFR3RnJOR1VWNTgrYnI0QVJGVlplVmhFNUhJa2hqbWtoSmhOWnM4b3FyN2F5?=
 =?utf-8?B?MEJpSXRYandKdGJ0bXRjNGM0eklKSm1QZFpsNEJ6RlliWXdBQ0FMTUF4b0lT?=
 =?utf-8?B?QWJuQWNXaEpaY0R3bmVvb3NVS2tjN0dZTklTcGxaTGRLVWlDY3ZaTUdsM1BT?=
 =?utf-8?B?MS9yNVVoTTk0MjBHSXhjQzZnSWZiS2s4bGV6Tnp2SDcrQVlvaDdCQnYxaEtT?=
 =?utf-8?B?YkFEYWVCdnhEbXVRTi80UzFFVEtWNUhNenluWVhQeUs3bXZLSzNRd2Y3Vkh5?=
 =?utf-8?B?dlVwRlZocThYZk5ZL0VYSEprMDQ1LzRobkdRY0JRTDZlMUE3RHBNeE50NnNp?=
 =?utf-8?B?K3F5YURndkxaMVJMUFp0S1BpdDBob0RNV29UZEEwS3YxeTQ2Y0lnNk1jQXdK?=
 =?utf-8?B?WXdGck9XRmsvejRwMWJaRXhBM2J3RStETkFOb3NWNUJQTy9PUCt4UnJ2NUVD?=
 =?utf-8?B?NW4zNDhVRGpSZmVQZXhRSVRFWmJ2bFNsUXFhVnU0dmhieXp5ckxIUGhWUXhk?=
 =?utf-8?B?MWIrSGpRLzl1cXg3RzFPTzdPVHhEbTNQK0UrR3BXbUFEdThYM2REU2NIYnlR?=
 =?utf-8?B?bGVrQVQ4bUpYKzdhOExiMkxmTUFjS0J0dEVLMWhWWjVtY0tzSkt5WG9ZMWpM?=
 =?utf-8?B?ekxOZkxLYlFuYlpBOTNkZU5ieXZwM3V1YUh2K0lsUzRHRFExdVpMOC8xQW01?=
 =?utf-8?B?THFYK3pKYXJCNlFYK2w3am1jYXJSWFJCZThISE5IWU10Z3I3bEg2THArMzhs?=
 =?utf-8?B?b0l5dUNFdVFxUnhnQ2ROeUVFMUpRRyttK1U4UERjOGNrRExDRkhnNDMrazFG?=
 =?utf-8?Q?7wov6kLlw62K26vAG1cYjd6Guh1iQk9xtwHM0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecc165a-359f-4b3e-4fa7-08df01c7aaf4
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:08:39.1592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DigFz6z924GgtNn5cURoLKxytena3rYrD7ZQ39QKt3XlmM2ME/qg933u0kp9LoxCegXRLGpv6MWXP9cJuLMpU0olVdr9D9AlhTbUz1W/v+tb5PBll5PB4lL7+4JgSbhD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7729

On Mon, Jul 13, 2026 at 09:08:03AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Concurrent execution of multiple flexcan IRQ handlers causes lockless list corruption in the can_rx_offload queue.
> --
> 
> --- Patch [3]: [PATCH v6 3/6] can: flexcan: split rx/tx masks per mailbox IRQ line ---
> commit 9f143e05fb5957d463ce1d05d4126d168798b0d8
> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> can: flexcan: split rx/tx masks per mailbox IRQ line
> 
> This commit updates flexcan to process split rx/tx masks based on the
> mailbox IRQ line for platforms like S32G2. It introduces MB0 and MB1 masks
> and passes them to flexcan_do_mb() to only process the relevant mailbox
> range for each IRQ.
> 
> > diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> > --- a/drivers/net/can/flexcan/flexcan-core.c
> > +++ b/drivers/net/can/flexcan/flexcan-core.c
> 
> [ ... ]
> 
> > @@ -1244,8 +1255,14 @@ static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
> >  	struct net_device *dev = dev_id;
> >  	struct flexcan_priv *priv = netdev_priv(dev);
> >  	irqreturn_t handled;
> > +	u64 mb_mask = ~0ULL;
> > +
> > +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
> > +		mb_mask = (irq == priv->irq_secondary_mb) ?
> > +			  FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK :
> > +			  FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK;
> >  
> > -	handled = flexcan_do_mb(dev);
> > +	handled = flexcan_do_mb(dev, mb_mask);
> >  
> >  	if (handled)
> >  		can_rx_offload_irq_finish(&priv->offload);
> 
> [Severity: High]
> This is a pre-existing issue, but does this concurrent execution risk
> corrupting the lockless rx-offload queues?
> 
> Since the primary and secondary mailbox IRQs are separate lines (e.g., on
> S32G2), they can be dispatched concurrently on different CPUs when frames
> arrive simultaneously for both mailbox groups.
> 
> If both IRQs execute at the same time:
> 
> CPU1
> flexcan_irq_mb()
>    flexcan_do_mb()
>       can_rx_offload_irq_offload_timestamp()
>          __skb_queue_add_sort(&offload->skb_irq_queue, ...)
> 
> CPU2
> flexcan_irq_mb()
>    flexcan_do_mb()
>       can_rx_offload_irq_offload_timestamp()
>          __skb_queue_add_sort(&offload->skb_irq_queue, ...)
> 
> Or if CPU2 reaches the finish step while CPU1 is still adding:
> 
> CPU2
> flexcan_irq_mb()
>    can_rx_offload_irq_finish()
>       skb_queue_splice_tail_init(&offload->skb_irq_queue, ...)
> 
> Since __skb_queue_add_sort() and skb_queue_splice_tail_init() operate
> locklessly on offload->skb_irq_queue, could this lead to corrupted linked
> list next/prev pointers or infinite loops during list traversal?

Hi Ciprian Costea,

Please double check whether S32 can generate these two mb interrupt at the same time, if not, no need change, just comment this feature, if yes, then need to add lock.

Regards
Haibo Chen
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com?part=3
