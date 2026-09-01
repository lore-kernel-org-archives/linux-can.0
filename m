Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9232E2852
	for <linux-can@vger.kernel.org>; Tue,  1 Sep 2026 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262217; cv=fail; b=kd21azrCEBBMbz0U6EelfViM1dpmDGNZqAknhgWSz5J7o3W6ImWNnhbDAVMLBZ6puRus14EjFYewHCk53Pf5hwrIgYEjob8SA3gFUJLyEUnRpfJmBgAdPZRHtS+SvXXvZLeu4BJzunVmt577ePnrd1nKpssxgGFpud0gmxqWREk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262217; c=relaxed/simple;
	bh=bXmO84hYFkjo11kCk6LvhyruOWZ0p1ZSwb9pdtO9g6g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uiJJCCOdinuRmFPOs5lLnEP57Ob4qibaUSfr6JPBOdPM9xRnjN2XP0+Jb8gEkXfKLTLnRjC8bt58rfHqeLcnjAV56v7kypNmSa4adAgzoXaQSv91uiCiVqqkPp/q23mKE68I9Ded4d5pDZ2ZBYyY4jUeel4D3kLNf8Mhgl0blr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QYvr0eUG; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QYvr0eUG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkrc8IoTDRk0iOCBs3l4rqy6LbCCvaX3dam0fHdwAai/MNXppvLPhXUjGSBGcIcW3633jUJw4P7/K+/X2h4kivxg2z8qrPrMr8EFTJhhUB8yGlR2e38HvcKKTQ3EHEkUJQwUthVg4fooPzF261a6SKpRaS6R78lycilzw8dzUg7X6HwQmOtKE8yRohmmTIowoQ8weCn6FD/P3q2BnN3Z+hc6EYVyH3UsD2658Wc2FydUUFPr0MM7uBrAAqmYSltYB1mwA1VDArRzuQ3Cwljp4XDVU5Cm4ccpTb1j5I6DbCmIFV4dGzbzgTnJQTxOWqYaZhm6Qh/VWat7HuciwjDJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26uh1SewvnHdm+6LHFv/flnxhMim2m02FHEDIfHVPKI=;
 b=V2xXSrqt1emoaSMPB95FUxwWYO1iY/O+bTmf+2654RG/sgN54+cuAKlZOpfuSbHDKr+Wz5sscEgEKaaYj79KZsTJc9UYAajqioUWyzXYJ0YL6CM+J8HP/ur3zSVIbs6PevQDrQQYSzhmPTlZLvO/rXNDrWdccpmQ4F4lgcADw5qVBQMvPrys6cX6SguyLuTp4de06HOyQwBrv3Ab1pBkG8vaNI6F85mj1fK37VynVNhWg5l8Bu7N2XMtpMGTq2VkK0ocSBjvXIIwnClp3yIS38xYyb+qHXEUl8qjmmwF5WFAMYH8eLOPaev2fqjo8XL7jsC3kWtCIJEZbOCm2/3TgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26uh1SewvnHdm+6LHFv/flnxhMim2m02FHEDIfHVPKI=;
 b=QYvr0eUG9y6/yjtUtSOwJH/TS9/x9hVtBZgM7QYCWZvnzaeOweb1QWG0PJRIgLkz1mwEfoFSsStKDgT8cB6gTk/vqJjNQ2KMZfIdaq/sXnwc8IsGoOQQXmEDu+6h3WrG7deeeitHb2Zl9/a4CtO/fsPiEBYcHACWf5r9Yw4LxnsDmwKRxvskuRdP5Uq/1m5V0IRqFF8LueooawiC3SkoY+SVJ3hSqY1t08a1Q+7j7shWiIZciFgVXXlGHQIIenwqL0k/bnTavSZXoxdiTDL/KJFp/3KxrLeRjxcQoVHHrKNVyDx0bHycM+2rKUJm+sr1I3EiPxisnprvJ8wIR3RgzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AS5PR04MB9874.eurprd04.prod.outlook.com (2603:10a6:20b:673::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 11:30:09 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 11:30:09 +0000
Message-ID: <801df0c8-472f-43ef-8a24-0b3c64bfea20@oss.nxp.com>
Date: Tue, 1 Sep 2026 14:30:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] can: rx-offload: make skb_irq_queue per-CPU
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org, imx@lists.linux.dev,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Frank.Li@kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, s32@nxp.com, imx@lists.linux.dev
References: <20260901104103.458619-1-ciprianmarian.costea@oss.nxp.com>
 <20260901104103.458619-2-ciprianmarian.costea@oss.nxp.com>
 <20260901105721.18EBD1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260901105721.18EBD1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AS5PR04MB9874:EE_
