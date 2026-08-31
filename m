Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDCB39FCB5;
	Mon, 31 Aug 2026 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188139; cv=fail; b=jxr0fC1W7HeazDCTZj28MRP+JHIDiZxLj0qI0Q1bDmpnGuEmrAXq6mrNJQkXX7k9x1QILkMkeCXcgTqEdtvxjgvH3xojTnybFfxuUoozzT2ndCFvQMq3P/R9ZJ2zk0X6oc8Z6SxEUhVe62h612iG3tPgYtIN2v1tOfTdNQMZcMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188139; c=relaxed/simple;
	bh=gOgRgjf8LHe3zANsdDtLee1I2pyu5iiwwch/MG/t6Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=as9OKRnvGtFIJEQFGXCVfbRypkv99FlKDztLNu5z6vzxn0aFk/CzbxJ5GpY6RxDZAr3dYcltLKHaK3OHsZdPwc17z7FkmGlzHt29jsOKbU23jXXbCh+jPFGU8MV+AC8n9xy/uZ6qFdDE+AbQyWDr+DFfwg3jscggn2MhzBJa8QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MZWISRim; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MZWISRim"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZ5KqW3ZhBtNEjiUO72QepbbYauZoUq6oFcosQS7HFyzQICEUU64ZRoL9IwJsW0vElaTuzj0a2gHTPscMOhqK3AoVpLE9kKso5Hkc2nzAtm7++85HDikJ81Vw7fD318hPIBaG6ftnHx1z753iFeMwZhRpZQuiojgzJDoKoy1GtbOoC0wDg7hhUQdulnjytbTd38dp34SxH8+CqCGuGiSnXWIZeYKb1YeD1GcLFvG1eVPHZzwmcJ1M4QXqE/5teDnAAFbbsZQTT7KSUGe63DhajNotuiDpnTZsLRy/pv1OMYQWJOjZpcUFfA8mjpfkTtYcFXEljgJXzxy9uJcyXNnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMB8AiJAAjc1F0KweYf/U+g69nZfsck0QFelr5Qts0k=;
 b=eKydWdMYT51yME4S8dgxKUQakN9SkBOGH80LknLSO5VUzVLf4z8Qwaz3QL1gAGQwwewo/5RC2xEkpnlAqG/OLfNcT7YV9FcoEy35KwE5n4Z5WEBe7f5DeGzvLQpWZ1bRCOXpqeOiUt9FGsTKnCePDSpSv8e3SFggHQQe/p4WoSbOC6uCHV0o6prdRUnR72fsOSspAvizmjTPHLhcRUf0FpbTdwKT89yI+rO5JuJBP4uGDxUZO9wKhDERxrgu61028bAHvBHsf6jWibmj/5l6qQDF2KY3OatioiAbdO9dc4TOZURa54A3ZTknlpz6Jt9LkmG2VF0OdwTtfXW7VvvT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMB8AiJAAjc1F0KweYf/U+g69nZfsck0QFelr5Qts0k=;
 b=MZWISRimFVqdV72+Bw1RGfglfE7RCGvNytqNpIG+QGCOJVwZR2i6JVQFFpc1KplwMvNWFqignTXjcPQpvf/fGvRi8nL+lNT+9dGn7kD58IJ49gBL1lrZG86Ti4gZAxhDzF9uc8bwuEbpu73p1qYmqHTX+wlg97hZ6scIQ8Utn35DF4DdWPhI7aVC0jFKygFTM8og+7zhF3XcYEE9fxIGFVt1HlqNhe3K3ct9q9vYxn3FQnQKaIgIlATwcyr4l2lmhJ/MaoGdBufy4OCenjMXDb0BfmI2mKmLvUyi+HJx/EdJsf+6yVl+d7TJFGSUA70gQRvjq9qVtlimPGNyhNDKyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9659.eurprd04.prod.outlook.com (2603:10a6:10:320::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:55:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 14:55:33 +0000
Date: Mon, 31 Aug 2026 09:55:23 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: sashiko-reviews@lists.linux.dev, Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>, conor+dt@kernel.org,
	olteanv@gmail.com, vkoul@kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, Frank.Li@kernel.org, robh@kernel.org,
	neil.armstrong@linaro.org, Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-can@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH V2 3/3] arm64: dts: freescale: Add chargebyte Charge
 Control Y
