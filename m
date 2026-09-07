Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982E24DF4D4
	for <linux-can@vger.kernel.org>; Mon,  7 Sep 2026 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787956; cv=fail; b=c1Ofx5x53j5msbLEat6rDi7i4ILxHOyevQ26szJYNRfPnmJCFyGczOBH3+KCWOd7B02OGbpD5Ndp0ahutzDpC8LHcqenfCx/OSNxaQ5gy2Vhc/Y6ehOzSko+OgXIToqSo5pwXYEzf2tdArjDGg+bkQTeycWC6J3iw5wN4gvm6oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787956; c=relaxed/simple;
	bh=/QDQ8OyEbHl21GAteyCVWjQcGRdMVYMFQC3zqqttISk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RJw1Zik9JFgh0Ioqpcc0ODLfk21zDHEoNQThAcOd6M9lowSMDeoOTWmYqsDnIqGcvuRuHXt9t7I8YPFFHGBap9CtIgqrabxrHEAkC/YIP8zhTJ+3vocKtK6aF2fkgICFSDRv6/RBnLNsdqXdG+iKQ94emeWsDkUMtrwBImFHeic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=U1sBU9Mx; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U1sBU9Mx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1DhGcM26GevCfujW28hQElBP/c3NQSx9P5jTKTwxoI8g+UtKKp0Z0snz/eCw/HJ8XWx5/ia9P4YKtHVIY9xa9SqRNDhErjucfORrZsehs5u0rQK5iHtYQgoeZgdNfKRhQ7W6SDYdckEUfDGO6kVzKhp0CrITqlLheYJvRljIH5C3mkcKFHZ/bBdvN4/RIkP5YVHlsHk213hyukFrS4DyNJMjDldhTxdboBdcqZepXZznehxUUQGDTfV+ML5zeCnU/xz39LgKB8k6hOcUtEmXT4qNN0QJxPx+/021hUwa5bLYr+r9sNGlOEoZrwce+foBt9gZPenwy84/6NnLT9+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kZVZRPTe6CSHUD0EyRYzPlKYrQQTrc1rw6KYUdSyHc=;
 b=tMvs7P5ggbRRmzdV7EZA5RgpBE2H/Kg/lPzHzvjkIg74Ix6fc8K9iYrowSixrlycf63UuMp0aSCzGfap2WJ/4QcW+l7PW60ePeOE4RCboqplAhR93yH2PxRmPVAa12y5e33Hqb0gDCcuyHI0JRzMZlyIM2rUn9zSf5GN0FI92qPvUO+sA4GhfdLHvebj+O1DHVz/qGwmazPBisr3lk42j8KMvalnBbdUm/toPZloO4NqvevuLVc2ZB3+HH3yHxCUDePj6u8oz/UyJPFnokEVPFrhaVZe1+syGBRcU4cG1vtRMww7o3H7W88lnhlNr6XSGm3QsrclJ2W3hvrg62ggrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kZVZRPTe6CSHUD0EyRYzPlKYrQQTrc1rw6KYUdSyHc=;
 b=U1sBU9MxKmI07jkpWDSV6JREdDfbxvT2Bqlyevp6CbE68OmH4BORrrH3o9c2urMiy2Gr9GQpvdzDXsTlU2v8+doWB2fa3CO0lPu2TTy6fzyR355hbykUO4EFfyl0oVBmH0cuNAM2C230tFUmRdjMcDBkY+AbCtuSgJwV9zhMXVlWmMxBD0vDLSxTfkVsvGVz12QWMmdWkTu9P9jB4x/2rnwndPgT8PLpSInDq///BzxbCfZgBiAj7ZPoXrsHsaaLHVGWUcOwW6i6wzxZDKnfwUbGD9IROEr23IW9dUxaxD5B70WSRWCipOEbBhu972UfW3sCaWx4g43HJYNs5UBeAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by GV2PR04MB11190.eurprd04.prod.outlook.com (2603:10a6:150:278::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 13:32:25 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 13:32:25 +0000
