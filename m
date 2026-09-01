Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3133D4E9
	for <linux-can@vger.kernel.org>; Tue,  1 Sep 2026 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253340; cv=fail; b=Q/M597VIoyllMQpT80bIyvMZMM3Pit8WgA4jkhM/G/1LDznZRqcdMkuNo+BX7Fco9k/Cg/lAX11Eu6YauUFlta+2eCp009aNgbNwOVvJFJEjV0v1G7DZg1ASJBqi4kzZPozVZu6sCa6Lm0Ohgm5yfTePNFRu6lGGsgu64tDunQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253340; c=relaxed/simple;
	bh=15p+hfInyifzPjauhSIlkcafd+7oLUz0Alg0F6VifZI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a3W9sLSdVwNRhCUp+xp8xjR/lKlr2q6XwzEOTXoc2w3cTrfSiPdkFEF64jaeMwn075ALA95XYrrrO7cwXxvPIhtjUgbCl8Uy+qiOrhXVYX8fCdJtrRbU4cAStd8qrGzb0WBVkSPUscAWgQAO4SvxUlQGxuNS+qToSjDGmGqpiKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iA6FfVDl; arc=fail smtp.client-ip=52.101.72.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iA6FfVDl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+Xg/JJynuaWO74Sk2iurKj2jLsxQf6pCbMaXlhXsiuz77CgMv6d0s28PnshQT47mSAWDJkKZuNzzlDOnczbpEqsXW5KR3qMmNiDdPwq1IOM78Bo4K8m1qZRHqsdKtDci4UCgxEpxCIYEgSLXHYepOPbTfcoopUJlXeWO1ANqoqJHfnAz/oP+R75fuWthzmANjnPpuv0jx1lu3LaCHi5Y7M+a7AAoK8fUhrNDfs4zDDaA0naAIQTZ+lDr0iUFG1BtUcGcUIPdXrF4a07OWMZQxsDe8meAOfDG8H+LEwhrNgQlqFCEB/1VoUGOJy63pEreeHOEkjsKmaz9V4hnelD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUZnrkL+dy+POt40s1JO1P2mxVtT+GuG2olKav0wzu8=;
 b=ox2sgBd/t9CsiBPuC0ioItgcadyJII3fToeL53huBqOnb5kDqPJwGnJ9MMoXqMNAayFY4Mwijy5MEbryQtlvlmCxW6rgzp0GfKQyx88ci88G+0vpjIxvwlhza+8TZPBaOYEiXQl51Ca6UUEMSOwQgznfI8FEPlajpnL9hElNpP4RlMResBN6jmhfBZuHE2E6TeDETkuD36w9nvgPslLkkUDA7oVe8ktwfe+yMESqaMuH0UM4jgEUHGtT53W0Zvlqne63zXU0RwjUrijNaieFaR0HoXncONxM8SI7kIgCICXm4VWJ9Pb1PD35bNk3KtRgjP9H4uJo/ykVufb68Qub5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUZnrkL+dy+POt40s1JO1P2mxVtT+GuG2olKav0wzu8=;
 b=iA6FfVDlfwAcNUKflO10w7NLOkwjKJhVx2rPS7wS0xZlyya2JzhhxWPatBGUx8YkAw1RYnW4FqE083tVJHadqlcbqv3LN6+rLT3JFY7KM1Pk0zh5n1Ar1aJjI4lwOvpVX4rsYJ+dC9HN1yKOwSYuNZvsJJxc0vanINUmWN4MHg10c4w7eHQtQ9wHSYtEv/ICDWNm2nl1eYtb5khFY+6q28JPwmJBPt0oBW4j98OwJSiezFOfuGGMA4huWWNGZXfUSKV36xOFB5hUqQgtPdg0sI2egVymKzQMwVWKZs46va5l7rdsV2US7ZWz4wMOedctzZa+9lTRdiap81gcKF9OSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AM7PR04MB6837.eurprd04.prod.outlook.com (2603:10a6:20b:10b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:02:15 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 09:02:14 +0000
Message-ID: <5baecf27-b4a9-49b0-ba68-f6808a8c1b41@oss.nxp.com>
Date: Tue, 1 Sep 2026 12:02:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] can: at91_can: add missing can_rx_offload_del() in
 at91_can_remove()
