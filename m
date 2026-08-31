Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357CC3E025C;
	Mon, 31 Aug 2026 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165396; cv=fail; b=a+G3QHcSw+18t6v0ImTfld2iZL+z7jlxhF/gfkpkPP14z7lFBtdhv7cTazNBrpvsHTB4gxMmUeiNjHf/vrUdbC3VhU6RBuUm+b3akOKxv6HvDZcpvS2UrLxkcq0UC8tQPv9LQr1iJKebGq5dX4WID5v0JyQKGPXPklcpAQD4N/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165396; c=relaxed/simple;
	bh=wyB2WDaOgRZK9lVHWt2oPoQbnnM7MIX40zkztphMy78=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kbNQmcwqP0aECI/DeU6N0m0jGzNsCOU1od3oajvd1FcXnez9jlvPmEJiCWQx7GmTLU1YvWkGH0xKwGzwPHWJH9mob3Xi8PnnG2hXUO2iEkVG9B1lCkkJVeO/lCEZXISHnjIL775QhBc+qPz4gfTiyy4otttQpyafR495qYx0IEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lCJtJq1j; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lCJtJq1j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwQVRBp74jpgWtS5XLjgvjEJT7h5iTPwUMY2eon4lheWe2FNXccplBVI6VXTCrL+nRVcVLw2jwW5WsV5fgLV9+WLcmOSoFey9pcZelEjzg63oy9WeMMCH554E+DQxnsQKpRQGvfaiYRboHxpeEiMR6FrclBXlKTfGxbpGgXKfSf3hULVsHvPaFI2XR3T35xCAFlU6CTPq3kpUr05WQojIr+IrvJBSg4j+b4DmmsecYcM5hWA6COOpbtg1ndXeZvQMEhmn4SsAcvKeHHPoJgLx2b9EOhpMz7jANsTI6hExnVWb3cezuD0nQUFECM9K/I1MPUopcBDCL/aEok7iDz80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cv5k6A3l8RfPBF6NTBAlkfVnr5OzCMVvF2XAa36s50=;
 b=ZX0cpz/Zbm6gqXOMn/F9N2JawrEJksoxNIz/BAJLRvf9O8qzN0EL3ZD15oqUyRvJWj6E9r+RQkXcQMzGPhL0unjG7hSVZRd7NOi3ckLZug/uVjvRXpHg/paU+9ypF3en0yLzC5BAudnwd1aOyqhJHPddqrzEY+OrpNwF6UmgKF/jA7ggUREvW0qMLqdWA29fbRnDcY/mrYa+mbRK2Pv+SZXxTZg/X308y3RAaEQyYn3JqjbTxvdwtxpTAmlzh4hdfZRXSeFaF58BKvIdAqJjUsTxUl+uuY5kGJdS32teILCTrlDKSpwnpvCJuD85prjKtTyfEjKmxZGjhWKe/ZKAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cv5k6A3l8RfPBF6NTBAlkfVnr5OzCMVvF2XAa36s50=;
 b=lCJtJq1jqDuEuQoWdB+gYrmfH2u0nPiDJDQJlpeB1eRg7sHDOWTrkCT+cggKkRv1R9L344TLNaUjSFDVY+a6YJgeb0KuC3AV7eEe5JBKus2Mecq5dKS6bc9RkQiC5bl4ELlzrHJTBXANGSxtkTRm7StebtDz3wMc1Oa6IwaGQF2npj5Xgrf54JfH/HuQ0LpIMQc04Sn6pzuFMgE7oLXltYUtL+VTgiaVLChafzf2ZkCwfNOzBTSG+cjF/5ZniJWxc9sEcS61ixEYmUgpmeWRTqAf5xey8JB9UgFV/skeWEXYCtOQS8dI6+gHan4mRhRlJaf93Tm8VlE/6y9RNTPVpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU6PR04MB11157.eurprd04.prod.outlook.com (2603:10a6:10:5c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:36:02 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:36:01 +0000
Message-ID: <b55b79a1-a20d-4c61-b02f-dac64d1d32a6@oss.nxp.com>
Date: Mon, 31 Aug 2026 11:35:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] can: flexcan: use dedicated IRQ handlers for
 multi-IRQ platforms
