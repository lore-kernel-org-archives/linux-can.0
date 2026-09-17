Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0950B8A8;
	Thu, 17 Sep 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664019; cv=fail; b=PC3JMy0gb6fm7974VxwUf4ubqggdm/Ne2vUPUInV3y5X/b3VGGEo+PuV2WPwr0P9ubeLha2zWc08sIt94hDv2jhWZp2sTJ7rm7JHcSZkWykXImkLy2B3YyS5beXqWezYsN5+LdfRxYVsNmEga49P53EacqHlnP7UMtHI+BXYDO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664019; c=relaxed/simple;
	bh=XKLfUYbKoFhe11on6VdjGesx2RRffGbrGBTYigrxHdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R1cJU2ZUlPIY4SWwoHS0ZkOj7BvZgqRQnrqkFPkIrbYBueGiRgFd3iwHihOii+t/3vSlrFB5KNmYwKIt31cdXfCJAeJhwEJ6xxmDDRNqcG6u9PdUyaNOBxRLFHlm6gZnl5ZKb1B4xiksiK6rJG8BQXulxiS94yS2RL+Uj6tuP1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=x+AUILiE reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="x+AUILiE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLTAvpb8roa9qqHHMBu4e77Xlmv4MTYUleIjOG8y8Zjq6jiLjxVjXys2tRNFnpIFuDgamItyyobHuiAghqsPHY4UXGnw7XkwCMGNsJUIA1NJ/xTKjkqWMsBFTcWlyB8Z8IxzFXbj70Njg3/Ns1pPjqFokfvylD/mWo+3YaXmp7zK+xOl5rOa8xpT+sGDvHmasywbQq3aPYdQu++eo9Hutju1QYzJEQZVE6LaRrSKd7HWx6hPNMDpGYNzVENUowaCPFp/B2hrMIax2bcZhQGgeGXYm6ZctZdIGDpUkIQdpiAnG63gKRob0OJI5qORt5/FLojozcSx2XosD11FB3uSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvQAeM+pG9SOT4q4CFC2Tr3L+KZkofWL2/2Zovgf/I4=;
 b=csIV+JauL+HiJ6lohCccSc7RKWU4M9Z+LakmS8zcwVMoBFwydYtnVoU92D3MiOMLJf4Fd03tdsCobq0su80s9Dovy7k6oZOi5ClnuRjWpVBHBLqCLSyoGUya+2t/4WXVCOO7NK0kYqtZsyOyoR6M0oYSu9HvgnRkFo1lJnwpKCxlu3NGji+xUFYm9lQj2aH1QfG5A6jlhgd/h12ywVtu2o0efuE93aManVX5J51e2+Y1QJaVZledY6pUNZ82eg2+LjNYie71Q58UTx7yVjYDk6GYEUpztntPdLA8upKAAQM20qzfLpq/pT9/QThLqrf7SyPd9AhcSCWNQAStiJlJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvQAeM+pG9SOT4q4CFC2Tr3L+KZkofWL2/2Zovgf/I4=;
 b=x+AUILiEyFN8RW6tT8tdWBXJiSYMkNP8UoDngCrKXYa4GW2+cohuO3lrra5CJqIEKQZQlwZVccmgeUiDzJXNtFbUhA8gDnNuCeobgZJ0+qNHNzl0/Br8IGmKXM8oqKtcWFVubeeyXVa12qHaNqXqACq+71zZkPDs2ZSLy3pv+5cTOaDQNrPLPaPEcyqIEcwjTV5TiGneMPjsKm7f6nHlfWm8vXRbkgryE3hduhBrdbngcz8UWQJPPni726QU9A/vKY3JisLJVi61iMdDWnnCPrfAQBpUMTLKQ02X025J/OcKVB9nkZS0GoNwbdKFfSqIcRENPkpDD5TiDjpnDSo4fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS5PR04MB9876.eurprd04.prod.outlook.com (2603:10a6:20b:678::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 16:53:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Thu, 17 Sep 2026
 16:53:34 +0000
Date: Thu, 17 Sep 2026 11:53:25 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Marek Vasut <marex@nabladev.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>, robh@kernel.org,
	Frank.Li@kernel.org, imx@lists.linux.dev, conor+dt@kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Message-ID: <aqwbBQUSfd60nVeI@SMW015318>
References: <20260917062543.534416-1-marex@nabladev.com>
 <20260917062543.534416-3-marex@nabladev.com>
 <20260917063512.C71F51F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917063512.C71F51F000FF@smtp.kernel.org>
X-ClientProxiedBy: PH8P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::30) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS5PR04MB9876:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f400ca7-8147-4e02-7045-08df14dc360a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|23010399003|6133799003|3023799007|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	e6yVajsAtrpBaswlDxKnd3Jo2TYHlpyDZN2a2nyGXQp6+5+4gzUAOs8jj/1njyRhkE7cQi8l/aH34Ympt/f7HlSTwQ5EPPqr+rm2I3a6xX2kAhHKZIhXTwyKosVJ5Jaq+YOX1YQdu0IEKvlpcORL26cg2QMs1xXfutQg6O1BXwjWC00jayJCwMWocpHM6k+GSvU5C9Oi3PFS+yhKpIjcWF7oqPOrs+/MuO2hk7mcTLjN3RHuShOfk/ZXblWwJpIbRSNPwj188643R549HGlV8dJ8Vl5XMbcHtYUcdZyRgF5cYuBmOgIE2dzLFVpTg6WXK4YL2vW/wx9/klhJbyZmObfGgZMPxZiaQB+G2cXPfaVmtZw+43ELrlsQVQ/afZU89UGYz/hW4oQXGcn2zanEd89ZMrXm0SFUmz0uUOqT+fhKCdAEIHdfgDkRpsIJxRmSGIFKmVQxDVn2Zy9cIHwWm6GJAz+8iw+EgirpzRXMxZfBs33v0XoKCbZ8fdsljMidSRY85x9CX5U+75Li503QoV4eVtcWzppMKdloeYoYnnb7quKjRF/DIv88iepqdCkPzrmqmSSAkzo2K+cti/zF7JIctOmC858nFNwVXz7OWLM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(23010399003)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?fnSYdXG5xnkRCoEqV6OvXWjzgkXUAbEv6tc1U/OxJlinJkUMQOOjB78HQu?=
 =?iso-8859-1?Q?8VdbvbjrKX3r9Yz8XUeGE4G1WN1ZYz+1IVqa2AtJOHRrQEhLD/D1T+EeQr?=
 =?iso-8859-1?Q?OfZgwsiP1p7hmETZiw2mKrv0EN3QiWevkbEv3pbGpdubebgaWoBLvqmUhm?=
 =?iso-8859-1?Q?OBCJob+4qhRq3GG6bIVND6HFl6Lh7IDC+NsKL3ozQj9XiwitnZ7XXTGeVy?=
 =?iso-8859-1?Q?ddlwt/F85r4nndvPB+288Jn5YJthBlVt7gkeQfKX4o/rteSfp+g9mj3om9?=
 =?iso-8859-1?Q?en+egUccKT2RlDonndN/91TZzqbgK8hjxNPdA+KiiIwkdvZ8vUGIvCLHBl?=
 =?iso-8859-1?Q?cMOI/L/6raa0nmqnHANWBztGhfIwxRdZmIiIsKemltVcgh+Fj5W5vg3AIX?=
 =?iso-8859-1?Q?Ef9cJ28gsCLWLJZ+fBCC173W0dIuXS8kHE/SScKPp9QUkMfnSLunJhE9Wn?=
 =?iso-8859-1?Q?GrWhU+EenrutrVrVB+wAclq7CUES4M9uSP1tfzsy/hDUBfGo9sVd5cyDo1?=
 =?iso-8859-1?Q?YIY2O53c4gvGsbSkFC6ZruXVPg6E4uSCBVpfbemHVCqeRqUK66VNQmAN7H?=
 =?iso-8859-1?Q?BAq1Ai6D52lj4oRrG2fFJW7EDbcOf+Kk2BTwwDtAtrKwuSsGhdfYAiJ76I?=
 =?iso-8859-1?Q?I5/RKZb5aKC6U5JfX5ObvKETyS3NAOQUjAQRffhmFdwKaJrNiCVOUBjyiE?=
 =?iso-8859-1?Q?WAoO9e7eVZhnhMcLnuqaR/SGPsORYR9NlM0nLw7QROm0BufcIr+KOqTSBm?=
 =?iso-8859-1?Q?Rf9uyuSxXcMSBGPoVWQC3niuRIxWNYQHeg9JEpLwj5MORl+w85t9qWajss?=
 =?iso-8859-1?Q?pdEK7CwpozaWRStaimStcrsf4rxLqlbK0NSUB08RCOgtC3WnQtNDGCg/CQ?=
 =?iso-8859-1?Q?VLpzcwChPpdz9fXgY9sMWWue/P7laKLbfTS2WK8cpcMBc/eesPRyhpi32j?=
 =?iso-8859-1?Q?PfG4T2Cfj8VtiXe8ItNOT+4p6qdUFibn+tFDXbS4wWdsgw9Nijyk0XDrW7?=
 =?iso-8859-1?Q?LYtf+MdBObudKYCQ/xG7CwU1Ss9kSGz15xi3GrQjnBFDVYQxXt5PArVrfH?=
 =?iso-8859-1?Q?ltgWQyLLyGfN7YNPNX3S1Dz8IY3IU22sqmBCI5GM7PQvPx0CD3rI4cDP0X?=
 =?iso-8859-1?Q?p23HsktAukKGTqUADg0rRKyk6WZP/VQmVXHmwpYoJE5mRe8Xg6HPNgiuA8?=
 =?iso-8859-1?Q?myrdwmVZ3ufFTYc7RjtoNQeShEVsPKBzEZLa8vaIa9kHkwIwA7Y6ktW2FE?=
 =?iso-8859-1?Q?LD3HeTLa2PtDUvW1IHAttW8t/mZI22CSzQAk3kSw3dyLYF3ETmLdma0vRc?=
 =?iso-8859-1?Q?Fg5he86G7nDr06xNw3fYKTMICooaCUuMqNJNw/MnnYmS+w/4HUVZtxZlYB?=
 =?iso-8859-1?Q?FcCJuntl9EBUElsTSeoxGOGYxqD//ci5DCqez2BDYaWXkUNoZfKV0P2cT5?=
 =?iso-8859-1?Q?/xOgT6Xpwkejzm28Y9IWYamPyveGtUbq0p1ucm7trs82+ZPBH4YN1Hdwqu?=
 =?iso-8859-1?Q?udUPtcNnLCyWY1lRV8AamYLtQ9N1UdYR7hrcZmxfmuWSBV8rlmMb0AhCIF?=
 =?iso-8859-1?Q?VNIOTu7IsWr04Lm7wLkUVvhERUWKHISfqi3kniNb0Vys4+qbxde7YY/xDx?=
 =?iso-8859-1?Q?2qwhWkEulUDXK1XHD/FOmQEDl3PXy1uTWtrSrBdI1LSd/sYpJpxhT/R/cr?=
 =?iso-8859-1?Q?/HN6RuISxEan13Hl6oQcpEZBY71gRERFLVwr6c29gyuFFFOQWmcJU30JtB?=
 =?iso-8859-1?Q?+w87Rb3pKSZ40NrL6duYbSjLHScSS1d6yyFkt8cTkAmgd6P/Dq5lrDViPX?=
 =?iso-8859-1?Q?wJ1/en3W9r39u4YpS10PxujnHkstZxHzvu1+b5hypiHZf6Y7Qq6R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f400ca7-8147-4e02-7045-08df14dc360a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:53:34.5208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ik/NecqbVwsWnUGxp2QPpKpD543mMP62MYW/wQLjLiW1uffyGxuXa2GC/4u9HeAAR98V2SYgKWygyc9eJpf5BRq/nb8Kd8YpLe5mQrG7fufjs3rFf8jOZ7fJ8AnX8U33
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9876

