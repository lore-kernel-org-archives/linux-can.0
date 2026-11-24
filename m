Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795543473;
	b=FgDB9JxppXQnj7tKhJmdf+WSvA9fKyDLm3UlYJjPf0/pRMs19c3Il8Ow1sGGHU1DAF94
	 hMLpcQH+3Y4vsHFW2sz6+/0HuSLM0dtFhh5irT0pblPVijRskm2Q6cWXE0z9ry3Q9ftbD
	 QfN5KUW7NdzR2uzHNrHOfANY0tCzPplMKwj0kxaDywW4Du5zoA6BBcUqYGW/xjh0Y2Bqd
	 dEs1t8qllNS9JpemKW3N5kPPJAi/Wnt3SN9Q+a8TScdVeWKRse2UIzpr6TN6i0otpp/Zn
	 3vK1O/vVigK4bUsRyf55qckHWEYmaOzp4SwTM1XIF/tXwJC93IQqc1GAaqgbaEoRh/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543473;
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
	bh=k5/B6PL75UGMNVTJq2uCNOwBZ/px3x/G0GnSVP138YI=;
	b=S6SiucKtEAADK/YluYdhYbNj93xpd51zCpdreX6PHDCCcMlnGkynqb9/XM81lQlBlJd/
	 E0p+3lH7uIgcdeJoeElkIBM/6JP3S/oN3X4dI2xjZnciyyVoLbEEk4L+eaIhKxFkLKIL+
	 RGg1q8mwB41QUpncYV/XqQ1e9GZpkbaIHWQt3bkScpo7t0n0NxKoL/1Q04viNBOiYsFn5
	 II972EBXvLxNi/Gj4vlycEaW+X/oj3xte/GegBbDkgXrLUZ8Qt4ojEYY9Te/EQtPLlPkR
	 CU2mPVp5Y90+nlpjW23BigUBsgoOqrZAO2VbJoo8ZJjnoYpLVuCB9YVLj+0H+QLIbeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GRoown+W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.57
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A5606A338;
	Tue, 24 Nov 2026 18:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C33A5606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GRoown+W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7n7zorw9duUoxwXbXNw1ofSz7pFyOldzaYxgnEEorNpSXpzSoXcT0l6z/GA/15siknXV7do9dkoh/apgfS9lBVHmWjuuYQFBNNhKF+5mjR/1gb9bIa/vVyTcl0rXjWWIo2eG2fTnXzDbqsnE0OPycCY4qsa4dk8asBp20SyFjk7hR4G7iyEt7r7kCBTf4+nk6luY42tvHMdswJKY9kiNlup3Goj+55++ByF0REWa8CXi6fsF2xZqLXOPnO+jVcQfpls4ogHYtkt3R6EVHnesaOG76x09vBvNoYvuG9tGOdY2fqIHmge+ntTfdi3j/+zL/MjLJ0XKqNDMgCgRs6dbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5/B6PL75UGMNVTJq2uCNOwBZ/px3x/G0GnSVP138YI=;
 b=hgg25yHPIbyvCStrH/RMl4EUW1GTImM0lq5RZ5ZWi5a/n4vGO1DJU1JmGX0R2DnXwQMecVUfqXwnxovo/xYhfsgF+WVepOaYvYF1TOm2sxupYX0ctsDpWe2fZ0QBosLrnY+tveHyyqszb3HEgO9y3PwOg8ycWSu/76/aV4bZc3+9JZcKQ9p8wJrthEIDk+OqZYETkH7DrTPSLsHsirViKYDOppcdC9Dyo0y8SI362qMGzq+Ebl7/G1H3qgHZu8ji5UnKb5+Zj7R1oJoSRRm93DXwNxVro+I+hW/p+VowpPLhj6+tz34nkNsImtJS9o+k7VcADBvDthXthfxd2N4iOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5/B6PL75UGMNVTJq2uCNOwBZ/px3x/G0GnSVP138YI=;
 b=GRoown+WrddWyu4QLAPSq0DjS3hVks7hU2hxWiQpS3kargzGDyE1bQV2lSLm1/G0BYP32ArPXhj8LstRikaISEXL86M3vluxoeVwJakI6YaQ5BnKJjAZgIokFrmmMs9UAfkmC7I7FNnHafLAyFfhxbk44pqPopGG2Pjb1VDC8UDlGTfAnW/91XzCGlw22sIXiA001//ByPkByH74bJoak4A5pQ0tQ+8pcOxhNiYHcOwxkY8D+eRyvyPZkEAy5+y9odFyA6XUisPbKEAZPF8KvSMaVGePAf65OjC7Yfb89UB1Gu2zJCThXEsmDvaOJ3xJyo8tUMmZspAP9lIfwdDdiQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM0PR04MB7075.eurprd04.prod.outlook.com (2603:10a6:208:19e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 18:04:29 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Tue, 24 Nov 2026
 18:04:29 +0000