To: sashiko-reviews@lists.linux.dev
Cc: Vincent Mailhol <mailhol@kernel.org>, imx@lists.linux.dev,
 Frank.Li@kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
 s32@nxp.com
References: <20260901083927.316283-1-ciprianmarian.costea@oss.nxp.com>
 <20260901083927.316283-3-ciprianmarian.costea@oss.nxp.com>
 <20260901084931.0AB111F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260901084931.0AB111F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0027.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::32) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AM7PR04MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 23be5e81-b442-4330-cd76-08df0807b780
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|366016|1800799024|10067099003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wgr0Eu/dng7DAncXiItaq8T87N1OZ7CzW4FL/Q0T3qcN8D7cyMHJ8gYRrmIogcSkjI3ki5LL+LOam88PYZ0wa0E2Wdh9Gnl3GlKCH1TDDE9garfYMrdiAYg2EKhE2U6bWw1asuE0baHsc89kEfzRC9LFJNucpQiTtn7Smtr7gO9J6zuT1kLvkqFUHGXXrXPFPiUBvXUdhRhjj1AY0ntxSBswHw+laM6xi/aXESzQLym0Owa1aDNJaSvX2GgJJJYWkViyNP9NglrSLpXJznGNliOCJlJwUnZ7D4vrXp6o/PyIYcyqPeuhI9T6UNr6HW5+GXNmaKbUtEB5/K92wx483e5pbZBSHKk9ruoAEs8wBfkEddZpGuL/JN47ne5qd96PgdKzsplsRpSaIvytG+kRN0sQaaxiR+zFBOZDqjMxJ4Fs37+cWyMFeWpVUVNJ4es4hFdkfQPugGLDLAufCPwsiTkK/wtBhB4uyxV0bVmvB3wCs6/cLeaJY0tlzOGAnMnTaAYtq5TA+5iDxR7kSwrlk7Oj/TgMnQHmUPKc+cmuawwLl2I6RZmwnzMk6v/e5fVr7kBvU89ODobcnV3JP44XzuMT7z8ykgF4ExWotlYW2bm6dxgtz7VRCwZjnYJyjVwS/Q/t2xKbiKNlCShARzifi/bw7qGDH1jbDGdz+Gao6xY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmFqUVpobXR4Sm5LdVNIckQzNHdyanZvQWlSWGg2eEhYNGRiQVJ2QjgxcHY3?=
 =?utf-8?B?V1k3Sm1GaVhlUWVycWMyQ3hHeFBubTNXNHlCOG9YYlMyeEdkWnltS2NYbWNW?=
 =?utf-8?B?WEtpcUp3NlMwanNoU0loWmt3RzRDTlowbkRxSzlsMDRIZitNdmhwb0wrK3ZQ?=
 =?utf-8?B?OWNGckRodGo4VUF0c2RMNGNoYkI3VitpRDhaQXVTRlhyNHZ3WmZOQzM2cDY2?=
 =?utf-8?B?TXd0cXkzYUdWODF5QkF4a0lONUJ1OXkrYVhmc2JmUCt0MXZ2eDVHUTdhbGZu?=
 =?utf-8?B?WEN4cENDNkNjaG9ZUEc4MklkZWdOcHVNcG1WbGNJNzF4alBpQ1FTckR5Smh0?=
 =?utf-8?B?YXJyemZ4cDVCTnZ4NVhWTkxVbnNaY2pNd3NoNnY3LzZKQW1KTyt3ZEsrVnZu?=
 =?utf-8?B?dmNGUzRUd094OXp3N0VwTEJYVHFpMW5nZGJNcjdnbVRtKzV0ajI0S3kwcDBL?=
 =?utf-8?B?NkdCV2VjUkg4amZoNTkzSG12U1NBNTV5R3lIT2hFRkJFQjV0T0JGd3JReklY?=
 =?utf-8?B?WWlQbW4yejQ5Vmp0N2Y4M1BCSlI1MUxraGdMcHNXLzNTMHBDdm1CNXpkd254?=
 =?utf-8?B?dGtRNHorVEdtVTVDNVFXbmV3VFdadDZENHdtdHlhVGFkRTFoL3U2Q2tEazhv?=
 =?utf-8?B?aVZITWxqTDhyYkhsR1dTczRCNHNBU0oxMXREejdVREZURWlCeXl4UGNPeUNG?=
 =?utf-8?B?cHB6Q2syRGtNZnpBOEVycFJ5czBJODU4MmdPT1gzbGcwdm45ZjgwY3YzZnF1?=
 =?utf-8?B?Zit2YVVqMzNldW1aa1F6azFUOWdjc0xHR3VhTENJTXVESzNNc1dxbVQvelZH?=
 =?utf-8?B?c0hDVlVabnFybm9RaHZ6eEtldUUrTmRobXJoTmRtbnBIemc3NUlBSWJRQUI0?=
 =?utf-8?B?Ymg5dlNNM09MVGpRdUV0K0JKT3RvdkFGbENieitBdE5wVS9FcEFPcnhYei9h?=
 =?utf-8?B?bGNwVVMxYmtjeXd0MTVRM2k5VU45ZG1td0kzMW54RUM4N1BKMlRFaTRVK0xY?=
 =?utf-8?B?RlVOYlVFN3Vqc0s3dS8wTEVXU1ZOdEdCb3QxL25hQ0ViRnlPb0YzdC9ZYlMz?=
 =?utf-8?B?SzNoZVZSUTA3QWlYb3hvV05pU3dCZDlJOVZvNWhDYnlocnBvZThEdHNJKzFa?=
 =?utf-8?B?Y01QSjJLZy95QVdHS1NXbk1aUFF1ZzFEMVZlZ0loZDU2dE0yTlY3Z21Gcjcv?=
 =?utf-8?B?dlQ2WVdiVkNvcGpSUzJ4SzNhSXNyWng5d3JuL3BNZTJkTVhrUkRoRk1rQlpt?=
 =?utf-8?B?MnV5cFdUdGNKYTh6bGNiMlFHYjdFMFh3NXZyMEdsVS9YNnpPSHMza3B5TzRt?=
 =?utf-8?B?OEFtYndrMkV3TlVhSm45RTRaaTNjeGxmVk1tcGRzTnBVMWRYdXV2YzdSYmdH?=
 =?utf-8?B?cWtKVU45WERnTGg0NmI1T1JuZ3JnWHZyNWhKWk8zdjljR2FKVkVJYSsydWRt?=
 =?utf-8?B?KzZMRFlPSjA3b2h0UWNienVuQzY1WXpVTTUyNkJGN0N2dHpLR2NteVA0V3dq?=
 =?utf-8?B?eXBrMkd3bHhvNUJhdnM4TjJrb0JyTnNjWWRzMStDaFp2L1lMY3NzVDE1d3FJ?=
 =?utf-8?B?K0RqRmZjcURhNlNEWXg3dDZoZ000TzBzVUZGZGljWjBkdHNYTjJyZ2R6M3o4?=
 =?utf-8?B?NllGd1lldUd5dU9ucHF4YXg5UkprcWMvZHRJM0VoSVpKSFlPK2tYdWZyVUhs?=
 =?utf-8?B?ZVIybHo5QmhZUFVPcTRkZm5ydHdSR2xybE9qYXpGTEVLUFhERlNKZ2FXMDZs?=
 =?utf-8?B?Mjh2KzNIZ2xBQ0RJeHR2TXBuMDEwM0EySlVwUFZxOS9FZWUydTJyZ3VYSkgr?=
 =?utf-8?B?Q2pPbFhRMmFWZUlFTFI2OW1VOTFPY1JuSGNOMUJ0ZlRxT1hERUcwbk0wNEtr?=
 =?utf-8?B?bTh5WnJ1d0lJMUxCNUhsVVk0Q0Fjam1NWnNHaE41SjRCWXJqeFRzOWltRjVL?=
 =?utf-8?B?QWJ6VUpjY1Y4eXppZS9WL3FYYmJBMStyL1FEM1RWV3gzR2haMk10WmUwSFJx?=
 =?utf-8?B?d3NsU2dLN2VKeHp4VTJlUks5T3BaOUJnd3hMZ0hRVTNZUkhpREdlWTZkSGty?=
 =?utf-8?B?QUtPaDAvdUJLbllmMTJsMjQyaWFtODdGcEV4Z0lnb1cvOXFIRXpIVkx1VnRi?=
 =?utf-8?B?a1NjRjNjSjNJK1RsVE5GeEs2ZlBzVjlOYnR1d29xczZKQ3NOME5MTWF4NUF6?=
 =?utf-8?B?Ni9MRW5DNXdES1p5MWExQ2s1ZGFtVTJMZ0hlZzdRZkdXYUVSeitSRTNVV3FQ?=
 =?utf-8?B?VnZvNnRSanh2OEdLdVZGYmF3UGhjc3UzT2Q1d0l6dDNaUlBuTXFUaEVDOEJl?=
 =?utf-8?B?M0V6RTFjQTNVeldMVTVDZXl2VHBmY3ZDNUFkTUNPTnBuRDZnaGdsYmRXYytN?=
 =?utf-8?Q?8TMF9vpVPfZdduZ4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23be5e81-b442-4330-cd76-08df0807b780
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:02:14.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73n3djcUr6lI7xb8WnPbDHb2rkc5KmcIkRTxRdTCHb4Wk1qvyeUuYCMziDASbTzJ0OPKjGsaBl78nf+ZJ92+gzziyer4vMmHqFHHghmMQQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6837

