Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D24544F561;
	Mon, 28 Sep 2026 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581178; cv=fail; b=CLqQFp6bX1qtsVzB2SxrCrT1dm/6n562FlhfPdo+GVdTvzGj+4xwmV1eYRBd0x69Qt/gMY1+D8RmOIoIofXAwvTaJOO+ItCPrzHLOOlxJjJo/hKAll2Z+VleJHPZe8l08s4LpZif2IPX2jSuLVkZmeBcG42uFU67i8DUrNCl42M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581178; c=relaxed/simple;
	bh=sLGavqtQqhTOzLywcdv2seyQbK6eur8EgZRLRN/0/n8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JYCtyDCU2m9ceZuz0aK7CkS+UhPLZOzJBIPbK1LY9Ufq2xiDeyVIEPtqEsDWTfRfwBWHzOj4KqRF6Fo+jGFRNesWFCBsQs0bz1SGoh/aY5oC/uVzLTYuNua8qzz8kXwv8JMcUPehXPYePXCrcPz/Jx9qYZYFox8ZpX72pzFRydU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gXQWgb0O; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gXQWgb0O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2biOePqz1o4suZe2dWt95T1NrAcxXVyvQzChCL7UG8oxJhXB1AXuTGBWn/o7Sy1pF314kRvdoTp6iksyysgryzDzU7vBmQXWNXajg5eaS+s6VTigbPEeKwR/E2Zs/KkTjSMRL0KGckCvHm1i90RS0NFgXsOMZfHNFFZGy7yh4pPrORA1V2yxzwpm6UD09TJdYGyimYScMJGrJVvL9d5cKmVSPnsQj3bpk9cuJQW7SprD1pnLDnMSDEcsmmzWfgWgQPVhy6qMb39zFlqDsw00Q8w4a+d+Gbg0ep+sT8vEspgcFfUkyZGWUxNEm9codgzlrbidt3ACcICTeW2MgqxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxfdRPBCnW2cZJuYiTid8FtTDf0UXr/U5DuD52+YWSQ=;
 b=ts6j5kOMG6B0Fuu4jvCYmPkxwLup6sRw1ihp0+4meaCZLd9L4/LwSx1fmWfwq20LnlIj/ux7IKR+0ML8aVmuQqMYqtmv2krEsB3/pgVIn0xbTu5dMbJJP6l3O0hG+WNwKcrmdp+DkH4oNmTQb5GmEb6cIH4YAGToMh14MxtgI3mCHiXcQh0POcvSogcjDi4aGyNSGuUBIs3GXzH5cVjDStUjNGthSN/8V7/oBoFK7zR82cAXNfF0MnghDZVtsJ7QK17ZaglB3JO+ri/0ueNZ4CParRFvZFe0QzoisGNKGWNe2DCBrX+I4B1ObPWxFjTUX9bmvBXadfaDGf5Z+IlTDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxfdRPBCnW2cZJuYiTid8FtTDf0UXr/U5DuD52+YWSQ=;
 b=gXQWgb0OTlkLAgdU9rPLk1yvsFi7gzUoF9UifHuSbhYfcSI9ANIqUHefsmuTKmkS1D2hnj4oKTVSzpQR7UJNNVnpeucbBwcvrBk9lVLhU3DNFTBkYdIRG2x7ZaT96M+ysbj3z0yl7gZgefnPSVFWmVXRLd07qA774+UmAH91200KJx6W4j9Vdi7wqlUJr4H5KeDqSi5ACMyGeQ78YRgX7mIxpbi5QOHPSXbm5i0cPoW8c/CKdBZYjVlwjG5OdU2l2OdE1009RDWYJUFcp49Ff+pU5ea8eFsPVU5wSCAR8GtS6xqXCFrZyMIVACl0i3SHgJ2C76XG3WKnXM6FspbnzQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 07:39:32 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 07:39:32 +0000
