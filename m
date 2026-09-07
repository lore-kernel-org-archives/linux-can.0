Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7696044C4E2;
	Mon,  7 Sep 2026 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774090; cv=fail; b=Dat6FdMTtndyrGbCOF+znFh86sJbSjq+Ra1HGn8rLrWoHELuLiOG9bWK9U1X2MzOLSyExR2S5RGlIAw5LIs/12tieCZ85rOd/vgzjSk15/rEm2s0Aq0i/72CxzobFQ6L8pVO8dTPWCiTh64ENnv0KRoa/zYdK8XcQwtyEiotU8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774090; c=relaxed/simple;
	bh=dtgMFv+J8kNcm3RBgD6Im6MU42fGg2UDR8YZJgKAV5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LW+7XbEonfkjAAYQo/QtnXxGzir8KiYwJbVd4m2x+3hrXq03KuCzW/jCPX+vecaamMdfeO5XMWcfXQZHwSossnDp4ecIoxTc6UwTutrvC77DRhVWoVninCaoIYu/qe29WoAw4qh6089Hdr1S3//L3paiqbRQAhqXiYB4uLnZhfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gUrxGxoW; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gUrxGxoW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/bOVscRk2Rw+82/w/yjMPm8NQ87XTPD2B3NVHEe7XlDtr9I08Z2IrR1xp87b/nW0AZnHVa46l3VT+ELgyi6/DCSFIXJMUjlkT6EtjWr3fmOJ57SAaEjiyOSZjBaf87tAZdaixA2A+jCXK6C7wcP6pErMG3G7qVe4DXinIFyJ4ZYf722WB9voIe5AO8I0JgXjsLvJY17JRR5wRZcZU1RpI1FJHdKe1Gz50v2lch3EttNj1qKDEmsdvPnV2cyoDTT1ixqdHAKLrlqzHsOMlPhudJ6Vo4y/h3pXzXjSfBPZxz+F0j/6XO3Nzp5cGFSziNQK3qA2ocW0DjL7EtpRoyFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPykujq/wilOJqUgpMwgvH9Rc1+VtX82ZhY5KZshyO0=;
 b=NP7OJbwwCAvS5pR5pVtTvEK1ByzjvV6cLnl+SIBFSgqPpS6nMsDJhKVA7Gjlhu1ovJSGFys6sa3p1D35J910BIdwCI7zF9XY9ipWqDf3Qx9r7zSfJUX8xhgiXMkOG8VeZIEiKAnCDO/UiLYMaMR8SXhqupYQB1FGUabQIzv/UH5GoeD0gkslIKob2klK8Bp1qWvSDMmb6k7Tsq/zSALCal3LF1dvmnrjyKSTXsbJi2ce5Hu/zB6i152Ry1TlGH180e/jSiKCCTulsNFZMVxl9lx+ep435Wy2toPdVQHDJ0j49aWgz+BJmx9Wh5vSykbpy1fj9Sgn8zPgG7CGypzdLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPykujq/wilOJqUgpMwgvH9Rc1+VtX82ZhY5KZshyO0=;
 b=gUrxGxoWA1HFLr1ssYpDRfqxGyCUGJmKM48MzY3BoKYTg53gPuTxBWNq3ok2Hx7KyShqQxp+xWAAiHj87Uoekj1RsvIC129xplwNV8o0UkDY31Yn2y8VwgKxuhbxsEXhyJGAaKMxpMHONzBLoqXxyTgdX4Qe4mwcrwm9zezfiCczIudx9/1Q1MxsgWm7LAYVmGek14fYtC7U9Ey6BqpsPiKafae3ut3yP0bJeqDMVVi1n0Qym8j3i3aE67Q+Nhiz4WuMk/lP1u/BzPq55sPlGj+HzjUjpkK1UWdsL8IAG3OYnDzTPDM1N43MCLVhs6itVvkOvZZh3AwnK+P5Hj+NHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU4PR04MB11053.eurprd04.prod.outlook.com (2603:10a6:10:589::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:41:25 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 09:41:24 +0000
Message-ID: <81891f6c-2976-46e7-a129-83bb221bb31f@oss.nxp.com>
Date: Mon, 7 Sep 2026 12:41:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] can: rx-offload: make skb_irq_queue per-CPU
To: Bough Chen <haibo.chen@oss.nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, s32@nxp.com
References: <20260901114848.500591-1-ciprianmarian.costea@oss.nxp.com>
 <20260901114848.500591-2-ciprianmarian.costea@oss.nxp.com>
 <20260907081954.h73o7vzgr3obpqyr@shlinux89>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260907081954.h73o7vzgr3obpqyr@shlinux89>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU4PR04MB11053:EE_
