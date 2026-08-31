Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581532FBDE0;
	Mon, 31 Aug 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166308; cv=fail; b=DIl7hlcdb4coTv/5hBOVIbVDJhqpxEcxlagxycn5SDpLFUKyqxAkGiZMNG3lhrf6MAWGU4Obmcu/i4GG8ruzIDMMT9gdKw4IVZ9L++0sezaisnZ1gWsfRe5kikSwylVAktg7KLN3TXcYUfkdaDc+CJ4DmBZKgx3wOBMC1E7rU3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166308; c=relaxed/simple;
	bh=6ifz7vQ++bj6xJPc9OTcXsFmKJp53blZxrNRPvvleIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g/vfrOQy5H5czYfWH8vjNbNJx3gFvpyt6awl/seBQOUJSnMDzXw/N5zrY8QuEuEHSuG1K21EPvgeV8meVJCkOV/HPvxJOhGqX+/wy/wqtU5H6doLoh42oqTC1EIipcmOmPHG5Di7xFYSfs+3m0rzu2oTRPh+KNqz11UJQaYTdDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HQgy3Pv/; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HQgy3Pv/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7G9XzG8ect4KhJDWkSZffGUqyha03hzoXTGHKfl/2/0tfW2/407yxgQxDvZfWs6K2i5wKGgvU+PUYz/2dIf4T+FR3dVrMcKdkIJ1DPJL6kgadg4QdrZYVX/VgiICgh/0E0Ii+LQnCjc3X6cX4OAXdYdbXQA2N6V42LkIU+5OGrW46lbP5rSae6AE7SV7adQE6P3CUYHW7+mwLIBxxoMxcoycrb08DoHoXltJblCMSAuBVS6UPWIDbQ3sHoaji0mZPBeT6fsGWXvBSdygVonK6rlvVCg0ArMhxHyZVUFswpzTkwQvl+xXR2sxc18lzF16B/bx8KRtPbG81PXOaq8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhacesnqQl1WiqjaUV1wauuGmBSB6RCk7RgM7wkjplw=;
 b=rZFaL/UxSTHF4VZqRlzKPIWjkv6B+Gqn/uyM6yoYv5FTxL0Wmf/avmIic9s/hf5muWJMZHs0p2VWfsl1/xNP1RGZHyQIJ0UQjjuKc/lw2zncaxO16SrQrutMdtfdhNiiPCG4FmM/teG9b7rPZXRzQpf3GqILnJzqhWfVJ5MynFn4qT/B+DlhiHOO385HHHDDiIIgHIRSereabrWvqUkakf3QZh7UekPAiLhbCrARv+Cqd5mnCAmDRamhEpmMi/EXOSwxnh8Z3y+40FZGx3CqzV+UkjyggPkJAuxdT9xBv35eRokaNJNXHolQuSjLwts11d7HukgslMXVj6x5HJzidg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhacesnqQl1WiqjaUV1wauuGmBSB6RCk7RgM7wkjplw=;
 b=HQgy3Pv/l41QbdQ4fO/A9hwQPAok02hEcnOmbz1vVA80p6+Up1LDhh2nzQu0qAfFsJyW57j4mZ1IJfGjISz8VOmt/X5jUm8HidZzB7cwBwPMV80i8MuWLjPwXmXpqcm+2C2SIUg/3prumWQsk3VF/mRqdP6AH1r8mrE3/LlsAecCRKGzY2fQK+BO/07ZBeHPck2+lhuJBjPC4NsS3nQsNjL5uX1HWFP9MRu9epS1RKgr99hRVno0g8ToIXzP4rQUFCG3zCb8OON68QVejVD2PD7c12sp+msefrF4PZWj1TBPbMq5nrjZ0V+y/ZXg4NgVkpm6gNjmeHPVg6jp7oJJVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU4PR04MB12151.eurprd04.prod.outlook.com (2603:10a6:10:640::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Mon, 31 Aug
 2026 08:51:42 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:51:42 +0000
Message-ID: <0bf5e10a-a3f6-4f71-a23b-d065cc5681a4@oss.nxp.com>
Date: Mon, 31 Aug 2026 11:51:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] can: flexcan: disable all IRQ lines in
 flexcan_chip_interrupts_enable()
