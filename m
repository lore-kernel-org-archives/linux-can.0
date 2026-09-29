Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B4F3C0626;
	Tue, 29 Sep 2026 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670098; cv=fail; b=EfFlO47bJv0AONNr7CQ4YhKbVLddKdHLlSijWD9WSFUJNSXA7IBZGBdoCxCyFkqOc/m3ZplDJzzgTM7vMb8tHfKwmZdDI4ZcXLe7X79uZgDtaXZQIF/yONrVYkTPHVDfcKQNyOGY/G27gDkF20jhteaTIrv9zfSoWZm6ecJv+/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670098; c=relaxed/simple;
	bh=ac+jUFEbR/mXp02Zpq8kngJgCneknD972S1WO6PVHkU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KwnpoBT1X1KVWEYsflxokK8g3adsF7fpHXvykZXG9JFQmH8tW29sR0nVtjPpZ7J4vVAq2PgOlbwAJ3ydfS/dep61I1QrtU2KsXDBNP6Xlc/oRCvUNszwA/TP+886UMVGEF455p64Z9m13SqMNf9cA8GoTANXrDQBpw6khvMfAfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=inY1DGds; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="inY1DGds"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4ARimgWCMWzKu2QP2Hge6kzm7z2c+JKD/xcDFIKgKBKb+gI68n2/kO+kfsnYjPuCbbrJbGrwczKZS4NO7YO7nOlaHvSToY9dZfRH5TQ3kS54bjOKaYoGh1zAKeG8DAIgk3lQ7xXdM0MclbsxS3GnVOWIKzYpAzXw1nHyLso0p+UJMasybecFF9gt9C6FHp2dbvoj6/UwsQZs+ZCfG8VVKKwnURfsfLWXhZblGajwwwLlZmMdLxxLlSox1GgJBK+YpPxvVmgmfS63rYFIFFtb8O9rZtCZKudL5on2FJr8YEToanpKdz2xVD7sjHugQZdmSGf79DmO+IZwxzktXdNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txdTA7em48h6GOrh2iixmpFaXq5fgiNRDJsqCgtdz/Q=;
 b=mBPjkgR41W31URhgLV58IR5LLpjQwhyQDj5BmU55Y5X+ReFWC8icA/rtgva+9j3Ip/tcNvqUwOThQNofq7fvSLi9/xgfOc4DtQRgrZL0gTVQWbcAYOobmgTfpEXo5yR6R8C3vxvE6lmHuNkc3WqTeBC3gQq8A6axIPSZyDmyYmnBjLw57yojIVyH7a1BWJIEoedM3zn5nJRKrFdm9SSxDBsX3X+vNIB9jdHlRi6sBtRmhAMazcg8Gz9P7fG2kNKRKuuanJcPDcpvzsd9zW5vcaygQpjyVE3YB/SxHfqkFY637Z/2HznSK+80aExt4YRhL4FXE6i4NbXJDc/ulA5fTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txdTA7em48h6GOrh2iixmpFaXq5fgiNRDJsqCgtdz/Q=;
 b=inY1DGds5gjBhp1kUhlfQh7GERz541V02XKx/g5YqeJpG3QwsyFFtiNxsjMAjobirCuGGKp2dEzy3vMNy2L4wN5v5rWqcFcMed4n6z2M91GHyDL6HTdksy6TCpBz5bdtsc1DdTljbZfJYKIWGG4IZtj1fSf8/Uox6GBkZ3mQM/77cHixkdeHRYEB57rZ4PkZ/j8u7k8WBrUUQP9CE+NX6G+FFQr5xhpjIRIOBpzHf+8wHozTD4V28cEm5FIqVBn/rYgZhy2gd9XdWjwMyElGaqWcZFb6AKr6IAQYKCVP54Nmh1LNMfgK5ph1oVfLZ+dZBivH075NMjQvZZN9GcZnog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by MRWPR04MB12120.eurprd04.prod.outlook.com (2603:10a6:501:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 08:21:25 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 08:21:25 +0000
Message-ID: <dd896eed-5bdc-48b8-ab6c-4a65fba14a88@oss.nxp.com>
Date: Tue, 29 Sep 2026 11:21:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] can: rx-offload: add a per-IRQ receive context
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Max Staudt <max@enpas.org>, Markus Schneider-Pargmann <msp@baylibre.com>,
 Heiko Stuebner <heiko@sntech.de>, Manivannan Sadhasivam <mani@kernel.org>,
 Thomas Kopp <thomas.kopp@microchip.com>, Ming Yu <tmyu0@nuvoton.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>,
 imx@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20260925144558.2909639-1-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260925144558.2909639-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::17) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|MRWPR04MB12120:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c94a8f-dbf7-465c-9236-08df1e02a6f3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|19092799006|1800799024|18002099003|22082099003|921020|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	7xOmWgltwokYLGdfaD4CeVEVNtHIp0/4dTnNFylQQz4m+udi6AQx0m5yFY+982ZRFrcxFccKe9W08rVey2gQVrwMzhxlBeRf1y7izeW6zbz95Er+hqeNAsDSD6REtECiTcB8tM+QvqxAiY2umIjytBvCANDeCoBmlHe43ky8NBMfxGEwA+mOjCAg53Cew2QrxDGY7O0tkE3KwDOS4wjP909fIt1N1C0SO4fTo5bbxcyR+iuamUc2Y3MGvv5wD0vXprzShgZcFYSI9QRG06nDRWs0ERJVjBqrXcK/KhgLHNaFbDRxaW1kVtMDdTAr8ZG63AIScCnM/s3haik5KqFaocoVOafPeYIvCYxT/SwaILRG/lrFRhOLJZDsNvZx4QasPl1kHPomhkMDj4E65p6KXED6yjCVUSEX+DMeHxbJ+/SHyaNS4ExvKTrxhBktxvzYVzjWHxfF3kmRUVItRh0+FWixcqEAKc8Yv+ViaI0WCeQy9t09WLHnUSu0cwl0rT5gr+2tM+7OVzyH17n2Uq/To/YvymJUH9OlZgT9nvN01aZJEIKgJXHOqhZVSaH+WzB6yUjd84ge0NT9C5G02/y3sTa4gRo0JNctygImKmbbAd+/QQ9J+OKNQx1IgV+28+9g2AiQDni3HWfr9wH1hXxWXgif6KsFwKOx0HflaRgcmw9q1wiXez8wwRFLVpJuvEq3pr5OkY7RTR5hbLb5kbtfSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(19092799006)(1800799024)(18002099003)(22082099003)(921020)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3FsN01xMEJ2dmtETTlDUHJXOVk2THdHbHVibUF0OUdBWVlFWndiY2JzYXlh?=
 =?utf-8?B?RFdaZUtLZUJXcVNIMll2M3JvbWVhRDFtSmxRQXQrY0dFRzFQZnB6Um1vV1dk?=
 =?utf-8?B?MkcraStoRDRxVWhxV042MGFjQ1ZER3ZnTW9ERmpDNkdVZkg1YTNOY3FjYmtz?=
 =?utf-8?B?OW9ELzhlNmdOTG5QQ1VhYnhDSUlQRFVJNmxMQmZnK1hqb29UZSt1QlBJSENE?=
 =?utf-8?B?NDZkbFI3VkNqWSt1OXI2b2sxb0pCdlpBcDRtdlFXcjFYWlRodFlWMGlKZUda?=
 =?utf-8?B?M3pBVGJPWGxYbTlFc3I3OGRGR3p3Y216dmlQd25majkvRHF4SXFBNFhQM0Jo?=
 =?utf-8?B?RWVYcE91RWZrTXVlRXRGVVZGbTlZeFlHMlBaRUZEZ0RGeWZDcEt1L3dnak42?=
 =?utf-8?B?N2tTWWoxdkh4VUJWUHZkVXR2RHZrSjFQZ0F6K21BMy9vajBUSy9DWmFKTmV2?=
 =?utf-8?B?TjMrSENCazIzVTI4OGhrWVplcW5FL2pOcTF4TjhQVTZqU3pJVElIeXc5d2pT?=
 =?utf-8?B?TjhXRmw2bHI4QldNOVFjTDd1amlxUzFuSlkya0JQcWZBRHhxZkp4VjlERE5P?=
 =?utf-8?B?NDlQaitOTUFQeFdoaEh2R2M5ZVRwcDhza2ZVVW11NXFld0NCM1FQd09qbXda?=
 =?utf-8?B?eUZnKzc5RFdMT2cyb3h2Z0xRMHFPNDFvWGxEU3J3OHNzbDI0SXV4VG43dXZH?=
 =?utf-8?B?ZmtGdDVrdmo2YXpHWlM2SjBZWTEyNFVxcjZTMGg0VlpXY3RsdHpNb0dIKzNH?=
 =?utf-8?B?OWpIbk9INTMrWXpFUkRCa0prY0haV2lmbnZ5amRXendLQitJQWRoYnM3MWt2?=
 =?utf-8?B?K0FuNjJxamFPSmh1K3NnQitPQ1NYTS9FK01ZNWRHbU5GblhheE04dmdISTdJ?=
 =?utf-8?B?dEt3ckUzUVdEay8wY3BsYVViRTdiTzhpaDJIc01oaEw3MEswOXVFN1ZZb2tu?=
 =?utf-8?B?RGEzSlA2K1ZRNEoybjlZOTU1a3I1OWNuWlNHbGpXTHo5SnlDeDhHWDg3Ti9V?=
 =?utf-8?B?RjlwNFlVeHFmbGo2VkZpaU04akdkdlpXNUhFZGlMSnMyOExSc0MvTmRUbER6?=
 =?utf-8?B?ZmxNdkRGT0V4RDlNbThDekV5cW9MTmlPa3BUSDdlbWp5eHpGVTRzYVo3T3FE?=
 =?utf-8?B?Um5QbHA0cUFnL3RveVNCcDhjd0tZeUtORzVzc1c0b1BwMStVSE84NU1aSnJN?=
 =?utf-8?B?c0V3T3VETTBDSW1VeXl4Rjg0MUphZGNvRkc0eEpVMFgyUEhQc2t6WlBNakUv?=
 =?utf-8?B?eGp1SDRpR25NdU1HUWZIVzh6SnMvWWdMaTdMWitvRzlXVVlSeHFVYnZ4STBn?=
 =?utf-8?B?RGNXNU1kbmFKSU9JdmN3SUZ4YVNoVnZUWmN2eFNhckwxeGhPU2pkbnQzcWlw?=
 =?utf-8?B?c3Z1a25LeE9idG9EWjRPZnN2T3FtS0Y5YWZpMDFvYjJiU2xSWDNaenlnL2Rz?=
 =?utf-8?B?TzVNOEttdVV6NmdSWXlWZ1NSWXpVbkUyMWF6NmNrcm1KdnNuK3B4R0JzUTQz?=
 =?utf-8?B?VW81QnVZNXFaRmVsWlNUMzluajVVTzVDT0wyYUlaMXo0V0g3U2lwVC9zQTlH?=
 =?utf-8?B?S3Nka2FwcUhBN3UvN1V2dlM3M0czNUc5bFhFVTdnampyajVVaUI2SjBmTmFT?=
 =?utf-8?B?N1UvdkZjSWRCNnNrVXlaeG5oQWhkWWxWZVFydE1Pc3FiUEE0N3BvWjNmRnc0?=
 =?utf-8?B?YUdVSGh3SUxWNXl4SWExVyt3UGJsRkJZNi9aVm51cXk3em5qeGx6b0JBN0RO?=
 =?utf-8?B?UlVZNnJWR0JCWUpmclN5R1kveEREaGtHVklNTTYwalc5REZ1OGl6d2JCa2JB?=
 =?utf-8?B?WERNNVNWMUxqU0kwd2pOYWRxOUloQVZNbEhzb05iM1J4QmFoUUJYMUh3ZGVa?=
 =?utf-8?B?VUlQTzZFelNIS0xJc0FtOFFsUVJGbkxCWXhOdjY0aElsdjZVajRCeDBwMkEz?=
 =?utf-8?B?ZTBzMDFVM1I2anNWZ0Vta2x0U0laSGY0cDV3M1RIbXVmdUdQV1BmNi83dFZ3?=
 =?utf-8?B?NXJ6aEMrOW8ySHpZcnJDLzVpSnpSUjg0Z1ZVUUJJQnFDMVRkdVNBQm00SnIr?=
 =?utf-8?B?TCtyU0dOZVcrNXpNOHpTK3E2ZWRzU1FqSXZWWlVuMUFhSW5GSWRaMjhpbDZs?=
 =?utf-8?B?OU5ibkhqb3EwVDBOR2pldVp0TmpkbzFRRU9lZ0VneDVXaFdhNFdQMmZQRG54?=
 =?utf-8?B?cDBPbHBNM01HT010OE8vM05vY1pPUTZCZ3VmYk51WC9aUVNKRlRTRUhvaFRI?=
 =?utf-8?B?QzRqdzF6Y2xJV0R6YVRCVHhyRWRXd2N6ZitOY1MxRXZoMXFWdkVRV2xhOTlv?=
 =?utf-8?B?NjM3WmVMOVl4WHgranR0Nlk2NWtqUGxSdnFxbjJhblJkMEFzOVNlYTFkemJM?=
 =?utf-8?Q?2XuVqkANvj8A5dqM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c94a8f-dbf7-465c-9236-08df1e02a6f3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 08:21:25.2200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juxPTrqEtlZZl5KIFWlm+9fxq2a/aRSpeXj0LY6wubpRRxp/zAQE4HlpHUwCaMDGGt3EZPH7ionX4p/61NGZKgAADqwNsoKlNUfI6gdG1Tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12120

