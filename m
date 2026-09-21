Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE733509B;
	Mon, 21 Sep 2026 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007882; cv=fail; b=OHgnqQAsTmsYAXnqEC694dalVjoPb1qcvslVtSV4xDiNklYs2EWoNqbGSUdSL/+eYGfKosbqbZIi21uZHm8stX0UkjBmjRq95S+n09BttPYc26y580isWPcPtCGkKpp7b/JvSFyl2eiO3aJB2AfsqKR/ZGzTvKIHAvv7/E/HusM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007882; c=relaxed/simple;
	bh=rR3f1apE/66QKg+zcz56s5sNujJGljhM9SEUlpVmvxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cA5pOt3Vw3X92klRKJxRNOyNKlj+fDUDcl7v/BIZHd5M5dzwYc3etx3g/mUoIO6A7f2qoQx7BJFVww69mf/HPOzIxDutztCpNqRcb515r2/wYCd7mH5h6Ihqj0s/dn4+i4I/usuiRWjDj9C+jvvkSMKw7EYoWqUeuuMlKpABfxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bZFOzMR3; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bZFOzMR3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJq2/frIbWlBvsOkGOTxZ1HPU8aWSmx6F8BDdlb19jlTJ81gSfAkXByaR/KIWiUp8k5iRTqLb9xZ9kXTCaFASKXCRtht78QIFmPOVHdaaFzxBj2Sv8AsTl2TES2bft4DfsS3caLeWis3Y7/ISBaW3HEMl1362gDOpBRA2oSZue3dTz2HCldAC4ZGBesGhSDN4oWZSfnaQCjUeQR0AbOFlx/ZRiTTntX8R8ERFyAN7F94vPqFWbQH/T37YpAXqw1vQbTZV1kFI2kHyVJzoswCzcgKguH6wv50M9uqUcRtT50S3iMnqsJhSFUQPSx2eIH6IQWPl9yc/FXvYSGCzPXpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTVMsaJpE6MfUHarnOp7BJaQr4yV8Y1hSIoST1Ho894=;
 b=KPfrmtyNkmJzhWC7OkZfYxUwKAgGkHBxZHYCfCiaR9AyZENXl8I/mWwyk3DuSNIj5iVzWgfx+semg4n2aVNrlARnz/Kd/roTGzWQHIxrMi4fMtzDpEyjPtP/R92PQfXYUc2MjXwi+JyTjH/MPWxwsXX6e6e762/VMvKi0bapg7Ug0PdmKPUpUkVFjkwr7WPqcP1W7rZrUCJesU4a3qttY2V2vwYigUhpAMHeinQPUKmrwY7/Dp1PjGO1qCc7NfeZKTeTjQm3LHXec3L2ZutcFxQTx5wIXFkyVwfzO+jT1vBjuyt3RYkyeow/jqWOhn5vk/zu3q0T12hL6HjVwVzdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTVMsaJpE6MfUHarnOp7BJaQr4yV8Y1hSIoST1Ho894=;
 b=bZFOzMR3ejp4l1EQ/IFDVb3PQZwb6UPQX1TxijNQptcDJ9GmWG7LE1D9q9k9lfxU3aCfiU0+NaIbgBoSQQN8ilCanXs4drkcuDkdvjWTZMnZrfIpGzQQCMyn2iUDNCbAw5y9VCO7SgOTVBeKjdr0Npi+zLS6jilT1rsspHGPy/Hj+wrc8eR4uwJ8GEssnoGcsg1KQO25ImYsOilAAxrFWEv8Kg/CR3jvvb8LGvH76bZ8vHfiTd7o3nq7/CTV8FU9g+0ikN0AW360Lh3m3M5WhR6A9RDvQAGUQaXlBW4/Tdn0UfKMfUcDH3xGmRrs6mQx9AwIGzQUUDyZPidpCjdxmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 16:24:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 16:24:37 +0000
Date: Mon, 21 Sep 2026 11:24:28 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, robh@kernel.org,
	Frank.Li@kernel.org, imx@lists.linux.dev, conor+dt@kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Message-ID: <arFaPA6aeFey9WlI@SMW015318>
References: <20260917062543.534416-1-marex@nabladev.com>
 <20260917062543.534416-3-marex@nabladev.com>
 <20260917063512.C71F51F000FF@smtp.kernel.org>
 <aqwbBQUSfd60nVeI@SMW015318>
 <384c5f71-d5ab-4990-9567-027605457439@nabladev.com>
 <aqw1agBrSjYoy71_@SMW015318>
 <c1197d8e-add5-48b7-b0ba-a5a91379ab04@nabladev.com>
 <aq1DnBkxgF49QLwa@SMW015318>
 <bca6ea91-297b-4316-b5db-74636593b084@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bca6ea91-297b-4316-b5db-74636593b084@nabladev.com>
