Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273E4E66BF;
	Mon,  7 Sep 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793669; cv=fail; b=ZGAaRigQZeR5HYMzT1VKHIiKaWhvpjPsZYX14aB9NH1xkmgcR4gLNOsZUEOT8zwFy+aUAPtAHG49hYiHRhJg4errAI+Ezfj0Ga3GJPLJO1okVbzLDgbCFgIUQRxFNVNVSxB9iDJ9lIUmvLjrunZC9dH/Kbn37Av5RUywfNZyZKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793669; c=relaxed/simple;
	bh=3pGrZss796uy4SesAUfd06Ceh566aJK2OyioOmljdEY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FgFxbuMmtKeTum5ZzC1MK+Ag9SX9x8JFdIfeItuL/5T1lTFqIySoaNbjcqDDjxIBXg+gkOTXuPXSbOAi5d5bADRxwjPGr7a1uKeuICIAXplMPe9Wqr2RChju2vqoDsJYPGAqQtInI23IxUni6i2vaHSWiaAC4q5aVOILTgDZTuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ahxg2T/b; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ahxg2T/b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCuEbJMtE7sRruAVpksRCh+JFDeoSbT3AxT+h6HKq8vGOw/Sh5lLMeFZjSq6IUKnxiNyukhz692stMnTF+updVR2gI/44RAXR55VIK+ODaFWEMZuc5jds0IMaZnRVbB7udQoPjDV04IaXN9wBHXfBwDccgEd2pDdhOvMjrp4cpj8JoQvspHFHVoQhfkskoVG4oWl62slwonpa2wb2xrhaDmBG1o39dailHSh0I2zBZjY2pBvilXyfeVvu2KPqeXytuLwaqcjzhcjK1cMhk1SPu9F/Ri8MmRGGN0Y71pEBHezszEHp9pal8Aj8DOjmDYwxpXVKOxlCX2DzX9lOW62Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyLte/efpILdTc5FfouO8wQoJcwnShv2w0I0Tjy0+D8=;
 b=cu3aId7nMhF3TwHcymnP5QZ7fxr9KM1SAo3qpEvtfOOjUkyKqMUYVuw4ccOVW1wHz0rb6XhZbkk7MkIMxzuD9/atlPEMaSL1m0ilS5TkMVwvA/9Fi1d+SMU9fCqX2W1MpLc0gY4k8rK0jxf9ZM9i+XdUJjCYQ+52esMCZOfxUuubFJLvk2mKaN8WilgercFX6UIMiRhcF4CazOl+ppE7ggtG16iEKNX+931tvSuK6FQsE8RY34MS1fU2NM8OULy9lW/EgY3PnQfwBnyZ5vj1b9TpmHj1gyAeX121MfRG1B9aua2BC8gB76MAzWpa/ydpqclQgFX5exNek/fiinI6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyLte/efpILdTc5FfouO8wQoJcwnShv2w0I0Tjy0+D8=;
 b=Ahxg2T/bvJdazUrNOfnTdR+a6cEVQZ5FK6PuEGTYe+JikyvsnN0pu498dtsMp/l13qZximW1HM+YPoFlFn4C/nkeEzfE0YyAoQRqsConIRVxB5eeZLNoXJ42rMH5opBK73MrxIMyfQ9dlMxp+RzYAa9MVD3bYrO6jN6we/lBloXkgwmVgkjiTvj5MyqdzErUYV2kKOuXVoM/Mp2GPO58SXogd1qNfGExDxBGnwvVa4OHcY+WlGS7JFc4Rb36UGOOaaL2fJEp4ygAkVScPgrp3IgEET1DwEwnaVcG4qXJzN60gU0ZRDDwyhno2gkeAOJyiT7PeUSUrceh3xGrAEC06Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU7PR04MB11236.eurprd04.prod.outlook.com (2603:10a6:10:5b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 15:07:44 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 15:07:44 +0000
Message-ID: <6bdc8044-34de-4d7a-89a5-908de7f8b044@oss.nxp.com>
Date: Mon, 7 Sep 2026 18:07:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] can_rx_offload keeps a lockless irq_queue that the
 IRQ handlers fill and that is later spliced under skb_queue.lock into the
 NAPI-facing skb_queue. This works as long as a single context fills the
 irq_queue. flexcan with FLEXCAN_QUIRK_SECONDARY_MB_IRQ and mcf5441x use two
 mailbox IRQ lines. When those are affined to different CPUs the two handlers
 can enqueue into the same list at the same time and corrupt it.
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, NXP S32 Linux Team <s32@nxp.com>
References: <20260907104942.17089-1-ciprianmarian.costea@oss.nxp.com>
 <20260907-lively-easygoing-groundhog-51cdd3-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260907-lively-easygoing-groundhog-51cdd3-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::12) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU7PR04MB11236:EE_
