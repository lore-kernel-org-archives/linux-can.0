Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013067.outbound.protection.outlook.com [40.107.159.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904803CB2D4;
	Tue,  1 Sep 2026 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273864; cv=fail; b=fPIT+0Z4RDqFsJF+k2hkYxEZPLZpFjzlMIaEXhX9FDUOkH1KJkgCdLj20Sv+2GUWx7yADu2d9TdFFmpOIUexSDiTSk3z75ENuJI/+hp3xikDw883RLj2r1W4L8z0cYuw0zir49jl8XzZKYOl+7MeJYhOfEjSdYIyIX0O/otVFhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273864; c=relaxed/simple;
	bh=YTwko38JfkgKmPxX1rtlIdsARqqNBupiXQfqKp+OjS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JhUe6sRcmIZTxbbackjz61SsrselaHuE+r6bKd2L7pw3c8ofU/AD2KPGDjpusbz/i1RkO2qYLMrXCf4pfR0Jd2oN0SFE5l/RH70dRUSI6GnvjBrqWqzc5GKUiF/gicizKqh7KpgRr6/bmtlUwqEv3X0zEOvb9wjqpvG/aqS2to8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rt9RBxbR; arc=fail smtp.client-ip=40.107.159.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rt9RBxbR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWi2HMS8oBVPdRLS7SePAT0fR6Ki1l1CVorHrjek2tr5XgTJ02//94Uz1jUVtQUw2M+kDW8MsaSb/mcyCg159v/PNVhT9CJK0BsEEfpYFRN2EDfOD8WxbqtYkTxr8NoTYTQ05JScsFkEEM2cb2aBJmZrd3b2ienUyap0jc7t5dpQYzlqe3f/snysxqboM7fsHB7syTstbWeihd6fS2XkIhF7RAvUdqQRprZys4M5GRHQNyrXw76tXdSfYMDIBfC1i7gKuIuTjn9yVfi2FRWvIWISJ5rhHiyNz9ZOZFUvhXwKJ2cdP4Ad+pCTbzP+fvzUq3B0RlO4jXDni2vNJRpj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ycEDgQKrZCHYIoWL2FsHFmCGQx5RSzH8VV9yNpwaKs=;
 b=D51dwl0FjBNmsQ7tyH/wqqCjXNVz17EKHOZVi1wBR9DLKJ85xbHdv8RcZCaCS3zateTVO7CkDUib74zK9Nd0ikXUPLrco/VR5XQruLLvo657N5y0yo76BNMsaMCkQgra2WqWP/w3c8yuKqSd7JMNuUCjU+BYjG1RvWuK1fWrxHxfrJdIxLENUm8QokGHNGHF4UGn+NZVY/oQkv4DYzIbGreN6hfxAPgFxK8vJ/DTFZoj9nmV2mjj8Tvc9ML6tsK8Tw5/iCd+Fe4B+TeInF25B6CP5eRwbsRI6zSMS79LRb+1wm2iPI1208VButxuheZEwt9VBqtyHwYosmkz0IE+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ycEDgQKrZCHYIoWL2FsHFmCGQx5RSzH8VV9yNpwaKs=;
 b=rt9RBxbRMarC2QqC/a0IhxY2LVoCT2ajakuRva/XpTGRPcwdSAwdNP2XsU1tMumAWwXXkdSxVnHdZl/yIvgBGSUVMI9XYEFbLncMNj/bHKWqsXUZsf25C1cIZFN+6Scys1iSeaH5QPtpewT/NZu4sPr4pL9EwNXLfKwAeU94c2Tsm4yVj29ZvNHn9O6fcof4dDvD8L92XVq29Nzvh8OnzV+RFB4hvjXoRG4iKZPOwNeNStWSjqJxqi4q9UjTbt/RRk5KDAhc1K66rwmWd+vB8qnbyspFcBxr5TtNZeYM1Ayhn1q8p4JoEeVtjItgwrG5uHxNIghn3cgKMVtMtKNDKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by GV1PR04MB10942.eurprd04.prod.outlook.com (2603:10a6:150:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:44:17 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 14:44:17 +0000
Message-ID: <cc806640-bb65-486e-a574-1d6e615e6df8@oss.nxp.com>
Date: Tue, 1 Sep 2026 17:44:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] can: flexcan: use dedicated IRQ handlers for
 multi-IRQ platforms
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>, imx@lists.linux.dev,
 Frank.Li@kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, s32@nxp.com,
 imx@lists.linux.dev
References: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
 <20260831143449.12828-2-ciprianmarian.costea@oss.nxp.com>
 <20260831180131.B55E61F00ACA@smtp.kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260831180131.B55E61F00ACA@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::33) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|GV1PR04MB10942:EE_