Message-ID: <b61c912e-2a3c-47c2-aa0e-9e1584c8d3a6@oss.nxp.com>
Date: Mon, 28 Sep 2026 10:39:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] can: rx-offload: add a per-IRQ receive context
To: Max Staudt <max@enpas.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Heiko Stuebner <heiko@sntech.de>, Manivannan Sadhasivam <mani@kernel.org>,
 Thomas Kopp <thomas.kopp@microchip.com>, Ming Yu <tmyu0@nuvoton.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>,
 imx@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20260925144558.2909639-1-ciprianmarian.costea@oss.nxp.com>
 <20260925144558.2909639-3-ciprianmarian.costea@oss.nxp.com>
 <0daea1b3-82ef-48f0-8d35-6ce0100b60bf@enpas.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <0daea1b3-82ef-48f0-8d35-6ce0100b60bf@enpas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DB9PR04MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: cce91ffd-b157-4dc9-75fb-08df1d33a2cd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|7416014|366016|23010399003|10067099003|11063799006|921020|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	GgNxXys003GvR/QwnEiT8ZP71HvPEORGm4Oo6gUWGFF+wM5l/yBND9+U626nZL3t1Z2CqjFLA/dWi5VqV7DWGJSHc8sYrssnW0MRFw+Aq1AcNCZSDY8FAVP3eFO2amgSRjsqjXFMvwwS/oJkw9W93+jXMnl36flRHka+QJS0+NRF8M0ukrYjA48kGwBrrtvJDfQyQ5BWmm3HVY4diPu0vJY83PXimIaueUrOLP106vWZF5MES/vi+hFBVY8psbm6kn2KI1/yjL/hQAbS3arqH9k5l2CE1mh7PaTnyX3AEKdWqcqvFgWN5SvIXhvVheJJBnBbjWOZ5bWRefszLvnkj1A3cw7534qcONjaoexkVp1lR7eNksEWjGE+xgsg3EUNfvdXkniXD9DEV8MPStj4LWtQqooW+b/lxjDlXU6W1HVV8pnyVozwp16SKXDtTo+GdkGDSllsR65NIGJMToKuAEaSHqwoKqIWbp+MapnU47Wwftl61O3itR61XjOKeHC1GW4wKqMsC2LvD488lHYbHecPGBZOD2PQ7pxHmzd4pBCAF8j5OcjU9QR5RJRCysQf3ADpXjAvBQuK/ZzXbb1hVY3Tuo5QsKYuQFO673hUApi1y9cWmboIrPz13pQEuXR5v6rs8zd8l9pHzj4eznUMvh/Hg+tpB96GwTIhpiu5+/T9tzdS0sEydOwGiZ2OBOM+SbSidMRGrkZ0JEk2dS1laQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(7416014)(366016)(23010399003)(10067099003)(11063799006)(921020)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aCtRYkVlMWVEQ2J0L09yMWFvRnFVWkhxK2JXa1hEaDNlaWh0SmhkZGZlWk1o?=
 =?utf-8?B?VmM1ZFdlTnlWUjZQeXh0cGh0OHA3K0pnckcraEpTRW8za1VNR0VIYkNyV0w0?=
 =?utf-8?B?N2N5d1VPWDRFNW0vcUZUdHZLbEZBOVllUWloREtHeFVaUVpNcG1FWEExQzhB?=
 =?utf-8?B?ZG80ZldkbHpkNmJ1NGQvWUpIVER1MGplSWJIbDcwM1pSNnhmUTVONGluazcy?=
 =?utf-8?B?OG9kd2ZrTGlFaW1IVFJQOVZtbDVUOWhkclJ2L2tSN3dRM1p4RSt1QUw2aGs1?=
 =?utf-8?B?SjBlMjVRTkNLOTZ2SytuVWZEMXJDdWZtelVBRldaV3pBN0hZRVdnRjBsV1Rh?=
 =?utf-8?B?Nk1jTllCZGFIbitNZHM1ZllGWHY2M2V5Rkppbm5VcTdUZ3BNS0Rzem5HeFho?=
 =?utf-8?B?bTQ2NW1WK0RsQjZGdHhLT2paQnovWWdhazNzdzU3UGlVZ0p0TzZsWmFNbkM4?=
 =?utf-8?B?dGZlYUxKYTB5Ky9zNUlkd3BicnUrLzB5Ymx5dUJRK2lqT2psWG9JdWhmTG1t?=
 =?utf-8?B?WVdncUYzeVByeVJobkNELzJwKy82Q2MxcXZVbW5jQmUxTnVkUXFhY1Npcm5w?=
 =?utf-8?B?ZUpORHppdVV6Z3UzRlViUmFGQXUwZExiK2wrZTNWV25VUWl0Vlk5aDROWWZ4?=
 =?utf-8?B?aklRQ1FLV0I5dTlTWUd5WkpyZHMxbWU2OXFYWmEyVkUwaHVxaEc2dFQyRXFF?=
 =?utf-8?B?MVljUmpPeGJCUVoxcWVJNFZyTDVKSC9LNlFwVHFtQ2I3MStTVGxNOFE0VjhR?=
 =?utf-8?B?NWtkcUxzZExJa3dOcm5jcmVkMEttU2kzRVl1ZUd0bDNNRDM2ak15c3V6TVdO?=
 =?utf-8?B?d1NZdWRwa1Y0Y2FIaFRUREJzZWtLUDBqL3pUM1hmOGk1ZG5yam5NeHhwc2tu?=
 =?utf-8?B?V1FhVjk3NUlaUTVOZHFaaGJ6RXdveXg4N3RrTTg2cGhlWmt5Z05YWFdUalBs?=
 =?utf-8?B?bUUxWWFNakZXZ3QycU5tVFY2QmsxZUtPdWZNNytxV0FtVS90Yk4xcWNMcmZU?=
 =?utf-8?B?U3Y3bFRNRmpDMUxTcFhPaVQ2UFhjVzk3VnplVFNETFVyeTE2VFM5Z2tnUzRl?=
 =?utf-8?B?a0w3cW1oNkFnZE5TeUgxbGVOcEl2WjRjdVV5TzNwcjg2NUxXRXBSMXlDWWtN?=
 =?utf-8?B?LzRXeW5LS0tmeVpkMEZ0eXZqdmFUNTFvOGt4Qk5YaE5Xc2RHeUsxK3c3c3lH?=
 =?utf-8?B?Vm1OZUM5c2lWWmxOUWNhWGREeUR2NjFjVktCNnVyTyt5T3EwT1dEUWxYa1dZ?=
 =?utf-8?B?dDFnd2xOYXlGbEcrcWQ2ZjlFRkxneFJOM2k3M0hPVE1BdXI2bEwyOUlsN1Jx?=
 =?utf-8?B?cTVlN3o1UCtlcjR6aW5ITDdjdzZKaW8wdjJWSmsxVnpIZUhGNDUrY3UrbzBR?=
 =?utf-8?B?WUwzK1ZqYzZ6VWRwL2pUc1hsNDdGOXlQZXVmVFN5OFJsTHd4TlNGVC9pcUlq?=
 =?utf-8?B?YXFzRWlXdGtMOWxvZWVGZGxuckk1Z2JPcnpLa0lma3h3RWZxMExXK1dZa01S?=
 =?utf-8?B?c2g4eVpQZFpvclNjSENnYVJDNWtFZ1diUFl4WmJLTWxjUGJLVFNiSjkrWUVs?=
 =?utf-8?B?b1Nxc3M5R29QenplSDdtZjNCR3oxQm9NSHRzZDZHT01uU3NEa0dqbmlSRWFS?=
 =?utf-8?B?bnoxNDRQb2JkTG9SMUlLSWM4ZlZIektVMXBjMjNkZ0NTZTFqbUxSZGdGaGt5?=
 =?utf-8?B?YVZlcUJYeXorSXdIVlZkRHdRTWpoVHdGS2txdnM0bEVzVmJrUUdOajZ5MFFp?=
 =?utf-8?B?RmdaT1lKWVBoMVlUOVhGNkJwUGtXNjNwYnYwTkZQSTFRMW9HT2lOT3lyb3Vp?=
 =?utf-8?B?bm5iZkxHZnVxZ2NuWnZsZFlpdEsxMGlkTFA2VE1QRElQdlhqb3p3UmR6czIw?=
 =?utf-8?B?TU9SbXhTWVVwUWIrQ25CNS9jNGh4VTRPOERmd3J0R2RTZGd3eHMxWlVwK0N6?=
 =?utf-8?B?OFB6dlRDWE1jc2xVYllIWmxnN3RqMmY5SXhtaGE3em43Rmx0ZllHYStPazlK?=
 =?utf-8?B?WUxhUlI1VXBkNUVsV21WN0RkVU41dmthWm5lbk5halMvcWMrL0hpTkREWmFn?=
 =?utf-8?B?R3NpWUE2TndDMlplb3ZZNVlBOTRYLzJ6cWxFd3ZNc0NhaFlTTDc3UitZbFJm?=
 =?utf-8?B?TVpqMWU0VTIvZEhnUENtVFJ6cnNoazErdk82Zk8wMXJKemcwbDEwZ1QzcTN1?=
 =?utf-8?B?alVrZUNGcUtuWHB1S1VUUWJZMitybmg5SElPZ2ZPckNzWXFOYnRTWlhGZlV3?=
 =?utf-8?B?ZkNucERVdnZkNmVTSjg0Y1d2S2xBbUdnWldsMWFhc0hmRnRIRjZXSzM1Q3Q1?=
 =?utf-8?B?bFRNbnFlQnMvUE44Z1pmT05NMEpwUDVRbDEyL3A3VVVqRmZCUEVsYnVCd3VS?=
 =?utf-8?Q?gKCY5ncLwRiXYM0w=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce91ffd-b157-4dc9-75fb-08df1d33a2cd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 07:39:32.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVa5CUjRhq/HyV5xLGZSs4wsieiRLD20nij+JHa+WBxb8iY9xTNIEZD/ZPSEfe9mqUkSBTA0RT+vbkKCi6TVqDZrkEOx+7F4FF97Qg8cC+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9498

