Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C9F3E49D5;
	Mon, 31 Aug 2026 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178123; cv=fail; b=A4eKnxujUF8WenvqVcn2Cc27iNpnN2R039kXDgVPeOz+/TbWOZtz+xV5xQxkz/2pMLVTp5gayXcAUiT+pRh11ped/TmYJyJkNiLTBYfLNqWQPKa5UKgmshWqDMJj+QSNJiraeVJ/vOYVQHdrquaVMqts0391jyjbGYouOqv+6C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178123; c=relaxed/simple;
	bh=dIAZhYjnYjvLRWkaMLh+9yxpywtlVmYAlWW7yuukUEM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jlrJj6a/rQree5LQX5XebvfOf/BBzQjNxf231X4n8F7qoDFzS4La0sd6s3WKOOlGrVHAjhCKnZ2iR2PufG7LuPSYNVftF4B5ruSHk3yWPpSf9qnZB7FCuyXwIP8jVoyXAtp7fjAol+Jkl5H9HvbrrfZhfaTwMKNMtH7lXFR4T8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OhYfWNPk; arc=fail smtp.client-ip=52.101.70.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OhYfWNPk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvQXYb5c64Os8LNSQNGsq9sSLjzasbtv78LGFJXUF8iHL0b/Kh5ViXlGCLEs5kMtQJ/gcCV82Rk416eYiNClInpl44xFEkwmF5yURuDp+IG2tvwhAdeJeBc4kFvOY4zbyETjq3cbTxopAM9mf9qvW9lNtiDE1XhXZHWKdU3ZyxBqYkK6dmmD+qOwPbwNRAxakMNznKaX4XAvNB/XJupzxoc4PFxf0LVx6qQUvsnWJn6TaQwhk6Zk8Sjmu0KJLmdan/gESmCyHzgZhFqK06W8v8mYnOm5Bgl6aei+vbkbWAnfD0FpNicU37BJT3XWQTLfwKr2O6MVIrrNdITWmWmzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKhlZQy2oQUcoYpvY9FCk52zrw4dIHyeqaHnqW9BB7M=;
 b=oBC6gHIcJIuJ0xxzuV8FeE5/jm+eBbGmc6yExrn5926Zz03u65nZ6mocMRSUKF65/eYPxRVcphVV2cfUlXzPvspzFYEJcDMDZRNQkpVL4OgIxx5ENeBvxcOIladVcOlyf8PCHvqUknrdlbC5/whWRnUBpKv+PAaAGrEF3NZybIG5/k9H7Dg0x+YiwKMSmoXsSrnazo1ZEiIH9oD7bmX+ZKbTCkE3z3MLCSjLXYhvE9VEZp2eQlGNdMffzEHRo/gDmfdhp6+hxuSuL3hvVnTmWnriUenh3n+IqeOSj/8WAD8pkCb0AZY2PiFFcKHbTAHZe0nhI0vZbFBGajbgUzUj1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKhlZQy2oQUcoYpvY9FCk52zrw4dIHyeqaHnqW9BB7M=;
 b=OhYfWNPkO/xW1SA4P8J/8L4qQWmi/3oSl4CzbCX3cGSBlrEUi3HSp29N2Tytwl8NHHdZ6+5CsVpiAS4ps3kSM+2g6vXtlqCw1PP5iMCIjWEZcvw9HAtUmRdEnB8uzb7ZkvMGccxIvZQD8OMlon+upkOU5ZsWDIVfHgQvjfJoqFDb4t3R4m/bJKme+NK+1n7fEFxK0VszoOeKMXEs3gGDhGx8ng5W2LkmtFU7oWhAQu6XRfMTqqCrsrkIa3u/5G3dhFzR1KgqOAoABY4OBiKwYXUeiqmfA8+9kBJah8TgOfCsbFcILGsh1FY6gXfSpZ/wkdGD3y5IHF/FHFoOiHoPnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by GV4PR04MB11972.eurprd04.prod.outlook.com (2603:10a6:150:2e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 12:08:37 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 12:08:37 +0000
Message-ID: <172b9e7c-3c8a-4bbf-8c99-a10412992ebf@oss.nxp.com>
Date: Mon, 31 Aug 2026 15:08:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] can: flexcan: split rx/tx masks per mailbox IRQ
 line
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Bough Chen <haibo.chen@oss.nxp.com>
Cc: sashiko-reviews@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org,
 Frank.Li@kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 linux-can@vger.kernel.org, imx@lists.linux.dev,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Vincent Mailhol <mailhol@kernel.org>, devicetree@vger.kernel.org, s32@nxp.com
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-4-ciprianmarian.costea@oss.nxp.com>
 <20260713090803.CCE2E1F000E9@smtp.kernel.org>
 <20260824101241.ysq45swzx4ihctel@shlinux89>
 <20260824-mustang-of-original-fame-4b3a91-mkl@pengutronix.de>
 <72930ce5-eb4e-44f7-a302-2cbb058d8293@oss.nxp.com>