X-MS-Office365-Filtering-Correlation-Id: 6726feb5-9cd1-40d1-0b6a-08df081c60d8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|1800799024|376014|22082099003|18002099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	MochkJQGbX3Nh3xd+2W18juaIP3NaIxWgA+EvqlqbjtTEo8aoYlLYCUdaDM9I10tYSvpF70VgwLbx8fCiQnCCFlsikhUBJgyCJnBmDm2CgovTaK12sLz10CnQlBvpIgtg9sahOPQ+G3wDk164hczH2+QOfNT3E0zAFNeAp3MlciI9KFcY+wzD2/LIr3vSQhL/p6V0c/Fxr/IXkvS/77+GEDQ9Wotl5V/4i64a+xs9n7BtJgzB5r+ELd9GbMDGxqudppfXEa+RZn9byb2QbHyQKV8AvB8pWCuKekdxPBai+RT0Uq/tb4sHqeZr/l4C90omO41KE47SOm0Or87cMLXKfMiqjARauLAo3iKd9WrXclEBydikRNOHkJUpaNrxJfk+aATnMngp4nuPitrxasf6xxyZaxesdfiaWJeAsMeg9hE8B6/1il3NJcKyO1iAvH7ZEMtOrkTm2oFe8thSCHd+Z5ovcp4agXp7ocMjYfSG3kd+O4iccQHBynbtR7NIcoMt2Dv4GXyK69vvdCGNPFMGX1Nz+5ATtjJbuhGzGjtot73ZLTrT183kmXo6uo3joVKmJyLnODd3xNvexutmbn/UfA5MVoCza8d2aYadGhm9NbTuZvRTlqXFhWUFGd5ARjBmx4+GVLWDcakycYulJrIVE2yfHck4pPGMvz4+5XLBqU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2lKOTNFclRwZXNQSEdFdzlYMjkwTHd3WlpxWklleFVqKzV4d0twN3dBNXpY?=
 =?utf-8?B?K1FwTmlyZHoya2djOFdoSlpvVE5hRndIMHhXOW5aUUNneUV5a1g0MGJ5VS9F?=
 =?utf-8?B?OEJIejU1TDFGaHVldXhXN29NS3BVeTl0UlVBdUNVSHZheHlsTnhHZXI5L0x0?=
 =?utf-8?B?WC9wWmY2cm5aM1pMOEs1TTFrN2Z2c3BPQjIyY3FFVFcwd3BaZU1raWRwcW5I?=
 =?utf-8?B?b1hwV25IM2paMzVrMjZMMFNERGpPZmJsc0NlN0VCZnJvMzFPSFhyWU1EY3lz?=
 =?utf-8?B?RWVWQ002NkF5OUtoZHJKL2lwMytvUktNemsxYkZyYmFGYTBLUFpONDkrdzcv?=
 =?utf-8?B?OXFaSmppMS9ZbnFNS29WajBpd0hPelc3c1dNMFh4ZmpSY3FFTlY0RW56YWNw?=
 =?utf-8?B?Nkd4aG12Zm00dW1zbzRCNUkxT1JNL1ZVbGtTUzRzV3FOb3ZnSHhPaG5vc0Z4?=
 =?utf-8?B?U2J1OWtsMUoxaEZOQnVPbjVxaFE0Z1kvZlhqTk9BSXUyQjZNNzJKTENvZVVU?=
 =?utf-8?B?TStsdnN1bGplRHhWcWtCNUp0aGFTc3BBemhGY2dsU1RrRDVRVHBzMGhrd0sv?=
 =?utf-8?B?RVNXaEYzTmtJTUo5a0RodFJZVlJuVER0VmJMTzMzak13bnlzYWE1S05VeXhX?=
 =?utf-8?B?d3VFSXpGTTZSbzlQR1RyQmJTNzlGTG9Kdy9tRGZSRUN5V3BVY29MWmpLSHpW?=
 =?utf-8?B?bDRoUTE2dmw0Qit3UWNMWnplMDFabW5OQ1gxemxLNy8relhGcERUK3NId0RJ?=
 =?utf-8?B?WjhTTzZmVURkNHdIUkFJV3g1bnFHdXlpc2MxM2dEZlJyWTRRWXcrb2U1cCtL?=
 =?utf-8?B?VXhvVW9YSitJRTFWZzBLc2ZEL3ZBcWtwUVlIbkM5T0NnRHhhVlNUb21QZVgx?=
 =?utf-8?B?RFpKak5DUDJUUUR1bkVjdTUwN2t6NXNiUDhYQnBaN2t1Y1lmRS9KT2hmbmo2?=
 =?utf-8?B?SmEyOGNoSWJJaTZwa1lrYzZWOWRlZE1ESElveEc0S0NDTHRKR2J0MU5DTFNn?=
 =?utf-8?B?WnpGcXlCZVFNWG9tUXlIN0RqQXV1V2pDVnk2NE1SZk5nenVXV3RpNVNsbkNt?=
 =?utf-8?B?RXRwT240emprWlNKcFIzakM1K0VmUGtwZGN5L2Y2cFBNZmhrYkIyYlJPU3BG?=
 =?utf-8?B?bzlMeHM5RmZvbHZpZ01ua2dtK2hNYjk3bXc1TktGODlHNWdkNWdoaG1SNGdE?=
 =?utf-8?B?VkNUNVFWRUhmT2tjZGhmNFhYS2l1RWttVjZTMWlFMmFrWW1keTY5czFMSUZY?=
 =?utf-8?B?NnRtNC9DeVlaMXFNVnlEZkhLYWl3M01ldHAxUE4yeFNrYmNXNlhFTmRzYmFk?=
 =?utf-8?B?N1NuUHVUTkJYMWZmQ2pRVDgyRGpTVDBUVWcxdzRoZWhVa1J6U2JuZE9KeG9B?=
 =?utf-8?B?ZWFDWFI0WXlad3V3QVJ0MndKMS9nZUI1MXd2SkYyVjZxNFRoVjYzbFc5Tk5I?=
 =?utf-8?B?R2syV1hQNzl5S1paRUE1blZ2NHdyamFSOWdIMUF0TXp3WVBTUWcwaktPellq?=
 =?utf-8?B?eEo3ZjdsVXJ5dlUxQzQrNkpJWmxNajNqRGFmckVUREpoSUVTVVl6RHZScVJV?=
 =?utf-8?B?bnFYc2xNblpBNEdVeDNTcHRNcDhubjl4RXlTVk5SZUJURzB6TVdoalNrSUtK?=
 =?utf-8?B?bFpoZmlacXVscTlSVVJiUnRFUXp6Lzd0VHFseU9aYUcrb0x0NC9UcktaRzlK?=
 =?utf-8?B?NEwxdi90ZHJ5OExIajFKQXBvYXdiQVpneDVhUFVaSWxSenhsUm5iRnBsVnNY?=
 =?utf-8?B?UksyOXJmbUlHVy81S3ZvdkE1Tmlsb09UaVAyZmI2bzBRRUJJa1h2VEp2UURU?=
 =?utf-8?B?WkdyRjNhcUJWNjg4VmcvNTRUWVZKQ0l1MmhqZThSOXlzcHJNYWJaNTlGcmM2?=
 =?utf-8?B?Nkh2YVRwejV3YW85Ky9DeTM2cEw1ZUVYTkVpKzJyVnZ0R1ROMjA3a29MQmkx?=
 =?utf-8?B?RHJ6Z0lQYUcwNEdhVG9vTlZHWnZFREJ3dEh0L1lIa2R6RXBGNC9sVWY2SFFo?=
 =?utf-8?B?Y0R5bFBSNUV6YjJyY2FnaFZZd1hmSkMxTXc0b2FuYjlpZ2RIa0tEZnh0THcz?=
 =?utf-8?B?UnRtOGlyRHU0SEdMSitSSmxyemZZSFpFK2NSUGJRNkhRdjF1SEMwM2NsM1VT?=
 =?utf-8?B?NG9NdnFQQXBTRnJnNUVRM1lGMXFiRU9id0luWk41a1UwNG5qRGlTYUlzZFQ1?=
 =?utf-8?B?NEZMakJsMkZTL1UwdzZhTkNscjhicXg2T1RhdWRZbHhQd1NZVUsvZUE1elFL?=
 =?utf-8?B?RDVZOTNhY2w3djZCdVRCbGlpU2V2NVZwSnJmSWNhcGh3WDR0MlhDNHZ0NXNu?=
 =?utf-8?B?VG91VU0vTmlmK0J1K0FMWjBuZjV0c3d1blpIeU9qZG0ySWV3UWpDSHRYcm9M?=
 =?utf-8?Q?h9pVQBWBtS9YYY1M=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6726feb5-9cd1-40d1-0b6a-08df081c60d8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:30:09.2404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnYyNdj298vW7TmgDjgISRoxMu9l32vdToeNQP8xra1yqIMBwQYomfXB8braJfQmd3jHWs/Ikzo/TQ0ZEICaS9F+fEZ3x0N+X9k6HHx524U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9874