X-MS-Office365-Filtering-Correlation-Id: d1fb735a-0de0-43d0-6482-08df08378007
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|1800799024|7416014|366016|6133799003|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uCDc68qwayAh8Erktk0ewQuw8gJmVoD/YzBYrQO4zi6OZz6CkbZCs8omKZBTn/F7CdmClLraTawdz0b4RJHvouFNMh0VrVScPvqyVQMmBONfUTSYN7TfVvgWlkAoprXT0JdVwLidZw//ePcZtEzwp5LI8b1v+Wdq83teVITXIJJ+5yCJJ8Akmh1cVKtQ/mSp3rVVPOtEC9vEf2zSeqzfrpTLlyR5FBZnoTXPGbAlgbiIHRX8a8vm5vydA4F3TCDKjJOmFKLQyEtr+1MQ3qUBlkGopPd+TX5dxBCDKWJ3OEscXwk/+7xKlVIDXm1ltbg5twWkGgaoAgBUs61hJft+3c1WIWXrUS5wCerP4y6/cmulORa9jD3e9Gbo+X3fxDLarG0Uamimom1kcDNOy8ghdmCV3TS2SBwqzOFuTSZjQAlA/14NXKHrYSpHVbGowdghvUNuOwRAfsJ4o9I2AWm/gLf682XcwXdJWm0gIkKDi6+oRjJp/oOn3nqlGF3eIrFkMuCTrvhrI3rgOkX5kQfJVjzcUQOe4w88jsV4J/rktWKCjkqUSXVjtq+ifMAhk9wQNQIoVsjOfDeYMsuV6Fj3g6tvbUi6dIVSpsgqcHnwtDMqK+Wr25thRc5XpNj9bQ4/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(1800799024)(7416014)(366016)(6133799003)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk9GeGVmd1Vub0d5cUo2bjUzS3JrM3JaNmpWQ1JmL1JSdmhOMTB1L0wvUEFt?=
 =?utf-8?B?MWpLaHR1SFhFdFA3N2Z1dlhWQnZ1MXR2dGU3cmZzV2pwU0Q5UUdUeitldTJS?=
 =?utf-8?B?OVYvM0JxcWt0aGxSem1oUWFMRUNiSFNxWDAzZFJEQ0dPN2tOSXA3ek1ETHU1?=
 =?utf-8?B?TU9yby9sL2RLdC96Qlg5L1g3TEdSOGdtSXJsaGY4WkQwanpwS2EzNEJWYXM0?=
 =?utf-8?B?VU5rTVlVWVRpeWYzUnE1NDFiS1J0UGFiendpOGtxbjY0UVNNS0lqVkhHelRh?=
 =?utf-8?B?VU9TUStHSTVkNWZlcWZGcEJmc1V6dXQ3dys1bG12WHRUUUlUaVNGNHpKRlRF?=
 =?utf-8?B?S3ZPMVQrTmVqNDdWeGQ2NnVqMlpwd1dyQlEyRHN6QkdnTWRrYnB5WG91OEFn?=
 =?utf-8?B?VDJTQjhBSmlwVDFRYlZXUVVvU1FxU2UxMzkxaW54WG91bndlTXUxZnNPaWdR?=
 =?utf-8?B?MHNqcmFhaWdxeUlxakFzWXZDTmhoTk9VQ1pMNEFRVUlKRE05bnM3Y2ZSN1pG?=
 =?utf-8?B?anpLUWpYNnQzb2VZT2xEbVJPbEdYOUtRaERDcnVHcjhHWUVrYjNTNCt6M0Fn?=
 =?utf-8?B?Si9SSVd2elFRRnZKWTB1aE9JdVhnVUkzaitqWFVMV3BOZ29qcnpsVWE3bVRQ?=
 =?utf-8?B?b0V4ZVRMY280bWlwNmFjMDlJUzVUQVRpOVNPbWpzakpuU09reWJ4aERkeStJ?=
 =?utf-8?B?SGN6U3VPbzFsRzZubDVtanN0RjJtenUzdUFOeUNaSm1RMmZtcE0vbEJ2WnNJ?=
 =?utf-8?B?K1YzRHBFVlRmWm9WcDZScVVNN1VkQTNYbSt0aklsN0lWeXFjTC83SGg4eXpV?=
 =?utf-8?B?ckpvYnZ5bVBvYmV3Y2MvMjIxdDF2SjB5SC9FZFZnT0VoMjVDWkN4bWNuR3pM?=
 =?utf-8?B?RzFGV0tXalV1Yk1HUzJhZDdSTlJZM2psSE9pUGJCZ1FtTy9XNFZMUktjN05I?=
 =?utf-8?B?ektqd21ZcURscUszc3FRUm9mQjJVZ2JDclo0MlZhaEFrdHRXSHZocStsd3E3?=
 =?utf-8?B?S1loVTZNZERtRjJyRUplbGRKdnJTSDZmVy9ZSlJST3oxejhvNkhzMVhPdmtH?=
 =?utf-8?B?SkNvb0dYSndWWW1NbDFla29EM1pEZFZBUUdSbGxRVy9qUjFpVWNGSGdFTkNn?=
 =?utf-8?B?Qjd3R2IzT2NKRG5PQUhiVkJyUUJSWDV4SlZTMWhkR1plZThDTnZ1clJMOGpS?=
 =?utf-8?B?b0VKOVE1NFZVaGIyZDJIOWc0UWFFK3haSFR0b05WYTFaN3dGTWlhWWdORDdC?=
 =?utf-8?B?eERvMW0yUjhycWcreXBjTEU0TjdOeGNSS0g2VmFFVlAweEFnMktYSkljcWlN?=
 =?utf-8?B?SStMcXdOamE3TU81cm9tRHlKdGtXK290WmI0ZlZDMHpFSDRpMUZvS3hUck04?=
 =?utf-8?B?MmRxSlpKY1N6ZFNSOXlrTERNOHIzZHVoc01VdnRid1dUYzNiL1pKU2dXeDhX?=
 =?utf-8?B?SmFKWVJLV0s4NUptYmlhMTMrTC80eTl6RCswK0FhQmdHY1REVnZkb01iUnFz?=
 =?utf-8?B?dW1lL21md3VxMGFUaHZ2RWREN013aE9UTDNGcFlBQzBkc285RVJJMFhVOWc5?=
 =?utf-8?B?Tlh3bHBmQ2pUUDRxaTE1MlhySlp3SHN5MFBxN2x2VDN2UVdMUkwvOVdSekVP?=
 =?utf-8?B?b3BFd2U2WFFXc2dKb21Lb1kzWW5LbUcyb2NxTzhwbGhBbTVueEtRelN3TnQz?=
 =?utf-8?B?ZjhnMkJMM2RCS010R3U1Y0sybEdtTXpVdUMzNjlZSVB0eWg3Wk1hejdHMmJq?=
 =?utf-8?B?UEh6NFF1aUNpcnJtY3ZKR1I2bFhmVlI4MzZrREE0QUxMbE1JN0ZTQzViVzRs?=
 =?utf-8?B?bjJVSzFjOHFheDloTWF2MGVLbFkxUkdKc3M1dkVzb1kySkp4SUgvanFPMFNi?=
 =?utf-8?B?clpkNmgyUXhHTFAveG1Vc1ZNSzd4Y1RrOVIzclFFR3ZObGluNVlJMktiZHll?=
 =?utf-8?B?L3hQbHV6YnlFbHN4NFJOS2tzRW9XR0E1Y2hVRVNtdWxYNjZRRWlxNndyZFdo?=
 =?utf-8?B?TEJmUXhhMk1YWUZVNHZXdm9OQ2pBcGdPcDgrazlRU1BUeDNsZm9QekM5cnhk?=
 =?utf-8?B?K3ZpOUNMNUc4Y0pCbGNxajV0cE11S0h2YVZXS0hQaXdVdDRMK0hiZU1qRU1H?=
 =?utf-8?B?b014dmFIcTg1OEdLYk1uMEt6WW8vdFQ1UUl2aE4zNDlDcllsUENSaEI3V0dt?=
 =?utf-8?B?emp1WjBwWWEyYkZFTExYbmNKVmlnQnBRRTJlZmJFcXE4UGlBVWxBejIrbmh5?=
 =?utf-8?B?bWl5aGpaMEpsL2NXditGL3ovY3c3TUdvS25WTUNmcVJxaVBaMTJ4eTFoQ0dR?=
 =?utf-8?B?OGswVHhpOWtKaE5oRU9QblZCckI1UjFKcEl2eElNaERneUdMOWl2c2RIdjlQ?=
 =?utf-8?Q?G4nyBQYj5ZGN6OG0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fb735a-0de0-43d0-6482-08df08378007
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:44:17.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOIP6nyCrlDoVYkd2+vguWU7FdnlYFn2KCwt6YAv/zSl6QnZZL2vBqBjeqSkSLL5AeV5tdEIVwJeyOPcDkh0rv9GUi+wm9rWXPPo7M7MrRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10942

