Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2DA4E431A;
	Mon, 21 Sep 2026 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010713; cv=fail; b=Y5bFuQdWpZmRuwimKp/MCwVHF1ezdNeNaBFPSqd987b3CTB3RVEIocwAlBI85u4HDV1m2fhztjO5KubljXdxiMyB01lHFQuLkiGtKD/jzRLBzmyM8pauiua5G795+v2fNqkUWeCZiQS8MG0Z09dc9v7Ki91RRIgr7awb0VG0Zxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010713; c=relaxed/simple;
	bh=IsXH4rS9d/V6hsGOTPOo5no4M3p9Ddr113YUYn+mReo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lLXxm9JpslsC7dg+hOY2sQktPUdcoudeaHEHJFMqAmllM1b6+MWmH7d6rQz7cYbtulHrd0CfRShWtwbuDm41HmtR1pINjdpgmTq6wht9Uh2GMlh59exMosVM7+LiXt6dspJMiYbN40jTnLyBAQL+3MV0wRXbZscu3bwYTe9aooE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hCu5lFXi; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hCu5lFXi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmHBzjHNMCmDY7VfmvXYWTxDYHPQq/VaeFvOYf06h0qebOqnj3hOYUbmI4J11ColzDeySYhNhkzVyLEizYHtiGljgZVoctbLaj8MROPMUQsWkH6vAiRDo1VMCKi+K7yiVDkCSOhIw5CFwyjVOGEcZK4Vq9/0N6aQIVzw09jZvzW3W0DiI1NSZXHwlDdsHeWqEulwJPvklIMxICLzRX0x2nNoq1Vcx4fxbVmVPKaHjcF46IEfx899KeKXmPbznPulzVHDpSkDpwdLQHN7hYdLTniWWqO76ovQJdlszDBZKHkYpPfw1dMLXU0dw2Mi35eGDsPWmZ3nKucg0tDrwhT/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYe7/mopS7h2Q71MrdPrdJxodB99jyj+fTJCug8tV7U=;
 b=l9aTc9S7F2cyruYrb7JrS1Q6D+vANuANL/j7EaprlOagYGcdp77lKk1y5/8QLC9NYJXD1UamjIc2fccWAUoDvBepM+g4Wb67PcrC62/8LgBEAAE2Vu8zv61SJut1NFvD40n5crYlBuc5JF0c2EhszOyoHg/IWAqO54iRDEO9PGkPMPtxKDwb6ojrMdtPw7tOQFcWcp1uHo0IEdYi65nCXgrlaauMfo+I+DuWTMzIt3oBK0uf87xCDIQvrlDxqAX4kIWs1Fqj4KBSQapEIjNM29bM6PSfsUaQOtXnO2Y3oHzRrpe7Pi1mr+7DRUtmalx00XlBNSlL2AeklMo+JUVrAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYe7/mopS7h2Q71MrdPrdJxodB99jyj+fTJCug8tV7U=;
 b=hCu5lFXiFiW8CgjTYaiZ6svcjWXib+HIn2OMbKqOoWrmQziWi4J5jAiuxu0wYpMARUOyspKYwzdNDb3J0d5/6rxZHJWdvMJTcqbD0gxG1WcQQb2xw8nL6W+uIJTSY0ZhFufTjflxi5c0ufez5++n+/rDMi/EFGTFg8tmySMWEoUIxvvS953ibC2YsDSvQSTmTwzuCRszZR0dq2KrZIXRsg7TAmKd345LAmtMdwTNMJSryNldNBm9bY7qf1VmbwwYFpzbGqfd+fkqzOb07WZknLK+QSJXCcFTYcOOrUHOecloE3lxB31TEjgJiuOpKE+sfkJ/j8ZIDT/5iwlC1p1cmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBAPR04MB7430.eurprd04.prod.outlook.com (2603:10a6:10:1aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 17:11:46 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 17:11:46 +0000
Date: Mon, 21 Sep 2026 12:11:37 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, robh@kernel.org,
	Frank.Li@kernel.org, imx@lists.linux.dev, conor+dt@kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Message-ID: <arFlScBqnMDmJi2O@SMW015318>
References: <20260917062543.534416-3-marex@nabladev.com>
 <20260917063512.C71F51F000FF@smtp.kernel.org>
 <aqwbBQUSfd60nVeI@SMW015318>
 <384c5f71-d5ab-4990-9567-027605457439@nabladev.com>
 <aqw1agBrSjYoy71_@SMW015318>
 <c1197d8e-add5-48b7-b0ba-a5a91379ab04@nabladev.com>
 <aq1DnBkxgF49QLwa@SMW015318>
 <bca6ea91-297b-4316-b5db-74636593b084@nabladev.com>
 <arFaPA6aeFey9WlI@SMW015318>
 <c43d3f57-8268-45f2-a654-a11ee4adb72d@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c43d3f57-8268-45f2-a654-a11ee4adb72d@nabladev.com>
X-ClientProxiedBy: PH8PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBAPR04MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: f444e639-3e29-4cbe-9c65-08df18036a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|23010399003|10067099003|56012099006|22082099003|18002099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	INZ7mwG81vmxuAbM766MmAgffg/fPBAnYOsIYB3tmWbiY2qSoisNxDa7/s07qXlCQLwQnkz0TZEKTrGQIbaSPmjMGG6w8b3qSsQdiWe15XlDz8Rg4PMiikIUJAcP94KhN3vsxybSi2dBFlmRtoDVvTg6IM5p4sIv1yeD/rdo3eCXx8RzAxEWJfM18A/gAsPdCrZnl6EjiGRse09j1wruyjGVm/YOp6OFsPjiMVP6vmegnJXTA+Z/XKl2WHdzU1cLjb3Yql5xWHFZZ7uWD65XvCH8/tTyAl9gZKRkzCdxA8qkWnCebHAu4EOW+skdvewb35BM72ymsgSHnVQmmRaGlPmHwg9+xTjEfMpc8IMgOKDJqNhmocSwqnaJfilZhSTnUGTui5gNvceNizNBgix8ph/nmhopsO0hpInybB4bOEdN3dGjhWKHEBg7cQysyrRlCtZoKsMvvZX8caepgdAjk/5p+LwVwkmFMoR6GL7GuVvZly1bL+4mHyJQAp842C/ZwojHHlQyHB95YzzdbKtLwxBtESnZfmGQPqRW6ZffaCoz+x7WEARFUZ4b00XKSy9PmRm/mkF0NZln5oYAByAvfB60xWrx6MuHi7Taq2Vu/nbNlj5+eg1ddDOtgAWJpnTBjorI0REN56pWGobRMTmgFX3S9YchtRMvoTrT/MPI68Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EDrVFkMhSO2LkuF+NzSh4b4cVr8L57L9pk4tBOqMLCBCmYyn2OIv9YBP3WwR?=
 =?us-ascii?Q?T7keRu+pwTSMnUAH6mt1shIsDnvzYJ+kJWcdi8Q4Qn3cAz7VvmRGghFDhefK?=
 =?us-ascii?Q?8EaQBkZS0TzvGHSUncJrvmB2wVRZV2NZwo7Es0iK0vo5+gADFFgFeQdT573Y?=
 =?us-ascii?Q?tqq311njmnSCESkpnDHzPzyxTy2cOcEK1SjeBZ2sU1LswNtkzoW8AJcePcjt?=
 =?us-ascii?Q?ULB3uv/BX8WjzKZiLdD84vIlOD0wr54231aKNN74BBbSvQMUxgZUPcMyH/vg?=
 =?us-ascii?Q?leypJQ7o7DnN1rdvPH+pNcFd0WfFvcQeiYWhB7Ys3AvZc98hbUiLBfvJdeKZ?=
 =?us-ascii?Q?26rVYJFTyq4ETBGTalbLc80F2AcJlr7eyxVW9v+r/bFlXlcI0dtX2nl4iK4H?=
 =?us-ascii?Q?PnuAftITHgM2oskUnHeGqKVYhO02+9v9mNR57Ybn1/rNY7dMaq949tnUNiYI?=
 =?us-ascii?Q?p6HpVN7LHI3fpXIEMN3eqM70ppdCOGvFFpwPhesAN2Opt1qksdNjCWQryaa8?=
 =?us-ascii?Q?dOMT4uqSiAyBpBldet4Xw2kVvkMeTUC4Rhy9e7VUrc/MV72+rdVwPbJjFnoO?=
 =?us-ascii?Q?iIJMNiuQRjFL4WM/o58ag0VHNZTKoiBhhnvl7L8hkmeyyMH5FVAIZZjFZL7I?=
 =?us-ascii?Q?Yz3uXUk7qWcamriLMZLE7B+dmWDHrUuVdnCFkIgbVl/VkP4WHzdNGsPJFKaG?=
 =?us-ascii?Q?dhgcUGigovhHV8HZ9BduZuwEBjr5Q9ohsaBwNK6M5KYzxk2q4m1fe+jvEuVe?=
 =?us-ascii?Q?PqZHVDoAJSEwauGMldgcX81yHLgF7PhzsJDnomwSxQkNIm5M1BbWHigIYWPt?=
 =?us-ascii?Q?Z5i2y3j2FCuwb2ODwlzY6KBxocRROnQ94BVayKmRZ2cuFTMtTDALxTW5Apc6?=
 =?us-ascii?Q?Qniox+bv7tDWTrPoKc+CfYwHO8/qzxUfvwu8qWLQIcnpc5/+l4er3tXLd8hw?=
 =?us-ascii?Q?8nAXSWeA40EfB64ZNQSmF8HJC7zLVrimnAnVChBx14uAIwjdM7dzA+mNNCCe?=
 =?us-ascii?Q?Zd6f3fcV8QP46qsk2BXPxj2QRCNtF93X93mxI27lsiSjKTAkgfPqeo/e2unS?=
 =?us-ascii?Q?WjSea+6WD5we7NogqEKY4u9bjX74iKZ2RUFY1wpexWvQ/Sa8pD7ajG2KzGVS?=
 =?us-ascii?Q?kFAhTHFfmbRFBL2ipHCPEEN79HZv6t1H+Q5r3a+lsdpapssEN+0Ki0Af5U5K?=
 =?us-ascii?Q?8MXM5T/WNUwX47bT0DbW/wx/DIN+oKY0o3hiDHzKjSSS8DUFPVS9BpXmZF1r?=
 =?us-ascii?Q?1Oyn0iEhc8Dq8R+7atDNmtK85+EJsDc7lfffsDjIbgFTWgyk0QIJyuv3c8vn?=
 =?us-ascii?Q?PLiIL9Y4J9uZLvDvrG1jM7sWe7jkFEg4E1Igg2xWFMeNi67z07rXeyxqq9FJ?=
 =?us-ascii?Q?ds6kkQR2Z1FkrVP/gQu9d6eg66SGLe4YJ5vi6qbBo2hKmey1YhOl8jjYtWTL?=
 =?us-ascii?Q?zQHelpUTXGDLLeJ+ObhwE+IsOxOFcy+pjwcenzZ5KLmvzAKezKwia2nUIn9F?=
 =?us-ascii?Q?1vuB8h3wW9fe2SHp9Y+NnbkLruceIXLQFj4SZ6SSRgD5cBK5hFdJdFjuNZ0l?=
 =?us-ascii?Q?GJbYkw4q3kxdRbuWnTNoLPvM6vH85Gx782v/w6ddqVqMXc7zIu0+ZZaTff0j?=
 =?us-ascii?Q?0ekCXgz4U3lv5eujdGWjDlMj4ZLhWjWTYrQqJRJzGBzzoDofkfq30cVOv4Xg?=
 =?us-ascii?Q?8RUqxOYhggB+WmlzQDDhz5InejTsVEaoeZFaBfDX3XVyg5tE4KmUDiO+fygs?=
 =?us-ascii?Q?+pKgJjIEJuLv8T7fIBxoR4+UqIhVa7I4qPTEjSGqxo6iCJI5yWL4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f444e639-3e29-4cbe-9c65-08df18036a7a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:11:46.3553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/5QBbfblTxeNWCrnd2gM+fVGePX37rQLrE+XdtclJ2mCsUuRmVgPfUtDbnQLOowm30yMAw+wZW1qxQwHtzmm3BhLPfShVgdQ/vViE6VSpHFaoTyA/+XPmqbah8P8Jlq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7430

On Mon, Sep 21, 2026 at 06:37:26PM +0200, Marek Vasut wrote:
> On 9/21/26 6:24 PM, Frank Li wrote:
>
> Hello Frank,
>
> > > > But why DTO need update regulator-panel-vcc's gpio informaiton. I suppose
> > > > it is fixed when board design.
> > >
> > > It is just a GPIO, it can have either polarity depending on the regulator
> > > that it controls.
> >
> > Understand, But the problem is why polarity change after board design?
> >
> > If reg_panel_vcc is on added on boards,  should it be in dtso file also to
> > match your hardware design correctly?
>
> We want to avoid duplication in the DTOs files, do we not ?

Yes, but there are not dtso file yet, I don't know how to share it yet.

>
> Hence, base common stuff in the base DT, stuff that changes in the DTOs.

Idea is good, but avoid hack stuff. Can you show me what's plan use
reg_panel_vcc in dtso and how to share it.

Frank
