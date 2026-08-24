Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011028.outbound.protection.outlook.com [52.101.65.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7E83AA4F9;
	Mon, 24 Aug 2026 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560125; cv=fail; b=t/I1TuFk5XRyDI7fOhsVE9inGu/ya59fnMlZCATodbrvWhbgX+6ASwE4qtvKecRC28GLO1IOJEXGqJSNhIXLoJseL8rQo56zBlfB5ENfMcH1Lh1DFqlXU6VXouf/+znpEyGzSviArhx97B6NnOmdmpCxvjt/iIr4ZYM8w/g/g94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560125; c=relaxed/simple;
	bh=REYqvN5nJBHHrzIk6TtjZ1rssgLt2QmOVoMJ+FWYKEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mlvt12nIY9N0MjM0Gf6y2O2INPUb/e94Xfe/XX0xfMf24j9ApxG3z21XQMwL4GsHF12Kx+IsOweArPmKmSY3Ezr30D5HyzruRyZX+LOChadOx3ARJsJ8QpdYcBKKriKK0fcmk0iE25+X8/A4IfvhmMORaSBtcrulfvyvPHnzUhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GM9DGFfv; arc=fail smtp.client-ip=52.101.65.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GM9DGFfv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIKnwU2MFrpZhokdKGEmMxfnmjGUp4HI2wCHlP5p4jTGQ94wDu354G4CqOXu6DdFF15JbuBuA5DnvTU4Z1gN+6wQXfiLo/088i9se08Znspzb00PLMp+roB+n7r1mq+vdIbqBME5whnfWF7Ajpfc4Tavv66S/nf3vfJQuue2vxFB/WVEhTs4XX6m3q6xssRSldnKGtmWrh06aTl4ju6vxLQVfUAYL4hsOw9YJcR5ZgZLsuuHJqJKxVgtvbXH+yp0qmPpEtcq8Bhyy/UA8plbk0BYB9y/vLtTpFpxi1gexzkFYqU51TRj2PynBhc55H6kPNyrIxosXawRcbwQANcAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvng7MbQSeBupUPOlnUDVFDcCfsW3x39oLxZU7EDWGo=;
 b=ti9LDS4xFGxJhpk4aEPc+ad6e4FGBU5QcDrzdDgzSMC/3yYyEOStu4C9ERCGmRSQudQw4Jlk+tC7g4WDfMtpPSHZwWLh5YO1kDwqb+EnwnEQWoGQARI9jKrvU/VpTxXOtlN+5+7pwbUaNvL1moyLPhdl3oIAJ3d+nQq4aq8E+weY6Fjd/pxst9PcYq4cIHrAnA8rbKiFiUaZ4CcPT8mvGct4vdg70C/L4FqcTT0q0bcZseiCmh0sYxROy70rb8o1xUX5xFxi8vM7ofgXHSm/7ALlxC5vtnxqe5oMqIK5F+ybKnjxXs+O0UAIHANkO4KOjJb4rdgH/aks/qiqa0kd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvng7MbQSeBupUPOlnUDVFDcCfsW3x39oLxZU7EDWGo=;
 b=GM9DGFfvHEw2E9ai6yEU0yspwVzBWVUzKSct2eDGIH0cUWFScAc7vzeuOZAS1COAXhhnmG1b+u1abXyUSxdzo2LibZmx8w2rIpJQRlGQHrKRC8pSqXR4LHErgLZlg7s97xu4AZ8zVcHEYGBZuQQtcvBs3tR08DQE/8byoj/pv7GZNAgpZoN0RT+F108cZ3m7ueeuj5IaG8kFaZvf9eArughLV/GlWDI8BwaTpu7rM3vvIJ8ZaCxvuuh4qYmC8utJ7qVxNSPTdPb/8w/04yAIInyUG0/h1HwqAUhKRinPyk24H0mzcIpyqpYoQ4uldIS/nv1oSPZYyYgw2pffQvLT4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by AM0PR04MB6835.eurprd04.prod.outlook.com
 (2603:10a6:208:180::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:28:40 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 08:28:40 +0000
Date: Mon, 24 Aug 2026 16:32:41 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>, devicetree@vger.kernel.org,
	Frank.Li@kernel.org, imx@lists.linux.dev, linux-can@vger.kernel.org,
	robh@kernel.org, conor+dt@kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v6 1/6] can: flexcan: use dedicated IRQ handlers for
 multi-IRQ platforms
Message-ID: <20260824083241.4spcdohbsot6x4wc@shlinux89>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-2-ciprianmarian.costea@oss.nxp.com>
 <20260713090746.D2B4B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713090746.D2B4B1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SI3PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:295::14) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|AM0PR04MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b20906-5479-4ebb-383d-08df01b9b351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|19092799006|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M2DUYXJ5FuoxsZG/IUny73Iicu5F4aIdp2hSzdYvdpxb5yzhcOXHphWPaZtX6CXDo/twy1aFzU192fGPNyNQb11aPnP8ws4Z5tVEflIkagNUzvJuVaDilvcf2ZgXGBsA5kejSa0maAjogjIvBf+ysUqdFm4RuFozCoQuZnRv4a8jBxEa8cSTxib4BxDBBGpepomJmKEVLLT19qtiXQO0ZOvLdmfPlOAU3NAR8oyIrO6JqUZfaQELC13zlmh5wNbrMo0+MxoYoXqIaSqnBo5C4c4GN/CFwTdEy4zsboelitKoy4P91TIJrqZ7p5H2mphJJKMcdVv+myS+ZqcRmfpP7J2giSw5xglZ6hyqe79GHPlKcN4PjniqPpa2ToLaR5/W0KeJkNrwvOSgMlLkTcoOf9q1OFVlpdW0HG9ONFtFZbnQPiTn49hXLcgXIcA2/1jVyV5XaCMy4hK/Ru7FgbKBLtsWL3cWUP9FYfsZXMP2kISMnHidbZzkXLfsFuCSKcUaSRYmIFZK6Bedpljf3MkagqhiWF3aHuFBiNnwCp3Yn4ddGmDL1t3xBptsu2EXc/k96sCwaGkC7vJEx30DDkxsFjFto8ezmi0C1XD5Ao3s4A8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(19092799006)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDVydFJXSFZQRFk3ZWZEbjRmWVNieDRBeG5DUEV1S0ZHS0NXMklkNFFQM0cz?=
 =?utf-8?B?UVVPYTl6RUpJRzFrM3lpV0dCVWd4MExHVlNZdXFOby9yUDJteCthRGx6KzJz?=
 =?utf-8?B?VEJSYWJxcmdrUlIwUWpaRUh5cXMxdVlaOW5ZQ09ZTnNlQlRGdjVWWlZJQTBY?=
 =?utf-8?B?NFRvUFArQnU4bTZJbzkzR3grVWhDY3J5eXNpclNORzV3TmRJeWRMck5RR3JM?=
 =?utf-8?B?VzRZekVwQnVIdVF3Kzl3L21rYjJ5K1dKTVh1Tld3ZlRWS0pIYTJxYlBDRlM3?=
 =?utf-8?B?VlcwVWpaZzFRaTVXeEp6TEJZRkEvbnpadTBjK0tFMjFqVnAvdW9VczdWa08y?=
 =?utf-8?B?VGpyaFF6SlBjMTBTWnhRVUZ6Z05ueTdrVXBrbTFydFBmUzdkSldnSUg1RklD?=
 =?utf-8?B?TU93WDRZdWpMRFRUeEJnRE03SThleEZLZWpGZUtrN0NlOUk2Q25FVEdzUGhO?=
 =?utf-8?B?YU1JaHdmZ2IyV0o3SnB5a29zbWFqMGRXMmdjYjRJd3hLNnZXeEZVWG1IZVNp?=
 =?utf-8?B?cmFiTExlWndDRmxMcWRLZTNLY2k3cVA0eThVL1lkeUpwcFc1ODY1dmtQRy9r?=
 =?utf-8?B?SHpGck50aGZvWEhwczQ4eU1jM3grRDR6a0xrNnlKTm5rMlJuZWhlRmV3Z3VE?=
 =?utf-8?B?VFU5UDVXZUhpanpLamdjUVdrR0FndlpPRmVEaUZzM244OUk1a1p3UWFqWElj?=
 =?utf-8?B?NkxPNk92OGU5S084TmVRbXMwTXpJakRCOWtYQjhZTUxqNzg3QkxiNWtDNjQx?=
 =?utf-8?B?SnVjVGw0bVl0STQ5ejkwSUNBaXlwbDBzaDF3Qm0yU2VwLzhBK2h4dnRVUFRW?=
 =?utf-8?B?RDZLZEJXVHd3ZkFhbzR2Y0t4bWZ0WmRKS25UdVZVWnNmYktySTk4UFA3SGdE?=
 =?utf-8?B?SjdmTWxJUTUyWkZjd0JCRm01N2o5bjlRSU9ydU9GMHFPb2FQS2MzQkhmUldY?=
 =?utf-8?B?eDRFTWx3V1FHMnAzbXQ2TUVXamNMUUtVZEZNcTQwRVNKNm4wckFvUEl0QmpS?=
 =?utf-8?B?QVU3MXl3aVNhWCtDY0VzemN3dGFyUUIxOHE4WUMyVVdDNHNVc1puT29tOThz?=
 =?utf-8?B?NnZKemI2WGIzUkRvWk80WDluOXlkUVVzczdmS2RrS1Z0TE5wWjFUYU1lYjI5?=
 =?utf-8?B?cTVMZlBQNzd2YVVEMWR2cUYrNTRPYVA1c3pMTUJMLzdMTGwrVTkwR3dWdlV4?=
 =?utf-8?B?bUYyMUNEUDZJN3RzOVRERkNxYnFYY0pja0hrUkI1L0twWHp2ZDVzMU9xTXdY?=
 =?utf-8?B?TVZkMGtQbU9aK1g0M3RLUXNodHRHWEFXNjZ3THlnRWVDMGczMzZSS0ZYOGxS?=
 =?utf-8?B?Q01Fam5ER3VhZzVnMEtIcnhPTFhUQUVmRDFBTlROUWhIcWNtNEhQemZHcTZX?=
 =?utf-8?B?eGNOSTZJdTlvTUpycnRhdW9zc3YyV2VrMlBQWk51R2dlSmYzbHFpc0xvR1JG?=
 =?utf-8?B?NWZwRHlUV21IR2FZam9TTytKVWI0V2tiaHh3SmJBNVFDTHJZU2lxdURpU2Vp?=
 =?utf-8?B?ekpTaWxWMnlHMy96T3IzZ3RIVnVqZS93WG9QSjFWbXcwYVZYeGJXeXNNZTFB?=
 =?utf-8?B?OUVUa3QvUE8wUVg3YVp5cjR4Z2QwSHlVc2RtQVJPMitvclNsTDdRZ0Yzd0FP?=
 =?utf-8?B?R0Z5bFZYL0Uzend1c3Vyc0NUa0I4K2FlL1ROc3UxeFhZWEROYkNjTmw2RkdT?=
 =?utf-8?B?TUFiTFhCejZPOWxQcm9lY0xLS2R6bnNsRzN3cytBOTZlQ3BBdzc2Ujk5eDlX?=
 =?utf-8?B?bHlLQVNSV0U1MXVqbFpkdFB6eEkzcVowWjFsMGFJOTlOd25STXpiV3ZmNytY?=
 =?utf-8?B?K1NvSlVyNW1pOWlISXltSmdvMWp6WGpDeVlMQUhqUUNqdjFCOFBRbnh2TFJa?=
 =?utf-8?B?Y1dTTnlsaE52bUMwVVpVU3NhTWplT0FNR3ZSNVE1N1pYNmJjalJINVQ2ZDlM?=
 =?utf-8?B?V21mNnE2Y2I3NEcwQ1FjakpFcXFRNmNsMVJwSHE2a21KakRDbEhYTTd2OW1r?=
 =?utf-8?B?MVJjZ0hkOG5SN3ZybkJ5WVZFRlhkQWs0YVZaMnZPTHBORkRhUnM4K3QxYmdx?=
 =?utf-8?B?NjFrbXE5UHZlRDNzcGtReWZBcUVaZ0NyNDR6LzZBNmw3VGJkUlI2aEpyKzBr?=
 =?utf-8?B?cFY3anh0Nlg1aFRXQ0MvMm8wTnprK1JpY0t2WGVENW15Z0Y1ZWc5d1h3UHdj?=
 =?utf-8?B?MEtzNHJDbGpMa0tKa2JVczR3VFRRYUQzNmp1a1BvL3IzMENXa0VCbnVPUVRs?=
 =?utf-8?B?Qk1samYyZmZJYmc4a3lmWlc5dGM4cDZqYUVia1lxazZJb2I5YkR0RVMrRTFm?=
 =?utf-8?B?Q2FKQ0tRWVpSWTFFYjJuVENMcGtOdlhFbVBUSGF3U1oxUlNtNUdJVDJEODQr?=
 =?utf-8?Q?MIp/5Fhdv+C06IJPfnf+uIvgUdcHomr6+v5Lc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b20906-5479-4ebb-383d-08df01b9b351
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:28:40.4346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spLwwDrZ3OCCJvcqd9qYNNMHWg9JzayNVfIeRrcysaxdkJz7qsPtaGtNhP5OF+lCUyyMhNaeOl6Vc+5JFr/gTFxviVYwcAH237sRTOT1R9kxXaIPKl7TDb1Iw9ik6vvO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6835

