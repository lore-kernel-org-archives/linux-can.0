Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FAB375F97;
	Mon, 21 Sep 2026 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018653; cv=fail; b=XH69gP8zmzwuIHmLhdqK/S/r9CBzoAbRopdPZSfAbQEQcdYEkEYqbZmGB0j2szOmPG0z5Jg3Ht8G3ZdDxAp6himLAy/xNx/iSFb9OcQTWjt5HUgcOopvk/mWu4yS/3Aasf+oPdZ+cXQILw1p2Ndv7M6liGssxIMcwvuQRKjz+ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018653; c=relaxed/simple;
	bh=flwewLgJrClw4ndeff4HZbs0bZAziKQ0RokN2FfHuVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=urNzS5vfAvkg3gPDikgNlWKaNnC6u0FulTyt2R4XPqp0RVEIPnoKwtMvoEyRrdaShoJgvRAFs3TmOHeQC9LbEyooFYYHIJBuq/qhWauCqX9F68QyJQ9tpvpW9FaQDP2pWZlk3rRVJbXI4pLNdgSWbImWRnygFxJ/gJeH+Z+Zr+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rvaFmxTh; arc=fail smtp.client-ip=40.107.159.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rvaFmxTh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6lbQv8GWo/4h+Zw2s9tKD77q4xHUjRr4ABZ0wbM+Unf0vdob/csbkNRloc2bPf6PwumK796TU6NWUdFnU3gAcj+ys1I6vRBZe2YS0MNgDdH+rVw6a5kTnBApzdLtfDU8fjbtgdKNQcABCzI917r4rID4hytrvMe0uRzyBlU5LSFTnmirNhnnRhfYTxZXCnZmvd3DSSLwnfOr3YgnR58gpTbvXFCPhj1XANYlK2mzkJ4oKwgwYaXfd0OluntRdMogdnY8j1M0kaUP4puvzHG9x1hTimsBj+Wxnnz+W5h+6bpbHP84sLIsAZ5/duVUjqdNexKkCutGmeWHjx9yZeUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eefOj1H+xeOCB+dZxnpE//BsMec6Ad4Dc7xYaVTkZFY=;
 b=Va87yr1MT4xy/WJf3xn+NtVtbtnr+Pk2vCDhHkGsrhHgxI4lFTY51X6vZTgyETPTa+dGOpzIcDb8Pc0d/yDqgq3Tvrh1dYtryYBpQUcGF6MA13l8xdr/eR1d1OFUsU5QLlCHQ6D96SrnfWFy9el2U/XvC7gWY545Dl+Ds/ZvvVo/OV/aVcuX6bglclL7McmzdEHKTjKG5AwNh9cJuBEGpEGL8qslEaTrK02saTZ5JWuU+4tDs9r1ANsaYXAU9DTHHOALori5PDMAYkjcSaKL2bML94H4p35XWibJZrlQFFPwSYB3JTgCgmdH9HBsyHuAx954zhqFCmrcuAuqmPqTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eefOj1H+xeOCB+dZxnpE//BsMec6Ad4Dc7xYaVTkZFY=;
 b=rvaFmxThjvRRb4zIioT18HISGpatixkrKsT6hJiTjrlziCeUzEmfH+8WsG2mVIdmJjWJ3om2VnodsbiPlck5rgJnSg1m3gEXMXz0a0Oje5LQAvMz131ko4z1Gje6gxPnYgnT3QqpAW8cwyiJLybp2s5oyKevmBjCOe2TEmsnWFH45LZfjtfPnahYnyYto61vCeicIn9QQtoFm7HBylkQpuWc8MwrcCNa+7l4S55+c0Fb2jc8oTHy6kcs0gIkItTj3PtI7R7bCkz1xQFUgsDS3rTIvNV9gbxbU073Os97DODB3g6HiMszFsKN2IjfPaJChn/N0jDGWRewayZzfpO5XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 19:24:08 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 19:24:07 +0000
Date: Mon, 21 Sep 2026 14:23:59 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, robh@kernel.org,
	Frank.Li@kernel.org, imx@lists.linux.dev, conor+dt@kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Message-ID: <arGETwtIZxP3yOP1@SMW015318>
References: <aqwbBQUSfd60nVeI@SMW015318>
 <384c5f71-d5ab-4990-9567-027605457439@nabladev.com>
 <aqw1agBrSjYoy71_@SMW015318>
 <c1197d8e-add5-48b7-b0ba-a5a91379ab04@nabladev.com>
 <aq1DnBkxgF49QLwa@SMW015318>
 <bca6ea91-297b-4316-b5db-74636593b084@nabladev.com>
 <arFaPA6aeFey9WlI@SMW015318>
 <c43d3f57-8268-45f2-a654-a11ee4adb72d@nabladev.com>
 <arFlScBqnMDmJi2O@SMW015318>
 <abd334fb-22d4-4b71-9d44-4aa3c2789b79@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abd334fb-22d4-4b71-9d44-4aa3c2789b79@nabladev.com>
