Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010063.outbound.protection.outlook.com [52.101.84.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C733B3BF2;
	Mon, 31 Aug 2026 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168608; cv=fail; b=KCqX5EsQHgeJtvEV9o6bC2XcQue4tmWCbIYuKD05PGNRfiiI034JrxCunvg9gEcrRRhL7WZzzIoCtdbPsoG5aozpUOgKCIIbuWks4lUr9PZympfEpQcH4tAiIDeJr7mWIMB7S/UER9nsX2BQsPzXh1V+gIlhXpTuX+Db2yDTpe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168608; c=relaxed/simple;
	bh=dV5ZZRsmJ9rRXfbKHDCSFk2ZWAh5LrgH1Jh5HSC4LMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i/nPqTeIG/QOtd4ZfdGxCYaavBFqzgc+JZeOfsFHCFeuJhUxbliho64vr4MOLCRHsw9jn7Y2XtGwLseHeHwAnwQ6fwF4YmliSl32CKRtrVhmmSwgdg9708AGq2hnREsSmXFguaEo2CFkx5jAlqDELg7qUAWa1RJhhTjW+lBd/2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UBE9Sevb; arc=fail smtp.client-ip=52.101.84.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UBE9Sevb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqX9f5tzaY1HADRsvIwbTaJCVKrvjTdz141kx+e1jXKVb4AMEdYxHKpiaR8JIv8XQHbMfPPJx/fLu/cr0nnC9+6B9Axh8VNCPDuqi1ph1D5pEvMhda0BnxjqQYdYbhuGo4Gm0okam0ReqeSDtZRlcGnwlCn0g3oXKMdQsAg/G6d3L3LMl7DqDi02CQuxcM+LTo0STJD59bvTsWhvCCeu6Dp/xcN3h+9FXNPotWuow2JUaIqdK1YapfQn+stH8VbPDXRvUVsb7KaL/4RrKM91KDqQdeTGcZOT9wluXeZU5c6bFMRTf1K6xZJeimzYvOjcsrCnSl9svm8gD8fqcWlmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+W8LU54Fb9yLhCuGqS6DqO8AI5EppGtbLrKjt7XOH4=;
 b=IW07KzVCEe3T1tVr5qluNlCf7xhAsaV0LWfeHAR6vEHyMWaLZhdPZbBbS90DnoJ1fI0wwqJqxrDTi82uXHuxry4FLj5FH+dMcJIQWgUiLNYIrlKpJxGW0CKyu/uFEqIYS/w1QlkS+0Bh2/9er1OUAAn8hbql0TyujICF1xFhf8ABJbOO0CexXYrWYg5U5mV6Ul83BZrTCxgaRWL1oqmDDDm+N2ZRv14MXc1bWi9QVM9Mex0PXRY6g8+migDJa9m4Q7PuRTWBurXyMhjw4/rN1gFckPyEGHBsUAU0VwGf+5BLW5onLFt9DbnVIhfr3WncKEYNiboMbXmPXejMu/7+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+W8LU54Fb9yLhCuGqS6DqO8AI5EppGtbLrKjt7XOH4=;
 b=UBE9SevbJyvNvD5oHgFcLK7wQLOSa6YCVm7RIUu2hzWwa8lgU/JUd5NSGv56hZcJucyoVxmd4iVbMa4VnUJsZBhextXYUq58NytttSz9D64VW6Y+McogSM/ZUmX4B/UGzXrcOkUz7V44Z3ugQQiCBgbKSrQz3h2Azudr+J/jeSHGXRYZ4dYA/6LclbKs+/6vLJW2gHG5Kv19fYS6tTOS7fH6xiRl4XnXNKhjV2qE0lt0xefAr4FwXtGlEwlu/2zjfUgW5FwbXkBeqkXHSkMxDtaaMQWjw0I9M7RjSz39WsEIBISMEDRlB2rdg7/ZtqWVjuC2D0OCROtvrdP+jW5f4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU4PR04MB10957.eurprd04.prod.outlook.com (2603:10a6:10:584::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 09:29:59 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 09:29:59 +0000
Message-ID: <72930ce5-eb4e-44f7-a302-2cbb058d8293@oss.nxp.com>
Date: Mon, 31 Aug 2026 12:29:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] can: flexcan: split rx/tx masks per mailbox IRQ
 line
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Bough Chen <haibo.chen@oss.nxp.com>
Cc: sashiko-reviews@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org,
 Frank.Li@kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 linux-can@vger.kernel.org, imx@lists.linux.dev,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Vincent Mailhol <mailhol@kernel.org>, devicetree@vger.kernel.org, s32@nxp.com
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-4-ciprianmarian.costea@oss.nxp.com>
 <20260713090803.CCE2E1F000E9@smtp.kernel.org>
 <20260824101241.ysq45swzx4ihctel@shlinux89>
 <20260824-mustang-of-original-fame-4b3a91-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260824-mustang-of-original-fame-4b3a91-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0038.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::7) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU4PR04MB10957:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ff0c09-7573-41f8-0602-08df07426d78
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|366016|376014|7416014|4143699003|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HPn3QOWPj4CWq2Bs528G4sLcaWb6G0mnI9km5GNC+oFBYKRzCQN3EwqUhKuh8OReKVgxZ+ElRfRiakVQ6xI3O3OeAhRtyqMqPfuDV6dDeytLvM28gAtSiSypEXZBq2w0d6gserB1rKg9dO5W5HRlsngF6vE3sh2q956KwS60fnsvAaUkMuGtyxxC2o+Kqm/IMIFLvEhLFjK3wkTOfoqirD6GvTA2HE1rofujr9K/SkZMOYb+K0xah1SwSA6v4V4E+BkA2GR3X2yATFGmatnTE7CW6OQ3TAXhUu9jWaXMJ6Tq1IXrMxab4AcKTjsPIkdMlZXA8psH11eP/J2xnS3oXcu6bPnymDzNmnBUg901N6DnZ+dvctvAaTkV6CYbZFdM7N3K3eUaxoHBEeJ3TL2gZFpEcRWSjo5M8cah/+or+8XN8MkYoj7014+EbnlY8gQar+GKdhbIUM1KK2rlOxwV9yDa7K8gpmvKYq8FR7hNf9enBgsGzOxEI8tUzAGZj3IQeGU8n9+RZYeJky4YMpqthILqmNK61+477yrfMZ81lPOOBg6GYxCc1vwhWn3IumbNFRFXt1A6waCvymACMiddpT6TSKr8UB/0Zj0BxxQRklgqBd8xWMcSN2aJgn/kwBV3xmBqPlDW8HniPjxzgueZg13+0XjinpqathwzLOA62BU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(366016)(376014)(7416014)(4143699003)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME9pTlNtYWxRYnZyMTFQaktwZ3lGUWlSOHREZFgvRlB1QlM5b1V4TTZ2THIy?=
 =?utf-8?B?dWNyazV3REtLdlZoRENCZlh3b1ZYdHV1V1NzdWVYRXNhT0paWnQ4aEFSOGhj?=
 =?utf-8?B?WFRCOEFwMnlUczBOY0lYNm1CL21hNyt1WDhVcUtsRzZmWEVXUTI2d1ZPMkVv?=
 =?utf-8?B?OU9yRHdDUG13YkdodGR3MUh1dlliaktmZHY4RVpBWUNSY3lkSHFjN05YeDRM?=
 =?utf-8?B?SkxPUXNDUDBPOUFTMmF1by9JdEZvMVN6ZHp5RkhUZG9oYmFOcU9vQUNZRVdR?=
 =?utf-8?B?YXdlRGFhQ3BtNDB2c1NMRlJwTysrOEx0b05ETkExRHdjc3h4SnNCS0lQeFFY?=
 =?utf-8?B?MHB1MStMR1NmNGhnMWVnTXhZanQ3UXp3ZzgwU0Z3dXA1SmNleHVnVGRRQ0Rs?=
 =?utf-8?B?c1VXWmdTaGw0V2tuc3ZFTEE0N3g2N3ozRTFwejlxWFZkVWhETXBtM09ZUkNk?=
 =?utf-8?B?QlVMenNDaWFrN0JzSS9GUDZ4NkVQamtYTXFUSlZha2Iya0plYWNIdzMzVHZq?=
 =?utf-8?B?dGVwWGxvQi9ydVd3NENmckFOR1pqRTZGSnhRcDN6WGxxRW44Y0p4N21ZQW9v?=
 =?utf-8?B?RXlsbmlJbGt5RWxiY21oRzhMOWM5NktPWVF0ZU9xU0E4RWxiSmJkaDIvcDZ6?=
 =?utf-8?B?Y3hxeHRaQ3JhNi9FME9IdFMzalRidHJwUzFBRUU2V1gxZTU3MU9IbzJuSExq?=
 =?utf-8?B?ZHFJanZTam5TNlhrL2JrRFF2NldvcEVIZjB0MW9kWjNOUDhCSTdUTlA3Ym91?=
 =?utf-8?B?Q28xbkpOcUIxT0FMb1poZHZwL3o1L0hOT3VUc2VZWUh0RStyOTlLcWQ2cVl5?=
 =?utf-8?B?dlhrazJ2R3V4d1JFZjlQM2h6QWllNjlPWUhWT2NUTDhjZC9iSU9Tb3p6TS9r?=
 =?utf-8?B?d2I3Y2FiTFNXR1hOVC9qeEhTUTF2cnVObFh0UlNSL0lxSFNSd1haMXBmNTRz?=
 =?utf-8?B?TVljVDNLNEQ2ODdkS3J4M2Jyd0R6SUxaTjhDb3lCcUFQZHNhZDJsMzViRDRl?=
 =?utf-8?B?WGt2MDZLS1FBMURvL1BLcFVGS3cyZm1GUnpncGpMWkJJVUZTN0pENU5LTHBl?=
 =?utf-8?B?NWZ5dmFiejRHamtqQlRqbkkrYUdRZEZ1anUyaHRqN0srdlZhdTdrWEM3Z1Fk?=
 =?utf-8?B?bkF5UEl1c1pZRWxCZkRlTHVHWlh3VzhUVHFiL2Q0U1psZ3h5dFkyV3Z2Nlgx?=
 =?utf-8?B?S0J0L3ZWTEo4eEdsWVRtdU5ndVBnTEZObWxFYm9jYjA4cWpuenRYMFpYM1Z0?=
 =?utf-8?B?UGdQNnR6WkZENkRlN2NhWGFWU0dNdzBSaVFuTmdMckhvZjhkV3pzT2t0Ti9U?=
 =?utf-8?B?cXBmQWw5NEVDVm1vWCt1ZUlRdDNqMzA5cHcvckEzckVZZi9xNjdWNkQvOUdO?=
 =?utf-8?B?RXRNUDNFdXRhenpxVWFkK3ZvbWlvNXRPV2liQXJKUFp2eDNBbW9UaVdoWEk4?=
 =?utf-8?B?bmlsdm5GSmRhZnNuVUZlSWg2aEwrSHJkSGp3ZDNvVHAzRlN4TGlBUDJMbTJI?=
 =?utf-8?B?dExjczA4YlNPMFYyUndveGdHRlQweXc0OWtCNHJMa2ZlNkI3K2tuRldYWWd3?=
 =?utf-8?B?R1VVUCtYR0ZzOXdBZDNZcTYzMm8wcFBSejY1OWxIdXZSR0pGK25FQVI4a1g4?=
 =?utf-8?B?VXZoK1dqcVVvRkI4dlpoaEFMTHA5RHlXd2VTeldQNjVXdEpTOHE1a1pIcExr?=
 =?utf-8?B?VjNuZzcrQ1pCRGlQcVlWdjNRdHRVWGZvaDU2cjlBQ1FsYlJLZjhmSVBNUDFK?=
 =?utf-8?B?TW9aNFdIWk9ENzliNXowdnBoQ2l2bHFVR3ZIbVVsMU9pVUdHaUszSDhJaTgr?=
 =?utf-8?B?YlBRellHc1pKSCtNczIxSXpPL0cya21tdWRXSjRGTVFvWnR4cUNqS0hEV0l0?=
 =?utf-8?B?WEFQdVN4ZThzVzEzSHZoZDNIbnBnY254akM1djF0Q3NOT3JWN1JQOXhPODFh?=
 =?utf-8?B?ekFhTTlZSWlYWkpNNU9vbVZwSEVPb0gxWnRlTnFXRkRkWGI4VGNWdHJPcXRR?=
 =?utf-8?B?TzJSUldvUDZmTzBFcC9mSjEyMTI3M0JDNEdiZWt6V2xpbzFyK1NFZ0hmNlpk?=
 =?utf-8?B?ei8rN1FadksyMGRGNjlwMDM3ZVdMcnlNWVJjU1BuZWgybXR1R3VJVTBUek1D?=
 =?utf-8?B?ZE10d1BHSWlOR3hVNjNHTWdBS1BHWEdTQzB0Ym9neXV1M3dpWHk2QXg4RFNX?=
 =?utf-8?B?QkMxZi93NDBHMHRKMjg1cTNwaWlwL0gxeEZuZFdpaWpNa2Q0YlB0U0p3YnU2?=
 =?utf-8?B?ZW5jQkpWTVhXWVloV3NpV1N3bVFvMFVDUGFBVzRReWpUditrQWFlWDRhcXow?=
 =?utf-8?B?ZlcxTnl3dGM5TnlsbFJCcW1jQlJUcnpLSk9jRyt6UnRxV1ZLK25pTlZGbVNL?=
 =?utf-8?Q?XoP/iL9GgIx5tyDw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ff0c09-7573-41f8-0602-08df07426d78
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 09:29:59.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Soyai4Qa0dJQdABhD3++F4Z6G8MrHe/NzXUhJun+WCsQts03TBDCFXRsTYZFvLiT4C/3uDRdPO5yDVgkz0XY/jeB5Yy5ZN3oQXgeLTV3Qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10957