X-MS-Office365-Filtering-Correlation-Id: 987acfc0-cb4f-4237-34c1-08df0cc42ead
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|23010399003|376014|7416014|10067099003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	iUP4Zb1HnhMaxjwGgU0CNQ6GMV9cV8uaqEagR3eXryb277e2P/Jmk6ugUhDeFihpaQI5mZCLWUOdTMkuhK8gRaBxhur4HwtHn4N9UMzsaG+PspUb3jyUPO1/WFEFQHwHkx3V+ceSJ/+16vGS1sf4SOhW+SVrdf0S/5026lzbiHwnE+HW953UzbYOu6ivPiEI4Bw9q4MGBbcVgle/+eEo6hODJ7ZJKmFwGjldcekxB7gZN86VsfjQHeqAush+IFHvZE77kHPwLldWcuNV0t8obe5xnqHbVmXMVyElQApEBFzpSSJ5s5g95eXWICB3Ky5P2j+pqXL1iUWiV/PJ6brhSEmvquxv4YZSbCA27bmI5x/HM5E/7huoJgeH5zlMj2MpL8xKbyV+6YoWLc3ylgZ5RAU+vdnhlWD4u3eXqnh3XZVI3oGy15rdySs2RPeSNneax0akV31EZ205OzdFCocJOd45JIxfNGYj9dEVbsoNCHl7K5mTOrYmgAnQnET0bqEbuYBIEzt6oz89rCX1P8eUzAdFsM5G7OkVshCxwv8dzerZMVtAEioHpgoXih40gNf/oOgU6NNwwB24JdsqM07Cb2powrfuW5LAXELC/VnipUzZYkTF0E7FpWoFgsMdHjfDP8VPEB0sFIzIeUaMx5gt7FiPyUu6k+0JchzHH3fvj64=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTdRaU53akZoaUpadVpDV0M3WTFzN04wOHJjTTV1OFdyb1NPZjVqZDZRaG5p?=
 =?utf-8?B?Y29Lb1g4SCtCK3FDRElxc2oxczk3T1M1YmZvY0hjTUdNRVRDK3o2anlCTUE0?=
 =?utf-8?B?Tjhwd1ZVb0J2c3p2Zk53QWVTYXpwSnBFTkJFMVplMmx4QmVpYkNnQ0wyTWM5?=
 =?utf-8?B?Njc5bUhZcnpMeHJsajJNbFB6MUlQaUZmYmo3ZzdIREd1SmFXdWpsQXBBS1dH?=
 =?utf-8?B?RWl3djhmTUZhZjIwL1BYV2lnR2xLVXFWNEtTTlFZUGdDbG8wL3REVWZmTnhK?=
 =?utf-8?B?L1BLeTFuMFZpNUZTV0xBS0tKd3MxMXNzL3FDQVlPVEJtcHJUSUxJdFY3MFd5?=
 =?utf-8?B?b2N2U2loRWFVbytIeEdVSkNGYTAveU5MUFdmZGVCY1ZqYjJSK2tIcmFSN1Bt?=
 =?utf-8?B?UnFiOFpua3hWbEZjUUlDQlNvcmZiczBRSnovMTRmTStyN09ZWVJxTmh5ZElx?=
 =?utf-8?B?WktRQVBVV1ZqdGltUmFVb0Z2aDdiS0FodDlna0NaOGd1K3BiMmJoenZzc3BI?=
 =?utf-8?B?TElNclpwQnpiMEQ5MEFPYmwvZDdEKzN0S0RKY3V2eTlOYndpakVPb2dNd1BI?=
 =?utf-8?B?ODI3UFFURE5RdEduWTYxSkFhcGx5b20rSlRiTWg5cS9lVUd2cCtwSm11TjQ4?=
 =?utf-8?B?TDAzdjNKYW05Z2ZxSkE3R3h2Q29yZkZ6VDVkRzJMWEcrT2NkWm0rVHk4S0x4?=
 =?utf-8?B?eUVCMnUya1laYTNZUHhkMlRBQzlOWUk5WVVtUlB6em96b2l6UlZzSjM2ZXFp?=
 =?utf-8?B?ZFZwZFhtc1JnZ2tvcFFjR29EOUZqTkUyR1ltb1FId3lJc254MzZyd0NabVB1?=
 =?utf-8?B?SlRUKysvMVFnRmt1SlFYMFR3RzVYc0w3S3hOSW4vdWpCT0M2NUpnVFM3VWsv?=
 =?utf-8?B?aHEraFpWYlV0amt5ekMxL1BKdkZXSHFIRVBucFhoTWRzUlJLaXVwM3lsTjF3?=
 =?utf-8?B?TTArMHF6emtqVElGYVlDeWo2Vy8rZUN5Um5FM0FZdDMyZGlEK0FmNDdpbDdx?=
 =?utf-8?B?ZVltbUdZTGRuSXE4dVFDVEdjR2FrU2NFMlh1Sk9qS21EVWcyQ0wvdU1TVlZN?=
 =?utf-8?B?UDhGUFhnNWF5VVJzMkxEUm93R292cHpEMDRCSTdxcmNmdENyWlR0OHg1eVFw?=
 =?utf-8?B?bFhTNFBmZDU0RTRWTXhYcjdEY1o2dGt3WEJsYzByeWpVZUxjYU5pRUxUblBF?=
 =?utf-8?B?a3h2Z0ZoaVd6Y2l4UWhhY2ErU05yc29RVzBmYUpFUmh4OTVieXRrOUVpLzRk?=
 =?utf-8?B?R1FFZHh5MTVWTVU1RWpJNUFqWjBObW4razJ0cXcwQTNWRHJkWTdNckdPU21X?=
 =?utf-8?B?cXBZc1FZdEY0aVRNbEpic2x2Y3EzM1FOQk4wM1VsWDBwWVNZcjR4dEFkMUk3?=
 =?utf-8?B?emUrL3V1NFJINWZWQVlPbGxBOWFGSU41ZHo4bnJ1OVg4VnN1Tzh2czhBZ2JI?=
 =?utf-8?B?UGhZd3VLN2krUDZONWJRZnliakpIaTNZZTArUmZkZSs0RXVlK3RMc1YrQWxk?=
 =?utf-8?B?VWx4aWxQTjdRMEoreVhQRnk4Z3hWZmRlTi8vUFhZcnZzK0JaSUhaVVV4YVZj?=
 =?utf-8?B?WkJKbDlTTUs0UC8xc2tHTG9ZaGd4dXNWTm42NXhobmRwZFlHMGN2cTZpSWx5?=
 =?utf-8?B?K3NoQzQ5OEh0a2lqWHM0OHU2VlZ3U1JkVE5WaUI1NmMrMllXU3IwY1VDNG9t?=
 =?utf-8?B?dWk4YW1BSElHRi82clo2ekRTRWkrMjQzb0xnREluMG9UTTVGdStTNU5IWTlw?=
 =?utf-8?B?WXV6MTBjOHlLWXR0MTVudm8vUTBDTlpkN05zMllCdERVeTl6L3FLRjIvdlNW?=
 =?utf-8?B?RXh6ZGh6b01hbDVRYUV3WVRoeHprQlV3QldYdkJ4M256ZjRBQ2tFYW1KN0xw?=
 =?utf-8?B?Zm5UTkJmbUVoUHlwQTRRdTZwUE02cWk1SzM1YmNLd2lwUlcxR3pjSXd0M2s5?=
 =?utf-8?B?aWZEMTA5aHRKMXBiaFE2YUs3SjBQVnRITUVIL3BvNWFqeWxEZGxsREhNM21q?=
 =?utf-8?B?Y2FRRE4zUDM1ZldUUXlzVCt5UEI4N2RFNWM3VjFoMGpxQ05LM0YvbG84UE0z?=
 =?utf-8?B?YUFxRFpPWFp6VjN2RjFKek00YXBVbmlCendwMHl1ZE1Sb0hTOFMvZ2xMMENJ?=
 =?utf-8?B?RG1hVkw4bkUvdG5QQ21iSHkrd09DM1VuaDh1cGlJdUVmTjc1blNIRVYycFNT?=
 =?utf-8?B?V2NsdStkb2V5L2Z1cVE3eHc5SEx5SUNBSFd1S2NXWUxURkhKTFBLOXQwVm1t?=
 =?utf-8?B?dDVqOEQxRHRkSm5xUSt1WDh5dzJMREpuTUExSlFYZUdXQVhJaWw3M01kZTFm?=
 =?utf-8?B?QktDK2ZFR3B0SGxLam9EWDBaSllIcnhWVkI4RC91WWlrMHA4ZUxEN0pUNnNJ?=
 =?utf-8?Q?LUC42tRctGlxjhec=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987acfc0-cb4f-4237-34c1-08df0cc42ead
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 09:41:24.8586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBYXFvziZ36XgnxncXoHusQRE1dWXz6HeLRshS4TE5d22GEzDXqnm5muCioxMPEFCET1+7IA5Fm7BFrM3KV/mSbZdCsJz9b4GnCQHyIHv1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11053

