Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0F3B05A4;
	Wed, 30 Sep 2026 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794647; cv=fail; b=kXLRRiNqYeHJ+61W+agMN5T91JgpM4hcP2a4uCNJZtk9by/XJP3UCzckkv1iNm1KPr1dvdlrVRJBIIO9uavWex1eiOgU2QF5mhxhiu2bTZdDNdLpX/slNdJzC0qoCMq3Wb65g8gCXEx6RGeXsEaYD0pu8wmWbYUl0ieUe2GP7mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794647; c=relaxed/simple;
	bh=fD3pSp5e9P7DBj5Qs3WUoZnvjmBttF3CsPb1megHYFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=azPx8GvWE/R1bSlaE9hSnB8ZfjqUWxCO8NC+W7/IEMENkRNYE/+g+zn7sV7lJcdUyQLzEUJKlHXccBFZYibCB3JRofSR1eK2KVM4sya+lo6DJXIkABG0emRzf6foqi8PSvLKFZSbNG3SAt6WO5s92KapWKaj6tYVkWghD6wNppo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CwwzIODf; arc=fail smtp.client-ip=40.107.162.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CwwzIODf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLcrj+LhL3DC6hV3mTSB5VK43PfBEM8V9lxlFphR9HZCFwOgmA2BDRDQkLN/ZW92TcH5QYcv0xORfywc6NJ/3KM8yJ413I7bpBTiiRq9tAId8GHAY3HUAaj6AH8L+BYl8eIchXAVG6LA/f/whqhuvl9BxWyHsAiJo/2G+PtEq3xbFzVSpQZmhrHO90lIqyNy54mUZR7uJYDmyVJ2ZGyWomxvrYIWcFTejbXqB2vCsWLD8RF4B0vAk3+Ws8cQsHgPfLE9fNdDRb1urKEO/KgB5gapXmbA+ebHZ/6N/GHMAX7L1TQppOdUsROYiD4PuH2Yd3GyJyEy8GCkYe/fOAJ4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nPNbgVCHHFzEt3Obn/IAjKZNyH2txtg8XjRPtBg+bY=;
 b=UG1qQk6Fs8y0mkqTIQTRaD6HFIAwb7C6Mlg/Wm+FLRYlUbgRxrLlZX5+SuA+vcGOvafrkVb2VnmKAQV9e8yXmgDVbDkmahCGkhIpadCs3O3fmpxztP5S4L+Yb0p/DRaLOKRZJ/+o3n9mtb6SNvkIInpJXAu1vv/6PCQ7eNYBSwCHtQ5OhVoB14C84PJ5aqQXlCfrPKJf7C35HrwDBTJbAHFkml9x/SHr9vJqIwdOO/1F+4nshCb29U1SEFe0s/CcmfDX4LeTza3aWKn8iahVGNHFJWzwWtaTuIzs6arpCGZEM2Z6noTwrrMt1wz6+qZaJveCA42C+SFpxeURZ4iy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nPNbgVCHHFzEt3Obn/IAjKZNyH2txtg8XjRPtBg+bY=;
 b=CwwzIODfxMd1rlnD6I7M+RR8fWYlcYLa7DlsG5TrllV5lVE/vEz8pOcyKrBgk2zce5J1o2F+v60oW79/2nmHjJXlTVDdYTVq2q6YDiBF23cHJQq+MN47+Ggll1Y7zu3pPgDnkDu/Qdbk7ZvLtkKyzlO0ZbZvNuR4HEWCfKECw4ebl+GnbzGwptKMnhoEq7FFJS21HGrwUTgmmoroN4nmBkEdz4KuwE4ge/1HDww1E5y2mzJG9XUYw2l00XzATP3gmrWfCvf5SXao9Ht5oM29zEDXpVC2O+CHR5xPp4w6kf4C5tQF17sCIDWyVODYaPSDL/pV7EesldnITf7VZBU2tA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB12136.eurprd04.prod.outlook.com (2603:10a6:800:317::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 18:57:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 18:57:21 +0000
Date: Wed, 30 Sep 2026 13:57:10 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marek Vasut <marex@nabladev.com>, linux-arm-kernel@lists.infradead.org,
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
Message-ID: <ar1bhpji35CbArtY@SMW015318>
References: <20260928204741.175754-1-marex@nabladev.com>
 <20260928204741.175754-3-marex@nabladev.com>
 <arvPDq8sjjv7na01@SMW015318>
 <49303872-5622-4e1d-8e1a-01394ec29367@nabladev.com>
 <20260930174413.GA2463938@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930174413.GA2463938@francesco-nb>
X-ClientProxiedBy: PH8P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB12136:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a6a801-5e24-45fc-5034-08df1f24a80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cuDynlvF6/jGkAoZoyIOUAvcPMahbNkeSlpwqOOHVYd93aGtp5za1JjLTDLRQN3rYhj/bSYM31CeVjqVVIccIpaqV+khE0/2qVX+5x+UHhOdkxc8OhRx/I+hJp32IhYNkIHxLY3lHjykWLqnXmw2dGsIVj0EJpa+JDKfotqSH2H4e2t+MnF2UqFNLAB7a6aEvJipWhfTPZ9/aBxMKec2ZfaFkdL9ehJQi4OQogEEbwQL/9wOm6ksNoNt5ivzsUHIDH9tRwfPsdKOQ7MBmz64+OV52RZ7rUfT6dHLk7JM9p0ST5n0CjfCCkQPJs/ZWSLI2WpZZMQGxo5lh1A7rn4H0EjxNNPqQVPxcQpTqkzlRpTjb5TFB/EKSU+sCryVNMJVbpd/qBeeia17xR5V25H8zkQAZH2CQMWL69CctskZF093dOuCY98+Q055HvfOUwzenToKnlQvCTTdqBb03pApNAzXF/GJs8UGSb79JlOF6INxXzHCU94u1l+3j2TVgGTyoNfeNHPzlk3QztTZOTOtljwdwMDWfksvvWbTbaFInoIduEr2McMellF7CISdFQZoUBLIiMFaIn3l6l9TDihWM2/Bj/R/Rq040G6worD6XIJ+d9LwodM4boA+qUQvmRAe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZaU5mjS7Gjvyz/KFHHUDPE18AtVm6MkV3Q++SqO01acEBJrwB9AuBBAPFXEx?=
 =?us-ascii?Q?h7lPVoQFvpY39wW+I/JYi26zUzNDpowtbYbwCkqgWqSrLduaFfpa5+pad1ov?=
 =?us-ascii?Q?VDjV9iuR4FjL77uaF7TSqyqbC6APbhOzTG1l9/RzCuqrsZIxe6xKr87dmOgf?=
 =?us-ascii?Q?104wGM7P7X7TwrK/fOELoU4kCVmjFEwwhc9Af+WPKl4zVpmEJbtBm255iw+Z?=
 =?us-ascii?Q?XA0lcuPPa+PgCdvtkKtf1ooRhAugYBA6i34w+sOkOZBg2iYmkOtDFK7r/yBI?=
 =?us-ascii?Q?jI7fIz2Bn9RzeUiFrHH83c17xMFn+kAYn+j78jIw9iEbnuGM4xw9hlC4U9N0?=
 =?us-ascii?Q?o1acIBiT5TTbsT74E/otTXSsvmrNcsGeTf9dOGSyani9kywp7PBUOkelbFcj?=
 =?us-ascii?Q?S3B4q8CNsevFROZNkxrSkdOvUzMzRJGqIlJdWNk6UxdF2fsUa9Hi0uTlOrY2?=
 =?us-ascii?Q?I5h0uhRza/Rku88rsls7KCGdMrTSuFw8edpx7Kga9gSQvFSW8hUt5R9MhpY2?=
 =?us-ascii?Q?JHFUVWd/yA2Ktco5T2PfIjQpPLtfy+z8NwMnOMXamcAOalCHn4o7p5Pna9JY?=
 =?us-ascii?Q?+kpa/G0g78wuMyrzBISim+e5/2A4gfnIuwlU5JqPbkPqSFaYbe9LhaSvpFcD?=
 =?us-ascii?Q?ICv9TyytallGV8SG4kDXtiPHLB6fhiO963QoYgbZ3mJtIApzTfmAur5egVsm?=
 =?us-ascii?Q?VRaIAZ8kPMIt2keU9MrRiZXOe/wlrp04gHUVal9WWhUT5VkPHkyA8dOUiG6m?=
 =?us-ascii?Q?NDDAbRqcFb4tcT5MUztn//YylMstqTAYN2C+5otAUTd501hPARRlAOFNJA3d?=
 =?us-ascii?Q?5VR0mrTc2Zqk3894pp1gnRj1N3TNBaTkLHkX8mNmqgXnM8oFnPnB3vE9EoVL?=
 =?us-ascii?Q?pb4OhJzzx9oWIE4zCkOHFlxXDvuWVESHKMn86osaAWxVMqAJof7h5hQ5oBkF?=
 =?us-ascii?Q?F7LL+jFwRk9nNqGIAj45xDbz2W8d5hsxfg8zs/2ZsN7AGFNgdn0G+z0UpfNl?=
 =?us-ascii?Q?cUIseGkG/rgZ/obCHAjhvBhrFGLX27QoOx4iTnx08L4oeFoFcwMCyqvRIJiS?=
 =?us-ascii?Q?sAXD2G+PwpEqqOY7DEcF4i+F4RKkkqIbeHtw6Dt9QzDAkpPbZaaDBIq0JmJ+?=
 =?us-ascii?Q?tD1HPsuyAPGgZdN6RL/6yelcLCbDgMIP9IEtV1L75aSwDpYvAColPeM7J9Ib?=
 =?us-ascii?Q?+07TrsTdKKbLHccyHU9vZ6diCXl3UkQ4D1s9Fs4w1y78nx3uKdYlt4bWk5z/?=
 =?us-ascii?Q?2Sj/yhzQxz46eGiWRTDbxITUqvdstY7ykiADoGY0afT5BWk7B1J2tIiz2INu?=
 =?us-ascii?Q?o09kQ0mgjn85luS8BhVdXVlT1zkn/Ev8pE1m+dhi7bj+ZXLC69aKSKDYA2+/?=
 =?us-ascii?Q?5YhvnaCvSwjlW9yCq5qUWzOc2VJzk3+1tiWXRiPm8ORs421rCDhuyhZvAe6N?=
 =?us-ascii?Q?BRcaIKO9B11a5chhBe0oVowjBeYMc2VpSeztOfuPAuV/UDtsHvSS0dAONQ/7?=
 =?us-ascii?Q?AYDGU63I8CYnI6rUCllZ4ZYzjbUuHGHkfQmnq1baUTMQYtCWmgBQiSKybobN?=
 =?us-ascii?Q?+bLMRdqrUgz/IuBzOMj2JoQ75h6yYC8otFtk560A5Wyr1PDSZhf1Zc3BgFhO?=
 =?us-ascii?Q?OxHn9tOKyuv7efgGwcRqINjlj84viCrpgLF/8wpRph99/OC0CZRfJ0AY3sKW?=
 =?us-ascii?Q?xXB14zIwQMulIh+wI14cMIBbGmGeFNzecynxTBL3QU73Frinsz+RDWNUz0pK?=
 =?us-ascii?Q?jaBpXbtWdvAl+/pwrBTx2M1DrKklJb7/VB5RI3VHrrGI48sR+AxW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a6a801-5e24-45fc-5034-08df1f24a80f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 18:57:21.1921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdE2OVG+UTswpubF7L5CYugbt+HYAgiWqO2LmMN5Bc5tvx5ChJgtT03YNvWDPO/8fkw8xongPBx8ZHez26VRY9vOIUq6PubgRXjlmHtCQvjqhWRqjMYzSNzpN/e0buIt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12136

On Wed, Sep 30, 2026 at 07:44:13PM +0200, Francesco Dolcini wrote:
> On Tue, Sep 29, 2026 at 05:20:27PM +0200, Marek Vasut wrote:
> > On 9/29/26 4:45 PM, Frank Li wrote:
> >
> > Hello Frank,
> >
> > > > +	backlight_lvds: backlight-lvds {
> > > > +		compatible = "pwm-backlight";
> > > > +		pinctrl-names = "default";
> > > > +		pinctrl-0 = <&pinctrl_panel_backlight_lvds>;
> > > > +		brightness-levels = <0 1 10 20 30 40 50 60 70 75 80 90 100>;
> > > > +		default-brightness-level = <7>;
> > > > +		enable-gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>;
> > > > +		pwms = <&tpm3 3 5000000 0>;
> > > > +		/* Disabled by default, unless display board plugged in. */
> > > > +		status = "disabled";
> > > > +	};
> > >
> > > The both backlight is not used in this dts, can you remove it and
> > > add these when it real use.
> > It's the same thing we do on the other boards, so I would prefer to keep
> > this consistent:
>
> I agree with Marek, and I would not use the criteria about being used or
> not.


Others boards: some has dtso, which use it. And krzy have some concern for
similar case although he have not reply alex's answer.

https://lore.kernel.org/imx/30599533-91de-41fd-9420-3f8693ec92ac@kernel.org/

And it is most likely go through nexus connector node to support display
panel in future.

So I suggest remove it now and add it when need.

Frank

>
> Francesco
>
