Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2351CF41;
	Wed, 30 Sep 2026 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803308; cv=fail; b=n6lrPDcOSnPuBLuO+y/28AsM9qoaP+j+2qXIEufuU3nDeMW2ybed5JyZz9Ax0GCWmRQQWnzKaOeAMoEbqHCv9z50yKOv9cLsEyRbCH7iXdrHCo450MLg9kiL8LLIzSOc5pk3xbgzP8T7AI7ARKol5nmAkDbWG3H8rVtUZZcb0Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803308; c=relaxed/simple;
	bh=PfFrApu3ZomijZftWfjaxOZF5fstHXZa0emfWByb58c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lU9QmEK9IJGmoMpl957dBUsvNlq+toNvYNSHnV3VnY6CBh86NIQEEjqe0/eQpW7+yub6sXfUpNob9dvCDDF5yyQLqqNec5Plh19wmb+7dqzH8FGYcr44FDdyo/hiK/4f1mER1I4szRWcgL5U+isUplcSSPl8RVYsGA2hvMHcErY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=f178iBn6; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="f178iBn6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCSNysgf48GqIo8z4iaTtWl8Mf/8JuzFL+kJhJZP4iNtpEA9oG5OZ0KDigANbTYw68Q1kSMc3GlKEncQcNH1fbaf6LtgiqD4RKozN6ZmzRS6Us7YZzwt0JTtTwEIAmSMJtjwxh6DSeViGdRiSdsMxhxCHWKcb2FHP9sc1E7lu4M2RJzCaPfs/2beS212i/8ucGXLuOE6q7YEWvpcyaNVZKOSDpyKcsef9Wj4SSENeH6TnEg5bhXfmrdB3MY9TtLo++33GyMa3muCbQmBvJp825LkwtJuYFC4zpGl8XdXMLgbv2DTgmyW3zuJ2QZf+q2XL4A4pKQ3RXmenDzEBHnR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0Pm+HDVARpjESyI7l/vxhqJmaeDd3/9JOwo7s6JK1c=;
 b=xz+6p6jiSmcMeavtXZc0YqitusjaIIqJ62jl8fl0BhjTS6osHnIYPzwX+vKac+4DXwq5XJxQCLrwrbbnbB0qTYYimf0B4tVN0eS8Mx7Ql/pEDzfxgNhzhASmLj02qwtSLca9mwMSjRNjqsCQNzfxT3ksg7DmDJrGUvlkM9azFHKszoCZVirYMGW/vRng85xp44lfRpJUY/9FS5n+xb235KuPKyxbHzuTEz/5dcLxs51PZxeKCcARwDLJ0M2jr9WX0g6zs90w++OjZL1OqyoP2yrEKtDI41lkw+tmx7xzsGp49k1+QTSccEQy0xosj4rVnId8ymga3mLm4MDxZbX8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0Pm+HDVARpjESyI7l/vxhqJmaeDd3/9JOwo7s6JK1c=;
 b=f178iBn67D+X7anQZMnnl1vCU1kf6wbDuwxrC5KXO3lAkZGqbuoyhNqvqJ7ocVkhQu55AmGyhtVgIJku3qwHzUOJoA00o4UADWXxNvkUNxUPgbSyI2/79CFigVbQC69RLvwVAccFrGGcq3q8izRpiRc7lbj0omG0EEuDEqgFIOAldRlyMzUvyJuqqYqM5dvARpzCudgsdob21On4Csq/0ffTqTo0oe53A0mqsQ5qczd81Oq5qfJRDBoOTc2s6Va9YW9EbJlw1gtwE6+Gy3XC/sv/m8X0qhh7A90pZYDnkB+L3O6vcIT+4Lh03v7/Le22dcXtRBmZniWyjKI4SxEOyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB704257.eurprd04.prod.outlook.com (2603:10a6:150:39e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 21:21:40 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 21:21:40 +0000
Date: Wed, 30 Sep 2026 17:21:31 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-arm-kernel@lists.infradead.org,
	Aswath Govindraju <a-govindraju@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Message-ID: <ar19W4wX07p8u3_5@lizhi-Precision-Tower-5810>
References: <20260928204741.175754-1-marex@nabladev.com>
 <20260928204741.175754-3-marex@nabladev.com>
 <arvPDq8sjjv7na01@SMW015318>
 <49303872-5622-4e1d-8e1a-01394ec29367@nabladev.com>
 <20260930174413.GA2463938@francesco-nb>
 <ar1bhpji35CbArtY@SMW015318>
 <17f240e5-9c65-4562-ba51-535b0c69c5fd@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f240e5-9c65-4562-ba51-535b0c69c5fd@nabladev.com>
X-ClientProxiedBy: PH8P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB704257:EE_
X-MS-Office365-Filtering-Correlation-Id: 22eefc60-23e5-439b-084b-08df1f38d13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|376014|7416014|18002099003|22082099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7gAndaDrnXOkKSK+D4HqpD10DCwVtQmqGRZhgPjZNVrRypD5B1CTde/Tg+APnztn1xNIZRNL2FjTNz79tbij9dpWdr8EwVvxh9WttKZQR64+olKYnXFeCgK3Z1QRAgQ7GO6SB6Atnc4/kGDWFoKgoMcdSjv8l2KMV/blrs8ny8VRC2DY/LTVSBWEbvbAiIhG9xLyDQ7JL326KByvAKH5HkO3XnjKFOsMW8kdPPdsv8zQnns4kw/oa1oODXvbqmqOPPzjOKQKBRuqh7Qu0dAa8dcQP8uk+2AsAD2Y9PXqZBxzH3Ugv3Hxr/BrenLD4vYSO1HyN83ECS1AqHJ6iDqIohapFbb3aHG6DNl08MCTdLPrfnbLhfOtol4BVTavtmXeu1Zt5SXoqp8d+Jd0ji9Us1zdJlwapGUymJEshvlP2L45lTl0TAfa9zFsK3MTuKuwI3oWpOvbk3I37fWxQNVgXFygN/HhcVOAvlirmulZOZGapE448+eW3N/sbpzyHPk0jeN5ql+SsRz58ceDZ64KPRQFK5xQf+zwsZTXdWgBWDVqJY2mTm0XDFtZ0tdNDgsEIUFugA4eJ5DzyHupqy1uBfo+kVJz7LNmOtXpKV/ZKxSJHVkJishAuvNZYgWsO0ge
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(376014)(7416014)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dDUG4lENvuB3qtMC5NlFvo+ovL/Wvq3CdzuZgAZsX87KjRjTZsR3wxuD9qVE?=
 =?us-ascii?Q?w7MySBTKYJXESBxjjnMY/EBgDljKZmkgU5813RKPibV+ule5YWTeKk55MLUU?=
 =?us-ascii?Q?PBzjUv3YBEc4A/7K31+QebuWtSxbDpOHImRZ0LbWeak7q3zEAUrdIIDFelwI?=
 =?us-ascii?Q?YaVCSSqOGviZS1txgiMd39V+z/c4gxrlsDTi4hy+awmcqNgZ1DYytqRGxsXF?=
 =?us-ascii?Q?xZ503v29gfPtSNmumlfDrMX1XMq9vSx5byDKS3ZRwp7mLhza8j2itE+2ZOaW?=
 =?us-ascii?Q?lqVyavyHP3sjdiV/UOH54mVQB0pENoltjifCmSSYKsbJ5ceAJVWJq+wyE8BR?=
 =?us-ascii?Q?EGt0MgMlAsPfutKB0q0O34WCH3afsL1mLFa73B/XUcl0ZdswrfZEekbuF49F?=
 =?us-ascii?Q?9Xv9ccJe9mdY0jU4+yUJ8nq6TT62YBP2sunw1pMfXYX8gkIYQ68JYvIg5IRs?=
 =?us-ascii?Q?76csF36WrQcXREu1U8oVOmblfgVMaUC5P8bB7I7ybSpCif596vYmxJyW6wPN?=
 =?us-ascii?Q?BNF+ePRqTmfyMzQy4x2CA17UPZvTAHWd9md9Ki2Qatzxvn5DJqS61T3M6HRG?=
 =?us-ascii?Q?/9Dhx5hIFkPlHrX95fPG8G945hN1SxGEMHayWJlaTXAY71lqlsZaoSLUGaEI?=
 =?us-ascii?Q?FtvpCdYVJE7eGl4yqlz+d47VdeuQjGP4oStcjBSA/QHth7Qb0biI1uJdx7n8?=
 =?us-ascii?Q?5FUReuVnvO0d2FhBvPH8eXOvbIv0/j4nZtqpgx8icvg3SJiwO8ICq3wbq2bk?=
 =?us-ascii?Q?l3zB/NiuQ6v3yB0V2moI7I/vEmdSNajbpCXowU0JBpweLgOOYhBf9AzI6ERq?=
 =?us-ascii?Q?NmKi/vwnLnCp2+gnB1ARE7m9Ec0/DfiHbw1laVheCjlj5icRzVFvEl49RDSo?=
 =?us-ascii?Q?kkqNyk92KJVhNCwj7bW45RFgCiuatt+svFhvIaekdefUul5vEeo5W3Gk6Qgz?=
 =?us-ascii?Q?9zi7NS1n93S6ZnVrqca9W8CT5Fz4vUWBRhjKQ7CwFsmY67qLpOJ12XvFzIVD?=
 =?us-ascii?Q?0B2tKm+JtueYwgB17LU9iQufCDCjFXhUcIPMQ6zO51GNnhGLsmYT0F8I4H8A?=
 =?us-ascii?Q?4dG/rNYI0vKuh6RX156tYOB3sLCZFeI9u6Kdi8ZyUVNTswnX2BjVr6pj5Qvu?=
 =?us-ascii?Q?w4jMR/DRr7nOQu/whvgxlE5JxY13NepZ7pA/kqR+BHMDgKc78a3cFPvgow1Q?=
 =?us-ascii?Q?kOmQv2O/J8BBPc3dlBtfCSSnhryavDU2p5VT+NWZyKcsRDt6MSj+7Sy+YrSU?=
 =?us-ascii?Q?Z1kx4YxzWvlIqRgbdmcQslwDBFG3Wj0xOlQwvk3ESH9wncnsnM9UziKi5Ok5?=
 =?us-ascii?Q?4bUSpLZsQXOKNeNm2GSKAZulgXeivBioc+ciWsUHOpsDzfXIL1+QveQAFyC4?=
 =?us-ascii?Q?p9uWVo32snhGMb75gE/B2de34QU3sUYUftIKNLawPFAO9fACSAXv2CKcuf90?=
 =?us-ascii?Q?tp6ks5pIDqSP6RgDMHTnlgq03jWkvty96TYs0u7Cm7MdSvNkjaDf3Tnwh+t3?=
 =?us-ascii?Q?Cuu/iSIOpGrxQ8YCLFT1E8QYlsiYjb5LpwERB6blywedG0VNE+x7j78NjIq6?=
 =?us-ascii?Q?RoCQpuOxCVZEfPRgdxh5EtQZka5CoK6pi4C1t2o9JHDY4FaBtb1hGbmmqnWb?=
 =?us-ascii?Q?xiVHm/HwV0HLlvsRxfes6O2gdyvDtn309z7Bi9LN8824NTwSgxXI5tTBlvR6?=
 =?us-ascii?Q?trUYsb7bN1xEdFmgS6Lh8j4EsTFDVe3rh2hHyidmN+mKdmTWiYuOE8VnkLiH?=
 =?us-ascii?Q?AK+jZ44lZoat1zxTEPvWSncSqGMGgYByoG2zbiTQNFIK2feSpB0f?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22eefc60-23e5-439b-084b-08df1f38d13f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 21:21:40.0937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRdCdPgOXIeWY1lyicWWVSWJvGsM7UsypVbugpepZQ17enNRLYjd4o07tiis3n6bQ4aL7Lj3ugTd6bNheYuIg4ImBhE3V1FeQdPe4khqu0PNWZvh+B8nY8wwg84Kq5aT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB704257

On Wed, Sep 30, 2026 at 09:29:34PM +0200, Marek Vasut wrote:
> On 9/30/26 8:57 PM, Frank Li wrote:
> > On Wed, Sep 30, 2026 at 07:44:13PM +0200, Francesco Dolcini wrote:
> > > On Tue, Sep 29, 2026 at 05:20:27PM +0200, Marek Vasut wrote:
> > > > On 9/29/26 4:45 PM, Frank Li wrote:
> > > >
> > > > Hello Frank,
> > > >
> > > > > > +	backlight_lvds: backlight-lvds {
> > > > > > +		compatible = "pwm-backlight";
> > > > > > +		pinctrl-names = "default";
> > > > > > +		pinctrl-0 = <&pinctrl_panel_backlight_lvds>;
> > > > > > +		brightness-levels = <0 1 10 20 30 40 50 60 70 75 80 90 100>;
> > > > > > +		default-brightness-level = <7>;
> > > > > > +		enable-gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>;
> > > > > > +		pwms = <&tpm3 3 5000000 0>;
> > > > > > +		/* Disabled by default, unless display board plugged in. */
> > > > > > +		status = "disabled";
> > > > > > +	};
> > > > >
> > > > > The both backlight is not used in this dts, can you remove it and
> > > > > add these when it real use.
> > > > It's the same thing we do on the other boards, so I would prefer to keep
> > > > this consistent:
> > >
> > > I agree with Marek, and I would not use the criteria about being used or
> > > not.
> >
> >
> > Others boards: some has dtso, which use it. And krzy have some concern for
> > similar case although he have not reply alex's answer.
> >
> > https://lore.kernel.org/imx/30599533-91de-41fd-9420-3f8693ec92ac@kernel.org/
> >
> > And it is most likely go through nexus connector node to support display
> > panel in future.
>
> I do not think nexus node will apply to this connector, no.
>
> > So I suggest remove it now and add it when need.
> Can we please go with consistency between these boards from one vendor ?

Yes, I am keeping consistency, then ask remove it. I applied alex's v2
version. I put v1 link to show krzy's concern.

https://lore.kernel.org/imx/20260319125013.2421621-3-alexander.stein@ew.tq-group.com/

Changes in v2:
* Changed commit message to imperative form
* Remove (currently unused) display and backlight nodes

Frnak

>
> Thank you.
