Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C3347425B;
	Wed, 29 Jul 2026 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324101; cv=fail; b=cJJlbtbqUc9cx0APlM+wWkih5SXNJrmSZyMsogSaQmeqiWNTmuTInCY/Kp7aO3CybUgtza/tzevlXUrxUeYra3ozKUx9xxNO8v61WAYkse7zm8eaB/7xfL072khFU0tuajBYYoWX/Z+nbQr+Aio+nph3KaVJTfAD3kAZJq2rprc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324101; c=relaxed/simple;
	bh=ps+hLPI+jgr2al4iK959/zutSuf0dtiR0M3QibyuyQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lz14lIW3JNdHKxElmRQjx6xnMEh2Sx9MJ9sHqpsSpXVeh8GQ47q0g9sQmG17fhbp5NBwO0NPC4126Sq/Eqxc/fJFgX0UPA9LWaXh41sVRRbFKaSt1VBRKc/oSNjxT/r0lm48ylSny7UstYv0vHt3snvj/yFsUfNj2kWVjr95Bpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aLHGhAjG; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aLHGhAjG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUXde84sgwkVZO34u56xAlt7ukx98TwSg9D8G2xLMJHO9jWkYsBEPUrSyFhYAH66zpIayctWZwJJKkT9Q8JfPgGveM66t0cN6hZvVDbIXdp5nkPsCR5JCNKvTG21s/qHLeEn8vW5yOpmo+QrOulORphOnGQGeIf0nY1pDIdQVnoCiq9pU8tmfuPH/zGS0c0J3Igw38qZZ3Fj/VZmRXWiqjrYAUck4oM9yp0lCYQseN66mpygHEB7n4ueC7hx94RjAx7HO5jmIaxEyySWHjcYI3p4FO6tvbc4HqTJTwLj+xAYC/e8WeSIodqOAQzgyM0kSkwTpyWDW+kLnolBrn4dqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6b+ymJrccO0Ti++OXwB6Hd8LvbnU+YPewQe7gGVHEA=;
 b=muPb0WSOWdvEgvYttI02XMow8dr7RqSltSs9+7wOhVSCRC7ElCWpkXzbgfrabxGuWcKuDCvnOx7ND/wbhyzWtC/27Mx2r2/bLgBp2G+HJXXNmmMjRwHNQ+SaPM+s0IZJGCl9kE8H9/JMBYZkCjxS7HyAfvDSHUTO8jm9X1xJyr/CTBz0Efja9OFIk2rHzKIDQpyyrWKM5Z4HIs7S0e2DIMWkE/YIQf8endKGvViwO50dcg9WkJ9NrwLnMKgXfM1O5XKxrfOhXHUv5dJccM/5zhJuP3f5IoeFWNoLzl00Spp/6ykyxQRy1OoWMUIpEgk7oeVf2YC3Xg2BrwmpsqClPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6b+ymJrccO0Ti++OXwB6Hd8LvbnU+YPewQe7gGVHEA=;
 b=aLHGhAjG+wUH5Z7xaUb10HS6HTM3YMRysqv+CSS7fxRBlCpmDH2pEovPKWKWzrRMwbSy1Bh+PS/63H8gcstjQ6z2ECeOhys3wkbGmbBMylz8SblTW8vSkj6/VcFlpDupIshhoLAzHio3/KWd6/9MLLhOEc8/sIZxRCgMkG1HN+mxOZwF8U157BF0Dzn3r6l9x8pX0VM3XUDTzCZL7ql3WsNYHNk1NkMuOOJQM6RrjHFrB5TVQ4RdyfgnS/fvBG40xsfInkHCMjUIxkatI2yyD4mvZlNsj+HbIYWw1M63jyUrV7CKe2a0HjCdc/a+LTefK5t0sswWSEVSUCpUJ93h2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by VI0PR04MB10760.eurprd04.prod.outlook.com (2603:10a6:800:25e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 11:21:35 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 11:21:35 +0000
Message-ID: <11837e3f-8021-4101-a80d-3d80f13afef3@oss.nxp.com>
Date: Wed, 29 Jul 2026 14:21:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] can: flexcan: Add NXP S32N79 SoC support
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Angelo Dureghello <angelo@kernel-space.org>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 NXP S32 Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>,
 Eric Chanudet <echanude@redhat.com>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::20) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|VI0PR04MB10760:EE_
