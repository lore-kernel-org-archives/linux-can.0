Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E964119F8;
	Thu, 30 Jul 2026 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422887; cv=fail; b=iZ2mPiyNGvnZzSs/JW6Ue+EN9lfV6ZuKgv6w0F3+gyRnIY/GKe8OT/9pI6YEiyXiNwJEDutUjzaCK51DYpjTKFI7pWr8jeZzy5BoGJAjEi0kvrRey+BAagnGmAWpBZbg40HQBQ2DIKIfyUO9dUP8MRjqYsC8o90/oi0AO8pb/i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422887; c=relaxed/simple;
	bh=J2R+J+06PtsXYZ2jCiVBtQJGo+sn5AFvix++osBBzRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y4fwqU7/LqqMR/FJA0RDWvqoOPnoJuHc0Z4NexXF9dsk5gWGWkqR1dz1aD4zM4TYMNz50TXfbIxhcs4uwqSxKsSPAYjcPbnG+tDQWteFn9majGdp7WjSrhkIDc96FzV9Ea91ApKQWHMHkEJ2ui2SczgXaILr1UzExLEKUT3b+vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=f6to4Qpc; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="f6to4Qpc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iF29+JXSHfllUc9OppfzKAigUESgg45BynsJH3Doe8IyZQRaWOg22PN0zsvBHu/l7kUEopWtEswjok6yVfO2clYJQyWXh8YqlQr+cGLIyQocZjMWpBk8To5emuest8JeL7qwKz0orOuYHnJuWTTSpOzDZbWeaqc6Jw2wFxWQjkLgsUxQnLXyLjyMahs3Y9175uvHdX3sP5iwWbvupOrT0E9ruK22oRfBgOo/3uLig3cGZp5QHLqunAJyf79GAMZFIRndXzQJ7Ap97pYJCrgFgYFN27dY79zIH4JZR9JFmOBLS/64A9hPwqn/FoE1gcIH4d0ZvU2Hu6bkqMZS0SJ/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDjgDPDKQk/wYx0iSSMxSGL9AF0514xo2K15f21ARok=;
 b=l7D8UlKvFhzMF+8mOAlTfpv8BJ5K0icQNfE6EuOero+nzckLi+550u9Y35wBWo4zzB6OtbZVjydY4tEgS0e3FBlosA4zlAQ0X0snXOGgG71kpXQqd2J8I8Br91x0V5laO1IgfYr4eWTSOvfkGqnbRlYPUvlANlRcrdPB+MutAyq6EUfiWcxXxx3BmcOqv/M7HBIivAgeSizxrYi2uFmEw2yrxxfIUOjXdGyQ/hRPWS3cEFRtdPwkfwjxuP22CfgoQkKG9NPUa914rPtL0pd5Wd9NfSh/Usqb5+TOEb6CVqvuCaSt0gFuzEXpGlitWlq3Jn+g1BVMhpDUSYdJDU66Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDjgDPDKQk/wYx0iSSMxSGL9AF0514xo2K15f21ARok=;
 b=f6to4QpcK7OmULWl0TUUs4jAD7tkRZH5r4/XBA+kDhNvwBjjKiQb95kvwMkSu2S12CpRcSwpeyLfJHONgQ02Et9I5khA8oy9wQthQsWpkXCqT+kuLgO2PyDXybUJwxVQSpFwoXgWrvCzAtvhNalXTAmUY1GQKM7aQi6U1+f66uOVUdsWheQoIsRXpyOqOlQtm7JYNOXTx2pQMNBJ9cxss/KSxXPzZtatcaczGvUNEVi1YKT+uD5wpX12dLspa2a3QjMT5+jqhyR3oBkDwXKBx/1V8HEYFltbAj9VxglOfsLpBNWCsonOn744o5N9ig6Ss0VRsEVir8QoeWaZIiEMlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB12052.eurprd04.prod.outlook.com (2603:10a6:20b:745::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 14:48:02 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 14:48:02 +0000
Date: Thu, 30 Jul 2026 09:47:51 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: haibo.chen@oss.nxp.com
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>,
	qijian.guo@nxp.com
Subject: Re: [PATCH 1/3] phy: phy-can-transceiver: default silent GPIO to
 high during probe
Message-ID: <amtkF1NXKN_nR2vE@SMW015318>
References: <20260730-can-share-silent-v1-0-63fd603f943d@nxp.com>
 <20260730-can-share-silent-v1-1-63fd603f943d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-can-share-silent-v1-1-63fd603f943d@nxp.com>
X-ClientProxiedBy: SA0PR11CA0127.namprd11.prod.outlook.com
 (2603:10b6:806:131::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB12052:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd7e265-6b32-4ed0-f544-08deee498e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	DiJIlF0hx1wQ7gYh4JT/pHgCOhxwcq+v426Ns4SDOjveGBEtAKJwxyZ5zXc+H2y0TivXz69uy8M6hi6JfEnOh9w5VZHXiSDnY+CK1FeW7Q7tviiOt8nxiPadIx0ew6go3sm7ll9C3VvYoC0vl3d2arUz9qo6odRl/Ncpn0dhzb3/iQbNWOGvdn+2uq1HVRJ0Om1GSh5qUPnY5L1QKKT/WL7eouv8xMZ3gNhCdXNZM1l87DEr2xPIevYR+j2ZkMZognfJ9ZAf3BjAJ5d4/Za6UBQT3lBJeCJdj5EfzQYREQNU2yddo6ipzyklfPktm7wv0vsyLbSn6nfz2ZGx73Zl3+XgkVj63Rby1tPqk0e9FLSzHNjjFLc0LdkMICy2BTdbFIoKMb7on/MYagP4ps4UaoSPU0pwWNnlv9rCLO22k6F+FihraqAKNpcR27rYM1mO5vD+WmSGuboG/otEGsun/Bo2HigSY7X5LiQCFnAZQ73YrSzsrzoPqI6w/bihMVbREB5TFKShCC9m8bX6+WucxfIzAuw4XqRkrBFrYEOUprhQVZgHLBGhXwkGIS+H8EYk3+VhPfw6x+MnE6xrQcAZDddWKmFuIBIhQLypXA8HEUxmVvz/xpiZWtGURxtv0mJMSS0fZh72a+S6xCOKIIqt1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QDPwx5PXDQDmj7OqZlvaOKO05+rWogxxgLhHXIAS2lRudSvsANNmaiMuVehp?=
 =?us-ascii?Q?1U3TFe386yBzW4lHegGDJbe2xL3JhYHC/unVbCWctrMk8T9A/DSVGcN8ovcO?=
 =?us-ascii?Q?lllyeddIsjl3B1qQw9SDNli3l7TbdqyOmzV7JGYeVflfRhskRNT4JXUczrQ6?=
 =?us-ascii?Q?e3YY5L/3HaRuJD2Lrex/ZoTjQ8rCTDgjgGk5uzueSreU347KPERZhLyieyHo?=
 =?us-ascii?Q?+Jap7c3MaLrWsxqjh+kmiVCn9yVQPwArjnEj6efH5yGkE3Atv8R7y/P6h0m6?=
 =?us-ascii?Q?xKTmMjTi/07ZbVkLoHxMZ0Yw7LFYvf3mMoOkNFOT0JfFs5Sb+HPvC9YKhOin?=
 =?us-ascii?Q?z3vtiuUJ6nqC5ppPT1Xefc4C6YkLOI0kA2PaQPT+xhSScyE9zM3yVXCQ4LRt?=
 =?us-ascii?Q?CHzATFO9ah8z87XGfJAUEAzbhAHNCtYl5zQXzBZMktV+yRrYceQtC3vBdZl8?=
 =?us-ascii?Q?SsQfqWVuoK3UoKdPxBawLk8MHlYM5W6U8RUokaTvoMSgqP4N8SIA03sQzxjx?=
 =?us-ascii?Q?CStNUNnTVAUerI1pNhGCYaUsl3DVYpu/MsjZwLOoaVyG4G7uzYmderdWmn1C?=
 =?us-ascii?Q?EbqyLLsBJGJaLVicSZY2DLEOMSDDdWTvWk4JxSh8psFCPAuV39ozeP/uX6JN?=
 =?us-ascii?Q?gSeJv2VnkKJ7OvgvT9BWWOX5jC6Qd9zzqICoIPRd/LTmeQ7nzwN6qCOSpDTN?=
 =?us-ascii?Q?q/4VJJUeqoWqxaRjlrBzZ7hvU/1z9QfQzAzb03NPVuw59exLAzsTavwmfh3V?=
 =?us-ascii?Q?8ehdv6urFKE+X3e7cCuN7qinFlr2qgEl+KDXLMfa7ZjFUpvl94PqioD7imrt?=
 =?us-ascii?Q?dCei4BGPt8ilwXgGwh8Wb+yK7WwMW/Ht6A8gkb/UGg2MEq0T62G1uElVKayB?=
 =?us-ascii?Q?7a94+OxCw+edyeJiL9eZqHBzMcmDYkr985wi0OEyy9ghPtBmlIopg3qaxN3a?=
 =?us-ascii?Q?0jboJNB2ivonQ06u1xYRjx5zAAYeBGKutAyMzzFC6Vbs/JgDX6Ispwogf6lD?=
 =?us-ascii?Q?zD2y8xnyDBs49PnGq89qXNN1ouIvtuTFy6CNOENwJpzuZRtbAp/77lvHZNY+?=
 =?us-ascii?Q?VZz6O7CijkXkuJg8LrkbWiRkEUlk1JZ4HnDMrZo5b1k4tovssEUzd7TmCC9K?=
 =?us-ascii?Q?92xi/j6Hz/AnyCwqGuypM79ucgn8LpcyqZ8GtiwUNpDtYtnWd4uAVhsl0mrQ?=
 =?us-ascii?Q?ZXwqz0CZWoEVwuSwPhiaOxu6YZsA/lnXvAawfbII+85VRKKZecVkQvnyDXC1?=
 =?us-ascii?Q?gtuHPlfAqi7m+CFYGM502HXnIlIsAI6F5m/UE2aeWoz3q2PRFUtLwaSRxRTI?=
 =?us-ascii?Q?6cW72w9biKgOU2SPg0h55ziEk81b6oclpj7UjS9lsvkOUUtBSX+lLfXqe24z?=
 =?us-ascii?Q?E0zip+Cba7zNDhpFYWlicgFZdNq/Yd/fxGdcAA6c5nyGjbfQ6TQePNdacBUc?=
 =?us-ascii?Q?tq8+YRHR16812CqAzj25cs08n2QsETI66iHsbT9lnPEHR+FnLQybA83nmTeJ?=
 =?us-ascii?Q?fom/jcHodp1P46kvBu5RhKo3aEgsVv7G/OIqB5ppqbX6AGC91NL889QhYTYQ?=
 =?us-ascii?Q?gK3JjxzW9ehKegq77Cb0+8DoSyrSTQ/MqZrHqCzM2o5hgCU1NjnjJn/Fc5pu?=
 =?us-ascii?Q?ChaPmhVhTESlzi3v0v0hNPJ7OvLowOICDW0HcdNJu29bMgTlMkZt46SK1vu5?=
 =?us-ascii?Q?+8WcKZnLEl/q+3w112TqLv72T9j+Gv1tZeY35bbPlf9VafyyHAwZvvZT3/o9?=
 =?us-ascii?Q?tiqpxIuCjkZHX38iOHXzbJM57DMoZtxFj9lIapb8aJHIsWuONLsP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd7e265-6b32-4ed0-f544-08deee498e73
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 14:48:02.7264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuKbR6GWJIbPThrHri/qvO0g8CQOIto0uZmjqldBYn1nI2LtZVUXwUziVXh69sFspBGg7Wst29LkW8HvY0T55hA5ayN4uzVHuFc1G6hlNN/yA0TkAagAZFL6a38Th2ZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12052

On Thu, Jul 30, 2026 at 12:33:26PM +0800, haibo.chen@oss.nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> The silent pin of the CAN transceiver is active high, asserting it puts
> the transceiver into silent (listen-only) mode where the transmitter is
> disabled.
>
> At probe time, and before the PHY is powered on, the transceiver should
> default to silent mode. This is the correct and lower-power state: the
> transceiver should not actively drive the CAN bus until the PHY is
> explicitly powered on. Requesting the silent GPIO as GPIOD_OUT_LOW leaves
> the transceiver in normal mode by default, which is both incorrect and
> wastes power.
>
> Request the silent GPIO as GPIOD_OUT_HIGH so the transceiver starts in
> silent mode, and let the power_on/power_off callbacks manage the mode
> afterwards.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/phy/phy-can-transceiver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> index 75dc49e75ca0e0e90a1b1b140dcaf8033ec02c50..9aa30662105f063fb6d0e60fd04a95c8d635a515 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -198,7 +198,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>
>  		if (drvdata->flags & CAN_TRANSCEIVER_SILENT_PRESENT) {
>  			silent_gpio = devm_gpiod_get_index_optional(dev, "silent", i,
> -								    GPIOD_OUT_LOW);
> +								    GPIOD_OUT_HIGH);
>  			if (IS_ERR(silent_gpio))
>  				return PTR_ERR(silent_gpio);
>  			can_transceiver_phy->silent_gpio = silent_gpio;
>
> --
> 2.34.1
>
>
