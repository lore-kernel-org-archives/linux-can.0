Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB942C4F0
	for <linux-can@vger.kernel.org>; Tue,  1 Sep 2026 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248540; cv=fail; b=JZLEUvs82SeZXlU5J8UDCkVO0wap/0BM978QbRo5hVrRjwM874cc5UukNTrJ7cgdh3GlMnsrgNCi62jtMQeN3r4EpcTJISaiT9BbWTJ3zqe5tWXgJlRNT0xJphF/tnl3QE0U6OqkuNUq5+XP4rl/8pTQETYOqzNo0Xxzl4FcKds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248540; c=relaxed/simple;
	bh=j3kKrjHRUUAB8fjA+bER2J882J3a5ZcJpLufSTGsTL0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tHDCv5FMFROOraiYYQLgpClQv687ObQ5hQcfXLYtCWHCT2nCCOzoGo912nRo0k2XvjWz7UEP4MBQLlk0YiLrQzzBa1WRkNkPIiMZ10c435KlRVmhCR2iUUgf6a/yRQQaYmKlLeoUXXlJX2RKJn5IaV/dS209qIbn99bBDssI0FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XgGrr/v4; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XgGrr/v4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAA2/IJYFOe9KzhDwxyAH+TgSfweab4ldbH5vR5QL2N55wwwzDCViljt77gZRkBAhlXh/qn6ZWs3KPkiaE1bY3WnEPYzlXJVKqcTRUXuXRLs4dGUCFHBZ78DE89JGC5fpWI5tJOnkBdNbIS7hhJ0/7PVV++jhmF/kWxZh7fksd42nCfSRCrGM4c7I0eKAmcO2m3qyKIgqTomLcg5Zde5txeYwGnxDKsiTa1/ACSO532Qd0LEBBvgl/Y+5PCbufc6D4q0kcWa+Ls5p6lqtbfEmqDwPS9bBPNzN6zKDGVfkounEdV5D3GIOdU/9aFGF5OmBP+Ax2GkkRgVKl9EEgknfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJAthXiiUY3uP6/D3FqS4p7rR2NTqkR8xM0DM0NnQ7Q=;
 b=BP660s3N5O0oi+GEhJHC8Na8z9qdaaXa+xSTdiDBbX7bX09VljtRQ6+MtzW3hUOMX4GC/2+Lr55EVGzs44jVBLbkRBAkaKOzy3DokkLJR1UtqJRTew2/1tvI91XuxwrNtNC0PQfZWDQf3LS92ucvmUxP5zx4OSW3CPGHYj1CpprIS+i8zGBKhlE4GwITu7FuvbyWY10C1Gui9fBbr2PrEBntnfM4W+W7/Ek7sISp6SOXH0cbDxIKP1jE1gZj3LIep5SX2/H9WhLQn/UDDQhzG5ELxzKPZwdH+gxlx1jwnYGUzg+nQ6w26ggwdksutb16eMDAcLNpxgTE+Pf0w0aJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJAthXiiUY3uP6/D3FqS4p7rR2NTqkR8xM0DM0NnQ7Q=;
 b=XgGrr/v40OcNNHSVzkqQA83fUtKfuatVw/6deyeOkLvypxEpRGE3bjwYzTFE66ydv/KG2t6OTtIX5hCjGDgX+OyR7czJ/8EpLyfKbTw7WJPm5llWJVsC/olXVifb/4hfvusSnqGeMcs7EYgq725MqSIAsSKzStqudWfqRnybVUMSrPmhx5rB1ZHFThZ9WQwdLiNsTeKft4/Ol+1/OTEJ675mh6t/UT56ivyO1nUik9E2+llg6Km+NhKQvr9RCfSb7dDyxJLccFKgWAkwrqZsmbcDFs4CrAej2hqGXyBnvgGwsn7td3XchKYWMfrOo+9+hjbLr3cw2ldM0Go81bj2tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AM9PR04MB9015.eurprd04.prod.outlook.com (2603:10a6:20b:40b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 07:42:11 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 07:42:11 +0000
Message-ID: <84fde41f-ec80-464d-bb87-783386839b07@oss.nxp.com>
Date: Tue, 1 Sep 2026 10:42:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: rx-offload: make skb_irq_queue per-CPU
To: sashiko-reviews@lists.linux.dev
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 imx@lists.linux.dev, Marc Kleine-Budde <mkl@pengutronix.de>,
 Frank.Li@kernel.org, s32@nxp.com
References: <20260831142819.9318-1-ciprianmarian.costea@oss.nxp.com>
 <20260831175801.C90141F000E9@smtp.kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260831175801.C90141F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::7) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AM9PR04MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f4f7f8-b1d6-4c67-4548-08df07fc8840
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|19092799006|1800799024|366016|10067099003|4143699003|6133799003|11063799006|5023799004|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	K6LoeYCu9F+RW/jE23pA5Ktfwnap5QivHgnJ+oyN9C+68mKr7zcDB+YAE2lEoR7hPl+qKii3JmBEM3D9u7Fehy8E/PkPNFPkkeb9Ur/1cFLHZndlQ1VTau0hYWJPyHnPr//Eoq4pclAVakCcxyEFbyR9mZMEfOTWMMN5dfoxQQpJrGbFE6+HxPUBBWij6l9v/srxbLF2JCOvSrbsXHK92nK+hlsjWlk3FCh1IqS5ilgVC9iv8S9LXxYfgTEfmw6JxBsQPLYF02cr8LcnMV65zK9m479qlH8JFykfjBLDGjwLjs8T5KGRSlw2+luPhkn6KRGMBCCp5BpJ18vQ08/W4XynwJQ5h4HPhvARrnN4tuUjMAbhl7mxD0Nf9sUY9nu47SxOZKQV1q6jJ6s21q2KN/lHlZHVr9X/xYNB8+tU8CxQtoasljMaKy4AO6PXwTtiCGlYLhZjzrITMxwSpHocbygDlH4EPiGbAbrCDQGGV0zdLf479HFFZs4y1xLY7gPCXI+9QPSAenOM0/US9rbrAkvnSi68cZ7Qmv5mS1UB3LhRCOykzC6rEpWbwnmf0jaPLMDDZStOaHgyliUXfuE5cK5H9JYnZzhDBQnL1ZtrcLQDi7dOEQV4LxcvtlWaFtCK2t3Ij9yMH9U4Xx/5Aq3rAg8VmjPhVnM/Jz6BoGQSZpk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(10067099003)(4143699003)(6133799003)(11063799006)(5023799004)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXYvbE5nNGpHcXd6eENqbTNSN0RRTTJOSkhyUWd3dS9HYmhXc2FIVmhvaDNy?=
 =?utf-8?B?aHRHTXBqcUNuaTIxaW80KzAzYlRTd1N6MnJqOUZ4cXlicnlaUG5CenMvbTdw?=
 =?utf-8?B?dGMvNmdXODkrVFZpWHJmeW1Ub1V6RVVuMkNXM1ZpeDFKb1hneGZUN2JMTkVZ?=
 =?utf-8?B?d0lHVVI2MXpXWTFVNjNRdjkzSmdwZjF3OFhYNFZzaCtwR2lRQ0Q0NmI3OHBp?=
 =?utf-8?B?VWZReUdGVkdaR29obnJITWsvVTFIMU9Ld2MzL3ZqbkxkdTZraGJ5VXB0WE5w?=
 =?utf-8?B?QzhVV0J0Rk9Jd2J2NUdRTG9WY3FVZ3hNa1ErdjdjNUZhWExiMHc1UjFLeGJ3?=
 =?utf-8?B?SmZvcFNMeTJCM1JJN0JmWWd3MU1rNlR2UHpQekZXWGNHbjRYT0RUeGphdi8y?=
 =?utf-8?B?Z2tCMDdJcGxERC8ySlRMaXRYc3psaTdMQjFMamcrbTk0Yzk5dStwdndMdDlM?=
 =?utf-8?B?UlFtZi9GdGNIdmNEUThyeEZiaXF4V2xVeGx3VS9RU2k5WGFtL05XaDVMQk5H?=
 =?utf-8?B?TC96SEw4TDRxSWhsTEtXeXNKaGYxdUpidHFrY3dqVS9hbkxvVXEyTlRKMkFm?=
 =?utf-8?B?Qk5nd1J1TXNmRlkrak4vS3h4N1NxSWVzdTM3UWVDNjJQMy9jN3orMWhYY0hW?=
 =?utf-8?B?a2NVNVVsUFc0cnB6T3UvTXdSUDVjckpJbVlORktmRDRNUzc3U01jWFlOSld2?=
 =?utf-8?B?RU1LOGVDdDlnbnNqUE90ZGtSMGp5UTAwckh0STNRTjJEMC9ybHlvS3kvTjhn?=
 =?utf-8?B?YnV2NE1lZ1ZKRU5nRGVEK090czg5aVJkdXp6byt1VFQ5dUZzR3VzVTVubC9k?=
 =?utf-8?B?ZWMvZFEwdG5OR3hUR25JWURraGpwMFB3Z0N2Y1VEMlZJcEVDYTF1V2wybTk1?=
 =?utf-8?B?dGhUMnlpbUZLOG5MNXlTSTdxdTNqSWQ1S2dQRXVVZ0FCR1NjRkVpeWtFazMy?=
 =?utf-8?B?M2Fta3kxeDF0U2YwNGRBanpuS0daRXgwRFl5VHNBNDM5aWVMOE1IbFZSRjdV?=
 =?utf-8?B?a2F0ZWJNcWtZMVpCNks5c0h3YnJoMk1iaWVYRzBFdjltNjBENHk4YjFTeVRy?=
 =?utf-8?B?MXp2OUord0cyNUJKcG11RjFEeVVwY0xwSFY3aHpDVjVGYmN2M3AvaDQzZzFR?=
 =?utf-8?B?Z3drVmxmMVlJWjhzdjFPY2x6S0JkMlR0cFJaUExBc3ZsKzhPK0hPVTNvMEVP?=
 =?utf-8?B?cFByWHR6KzNFWFg4TXZvNzZmWXRQMWJWVWVqQzZIUExBMWpNMGVBR3pHODlx?=
 =?utf-8?B?RzBHSUt0aDlUWmZoQktibE9jZE1FdXdoRnFvcnF5UGNYYkxwL243dDROWEZk?=
 =?utf-8?B?WFdRMGJkLy9RMFZuQUdQY2ZFamIza010NXBuR21mMXk4VEY0U254WWRHM3No?=
 =?utf-8?B?VU1kbFd2OHdORHdhSjlGbEdvcEtSLzZkNnFDbmpXQzBYUlRheTZBbnNtcmE4?=
 =?utf-8?B?Y1YrVzZmOUNOWTRJbk5vSmdERXozd2xxV2xEVVFYWWdvaEkvVGZHUVhYOHVl?=
 =?utf-8?B?VU5iN2piM281QVNKeG1PY1lUL1djNHNxNDRzMW16cXB1a3IwOE1aU3NBcUIz?=
 =?utf-8?B?K3J0NzN6MDA0eFVtRVRQOHZ6Q2RsVkZSOVc3d05SRzZEM1VNK0pWc1BlZ0p6?=
 =?utf-8?B?N3VFMy8zcGtpeE0wSUZoUVdvUk95UXdwRlhORHZ1OE1LRUJ1THREQ0JvVGFl?=
 =?utf-8?B?NW5Dc2pXcFB2K0tNYW1uV2FkK3cvYmRJbGticG5VanlNbEwyVnZ3NGxYR3E0?=
 =?utf-8?B?ZmhibG9zZlhhTzJvTnkrZ1hXVTVkNkY0NURvWEVpZEw4c2xoUWhpTHBNa0di?=
 =?utf-8?B?RU5XYXdHREtZWWtiQzdSS1BBeW1PWlR0T0YrVnBtWkJFdTdRRVFmMnkrblhI?=
 =?utf-8?B?VGltbE9xU1ZJQURlL29zSjg1NERaWjBpN2h3M0V4UGlRL0FkUXZvQmZWYTJ6?=
 =?utf-8?B?RzFFWGxuNFJOcmpSM1pHZU1CRGl6MElTd1ZMaDlLWXI3dVdjL3hIOUdVcU1B?=
 =?utf-8?B?YnZxbHkveFpZOWY1eDFZY3FSWGZzVDYxY3ZkOGk0bHhHdTg1MmlmQUExSnRz?=
 =?utf-8?B?azkxSWlSQXJYSmxFRFFaQUZyNGR3UXpIK2h2S1plb01JMmV0Lzk4ekpnd1M3?=
 =?utf-8?B?NnViVEwvWExpWjlTL0RxZ3ZCdW5qK2kwWWJLN2huN3VGQlpHelVLQmdNVjBT?=
 =?utf-8?B?ZFVHamVnM3lYblg0bFdYQ2RGQnNsNnhySmFrS1U0TlFoRXlJRnlmYmpNRE9l?=
 =?utf-8?B?Q2lPNzh5TVd2UmVwYWNOMHlkaU1xWG9kOUY5SmhZb3FicGNRRXZWekFJZ1ZV?=
 =?utf-8?B?bWorU01rVlVrSUtpV0pwT0FjTklxOVU2R0xwbEovSFlydkxWcGYzWU9aMlVR?=
 =?utf-8?Q?0lvRa1gpkN6ftWRw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f4f7f8-b1d6-4c67-4548-08df07fc8840
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:42:11.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C65gg80R3X4rr2wvRZqkD2Jcbz04w5NCjd23+i9lvZr51ZUFq/HRFJjcBI5/L+H007VqQayx8se3DXAGsTdGhMiOiASdhHictwi6A28aODs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9015