On Mon, Jul 13, 2026 at 09:07:46AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Splitting the IRQ handler breaks the FLEXCAN_QUIRK_BROKEN_PERR_STATE workaround on multi-IRQ platforms.
> 
> Pre-existing issues:
> - [Critical] Concurrent lockless modifications of `skb_irq_queue` by multiple IRQ handlers causes list corruption.
> - [High] Incomplete fix for duplicate frame processing on platforms with secondary mailbox IRQs.
> --
> 
> --- Patch [1]: [PATCH v6 1/6] can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms ---
> commit b6f6f5d373c333a28a06c2ed84ea386f9dc5b122
> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
>     
> On platforms with multiple IRQ lines (S32G2, MCF5441X), all lines are
> registered to the same flexcan_irq() handler. Since these are distinct IRQ
> numbers, they can be dispatched concurrently on different CPUs. Both
> instances then read the same iflag and ESR registers unconditionally,
> leading to duplicate frame processing.
> 
> Fix this by splitting the monolithic handler into focused parts:
> - flexcan_do_mb(): processes mailbox events
> - flexcan_do_state(): processes device state change events
> - flexcan_do_berr(): processes bus error events
>     
> Introduce dedicated IRQ handlers for multi-IRQ platforms:
> - flexcan_irq_mb(): mailbox-only, used for mb-0, mb-1 IRQ lines
> - flexcan_irq_boff(): state-change-only, used for boff/state IRQ line
> - flexcan_irq_berr(): bus-error-only, used for berr IRQ line
>     
> The combined flexcan_irq() handler is preserved for single-IRQ
> platforms with no functional change.
> 
> Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
> 
> > diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> > index f5d22c61503fa..f73ff442d5304 100644
> > --- a/drivers/net/can/flexcan/flexcan-core.c
> > +++ b/drivers/net/can/flexcan/flexcan-core.c
> > @@ -1188,6 +1218,65 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
> >  		}
> >  	}
> >  
> > +	return handled;
> > +}
> > +
> > +/* Combined IRQ handler for single-IRQ platforms */
> > +static irqreturn_t flexcan_irq(int irq, void *dev_id)
> > +{
> > +	struct net_device *dev = dev_id;
> > +	struct flexcan_priv *priv = netdev_priv(dev);
> > +	irqreturn_t handled;
> > +
> > +	handled = flexcan_do_mb(dev);
> > +	handled |= flexcan_do_state(dev);
> > +	handled |= flexcan_do_berr(dev);
> > +
> > +	if (handled)
> > +		can_rx_offload_irq_finish(&priv->offload);
> > +
> > +	return handled;
> > +}
> > +
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
> Does isolating mailbox handling into flexcan_irq_mb() break the
> FLEXCAN_QUIRK_BROKEN_PERR_STATE workaround?
> 
> On multi-IRQ platforms with this quirk (such as MCF5441X and S32G2), the
> hardware fails to trigger a state change interrupt, meaning flexcan_irq_boff()
> won't fire. The baseline driver worked around this by polling the state via
> flexcan_do_state() during every mailbox interrupt in the monolithic handler.
> 
> Since flexcan_irq_mb() completely bypasses flexcan_do_state(), could this cause
> the driver to silently miss CAN error state transitions (e.g., Error Passive)
> when the error rate increases?