Content-Language: en-US
In-Reply-To: <72930ce5-eb4e-44f7-a302-2cbb058d8293@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0187.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::24) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|GV4PR04MB11972:EE_
X-MS-Office365-Filtering-Correlation-Id: 75975313-0d67-4170-7393-08df07589633
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|7416014|376014|10067099003|6133799003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dVusYfVZl/Ad2K4euyB9YVEsSSmWnHLACQSx70IA1rWrVci6GKynh3Z3g2FX44cQ5FihIjoPOX3fjJS/eST+Ei0BqXzH/3xzguUwESiYfYc4899MFhOmYaG8OT2A6jN1pILq0yHKUg7T53GbRyeqb0c70FDdt806F3k97ymRhDMmfJXjAlL1EC4FWoraRAd9khZNkDvgg5EFf6P7fgHmiiTDBXaZHouH9Lx9qCmpahDIoAYjP/Kbcy22vW9kMobTsqjfjUW8cFz3IEsKSZJsKS6PU1KjJAJsbZH8HEBGe0ONxLhqMS7RGcij+XUavsmezZPI4VZBwlc6SfIbXAFcdOoZbC9Os+A7cwCj2f1hcSAXR2uQYqnkY1aGuh6Nq+jpBiFlcY95atrOKdKj4KNrydvPcv0UPmunnWGMN5gPQz5zjF3zI1R+HZACs6lYfHJry5YGo3LtVqzWTW9gSmvPztnad+nsCBKNbcbmjOFqOid3iDW6/YUHGWaWNRwG2ky4UmGTOuyZQLdlTEk1AbH7VRKORw9QGj4oDVfmtRD39oVE5/kSO8KO0rGUNgXo80xhYNUObSgVP1rJnckW5amxBQkZ/oA1AHPmpSFnHCz6bCFKF1QPfgnGItuE7cTgdCWyFQMH98XgpdN6+67r+KH3m4DsL3uKGYxeb+Gp0C9w+bc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2RVM211Z2NnMzluUUtQT08yL2pCQVUrSC9nY2ZLQzZ5RmJ4U1Zrb3I0KzRs?=
 =?utf-8?B?OFJ1bmxBeWdaays1a3I1Y0ZvT2wyNDV6NXFJU0RVR0o4ZGJJZmNMYlQxSGpm?=
 =?utf-8?B?YzZ3Nk4yL1JZaWlSRHYvZnB6M3JhcmkyZFF2cFR2NUpBRkQyak1hZFZQNFZD?=
 =?utf-8?B?VFJtK1VLNk9ScmNtL3hxVGZTM1IwZWg1Vm8wMHU5aHBVa0ZTNGRkaW82aHRj?=
 =?utf-8?B?eng5ZDVERFFWaW1GKzVMRUpDZjFyL28yMUlSVkZ5WVdrWVdUQzdyaWNaaW00?=
 =?utf-8?B?b2F4ejRCUUswY2R1MnV0bkN0bVMvdXloYlVwNzJra08wa2NON3gvOTB2dHZx?=
 =?utf-8?B?MGhEYy9XbklNL1QzMjQ2VzFBZDVVMFU3VFlkTmkwZDFJaS9yYm1pdmdZakwz?=
 =?utf-8?B?a0E5UWIvdlN0U1QvNDNERjE2MVNMSjRIOU83VWlDTnQzb0hyYmV4NEVVdDEy?=
 =?utf-8?B?Q0ZHS3FHRUtScjRjM3RtME9lbDVKNXlYNitDL2k2b3NJbGNHWThjeG8vamNE?=
 =?utf-8?B?ZjZobnVWUjJSWWczazRTc2t2TUhDVnBzN0NCUFRrMlo0N3Fma1lDeUpFWjdW?=
 =?utf-8?B?V0NEWEJtSVp2dUkwZ3MreHprOXN0cTJhOWw2Z0xNQml3U2RiclYwNlVxc09G?=
 =?utf-8?B?S0laZFNtL1RLQW5keFFHM0I4cWJGU3orOXZ4aTNLdkJMMmNhOVkxQ0RKM1J5?=
 =?utf-8?B?MDZObXF5NG9hb0x3clM0TTdBS01uSFpYZEtHOGlybGtnQ0ZIeU9BNXNETlhD?=
 =?utf-8?B?cjZHYUhya0s3WjlpZWFoZ1pWM25MUzR5bGQxSk9HRXc3Qnk3amwyblRjcXpO?=
 =?utf-8?B?T0xRUndqMDNOSHN3Vk9YZ1NDdW0wUmhCWGlkTjlUVGxOdTA1VVJ5d3E2OXd6?=
 =?utf-8?B?NjdUa0F3TUY4WVcwekRrOXB0bGZGTitZclpndnlUQTh6NEIycHdwQ3hSclRZ?=
 =?utf-8?B?OHR3b2VRQldXeXYzTEJlQ3p1aTdWN0doSklwVlNFMXk3ZHIxS2w3MWQwNEdI?=
 =?utf-8?B?blkxS01aYzcxUDRiY0tkdXJxL2xtYzlFeDVHTUtWZ3RBUWVFS1JHdTE1ZmJZ?=
 =?utf-8?B?M3NrYjhEY0ZHc0FtL1lNT2dBbU12L3UrNGJ2bk1rQXpOZG9vZWNmeWZpbVRR?=
 =?utf-8?B?T1dRS1ZpbGQrQTZxQUhKL2Y1a0FGL1dPeUVXOThhZENSV3ltTlNaU2JvMnk5?=
 =?utf-8?B?dnJob3JSbXhuNW1tbFJVVEV1U1hwMWFtZVpYR1hSOHhVWFZrZmNiN2RsNFBH?=
 =?utf-8?B?b1BwcWdja2EzVnFEaFkvRGJrT21nTVVuN29NRHAyTDV0VFhITVprYWpiRXRs?=
 =?utf-8?B?c29vcGpueDR2SDVXaHRSNTI2WE8yMVFqVEtvUzlFY3UrL0M0ZXJtaXFUQWhU?=
 =?utf-8?B?K1F2aEhKaWJpdXhsWjFIVkRCbm8zc045L0lKVDlQZnpoOTlnTmZQeFF2Wk1s?=
 =?utf-8?B?V0tyMU96YndWN3c0YW9CSTNyRnVEbFdDSWM1bFJ2RnIxNkppNEVySmFyaVAx?=
 =?utf-8?B?c3lQM2xTVEhLZ2hnMVkzU3dEendWYTRvaDVDR2xuanVNYmQwcEZNN0Zzb29l?=
 =?utf-8?B?VzdUSEpNUUxNaDY0M2pJZVhsZk1wd3FRc2tqRWJiTkJoZ0FzY1B0Yzc4SWpM?=
 =?utf-8?B?NnRaWnhycm5VZlo2Zm9oYWxMQUVXWE54cGJUZVJLVGg3RnlxanBxWnQ0bDhp?=
 =?utf-8?B?bERhK1h5dlNjYVM4K0krQ1lIZDJIbStQQitYRGFVR1lSbWExL3k3eHFJZ0lM?=
 =?utf-8?B?WVlOWlkrQ2F5Nzkxd0lwS3AxdHVCT1QyMVZJTlVCNFVUOUs4d1NOcC9NYlNj?=
 =?utf-8?B?RGF1RUNGcjRaZmNqeHpZQXIreVAwczNhbDM1UUpjTDJJaVZnVUtQSWZpakp0?=
 =?utf-8?B?MGJwL0xPZzM2dThsT2I0VisydjR1K2FwRWZucVhYckdzVGFISmRkM3BoNjQ0?=
 =?utf-8?B?OVFVUFJvMkF3UUZkejZ4K0pxTks2aFBwTGl0MlRXMkJVUmRlek93Z0R4Mmov?=
 =?utf-8?B?U0srZmE2TU1LZndHaDEwT2UzUDRoc2tHUU0xZFlNVWdxMWNxMktZUkF1SEF0?=
 =?utf-8?B?aERTS203akxHM3UvR3pJZ2xOenVRYmVzRFUyZmgyVThsR1NoVis4T3NDOVEr?=
 =?utf-8?B?TmhDcVhDRnUwVEtkbTdMNFdZZis4TjlGclpuU2RaUmovRDk3dkZOMVc0KzQ4?=
 =?utf-8?B?SXVEZjJBdVhVTWs3NHVYd0F6T0xsYVlOTnVxOE9lTzFhSzJOWU5UOHJ3OTNM?=
 =?utf-8?B?QTJjdllIbHJmc05yUFlJNnkyQjM5dUFHT1RKN2w5MG94OHh1TVRyVlZXY1JY?=
 =?utf-8?B?SWRZVzN3SDhoVUJoUGFzUk9GdXVCd1FuRWVSbnpqMnJqeTZuSzRkWDZsblho?=
 =?utf-8?Q?fBCHRcAZ7tHQJvzc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75975313-0d67-4170-7393-08df07589633
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 12:08:37.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fT3Ue/n4+hJspXGdM/GUg9NgQnjzrzHbgxeggRls3Fb7kiRu33NSnig42H92JcwNHhTZnwKOdQRVUjLS43otloaO2gxBYbl7ejT7qHdHrSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11972