On 9/25/2026 5:45 PM, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> The rx-offload IRQ handler fills skb_irq_queue without a lock and the
> finish helpers splice it into skb_queue under skb_queue.lock. This only
> works with a single producer. flexcan requests the same handler on every
> IRQ line: the mailbox line, the bus off and error lines
> (FLEXCAN_QUIRK_NR_IRQ_3) and a second mailbox line
> (FLEXCAN_QUIRK_SECONDARY_MB_IRQ). On NXP S32G2 all four are used, so the
> handlers can run at the same time on different CPUs and corrupt the queue.
> 
> As Marc suggested, each IRQ line now gets its own receive context, similar
> to NAPI. struct can_rx_offload_irq holds skb_irq_queue, skb_queue_len_max
> and the mailbox range, skb_queue and napi stay in struct can_rx_offload.
> With a single context the finish helpers still use
> skb_queue_splice_tail_init(), with more than one the skbs are sorted into
> skb_queue.
> 
> Patch 1 is an at91_can fix, independent of the rest. Patch 2 adds the
> per-IRQ context and converts all rx-offload users. Patch 3 gives each
> flexcan IRQ line its own context.
> 
> All lines still read the whole mailbox range, so two of them can read the
> same mailbox. This series does not change that, the range split is part
> of the flexcan multi-IRQ patches along with the S32N79 FlexCAN support.
> 
> Testing on S32G2 is in progress, I will follow up in this thread.
> 