X-ClientProxiedBy: PH0PR07CA0067.namprd07.prod.outlook.com
 (2603:10b6:510:f::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: ff14a9c8-67b3-4ec7-b799-08df17fcd47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|19092799006|366016|23010399003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yMaEIPa5yDNc0sanzb9NZjbCWTEMJPpTklCNGO8K0Nesn4+GFLBPYfFRH2XgfKTEVuYFbh8TCJ67oqm1qP7ultuNWT2ynyZ4R6eGZQij3Ly0kfXhcBO6FjTtqtuS1KQm2hEdH/SBh4QAUimlMjOkC/QcXpMzHmfduptoREwVUFvi1BJI/YlbjOmqpKN+abB+S221Ci7zMcrM1cgSX2Psvx6lC9e5VixFM6HqbgM1biB2/qkcvc43Wb9T6tLGZYwkBjzypGZLv0PpoWxIxBBKnnYsl7REn10MtBApaR7N73JS8LZ4ej0Y+duBJGFHVWaxE0A7FQto347LMFaerYrWbElXvMXjHhcUC6GYtekDGu9ZWydMgZ1USo52OO/z0X/6zjKz+ofvUxe/BW/3aT77cnIigzl49a218ga21kibPwF/ISu7z/jBWp9EIaicJlYLB/dAzVmwTifMUig7xJLOne0XZOQIg34pn9m+udm6gCibirvvPo/7OCrI8L6KOk0y+EBYZLglSxxuY7fAGCN/mBqItYrqmlGS/0pPpaj8mb9w7kMvHphABUS424FECT3TdkCS51mFDx3rrpWU7itZUCcvpoZI9S27HWWv938CITCERL0E+n7jGJzowBWkTl7J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(19092799006)(366016)(23010399003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zics+UfEPejxrsKzoEcGAXy3cbea9ePPvm7hIrYuZKhQ2A4Tmb5zpWSa/m86?=
 =?us-ascii?Q?Vi0JVCPWZpMz8gVjS8uTrhhGhchZWG89wXTWWm+VSOYxsy+PNv8JsmMjOW2D?=
 =?us-ascii?Q?S6oSbA3JyXTBD9GdXymbE4nICfHRkKuQEvPeCmD0XTdNgZ+7iWot36sj5tVh?=
 =?us-ascii?Q?9nxsbAXO/skGI5YTSSHnJAfOvU6aD1BJrzvaISORCO3tuqdklaTAWt24KAPC?=
 =?us-ascii?Q?0A5Pbx5mmyux1KJD2x6dPk0p2nj9wZK5eWLB2b0KEXmriMEJGSjty7dV6CFr?=
 =?us-ascii?Q?MO/baXBb4cdq8oQIpYLEofLRw4vEHEv0/I9/bKmPa+cOJRBvEavuhQ4MYCnU?=
 =?us-ascii?Q?NF4GCv1iYm97IVqlk96h3wBb0lfWlaHTFYgOiOp9UaGep9PNQL5pqKKe0a/+?=
 =?us-ascii?Q?ly3LEW8DEJ6B1sS8BQzCPyrexGuDys3wuOYX0krxIaGW50MOAxtNOrKu21H9?=
 =?us-ascii?Q?Om1xl3gspFHG2GEUX+SgTqvWNjVKmEZyN6q4+Z9W+c2Sa1dHdE9lvuosgRpL?=
 =?us-ascii?Q?EJw7FwNMBz4Fok40rpVHud7cgjvaCNywfoiCi1CqXUPfg+raSucTYLmtNNhS?=
 =?us-ascii?Q?HOyi75V8CvZZqUJiSBsdO7LwV01fjjUKhIB/IuVBQH/9931njF+VWvSI1GHh?=
 =?us-ascii?Q?xKfZYWF8JAHWT8c+tbRrOtxh+W30sNIU1X9e8IKocN7tnaES7JtZjPUBHYo7?=
 =?us-ascii?Q?Aby7t1EfIURlaaSj/w6OAG99MN45F7vmlTAIRoUkJMLm01tZMRnci0yqa4+V?=
 =?us-ascii?Q?sM62ptNCWhBSltAiJ4OxpdSfBrDHC7tMXzAFsBa8bNLFiNzvFXeQusvReG4m?=
 =?us-ascii?Q?uiYO1m1JOoq6kRWQaYdbXoJBloOirBPfvBCSPtAD5vNK8/pvUxTRP5V4+skP?=
 =?us-ascii?Q?lftTEFvzIJuq97F1QwKbI7+9s2H2V8/DbwW3faVFNhreNf+aWV1wwLn05EAX?=
 =?us-ascii?Q?RADVgjvIj6Lnx6H7Ers7F5Q1bIlH0NlRL3GHfHrWXTW2ZrxP0AB9cbSQXQUk?=
 =?us-ascii?Q?xaH0N1QZkC/YvTyofJQfsvdPaXUSh/4ghunoLlAPxt+V5BvkD1mrPqHC6+Y+?=
 =?us-ascii?Q?h5J7xsbUkT2UDrOUYiQKXu9hIT6RZZ55Fe0P0UDY4UkJZnN958LOpjMSCPbc?=
 =?us-ascii?Q?OiPXQilIhn45t5WX3r+77omtqm20YEoqObGpGKSr+roIX46lSkaPROI5/deB?=
 =?us-ascii?Q?ALd3gKUv2CMYY5pt8QTEm2rKE4XzRlKDEUDDjOnbhL6XyoSRWWY+yY1RbUsU?=
 =?us-ascii?Q?0cYOrgYsDvKRIkFJJ4vGNEKrC8VepMtnT85kUN1wXtT49Abfv40EdQAezDuy?=
 =?us-ascii?Q?XHHABzeRxFN7rl5rNErZmpVpWjmw1k3W2SH94U7cR4ZvfQ9lzDe5bcS4HWvS?=
 =?us-ascii?Q?ERO4d5GBPJsRXQ39+JtAPIfcP5L7coe8OmMPB1Lv9HVYJ93Gu6ZDIw2cxNNK?=
 =?us-ascii?Q?jY9ubhu+M2oQzOds4KtkopCdTYd8G/vrccw/KOzvaTki4mjW8LX7HN2OU6pd?=
 =?us-ascii?Q?+nyPp5mRiSkxz8WA/6mFmaPnRcjW1/RWWvctIPMJCRQT3xW2A3NV0wSavswn?=
 =?us-ascii?Q?w19X1TVDS6qxUE20gh+TFxQBxu5vqzOGWk58NgedCx9ykeQaHdFR8jo4r4N2?=
 =?us-ascii?Q?Tdbv7dVRvS8zDXBSWOvTLThz758KRPptxGRiRjXAXkSAHrnB1YIdRzGOAPZB?=
 =?us-ascii?Q?2r15nE3W3n2qF/Yszky19GsGLJs4L87kMSmKNOu9O16b3bM/Q/WXjJgpOmyi?=
 =?us-ascii?Q?sxfpuYHVfmMFoIEDtYPV2oV1BiTB20nBh5GlPSlYelhB9KJjmcHy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff14a9c8-67b3-4ec7-b799-08df17fcd47f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 16:24:37.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IiZ2qWRyRfa8KpGdwFrWOFkFoMTN1YbkVuaXE5yYh8pw116H2MLmZA3UATAQFmyujQvnnmxpD9AFI2PS/T1HnZILOxz8Pk6jOwG35F4lnDJ8qcPKjHNXqockL17RGaI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540

On Sun, Sep 20, 2026 at 07:05:58PM +0200, Marek Vasut wrote:
> On 9/18/26 3:58 PM, Frank Li wrote:
>
> Hello Frank,
>
> > > > > > > > +	reg_panel_vcc: regulator-panel-vcc {
> > > > > > > > +		compatible = "regulator-fixed";
> > > > > > > > +		regulator-min-microvolt = <3300000>;
> > > > > > > > +		regulator-max-microvolt = <3300000>;
> > > > > > > > +		regulator-name = "PANEL_VCC";
> > > > > > > > +		gpios = <&i2c2_gpio_expander_20 17 0>;
> > > > > >
> > > > > > gpio third arg 0, means GPIO_ACTIVE_HIGH
> > > > > >
> > > > > > 	so need enable-active-high
> > > > > >
> > > > > > if your boards have invertor should use GPIO_ACTIVE_LOW
> > > > >
> > > > > I already went through all that, please see "Re: [PATCH 3/3] arm64: dts:
> > > > > imx95: Add support for Data Modul i.MX95 eDM SBC" .
> > > >
> > > > at https://lore.kernel.org/imx/f4dbeaac-ab10-4980-9fc5-533907be223c@nabladev.com/
> > > >
> > > > <&i2c2_gpio_expander_20 17 0>;
> > > >                              ^
> > > >
> > > > 0 should use predefine MACRO, after I check 0 means GPIO_ACTIVE_HIGH.
> > > >
> > > > so need enable-active-high for regulator.
> > >
> > > This is extended via a DTO, so no, I must not use a macro because I do not
> > > know the polarity of this signal, that is why there is 0 here.
> > >
> > > The enable-active-high DT property must explicitly NOT be here, because the
> > > DTO can not remove properties from the base DT. Adding enable-active-high
> > > here would make the DTO unable to operate this signal as active-low .
> >
> >
> > But why DTO need update regulator-panel-vcc's gpio informaiton. I suppose
> > it is fixed when board design.
>
> It is just a GPIO, it can have either polarity depending on the regulator
> that it controls.

Understand, But the problem is why polarity change after board design?

If reg_panel_vcc is on added on boards,  should it be in dtso file also to
match your hardware design correctly?

Frank

>
> --
> Best regards,
> Marek Vasut