Message-ID: <apWV22qLzOLOux7N@SMW015318>
References: <20260831083539.8287-1-wahrenst@gmx.net>
 <20260831083539.8287-4-wahrenst@gmx.net>
 <20260831090445.0F50B1F000E9@smtp.kernel.org>
 <ceccb248-8801-402b-b147-916eb9ed3883@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceccb248-8801-402b-b147-916eb9ed3883@gmx.net>
X-ClientProxiedBy: PH1PEPF000132FB.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::2c) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c70b070-1854-4f24-3945-08df076fe815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|19092799006|6133799003|22082099003|18002099003|56012099006|3023799007|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	XVD2cinQWuQVGXU/hw0n2gQPNB0wU7VnhicUCtQMhFkbwrhzGHUNxksozuwPkVTlTO3yAUr+YDgbzunfkHVFNvXiSyhIfgaFmqPUbEvCaD/rL44cOILjyc6Twy5OkI1+ZrPWcAHR0x83cqMAXE0GiIS8q0PkWS7NI/1+sGg8VDiiDyawln6Zy2eGAi9+ww6zviX3mxS/ekpiVDBo1jkYIjXuVxG56QWeIg0sVOzd34Tl4kNRpGdtpGe1TVjBlUyvw909FAXnLFHFBDD83YssdbS/EM1fB2XyscuGV0WNZj1WJPw9c3GXf2075aHXAXRiPrJM9EwuGQ78UIsPMalFdmT4l3ouopxFQH6kTHMDi56GW2e2JV9c09zvZiYlXA+QxI4bqyZfaH3FOCHjZAVSEYdmt+wdN9m1qaqtosAy/MqEZcx+4Igm/uXpEAOe0V2obaZP84a8bVWMXJ/I4foxvSci277Remqq1cIYYoAZizhg0h+sJZWiRScnWtyg1SUw7ywGYsqGA2bYk0nb50dcL4Xi57KOCQuuzgJPbO+Nrux3qAywiwFRy80fPxijAjuzAFcS1cGCk1/WaSnI2xmQ/z5K7lFRZQ8IDUOR5AkFdje2EE/gTkKMse+iu8/3mN2qLk9/2N6fIjuZBv9zL44xguFJMKrr+rayfSVcDEcwhCY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(19092799006)(6133799003)(22082099003)(18002099003)(56012099006)(3023799007)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vq1kqUQmR5P8GC8zojMbLhIP7SmlOrNmhmRR8UkiKouQRZnW3Ffx0aEGKEOY?=
 =?us-ascii?Q?x5esPI10VMxYNjF2tmdloeknl83k7BUntfgp2S+K0IDMgFQjT5B791fQbMrS?=
 =?us-ascii?Q?FaOragU5OEffIOh5HvCcNCq5OOlhriEJ2gqzeGgnCw1WSN1gIv5dbC778JZV?=
 =?us-ascii?Q?4d9WY0mCdrTcCmPArkBfWbCtHLifgs+7ZC/YPj53NW6Mj5dtvqbHM3OFqS9w?=
 =?us-ascii?Q?CLZ9nxH8A/3e6/nwZV/oK9N6XQH8C9AgIKxEa6Muw2V4rGGx8zW+BF/zZEfk?=
 =?us-ascii?Q?gRdwcMyDhlb76vCxyl1Ntwqf3g2pnODIw2WtDfcmNzG/GUOE3gNWD+OUzk/1?=
 =?us-ascii?Q?hyVOHMkovF5rz5b7R466+9SUOGhXLk645mfx+hWtO72Soz9QqqADeEucrPrb?=
 =?us-ascii?Q?5key8D17/a6uHT6G65Ll/X17WaxZKvXPzB+yW6bE/4fe352uLLDWBIRNCyVK?=
 =?us-ascii?Q?biF4bkEeiyvL5F8GVrk5obMu4vdInUjAZ5xYNY2AOq6eezs4Gjqe3TkWGW00?=
 =?us-ascii?Q?sZul4d4gwUOncLdOSTI+ss7mX3kqKuf5bfvYaxXBVNZhZML7dn+cdoRJjaop?=
 =?us-ascii?Q?cM0M5b08TtbXV6CdrSY74XmtWCV1NX4amkaFxwgJpScHKYlrFaI10DkoVFGh?=
 =?us-ascii?Q?UUbKDT2OawujZ6nktBXIOij3g1mhEkisPh3Hm0Z2vu4FPgibipxlY2YQQ5cW?=
 =?us-ascii?Q?qjUhOaYXVoncE9sreSLED2AfaqQriMcDjGGsTWCed4tGQzvETJ3pqYP6w58R?=
 =?us-ascii?Q?K+pS/lcki+5OBNZ4HK/NYa4Adghfb2cuM7tuXMfs9julpZ3KJfdGYvLwkoIi?=
 =?us-ascii?Q?xkGlM0VufO9907pl2F21eRiAaMwsY7yYW9So21zadp71Y8bEI+1i75J4bCdl?=
 =?us-ascii?Q?aReuF11mL8URpiObfBWbOr/bqNsN70jrHtJxwTSlMXTSFZlqVxKxAN1U7enf?=
 =?us-ascii?Q?et29p6djfQTmWvsdGhBJSd0ZS8zT6+FyY7wvO0hw44J4gvU+V+Z32y1F5oyL?=
 =?us-ascii?Q?f1bmu8PcEOKCLzT9SUvdQ3NkICQHtM/CEVE/ZFiHKBLemoh4qp+p98JQDPP8?=
 =?us-ascii?Q?A4/0LFu7I9j9VSC+fvihJJH07FcBKSPcFWpBhkJ85kKpRhYlatIsCUvdmG58?=
 =?us-ascii?Q?1Rw6GzaW7MknaJgfxBNhnM+UbWZmR0G+4lfQw4Md0782b8uX4CkKv5+XGC3f?=
 =?us-ascii?Q?2PWMCwwCg4d3jnYuvIyjvo1lJSmLQWPz651cWcZAkhYs4BLuDDrllw3/CoqX?=
 =?us-ascii?Q?29DEyFM6DY8PKpLfiaooKxuoDpvOxfCGIB6BHcdCFrjrmuPjicJnopowDrbn?=
 =?us-ascii?Q?vWSF58bPCXY/RPs6lLDFokoZfltL43LdmEH4nL+gouA2entGbx/0rxIvxwss?=
 =?us-ascii?Q?dFU86H6pw1ER4V1jV2eqnm8J+0jYz9PEwZhfYwASbq2bunXqjSUJIKTuqrw3?=
 =?us-ascii?Q?eZKnjlqTAtyhKjeSUUGUVAjwoPj0O/eFt7DpodGKf1XEkwdeBAbCxLWk74AX?=
 =?us-ascii?Q?xf3gkckdEvC/iBB0oZerI6lxfW8XSbSuOOxwrInkIwvGc/+dLFx0bvyISvcg?=
 =?us-ascii?Q?vbfDTveEHDYdrQPNL15PNmYZYXPAwLIBsLmOBofcLjfJvhg1qgGCq8l4ilhq?=
 =?us-ascii?Q?JV++kFXb79kbnKcV3RQOc2B1mjh9wECzif3acZCoN8G6Dc+OdAOhjX4+LM6+?=
 =?us-ascii?Q?nIFg22lo4c1RciaacQ7W8C8rXuZJKCpTnnHYlfbTN8d6AenuekOZMZy5slLx?=
 =?us-ascii?Q?48S/BXLJVLCIHe3YTS3XTXXzyhlE4u9dQhsHuNAxuD1pI/xkc1+K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c70b070-1854-4f24-3945-08df076fe815
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:55:32.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbBnkFkhhwOIVChAsiQFO/wUGkzTPxb/FggbhRqVTQ6DTSEov4CC790bL1WVPqsyre9eqw+BMr0DUZseddKggdn8YhpFs9ecCYeklnojCLNlX/KyJKV1cPXG1GA3+lmN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9659