On 8/31/2026 8:58 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Per-CPU splicing destroys strict CAN frame timestamp ordering, causing out-of-order delivery.
> - [High] Unsafe use of this_cpu_ptr() in preemptible threaded IRQ context triggers smp_processor_id() warnings.
> - [High] Crash in can_rx_offload_del() due to unchecked dynamic per-CPU allocation failure.
> - [High] Lockless cross-CPU list manipulation in can_rx_offload_threaded_irq_finish() races with hard IRQ handlers.
> - [Medium] Memory leak in at91_can driver due to missing can_rx_offload_del() call.
> --
> 
> commit 65bff5b50e9fe16e30c0b8850186d29135b0b545
> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Subject: can: rx-offload: make skb_irq_queue per-CPU
> 
> This patch changes the skb_irq_queue from a single lockless list to a
> per-CPU list to avoid corruption when multiple mailbox IRQ lines are affined
> to different CPUs. The queues are now enqueued via this_cpu_ptr() and
> spliced together in the IRQ finish handlers.
> 
>> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
>> index 46e7b6db4a1ef..48d814664b3d1 100644
>> --- a/drivers/net/can/dev/rx-offload.c
>> +++ b/drivers/net/can/dev/rx-offload.c
> [ ... ]
>> @@ -222,6 +225,7 @@ EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_fifo);
>>   int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
>>   				   struct sk_buff *skb, u32 timestamp)
>>   {
>> +	struct sk_buff_head *irq_queue = this_cpu_ptr(offload->skb_irq_queue);
> 
> [Severity: High]
> Is it safe to use this_cpu_ptr() here?
> 
> If a driver utilizes threaded IRQs (such as mcp251xfd), it can invoke offload
> enqueue helpers from a preemptible context. Wouldn't obtaining a per-CPU
> pointer without first disabling preemption trigger a
> BUG: using smp_processor_id() in preemptible warning?
> 
> Could this also cause lockless list corruption if the kernel thread migrates
> to another CPU mid-enqueue?

Good finding. Will fix in V2 by converting all enqueue helpers to use
get_cpu_ptr()/put_cpu_ptr().

> 
> [ ... ]
>> @@ -268,13 +272,15 @@ EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_timestamp);
>>   int can_rx_offload_queue_tail(struct can_rx_offload *offload,
>>   			      struct sk_buff *skb)
>>   {
>> +	struct sk_buff_head *irq_queue = this_cpu_ptr(offload->skb_irq_queue);
> 
> [Severity: High]
> This appears to be another helper used by drivers from potentially preemptible
> contexts, and it might have the same this_cpu_ptr() issue as above.

Will fix in V2 by converting all enqueue helpers to use
get_cpu_ptr()/put_cpu_ptr().

> 
> [ ... ]
>> @@ -330,15 +337,21 @@ void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
>>   {
>>   	unsigned long flags;
>>   	int queue_len;
>> -
>> -	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
>> -		return;
>> +	int cpu;
>>   
>>   	spin_lock_irqsave(&offload->skb_queue.lock, flags);
>> -	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue);
>> +	for_each_possible_cpu(cpu) {
>> +		struct sk_buff_head *irq_queue;
>> +
>> +		irq_queue = per_cpu_ptr(offload->skb_irq_queue, cpu);
>> +		skb_queue_splice_tail_init(irq_queue, &offload->skb_queue);
> 
> [Severity: High]
> Does this per-CPU splicing destroy strict CAN frame timestamp ordering?
> 
> The commit message states "Cross-line frames are now sorted by timestamp only
> within a CPU's queue and appended across CPUs on splice". By blindly
> concatenating per-CPU queues in numerical CPU order without merging by
> timestamp, doesn't this result in out-of-order delivery of CAN frames to the
> network stack for devices receiving frames concurrently on different CPUs?
> 
> Could this break chronological CAN bus protocol guarantees?

AFAIK, SocketCAN does not guarantee chronological order. I could do a
cross-CPU merge sort but I do not find it necessary at this point.

> 
> [Severity: High]
> Additionally, can this cross-CPU list manipulation race with hard IRQ handlers?
> 
> Here, the threaded IRQ handler iterates over all CPUs and accesses another
> CPU's lockless list (irq_queue) without cross-CPU synchronization. If a device
> has multiple IRQ lines affined to different CPUs, a hard IRQ handler on
> another CPU could concurrently locklessly enqueue into its list via
> __skb_queue_add_sort().
> 
> Couldn't this concurrent modification cause severe list corruption?
> 

Currently, drivers which use 'can_rx_offload_threaded_irq_finish' are
all single irq. Multi irq drivers use the non-threaded finish variant.
Will add a comment documenting this in V2.

> [ ... ]
>> @@ -353,13 +366,21 @@ static int can_rx_offload_init_queue(struct net_device *dev,
>>   				     struct can_rx_offload *offload,
>>   				     unsigned int weight)
>>   {
>> +	int cpu;
>> +
>>   	offload->dev = dev;
>>   
>>   	/* Limit queue len to 4x the weight (rounded to next power of two) */
>>   	offload->skb_queue_len_max = 2 << fls(weight);
>>   	offload->skb_queue_len_max *= 4;
>>   	skb_queue_head_init(&offload->skb_queue);
>> -	__skb_queue_head_init(&offload->skb_irq_queue);
>> +
>> +	offload->skb_irq_queue = alloc_percpu(struct sk_buff_head);
>> +	if (!offload->skb_irq_queue)
>> +		return -ENOMEM;
> 
> [Severity: Medium]
> Will this new dynamic allocation cause memory leaks in drivers that don't call
> can_rx_offload_del()?
> 
> For example, the at91_can driver calls can_rx_offload_add_timestamp() during
> probe but misses the matching can_rx_offload_del() call in its teardown path
> (at91_can_remove). Before this patch, the omission was benign, but won't this
> now unconditionally leak per-CPU memory upon device unbind, module removal, or
> probe failure?

Will fix in 'at91_can_remove' in a new patch in V2 in this
series.

> 
> [ ... ]
>> @@ -420,8 +441,14 @@ EXPORT_SYMBOL_GPL(can_rx_offload_enable);
>>   
>>   void can_rx_offload_del(struct can_rx_offload *offload)
>>   {
>> +	int cpu;
>> +
>>   	netif_napi_del(&offload->napi);
>>   	skb_queue_purge(&offload->skb_queue);
>> -	__skb_queue_purge(&offload->skb_irq_queue);
>> +
>> +	for_each_possible_cpu(cpu)
>> +		__skb_queue_purge(per_cpu_ptr(offload->skb_irq_queue, cpu));
> 
> [Severity: High]
> Can this cause a kernel panic if the dynamic allocation fails?
> 
> If alloc_percpu() fails in can_rx_offload_init_queue(), offload->skb_irq_queue
> will be NULL. If a driver ignores the return value (like gs_usb), or during a
> probe failure rollback, can_rx_offload_del() will unconditionally call
> per_cpu_ptr(NULL, cpu).
> 
> Wouldn't passing this pointer to __skb_queue_purge() blindly overwrite
> unrelated per-CPU memory?
> 

Good finding. Will fix in V2.

Ciprian

>> +
>> +	free_percpu(offload->skb_irq_queue);
>>   }
> 

