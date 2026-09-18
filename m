Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642382EBBB7;
	Fri, 18 Sep 2026 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739945; cv=fail; b=DwFnuOA3kNhxgGZ35iVyMuU5gi4V6tOkuqDitjlTpkCzH34A1MEo8m5tCqMKOxll6RXTsia83lQROBnDyj4xZ41mclOjxd8JJ8nlZ2ZZohaktFKX2kMySaMGXEYoKXKoKA7jEano69+m39kjJl9vIptq8o023kPnn2HmN7KNs64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739945; c=relaxed/simple;
	bh=XqJy5tVbNtoQ0DQ9OYldf6J773Tlgy0mgDo/Jgi2+1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=md6nfHMOXlp5SlTk1A2B3VvKRQnDzo1jEGqi0Wjw5rn3cRMpCD4Y+SS/XLTzwzkBJbji++pNNc1MN/I2Qh5WVY2OdpoVFwkDhjhyCDqnlUs4onN3LKhJWpr7x0pee4THxeFCbrrZ5gSPt0isfMtEA+WrOghadAqJ2k4VEIECAYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=caBeZvZy; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="caBeZvZy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULchnNKB4pN+wLLECn3rkWql5wcNErBSC6qOPgjhXm9JMYQbBtcLoT8Ivaia1aaZxMfy6FSsjm8J2kChhvb0OfthYg7xtaS3SBIQl5M0feaSsiWIws9RGbTbeUCeZD53ru8TvRNrc1Rpm9YdIhY1/1klUr7uqZXgCu8LuTFNhPYB4WFu6tBLI6SLhkFh30OsOkDS4RCRcsZxiMQxBGu+FpkPvo1fsG/N38SMOXiUVVqzeSG/mTTcioBZ8vmbJdxXj4/jbqusIwgDESR46pGqI0uWv75BbR4OXE0fS9EjfexvQhMwX97gDkJH6mS1/AGEABjd3dusm874HPreuP5l4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJ67Jm8crkf4hpNhmWwFfXlDjQcIiZi9/IMI5041Vyk=;
 b=s7xovHNpb5ItxRl6/xqEjmzplB73c/ailI8CK85NHPw+XX44p0VaZzZ42X1+h6msLN/davYdnngTG4G5OCm++pqjGKGTJXN3H8hUGP5N7aol7odclXUnMoIU7+mT9wE1LgEQe0JPjmLSgCLDzxJjtontE+L959pi2oyeAnJ56Xrp/XwwbBIDTskXCGuVJAOaef9KifDd+U23bYGqZVpASwDyCTC2Rc00ao+YE/7ic+n5gRi7KKk76BVZvA2q4eYT85xE9i4kjMVhR/mvEfNP7ybALrhYQUdOEClit4te5wnDSlwA+YHtTvru5NRU4DyQ8u6yw4ob9DVDzNnA3wgHBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJ67Jm8crkf4hpNhmWwFfXlDjQcIiZi9/IMI5041Vyk=;
 b=caBeZvZyaXmvehrq3ma1kTyGAn9NkEGvbSoEDpiSI4wtatPh/xMXeGL5u3LfRuF6flA4YATdX/3FvGO5U6pt+MxbALgaYWZLQLb1enoVWOC+9Ug8AhzW92DZERDFGc0oMAtp+GydhZR+qI/hstCzdHh2LD4Ky2znXR5VBLsrW7gqdLQgKTyd/dTwhvGGJuYLW1lshMv65kh3Nb8bRd2sefk2V58HmmlaE9rWSGKrZi89ws4ELsIZLDDABGF0fVArKDDNl/SONLz5KL/e9fsBKfqylo60AbBfdepwEU2wl06m/vChsWLPmAG+xOtIsTJNzV1EADAaB0MoAn+/YhiTqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8621.eurprd04.prod.outlook.com (2603:10a6:102:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Fri, 18 Sep
 2026 13:59:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 13:59:00 +0000
Date: Fri, 18 Sep 2026 08:58:52 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, robh@kernel.org,
	Frank.Li@kernel.org, imx@lists.linux.dev, conor+dt@kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Message-ID: <aq1DnBkxgF49QLwa@SMW015318>
References: <20260917062543.534416-1-marex@nabladev.com>
 <20260917062543.534416-3-marex@nabladev.com>
 <20260917063512.C71F51F000FF@smtp.kernel.org>
 <aqwbBQUSfd60nVeI@SMW015318>
 <384c5f71-d5ab-4990-9567-027605457439@nabladev.com>
 <aqw1agBrSjYoy71_@SMW015318>
 <c1197d8e-add5-48b7-b0ba-a5a91379ab04@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1197d8e-add5-48b7-b0ba-a5a91379ab04@nabladev.com>
X-ClientProxiedBy: CYXPR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:930:d2::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: 34476b82-bfc3-47e7-d400-08df158cfda8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|19092799006|376014|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3NwPy7fERZDjrNzLnY2N64rQHGR1kxBNqyE/xWojeOPatpHhH6ahJd4SMcyYHPX3tMrqjK2Cd/s0Ao8Ogk6oJD+Zk5F9sDhDdDUhE+6J+J3BklH0DhK/t/bVMBJxjE9Lph4MdDXcA0ti9n6RhYp23SH9G5y8JbgvPd2zplQQj/Uc0tPC1yIOmUVArFw+fapboPoD/0ZSpv5Vh6m76HtxT1wta51ulM1O3BWoX1wDbiOmt8oyFfhRI9/tgQHpHQWgzMLwlG7zHPTJ1cGRtCasF9Dkxrj0ARwO+qxdFzz22HOm9gD/iXQVrClq/P3kDe2LunUqHQgzVKTeB6yBCgbzSTdquVTlLALr3GW4QgyoVo0YAjaV/TqYq2KAPc8VTveDtuFg8+tnSdaLzSVEvXxc7Br2CCRtR6e3s8ESFmxBzN760RX5m5VejebKaqQrJ7B7a9rrdAfHfFTzbI6GEIZcPUR7N77FfsZ6kU8IhjmqABKhMBMWT+oCjtQ9ZUPDm1c9pbJvgzdyRyLO61H9MfO/luSm5VFtgz7NkOJJjPwn7eiW/DH/Bzmr+FxarR/9+9PtNzsev7ERdkew6AhabixRC72wuNTrrG3pjmXmF09H3SVYxocpuojF4+q01u7/n1x0oSFFkreBqhtoysYfcygNvOodnLQZ7m1WmAPFTLQ4mHQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(19092799006)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fDu3NwgDQl2l/888FdsJ9a6hmQzaSne1A5O0l0iUkmJzm4laCtw3z0Np54g7?=
 =?us-ascii?Q?IhhXt/uYX9BC9H/6VAag+HgMrMrqcSLrDcCyfokvAYdOP2CNk86G0xxEV1zK?=
 =?us-ascii?Q?T1/i9u6uEQtPKDHPs2sJkjqDq7JHRTHAV374rsfk2m8ssXarmXL24fU+8qxS?=
 =?us-ascii?Q?JDlfnsFRADB3P6N4yvFulIgu6cViFtKxW+P7bYRgPq22602HPHKaXuQLUxVa?=
 =?us-ascii?Q?hcCRNeNCPFTtLZSdd/NJKFkzySLJ9hWIHPOFNVKMjmZTdxpUT6Mm+X48Bcxk?=
 =?us-ascii?Q?frw71166Pkyoq/ReWVP4vUiu06e6GFRm4OgXtWfyyDG+zwWK5qWlSJsgl9Mb?=
 =?us-ascii?Q?FmJDprxaq/KPzWA54eDi2O7OF4akE0lZHi2PsfxaMjnDLkXh4qlAQPuPX1qo?=
 =?us-ascii?Q?wiW+9bSKTqKPJNzvGkQtnPxstYz488kEMtUgX0Av3/PgVZbEVFFYWaiPz/bk?=
 =?us-ascii?Q?XHOV871AoD174CcrZO5tyEmqWmyGIAmlBe9BUzNWCIbweo+1fu/DW2tlDyBm?=
 =?us-ascii?Q?zwxbIf/6BxS5CfCIhvivcwhDdZVFB8gxmqyXR7ozhfBr4NLERXVP0tVHH0nO?=
 =?us-ascii?Q?w9ylgqwWsH2a6hXYHUhbUjWpJJkNcRnLt9lWQ6V4hr5D+n2w1yygvUjDm9b6?=
 =?us-ascii?Q?QDeaMcLJb2tR156KLeLXHEk+JEZiMRWJymBWdBuZAitGLeaIBAMfCUSSsLsK?=
 =?us-ascii?Q?slQzT9oQD43HVa9fYvU1JONs2hqYV128r7usWdkrZlqj2cmR1JsPXlX8CGqJ?=
 =?us-ascii?Q?PYt1JNPAFDVe+laO803zGUP5LstFm1K8U5/DO26J/I3g8jbrUT3vSvZotJmf?=
 =?us-ascii?Q?ABTsBtTP8+l6GmWrvL9rt6Y3GYHnA2wk/e6desgb+CsZVTKANA15uIiYK3/+?=
 =?us-ascii?Q?Nc2lgEwmbVNX9G5YUBig2bOR1eOsPr3n8GZgPCPgYd6N7y5xuWnNkQNd5ICk?=
 =?us-ascii?Q?s9C+DaWtpu0UDqieHRmjwi+oK+BGXwT6clJVq/D24nVmfVosU064+K7VqoNt?=
 =?us-ascii?Q?GePnO3VwVcX6ZFjC888DB3s7eekemP0/+i8jBvKRYcqe5i7lxD29xeEBjHNj?=
 =?us-ascii?Q?4zafz0+QjO23WB0uE2/XnQjFxXBA3TbL/f+DLh8fmQeL3relq0eliJ/oNnlW?=
 =?us-ascii?Q?Dfmrw41aFgmdKgYt3vDnb01lyTSrrGS8/9IUKG6S7QGeaGuxYuGO+8j2M10j?=
 =?us-ascii?Q?vec3EHY5/X8vorxDPN6MXvSYgQ/Jr8PX7lmjSCgXI5Xpe7zenHfcecrDeOh6?=
 =?us-ascii?Q?bBMtjXBenSUV7ABzXaNkkm9WvcX7GpmvU6ktmlx8tWIpNuIsarijabywqZll?=
 =?us-ascii?Q?tMYd431OQxHlWRSl2uGM7S5j9iqUVPVLsyfDnigCC8unRoaXbtO3Zv3J3Vln?=
 =?us-ascii?Q?XHKbpl86GtPeWLwMmaA9YVKJrzsWiKcgfbtD5/Ht7omWE3jqgAL3/1rWttyf?=
 =?us-ascii?Q?Ege2N0z6BdYWBmZMdoE49yavyIwDpK3n9i3Gg6RWoJBWr21VjLgv2jHU2+WL?=
 =?us-ascii?Q?eVk1sBJdDRGRM6UfZmNwqo5mVofFlINZlcdK5KwGWUm0uCs6ZUoN1SDlhCFU?=
 =?us-ascii?Q?P4h+o6njfFI4WLUHwxyuc0KWZE46N45RgqYzE409Bu0mkWlc1mrR2AZC2j3o?=
 =?us-ascii?Q?ztP1x7qbKbTwfRgTw3Z4psWG8wlfIlxVOSahj+rbTQR6Ihw96XFOcAKlYsKR?=
 =?us-ascii?Q?xyMNs4v5W3OPddKUSGJFi8yTqpJbJ6aDNakif3x4WKIqGnk2RBlI3XyWQAjb?=
 =?us-ascii?Q?0NknYPNHFn3+lRi9P/V5YIqrZd0LtE9RQoPP5Y4jeMit4C+u4rF2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34476b82-bfc3-47e7-d400-08df158cfda8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:59:00.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91PqK+Rc2hbxr1yZ6vGtR2bYt0dL8TLtx9fbx/nC8//ci1Y12UB4xKUvajYyKouJy+vz8pYwl1oojCcgfobubko7p3DCVa8nN6C00phOT0/n9ivq+qSOSFa+2hQOrC/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8621

On Thu, Sep 17, 2026 at 08:55:56PM +0200, Marek Vasut wrote:
> On 9/17/26 8:46 PM, Frank Li wrote:
>
> Hello Frank,
>
> [...]
>
> > > > > > +	reg_panel_vcc: regulator-panel-vcc {
> > > > > > +		compatible = "regulator-fixed";
> > > > > > +		regulator-min-microvolt = <3300000>;
> > > > > > +		regulator-max-microvolt = <3300000>;
> > > > > > +		regulator-name = "PANEL_VCC";
> > > > > > +		gpios = <&i2c2_gpio_expander_20 17 0>;
> > > >
> > > > gpio third arg 0, means GPIO_ACTIVE_HIGH
> > > >
> > > > 	so need enable-active-high
> > > >
> > > > if your boards have invertor should use GPIO_ACTIVE_LOW
> > >
> > > I already went through all that, please see "Re: [PATCH 3/3] arm64: dts:
> > > imx95: Add support for Data Modul i.MX95 eDM SBC" .
> >
> > at https://lore.kernel.org/imx/f4dbeaac-ab10-4980-9fc5-533907be223c@nabladev.com/
> >
> > <&i2c2_gpio_expander_20 17 0>;
> >                             ^
> >
> > 0 should use predefine MACRO, after I check 0 means GPIO_ACTIVE_HIGH.
> >
> > so need enable-active-high for regulator.
>
> This is extended via a DTO, so no, I must not use a macro because I do not
> know the polarity of this signal, that is why there is 0 here.
>
> The enable-active-high DT property must explicitly NOT be here, because the
> DTO can not remove properties from the base DT. Adding enable-active-high
> here would make the DTO unable to operate this signal as active-low .


But why DTO need update regulator-panel-vcc's gpio informaiton. I suppose
it is fixed when board design.

Does this regulator place at additional boards?

Frank

>
> > > > > > +	tas2552: audio-codec@40 {
> > > > > > +		compatible = "ti,tas2552";
> > > > > > +		reg = <0x40>;
> > > > > > +		#sound-dai-cells = <0>;
> > > > > > +		avdd-supply = <&reg_1p8v>;
> > > > > > +		iovdd-supply = <&reg_3p3v>;
> > > > > > +		vbat-supply = <&reg_5p0v>;
> > > > > > +		enable-gpio = <&i2c2_gpio_expander_20 23 GPIO_ACTIVE_HIGH>;
> > > > >
> > > > > [Severity: Low]
> > > > > This isn't a bug, but should tas2552 be using the enable-gpios property name
> > > > > instead of the deprecated enable-gpio? The patch changelog mentions replacing
> > > > > gpio with gpios DT properties.
> > > >
> > > > Please fix this one.
> > >
> > > No, this is correct, see
> > >
> > > Documentation/devicetree/bindings/sound/ti,tas2552.yaml:  enable-gpio:
> >
> > It is fine now, I suggest update bindings to allow both. which convert
> > by Rob at Jan 2026. I think Rob may miss it.
> >
> > kernel hack code covert -gpio to -gpios
> I'll add that into my todo, but that is a separate fix from this DT.