On 8/24/2026 1:16 PM, Marc Kleine-Budde wrote:
> On 24.08.2026 18:12:41, Bough Chen wrote:
>> On Mon, Jul 13, 2026 at 09:08:03AM +0000, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>>
>>> Pre-existing issues:
>>> - [High] Concurrent execution of multiple flexcan IRQ handlers causes lockless list corruption in the can_rx_offload queue.
>>> --
>>>
>>> --- Patch [3]: [PATCH v6 3/6] can: flexcan: split rx/tx masks per mailbox IRQ line ---
>>> commit 9f143e05fb5957d463ce1d05d4126d168798b0d8
>>> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>
>>> can: flexcan: split rx/tx masks per mailbox IRQ line
>>>
>>> This commit updates flexcan to process split rx/tx masks based on the
>>> mailbox IRQ line for platforms like S32G2. It introduces MB0 and MB1 masks
>>> and passes them to flexcan_do_mb() to only process the relevant mailbox
>>> range for each IRQ.
>>>
>>>> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
>>>> --- a/drivers/net/can/flexcan/flexcan-core.c
>>>> +++ b/drivers/net/can/flexcan/flexcan-core.c
>>>
>>> [ ... ]
>>>
>>>> @@ -1244,8 +1255,14 @@ static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
>>>>   	struct net_device *dev = dev_id;
>>>>   	struct flexcan_priv *priv = netdev_priv(dev);
>>>>   	irqreturn_t handled;
>>>> +	u64 mb_mask = ~0ULL;
>>>> +
>>>> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
>>>> +		mb_mask = (irq == priv->irq_secondary_mb) ?
>>>> +			  FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK :
>>>> +			  FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK;
>>>>
>>>> -	handled = flexcan_do_mb(dev);
>>>> +	handled = flexcan_do_mb(dev, mb_mask);
>>>>
>>>>   	if (handled)
>>>>   		can_rx_offload_irq_finish(&priv->offload);
>>>
>>> [Severity: High]
>>> This is a pre-existing issue, but does this concurrent execution risk
>>> corrupting the lockless rx-offload queues?
>>>
>>> Since the primary and secondary mailbox IRQs are separate lines (e.g., on
>>> S32G2), they can be dispatched concurrently on different CPUs when frames
>>> arrive simultaneously for both mailbox groups.
>>>
>>> If both IRQs execute at the same time:
>>>
>>> CPU1
>>> flexcan_irq_mb()
>>>     flexcan_do_mb()
>>>        can_rx_offload_irq_offload_timestamp()
>>>           __skb_queue_add_sort(&offload->skb_irq_queue, ...)
>>>
>>> CPU2
>>> flexcan_irq_mb()
>>>     flexcan_do_mb()
>>>        can_rx_offload_irq_offload_timestamp()
>>>           __skb_queue_add_sort(&offload->skb_irq_queue, ...)
>>>
>>> Or if CPU2 reaches the finish step while CPU1 is still adding:
>>>
>>> CPU2
>>> flexcan_irq_mb()
>>>     can_rx_offload_irq_finish()
>>>        skb_queue_splice_tail_init(&offload->skb_irq_queue, ...)
>>>
>>> Since __skb_queue_add_sort() and skb_queue_splice_tail_init() operate
>>> locklessly on offload->skb_irq_queue, could this lead to corrupted linked
>>> list next/prev pointers or infinite loops during list traversal?
>>
>> Hi Ciprian Costea,
>>
>> Please double check whether S32 can generate these two mb interrupt at
>> the same time, if not, no need change, just comment this feature, if
>> yes, then need to add lock.
> 
> If the IRQ is delayed for some reason, mailboxes 7 (associated with
> mb-0) and 8 (associated with mb-1) might be pending at the same time.
> 
> I assume that both IRQs will fire. One workaround would be to only use
> the mb-1 IRQ until the rx-offloading has been fixed.
> 
> regards,
> Marc
> 

Hello Haibo, Marc,

You're both right. On S32G2 the mb-0 and mb-1 lines are independent and
can fire concurrently if one handler is delayed (Marc's MB7/MB8
example).

For V7 I'll implement Marc's suggestion and use only the mb-1 line on
S32G2: move the RX-offload window into the MB 8–63 group and register
enable only the secondary MB interrupt.
This keeps everything on a single hardirq context and avoids the race.

The underlying limitation is the lockless skb_irq_queue in the rx
offload core. I'll address that in a separate patchset. Once it's fixed, 
this workaround can be dropped and the second MB line re-enabled.

Best regards,
Ciprian