Date: Tue, 24 Nov 2026 12:04:17 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Frank Li <Frank.Li@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
	Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Manivannan Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH V2 0/6] ARM: mxs: add EVAchargeSE board support
Message-ID: <awXRoV4Ldg8XJ9BP@SMW015318>
References: <20261112130506.12823-1-wahrenst@gmx.net>
 <5e2563fb-bc32-45e0-88e9-71ddd1d8b1d2@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e2563fb-bc32-45e0-88e9-71ddd1d8b1d2@gmx.net>
X-ClientProxiedBy: PH7PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:510:339::27) To AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM0PR04MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 3158a5f2-ab67-4f1c-a2aa-08df4a556201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|376014|1800799024|7416014|18002099003|22082099003|261009223027099003|10067099003|56012099006|4143699003|11063799006|261102123227099003|261026121527099003|261021121427099003|261026140227099003|261028144727099003|261026130827099003|261026135527099003|261021133027099003|261022105027099003|261021130227099003|261022075727099003|261022113327099003|261022115727099003|261021135927099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	cjITTcA+3wO5MHTjJsE/WtLwKpTBp4iglS5c/p9XffmnMLxAZ1luM7M4tQljd3Hwp122Y4BWP7X8tCLqTiBdn7uRkWvQAI1bLhUK8swZyPJUcIBo40ud4KsE1peMUwNm/e8dOn3gS9cV7iZijBVfR/nbusrdhcpPZ9C5y1ExJZIl59kO0YwdTRJFwLzEZlwknOK5FemlcloV+pJOxzcfqKjr23974Friy+nclqfIrPYi+BXxUHHzeqOv5SAvngGWFOLE1LzFJ1BpKWgn4kE6fNPsuln4qstxUqn9oTttG5CyvT5QNP9mVTcGpS23aKOKqlMeMtohoYC1Xv4f0Et1YLwRauo3EZNPDCXA99GBiXdZGstQgn6cMGRxjV/yuvnPeK1w+1gIpfYFeRaqqdWewGiS+XHm/wlyp74T9DWIHea/h2E0e3ggbz2SA865t/RMcQCmrRl25MNatW+0k4FFACdbIOq19LPmiUjcHAQudenW+Hbem4N9B/5Sgngr7Sltja971ctZ805xLC7ib87c6gfk1D3b1TdUcRsZbI45t3oWDSOUtkrQg59yF7xThdh54yV5pOT7HoXj0LSpqGo1SamWABnTlit3loVTQQYT5YW+KSwDU4rVT6SLyPMpIBYEpC2RvF5f4hKy87LzzvE/HmAp/f/C3srdoNrBLUZRFAM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(261009223027099003)(10067099003)(56012099006)(4143699003)(11063799006)(261102123227099003)(261026121527099003)(261021121427099003)(261026140227099003)(261028144727099003)(261026130827099003)(261026135527099003)(261021133027099003)(261022105027099003)(261021130227099003)(261022075727099003)(261022113327099003)(261022115727099003)(261021135927099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qGt4qsZyZ/H6oVRpXmNbTnjPQWmuRShRnQwvM7cEFRHJpfrjT4RvE/XoXQIF?=
 =?us-ascii?Q?MEA8uXOyDeN472E5hkpNTqL6FFjFKjPddo6vbm7tWi6zM3JW7GTEkycusBet?=
 =?us-ascii?Q?EQwHLnPUssxuAOiQ5THpkv3tRt2lHDK6PSJX4bGy0EEzDnxLQpVeLcibGtEA?=
 =?us-ascii?Q?egQ6aPMvi+bzYGRnE50PauRj4cO1PSZohd5eFTRNfArIJLvdgo5HUjCnkxYU?=
 =?us-ascii?Q?+e35oIPMxX0sI+/1OwExKmv3b7Pb63mOAKXS42/Mf/QCJp0nvLPp+GeqH9A0?=
 =?us-ascii?Q?4GBYzzp1f1nRFyVKHcZ1kf7FANLJHuAZMmgH1A+z19vsyG4dyVggB1OLwuvD?=
 =?us-ascii?Q?a3uZh6z5ayb3/8Ohn+ZyJ5PlXurRjIb5jS9IReZnqhIcB+osbFoyRdv/YN8V?=
 =?us-ascii?Q?6WHQ4x7R+7jGSaoj+v0brNbjL4t8icQJTEJqaQpvPzPB2F+AIItYbSgmc7mb?=
 =?us-ascii?Q?++cTQHyEkvm1/N/HGGsoDFAg8r0TlLoXj6NrQeXyBdk2oxevpgcKb9mJn2DK?=
 =?us-ascii?Q?4q30yxpxlrKwUfRNHSDzvOpBJS8csfpa1RUFc1FLv+V9c3g0OFErun+chMEt?=
 =?us-ascii?Q?NrBRZ6QTvu1kfPJNYYcFjjbHj49UfwGizuDTwxgs4uVAT93EZVij1QZ+YEy8?=
 =?us-ascii?Q?5jThV8TMMeu1seayAPuuGyFP22rzrmKRwoTCTTqbhTJKJi6sjepquGZKTXUQ?=
 =?us-ascii?Q?YWBzAtbJ5pKAH50hKQWW1RGrtEtGefedfMGbSikt5dfA0k8MosysJbXkhPRl?=
 =?us-ascii?Q?3APNRTleqSRYTUxM38s3v7ijUg6BxTlNTOLuK48bksU3v+tpC7eknWRApSH9?=
 =?us-ascii?Q?J/KqisEACmxOSkQH+5dHoM9LBsUJT9Nhd/b0wuOHO07+rtPyD2qDIGvRq7zJ?=
 =?us-ascii?Q?De5r2ktwjPo7l62AOrUPAmWW8OYEdY3cHpxHNTyj26wvtO4MHFDYOwFURYXU?=
 =?us-ascii?Q?xg3Q22fRQwTDoxb2N++fmzRRTQJU2x9bKGxwdYByTFdJOScfehYjxYgIxG84?=
 =?us-ascii?Q?H+i78fx0ClLtqyYN+2CqqWjwMYebZ9ckkWjYlvy8DHFz9GF8aTb4mcBMk0Dh?=
 =?us-ascii?Q?FkSUW4t4hEGpXaUp/INGAEyL/7j7YfjUU7CWsXBZisRK2eHYbXgqA38ST34o?=
 =?us-ascii?Q?SMnpuMeF6zJYltUsb2L7RrYVmES2i7zIC00gieOTi4EKjYTvtBwK/HvIgES9?=
 =?us-ascii?Q?4+SvmjD1cEbGK5G74UXoOCEFhOIOft7r76UPEimsakPMBLWhc2sPeLw36owQ?=
 =?us-ascii?Q?jbyvWZKXxhzYJ1+Rv296VzEsY/zrKci8FdCXFNwnCAlrQbnoSdA0xY+pUFZf?=
 =?us-ascii?Q?G2SG7Z0GVKegfy+DJqVZpZB4qEHJmeYa4+Js3FENE8N/SkDyg93jSXyml7Fy?=
 =?us-ascii?Q?4qouq+PNRoxTaU5g+1cm9VReNrOQOJj7eYmnrCY9Kg2BF+oiwOSuFLihnOnZ?=
 =?us-ascii?Q?CXeq8Qa2odokk91Xsp1yt4+RIVleaaYncSRj7zy5lLKrG4dc6hrX3YHVYyNY?=
 =?us-ascii?Q?xA/oj2QmrI5Qxa8RL/faBbjf8uom7oqyNak7G8x6Jl/4tA8H9GZNEnKzxF/6?=
 =?us-ascii?Q?/ja0vmirrEoef44fIxAZoGZiiLtpGjKEWWG2YFP68bEw1yJ4DlSeXfL4ICnB?=
 =?us-ascii?Q?cKBUuxyERVhtWXuPpvmZHeITBniFWVo/Sp82VWADLGyg8xNAS8DiSSzERCmX?=
 =?us-ascii?Q?CDILIKmuHp8ybE3U8SqDJeQ/fUGaZgeIBN8f6T5COWoRChOkb0xFhMpedqb6?=
 =?us-ascii?Q?vWOgenofvnv+SqlFNkIAeTw8AeEHq6DttVjKE6jEH3cD9MTKw+xg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3158a5f2-ab67-4f1c-a2aa-08df4a556201
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12445.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 18:04:29.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQnIveVkpcDf+I03SibYDSLM679unuas6I7v10RrOf2Xqu8aDsXCBPKHAzYjf0Gd1CwZkkc5ZmU1w2PRNbs+3jgpiEixtimpBYuPSg+thEaZ9ztNJkJMJn7UvaKj0w1u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7075

On Mon, Nov 23, 2026 at 07:22:47PM +0100, Stefan Wahren wrote:
> Hi Frank,
>
> Am 12.11.26 um 14:04 schrieb Stefan Wahren:
> > This series adds support for the chargebyte EVAcharge SE, which is a
> > ISO 15118 compliant controller for electric vehicle & charging stations.
> >
> > Changes in V2:
> > - add Krzysztof's Acked-by to Patches 1-3
> > - align writing of EVAcharge SE (reported by sashiko)
> > - add "dts:" to subject of Patch 5 (reported by Andrew)
> > - add PHY ID of LAN8720Ai (reported by sashiko)
> > - move enet_out clock to MAC node as in imx28-btt3.dtsi
> > - adjust IRQ type of PHY (reported by Andrew)
> > - add new patch to enable EVAcharge SE peripherals in mxs_defconfig
> any remarks to this series? Vinod already applied Patch 2

Does gpio-mxs.yaml applied? Or Linus Walleij agree go through dts tree?

Frank

>
> Best regards
> >
> > Stefan Wahren (6):
> >    dt-bindings: arm: fsl: support chargebyte EVAcharge SE
> >    dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2562
> >    dt-bindings: gpio: mxs: Allow gpio-line-names to be set
> >    ARM: dts: imx28: add alternative pinmux for CAN1
> >    ARM: dts: mxs: add EVAchargeSE board support
> >    ARM: mxs_defconfig: Enable EVAcharge SE peripherals
> >
> >   .../devicetree/bindings/arm/fsl.yaml          |   1 +
> >   .../devicetree/bindings/gpio/gpio-mxs.yaml    |   4 +
> >   .../bindings/phy/ti,tcan104x-can.yaml         |   1 +
> >   arch/arm/boot/dts/nxp/mxs/Makefile            |   1 +
> >   .../boot/dts/nxp/mxs/imx28-evachargese.dts    | 295 ++++++++++++++++++
> >   arch/arm/boot/dts/nxp/mxs/imx28.dtsi          |  11 +
> >   arch/arm/configs/mxs_defconfig                |   2 +
> >   7 files changed, 315 insertions(+)
> >   create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts
> >
>
>