Message-ID: <c02c76b3-8b6b-4ecd-9d9c-2a2112571da9@oss.nxp.com>
Date: Mon, 7 Sep 2026 16:32:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] can: rx-offload: make skb_irq_queue per-CPU
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@kernel.org, Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, imx@lists.linux.dev
References: <20260907104942.17089-1-ciprianmarian.costea@oss.nxp.com>
 <20260907104942.17089-2-ciprianmarian.costea@oss.nxp.com>
 <20260907111228.3869A1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260907111228.3869A1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P192CA0017.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::22) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|GV2PR04MB11190:EE_
X-MS-Office365-Filtering-Correlation-Id: 028b01e6-6fe6-431a-fa2f-08df0ce4746c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fkIb38vaCV5JALVKo0QXDewUeXHOy/YMe0PXldgNfm5zwZ0QCTdPjpfbqBJoeaeVZ36CUhh7Lb+JN7DC3q8k2/PBKCQCk9aeVdmP5ekE1wXMiEjsSe1BDdW/hDX2AZswj5XIiFH2NFEGzNgyH0EKRhRN3SPQ39Wad+VcLVRA+oBypoMcRBT9GMWXqKvUk2uYOY1f61mW9jQKrO6Uz5dDdSo9gsprL/+MH8wdyoEEiAERo9GrpUplTuCkk84fdI6buUnMcg9lXQNNiF/0rPG4EwomjxhfQ1UYgx+bOI+w1Unu6ZMP2WjElUoNKoDzmVldqecyN99zUWIL0SxdyHzrWq2HkR5Xmkso9GWE/OcbV29/OK+yu5Le45xE/5b9QBuh74KqOmjvjC3vDl9yYoKZDVTe+jh+2KoNxspih5K3/LuZfKBGLLOYrzYsLloOyDjpSoHa0w+uSbyR2n9y6Oj8xyrDAmTvETqp6r0mDZ/djrO4aJRYxtuofr3nj+f+Vpp+hFZuO5A8PcjtYTra1l6tBie93u1LEN/tvJEqoFNvmefuVfMsptrDYW1UMdiXWd2duV3ShTId6L+qPDZZxyg5qNO3XAWNzN1Nl5Z12BU6OTYLhtNIIESanHu9ATfcXwDyRdIhPercRWVf262CujTnhaUSfH02VcxJLNWZGCNDUkk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTU1NjdseUt0SDRJSk91TWVlTHJ5TjRtUVFyazFoVGVvVU43MTRWOTMxZTBX?=
 =?utf-8?B?akllZlFYK1VrMXNlWlV0dy9SVnZCd0JWTXBSMldjTi9NajljdElsWmxJRFd4?=
 =?utf-8?B?WUxVTGNHSEd2L1RveS9PekkzbzhqWm5uWjl5MVhVN3RUR0F3Y2FsZTB5M3Yz?=
 =?utf-8?B?QXFySUdIdlNqMVhXcVNSWDFwbDh2L2JnWkNERTI3WDRYQXlJdzZ4bUN0bFVn?=
 =?utf-8?B?ZDZlMkJoMEZPS2NkMDhoYktKenpTQnFpUVpOZXEzTXZyaFZvR2xtSnhFZ0ls?=
 =?utf-8?B?U0FOajdCOHZWaFVJMDZKdnJNbU9DM3U0WSs2c0ZRamVWS1hOb3EyNFN5eC9Y?=
 =?utf-8?B?MUMvekNQbkRsbmd5K1VyWUtuWHdJS2NxTFdqeHNlZVRVc0E1TWpDU05YZ0pQ?=
 =?utf-8?B?YUxyZmZpd28ydlBiVC9hOVNXcGxFSEZmL3dZblVzOWtVcXZKVW40OXFyK2pY?=
 =?utf-8?B?MzhYYlJ0OUNuTUFQR3RCMHJRRjJGMDhtaWtqLzgrM0FrYVFxcEV3b2JhT3kx?=
 =?utf-8?B?UE4wZ1U2bUVvRFBhd0l0Z0xqekNUSDZuTVZDQStNeEU3SmJpNkNZY3hWWWRw?=
 =?utf-8?B?Wm1WMmt3cEN6d0duWHJXcm9zTk9ScWpwL09jakVDMzR0djQ1OGtQenJqd245?=
 =?utf-8?B?dEMwYWM0b0s5MC83NmRKK3pWMmZ4MlVua0lOTGcvdmxrUlk0aFRaUXZDUGho?=
 =?utf-8?B?QlEwaE91UEcrVHphKzFkNWpOV3pQRDgrM1lOc0tTTlBuSlYvOU95WWNLeFVX?=
 =?utf-8?B?Y044WmlFdkdCZm5hRDlpVm1PVGRZbmdxUm9HT0JjNzQvM3ZaTnlDeFdNd0xl?=
 =?utf-8?B?VERtSXNVMTY1ZmpkUGlPYUZnOWE3bm51T3dIV25WcDg4ZTJuMnh3bGJuaVVz?=
 =?utf-8?B?c250ekpHTGp1TUpRemxqSzhmTkJQWUZVS2VYMnJoZS9GNS8zQU5vMUlJakh3?=
 =?utf-8?B?aytzUjJCajJJdDhkRko3MVh3QkwvWVlTN2hNNmlieDBkSEpJL2hRUGVnWVBq?=
 =?utf-8?B?WUE5dU1VMmRMbnlxRHc2VUcrcHhuN3lRaS9mZmcxK1gxRmYrYVlzWW9Da3pv?=
 =?utf-8?B?WUl5VlUwZFQvTXl1cjVIMXgwZ0daalpIbkxxbVJBSkpPNWhSb0hpMkxDbG5i?=
 =?utf-8?B?QkV5bWFmL1ZGOWNlZGkyYUVHWVR1ZkJvbTRYRVhtNlBuNVlnNys5ZGF1S3pI?=
 =?utf-8?B?aXB5VkZlNkk5N1U2TjN4b1Q1cnRMSitaNHJmdG9nUVI2Z3NHS3h3c2E2Vi8v?=
 =?utf-8?B?NVNBMzVidElMbHB1eUEwYklPUk9qa1BBWDE1QzhyUUlkMmdUekk1Tlh1WWQv?=
 =?utf-8?B?N0dqNlRObHUrNENUdkU4Y1RSbEV6WXZIMTZSelMwM3ZEcVcvUFVZQzdidWFI?=
 =?utf-8?B?TVFlaXdkZzhDZXVaNG5Ja3dGUUZCU1BJSTBRQU1BZzJxdDJoZUF6YUFDeFpQ?=
 =?utf-8?B?RUNpNXRJc2VMZW1QVHhMY0pzb1pGOWIySWFsS2JWUUF5TjNvaHVTclYyWFVy?=
 =?utf-8?B?amxKMFNRVytmNVZ1VEcyNHV0YkRldE9DdmdyUlFsRE9qakhYUjRCUmx2cWhU?=
 =?utf-8?B?VzlTZ0dsRTBnS2JTL3M2U0l2NVJEVEttSHVvMUFnYTFsY0pSVmg1RHU1TU9V?=
 =?utf-8?B?cGVsdVJQQW1BMUpYWkoxL1RaemVZUyt1MktRMVNoc200ZWZITDlZMUg3UHhO?=
 =?utf-8?B?cHBYT0FaTEJLZ281LyszVzlvcnk0a3N1TUhVaURxV1RINkhLUnVTRm1mUTBM?=
 =?utf-8?B?RUlpSHk2b0x5SHB4K0lMWlIrTllONXdIS2xRV2J1dTFJTm9TTWdJMm15aXNT?=
 =?utf-8?B?RUpnaHNwVy9CcDJUQ2U0R2VzMHZ1eGNQU0FXWkxkODJBaXZPQyt4NEw4TFhn?=
 =?utf-8?B?eW9aUlBBNlpVRzdUb0VneGVFNVhjQUdGRkN1Qyszd2ppZVNYMG1oNEs4cnRK?=
 =?utf-8?B?S05ycFM4L0ZIMWg5MEQvcTlxQVFhcmRNa0JTTmV5Q0JFR1NQRlZRUHNoNDBK?=
 =?utf-8?B?Nk1pYldEbmd5WGZsY0hodi9EL2llWUdBZnZUVm1GOHV1SVlMUUIrNG9uMUVm?=
 =?utf-8?B?bFhpYjFCOGNmSS9qZVY2ZmN2QU1lSDFlZGJzdnYzdnJGeFIzTFVKb0dTTWNt?=
 =?utf-8?B?VWxlbWNTZ1ZWNS9CcFp5dXJNYzc0SWdJTVlmZkxSTDg4cW9jNWp5V3ZCUkV4?=
 =?utf-8?B?Q0VUMGRJZkIzVXgrQVhqL3NtYWpmbGJwSnFtYmFkbVgybmhWeGsyUGdrZFhU?=
 =?utf-8?B?VnB2SkNhYnJQcVJEcXdNUkF1RDJ2cmdUalM0a0FJZ3dHWWkra1FaWGE2aXA4?=
 =?utf-8?B?Q3gxTkU3cGx2Vm5kOEhRL1R5QUtKcXE0dUNXN3hJOWxIekE0R2FSRW80anlv?=
 =?utf-8?Q?LT4j/Ul/em76xFnA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028b01e6-6fe6-431a-fa2f-08df0ce4746c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 13:32:25.7607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWMmhne5I2r2KBJ3J1cilpFmLnPKfj0bFvElohV6imFvK/DNN/cTS6Zst9F+cSXeuWUwDQn1EupqBY78aOFXDOyVzdC3QIChfw9g96ET4EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11190