On 9/7/2026 11:19 AM, Bough Chen wrote:
> On Tue, Sep 01, 2026 at 01:48:46PM +0200, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> skb_irq_queue is filled by the IRQ handlers using the lockless
>> __skb_queue_add_sort() / __skb_queue_tail() helpers and later spliced
>> into skb_queue under skb_queue.lock by can_rx_offload_irq_finish() and
>> can_rx_offload_threaded_irq_finish().
>>
>> This is only safe while a single context fills skb_irq_queue. FlexCAN
>> on NXP S32G2 (FLEXCAN_QUIRK_SECONDARY_MB_IRQ) uses two mailbox IRQ
>> lines, one for MB0-7 and one for MB8-63; MCF5441X similarly splits its
>> mailbox interrupt. When these lines are affined to different CPUs both
>> handlers can run at the same time and enqueue into the same sk_buff_head
>> concurrently, corrupting its list.
>>
>> Allocate skb_irq_queue per-CPU so the handlers no longer share a list,
>> keeping the enqueue path lock-free. Access the per-CPU queue via
>> get_cpu_ptr()/put_cpu_ptr() in the enqueue helpers: this disables
>> preemption around the lockless __skb_queue_*() operation.
>>
>> can_rx_offload_irq_finish() runs in the same context as its enqueues and
>> splices this_cpu_ptr(). can_rx_offload_threaded_irq_finish() may have
>> been migrated after its enqueues, so it splices every possible CPU's
>> queue; this is safe because each per-CPU queue has a single producer and
>> that producer runs with preemption disabled, so it cannot race the
>> splice.
>>
>> Cross-line frames are now sorted by timestamp only within a CPU's queue
>> and appended across CPUs on splice; each skb keeps its own timestamp.
>>
>> Fixes: c757096ea103 ("can: rx-offload: add skb queue for use during ISR")
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   drivers/net/can/dev/rx-offload.c | 83 ++++++++++++++++++++++++++------
>>   include/linux/can/rx-offload.h   |  2 +-
>>   2 files changed, 70 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
>> index 46e7b6db4a1e..649bfda08b65 100644
>> --- a/drivers/net/can/dev/rx-offload.c
>> +++ b/drivers/net/can/dev/rx-offload.c
>> @@ -7,6 +7,7 @@
>>   
>>   #include <linux/can/dev.h>
>>   #include <linux/can/rx-offload.h>
>> +#include <linux/percpu.h>
>>   
>>   struct can_rx_offload_cb {
>>   	u32 timestamp;
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
>>   		if (IS_ERR(skb))
>> @@ -211,10 +226,12 @@ int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
>>   		if (!skb)
>>   			break;
>>   
>> -		__skb_queue_tail(&offload->skb_irq_queue, skb);
>> +		__skb_queue_tail(irq_queue, skb);
>>   		received++;
>>   	}
>>   
>> +	put_cpu_ptr(offload->skb_irq_queue);
>> +
>>   	return received;
>>   }
>>   EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_fifo);
>> @@ -222,6 +239,7 @@ EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_fifo);
>>   int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
>>   				   struct sk_buff *skb, u32 timestamp)
>>   {
>> +	struct sk_buff_head *irq_queue;
>>   	struct can_rx_offload_cb *cb;
>>   
>>   	if (skb_queue_len(&offload->skb_queue) >
>> @@ -233,8 +251,9 @@ int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
>>   	cb = can_rx_offload_get_cb(skb);
>>   	cb->timestamp = timestamp;
>>   
>> -	__skb_queue_add_sort(&offload->skb_irq_queue, skb,
>> -			     can_rx_offload_compare);
>> +	irq_queue = get_cpu_ptr(offload->skb_irq_queue);
>> +	__skb_queue_add_sort(irq_queue, skb, can_rx_offload_compare);
>> +	put_cpu_ptr(offload->skb_irq_queue);
>>   
>>   	return 0;
>>   }
>> @@ -268,13 +287,17 @@ EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_timestamp);
>>   int can_rx_offload_queue_tail(struct can_rx_offload *offload,
>>   			      struct sk_buff *skb)
>>   {
>> +	struct sk_buff_head *irq_queue;
>> +
>>   	if (skb_queue_len(&offload->skb_queue) >
>>   	    offload->skb_queue_len_max) {
>>   		dev_kfree_skb_any(skb);
>>   		return -ENOBUFS;
>>   	}
>>   
>> -	__skb_queue_tail(&offload->skb_irq_queue, skb);
>> +	irq_queue = get_cpu_ptr(offload->skb_irq_queue);
>> +	__skb_queue_tail(irq_queue, skb);
>> +	put_cpu_ptr(offload->skb_irq_queue);
>>   
>>   	return 0;
>>   }
>> @@ -307,14 +330,15 @@ EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_tail);
>>   
>>   void can_rx_offload_irq_finish(struct can_rx_offload *offload)
>>   {
>> +	struct sk_buff_head *irq_queue = this_cpu_ptr(offload->skb_irq_queue);
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
>>   	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
>>   
>>   	queue_len = skb_queue_len(&offload->skb_queue);
>> @@ -330,15 +354,29 @@ void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
>>   {
>>   	unsigned long flags;
>>   	int queue_len;
>> -
>> -	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
>> -		return;
>> -
>> +	int cpu;
>> +
>> +	/*
>> +	 * Splice every CPU's queue: unlike the non-threaded
>> +	 * can_rx_offload_irq_finish(), a threaded handler may be migrated
>> +	 * between the enqueue and this splice, so the frames may sit on a
>> +	 * different CPU's queue. This is only safe because a given per-CPU
>> +	 * queue has a single producer (the enqueue on that CPU is
>> +	 * non-preemptible), so no producer can race this splice.
>> +	 */
>>   	spin_lock_irqsave(&offload->skb_queue.lock, flags);
>> -	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue);
>> +	for_each_possible_cpu(cpu) {
>> +		struct sk_buff_head *irq_queue;
>> +
>> +		irq_queue = per_cpu_ptr(offload->skb_irq_queue, cpu);
>> +		skb_queue_splice_tail_init(irq_queue, &offload->skb_queue);
>> +	}
>>   	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
>>   
> Hi Ciprian,
> The fix looks correct to me. I checked all rx-offload users in
> drivers/net/can/ and the change is safe for every current driver.
> 
> One suggestion:
> the cross-CPU splice in can_rx_offload_threaded_irq_finish() is safe
> only as long as there is a single threaded handler context per offload
> instance, so each per-CPU queue has exactly one producer.
> This isn't new (the old shared skb_irq_queue relied on the same
> "single context fills the queue" assumption), and for the current
> threaded users it's actually enforced by genirq:
> they all use request_threaded_irq(irq, NULL, handler, ...),
> which mandates IRQF_ONESHOT, so the handler can't re-enter.
> 
> Only the threaded finish path cares about this, and all three such
> drivers request the IRQ with IRQF_ONESHOT:
>    - m_can (peripheral)
>    - mcp251xfd
>    - nct6694_canfd
> They all use the manual enqueue path (queue_timestamp/queue_tail), not
> irq_offload_*(). Everyone else uses the non-threaded irq_finish()
> (this_cpu_ptr only) and is safe by construction.
> 
> Could you spell out this assumption in the comment above the
> for_each_possible_cpu() loop? e.g.:
> 
> This assumes a single threaded handler context per offload instance
> (IRQ requested with IRQF_ONESHOT / handler non-reentrant), so each
> per-CPU queue has exactly one producer. If that changes, this
> cross-CPU splice of lockless queues would need additional locking.
> 
> Minor, non-blocking: get_cpu_ptr() only wraps a single enqueue, so a
> handler that drains several frames per IRQ (e.g. mcp251xfd) can migrate
> mid-batch and split a burst across CPU queues, losing intra-batch
> timestamp order after the splice. Just as the Sashiko reveiw in your
> V2. I think it is harmless, and SocketCAN doesn't guarantee delivery
> order anyway, so I'm fine with it as-is.
> Point it out just in case other people may have comment on it.
> 
> With the comment clarification:
> 
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> 
> Regards
> Haibo Chen
> 