On 9/1/2026 11:49 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The driver ignores the return value of `can_rx_offload_add_timestamp()`, leading to a kernel panic upon allocation failure, and also misses cleanup in the probe error path.
> --
> 
> commit 480793d438a773b528d044a7ee532ec7fbf0bc18
> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> can: at91_can: add missing can_rx_offload_del() in at91_can_remove()
> 
> at91_can_probe() sets up rx-offload via can_rx_offload_add_timestamp(),
> but at91_can_remove() never calls can_rx_offload_del(). The NAPI
> instance added by can_rx_offload_add_timestamp() is therefore never
> removed on unbind.
> 
> [ ... ]
> 
>> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
>> index 58da323f14d7c..3ee908817add8 100644
>> --- a/drivers/net/can/at91_can.c
>> +++ b/drivers/net/can/at91_can.c
>> @@ -1165,6 +1165,8 @@ static void at91_can_remove(struct platform_device *pdev)
>>   
>>   	unregister_netdev(dev);
>>   
>> +	can_rx_offload_del(&priv->offload);
>> +
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while fixing this missing
> cleanup in at91_can_remove(), is there a similar leak in the at91_can_probe()
> error path?
> 
> If register_candev() fails during probe, the exit_free error path is taken
> but it misses calling can_rx_offload_del(). Could this leave a dangling NAPI
> instance and leak the per-CPU queues?
> 
> drivers/net/can/at91_can.c:at91_can_probe() {
> 	...
> 	err = register_candev(dev);
> 	if (err) {
> 		dev_err(&pdev->dev, "registering netdev failed\n");
> 		goto exit_free;
> 	}
> 	...
>   exit_free:
> 	free_candev(dev);
> 	...
> }
> 
> Additionally, the return value of can_rx_offload_add_timestamp() in
> at91_can_probe() is ignored.
> 
> If the allocation fails under memory pressure and returns an error like
> -ENOMEM, the probe continues without allocating the per-CPU queues. When a
> hardware interrupt eventually fires:
> 
> drivers/net/can/dev/rx-offload.c:can_rx_offload_irq_offload_timestamp() {
> 	...
> 	irq_queue = get_cpu_ptr(offload->skb_irq_queue);
> 	...
> 	__skb_queue_add_sort(irq_queue, skb, can_rx_offload_compare);
> }
> 
> Could this result in passing an uninitialized NULL skb_irq_queue pointer to
> get_cpu_ptr(), producing an invalid memory address and causing a fatal page
> fault when dereferenced by __skb_queue_add_sort()?
> 
> Does at91_can_probe() need to check the return value of
> can_rx_offload_add_timestamp() and handle the allocation error?
> 
>>   	iounmap(priv->reg_base);
>>   
>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 

Good finding. Will fix in V3.

Ciprian

