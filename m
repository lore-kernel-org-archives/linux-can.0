Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606553CA48E;
	Thu, 17 Sep 2026 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670777; cv=fail; b=NcmdIcSAn+wvSO7geXFxQ1eJOYwKRjRCqmEh/Y5AO/ZX7Di1uxWAMA5bJe9/HBSjrLN7CprUx16Vo+EvoJO3hN9qFrOKSjpGJHEvrIUoCoZHb41w/4a3Nc4QMYf8gYS81doOLlASsx7+mnp6WgKLR35bXZ/YyOtfUCJsp3gyJJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670777; c=relaxed/simple;
	bh=svEDumizkDqTHFlH610vmGd4P18lcJ28orGUxIemNBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PiVOhSgz7/8WPyrsk6eB8Re7M3vDd0ezvu3BvtB43yZxL73m8id0SlnuV6y4pRGUD85R92W25IIes+WjKE7+BwIymoR+Mp1SfcNnHTy21dQ/wLJRobpDre7w5xImp40GttkoTTWTYOqOhHZ0N46xPtJSrszxJO17suePoOJIuc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qYA5qFbG; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qYA5qFbG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tg3SJgbiJ7njYXpNgDKdIejJT4caLXPOojyYMhQFQSGMSM/VXzmQcNogJf/ztNptNucQuUd0gRNKzniw/XqH3GH0bEhHVzcG6srHLErRjrkx9wjoUXywJe8PdNQLcRN0Uoiub9NW7TSZSh3Awl8pwlLz5y4dri/NKscHSIzMPqbXivaEcteL7gHY+ju9+G/JGVQkMgKqZtITkd9Pf3ZPih1fN19cOmyD4fkgU7s5kilxci5IyMQ6HwcviaotJN49cp1reUZzHVoIow0yqWcVVepl6HcgSmRGYpvkEywFVbENWNzaB4t0S4js0xX6HLoXZjLfkQxsM1iLIxELBWLWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RTAdNTUg17mqYWJ4yqtVCWb8SpTRn+P8aZiWfEOjZw=;
 b=U/sDnfj1nwU+1eGuheCh16bPYvEX9S8Z4KEDlSdJ7irfjmcP5Wjh37MlGKq0hrjueVhwcrKgw08OKzX7qUu8JUir1GGBpALymfbKffP+gQPx2fye2Kk5ia86l2DPCLrXb6h7ASKQtjIra+koY86qfYigxUyohtHxQXYPLX78w4oML/4liDfDZ1lQpuFgH+MHAQ/I9+rTJAAeLi5zre+AxDkEwNdIOfbEHyX1UidQIcjAmCQzyp0bxmvseCVbMxy1mp4+v16EBVxJaIxpA0ZnTWBQzHjISpep2cisO/jI6nMbSMEGaHgl2awKb+yYX1awHAooHnszGcRmr218DKtf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RTAdNTUg17mqYWJ4yqtVCWb8SpTRn+P8aZiWfEOjZw=;
 b=qYA5qFbGaCyLD09beESiuZ9l3Ty8oMHn2oFSKiaIUhAFtPPBX8gIo1qYJcUz3ycy4BbXfipbFW+hpM+ChiO0nQK5VB3hBVrlmuvonZH0AUMiJyDHBuAGuaBvJ7LapsZeFNaWgRTZdPHYenUqYAiGTW5I62x7QgNOIdJJCVY/0ZTxwaNsLycJ8k98FouHB87x+o6+IvoM5sLLaJTfNXXsMGzEIH+Io7T69NhMvsV+LXVVQ7u5TXW0WyZXRRGUGAd8tyfezD8ERZ5ijxbDojU3C8AX8kJgvVDn6n/nQQM1svxHQLqNwYehBczvFcXcrH2JegyFOKUeJZVZYFlxqv3rCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 17 Sep
 2026 18:46:11 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Thu, 17 Sep 2026
 18:46:11 +0000
Date: Thu, 17 Sep 2026 13:46:02 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, robh@kernel.org,
	Frank.Li@kernel.org, imx@lists.linux.dev, conor+dt@kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Message-ID: <aqw1agBrSjYoy71_@SMW015318>
References: <20260917062543.534416-1-marex@nabladev.com>
 <20260917062543.534416-3-marex@nabladev.com>
 <20260917063512.C71F51F000FF@smtp.kernel.org>
 <aqwbBQUSfd60nVeI@SMW015318>
 <384c5f71-d5ab-4990-9567-027605457439@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <384c5f71-d5ab-4990-9567-027605457439@nabladev.com>