To: Bough Chen <haibo.chen@oss.nxp.com>, sashiko-reviews@lists.linux.dev
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, devicetree@vger.kernel.org,
 Frank.Li@kernel.org, imx@lists.linux.dev, linux-can@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-2-ciprianmarian.costea@oss.nxp.com>
 <20260713090746.D2B4B1F000E9@smtp.kernel.org>
 <20260824083241.4spcdohbsot6x4wc@shlinux89>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260824083241.4spcdohbsot6x4wc@shlinux89>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0177.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::14) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU6PR04MB11157:EE_
X-MS-Office365-Filtering-Correlation-Id: b21cde15-5415-446b-26de-08df073ae381
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|19092799006|1800799024|376014|23010399003|18002099003|22082099003|56012099006|4143699003|11063799006|5023799004|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	xHt7nu8t2oWqxwxVRhMFq0kkgL181fvK/OPX2bvPvbizntdZDuX1D2CvoSJfGSQFYwCzo3y+kZUHj0/U2pEo6DI5ElWoV6uqEYlRBMBLYCeltZK0cTOBhLPucgZe0SGFDWZzJ8P7oPYglMNsYVoYX0v9wK8DDOc0vByT0s+aXFpsTBKg/pnbfzstlT/lYtvi93p0bREzdtXwbrWZz09smEa3mW5/JUnG4Xv0ZwYzQVg/khsYkC4QLgCE6jVCFISsjLFV5uFc6vXcLtM9vvDQVVV2ndHyFbs+94y2L3ukyyH2BE4OJZI3QgKMp3pz+89+IuuII7enEkncDpshwH/d2tCUUg5pl1zK7Woj1tQy/NyrGZx7kf+YEbEWh2g0UHchRDG+dXJwMXSUcUlP1GXl8nAex4pov9D4PqI86mo5suwOzIunZ/y6riIe1ot2k8iEJAz4EiQvx1CUeI506iaUydZ31t8hZO+u1GMLQdHV80NfRVoolENKqYmGFxk14TrIjs4HJsZCD+QQ2TS8ADuYc0ITqKIbuToWngrjR+AnpYcHjt9eUOpz58sd4asNvz3f4320khI2HWBrOfbn1273eFGZ8TSTVAqDcyfO1ywqTPM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(5023799004)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmV0bGJyVEd4eTlrUnZ6RnVreDdrNHNUSURPaU5MVGNUWUNFZDRibEd0WUpF?=
 =?utf-8?B?SUJIcW1QRlA3cEhGbnByTTZ3eDQvOEhsbVNRcmVHQWI1eHo0OVpRRE03UHhq?=
 =?utf-8?B?U25KWUxSNDBPbDIrQWdIa3IvcHF5c2srR0JMaUpXR21rUGw1a1hPdXp4UUYv?=
 =?utf-8?B?amx6TUlFOXhRY3Z5cVVoNjBSa2Zsb3FBcytlQ2s3OVlTdnJsaTRBQnY0NU94?=
 =?utf-8?B?UFI3U1Zaem1TbEV0VHFTVXdWOVNCSlV0Y3N6UWFJSU8wQ1RDZGRHd0xPUlp0?=
 =?utf-8?B?M1V5ZlJNU3NkMEpQTmREajNycUVqUU9LS0FkaWp0L3NpQU1pRGlEWjB5azFy?=
 =?utf-8?B?b01tMFVRKzR0T0pIVlBoTGF2bkdPWlBUc2JrSWc1Y3l4c3NFSTViZHVEeTcw?=
 =?utf-8?B?Qk1leDBnU0QraWhRbUdVU2tqM21xNnhYbi80eTFVaXpoODd3ZUxZQmNFZVQr?=
 =?utf-8?B?MzBQS2ZIblVoYmZTMklPdFdmMlU4LzZSbDI4ellMaHNEVzBHY0t1MFV5aUg4?=
 =?utf-8?B?WlpEL1htdXIxYUVYeEQwdHNHS2p1UHBmNzdFR2FuVURjN3JjMWQ0WU5ZalA1?=
 =?utf-8?B?NVh3cnJsL1pYNDk3djVRZm1JdUJ3RTlsd296UDRLb3JUOG40cVBhVlg4SGcv?=
 =?utf-8?B?U3pkZjJrbG4zTWRUeXdFdGRwb2xmWi9hY0dpMTZqVGQ5Zzk2enFNMDhoazgy?=
 =?utf-8?B?NGR2R1g2cEFmOTk5SnRQN1pPcndwUFM2VXhKUW5abTVkVkgrdTVYOXFyWEx5?=
 =?utf-8?B?MjZ2cmNPVlVBS3I3Y3d4SnNrZDcwR2RGcnpNK3hYbWpYbUxKSjJjWEkzOWJW?=
 =?utf-8?B?NXVMYkl2bHVUTisxc3VQU0N3bTQvY01xZDlNQmFxaFVZY1J6ZW9xRy9TNHJU?=
 =?utf-8?B?SjdXcU1TREVHS0VkcUNLRWU3N0I4VDFIZXRGSk5WY0k4ekYxN2l6VWpPR24z?=
 =?utf-8?B?cDdvMzcvZzF0R0hDTEIzQzRMdUZpcFluZFlCNHUwT2p0YUFKS0w3OURiRTlj?=
 =?utf-8?B?ZXJ5NGN5bXkxVzdmcWpjSVFqbHJtaWdsNHpUTlhpbW12RXhsVm81ZkhZNi9l?=
 =?utf-8?B?OFlMUU5PNUhINzFYOEUxdDdhMTNJVmtJTFQ2dTBzZEFrcm82S1A2d3FpZE11?=
 =?utf-8?B?YnBqSEsxTUN6Y1hPYWkzVllKdDhheThmV1dBajZTQVgrVTdkVktCQnorZ254?=
 =?utf-8?B?bzl0Uk9nR1ZJM093MDdEeGtIRGwzcHpBR0VUd3BVMWVoT1BRbVNSc1B6aHBC?=
 =?utf-8?B?a3NNRGRZK1lYMGY1OXEvVjVBREszMmc0R1ZtRnRucU12QXRqeXh4N2U2V1Fl?=
 =?utf-8?B?ZGN2QkRjRng2dWtSaXU0bHNKcVJQOXRXOHlxcE1LV3BhbmhMbTh4UENIdDBJ?=
 =?utf-8?B?VmhzSmMxZjVnRWZEZ0dWODY2MUZYK3lxYnljNW5ndGw1Z1JzaytzZFVnUndM?=
 =?utf-8?B?cWo4MTdwdHkvdkFHRUJobENSZ08zUUNzb3JPUVUxVGQzaUJhOFNIYnl6OUlY?=
 =?utf-8?B?RlBYT3BDRzRtNTB0QXRlWitiT3lpTGtZcG1QUldaUkEzR2NqdmtvQ21vV0lq?=
 =?utf-8?B?ei9ISEIvVW1NZlRhVVhxbUVSTDk2c3NySFByVVFoMUNhQ2ZXQW1qTFFWa05R?=
 =?utf-8?B?NnVIbFFnNjRjVi9uSGV3UUZ2UWgxQlBxMFNVWnhDSFl4dUlCYnNmaVZrd2dF?=
 =?utf-8?B?eW9kbmZocG1XSm91SzVORElwNkE3Q1BZcWtQKzZvMXBKSytJSGI5OWFHbmtj?=
 =?utf-8?B?Y3JZY1AzUm12NE5VaTFKVWwyYlVDbE5MMFVFSmRESlVCTm55dHVic3JoQVJa?=
 =?utf-8?B?TmlxSGhYSmJIa0hpUGtOYUxhd3FzSm5sM2NNcC9acVU0clRBQXgvR09USEhC?=
 =?utf-8?B?ZFhvc01LNHpQZFVoYzgrMTNaNXRNZFR5TjVDRXVrNEc5NHI1TTAzekIwVnV3?=
 =?utf-8?B?SzV4L0FvcVJXRjk3b0lxRGlTZ0hYNllpa21DWTRnRzl5Z0VWbzB3cUM0ZXZI?=
 =?utf-8?B?NmcxWG1NYnY3dWlycmY4K1Q0V3NOdFoxSStrcG1rRXNKOXdTTU1DQU1od2xr?=
 =?utf-8?B?NVhHYy9oL1F2MGx5STVEWlNoc3BYQmdLVTNhekdjQmpkY3k0QVNVRUFSZEto?=
 =?utf-8?B?ditQbk9LTjBmVlRYcHBMcXN3VFBnYmJPQTU5VWIrTEovNEROVkxHUmtoQ2hS?=
 =?utf-8?B?M1N4YWtsTXdLT1k0OEtsd0hIeloyLzNJZHFWS2RUOS90Y0VzbEczemZFRGMy?=
 =?utf-8?B?SVNzbnZWd3ZQbXFSRGptQjB4STcveFZiQ0c4Z0pyVHNCUzdKWExoZUFXeTZH?=
 =?utf-8?B?eEZRUm9qMU13U0FtSUJvVENkMVJwOVNuTURBVzc2MUgwMy8yVmtyQjRuRUdC?=
 =?utf-8?Q?YP8LSoPf3tP2WHvI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21cde15-5415-446b-26de-08df073ae381
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:36:01.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugqfwy+IAy1MLHA9S9Av8iG5osbuW3KLoEV8hhaTlqvzXUVT6njsQ0hrhlVTzOEFJcrYtQWCZh/yT1OKcAFsSgjvQjioCa7pPJ/LWGwUc70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11157