On Mon, Aug 31, 2026 at 03:47:15PM +0200, Stefan Wahren wrote:
> Am 31.08.26 um 11:04 schrieb sashiko-bot@kernel.org:
> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > - [Medium] Missing GPIO initialization / Unused pin for X_nRST_LAN
> > - [Medium] Missing Pin Mux Configuration for USDHC2_VSELECT in default state
> > - [Low] DT Binding Violation: Undocumented compatible string 'microchip,mcp2542'
> > --
> >
> > commit c595019b7dc419cc298a111c2b215904a12f65e1
> > Author: Stefan Wahren <wahrenst@gmx.net>
> > arm64: dts: freescale: Add chargebyte Charge Control Y
> >
> > This commit introduces device tree support for the chargebyte Charge Control Y,
> > an Electrical Vehicle Supply Equipment for MCS charging stations based on the
> > phyCORE-i.MX 93 ARM SoM. It defines necessary pin multiplexing, peripherals
> > like CAN and Ethernet, and device-specific layouts.
> >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts b/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts
> > > new file mode 100644
> > > index 0000000000000..0405098cc05c4
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx93-charge-control-y.dts
> > [ ... ]
> >
> > > +	// Heartbeat LED of phyCore is not populated
> > > +	/delete-node/ leds;
> > > +
> > > +	flexcan1_tc: can-phy0 {
> > > +		compatible = "microchip,mcp2542", "ti,tcan1042";
> > [Severity: Low]
> > Is the "microchip,mcp2542" compatible string documented in any devicetree
> > binding schema?
> This is included in patch #2.
> > Using an undocumented compatible string here might cause `make dtbs_check`
> > validation tooling to fail.
> I verified this patch series with "make dtbs_check". False positive?
> >
> > > +		#phy-cells = <0>;
> > > +		max-bitrate = <1000000>;
> > > +	};
> > [ ... ]
> >
> > > +	pinctrl_flexcan1: flexcan1grp {
> > > +		fsl,pins = <
> > > +			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX	0x139e
> > > +			MX93_PAD_PDM_CLK__CAN1_TX		0x1382
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_gpio1: gpio1grp {
> > > +		fsl,pins = <
> > > +			MX93_PAD_I2C2_SDA__GPIO1_IO03		0x31e
> > [Severity: Medium]
> > Does the X_nRST_LAN reset pin (GPIO1_IO03) need a GPIO hog or a driver
> > consumer (e.g., via a reset-gpios property) in the device tree?
> >
> > Since the upstream lan865x SPI kernel driver does not parse or manage
> > reset-gpios, leaving its functional state unmanaged here might result in the
> > hardware reset pin floating or being left in an indeterminate state.
> >
> > Could this cause the LAN8651 Ethernet interface to fail to emerge from reset
> > and initialize properly on a cold boot?
> As already mentioned in the cover letter, I like to proceed with the version
> until the reset management is implemented in LAN8651.
> The pin is not floating because there is a pull resistor in hardware.
>
> Should I move the explanation to the commit message of this patch or add a
> comment in the DTS?

Comments in code.

Frank

> >
> > > +			MX93_PAD_PDM_BIT_STREAM1__GPIO1_IO10	0x382
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_gpio4: gpio4grp {
> > [ ... ]
> >
> > > +	pinctrl_usdhc2_cd: usdhc2cdgrp {
> > > +		fsl,pins = <
> > > +			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> > > +		>;
> > > +	};
> > > +
> > > +	/* need to config the SION for data and cmd pad, refer to ERR052021 */
> > > +	pinctrl_usdhc2_default: usdhc2grp {
> > > +		fsl,pins = <
> > > +			MX93_PAD_SD2_CLK__USDHC2_CLK		0x119e
> > > +			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000139e
> > > +			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000138e
> > > +			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000138e
> > > +			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000138e
> > > +			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000139e
> > [Severity: Medium]
> > Should MX93_PAD_SD2_VSELECT__USDHC2_VSELECT be included in this default
> > state group?
> >
> > The MMC core initially brings up the SD card in the default 3.3V state. Without
> > the USDHC2_VSELECT pad configured here, the controller might not be able to
> > actively manage the IO voltage selection in its default state.
> >
> > Could this absence lead to unpredictable external voltage regulator behavior or
> > SD card initialization failures?
> Nice catch, will fix it
>
> Best regards
> >
> > > +		>;
> > > +	};
> > > +
> > > +	/* need to config the SION for data and cmd pad, refer to ERR052021 */
> > > +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
>