X-MS-Office365-Filtering-Correlation-Id: 285fc5c2-7096-421b-7ee5-08deed638cac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 /2lRgHMBdbclDyku+A0WM0fQ2TRN0cNRG2eXopsiI8JIZOO7nXoSHdojGDJWJ3140euFRQYJc55kkb3+Xn+CNeGetqZ+oFQX++IqrIRKg5VXLyKPiBFzURvtRAYbg1YIH0fxkUuo7BH+T05NpHNEA0pRJuKqqFncWcTrRcmfbxPlf770xdKMoB37Fz5F69z8HEt5THARArDYXUei+OhUzF7oxsn9wE8tBm1/AAzvHR826KqfzvCfL78XBUqHc9CwAx4reGAOf7hc9YfB8P/fnxnp2W7UNSK+nIgdmhbKtN8MNyFR0Z77QMR53KIk6jh+7EkxGFTggmpnggQIOgb8950tM7Rp2K2iaoJYp0lkT4ue555Bjv7ax6CAWDy2fuaeCjG2eRBdXDgWAHKqZMHv5lrPAn12eOF25PGh8zSTnv7+2RK9QC67Mdnud7DZZVjVrJnTiXi9ErxXjTCv/JkqR3+rDjI+RxyDXpeS7PaRiPNdR/HmTVm8Famkr8ro5WxYWfk4jHCkHexjsuD0P0YhLiwyDSk6HWM/0CBHTX41tYHKrZFTmAc2SN27xx+bnEkg6aRd6+OVoEluJow+yAtAJYXIOdm/4Z6BomC6HixdflF+/rJEV8WUR7iHqmZo5J7g3fFP9ZnMNzrEVD8sRtpC5DQXmRJor///cNM02sbmrH0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ellQK29pbmQydmYwT1c4a2o3RFBQSmVUMWx1VHZEamYwQTd2SlNBTjdTNHdF?=
 =?utf-8?B?VHlsNGM2TnhaVVRMc0RVdVo0NHM5QjJpd3VoUGdGeHNaNVBzM3FVUzkrZ0J2?=
 =?utf-8?B?Q0doeEhORys1aWJZdmd6d0pUVzFqOGx0T3U1cUVLM05QOC82alhvci9aeG5w?=
 =?utf-8?B?eUgwVUxIQTlKcXpHQjlDVmlGeWZmdTJYSWlVdnNXT2ZDbFkwcTAyTDVmcTBC?=
 =?utf-8?B?SlBNVERSL3k1cnptTlhPWXQ1Y0IzUzB4dUpPMm1xL0pkYW1VaGRROWQrTGVP?=
 =?utf-8?B?Vm1GVWpiVHhVYzd5WjBlYzcyUUNpSUVrTW9wS3VybXV0ZnJvRHNYWnBVSzBu?=
 =?utf-8?B?WmV6N01ha3lCb3p5MXFybzNiQ3pzUDg4RkZQZUdEQ1RhM2FCL2p6cWJad0hK?=
 =?utf-8?B?cVZFSEJEajNJNnJXVlVjZ2llbWtUTGljdUl6anI0MC9JWHpUblRrUGlpdlh4?=
 =?utf-8?B?aW0ySTdTSVE2dDVtRXFqK1RlRjhlVzZUV2FjNC9DcituQ0Uya04xT1prd25Y?=
 =?utf-8?B?OEVOUEtwL2YrQWw0Q3Q0dDhBeE5MTjV0ZzlObUw0OUVkek5MbmJBcE9rRlpm?=
 =?utf-8?B?OWNWZ3VVVm1RSzFCODRNU3I0aDdnS0RmeGZmU3FIT3F4WkY1VkZDUW1Ba1Yw?=
 =?utf-8?B?RDB4ZGFBam1nZGVlaHlkeVFRNlZRaUl1Slk0b1R1U2tDZisxVEJFWmZYc2U5?=
 =?utf-8?B?VG91RDhtbjV6bmhDczJXTDZOZmpzU1g2U2RhK21Lb2hoM2RwRTlYN3FQaTlD?=
 =?utf-8?B?cUdBemhubldVcFcxRmpYRmZPeHhDRTJGcWVScnhzR1BLa04yWDlraTQrYzNv?=
 =?utf-8?B?emx6WUhsWGVkMndYbkdaK2VrM0t6RDF0V3FualpiZnZ5OGJ3QXhCaU1WYytQ?=
 =?utf-8?B?cDZVMk9ucitCUXhzYXRMaC9PK2xCeXhLc3Jrd0h0SVdKR2k5b1NFZVMwTk53?=
 =?utf-8?B?QUR1OXE3c2RJOGFzaXVmZ3dUSElaV3pTbFF6UnM1OTc4QUVVS2IyYzVTQWZF?=
 =?utf-8?B?UStpOUkvWnlLMzZqeFJGdFJNWVQrN0t6cGphZGlvZTlqazJQeHJBU1IzajRD?=
 =?utf-8?B?S20zNlFxRUUxSWdzRnlIQnRub3RJWFphVWpJazRmQ1ltRWtJbnQrR1lUMUp5?=
 =?utf-8?B?NXNhdDdDRTRDeXR1Q3hEWUJMcE0vTmxoakRndTFNNnVSQnRJV3ZvZWUvalV6?=
 =?utf-8?B?NVcvUGdrd0lQMFhzUXY1V1hwUFRPUTlURUhDbUc1UXhUNkRBSkpjbmNUajBK?=
 =?utf-8?B?a2pKZGdyZlpZVDFnUzlqdGpzbUswOHRaWmZNTHlwa0ZaRGFqWS9mUC9OVnNM?=
 =?utf-8?B?SFBsYXp0NmlOcGZCLys4eDlCYXFrcXBEckxQTUtTdVgyMnFPd1YzdkJyaHZG?=
 =?utf-8?B?Q0RiNVNNK1hod21WYW9RRllTQ2tFMTNMeFhKbW1hSE1pOFcvRGt4WDhRbTBC?=
 =?utf-8?B?NDBaYTdSTENieWpVNFJFb2ZBM0FRWXBPWGFBZW9WNmxTN3hIUktVNnRCRndj?=
 =?utf-8?B?T0NLWHgwaUlZbDJid0hDSml1aTMvWnowNml5SjhsM2x4bncyNVhjZzJwVmQx?=
 =?utf-8?B?U043VnZKMVRPWTFYWEdqRndzUVNrQ0RTUlNqejVhNlpnMzROVXR3bjNNOVJ0?=
 =?utf-8?B?RTVWYjMwV0VjVzdGc0l0TFJ3Z1NHajJjelhZNENvblVVL3pDYnpOMytUaTVL?=
 =?utf-8?B?MXcwSHRMeVFtVml6cHJGNWhSRFdDQUp1L0cyK0hTcFc3cEk1ZElSSWhFUmZI?=
 =?utf-8?B?ZEhjTHVHTDJreG14QU5zbThENE5qZzJhUUZrVWJEUXVlRTBSYmt2NEVGU2Rr?=
 =?utf-8?B?eFZNcnpTdk1rUGlETU84OVJ4MHd5K3BXOGsyUVh2YjVmWmU2K1RXZlp2a2lV?=
 =?utf-8?B?QWpvN2ZkWmduQkVnSE5KS1V5VE1ncEFELzM4dENINGVMK0lWUFZ4M1kvVStO?=
 =?utf-8?B?ZlNHczc5cmdzdTEzelRyMEdNQ2REV0poL0phNzZQZmdtU1RXSURTdE9HUTcz?=
 =?utf-8?B?ZzNPa3NTZVViYkZ0cWpjTzlsMFFrUTJ1TUYzcldKVzMvUHB3YmdBV2NZbDEw?=
 =?utf-8?B?Tm1pZDlDcUZwd2RISEkxRkYybjhpaktMNnlwd0tOaW16RHhPY3d4cjRyRlA0?=
 =?utf-8?B?SGpOSi9HREhQV2w2dlVqUjVJUkN4amUySlFMT1ViZndlWk9UcmduZzV0L3Zs?=
 =?utf-8?B?NTg1RXJtMVppSFlQbFpYMGV4cjRrR1BFV1RvN3hUd2g2bjlQTzIvTFA0TXpl?=
 =?utf-8?B?RTRBMWVtREFPMHZXRUEwOFk4Ym9NbVV2b2VaNkVBRDg3bjRYTS9zMTV0b3k2?=
 =?utf-8?B?Vm9wT1dHanFxbnpJOFVFZzZ4RnRPaDl5ZVZWMVA4WGNnWng5ZTFFZnNQWjJq?=
 =?utf-8?Q?a3FEBIPr54P8rIss=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285fc5c2-7096-421b-7ee5-08deed638cac
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 11:21:35.7059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNp1B9+RKth3iZUP2UVgSBP+OKTMKxqqLFi9FB9doGL+RLETtlX2xI17fEXNYDkQ93cYPokfo4WzqV7Y4zMiI/lZMOzS416SYCsz9PanrLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10760