On Thu, Sep 17, 2026 at 06:35:12AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [High] dts: pcal6524 interrupt polarity is incorrectly set to LEVEL_HIGH
> - [Medium] dts: Ethernet PHY reset-gpios configured with wrong polarity
> - [Medium] dts: eMMC reset GPIO defined but unused in usdhc1
> - [Medium] dts: reg_panel_vcc regulator missing enable-active-high property
> - [Medium] dts: M.2 Key-E (usdhc3) slot missing power regulator
> - [Low] dts: tas2552 codec uses deprecated enable-gpio instead of enable-gpios
> --
>
> commit 5792bafb068af6288c67560ae9fb90a4c34326af
> Author: Marek Vasut <marex@nabladev.com>
> arm64: dts: imx95: Add support for Data Modul i.MX95 eDM SBC
>
> This commit adds support for the Data Modul i.MX95 eDM SBC evaluation board,
> enabling various peripherals like serial console, ethernet, eMMC, SD,
> SPI NOR, USB, and PCIe.
>
> > diff --git a/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts b/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
> > new file mode 100644
> > index 0000000000000..0181262eb8a98
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx95-data-modul-edm-sbc.dts
>
> [ ... ]
>
> > +	reg_panel_vcc: regulator-panel-vcc {
> > +		compatible = "regulator-fixed";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-name = "PANEL_VCC";
> > +		gpios = <&i2c2_gpio_expander_20 17 0>;

gpio third arg 0, means GPIO_ACTIVE_HIGH

	so need enable-active-high

if your boards have invertor should use GPIO_ACTIVE_LOW


> > +		/* Disabled by default, unless display board plugged in. */
> > +		status = "disabled";
> > +	};
>
> [Severity: Medium]
> Does reg_panel_vcc need an enable-active-high property? Without it, the
> regulator defaults to active-low logic, which will drive the panel VCC low
> when the regulator is enabled.
>
> [ ... ]
>
> > +	i2c2_gpio_expander_20: gpio@20 {	/* U12 */
> > +		compatible = "nxp,pcal6524";
> > +		reg = <0x20>;
> > +		#gpio-cells = <2>;
> > +		gpio-controller;
> > +		#interrupt-cells = <2>;
> > +		interrupt-controller;
> > +		interrupts-extended = <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;
>
> [Severity: High]
> Will triggering interrupts-extended on IRQ_TYPE_LEVEL_HIGH cause an interrupt
> storm? The PCAL6524 INT output is an open-drain, active-low signal, so the
> line will idle high.

Yes, suppose it should LOW to trigger irq.


>
> [ ... ]
>
> > +	i2c2_gpio_expander_21: gpio@21 {	/* U14 */
> > +		compatible = "nxp,pcal6524";
> > +		reg = <0x21>;
> > +		#gpio-cells = <2>;
> > +		gpio-controller;
> > +		#interrupt-cells = <2>;
> > +		interrupt-controller;
> > +		interrupts-extended = <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;
>
> [Severity: High]
> Could this IRQ_TYPE_LEVEL_HIGH configuration also lead to an interrupt
> storm for i2c2_gpio_expander_21?
>
> [ ... ]
>
> > +	i2c2_gpio_expander_22: gpio@22 {	/* U13 */
> > +		compatible = "nxp,pcal6524";
> > +		reg = <0x22>;
> > +		#gpio-cells = <2>;
> > +		gpio-controller;
> > +		#interrupt-cells = <2>;
> > +		interrupt-controller;
> > +		interrupts-extended = <&gpio5 11 IRQ_TYPE_LEVEL_HIGH>;
>
> [Severity: High]
> Does i2c2_gpio_expander_22 similarly need to be configured for an active-low
> interrupt instead of IRQ_TYPE_LEVEL_HIGH?
>
> [ ... ]
>
> > +	tas2552: audio-codec@40 {
> > +		compatible = "ti,tas2552";
> > +		reg = <0x40>;
> > +		#sound-dai-cells = <0>;
> > +		avdd-supply = <&reg_1p8v>;
> > +		iovdd-supply = <&reg_3p3v>;
> > +		vbat-supply = <&reg_5p0v>;
> > +		enable-gpio = <&i2c2_gpio_expander_20 23 GPIO_ACTIVE_HIGH>;
>
> [Severity: Low]
> This isn't a bug, but should tas2552 be using the enable-gpios property name
> instead of the deprecated enable-gpio? The patch changelog mentions replacing
> gpio with gpios DT properties.

Please fix this one.

>
> [ ... ]
>
> > +	ethphy0: ethernet-phy@1 {	/* KSZ9131RNXI U20 */
> > +		compatible = "ethernet-phy-id0022.1640";
> > +		reg = <1>;
> > +		interrupts-extended = <&gpio1 10 IRQ_TYPE_LEVEL_LOW>;
> > +		reset-assert-us = <1000>;
> > +		/* RESET_N signal rise time ~100ms */
> > +		reset-deassert-us = <120000>;
> > +		reset-gpios = <&i2c2_gpio_expander_22 4 GPIO_ACTIVE_HIGH>;
>
> [Severity: Medium]
> Will ethphy0 be held in reset permanently? The KSZ9131RNXI RESET_N signal is
> active-low, so defining reset-gpios with GPIO_ACTIVE_HIGH will drive the line
> high to assert reset.
>
> > +	};
> > +
> > +	ethphy1: ethernet-phy@2 {	/* KSZ9131RNXI U22 */
> > +		compatible = "ethernet-phy-id0022.1640";
> > +		reg = <2>;
> > +		interrupts-extended = <&gpio1 10 IRQ_TYPE_LEVEL_LOW>;
> > +		reset-assert-us = <1000>;
> > +		/* RESET_N signal rise time ~100ms */
> > +		reset-deassert-us = <120000>;
> > +		reset-gpios = <&i2c2_gpio_expander_22 5 GPIO_ACTIVE_HIGH>;
>
> [Severity: Medium]
> Does ethphy1 also suffer from the incorrect GPIO_ACTIVE_HIGH reset polarity?

Is it correct?

>
> [ ... ]
>
> > +&usdhc1 {	/* eMMC */
> > +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> > +	pinctrl-0 = <&pinctrl_usdhc1>;
>
> [Severity: Medium]
> Could usdhc1 be missing its reset sequence configuration? The hardware
> provides an eMMC_RESET line on the I2C GPIO expander, but it isn't consumed
> via mmc-pwrseq or reset-gpios. This might cause the eMMC to fail to initialize
> during warm reboots.

Please check this

Frank

>
> [ ... ]
>
> > +&usdhc3 {	/* M.2 Key-E */
> > +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> > +	pinctrl-0 = <&pinctrl_usdhc3>;
>
> [Severity: Medium]
> Does the usdhc3 node need a vmmc-supply? The VDD_3V3_M2-E_EN pin is defined on
> the expander but there is no fixed regulator defined to power the M.2 Key-E
> slot, which might leave peripherals undetectable.
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260917062543.534416-1-marex@nabladev.com?part=3