Finished testing on the S32G274A-RDB2 board between can0 and can1 on the
same bus, CAN FD + classic CAN, with the IRQ lines pinned to different
CPUs. The rx-offload queue works fine with the series applied.

As mentioned in patch 3, the handlers still process all mailboxes and
the ESR on every line. With the lines on different CPUs, a frame can
rarely be received twice and a state change can be reported twice. This
is a pre-existing issue and will be fixed in a follow-up flexcan series
that splits the handling per IRQ line, along with the S32N79-RDB FlexCAN
support [1] (needs a new version once the current rx-offload patchset
gets accepted).

[1] 
https://lore.kernel.org/all/20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com/

> Changes since v5:
> 
> - Replaced the per-CPU skb_irq_queue, which does not work in preemptible
>    context, with a per-IRQ receive context, as suggested by Marc Kleine-Budde.
> - Added patch 3 with the flexcan conversion. The bus off and error lines get
>    their own context too, not only the mailbox lines.
> - Moved the at91_can fix to its own patch.
> - Dropped the gs_usb can_rx_offload_add_manual() return value check, the
>    NULL pointer dereference it guarded against went away with the per-CPU
>    allocation.
> - Dropped Haibo's Reviewed-by from the rx-offload patch, since it was
>    rewritten.
> - Added Assisted-by tags.
> 
> Changes since v4:
> - rx-offload: expand the comment above the for_each_possible_cpu() loop
>    in can_rx_offload_threaded_irq_finish() to add the single-producer
>    assumption (IRQ requested with IRQF_ONESHOT / handler non-reentrant).
>    Suggested by Haibo Chen.
> - rx-offload: add Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> 
> Changes since v3:
> 
> - In gs_usb driver, check the can_rx_offload_add_manual() return value,
>    the same NULL-deref the per-CPU change exposes.
> 
> Changes since v2:
> 
> - at91_can: also add can_rx_offload_del() on the register_candev() error
>    path and check the can_rx_offload_add_timestamp() return value.
> 
> Changes since v1:
> 
> - The enqueue helpers used this_cpu_ptr() without disabling preemption.
>    All four enqueue helpers now use get_cpu_ptr()/put_cpu_ptr().
> - Guard can_rx_offload_del() against skb_irq_queue == NULL.
> - Fix 'at91_can' memory leak by adding missing 'can_rx_offload_del'.
> 
> Ciprian Marian Costea (3):
>    can: at91_can: release the rx-offload on teardown
>    can: rx-offload: add a per-IRQ receive context
>    can: flexcan: use one rx-offload context per IRQ line
> 
>   drivers/net/can/at91_can.c                    |  28 ++-
>   drivers/net/can/bxcan.c                       |  14 +-
>   drivers/net/can/can327.c                      |   8 +-
>   drivers/net/can/dev/rx-offload.c              | 196 ++++++++++++------
>   drivers/net/can/flexcan/flexcan-core.c        | 109 ++++++++--
>   drivers/net/can/flexcan/flexcan-ethtool.c     |   4 +-
>   drivers/net/can/flexcan/flexcan.h             |   4 +
>   drivers/net/can/m_can/m_can.c                 |   7 +-
>   drivers/net/can/m_can/m_can.h                 |   1 +
>   .../net/can/rockchip/rockchip_canfd-core.c    |   9 +-
>   drivers/net/can/rockchip/rockchip_canfd-rx.c  |   2 +-
>   drivers/net/can/rockchip/rockchip_canfd-tx.c  |   2 +-
>   drivers/net/can/rockchip/rockchip_canfd.h     |   1 +
>   .../net/can/spi/mcp251xfd/mcp251xfd-core.c    |  13 +-
>   drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c  |   2 +-
>   drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c |   2 +-
>   drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   1 +
>   drivers/net/can/ti_hecc.c                     |  18 +-
>   drivers/net/can/usb/gs_usb.c                  |  23 +-
>   drivers/net/can/usb/nct6694_canfd.c           |  20 +-
>   include/linux/can/rx-offload.h                |  48 ++++-
>   21 files changed, 349 insertions(+), 163 deletions(-)
> 