On 9/1/2026 1:57 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Ignoring the return value of can_rx_offload_add_manual() leads to a kernel panic in gs_usb if per-CPU allocation fails.
> --
> 
> commit d8e59325c82aef9b3489bcce81a1a5ee64835783
> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> can: rx-offload: make skb_irq_queue per-CPU
> 
> This patch converts skb_irq_queue to a per-CPU allocation to fix concurrent
> list enqueueing issues on platforms with multiple mailboxes affined to
> different CPUs.
> 
>> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
>> index 46e7b6db4a1ef..649bfda08b654 100644
>> --- a/drivers/net/can/dev/rx-offload.c
>> +++ b/drivers/net/can/dev/rx-offload.c
> [ ... ]
>> @@ -353,13 +391,21 @@ static int can_rx_offload_init_queue(struct net_device *dev,
>>   				     struct can_rx_offload *offload,
>>   				     unsigned int weight)
>>   {
> [ ... ]
>> -	__skb_queue_head_init(&offload->skb_irq_queue);
>> +
>> +	offload->skb_irq_queue = alloc_percpu(struct sk_buff_head);
>> +	if (!offload->skb_irq_queue)
>> +		return -ENOMEM;
>> +
> 
> [Severity: High]
> Does this new error path cause a kernel panic in drivers that ignore the
> return value of can_rx_offload_add_manual()?
> 
> Looking at gs_make_candev() in drivers/net/can/usb/gs_usb.c, it does not
> check the return value of can_rx_offload_add_manual(). If alloc_percpu()
> fails here, the gs_usb driver proceeds with registration.
> 
> When a frame is later received, can_rx_offload_queue_tail() uses
> get_cpu_ptr(offload->skb_irq_queue). Passing a NULL pointer to get_cpu_ptr()
> results in an invalid pointer (0 + per-CPU offset), leading to a crash when
> it is unconditionally dereferenced by __skb_queue_tail().
> 
> I note an identical issue in at91_can.c was addressed in a subsequent patch
> ("can: at91_can: fix rx-offload cleanup on unbind and probe errors"), but it
> appears gs_usb.c was missed.
> 

Seems to be the same class issue as 'at91_can' one. Nice finding. I will
address it in V4.

Ciprian