Hello Haibo,

Thank you for taking time into reviewing this patchset.

I will add your comment clarifying the single-producer context in V5.

Best Regards,
Ciprian

>>   	queue_len = skb_queue_len(&offload->skb_queue);
>> +	if (!queue_len)
>> +		return;
>> +
>>   	if (queue_len > offload->skb_queue_len_max / 8)
>>   		netdev_dbg(offload->dev, "%s: queue_len=%d\n",
>>   			   __func__, queue_len);
>> @@ -353,13 +391,21 @@ static int can_rx_offload_init_queue(struct net_device *dev,
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
>> +
>> +	for_each_possible_cpu(cpu)
>> +		__skb_queue_head_init(per_cpu_ptr(offload->skb_irq_queue, cpu));
>>   
>>   	netif_napi_add_weight(dev, &offload->napi, can_rx_offload_napi_poll,
>>   			      weight);
>> @@ -420,8 +466,17 @@ EXPORT_SYMBOL_GPL(can_rx_offload_enable);
>>   
>>   void can_rx_offload_del(struct can_rx_offload *offload)
>>   {
>> +	int cpu;
>> +
>>   	netif_napi_del(&offload->napi);
>>   	skb_queue_purge(&offload->skb_queue);
>> -	__skb_queue_purge(&offload->skb_irq_queue);
>> +
>> +	if (!offload->skb_irq_queue)
>> +		return;
>> +
>> +	for_each_possible_cpu(cpu)
>> +		__skb_queue_purge(per_cpu_ptr(offload->skb_irq_queue, cpu));
>> +
>> +	free_percpu(offload->skb_irq_queue);
>>   }
>>   EXPORT_SYMBOL_GPL(can_rx_offload_del);
>> diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
>> index d29bb4521947..1b9e2a8ab39a 100644
>> --- a/include/linux/can/rx-offload.h
>> +++ b/include/linux/can/rx-offload.h
>> @@ -20,7 +20,7 @@ struct can_rx_offload {
>>   					bool drop);
>>   
>>   	struct sk_buff_head skb_queue;
>> -	struct sk_buff_head skb_irq_queue;
>> +	struct sk_buff_head __percpu *skb_irq_queue;
>>   	u32 skb_queue_len_max;
>>   
>>   	unsigned int mb_first;
>> -- 
>> 2.43.0
>>

