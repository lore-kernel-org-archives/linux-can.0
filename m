Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793112349;
	b=laqGXbDlzWFrECgranv9b6YAxoYpKDo4u/XOj8rlB+wq20APy4WTxZhBgL+K5k0Awstr
	 ArnTGU5nLWMc38sr/zUKpLyQu/WN1hs16KJWSWmmzm19wKO1TsGgXU7QodX1VriQoT+Vf
	 h50xDqnY9gAx079D/OUhfSMENYdTs0QLHTIPiSJpjZFKUhgwKgI8Ja/S2Q84lmW7T4BMG
	 GwBdl0kUEFfuNedKdmchD3v6ONV7bL+EYQ3s84odm/5PkOX5V+DzC/hsOHOBqJG2c7uSU
	 hNzDLZCVWkvncjiyB5kFVOGHgSFB6p6WXuN6w3L3ZOp+CmrVfg4yDhPSGKSzznsOsEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112349;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=uEk9X6QMUSN/rscXagG88wCXX2uSzcyGqVNWVGM+tUA=;
	b=PM3gbRQTKR5MN6LORExN01MSteB3fj10idFlSUCSxZnPyPl+za7vwpDguRrjbsJPcRTT
	 XZEMIAPrDSrRZ5f89Jz6qhljENj1LVMxh//AJC3zVwkwltCpHZzNvTvia664w6A81mAzT
	 2WXNhi/s6IyCNN+fvaGDap5pkukQPHb9ziWlx1somQ6sQCwrdd9d6wJdLA1C6KTlrp+58
	 crqrjrOetvpuD0h/sXvEitY++VgtaK3jA+vi+gTNtXH7UwQePbOWNHUxGfdFhOjNbinkw
	 w0WufLFdy+lDald0OYNe2X/lgs+bEQ9lpR/VQrjrYEfbzzX0RQxyZuYYwB5H2L3ACnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kkSBIKI+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.27
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E56606A31B;
	Tue, 27 Oct 2026 14:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40E56606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kkSBIKI+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9B9P91dpzjnM6b5x6O+ISxREWiwLKYbJNxdsLfJMtKzVN7MiSPV7WikO149PQGMV5FFd08ihrnyDVRslp0bOm8suD/I1Ph79qpik8p7Cf9yhHtTCr0Qlij5UMkJt9fqHpJT9kGpYcyarftXCcyjj3FqYA2mGzajQRsIt2dDSpI94AIu+JLYkajkIEEFphEuj6CFqkqMHVyBSiMdveBmugcgMtLcbY/ktFq5tmu0Z8LxKB8jDeNbvGGK3uK2zvbiKv0Vq1DlHMmeefqUf6/bcXlgXS+iBJ6TutbDDPJvHOuUy3IJW0fdXnERvOKbrGLKiUUTJ9N3wKdzRZlGfnNrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEk9X6QMUSN/rscXagG88wCXX2uSzcyGqVNWVGM+tUA=;
 b=vcwtMXJABAQlci3xWaK22VNAUn5XRhcbWjUJfMFNhkkqiJEtPL0+0VcmTBpuQsnXn6xljcVIBEHjrqdqugtkffbZsDV9Af1SbvIxwY2J3cRYm7qY3f7STndxrzHbosDDNGEHCsPZGJzCdcNwQIYtdrpzo92KC7dCBnQujanRaijvnZkuverEjtTG7AClqJoHDEJWYH5uamMVZ0wRmINZIvblqicCWGOwFe/5J6SowWMt7+OypKrnV2hW5rf9oFSCaAgT5uDHyUII8SupY7DJERBZzQc1b4ozYtLTu648njjItDWnSrDY6wfqeNdBRe+NaPV0ypPCQ69cpQmKFri83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEk9X6QMUSN/rscXagG88wCXX2uSzcyGqVNWVGM+tUA=;
 b=kkSBIKI+iUduJDtfd7S7nLrUgCuErMaQjjpgiY7W26YiBVX+TwQ3XMIV5HMdIAqKtZUZQefKHbU95YI+c8SuclSWFJS7rDq6y42MyQFUOsvIAS62w+Adn40BqREhbjH+L0rieG/44YnnoP6zVdvB3loWKcYz1kyyxJUFXfBF5x3nucFrAXWlH8DkHT6GYrE52vpvkAkRoiwMkQxEXxSRhSKIP0QgjwYqP/giXQMAvoMb17Mx76pdYbj3QBVrqaAhO30xH6ihutXnKt5hFB9NOlBR+73rdZ83lLXlfQNRZmy5ZYksddibC4q3usgDzixhv9liUL6eRH/0cEcyOlxyVQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM5PR04MB556016.eurprd04.prod.outlook.com (2603:10a6:20b:7d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:45:46 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 14:45:46 +0000
Date: Tue, 27 Oct 2026 09:45:36 -0500
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
Message-ID: <auC5EAZ2arNqdsvY@SMW015318>
References: <arvPDq8sjjv7na01@SMW015318>
 <49303872-5622-4e1d-8e1a-01394ec29367@nabladev.com>
 <20260930174413.GA2463938@francesco-nb>
 <ar1bhpji35CbArtY@SMW015318>
 <17f240e5-9c65-4562-ba51-535b0c69c5fd@nabladev.com>
 <ar19W4wX07p8u3_5@lizhi-Precision-Tower-5810>
 <4efdcea6-a099-46a6-8d07-dd5c583b962a@nabladev.com>
 <eca44457-d3d3-4732-977d-d30a408b7b66@nabladev.com>
 <at-0VK3LQ5c7rVmF@SMW015318>
 <8768c05d-417c-41c6-a275-33ac7f74e345@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8768c05d-417c-41c6-a275-33ac7f74e345@nabladev.com>
X-ClientProxiedBy: PH1PEPF00013300.namprd07.prod.outlook.com
 (2603:10b6:518:1::e) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM5PR04MB556016:EE_
X-MS-Office365-Filtering-Correlation-Id: 97adb1bd-a41a-47e3-ee51-08df3438fbd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|23010399003|366016|376014|1800799024|22082099003|18002099003|261026140227099003|261009223027099003|4143699003|56012099006|11063799006|10067099003|261022105027099003|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	hic682IdI0YAtuQFBL4rU34r6T91hKwr93MNLTQYMHDTLQkC6Xz5j5ksezKtK65MPXjLcWdMjVkPQ+Oqb7OFukrKyL0gNPRdXHSmcAadxOOD5NEd2QJ7KC2xZyNy2bg4FddP85ykyUTGuP50GsLd92kMcXTMhyT8mO8hgjoPV6Ns93+sq5GAZQhNipVTOTKgek4aOGDS4f3HADZZUn+jtfA8Dgqg/gZTWgDjInAf0A2oX70OMCXNqHliYLJUnXk5tTuFhw5cSQXbw/ZIGm81T7AfTT/TqMjJgfK/isENyAFCNkbyMHN3eBppA3RSMINnOO8RpsItPsAAivuTi+HqwYn2siIVhQ/f+rWtAvcOBagCb2w8MTG19gx76KieI9sRjSOy8p4iJegro08bM7lK+mpQadD6MUy2TnQZ/PlQ7FM3s4T5ldOJXDlKCkzVqffYySp2xSdrDYQUSWOVWTDPRfSbKqeqo4UTwdPsGdYpGB0sf7JjKe6bfv096XyLPitspeZqYn+x4IPWfiakFhomr4PUoJMZipJWLpxiu3P8zcrTiUjrRrDVXpdGJjDaAN/b90h/oolV+X4A5O5QV/D0pY0srKEPi2S/TsSk7J/bmwYBL2MTuCg92snVIOrD912l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(261026140227099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(10067099003)(261022105027099003)(261021121427099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m34LAeOP5zIPbxGNDB/kyu9gR0GkybqsiqtiLXgUzjiuJuZLnLhb/XJvc9Fb?=
 =?us-ascii?Q?MPGq+0iFz41KJbKbLbgJl1+QLr21RgA4MbxVuoxV59TBEqH2uD7GVwu/cqP+?=
 =?us-ascii?Q?U5mbUgtKvEkMPCnSCbIo2Yjwf0XF0KshpFTv+xzOqtTOlxIopFNTaZt3vn4R?=
 =?us-ascii?Q?gpqW86tDfNXF8u0DdCDZ0V6rE3gy04A5uNYyWkuVsPh+xWwEW4ASEB9m6Our?=
 =?us-ascii?Q?F1bViyBEOsKSbJcpHGIXtHKM3armaqcQxqwwEXcw873YIhlvJq2lJxcHDDeS?=
 =?us-ascii?Q?oqfaWb3NRR+NCx96Tl4WgZ8Bz54n9qCzP5tWfEAy0rhA07wEqueqImsa0c3J?=
 =?us-ascii?Q?dNCzBY4mj0h0kfsf0W6fimew3wMDAc7UxOhTkHabl1/pD0cu8ZeW2ZV/avkt?=
 =?us-ascii?Q?FJdTwxhIL1rgh9F3UgoD6BWtAoTs/jI5yX/QDmMSr171jayV+HDp5chJV3E0?=
 =?us-ascii?Q?PFuO+9wbP3T8YV1Yd7ZxOY9uWiMVI9IeVPs5XGzgSFCt5Q8g1uwQRgQOxGAM?=
 =?us-ascii?Q?PCW8+23NvUmnrkTb62YuVuOwhaFpKVa9M+2AAOIoT8xTqO6Tk7Q7rxdM26eC?=
 =?us-ascii?Q?1Zn9DxdrWvab5IhcGsYJWRId/u/uMJmiaPw5kYTJGclfASeHOXjoHkAcumMP?=
 =?us-ascii?Q?tA4ECSX6SDsnD3O35adJSQnMU+LrUteYpL9TBdmrc5RXutQw1NxAmnnq+l+w?=
 =?us-ascii?Q?a2OOkEo/CCUaJ/kTqFYGob0CAmWfdiw0OI+rGDY2fEj/Q86Stx+zqpNCKblM?=
 =?us-ascii?Q?AOG/dREYRj2mOeNCd0JodKvQvsaMIOLahZXq3mRxVAi1531MRNvIapaAlJaW?=
 =?us-ascii?Q?eHnzaCOta5+v91UpG8L9hPn9FsPAhhwC6vnyDWCWpfpeTqUjtAkQugC+7AMd?=
 =?us-ascii?Q?YiJZseaGjpHBCzm1ms91SWCs7AG5cAYUweKohzvbKOAPv1ZnTf07cfjye9hg?=
 =?us-ascii?Q?c8Q0JwULUsXbR5pj9Zt/pd+A/ycQwQnLpQogs33jolfQQQvgY8NsY4/s1W5x?=
 =?us-ascii?Q?DRfA6j4VzYPEt+8DZprsg2TufuneforqrNJFc42jOr4Np/04eV+CE2GXW+iw?=
 =?us-ascii?Q?syPksdANgGFS0w598g0r8W8OqedcjqYdBYRcYQqm/Hh5wiZOaz3G49WhioNa?=
 =?us-ascii?Q?FrNugSjLXrDJk+ucGB+BE9UEeA7R+2RXX1/v0G4XcyxY6QesGkjGVSRwPMU6?=
 =?us-ascii?Q?Y3EFVctjDSzhWZeNi3r/+s+F/3w8A3yLjIK04HD2v3rhlxdbZgkIrNR4r2dl?=
 =?us-ascii?Q?2/0JZYmvxQf2SKR5bWpgsaKQTep5RpyDn7anvwYpb0V7ZmZOq3thhtHTxWKs?=
 =?us-ascii?Q?yoyVBi5iAhMlSzOM0uWoOciyeWOlMj/IuZoIFHuJK5b0V9pV9t5l4gaynure?=
 =?us-ascii?Q?duvz4RID8BkAoIR7tevxd9c7ZDnwiws58fiGo+V0Mwddaw3NE279XYEnMNi8?=
 =?us-ascii?Q?AW20faYNypg6QIMDyvLgz/+gMjq/Qsszjhkg62CD3/RAm2TDyd8tlwtC+UZB?=
 =?us-ascii?Q?5wr73SOQyd2EkaCl7f45S1luhrlCjCMTjOhOQrgw2tuRADmfSje9ySEVDcEg?=
 =?us-ascii?Q?IJORtRn58hV2QzGb4FEMkaAD7QlLhja4Sr3L6hEbFM9gAp033b+YG1KsSYT+?=
 =?us-ascii?Q?DwTpMMaYF2VszgmNDYsB51P34RvlKh7JeTIdVipU9762Owhv7+sIdBVRi/lo?=
 =?us-ascii?Q?dxrHDiuDqqt8c7UB8IT7xjo9p+9vyRjkaMUheDpk6kdStW7icZqhNsCEaYGr?=
 =?us-ascii?Q?iItfTbSqTt65lyZNzG/XPOZAUr/MJME8ggr0AgWFFi0S4r76x6g8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97adb1bd-a41a-47e3-ee51-08df3438fbd0
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:45:45.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZsjWwKfC7vfhFIUNCe0IhwL6i/nR/3JCEEWnaHx/jmrYtz8Nc8BVjmDb3xIXL+vvbpag8IN3L7XEiMP5wcOeSd/gmAGqU3VhWABN2fdJAsuhyR28kOaUmcxkMRZ9N9b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB556016

On Mon, Oct 26, 2026 at 10:46:23PM +0100, Marek Vasut wrote:
> On 10/26/26 9:13 PM, Frank Li wrote:
> > On Mon, Oct 26, 2026 at 04:04:02PM +0100, Marek Vasut wrote:
> > > On 9/30/26 11:49 PM, Marek Vasut wrote:
> > >
> > > Hello Frank,
> > >
> > > > > > > So I suggest remove it now and add it when need.
> > > > > > Can we please go with consistency between these boards from one vendor ?
> > > > >
> > > > > Yes, I am keeping consistency, then ask remove it. I applied alex's v2
> > > > > version. I put v1 link to show krzy's concern.
> > > > >
> > > > > https://lore.kernel.org/imx/20260319125013.2421621-3-
> > > > > alexander.stein@ew.tq-group.com/
> > > > >
> > > > > Changes in v2:
> > > > > * Changed commit message to imperative form
> > > > > * Remove (currently unused) display and backlight nodes
> > > > I sent you a V6 with those nodes removed.
> > >
> > > Have you had a chance to handle the V6 ?
> >
> > Does first patch picked by vnod?
>
> What is vnod ? (the patch has a RB from the DT maintainers)
>

You touch PHY bind
Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml, which supposed
picked by PHY maintainer, vinod koul.

You missed phy linux-phy maillist and vinod koul. get_maintainer.pl

Frank

> >   dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6563