On 8/31/2026 12:29 PM, Ciprian Marian Costea wrote:
> On 8/24/2026 1:16 PM, Marc Kleine-Budde wrote:
>> On 24.08.2026 18:12:41, Bough Chen wrote:
>>> On Mon, Jul 13, 2026 at 09:08:03AM +0000, sashiko-bot@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 1 potential 
>>>> issue(s) to consider:
>>>>
>>>> Pre-existing issues:
>>>> - [High] Concurrent execution of multiple flexcan IRQ handlers 
>>>> causes lockless list corruption in the can_rx_offload queue.
>>>> -- 
>>>>
>>>> --- Patch [3]: [PATCH v6 3/6] can: flexcan: split rx/tx masks per 
>>>> mailbox IRQ line ---
>>>> commit 9f143e05fb5957d463ce1d05d4126d168798b0d8
>>>> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>>
>>>> can: flexcan: split rx/tx masks per mailbox IRQ line
>>>>
>>>> This commit updates flexcan to process split rx/tx masks based on the
>>>> mailbox IRQ line for platforms like S32G2. It introduces MB0 and MB1 
>>>> masks
>>>> and passes them to flexcan_do_mb() to only process the relevant mailbox
>>>> range for each IRQ.
>>>>
>>>>> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/ 
>>>>> can/flexcan/flexcan-core.c
>>>>> --- a/drivers/net/can/flexcan/flexcan-core.c
>>>>> +++ b/drivers/net/can/flexcan/flexcan-core.c
>>>>
>>>> [ ... ]
>>>>
>>>>> @@ -1244,8 +1255,14 @@ static irqreturn_t flexcan_irq_mb(int irq, 
>>>>> void *dev_id)
>>>>>       struct net_device *dev = dev_id;
>>>>>       struct flexcan_priv *priv = netdev_priv(dev);
>>>>>       irqreturn_t handled;
>>>>> +    u64 mb_mask = ~0ULL;
>>>>> +
>>>>> +    if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
>>>>> +        mb_mask = (irq == priv->irq_secondary_mb) ?
>>>>> +              FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK :
>>>>> +              FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK;
>>>>>
>>>>> -    handled = flexcan_do_mb(dev);
>>>>> +    handled = flexcan_do_mb(dev, mb_mask);
>>>>>
>>>>>       if (handled)
>>>>>           can_rx_offload_irq_finish(&priv->offload);
>>>>
>>>> [Severity: High]
>>>> This is a pre-existing issue, but does this concurrent execution risk
>>>> corrupting the lockless rx-offload queues?
>>>>
>>>> Since the primary and secondary mailbox IRQs are separate lines 
>>>> (e.g., on
>>>> S32G2), they can be dispatched concurrently on different CPUs when 
>>>> frames
>>>> arrive simultaneously for both mailbox groups.
>>>>
>>>> If both IRQs execute at the same time:
>>>>
>>>> CPU1
>>>> flexcan_irq_mb()
>>>>     flexcan_do_mb()
>>>>        can_rx_offload_irq_offload_timestamp()
>>>>           __skb_queue_add_sort(&offload->skb_irq_queue, ...)
>>>>
>>>> CPU2
>>>> flexcan_irq_mb()
>>>>     flexcan_do_mb()
>>>>        can_rx_offload_irq_offload_timestamp()
>>>>           __skb_queue_add_sort(&offload->skb_irq_queue, ...)
>>>>
>>>> Or if CPU2 reaches the finish step while CPU1 is still adding:
>>>>
>>>> CPU2
>>>> flexcan_irq_mb()
>>>>     can_rx_offload_irq_finish()
>>>>        skb_queue_splice_tail_init(&offload->skb_irq_queue, ...)
>>>>
>>>> Since __skb_queue_add_sort() and skb_queue_splice_tail_init() operate
>>>> locklessly on offload->skb_irq_queue, could this lead to corrupted 
>>>> linked
>>>> list next/prev pointers or infinite loops during list traversal?
>>>
>>> Hi Ciprian Costea,
>>>
>>> Please double check whether S32 can generate these two mb interrupt at
>>> the same time, if not, no need change, just comment this feature, if
>>> yes, then need to add lock.
>>
>> If the IRQ is delayed for some reason, mailboxes 7 (associated with
>> mb-0) and 8 (associated with mb-1) might be pending at the same time.
>>
>> I assume that both IRQs will fire. One workaround would be to only use
>> the mb-1 IRQ until the rx-offloading has been fixed.
>>
>> regards,
>> Marc
>>
> 
> Hello Haibo, Marc,
> 
> You're both right. On S32G2 the mb-0 and mb-1 lines are independent and
> can fire concurrently if one handler is delayed (Marc's MB7/MB8
> example).
> 
> For V7 I'll implement Marc's suggestion and use only the mb-1 line on
> S32G2: move the RX-offload window into the MB 8–63 group and register
> enable only the secondary MB interrupt.
> This keeps everything on a single hardirq context and avoids the race.
> 
> The underlying limitation is the lockless skb_irq_queue in the rx
> offload core. I'll address that in a separate patchset. Once it's fixed, 
> this workaround can be dropped and the second MB line re-enabled.
> 
> Best regards,
> Ciprian

On a later note, I'll send a proposal to fix the rx-offload concurency
now, to avoid having to workaround this S32N79 patchset just to remove
the temporary fix later.

Best Regards,
Ciprian