To: Bough Chen <haibo.chen@oss.nxp.com>, sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org,
 Frank.Li@kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, conor+dt@kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, devicetree@vger.kernel.org,
 s32@nxp.com
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-3-ciprianmarian.costea@oss.nxp.com>
 <20260713090705.9F7671F000E9@smtp.kernel.org>
 <20260824085716.ejrveo5udehy4ijc@shlinux89>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260824085716.ejrveo5udehy4ijc@shlinux89>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU4PR04MB12151:EE_
X-MS-Office365-Filtering-Correlation-Id: 11cdd3bc-2664-4562-3763-08df073d1403
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|23010399003|1800799024|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	x30x1JeQLq2nGwrXC8JZzk75htCX+hr2+nkEO9SFl5LUKyXbSpjrRyV0CofcuDoyQcAecdetFREccDSCimZAh7LCy7b2RicDBSdDaev69fE+jqpzXTqlTN55d/PtFi9LsWsHAFmDvp6x0HYVK0HPk2/0SX5XfAMin5N9LQhHAY1EfDZ5flyfxAAabmwaES2iyQcLy3F+UvNueXwa9CGAbGz+xgjW7bq/JPP97bY6bkoAQKrFB59jmVdAxPXC04UqWurU1Od9W9NjBJaDQTfevMyDtfwnwBwg/EtCKMRuvI2jOAF3X3NgMcSVTFqtNoxi5wUeXWZyrF48rP4MmbMh8/YCP+Gm9LqwvXz3x+4Cp5TvE0wg0UCh1ZwvTzSMsJk/99GY/PtpDBJv48a6NED7HiTpM89EqF72gdTlG3CRXl8Zx6uXIzhyT4DPbC0LKistVCeLDKLTy5mBe1iClQYzI4YI8PbfCagshaoY5YCjh5jIVRmMIMkIWo0ew/7IJjHtvWntx736Mi1WQXXbjf4k/ENnfhD8HtBHtoptZCgKLpIeyD5aoKY5pi1n6JDLmUWcLpUuZ++kK8vEdTsF4u1VgHsGAAhU5ytWj+ICsR5bu/c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXFjTVo3WnhwdlQ1VllCK2hvQkxwWGhBWFdBTHM3TGNlQ2RjS0tCbGY3UC9x?=
 =?utf-8?B?N3pmZkhCdGZYa082MmJYeHRQOGFpems3MTZLazJ1bTBDWURkekg5cHcrREw0?=
 =?utf-8?B?T0dVd3R2MENtbWM0M3ZOSmxNaitrdUxvcmVETXhrRHlqdmFzTlk0aFl1N0ZV?=
 =?utf-8?B?cGtFQXM5R0kwZWV5Mmc5a1lqbUJMd1Jvd2ZYSkNyblVUQXEzTzE4Q3hGbXkz?=
 =?utf-8?B?L25XSFMzOGIyMTliNFZ1a3lBQzljckZmWFZYYmVERG1KVmZuYzQ5N0x1ZHhT?=
 =?utf-8?B?MDk1dVZqeFNHN0xpK1V2OFpoa1JsS29Eb2llRzJ4Q0oreGhoTGJLdDhxMmpT?=
 =?utf-8?B?WG4xYTBSZW1QUFJjalRUV0tod0VkK1Y0K3VvRiszc0xjUVpQTXB2MWhSU0lh?=
 =?utf-8?B?TmlwSmNvMzFINE93V0JuNEcvYkM1RlNrL21tRkNuMnZSRDVHeUdXaTVQcGow?=
 =?utf-8?B?TmpZVmkxZCtJbWlrVlEvVjJzcFZoSk9pbExVT3lrVE9oa0I1NGorMy8wL2lQ?=
 =?utf-8?B?Tzk3NDhSM3hRRDBmSjk3NlhacEIva09JZEkxNVhxZWZrOUpDenpya0d3aTRQ?=
 =?utf-8?B?US9CNlhCbmNCVWxqSjZ1ZzNXZW1yejlTVk5MYlN1TTNMQVdLeHVROWNEUm9I?=
 =?utf-8?B?UitpVE5NK0Jja0YwbTQ2bUpza3VtSjhVWnRlSTc5aGhpV1loZlplUXNhV0pI?=
 =?utf-8?B?K1l1amdpclNrNkdIdU9SSndWRklPSXJqZzNrZS91UGtmRldaalN1bEVZZFps?=
 =?utf-8?B?L2lMNWRNNEtCeVR1Tmxpd1NyTUJFa0lkS2tVbGgwVXh1Q3JiUGxjS2piYVRS?=
 =?utf-8?B?ZjlCRXdLVW50SXVjbWJ0VnZXaXBFaXE3WlpSZVFKam1kc0p6aTRoVmVmZER5?=
 =?utf-8?B?STBjK2NnNzIzaE5DUmVGRDQ0ODRjeFA2MEs5MHg1aHBUODZ2K3V2OWNaTng5?=
 =?utf-8?B?aGlVcFlMZ3Nod1dyeTBMak91NC9uRjB3ZjlKb3Fya0w3K0ZkTzNhSVBxL1VJ?=
 =?utf-8?B?Qk9tZVVzbm1yNlRGNDF2eWNNSWsxTFBuOFhkckRWS05vb1h1K0o2em1NZ0Ra?=
 =?utf-8?B?UmRxckJ6YkpsUk5zTEJVc0FOZU9vNG9wTVpvUFF0SnpBUWM5b1ZmYzY0Q01E?=
 =?utf-8?B?R2M3bno0OU1GQTBOZitlMWdpZENOTEJYeVVkVWpEbmlmM21URFF2dlFDQXJ1?=
 =?utf-8?B?dDFQbTQwVTllMDZtOTBiLzcvcEJqL3Q4MytYYjMreXluRTJiQ0tzUk11QXla?=
 =?utf-8?B?RXBaZ1ZOaElLVHhsek93ODVEemJXUFBXREU5cG5scHRnclVXVFZBaW96Skk0?=
 =?utf-8?B?a2lYTXNvUGJrbGZ6alhSRU9Nb3RXcnBxSjZKdC85OWJicmxVWnJGdWJDNWtR?=
 =?utf-8?B?TVY4NjBxejdTZVB2NGdDSDJPQ2VkODlaWTh6cytSQjVnTndSU21qVHFvaDRs?=
 =?utf-8?B?d2hucjRwblBqUXZUYWx0R2NIdGI0NmlZcm1FS0srMHVWL0pTdldwdEptTDVu?=
 =?utf-8?B?T1RQQ0F2ZkgzU0ZOQ244cmpIais2aUNFQkZqcEJIZTZ6aEZIT1M5Ri9HL0VO?=
 =?utf-8?B?TzhRTnJRbnFxMmZVWXg4emkzMi93Q2dsS2VRNHVMMGVYOUhGZ0xHQ2prSFJT?=
 =?utf-8?B?aTVjTzBIOEVCUTFmQjViRWt6ZUszQlNwd01YWFJiWFVpQWE1ZE9zLzFXbDRl?=
 =?utf-8?B?bnB4OTZONlRnRXJQU09LRFJXNHdHSWpENDEvUUU3V3RnNDhHVUR2NUlXRGl3?=
 =?utf-8?B?RFJVWVVpT1UzSXVScktCV01KOTM0OTJPZVRYS1BHUk5BRFZvMUZGNmQzb2RN?=
 =?utf-8?B?djZLRVJmWDRMOEtRZHV3Q3NOV3djSlREdjNZS3haQk5MMVZTUzJPY2R4dURL?=
 =?utf-8?B?a2RCSkNrNk9SQndFaDR5dEdpQ2ZTOFluMVlRVlZwQ21GQ2hoNVRTQ240dURF?=
 =?utf-8?B?U3JFRk5MR0FNZVNIUnBnMnhvUkpXdUJiMzViNWtwc0F0YVVMak14WUM1VVh5?=
 =?utf-8?B?TzZIUFNoeUNqZFBjWkpZTm5FR0EvQWhtd3RlY1RRNUdDVnVvdGV5eTdGL3hC?=
 =?utf-8?B?ZzEyb3VhaDZyb29LS1ZCdUhkZlI2SUpDM0RhdzdRK3poelUwMlF3WDI1allF?=
 =?utf-8?B?dVM3V3UybGtPOU1maDZkVmRmUFJwOGtwaDhBOEw3ZVhGVlp3NjloR1E2N1BG?=
 =?utf-8?B?M25Oa2pOa3Y5RGJmODZJOXhudzc0WmhscDVuTVJabTNHQkJHV3JEVlVyY0pD?=
 =?utf-8?B?ZDR0b1pDTi9wWWdHSG9oamFOaEhCL0oyL2dSV2xwT2dBTWhWWDkyK3dBZG5s?=
 =?utf-8?B?aExxa2Q1aTBET0l5VVNRajkyMlRaRGVOTGN2WlExMDE0cHZuUThOTkt6VGNG?=
 =?utf-8?Q?6pKUb1d/YmCZQXFc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cdd3bc-2664-4562-3763-08df073d1403
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:51:42.1473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oe9UXyIdMZVPd06+vkC7SIVoNw+nG7Gd8tigAs3m5ghbjqmr/7pKV17BaDO3WTmmKCvvn0a9WP7Z+yDqlujaywmtgC3I0mVt3IOelQ0GKTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12151