AI is correct, need to fix this in next version.

> 
> > +
> > +	if (handled)
> > +		can_rx_offload_irq_finish(&priv->offload);
> > +
> > +	return handled;
> > +}
> > +
> > +/* Bus error IRQ handler for multi-IRQ platforms */
> > +static irqreturn_t flexcan_irq_berr(int irq, void *dev_id)
> > +{
> > +	struct net_device *dev = dev_id;
> > +	struct flexcan_priv *priv = netdev_priv(dev);
> > +	irqreturn_t handled;
> > +
> > +	handled = flexcan_do_berr(dev);
> 
> [Severity: Critical]
> This is a pre-existing issue, but does having dedicated IRQ handlers
> running concurrently on different CPUs cause a race condition in the rx offload
> framework?
> 
> If flexcan_irq_mb() and flexcan_irq_berr() fire simultaneously, both will
> eventually call into the CAN rx offload framework (e.g., via
> can_rx_offload_queue_timestamp()):
> 
> drivers/net/can/dev/rx-offload.c:can_rx_offload_queue_timestamp() {
>     ...
>     __skb_queue_add_sort(&offload->skb_irq_queue, skb,
>                          can_rx_offload_compare);
>     ...
> }
> 
> Since __skb_queue_add_sort() locklessly modifies skb_irq_queue, could
> concurrent execution of these handlers corrupt the sk_buff linked lists?

Yes, should be handled in another patch.

> 
> > +
> > +	if (handled)
> > +		can_rx_offload_irq_finish(&priv->offload);
> > +
> > +	return handled;
> > +}
> > +
> > +/* Device state change IRQ handler for multi-IRQ platforms */
> > +static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
> > +{
> 
> [ ... ]
> 
> > @@ -1761,25 +1850,30 @@ static int flexcan_open(struct net_device *dev)
> >  
> >  	can_rx_offload_enable(&priv->offload);
> >  
> > -	err = request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
> > +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
> > +		err = request_irq(dev->irq, flexcan_irq_mb,
> > +				  IRQF_SHARED, dev->name, dev);
> > +	else
> > +		err = request_irq(dev->irq, flexcan_irq,
> > +				  IRQF_SHARED, dev->name, dev);
> 
> [ ... ]
> 
> >  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
> >  		err = request_irq(priv->irq_secondary_mb,
> > -				  flexcan_irq, IRQF_SHARED, dev->name, dev);
> > +				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does registering the same
> flexcan_irq_mb() handler for both primary and secondary MB IRQ lines leave the
> duplicate frame processing bug unfixed on platforms with secondary mailboxes?
> 
> If both IRQ lines fire concurrently on S32G2, flexcan_irq_mb() is dispatched to
> both CPUs. Since flexcan_do_mb() doesn't check which IRQ line triggered it,
> won't both CPUs unconditionally process all mailboxes, resulting in every
> frame being processed twice?

I think this is fixed by PATCH3.

Regards
Haibo Chen
> 
> >  		if (err)
> >  			goto out_free_irq_err;
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com?part=1
