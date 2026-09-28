Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC04F55AB;
	Mon, 28 Sep 2026 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623929; cv=fail; b=bdRl37QWswkmaFTFjt85ZGTPVi8h1GG31EIoOV6BDGlVb5f9wrc5enOwXLJotA+blGGuB0Eoim8wpKFsHjg+7Gmlhq4ruB5BGnfhqH3JfKwobDbBxSuleHp5hcIIfJq4GZA07jOh777iTGQiYYtk/rhQWOp7HO9eBLE1+TFurzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623929; c=relaxed/simple;
	bh=7GkVZu/Dfqy5Tg+fcgN9/bSxyfIB26S0mBJEGs8UUvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jXXTU7asV7z5CZszb/Ihy7xMmxVs2Pi7aNxGNOzOADf9Outb8Ipf4Kwb8Pu5BfapzKm+lDl4Txnf+rldfCAxsn3ZtWc5/eZVhf3IxPoKEozRQ5jArDOqSITfZ7XbNJntbrFomI3TnWJtO6lDrgU7NFFuMH5z1eEr7xjlbB1FeM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oqITb3Bl; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oqITb3Bl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHRW/IbbRBun++LwS8qpitYX38ZgtR+X1PXc4NZGIPnMjhhtvu8tiEucylxK1BBASc7Zt6xYtytZW5V+atBkdIX0s8QBSquBgXiShyHVKs6qlCeEWiNAl/wmlKNcJ4YDmiXnPn01B+4S7cVr84dQTal4R3YBqt6wQfKxaANSOhf9ACcWj2hgVgqoqSrlulL31wBZLyT3Vh9CH/3MvLmDAs1kG7464eDRJS1UGWvPC6LRmp1SJfLbGR7OPzVCBD3tOEINVXz25NjyNMslqsxSu+RWzhHxGu0fj/3HPBx3fVHcjw+7lzg4LTkOC0A2rYsOfVHaQ6tTZxD4oVnSVIyfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1sbEkYIPQ6sA/ui2C8D954iMTF8q3qzpO3P65MOIpI=;
 b=GlyVMODNNT2HtK3WoitKmOkkc7rTamY79piSiM5pnnbmeeIYmctPmJ//MolrjBIEUzpJoWA9Iu4UFGlTO5DBfYi6S/1EmwEtidSgJFEwXxDNhZirORraxs7tbFBbHbWb75xeQ/UFkZU9chJF8vPUMlGPrHmDNaSc7J5u5K1CxQqNjUUHMRVa0cz3MUMQRPedU13wmIzLH6enSQde3OobqLs2SfbO9DjfHJ6YkFXz/x8YG3t/GXipBnzntS++l1aFLFAJ77ic0q7vKMwY9dSZQboJfbSoEPd7wiI6cCxQD6od25vbmLWyLs8E2vUUYD5X+LKMjp6hjHa2x5JOJcrCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1sbEkYIPQ6sA/ui2C8D954iMTF8q3qzpO3P65MOIpI=;
 b=oqITb3Bl9Q//HucjVLS17F2laFnXRR1SPm+cInkBuPLiYhpicxE+EOaSzJF4TCXMI/BtKP41SmfKSHLvegUrHiubFNdBxVq/nZPEu1hLVTIJqyDwSqvPeulGzMvHJ4A+HlP/2PCAD9o6azPm6klfwlxRd9dVLuzjzQ0ni6HV5tSO9EBhl0YdXDCRz2mM2kGd5vOKamwvJl7aBQnsdyOoAXpAXrWsoJBLmfy4KSS4p58tGKxx3Ptjz5ZMiZvbq4eulh/1kgq75o6uwQthPJ84qcCeL/ee79rkLQbXnetSL9k7h0oVLy6Ss2efptgZWe/B2nykXrixsXlrpL+6viH19g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AM9PR04MB8633.eurprd04.prod.outlook.com (2603:10a6:20b:43c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 19:32:03 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 19:32:03 +0000
Date: Mon, 28 Sep 2026 15:31:49 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH V5 3/4] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip MCP2542
Message-ID: <arrApSK-HQwx5UVg@lizhi-Precision-Tower-5810>
References: <20260907150420.18787-1-wahrenst@gmx.net>
 <20260907150420.18787-4-wahrenst@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907150420.18787-4-wahrenst@gmx.net>