On 8/24/2026 11:32 AM, Bough Chen wrote:
> On Mon, Jul 13, 2026 at 09:07:46AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>>
>> New issues:
>> - [High] Splitting the IRQ handler breaks the FLEXCAN_QUIRK_BROKEN_PERR_STATE workaround on multi-IRQ platforms.
>>
>> Pre-existing issues:
>> - [Critical] Concurrent lockless modifications of `skb_irq_queue` by multiple IRQ handlers causes list corruption.
>> - [High] Incomplete fix for duplicate frame processing on platforms with secondary mailbox IRQs.
>> --
>>
>> --- Patch [1]: [PATCH v6 1/6] can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms ---
>> commit b6f6f5d373c333a28a06c2ed84ea386f9dc5b122
>> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
>>      
>> On platforms with multiple IRQ lines (S32G2, MCF5441X), all lines are
>> registered to the same flexcan_irq() handler. Since these are distinct IRQ
>> numbers, they can be dispatched concurrently on different CPUs. Both
>> instances then read the same iflag and ESR registers unconditionally,
>> leading to duplicate frame processing.
>>
>> Fix this by splitting the monolithic handler into focused parts:
>> - flexcan_do_mb(): processes mailbox events
>> - flexcan_do_state(): processes device state change events
>> - flexcan_do_berr(): processes bus error events
>>      
>> Introduce dedicated IRQ handlers for multi-IRQ platforms:
>> - flexcan_irq_mb(): mailbox-only, used for mb-0, mb-1 IRQ lines
>> - flexcan_irq_boff(): state-change-only, used for boff/state IRQ line
>> - flexcan_irq_berr(): bus-error-only, used for berr IRQ line
>>      
>> The combined flexcan_irq() handler is preserved for single-IRQ
>> platforms with no functional change.
>>
>> Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
>> Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
>> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
>>
>>> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
>>> index f5d22c61503fa..f73ff442d5304 100644
>>> --- a/drivers/net/can/flexcan/flexcan-core.c
>>> +++ b/drivers/net/can/flexcan/flexcan-core.c
>>> @@ -1188,6 +1218,65 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>>>   		}
>>>   	}
>>>   
>>> +	return handled;
>>> +}
>>> +
>>> +/* Combined IRQ handler for single-IRQ platforms */
>>> +static irqreturn_t flexcan_irq(int irq, void *dev_id)
>>> +{
>>> +	struct net_device *dev = dev_id;
>>> +	struct flexcan_priv *priv = netdev_priv(dev);
>>> +	irqreturn_t handled;
>>> +
>>> +	handled = flexcan_do_mb(dev);
>>> +	handled |= flexcan_do_state(dev);
>>> +	handled |= flexcan_do_berr(dev);
>>> +
>>> +	if (handled)
>>> +		can_rx_offload_irq_finish(&priv->offload);
>>> +
>>> +	return handled;
>>> +}
>>> +
>>> +/* Mailbox IRQ handler for multi-IRQ platforms */
>>> +static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
>>> +{
>>> +	struct net_device *dev = dev_id;
>>> +	struct flexcan_priv *priv = netdev_priv(dev);
>>> +	irqreturn_t handled;
>>> +
>>> +	handled = flexcan_do_mb(dev);
>>
>> [Severity: High]
>> Does isolating mailbox handling into flexcan_irq_mb() break the
>> FLEXCAN_QUIRK_BROKEN_PERR_STATE workaround?
>>
>> On multi-IRQ platforms with this quirk (such as MCF5441X and S32G2), the
>> hardware fails to trigger a state change interrupt, meaning flexcan_irq_boff()
>> won't fire. The baseline driver worked around this by polling the state via
>> flexcan_do_state() during every mailbox interrupt in the monolithic handler.
>>
>> Since flexcan_irq_mb() completely bypasses flexcan_do_state(), could this cause
>> the driver to silently miss CAN error state transitions (e.g., Error Passive)
>> when the error rate increases?
> 
> AI is correct, need to fix this in next version.
> 

Hello Haibo Chen,

Thank you for providing review on this patchset.

I'll fix this in V7 by having the bus-error handler also invoke
'flexcan_do_state' when the 'BROKEN_PERR_STATE' quirk is set.

>>
>>> +
>>> +	if (handled)
>>> +		can_rx_offload_irq_finish(&priv->offload);
>>> +
>>> +	return handled;
>>> +}
>>> +
>>> +/* Bus error IRQ handler for multi-IRQ platforms */
>>> +static irqreturn_t flexcan_irq_berr(int irq, void *dev_id)
>>> +{
>>> +	struct net_device *dev = dev_id;
>>> +	struct flexcan_priv *priv = netdev_priv(dev);
>>> +	irqreturn_t handled;
>>> +
>>> +	handled = flexcan_do_berr(dev);
>>
>> [Severity: Critical]
>> This is a pre-existing issue, but does having dedicated IRQ handlers
>> running concurrently on different CPUs cause a race condition in the rx offload
>> framework?
>>
>> If flexcan_irq_mb() and flexcan_irq_berr() fire simultaneously, both will
>> eventually call into the CAN rx offload framework (e.g., via
>> can_rx_offload_queue_timestamp()):
>>
>> drivers/net/can/dev/rx-offload.c:can_rx_offload_queue_timestamp() {
>>      ...
>>      __skb_queue_add_sort(&offload->skb_irq_queue, skb,
>>                           can_rx_offload_compare);
>>      ...
>> }
>>
>> Since __skb_queue_add_sort() locklessly modifies skb_irq_queue, could
>> concurrent execution of these handlers corrupt the sk_buff linked lists?
> 
> Yes, should be handled in another patch.
> 

I want to target this fix separate from this patchset since it is a 
pre-existing issue and the fix will most likely touch shared rx-offload 
core.

>>
>>> +
>>> +	if (handled)
>>> +		can_rx_offload_irq_finish(&priv->offload);
>>> +
>>> +	return handled;
>>> +}
>>> +
>>> +/* Device state change IRQ handler for multi-IRQ platforms */
>>> +static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
>>> +{
>>
>> [ ... ]
>>
>>> @@ -1761,25 +1850,30 @@ static int flexcan_open(struct net_device *dev)
>>>   
>>>   	can_rx_offload_enable(&priv->offload);
>>>   
>>> -	err = request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
>>> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
>>> +		err = request_irq(dev->irq, flexcan_irq_mb,
>>> +				  IRQF_SHARED, dev->name, dev);
>>> +	else
>>> +		err = request_irq(dev->irq, flexcan_irq,
>>> +				  IRQF_SHARED, dev->name, dev);
>>
>> [ ... ]
>>
>>>   	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
>>>   		err = request_irq(priv->irq_secondary_mb,
>>> -				  flexcan_irq, IRQF_SHARED, dev->name, dev);
>>> +				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
>>
>> [Severity: High]
>> This isn't a bug introduced by this patch, but does registering the same
>> flexcan_irq_mb() handler for both primary and secondary MB IRQ lines leave the
>> duplicate frame processing bug unfixed on platforms with secondary mailboxes?
>>
>> If both IRQ lines fire concurrently on S32G2, flexcan_irq_mb() is dispatched to
>> both CPUs. Since flexcan_do_mb() doesn't check which IRQ line triggered it,
>> won't both CPUs unconditionally process all mailboxes, resulting in every
>> frame being processed twice?
> 
> I think this is fixed by PATCH3.
> 
> Regards
> Haibo Chen

Yes. It is covered.

Best Regards,
Ciprian

>>
>>>   		if (err)
>>>   			goto out_free_irq_err;
>>>   	}
>>
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com?part=1