X-ClientProxiedBy: PH0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB8PR04MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f0e777-e9eb-40ad-f2a2-08df1815e7fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|19092799006|23010399003|376014|11063799006|5023799004|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Dp7duDi/Rjc4fi9QcOnRbIjyVKCFbyMBUJqkkjS5Iico7otGtFTSQVMY1CCgvMuFr293yvC/2we4ys2O5tYOwJ4Un8zVgfK7g3IfSk2qeyxjytTvlFIVmtew2NVEh713W9Qp2GPR8rVOw8N72Q2sg6mVSu7bQa08n/0cJfI/YUE4Bz3wQjoR1ebugLE/EwCNHRmBo5lCkRqXzmUN1N6o3PbYuL7vgHSnidxsCugIl2pQ3IOv8R95bdN/3hV7p5IQO6iOHLnwBe5UlL3P6yVydzS/rtVXcuW1eMyZ0rI0XEY1X+8LAClHrsE0YfgmQiekR8vBjoSLdXX/3xSX0s3FsYUByJUIdAep7BIBYJHQK6+UGQZmG1OtEREyz8E8PBTq013O3CWSdbC3TD+YRU/6u8j/waq33oux+avau73RZpr9qarPX+6GgHQy5KsRFReOsXJukbHfQQo2yVbfbI25Mxht0DuymEe6PZsN/qMuO7eR2k3n01/FZaV7Kr1xExODK08atgHvt6yc5+6oDxN3ID6rV20bdZCB7zoL0JhOEJpmO0NqbIBvbYKVqeuXXAmulndcFicf4/6kTCE7Zt+SA/UoO7tVmh0iK3YjOMoCsd4wbxKYpoxOtfZOh3EIZmRhZ79meSQLZvkYNtleE4NWsDyH72k2F6VtNX0C5uc/GQ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(19092799006)(23010399003)(376014)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x5F8nLK4htOWI0ZTSZbkRoqWWB+CdFTPxHF/ub8Eb7/prw9ya9UAYZDiEXU/?=
 =?us-ascii?Q?s7xP/P3/Cz9JrJWsB6R1h7EaWg9rXfOI7x1I6WB/oYKNdZjUHiN1Rpm7f2NM?=
 =?us-ascii?Q?Fxph3cQyZ8LIn4rlVFaFJYZIoorQ/4g+3NPv+0sNxU5lz5EOkBR6YCGIwKe9?=
 =?us-ascii?Q?8gVLlqZ4gZ/YA66Byi7OiedlrLbUlMNNp3sVYAOeOfZFhO4XHYJKqMQA92YI?=
 =?us-ascii?Q?YRTi0sXyUSMvYSDTlnY0cLXu+NHbID/aYDu9hGnaDEQPR511bXzwMqgkwIlh?=
 =?us-ascii?Q?eQ0J2tN6i3lTdCFhtSs6rn4EHlgzElUIxmGOOg1HlfmRG1bN5+YqespY9URH?=
 =?us-ascii?Q?pg/qinDyUHf9kYUDwebKDAoEZclpJ7m9nK+Zml/+3PQ+R9E6dP3qETXpOAnm?=
 =?us-ascii?Q?63R1bnFTSXOCPcX/7ynMbEaiqp7HwvSeZbsEdCy94FPbE3uuI+b5s88odAu+?=
 =?us-ascii?Q?xjomVOZg9GYOg/u/4OzJY3UzavbiVv2NkVTwVtb4ogXGXjzn+azkshhBPCKk?=
 =?us-ascii?Q?AqYzK1B6EJjQMGDAzcTyRoEUG+U0e9FBWgKX5TWoA9o5vGQz9UPICbSb3b9l?=
 =?us-ascii?Q?3SnaBtyIVy/leyjN9tveLQ8WWjctwgqhV10a7oS/W9onFc0SwQzWdX0FfgBM?=
 =?us-ascii?Q?eG54nkz691ADEhLzLeKfR0ZmIHnzkJQOpnoZYD2UBqrsoUC+4pVXSzVjRXfz?=
 =?us-ascii?Q?yw20NX3Dj2/wKGrv/P+rWi0uWisKoSsZv/jr/wZncYDW3Qlplk7M+IaHxWFW?=
 =?us-ascii?Q?E4XKmj28s/AEO2TKQ/k+vS7ZDCdGH16Z3zCK8YrHgqEzfgb6bMlodOoGmyfc?=
 =?us-ascii?Q?GigLILxz2mkVtVqjd27Yrfo+/orCxt0UfWyj0KsrajWQVJBMacp3Q6179DQq?=
 =?us-ascii?Q?jeUkYHBqku/jpoqpq+BRSo7BKVmGfniJZZlysFobJEFB/8GO+PgC+kU4XYwC?=
 =?us-ascii?Q?0Ib9CDL/kq34082fItkzlKdSyFzo9Ub9QiEId+W7owgNmV6LzjteuCRohT9y?=
 =?us-ascii?Q?7ArocujLQmO4RH2N+tu973am8LzFsniv3jgA21tMZUSSF0dNWCMGCTCqY3X9?=
 =?us-ascii?Q?kPS1pNrrgZj2KtxaCb2JzPV3nCR0mt9lUfEXIPGAxV0HvFjD51Ins90sp+s3?=
 =?us-ascii?Q?gc3sGCB+QhFrrcFfxRl97AL3DeS+p2DZ3Cjex9YUS+KEZ05+M3ayLv/bvso7?=
 =?us-ascii?Q?P/uKLr1mb10ylZ3Cz8S14JsP4UdwB9MGxA56So1Pz5/+wj3z4jSEgZ1hQQOJ?=
 =?us-ascii?Q?7ar/vEV8fWackZdhlcd8b1cfu92GbnkmbKw5jACDSLKJLaabrMSm7n20HWGF?=
 =?us-ascii?Q?izi1t5eXHQjffCe/ZkG7Se59y+hy2b3+FSIADGAGHeTkag+iUuS1mBPyKD3g?=
 =?us-ascii?Q?B+4xpbd4qCPXiUHE6Jq/6T2smqDy3OJIBXxetMPiBJtiy62hZQ7luAELFnY8?=
 =?us-ascii?Q?6KoMbwtyWXIZ/6ssYWbDeHv4RTaKhDsMJFiHwhP0e1BRkfrkzIRjpdGkrH4q?=
 =?us-ascii?Q?RLSjeFKYtqNC0ORpo3+jzdB9U3RGwhPq650BJMIsV3xXiSd3BXnmm2gEkkuN?=
 =?us-ascii?Q?EAxeDJjZER3BQwjlB+BL6J7ABmhD/W7EkTEUQNcl1U1h+KELZJTG3i/YVNUr?=
 =?us-ascii?Q?Ii8YhazOPmD2cq3n7LAjP/njGDpUPJKSICnNgIDj1XaXmfW5MukU+fXp2PXY?=
 =?us-ascii?Q?h20Lc6LidWJkplK2Lt57WuKDTa82OOmWgesv8jNx0s0ng8S2jt6p5iTdP2/N?=
 =?us-ascii?Q?KyPh2THToTNQMnVFLCfcA+yqcxsArj2AO9ETNNv647CuNEsvr85g?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f0e777-e9eb-40ad-f2a2-08df1815e7fc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:24:07.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IcIwNUTACs8MPJ+gWtTpj4Ye7Vz5d/EAr1LTXvXL8fsEQ4pyCF3PlO3VuQ/qRG8vfjwJtH28G1QHrhFVr7VciYzLIFj4K6dpiZFL6tfKrDsZALxguyQR1vySrgU3cd2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163