X-ClientProxiedBy: PH8P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AM9PR04MB8633:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ce0170-27db-4b9b-2321-08df1d972a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|23010399003|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vlFMTBm3FYLKvC7wAyRiikSbt5d5CIUUaPGGZsZIksBtdHhaY49zKnm9c9ovkEy0JsglD7SRkArNY7k6gHnbwDbyH+dYwrJ2souN/aPsZLQqfq2B1MPlhw2zNoxM6L3BpjbhKQEg8jbm8z1khtEaGgfcHQ07qKIv2+YAirn6nkUKrr34htNz5JzAgH1Gh3xwscrn8ZSJ8HwA+dgF2X+LeJjTker45fpPSsXTuVQBelGA/mYyk4ttsrL7AzT6qkQ7gj0APBv7wtuluIBZvve3RxxwMWuu7/73aQ/or3uWPsX3zAAC39Cn9/MnAVrh+j56CDFI9EdBXMVdvZEjKADZZOUzXa0xXz2ulct1533OWmjLb7VymXuecM0rcXI4XSUEv6rcsbZLkA2n194OQrOeqoIdZO3Cb30M12Me7egrxJDNf060AQxWyTVIFIgwepugj58W9RF8aenbHBcIVwV1nSMzsow4aBb2hKBsTP6lZXRH+pAtm167qHfMYpl8TsdylBk2zzHcYyimh+WIThrXZl/JeBBB24HDx5BronczmBaB0xyUyUfW4jpPnwCto1j8AeiOJQ1l9em4FLZQCwCjF5X5ZRrEgAZ7T6WBX77DbCkWu/A6uXNzwMQoNbbiAkQk8bF4OOSXU/ELI+4LtAo4YMA/Iy4DE1a0EDnIjMOGkn4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4xV/7+PGxvNlardsDfEBjSEgb61Eg+N5z/TOXlqL35yCuxBfuJ+hlG709VEG?=
 =?us-ascii?Q?NoMB3LVYrupXLaZK0c/HUSKmVnPbYA0O2um+FO4KOnhoFGNyqyGUoVmgR7KO?=
 =?us-ascii?Q?jGFg+uhZEzBagzBoSzQu1BSgb5vgJ4/CzoGU8sHYJA5HzWywDwXt2GKnlhQO?=
 =?us-ascii?Q?8N+VbWVKvMZAJd6U65tzFsvDjqj4IKcU05iv+frRImH8mWQIN4kZjNBhMps3?=
 =?us-ascii?Q?a9wAeCi/OgmxskCsuxpVDP11DjZAy5wGEdSaoc1XEvr11QwQ+nYDGp9ntUuF?=
 =?us-ascii?Q?4cM0QaVgyBlUd7ZvT49km3PdDZw2Xb7ZnrjLv1yt8pqbJbg9QhMtiW56jEk1?=
 =?us-ascii?Q?oYnGU36ty3rm6ZpAX+QwOJyMQHYK9+GWlu969FsowtqBHZl+WAaDUoKdpYRX?=
 =?us-ascii?Q?9F0r1Jmq2xIHejftV8EC6OvMiKNSDVcIi3whUxMkcUM+Uo+SuhImDE5zPcU/?=
 =?us-ascii?Q?uKy2cFQYwkqfXAkOWtnk1E9a0yyXbqetOUfq8YmWDgF982u+21JFFp8a+U8E?=
 =?us-ascii?Q?LSWES0/GO1iBZoeY6uWwjrXS2apVELoN13KhXCsIRZwN8BtPp1fx7aBVcE2f?=
 =?us-ascii?Q?r0LC7ZmVmLhOhbu7HG2jwu7kElmeoF5Nj3jwm3UhTCWdbdWmlaeLa66MnHnX?=
 =?us-ascii?Q?akg4caP2ZnCUlb1YqIAsWeWE98RMWTqSGuKLwwyHgT7xkyGsR1b2Atzs/9+i?=
 =?us-ascii?Q?bbwi4KR37XSWEaQHLpwIcGQuZoHvSWi8ary5cPzWlRcKNhhOphhBIUAEcsBR?=
 =?us-ascii?Q?NEqTEpT3UVDbybiuFCDVj8XIgoxMwNwECvnJbV5gyGReYJdX93E6w5m36erE?=
 =?us-ascii?Q?2pxQ14XwubshPdM5gGZeKMK2Ew047u6YyB9XBp8GQYdYJYqnBNExi5xA4wl7?=
 =?us-ascii?Q?3TRCXfPxZWv5pGYxE4gJBd5rtM6ELokd+Br4enR4aPG/oEq0WJ1LqyXTjz60?=
 =?us-ascii?Q?pBBM6E4O6FFv1Lm6ZxnT5IugOxdRXq2SCLvOBOS4Fhl7NVYpOLgG/IcU/lrm?=
 =?us-ascii?Q?8IY6rNQwrNejQBIfxflbPUEtfWXoZ96cp+BCAa0PMONZLZCtl+W/6MvTCzzb?=
 =?us-ascii?Q?j83i8bOTh1SMUhqT1RxdGIMXjtbxOXfZt2NUrQWZdopWO6dcqKF/y+ShYMle?=
 =?us-ascii?Q?c1hFt2rDrEJ7Vr35KboW5+0QyRyizFjqXDmZHObIAyom9zFcb6jgXpkXRfMb?=
 =?us-ascii?Q?opUNlbe0XRUnErfQlyPfImUthYiONyOtCnfXydrR+RY/QVXWZ17GRXb0q2uC?=
 =?us-ascii?Q?PPm/+Ea1/yatsey5grP4WoqCHYSQhHWoosogVmC0O/rlgYYbmpmau7wqL4BL?=
 =?us-ascii?Q?bIyvsLiEq9jLeq9iu2FQxitkQ/CNkBSuoxfQRMv2F2+u0Nxuc0PMYZ7ixIhx?=
 =?us-ascii?Q?o4P01sV4+ymv5a67CPa+qQ/fB5lYpMovHdHB1HGo4s3n0I7xS78lAWURAEgx?=
 =?us-ascii?Q?GYCeD6UL6ZClLtesSEHPN/DESoRIDE9SSb9jbKUwO087RFS2ZpiIJh6gcPgF?=
 =?us-ascii?Q?uis+eWsVmqNXtVCpPCWFSEzx6ddPxsAaWfiWeRCQVIJJsYA8BJ5XG96Pmi6L?=
 =?us-ascii?Q?W5TlNlVqSPn+PwiD/gwXnRTlJNsZpuYBxkGMekEpXjAFg849rI5SBpsg8bse?=
 =?us-ascii?Q?dSpx60rjH4YdfFD6RPfYT28iVddPdZ7Ot2ajhvtjCGwTyhTJbFgetVlJw4Ey?=
 =?us-ascii?Q?ZjlkygPmNpIp4/G+SM69N4oL3zDG00ww+qBQvqHAw6mgZHFKSqT0vakRz8iV?=
 =?us-ascii?Q?+FbIQCsOC7RVkRJt0Yw0G5VztaI3NUSar0dj7OzW9co2qSKWgzWy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ce0170-27db-4b9b-2321-08df1d972a2e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 19:32:02.9617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRSiDh019OeaGjTAT7oofhbokt5PeBtrMvGKDIbVCkvtXTk0ujPT+BvmwNV4ReA2h2u0mVuUKogXCXmTqV93xWCP/yZZPXu/bbsFL5lJ46OqbJtdlrM9kXz/hMZMfTRu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8633

On Mon, Sep 07, 2026 at 05:04:19PM +0200, Stefan Wahren wrote:
> The Microchip MCP2542 High-speed CAN transceiver with Sleep mode is a
> pin-compatible alternative for the TI TCAN1042.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Vinod:

	I have not seen this patch in linux-next, looks like you missed
this one, only pick Patch1.

Frank

>  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 0cf5fa21106b..1a0dc9bbe6c9 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -18,6 +18,7 @@ properties:
>        - items:
>            - enum:
>                - microchip,ata6561
> +              - microchip,mcp2542
>                - ti,tcan1051
>            - const: ti,tcan1042
>        - items:
> --
> 2.43.0
>