X-ClientProxiedBy: PH1PEPF000132FA.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::2b) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS1PR04MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a43f7d5-21e5-40e0-5934-08df14ebf163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|19092799006|11063799006|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sW+JMHlyaDVirZp9Vz4WRjiHljxaiys6aOqR5tHgrb3ijv6lOCJ9klN4DFaBsR3ml7ShDsvBe6YnMWk4mINTbSxgGGE93zRShGiUXIqRzIAqqJLzKg3qwcnFE8bYhi6FMNay6KGw+zU2kJSfP5WmiqUDt1Zr6croUe67emmZeGfK0+hVoZavvPgyQn5wi1b/+6xVmr90S+BN21NWIsp/Dga4R0EWrjSCruOKWIIjgru0XAteQsnDBIdRNExLIo2T7rV3R3JD/LSrxM+fA2PW+Rc3MWne8+437vR4742ut4brpOTkMjdMoJ5cxXGlJmfrPZ3jS/66RlVS7r6Sq1uMJIt93v8mt8KF+LG8zWF/foX5kmf2lwu8HLdYOUmM3UOai6Lnvs/bS9D/SZSwWMfWLNx0Xc+ZoaiBd/cyG7sDzYohFmFmyrjhabk7hpgI3Zt54TgAfkS7LEVyJE92F5LRBKI87O3/zdJPq+K5S4ttb8oQvQLd2WbIZUjRzRDkm1s4ExNpvo0QJwVfuttsZHYK/6FhgJ0tTW/MwLgcZ2CgBWX/a9JRIiWbNy5XOAfryE+gI/XP4bt1DLXKKmqjK4r7UKvrbpW/cy/FJ3ga8FrX25IwgSzDXuDfYHXPTNF0u1JXQGRG4DVaCTI+K7CyE2tzsSHnESVwvaEkm4VZQofv4qg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(19092799006)(11063799006)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d5mjKyAS5hefk5mIL6OagA278/zVPatCi2UlX051EXvJB9rVWta+NtROxJVY?=
 =?us-ascii?Q?OtZmC62KrOZXMDREY/a2aKQFLxbU/M4UFEG0xfdcUFoDpkN5jNKdPJVY1cAX?=
 =?us-ascii?Q?5/sTrTu0MsQqpWEd7EU3nbQGfCBzorK67p2uSUfXb4OR3JKd8KIHKxiUrvlQ?=
 =?us-ascii?Q?7BU10qLI2p3pZdPnZ9LZdR+GxXP8ZIeFu2IL8H9NU8TD4/d/7b4Cs2FaElkO?=
 =?us-ascii?Q?n05ZQ2uvUI++D1cLOD75Qx3WsOvDPKxSlAd35JuZunJB7vcHhe/+nzUxUwyw?=
 =?us-ascii?Q?wXZiOLrBxqnwiA8nLNiIS32vZ8Q1LX5szML1zcAnr/bGwK1SYGbRXkjXqrBa?=
 =?us-ascii?Q?XiQ0aR1hIHy/uKXE76DuBilAzx/rFmzNSLOzKR6aVkIgkjXcWc4/f2S5aMke?=
 =?us-ascii?Q?bmUXI7E6lFnqKOhqlLebEGlzTxlXtw+Hfz8fr6Gslwg6Lpw/hlCtc67MPt2P?=
 =?us-ascii?Q?9f1kEzxbu7fdt5Q3Rv0vzFCK5ES8AGDEd+WJbV+f6/rpMQAqj+2vQ8fuH70c?=
 =?us-ascii?Q?SZpFbq1Tnd3jx/b78U6dtG2IEX5DtuazPEo6cL9ViuhVb9Nb6DVtGDP6aE+w?=
 =?us-ascii?Q?XZ4ORkmp7yRZ+IvGnct/73rUBm3ctKZEayoUZ+hdHvD8Bb7V2Iju3aEKaRRn?=
 =?us-ascii?Q?a9P+KatQL1AVvpZBGMOZewxv1nMJkYh8Xbyde0GqXm7wCyGx4EHKAHCe+/Ea?=
 =?us-ascii?Q?Z2EeCsSmW/EpJ252ZdIAb5cJttej4aV019zKnKkKXHvrppzeOS4ZUZVvS20g?=
 =?us-ascii?Q?l5kxLVZDHuTztwlk2ZKiHaCsa7ma//eQtUsMfGrvAk7jMIGjOe/YZhXi2fYf?=
 =?us-ascii?Q?IQPozPB18iqjUp8ArKPFQIAsDIVS1MDTt55hputrrmwM7XFhca5cuYkah43e?=
 =?us-ascii?Q?DZTz+T2Zbrh7PuXL1o04kZf2XedujrasvWmbwFc3TnLbRuwIGR4nf9xjoaVx?=
 =?us-ascii?Q?hGGW+9WFnvlVoEv3lahwqvJ0NfIDKHS3Kude3f0t/CxsFnQnCTIsA0J49laz?=
 =?us-ascii?Q?KX6lBjq7BNS8WUkVO3M6+eZ4bL+9AZ4KkUltKJR4twk+Oj3/pLzdD4zz8Ar8?=
 =?us-ascii?Q?02Zojj21OeWkoFp9lS8JhO0ND9sxO3UQabng4dnzZUtXXtWXn1KxtWuoa3W1?=
 =?us-ascii?Q?tTfPgf4FENCSUjJ9s2u9+cIaWwktT/s9Q5yABtnd0jldWML2+F+smWZVrX3t?=
 =?us-ascii?Q?y7YBk47g1GMMCtNgC6hxjGrPVYfeMnMZwswLkcLw3MEtbHg3OdejayMWqvhV?=
 =?us-ascii?Q?dutYbj/Rulp+R7jk1YhiQMNHHdK6oiJ3yRSVWqGuOe5ZdoFBZQz51wJ4pQ0y?=
 =?us-ascii?Q?Cn1Z7m1CYEYMcBHSP5AOJqczWMM9y+hfsMaUzK+pnc6ocjY1kh53yueB37ii?=
 =?us-ascii?Q?XJwcifnUNAiJLjI3a6VK/yR3AxNa/N9HiGCw6TfovyUSSr/ibV82t4/KG7X8?=
 =?us-ascii?Q?H+6+GFL3g66YKRBaIYVNp4jdNYvPOk5ktfvLHG4AScE5AB2lE4flKqoiU6ke?=
 =?us-ascii?Q?dvWENSvjuBl98PrLIbgvvK2svGqF83lXhrdGoXFvThAOTdyJFTsQNCSZgcmQ?=
 =?us-ascii?Q?E+wGo4l0dvpTho/UQTeNDuPaiIyDCvC2AAeEM9LIsiXGunet9iQQGf5F3jCX?=
 =?us-ascii?Q?NY3PqD1yX/mnwvKlL217cj8m4o9p7QtemI4iI+uTZq+B/3hhbsa77WeJYCgz?=
 =?us-ascii?Q?7eHGzircqO4DMk/+Td1iPUzHTz8OwSakgoKeNPR99BimKT9PlRhIbkOAM9zK?=
 =?us-ascii?Q?pyvk8JWbq5o1cxTXa81kdQaknKW4ac3PSIDpgMAyawE5Iuynkw/b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a43f7d5-21e5-40e0-5934-08df14ebf163
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:46:11.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvdzZ3WYjlb5rgOL4YtXlwaXvoUTpxyE34TbsSGe3WLE8tdfdFTOIU+/U8Pumkd7/ePtJasE4QGdbJUFk5296K0f5oJYv6YqxFyE1HY9oT1dp0xIFGIe0sqZx0MaFgwW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479