On Mon, Sep 21, 2026 at 08:43:35PM +0200, Marek Vasut wrote:
> On 9/21/26 7:11 PM, Frank Li wrote:
>
> Hello Frank,
>
> > > > > > But why DTO need update regulator-panel-vcc's gpio informaiton. I suppose
> > > > > > it is fixed when board design.
> > > > >
> > > > > It is just a GPIO, it can have either polarity depending on the regulator
> > > > > that it controls.
> > > >
> > > > Understand, But the problem is why polarity change after board design?
> > > >
> > > > If reg_panel_vcc is on added on boards,  should it be in dtso file also to
> > > > match your hardware design correctly?
> > >
> > > We want to avoid duplication in the DTOs files, do we not ?
> >
> > Yes, but there are not dtso file yet, I don't know how to share it yet.
>
> Yes, there is no DTSO, because there is no DPU support for MX95, so display
> support in upstream is missing (check with Victor Liu, they might know more
> about the current state).
>
> > > Hence, base common stuff in the base DT, stuff that changes in the DTOs.
> >
> > Idea is good, but avoid hack stuff. Can you show me what's plan use
> > reg_panel_vcc in dtso and how to share it.
> See above, currently I cannot really use the regulator, because of the
> missing DPU support.

I suggest add it when it will be used.  Or Remove gpios = <&i2c2_gpio_expander_20 17 0>;

Suppose it will be overwrited by dtso future.

> The only DTO I temporarily have in tree (used with my
> DPU patchset) is for the RPi 7" display 2, which does not use this
> regulator.
>
> The plan is to use it the same way as on the MX8MM/MX8MP eDM SBC in the DTO:
>
> &reg_panel_vcc {
>   gpios = <&i2c2_gpio_expander_20 17 GPIO_ACTIVE_HIGH>;
>   enable-active-high;
>   status = "okay";
> };
>
> or
>
> &reg_panel_vcc {
>   gpios = <&i2c2_gpio_expander_20 17 GPIO_ACTIVE_LOW>;
>   status = "okay";
> };

In future, it should be nexus node for it and put reg_panel_vcc into dtso
files, and looks like you use gpio controller add-on boards's regulator.

Frank