On 8/31/2026 9:01 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The split IRQ handlers fail to resolve multi-IRQ concurrency for device state processing, leading to lockless list corruption.
> --
> 
> commit f3f261bafd25e44254ad99cda953074bc68ed987
> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
> 
> This commit splits the monolithic flexcan_irq handler into dedicated
> functions for mailbox, device state, and bus error processing. The split
> handlers are then registered to specific multi-IRQ lines depending on the
> platform quirks.
> 
>> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
>> index f5d22c61503fa..2e9df2d14b341 100644
>> --- a/drivers/net/can/flexcan/flexcan-core.c
>> +++ b/drivers/net/can/flexcan/flexcan-core.c
> [ ... ]
>> +/* Process device state change events */
>> +static irqreturn_t flexcan_do_state(struct net_device *dev)
>> +{
> [ ... ]
>> +	/* state change interrupt or broken error state quirk fix is enabled */
>> +	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
>> +	    (priv->devtype_data.quirks &
>> +	    (FLEXCAN_QUIRK_BROKEN_WERR_STATE | FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
>> +		flexcan_irq_state(dev, reg_esr);
> 
> [Severity: High]
> This is a pre-existing issue, but does calling flexcan_irq_state()
> concurrently corrupt the lockless SKB queue?
> 
> If the boff and err handlers execute flexcan_do_state() concurrently,
> they will both allocate error SKBs and insert them into
> offload->skb_irq_queue using the lockless __skb_queue_add_sort().
> 
> Can this concurrent insertion corrupt the list pointers (skb->next and
> skb->prev), potentially causing infinite loops or use-after-free
> conditions?
> 
> [ ... ]
>> +/* Bus error IRQ handler for multi-IRQ platforms */
>> +static irqreturn_t flexcan_irq_berr(int irq, void *dev_id)
>> +{
>> +	struct net_device *dev = dev_id;
>> +	struct flexcan_priv *priv = netdev_priv(dev);
>> +	irqreturn_t handled;
>> +
>> +	handled = flexcan_do_berr(dev);
>> +
>> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_BROKEN_PERR_STATE)
>> +		handled |= flexcan_do_state(dev);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but could this multi-IRQ
> setup lead to concurrent device state mutations?
> 
> On platforms like s32g2 and mcf5441x with FLEXCAN_QUIRK_NR_IRQ_3 and
> FLEXCAN_QUIRK_BROKEN_PERR_STATE, a hardware bus error or state change
> can trigger both the boff and berr interrupts on distinct IRQ lines.
> 
> Since flexcan_irq_berr() and flexcan_irq_boff() execute on different
> CPUs, couldn't they both call flexcan_do_state(dev) at the same time?
> 

multi-IRQ concurrency findings in this series should be covered by the 
following patchset [1]

[1] 
https://lore.kernel.org/all/20260901114848.500591-1-ciprianmarian.costea@oss.nxp.com/T/#t

Regards,
Ciprian