On 8/24/2026 11:57 AM, Bough Chen wrote:
> On Mon, Jul 13, 2026 at 09:07:04AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] On multi-IRQ platforms, Wake-on-CAN is broken because `flexcan_suspend` only arms the primary IRQ (`dev->irq`) for wakeup, completely ignoring the state/BOFF interrupt (`priv->irq_boff`) which actually handles the wakeup event.
>> - [High] In `flexcan_resume`, the network queue is restarted (`netif_device_attach` and `netif_start_queue`) before the hardware is initialized (`flexcan_chip_start`). This creates a race condition where a packet can be queued for transmission just before the hardware undergoes a soft reset, leading to a permanent TX stall.
>> --
>>
>> --- Patch [2]: [PATCH v6 2/6] can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable() ---
>> commit ca7ea75d45df1ecf13f11dcec0bd19377eccf3c6
>> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable()
>>
>> flexcan_chip_interrupts_enable() disables only the primary IRQ line while
>> writing to the IMASK and CTRL registers. On multi-IRQ platforms, the
>> additional IRQ lines remain active so their handlers can fire while registers
>> are inconsistent. This commit disables all registered IRQ lines around the
>> IMASK/CTRL writes.
>>
>>> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
>>> index f73ff442d5304..7dde2e623defe 100644
>>> --- a/drivers/net/can/flexcan/flexcan-core.c
>>> +++ b/drivers/net/can/flexcan/flexcan-core.c
>>> @@ -1519,14 +1519,28 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
>>>   {
>>>   	const struct flexcan_priv *priv = netdev_priv(dev);
>>>   	struct flexcan_regs __iomem *regs = priv->regs;
>>> +	u32 quirks = priv->devtype_data.quirks;
>>>   	u64 reg_imask;
>>>   
>>>   	disable_irq(dev->irq);
>>> +	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
>>> +		disable_irq(priv->irq_boff);
>>
>> [Severity: High]
>> This is a pre-existing issue, but on multi-IRQ platforms, is Wake-on-CAN
>> broken because we only arm the primary IRQ during suspend?
>>
>> In drivers/net/can/flexcan/flexcan-core.c:flexcan_suspend(), we see:
>>
>> 	if (device_may_wakeup(device)) {
>> 		enable_irq_wake(dev->irq);
>> 		err = flexcan_enter_stop_mode(priv);
>>
>> Since the hardware asserts irq_boff (which handles FLEXCAN_ESR_WAK_INT) for
>> wakeup events, doesn't irq_boff need to be armed with enable_irq_wake() as
>> well? Otherwise, the system might fail to wake from suspend since the
>> interrupt controller won't treat the asserted IRQ line as a wakeup source.
> 
> Yes, this need to be addressed.
> 
>>
>> [Severity: High]
>> This is also a pre-existing issue, but does flexcan_resume() restart the
>> network queue prematurely?
>>
>> In drivers/net/can/flexcan/flexcan-core.c:flexcan_resume(), the queue is
>> restarted before hardware initialization:
>>
>> 	if (netif_running(dev)) {
>> 		netif_device_attach(dev);
>> 		netif_start_queue(dev);
>> 		if (device_may_wakeup(device)) {
>> 			...
>> 		} else {
>> 			...
>> 			err = flexcan_chip_start(dev);
>>
>> If netif_start_queue() is called before flexcan_chip_start() reinitializes
>> the hardware, could the networking stack concurrently call ndo_start_xmit
>> (flexcan_start_xmit) and queue a packet?
>>
>> If so, would the subsequent flexcan_chip_start() soft reset wipe out the
>> freshly populated message buffers, aborting the transmission and leading to a
>> permanent TX stall since the completion interrupt will never fire?
> 
> Good catch, those two findings should be addressed in another patch set.
> 
> Regards
> Haibo Chen

Agree. Since these two findings are pre-existing I will target them in a 
new patchset separate from S32N79 Flexcan enablement.

Best Regards,
Ciprian

>>
>> [ ... ]
>>
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com?part=2