On 9/26/2026 6:26 PM, Max Staudt wrote:
> Thank you for your patch. The general idea sounds useful, and at a quick 
> glance, the implementation seems sound. I'm not able to do a full review 
> - please wait for a maintainer's reply.
> 
> Comments below, from the point of view of a simple CAN driver's 
> maintainer (can327).
> 

Hello Max,

Thank you for taking time in reviewing this patchset.

> 
> 
> On 9/25/26 11:45 PM, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> The IRQ handler fills skb_irq_queue without a lock and the finish helpers
>> then splice it into skb_queue under skb_queue.lock. This breaks when a
>> driver uses the helpers from more than one IRQ line. On NXP S32G2, the
>> flexcan handlers can run at the same time on different CPUs and corrupt
>> skb_irq_queue.
> 
> Please add "Currently, " to the beginning of this paragraph.
> 

Will do in v7.

> 
>> Add struct can_rx_offload_irq, one per IRQ line, which holds
>> skb_irq_queue, skb_queue_len_max and the mailbox range. skb_queue and 
>> napi
>> stay in struct can_rx_offload and are shared by all contexts.
> 
> The IRQ naming gives me a bit of a headache. It may be IRQ in the case 
> of flexcan, but can be something else in other drivers. Also, _irq gives 
> the impression that the struct stores an IRQ, or at least something 
> related to it, but this really does not.
> 
> Can you please rename the new struct and concept to something else? 
> Maybe _queue? And then the old struct can be renamed to _common or 
> _shared or something. The maintainers may have better naming ideas.
> 