On Thu, Sep 17, 2026 at 07:19:51PM +0200, Marek Vasut wrote:
> On 9/17/26 6:53 PM, Frank Li wrote:
>
> Hello Frank,
>
> > On Thu, Sep 17, 2026 at 06:35:12AM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> > > - [High] dts: pcal6524 interrupt polarity is incorrectly set to LEVEL_HIGH
> > > - [Medium] dts: Ethernet PHY reset-gpios configured with wrong polarity
> > > - [Medium] dts: eMMC reset GPIO defined but unused in usdhc1
> > > - [Medium] dts: reg_panel_vcc regulator missing enable-active-high property
> > > - [Medium] dts: M.2 Key-E (usdhc3) slot missing power regulator
> > > - [Low] dts: tas2552 codec uses deprecated enable-gpio instead of enable-gpios
>
> [...]
>
> > > > +	reg_panel_vcc: regulator-panel-vcc {
> > > > +		compatible = "regulator-fixed";
> > > > +		regulator-min-microvolt = <3300000>;
> > > > +		regulator-max-microvolt = <3300000>;
> > > > +		regulator-name = "PANEL_VCC";
> > > > +		gpios = <&i2c2_gpio_expander_20 17 0>;
> >
> > gpio third arg 0, means GPIO_ACTIVE_HIGH
> >
> > 	so need enable-active-high
> >
> > if your boards have invertor should use GPIO_ACTIVE_LOW
>
> I already went through all that, please see "Re: [PATCH 3/3] arm64: dts:
> imx95: Add support for Data Modul i.MX95 eDM SBC" .

at https://lore.kernel.org/imx/f4dbeaac-ab10-4980-9fc5-533907be223c@nabladev.com/

<&i2c2_gpio_expander_20 17 0>;
                           ^

0 should use predefine MACRO, after I check 0 means GPIO_ACTIVE_HIGH.

so need enable-active-high for regulator.


>
> [...]
>
> > > > +	tas2552: audio-codec@40 {
> > > > +		compatible = "ti,tas2552";
> > > > +		reg = <0x40>;
> > > > +		#sound-dai-cells = <0>;
> > > > +		avdd-supply = <&reg_1p8v>;
> > > > +		iovdd-supply = <&reg_3p3v>;
> > > > +		vbat-supply = <&reg_5p0v>;
> > > > +		enable-gpio = <&i2c2_gpio_expander_20 23 GPIO_ACTIVE_HIGH>;
> > >
> > > [Severity: Low]
> > > This isn't a bug, but should tas2552 be using the enable-gpios property name
> > > instead of the deprecated enable-gpio? The patch changelog mentions replacing
> > > gpio with gpios DT properties.
> >
> > Please fix this one.
>
> No, this is correct, see
>
> Documentation/devicetree/bindings/sound/ti,tas2552.yaml:  enable-gpio:

It is fine now, I suggest update bindings to allow both. which convert
by Rob at Jan 2026. I think Rob may miss it.

kernel hack code covert -gpio to -gpios

Frank

>
> [...]
