Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD234EE87C;
	Fri,  2 Oct 2026 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957196; cv=fail; b=AeMqKUacxMrGLP+75tpEri6fTUD4Lxbn7mmWFFPYTXwTYjpdZZbI3S9IK1JYivZ8ieDIz+D5sSVx+Yt/MLDqEtG6ohSVvFjQ473kPyLVGfzOgAsCs9UJ+usbiFZZE8f8S5xjUBz5lUvjGFoDGl/t28NnPssCa5uo9GB1j1kH5/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957196; c=relaxed/simple;
	bh=rxcwbJMZeN/G81MvCglZEfuO2hWibRsiO4fTbfOAC8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cg4JV/R2Lxow/C+QZi8m0494ugLLBI7iaywEnOVMUj6bYQrzFvbWhMa/8J7pCE2/nweWCLchCaRHYHe5m9DYVPXjEsGSCGIz3OLtHioLiw5894bIa3OMvtzLuTPacqeFnCMtaNmLrGT4S70EVyx1c7NTPNi8oWdq5xzyztaFodo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gUtaMbVr; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gUtaMbVr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hutCvIWohu38umclWXBU60mYIoLYZtdfKMqlAB379yq7S/Lrwg89JpcLHkoeRIPPQlCbZd6ISqRkDXkEEyBe0JMn+yZEcZVGxhyRYaTvDtCjC8vLDuMhMrUfWYI8RXfeZP5U69PB8udNhZwQwu5NJR1MzXgv1zZPEeHZo2LvWi0KDg/NaJ+m+0HSjW3+O3uAgFwwsq1SNV49F6mYEg818VFBRbCXVvlg7JnXUdwsZHdL+9RkM0l21F204JYqkYoOOABZD8Jg8CX2ksEUNBmAOqKa32F3OX2hwInuTcEUOQtBFy0y0xxyb4hVfI7FCzpSTV8LQsQMxbK8yE4NqCddfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxcwbJMZeN/G81MvCglZEfuO2hWibRsiO4fTbfOAC8k=;
 b=Hd+YOc+9SyljVCWZL0jwU50v7QO0wzsAbjBwNH6bRAHzU0+c4SMBqxtn6xpdT/jC3bzR3fgDlntbVHJxn0/5dvuvbH+Wfk6HlrBIvp1gkvVjrFX9L2enBPPvAkRBMlnHVIeknWspHB/jXFXB9Gz5kXX9kVNIk+gheYmAUPAGsKVuIcTl/VNIgtA8x1Pyht3AIvYqOw+bIqg6AN5PSmbV5fzqoslFNjqGuoVVzMy9fOACqqv4mJiSbwcy9NSsBn6nYwBqkhAcodAfJtu7Rn7Cqq1ePJiOTTOsNu29f1GycYrIekxNYafHnKDmXdB5+B9VVk0NVhh6Qkj9K2QDtTbKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxcwbJMZeN/G81MvCglZEfuO2hWibRsiO4fTbfOAC8k=;
 b=gUtaMbVrPuTRxidEcWkIygIeBaM+rEvDVr6QoRZxMqg9OUs2o3cHuqCBWmerZUxXCWUaNQRKbO6fV05ik8PKvvc69XpDoOXUhmtAnzwx0ekmwovwct9PGy+Yf4aBcgjMloOu+TKXvH3D2tVknbHhBqqp26pYJUC062gRq0zB016pbbjVgEkbMg6uS2xYubRKhNfmF0aH0QBIqoy4Hqk03VMtLp9BQMLim4Pu/sWz9b0Y8eaUpYLtvHxhSooGhQzS/vtFzgUCGOcAUFIrhRJcf4bUzKfm9YlTnbACWe5zEN0CKfNu/gL4yd8V2TvUBijjDvr37KG/djgDaZBtskjOgQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB10792.eurprd04.prod.outlook.com (2603:10a6:10:58e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 16:06:29 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 16:06:27 +0000
Date: Fri, 2 Oct 2026 11:06:15 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>, devicetree@vger.kernel.org,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>, Vincent Mailhol <mailhol@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>
Subject: Re: [PATCH V5 0/4] arm64: dts: freescale: Add chargebyte Charge
 Control Y
Message-ID: <ar_Wd3fF94XSj4mh@SMW015318>
References: <20260907150420.18787-1-wahrenst@gmx.net>
 <9cb548d3-f3cf-4757-a9ff-5f878479c7d7@gmx.net>
 <arFDUby0v52HSNnU@SMW015318>
 <1a7c722b-a4ff-45d5-a590-0910ac47b541@gmx.net>
 <7cc6e394-9895-4f42-a0c1-f1fbd7eafbfa@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cc6e394-9895-4f42-a0c1-f1fbd7eafbfa@gmx.net>
X-ClientProxiedBy: PH5P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB10792:EE_
X-MS-Office365-Filtering-Correlation-Id: ea85c338-944e-4f34-16d3-08df209f1cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|19092799006|1800799024|22082099003|18002099003|4143699003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	A5ZPpM2UNBLI8GWdni1ybxULqUtvLZamVwvgqd4NCtEjtzPE1CeSV/fJoZ/QrdGr/XW+L/gkbMbZM+/e7FHo0+g7ATen1MECwLZl7+mNb4XsxTU0F/zhaQbppeh8Qs01WiGOpWY2bW+3z9IYxtnxaJtvGI33Nms0nhcyXm6EEJhOz/hsLx/ADqtqHODCIyBhjNP/5/ubOz2WlaPHmd4c81tLRB2EWHUd2q4UvloHFCi63IPf6rmlNX0WF9kZcM6vIWxjtOFXvA4imtJ/osvXlvqfozDZuva5lUK+Po6d7jSYwmm4cUYISjO9EnOlRFHU0BzCU2tX6nfnEWRdzT75ZKxEE211YvYBMaWv7rMm2z21OXAORIP5XZxagna5mw1DNZ0gWoFlXSFABZlZ8LhscOIfmb/DjSWO8wWQoHPXh0eJ5XpXw+TTotIcLdQ6K71hR4HOdrBXllcnJb8vFhXTxEY5OVnQ0+A+HHX4Ywl5k5Z9l4SUh4mvQAty7Gdnlp6+9y1xNEK9xnjsPnFmRrpHY9gYT0zAe6kw1ffidbQk/Ui1OlNbJN/D8ulJjfsDu/m1TDkknZICwAD2/I0BCij5tfMK8z1czU3MfvYMkCB+UPrcgC1tVXsEtMTpOX3t8KxZz/lOV54UwQTuY5xyax3VrR4d1ZGQOVtWN+WvdOCvkq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(4143699003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vNdEIGhVTULaMiq30UZV8hhVZUtyDn6ymmRDuqevK9UeNRa0DrmcTiwwiuP1?=
 =?us-ascii?Q?YYxNqZh3tCTv92UWlKajYWPrSj8WX9leQ1i+XcaleGMIAogbpMKR1Wrhcly8?=
 =?us-ascii?Q?4kFUzULxueIgysPO8z8ClSath+M975rVEqxaFq5lqzZooKqw9eqmU+IXr42a?=
 =?us-ascii?Q?AttuXAjV5bQ2gtEEHob5oZA3IOGvPzYSdOUM/Jx4XtIq0dXKyYjbXH1ixnqH?=
 =?us-ascii?Q?IFQDirdTLhdqSpzMlMofp8OBvUWzPX4aCqSS6uAt2C4IiqzHZ8iyJf8Np8ck?=
 =?us-ascii?Q?BklO2lq2Wl3TvD18fsXfFLdmMNrDT4gUuHcZnBS3Ab69cCZFsHjP+rR8xf82?=
 =?us-ascii?Q?Mf7RKAxXrQNljo6KdpYArQw2XFimMwCMPdLMQfatfH2nZRnaZwa3QS+EfwTo?=
 =?us-ascii?Q?N1sjkCu6q1G62wifrpFuSb3Bsp6dznmM369QBIjA7PfZriKcB7I6nvQ/DtRt?=
 =?us-ascii?Q?JpKZediZgj3tBOd/VeHOhmQBMwYQcRKY4ozptBQyMqs4NFz5HjD3m06YJdvR?=
 =?us-ascii?Q?QnKvgJ2dUT/WH8UVZwUttoNDhjEIAvrSAFUPIE4u7DIhurw1FP/zLYTFkDpZ?=
 =?us-ascii?Q?fmv66QFLs5XPQUTiDnKAOOXuq1mbIPLWZcEKBHtXiaUwYGZQZPkmdSTlF73C?=
 =?us-ascii?Q?k9wmsv2CTot1bwC08vzN72AtLqVOor/i63W6oj0NKWdS1OvXlXlu+GC8vI9V?=
 =?us-ascii?Q?wj2nS/b6G3YTb35wHejWG3xP8XBmtdTJgntfLIXPxlfvdpXElbaTPoY9DNR5?=
 =?us-ascii?Q?u2aJtzjb8AItQxKBFkNMdTxYjaC5hmxQbcOqSl9qHr8S26GJbGw7NkJ50jAP?=
 =?us-ascii?Q?CskEtQf1148SjqHMQ895/48DkkKzyFfORIp3cvnMxlNmu5Z4UPiXilPtprB9?=
 =?us-ascii?Q?P9ofuzdHpagkNA1foPjfhf1Q2JinpCZNu5dq8CayuE95jjyJVZRrNwtGbqXd?=
 =?us-ascii?Q?Y0GEoHjSfg+qgCZ2hZ8TOF7hqJxWpXaGLByCWdV0oSyFA07jsjmFhTux3vdB?=
 =?us-ascii?Q?r+E3UbZQ4n3smD4UBOofxoRR5pgtMFbLf7yC3A0dnuOGGJmu6M5+7jcdYqNn?=
 =?us-ascii?Q?X/hn11LCgePBEpTO8T6tz5MJ5/bx1ZZa/7Sy6B9+ZGuLqgAeJeiFS+8EpEX8?=
 =?us-ascii?Q?aLGcIEb9V3bNzkYoLo08+U7LpG47nN2pVHXohD2B6kz7hMg19lKMMUTXZTov?=
 =?us-ascii?Q?ocbFyPmSTT4LtMxfjHo3deXMC+uNVi8vg8ze/Lg2ATRzzs+4eHBSSJ9ZgbNO?=
 =?us-ascii?Q?30POVzNPROJVRl7zzG2g/C5h07PVhmxq+TW+ypDqq/Stc5A88k+Kj+qNdt2B?=
 =?us-ascii?Q?a+2mnxYos3gX1agxY2UeFH6CU9CqG59pDV+iEfHJ56sjDw5KPyk6wfuYQCiO?=
 =?us-ascii?Q?htAEhUKV2cv0ux+r6DcUbakOGubfIhICd71bAjDSj0y5CQOZLTLGgKrDw5jW?=
 =?us-ascii?Q?9Wn94z7hvzbWOOyjNAM6AJNhvWRC7T+zVooHp/A8KZdXNTMRzceNz2q0A89M?=
 =?us-ascii?Q?u9z9VkDxtdiGR9nT0xeTVZdAhzib5XSJeiZKdHdU8riWs3Lxy97Hd2d3QHeE?=
 =?us-ascii?Q?NW8OzSw8a4h3lVIkUsZEyAKQ99HRH5o8ZSfLyF2aktQbYdwQzRnyCS6adGvu?=
 =?us-ascii?Q?ceMGBsySsv/4cdv8JoBCMXyQOua4h6tGIVRcTFTdScQiotQFyi/nhc8dDwmR?=
 =?us-ascii?Q?uVv2mNqgZYTulP6B9sah2TICPZsOUGROZqR1plIGCQGRIfv647C8pkGMQlOc?=
 =?us-ascii?Q?Qnxxi1wHAw22b/orwZbKHRQ1N/kTZwI5nhEu853+QsxSgcqMVRXf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea85c338-944e-4f34-16d3-08df209f1cec
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 16:06:27.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2m8z7r8/k3PrQMEG38Njyr5Aq3l4Ewo9jQCl3BnkQ6VZzE1Xnnz67hVO5BAQk2keVcHUXzYsAJpngEjwfKIcgjsGNmCzN2UKrDLR04BxDlS2bm154YwFRIxWPwNSHXUn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10792

On Fri, Oct 02, 2026 at 05:31:23PM +0200, Stefan Wahren wrote:
> Hi Frank,
>
> Am 23.09.26 um 11:19 schrieb Stefan Wahren:
> > Hi Frank,
> > hi Vinod,
> >
> > Am 21.09.26 um 16:46 schrieb Frank Li:
> > > On Mon, Sep 21, 2026 at 03:09:23PM +0200, Stefan Wahren wrote:
> > > > Hi Frank,
> > > >
> > > > Am 07.09.26 um 17:04 schrieb Stefan Wahren:
> > > > > This series adds support for the chargebyte Charge Control Y, which is
> > > > > an Electrical Vehicle Supply Equipment (EVSE) for MCS (Megawatt
> > > > > Charging System) charging stations.
> > > > >
> > > > > sashiko reported in the first version of the series [1] that
> > > > > X_nRST_LAN
> > > > > is available via GPIO line names, but there is no reset
> > > > > mechanismn in the
> > > > > device tree. This finding is valid. Since the reset line feature isn't
> > > > > implemented for LAN8651 driver yet, I like to proceed with the current
> > > > > version. The LAN8651 handles reset via SPI commands and in rare cases
> > > > > we still have the possibility to control the reset from userspace.
> > > > > Btw the pin has a pull resistor in hardware, so it's not floating.
> > > > >
> > > > > sashiko complained in the fourth version of the series [2] about the
> > > > > reset polarity of ethphy2 and the different drive strength across the
> > > > > data lines. Both is intended.
> > > > >
> > > > > [1] - https://lore.kernel.org/linux-devicetree/20260818093147.E556C1F000E9@smtp.kernel.org/
> > > > > [2] - https://lore.kernel.org/linux-devicetree/20260903082122.A777C1F000E9@smtp.kernel.org/
> > > > >
> > > > > Changes in V5:
> > > > > - fix delete-node for pinctrl_leds (reported by sashiko)
> > > > > - add Krzysztof's Reviewed-by
> > > > I didn't received any feedback for V5 yet. Do you have any
> > > > comments or could
> > > > it be merged?
> > > Wait for vinod pick phy binding part.
> > @Vinod are you fine with both PHY bindings?
> >
> > @Frank I noticed that this patch has a conflict with the Makefile in
> > linux-next. Should I rebase or do you resolve the conflict?
> would it be better if I rebase now and send a V6, I concerned that this
> misses the cycle.

Vinod missed pickup one of binding patch.

Frank

>
> Best regards
> >
> > Best regards
> > >
> > > Frank
> > >
> > > > Best regards
> > > >
> >
>