I agree. The name does not fit can327 or the USB drivers.
I would rather avoid *_queue, since "queue" is already used for
skb_queue, skb_irq_queue and the can_rx_offload_queue_*() helpers.
What about struct can_rx_offload_source ? The fields and comments would
follow (e.g. source_cnt).

For struct can_rx_offload I would prefer to keep the name. It is
embedded in every driver and used in the mailbox_read() callback, so
renaming it adds a lot of noise for little gain.

Marc, any preference or other view ?

> I think you can keep the name skb_irq_queue inside the struct, my 
> request is about the new struct's name itself. In the same vein, 
> expanding the new struct's explanatory comment would help - please 
> explain that *the purpose* of having this struct is so you can have one 
> per source, *such as* one for each unique IRQ that the same CAN hardware 
> may trigger.
> 

Thanks for this suggestion, I will expand the comment to add more
context regarding the purpose of the new 'can_rx_offload_irq' struct.

> 
>> @@ -351,64 +378,88 @@ 
>> EXPORT_SYMBOL_GPL(can_rx_offload_threaded_irq_finish);
>>   static int can_rx_offload_init_queue(struct net_device *dev,
>>                        struct can_rx_offload *offload,
>> +                     struct can_rx_offload_irq *offload_irq,
>>                        unsigned int weight)
>>   {
>> -    offload->dev = dev;
>> -
>> -    /* Limit queue len to 4x the weight (rounded to next power of 
>> two) */
>> -    offload->skb_queue_len_max = 2 << fls(weight);
>> -    offload->skb_queue_len_max *= 4;
>> -    skb_queue_head_init(&offload->skb_queue);
>> -    __skb_queue_head_init(&offload->skb_irq_queue);
>> +    struct can_rx_offload_irq *pos;
>> +    u32 skb_queue_len_max;
>> +
>> +    offload_irq->offload = offload;
>> +    __skb_queue_head_init(&offload_irq->skb_irq_queue);
>> +
>> +    /* The first registered IRQ initializes the shared state. */
>> +    if (!offload->irq_cnt) {
>> +        offload->dev = dev;
>> +        skb_queue_head_init(&offload->skb_queue);
>> +        INIT_LIST_HEAD(&offload->irqs);
>> +        netif_napi_add_weight(dev, &offload->napi,
>> +                      can_rx_offload_napi_poll, weight);
>> +    } else if (weight > offload->napi.weight) {
>> +        /* All contexts feed the same NAPI, keep the largest weight. */
>> +        offload->napi.weight = weight;
>> +    }
>> +    list_add_tail(&offload_irq->node, &offload->irqs);
>> +    offload->irq_cnt++;
>> -    netif_napi_add_weight(dev, &offload->napi, can_rx_offload_napi_poll,
>> -                  weight);
>> +    /* Limit queue len to 4x the weight (rounded to next power of two).
>> +     * All contexts feed the same skb_queue, so they share its limit.
>> +     */
>> +    skb_queue_len_max = 2 << fls(offload->napi.weight);
>> +    skb_queue_len_max *= 4;
>> +    list_for_each_entry(pos, &offload->irqs, node)
>> +        pos->skb_queue_len_max = skb_queue_len_max;
>>       dev_dbg(dev->dev.parent, "%s: skb_queue_len_max=%d\n",
>> -        __func__, offload->skb_queue_len_max);
>> +        __func__, skb_queue_len_max);
>>       return 0;
>>   }
> 
> This API is confusing now. It's called _init_queue(), but you've really 
> changed it into something that acts like _init_or_add_queue(). Please 
> rename this, and while at it, please add an explanatory comment for the 
> function above it, since it has grown quite complex.

Right. I am thinking about moving the shared setup done on the first
registration into a separate helper, rename the rest into
can_rx_offload_add_source() and document both.

> 
> The comment you added in can_rx_offload_del() is a positive example - 
> having more of this stuff helps! Actually, that specific comment talks 
> about "contexts" - please try to align that wording with whatever you 
> rename the _irq struct to, such as "queue", to keep the code and 
> comments consistent for the next reader.
> 

Will do, the comments will use the new name.

I will wait a bit for Marc's feedback regarding the naming before
sending v7.

> 
> Thanks,
> Max

Best Regards,
Ciprian