X-MS-Office365-Filtering-Correlation-Id: 010cd48c-f989-4918-54b9-08df0cf1c4c3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|19092799006|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7/5jttF2HJIgFt/GhUmyuHr3cD7Z/38hhooDJIB6Y58pCZwgWbUY3uqLhLCAgdTUD1CoiewVgRCvCSCKsXDcVZPV9XyebOUSAnsXjwE4jzDviqa0hQVybjp84K43k3hvvBxJQMA317D1z0To8wKW+gruijfRMlZyAmrJ66IDC3A/UVu9iBPQOFw3Pn0ippaH9H28sYDknj+lT4OmRQk9HD3YCJYf8y63cIuS7mucwRQqy1EAv5LEQIeEMP6F6fi0gGAOp9p6kp4aauReLA2bom81Dr2S67r+RMDkoTWuqGnf4RUCp3SWwk/ku7YabjBw9JPhWYEsLWML0bU5h3JybFp9DpcQ0Qm8f0AVZ7pzUmnbAYDkeZRNsXcaMp//M1tGRc/DEsHur2i1PggvP94bnlompUY7Q465jMpw+txMia3lDT9D2OL+qbPmmMIjMpf7qIqSVn1+d0j4oX+CjmnfFA51hV6JoSmWxwc8D4D8muZx9RzQBfjt7+73ISuEreSfQZe1YtDY06EnB497dHf3fnCGt9oEtcktikWgOH1O06DVrQjpfE+2nxeLQ59jN/jlu8xfe8quYTm/83XZxFzQCWfrONnFs6Tw4PeqHPHNeHTvtI4yeQKrnZIl1TbiKb5k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(19092799006)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTF0VFR4Y1UyNnVpL0dFVHAzWG1pbEE1bm83RC84YXlpM0ZReWkyMURYV1Rh?=
 =?utf-8?B?QUl0TjF0M2N1SC9BeVhBeHRpaFFUUnVVUS94T1doeHJYRVg0L1l4QmhncDcw?=
 =?utf-8?B?OENHUzkwY1ZBYUNXT1Z2U25HVEhSd21VKzd5dCtZcFNQaVg0aVgxaE5NZzN4?=
 =?utf-8?B?Tnd5ZFp6SG9vOFFGelpUTyt3MzhQaEFncEQxMkt1SHB1eEhtSkxaMkpPcXFn?=
 =?utf-8?B?S3I0Sm50ck55MjJrVXg0WFpUcCsrdXYxM2ZhWkhGaGM3aHM1ZjRtTXIrVkpo?=
 =?utf-8?B?K3BERG5adkM0Q3Znd2orRWhHVVF6RUg4a3dISDJMbVZnaDNPMlBmTDROTGxq?=
 =?utf-8?B?TjMrZjJxV3Fkc2NpMlI2dElOWlRKTXRTcnVldkl0T28xUitNVVFnaGtXajRE?=
 =?utf-8?B?OG1XemxuU1dyblFEaXB1RjdObTRuU1lINHp3VFg2b1lJK05mZjRHYU1PUjJC?=
 =?utf-8?B?bmkzbXpVRTR4YklQcDAwYWo4WjhsVm5kbXlSSFY0QU0vUmRiVVpHZW5Gb0lk?=
 =?utf-8?B?MDdBdnpFa0RlWndVQ25YV2Z6VkwzTitFUlB6RDNhT29tektvTkhMYUlYNHV1?=
 =?utf-8?B?YncwWmZJTEZaOUhKZzkvRVB4MTlTVVJjTUgvN1NFY3dBYkZCT3ZnY25TMXcx?=
 =?utf-8?B?QUNIejhTRDRybEd3KzhlR1VKOHpLZ3lCbkdJTTZ4L2R6b2VxT0hDSjZBOGdl?=
 =?utf-8?B?Z0NDYlAyU2QzOHFOTFBjV0o4em1tZFEvSXc0bFNqQ1RUWUphcWJ5MkYrTmQ2?=
 =?utf-8?B?TVVzSGpCTm5SUG5LVTFWMDkvdEpNR3FudVJEeU0wL04yTlFrMDgwS3A5U1Ux?=
 =?utf-8?B?Y2FuRlBkWFFsZFRNMDhxZ2s3MVM4ZVJ0bFQ1Q0VmZHZPMGJORDBqOG1MVFZQ?=
 =?utf-8?B?M05pZmJlcGZPRjNPRTc2RStWZlhMUjRhT2JyaDQ3OTAwWE5LSkxsb2o3Z056?=
 =?utf-8?B?UXB2dUc2dHA0K1EvK2ZUamY5ODBNL0xLRUQ2RVhmNEdsR2UxN1lnQmMrcU9O?=
 =?utf-8?B?aGtWajk5TXJUdG1TN05CendhUXFDNHZVRkU3aFdsY0NpZHNoUm1KdXUxcjlk?=
 =?utf-8?B?S0RkMWxZK21yWUJET09ZajVSZ3JNRWtycC9PUnFCTDhERUxWUUcyUllMRTkz?=
 =?utf-8?B?QlNPK1RBeEhTK0xmdWFSemVGaEJDbitVWTRUOFp2VzBJUGRWdTUzWDZUVkpD?=
 =?utf-8?B?dTFzMldHSkhxM2NJUklDeFNEcXZrNHIrd21xS2tKSTgxVmVFU29EdXVFYklF?=
 =?utf-8?B?VXhkajBJK2V4TnJNclIvSTZYZEVWeGZFRFMrWTBXNUpqZDVSMWtkRFdQNWJX?=
 =?utf-8?B?NS8vbFdEYjJsaElYZkpNTzVZT0Q3QzM5TFBxZXpoNVpCVHpWU014YzJIOEEx?=
 =?utf-8?B?VlNwOExjMEJWaEZDUUw3MlFIWUI1SWhxYjA0UTkyMVRqQnhIRUpzYzRUUzdM?=
 =?utf-8?B?VXUyMVRIOTgwdGhkby9iM0cvank0RFVlZk5VbVNsazByOFpKWlQ4RmpDUGgv?=
 =?utf-8?B?U25EbG9HQVNYL3dMY1U0MURkbldPN2lQQmg4aGlNS0duYkUwd3B6M0RTREpo?=
 =?utf-8?B?T093QUVhY1pOMkZHZ3BnMVdGd2NHb3hKSjJSSVQ5UmkwTHlRcUJpZDlBb2s5?=
 =?utf-8?B?UkY5eXBVNmRYUnBMNmpHT1VqMHRlY1NGVGRQNy9uekI2RjFEVlFqcExXdDZr?=
 =?utf-8?B?djNRcnpNcjZzWCtMM3lUZUdQeUkzamkvMGppMWdIK1lMc1JPcVd1L3RMSDdu?=
 =?utf-8?B?UFRIeFE0OWdERStrM1hqZUlSd2laYld3RFV6M0VpMHZnRFJzaGVDbktPM0w2?=
 =?utf-8?B?c01iZktwYUVMWDVWUmg0QWkwOWRZYmw5cGxHWjMzYytKd3A4YVNPemkrVUZM?=
 =?utf-8?B?bklZczVWcTNuNm5XVDE3dGh1ZjMrcDFQN3l6YjF1N05aUkRPcXV2WnM1Q1Ns?=
 =?utf-8?B?SVQvLzJ2cDgyYlhCdm5BcFVvZW0vLzBRWG1veWxqK1BiSlhCaEFaTHJ3MnRR?=
 =?utf-8?B?RURNNTlMWGxnM3M2amxxOWd0cEpsajFIWWtxK21na3Y4ODNFTUdwYkRleE5O?=
 =?utf-8?B?Qkg1cTk0Q056dEkzZEpWRGcyMWE3ZElheVNLeUI1dUZkZFdudmw1RDBiQXJ1?=
 =?utf-8?B?dVdvekx2TG1nZ3EwbzhVNCtoaEVTVUl2aVlEa3l6TmtzcXdNcktEYW4xczJE?=
 =?utf-8?B?WlNIYTBoNlB0ZmdDZ01qRXdTRngxUUpEeTZHMDhITy9FKzgyTGhoeDliU0xo?=
 =?utf-8?B?R3BpQWp2czV2MFdlK3FtUSsrbkJISnUxcW9idm9XbnN5MkZocUYrRnhTRzdP?=
 =?utf-8?B?RUNPbHA2VHBlbDNTbm1TZUpHYXRIeExETUFjY3UzQk05blg2ak16VEpUbGFR?=
 =?utf-8?Q?/WDp27VpbRUgowjs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010cd48c-f989-4918-54b9-08df0cf1c4c3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 15:07:44.0086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oj3wUBwDkSFBMZbHmBAYPXU7NnrxYqgb15Jle4tJ9tlIfNX3qnGwh0LF5KsaE0VSiorib6nAHIgrGpyoRKti6YAfwJcWHeKiksJhiANfjr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11236