On 9/7/2026 2:12 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Scheduling while atomic BUG on PREEMPT_RT and high preemption latency due to wrapping hardware drain loop in get_cpu_ptr().
> - [High] Lockless list corruption and smp_processor_id() BUG on PREEMPT_RT due to preemptible use of this_cpu_ptr() and splice in can_rx_offload_irq_finish().
> --
> 
> commit c8905dbba299961e2728d05040d60499542251c0
> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> can: rx-offload: make skb_irq_queue per-CPU
> 
> This commit makes skb_irq_queue per-CPU to prevent concurrent list
> corruption when multiple IRQ lines are affined to different CPUs. It
> uses get_cpu_ptr() during enqueue to disable preemption, and splices
> the queues in the IRQ finish handlers.
> 
>> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
>> index 46e7b6db4a1ef..7616a16d90497 100644
>> --- a/drivers/net/can/dev/rx-offload.c
>> +++ b/drivers/net/can/dev/rx-offload.c
> [ ... ]
>> @@ -175,9 +176,18 @@ can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
>>   int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
>>   					 u64 pending)
>>   {
>> +	struct sk_buff_head *irq_queue;
>>   	unsigned int i;
>>   	int received = 0;
>>   
>> +	/*
>> +	 * get_cpu_ptr() disables preemption so that the lockless
>> +	 * __skb_queue_*() below operate on the current CPU's queue without
>> +	 * racing a migration. This also keeps this_cpu_ptr() valid when a
>> +	 * driver enqueues from a preemptible (threaded IRQ) context.
>> +	 */
>> +	irq_queue = get_cpu_ptr(offload->skb_irq_queue);
>> +
>>   	for (i = offload->mb_first;
>>   	     can_rx_offload_le(offload, i, offload->mb_last);
>>   	     can_rx_offload_inc(offload, &i)) {
>> @@ -190,20 +200,25 @@ int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
>>   		if (IS_ERR_OR_NULL(skb))
>>   			continue;
>>   
> 
> [Severity: High]
> Does wrapping this entire hardware drain loop in get_cpu_ptr() cause a
> "scheduling while atomic" BUG on PREEMPT_RT?
> 
> Inside the loop in drivers/net/can/dev/rx-offload.c,
> can_rx_offload_offload_one() allocates memory. On PREEMPT_RT, GFP_ATOMIC
> allocations acquire a local_lock, which maps to an rt_mutex and can sleep.
> Acquiring a sleeping lock while preemption is explicitly disabled by
> get_cpu_ptr() triggers the BUG splat, and can also cause significant preemption
> latency spikes on non-RT systems.
> 
> Could get_cpu_ptr() be pushed down into the loop to strictly guard only the
> lockless __skb_queue_add_sort() operation, similar to how it was correctly
> done in can_rx_offload_queue_timestamp()?
> 
>> -		__skb_queue_add_sort(&offload->skb_irq_queue, skb,
>> +		__skb_queue_add_sort(irq_queue, skb,
>>   				     can_rx_offload_compare);
>>   		received++;
>>   	}
>>   
>> +	put_cpu_ptr(offload->skb_irq_queue);
>> +
>>   	return received;
>>   }
>>   EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_timestamp);
>>   
>>   int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
>>   {
>> +	struct sk_buff_head *irq_queue;
>>   	struct sk_buff *skb;
>>   	int received = 0;
>>   
>> +	irq_queue = get_cpu_ptr(offload->skb_irq_queue);
>> +
>>   	while (1) {
>>   		skb = can_rx_offload_offload_one(offload, 0);
> 
> [Severity: High]
> Does this unbounded read loop have the same "scheduling while atomic" issue
> on PREEMPT_RT as in can_rx_offload_irq_offload_timestamp()?
> 
> By calling get_cpu_ptr() outside the while loop, preemption is disabled across
> all memory allocations in can_rx_offload_offload_one() here as well.
> 
> [ ... ]
>> @@ -307,14 +330,15 @@ EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_tail);
>>   
>>   void can_rx_offload_irq_finish(struct can_rx_offload *offload)
>>   {
>> +	struct sk_buff_head *irq_queue = this_cpu_ptr(offload->skb_irq_queue);
> 
> [Severity: High]
> Does calling this_cpu_ptr() here in a preemptible context trigger a
> "using smp_processor_id() in preemptible" BUG on PREEMPT_RT?
> 
> On PREEMPT_RT, standard hardware IRQ handlers like flexcan_irq execute as
> preemptible IRQ threads. Because preemption is not disabled here, calling
> this_cpu_ptr() is unsafe.
> 
>>   	unsigned long flags;
>>   	int queue_len;
>>   
>> -	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
>> +	if (skb_queue_empty_lockless(irq_queue))
>>   		return;
>>   
>>   	spin_lock_irqsave(&offload->skb_queue.lock, flags);
>> -	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue);
>> +	skb_queue_splice_tail_init(irq_queue, &offload->skb_queue);
> 
> [Severity: High]
> Can another IRQ thread preempt this list splice and corrupt the list?
> 
> Since preemption is not disabled in this function (and spin_lock_irqsave
> only disables migration on RT, not preemption), a higher-priority IRQ
> thread on a multi-IRQ controller (like FlexCAN on S32G2) could preempt
> the lower-priority one during this skb_queue_splice_tail_init() splice.
> 
> If the preempting thread then calls can_rx_offload_irq_offload_timestamp(),
> it will explicitly disable preemption and push to the exact same CPU's
> irq_queue, concurrently modifying the lockless list.
> 

This review around PREEMPT_RT seems valid and I could switch the
'per_CPU' approach to a dedicated spinlock on the skb queue operations.
But I will await more review on this patchset.

Regards,
Ciprian