On 7/13/2026 11:53 AM, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 

Hi Vincent, Mark,

Just following up on this series.

Earlier versions got consistent review, so I want to make sure I'm not 
missing anything on my side. Is there anything still blocking it ?


Thanks,
Ciprian

> This patch series adds FlexCAN support for the NXP S32N79 SoC.
> 
> The S32N79 is an automotive-grade processor from NXP with multiple
> FlexCAN instances. The FlexCAN IP integration on S32N79 differs from
> other SoCs in the interrupt routing - it uses two separate interrupt
> lines:
>    - one interrupt for mailboxes 0-127
>    - one interrupt for bus error detection and device state changes
> 
> The CAN controllers are connected through an irqsteer interrupt
> controller in the RCU (Resource Control Unit) domain.
> 
> This series:
>    1. Splits flexcan_irq() into dedicated handlers for multi-IRQ platforms
>    2. Adds dt-bindings documentation for S32N79 FlexCAN
>    3. Introduces FLEXCAN_QUIRK_IRQ_BERR to handle the two-interrupt
>       configuration
>    4. Adds S32N79 device data and compatible string to the driver
>    5. Adds FlexCAN device tree nodes for S32N79 SoC
>    6. Enables FlexCAN devices on the S32N79-RDB board
> 
> Tested on S32N79-RDB board with CAN and CAN FD communication.
> 
> v6 -> v5
> - Addressed a couple of cosmetic issues on patches 3 and 5 .
> - Removed dts related changes as they should be sent on different review
> list
> 
> v5 -> v4
> - Simplified splitting rx/tx masks per mailbox IRQ line
> 
> v4 -> v3
> - flexcan_chip_interrupts_enable(): disable/enable all IRQ lines
>    (not just dev->irq) during IMASK register writes
> - Split rx/tx masks per mailbox IRQ line (struct flexcan_mb_irq) so
>    each handler on S32G2 only processes its own MB range
> - Added received Acked-by tag on DT bindings patch
> 
> v3 -> v2
> - Split flexcan_irq() into dedicated handlers (flexcan_irq_mb,
>    flexcan_irq_boff, flexcan_irq_berr) to fix duplicate event
>    processing when multiple IRQ lines run concurrently (new patch).
> - Added flexcan_irq_esr() handler composing state + berr for S32N79
> - Ordered quirks used by s32n devtype data by value.
> 
> v2 -> v1
> - Renamed FLEXCAN_QUIRK_NR_IRQ_2 to FLEXCAN_QUIRK_IRQ_BERR to better
> describe the actual hardware feature
> - Appended new quirk at the end
> - Switched from platform_get_irq to platform_get_irq_byname usage
> - Updated interrupt description in dt-bindings
> 
> Ciprian Marian Costea (6):
>    can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
>    can: flexcan: disable all IRQ lines in
>      flexcan_chip_interrupts_enable()
>    can: flexcan: split rx/tx masks per mailbox IRQ line
>    dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
>    can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
>    can: flexcan: add NXP S32N79 SoC support
> 
>   .../bindings/net/can/fsl,flexcan.yaml         |  30 ++-
>   drivers/net/can/flexcan/flexcan-core.c        | 226 +++++++++++++++---
>   drivers/net/can/flexcan/flexcan.h             |   2 +
>   3 files changed, 229 insertions(+), 29 deletions(-)
> 