On 9/7/2026 4:49 PM, Marc Kleine-Budde wrote:
> On 07.09.2026 12:49:39, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> This series:
>>    1. Makes the irq_queue per-CPU so the handlers no longer share a list.
> 
> As sashiko pointed out, using per-CPU variables in a preemptible context
> doesn't work. When proposing to use per-CPU variables I haven't thought
> that far. So in hindsight this approach is not good.
> 
> What about following what NAPI does. Have a dedicated data structure per
> IRQ. I think these ones are needed:
> 
> | 	struct sk_buff_head skb_irq_queue;
> | 	u32 skb_queue_len_max;
> |
> | 	unsigned int mb_first;
> | 	unsigned int mb_last;
> 
> And pass them to can_rx_offload_queue_timestamp() and
> can_rx_offload_irq_finish().
> 
> regards,
> Marc
> 

Hello Marc,

Thanks for replying.
Indeed the per-CPU approach should be dropped. I've also missed the 
PREEMPT_RT case.
Your proposal seems better than even having a dedicated spinlock for 
skb_irq_queue operations as I've originally thought.

One thing to confirm before I go ahead and implement this approach for 
V6: Having the following connected patchset in mind [1] which separates 
the IRQ handlers, both flexcan MB IRQs currently run flexcan_do_mb() 
over the full iflag. Therefore, to actually separate the producers I'll 
have each IRQ drain only its own mb_first..mb_last range into its own 
queue - is this the right approach ?


[1] 
https://lore.kernel.org/all/20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com/T/#t

Regards,
Ciprian
