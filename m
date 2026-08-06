Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011032.outbound.protection.outlook.com [40.107.130.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80A248F83A;
	Thu,  6 Aug 2026 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046874; cv=fail; b=Ne8VANQH69tuAzz/XC8UnuvU+84UXm/Cpr8EdyCgTtDcNa3lHaASfsSak2N/wSfqhbXao785bq2ME58zteMNFm9HEcsS7xD+zqldPqO2g/XVJKiAYGvFMrXyYbdJ/1PcSflSoaBb9xp9zPc3Hc9Os6uKdewXB/jEZj2Clhx0i9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046874; c=relaxed/simple;
	bh=NVJEUYkwCBrtANqYGuE8YqSI0WBcH/xgh5Gk5q8oMRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m+admm13PvaHybXhr3Gsj+9QjMiNSMtShL8szP7UfyAy8QsYE74jOCVrKX9E/QX4+cqoT5xs6MppUJz67XodZ4EHgodGb1sfMuwu8kWgBfTysm1kwK8vj5ZU3rNlQRoMkhSSxlT1/Rj8Yb1b5zb9vGLr4mG17TFRBzqbpS+PgD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R4O0xU2S; arc=fail smtp.client-ip=40.107.130.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R4O0xU2S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=If2FTL95hOjIAcMjH6a3GHwyr42n0z4k57RC1XTAUW3CjYQPy0cERKMl/mtL+/SssY0Lvd6fAWlfb2TTSiArVCsrx2HqQKPh60tqK5AJrgS7+yyj466hJhrPzmkUyBCQ0kgh0Yqn8Ib58vikIl3sVe7yofjx85p7BrCAxv49XtFZthMPFYTGOhIVtaJcUnXRGnpTyynvCQAgfariGtfcsJroPOan3/00rz8LpIp/FEBKxXfxLIZZMbGWoXgcv/kvrRKfUBVboroONKqGSG4/mcGYq2Swg/Zwk0f7Yuz/PsmbEMk3ZI7Za2kFlwnj0++MJ41umke5YHIDhaQcy/awwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79M1gwo70h2R1pbW4dk8OHTqnkhNC1Hehr1kfuE/rYg=;
 b=OLpOIvdrf+qEmDp8M3KWyBvowchkBfEIrG0BxR1qFr6yQoa/aLR7GazVFS2dOfy5r5RWACCK77N6PBDMuxV4NCUXkr0GsP/01+H+beDT1UMyjycljP4/RiHGiQlgQjjH6dMpSciKsB0577WxpxmDnD109J1OxwsQPrwa2rVCNKvBdizj6JR8/IJCeZLV4j8bB5e5rEFrqbQyZJklyX234mBhnCX4BYlCpDGG5qInMKcCAo3o/8Iupz24AM4/0Qebx4xQn672zo6FkDb5qDMbWkyeH28wDJYpvaCRvsDL6cvAYpLCNHYidaq2WaQVvdGIJ8xbKUzA3bTYPAhud2AlfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79M1gwo70h2R1pbW4dk8OHTqnkhNC1Hehr1kfuE/rYg=;
 b=R4O0xU2SyNQKBtdFQZue66uzsUiGghtwH5RZvXwMmQlQMKDZo4elu3P9YeQZ1cciMN8C4w4uGA4NGb6G5knD0wWGzRcTUpkD55MKqG8zAE1WLc13Y1gYJQk1S9qvlTF6uxbAQdPFCVo8rf6ZtydM0CLuBJKB3pijcahuVuyFCoqfh89ETejeBCrNO12W8gXf6FwNk8Cbfhg4P/90O4rcMhf3I4GTOFt743ZAWXn8E5NhxCT8IHGCwYnuOk22PrJecCOfBVnA3Ozd/JPlQ4oME+Y10BgRPP31OQEmYfz9DEAKhOBiScJA5lGEZ7F/GCU/jrftFKAlWXCC56DrmEqBig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB12002.eurprd04.prod.outlook.com (2603:10a6:20b:742::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 20:07:46 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 20:07:46 +0000
From: Frank.Li@oss.nxp.com
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	haibo.chen@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Haibo Chen <haibo.chen@nxp.com>,
	qijian.guo@nxp.com
Subject: Re: (subset) [PATCH 0/3] arm64: dts: imx95-15x15-frdm: support CAN transceivers sharing a silent GPIO
Date: Thu,  6 Aug 2026 16:07:36 -0400
Message-ID: <178604677653.439551.7004828276697704665.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730-can-share-silent-v1-0-63fd603f943d@nxp.com>
References: <20260730-can-share-silent-v1-0-63fd603f943d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::35) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB12002:EE_
X-MS-Office365-Filtering-Correlation-Id: b8463260-b2be-40ad-b678-08def3f661cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|376014|7416014|1800799024|921020|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	l8JW7Pc4uAObFl4EQOd/aw7ZVWlKiqLaBvi/1+LQROYb4HC8SVgboxAkMrBEOrdY/VVoRm3kc2R8JAj3UMajzXk1QqM0oX9czgPGhEwTlTEH+8Tj+pBBP6ducaCu6gqrkbgjChk1ef3Rm+sVkd8h7Y4jFT1HK5usdFdxvwo2Wcynsscl8uMs43njVG3/1ZpEpxUQZ14m7TV9WeTHv/4bxf0Pw+7fcWmkBLBliFMPO0OFytNueqErXYBlsf84xW9qWT12QncqUmOvpvK635RjB4VvkZ0ZMUUg9NVPOXI2KnI3OAwfViHYd+r2D7BgbJUYnngLgfWrAoLX55xPXUb6nRl+bXZ3XSm0DbzMWTiUPgXqRcU4T0RQnzWEAxZUqw2nZsGZbUVtFIg+omf1cJjI2YfnqIzlExBysJEM+qohWy9wCXz/fw0Tfs1HaQF3VX7TmRcITmjMqOJpayEQOwiXMCmRQwOBgO5QOcqb9gRGLZf2wovwLIbznv3GQyygUwHno3IVb4xbqqar293PuGbi8yOOZ/KqGuj5uxrpomp47zUinx4LRIGGw0iIfsCrLsEBOMxaP7co7TxCR8SkLUH/tHoX5nmPQlKQMOQrvEfBkc+g9axJJp/k4aGcaebvpXNro9Rh9vFhSk2C660HYzt6haKQfvYBW+sXc2xjCNarcbQqh0zBr89erHKhL1oQbQ+7BJ+Jw80e7XmeFONM3macSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(376014)(7416014)(1800799024)(921020)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U29JS1NyWFdJRWxpM0FnT0ZXSU9oTHVzUTFaTEdGRHdXUWxHLzlvMjcwMG45?=
 =?utf-8?B?VWxJelc3dFpxQlUxUlNseEJ2SktYUXBBOW9ZYWEvRXZvOE9HSCt2SVc4Z2RW?=
 =?utf-8?B?Umc0TGU5MkQ2TjdQeGl6WEtORmNNSGdtVW9UOVZPZ3RleUNxazQ2MUE5V1VP?=
 =?utf-8?B?R3FEMUc1aUVGaUhzWEhVVzZjTEhLOUEvaTdpZGsyTlJwK1l4WHBHU1ArYmtR?=
 =?utf-8?B?RFZwWUVXR1gzbk5CWVdrcHF1eld4ZWkyaTRGYk1OY2VSUWZIbFFtZjJnMU15?=
 =?utf-8?B?ZFdZbHM0VnE3K05HaWNNNFE3cTBtUHdaaUhlWTM1K1BpdXMwQmJXSXpkMDhu?=
 =?utf-8?B?Rno1c2wvSFV3NGg4b1JYazNPQUdjRExvZTAyTHpLRENSc0I4czZqTWZZNGh6?=
 =?utf-8?B?STRjTnRFMmJFL2dlN01xQkZuaEVid0pib2hRZUlrS2pSS3VrOGFkcHZWR216?=
 =?utf-8?B?YUxwOURuUEtxUmltS0ZYQkhxaEgya2JBbjlocGRIUFUxTi80a1BleFNHR2Zs?=
 =?utf-8?B?Ry9sVlJqL2IvcEt6ODFPTnJ3S1NteCtFQks1V29QU2RnZUVTbFNoRFZsZHFY?=
 =?utf-8?B?MFZNaG5oUEtjakxleVVLZkFMV1lOUU0rMEtrVkNxWXRqeHIyNmI1YWxXVmhV?=
 =?utf-8?B?THhySno3Y0VsMkNHdm1sNzVVRDRIUEorNjhVYnRkMTFrZVAreGFTbUV4d0Vn?=
 =?utf-8?B?Tlc2VW05T3lNaXhmMjl6Mm1FWUJ1dDU4WnNmRmU5THo3aGEvSjRkSmpZU3U2?=
 =?utf-8?B?UnBhYkt5Wnl2UVRFQjg1Vk9tbWN3cWdlaXBzOThFVWthWDlwV2NzQnFJTlcz?=
 =?utf-8?B?Wjd4Y2huMVo0aFloS3padDd6NFRNOTRqMjZTd3Z3Y0hJZnM5UytIOGMzd09y?=
 =?utf-8?B?RS9zaHpMN1N2MUczOWltNXZyUk9ybmE0YlJsaG9oVTFWWk9MeElBb1N6RXlO?=
 =?utf-8?B?QXduR0VzUDlnamRJQnh3SExYdWZGbGVoRjFxbU5vajlJMXZ4UnZjK3lQZlNU?=
 =?utf-8?B?QlV2SWg5dG9lWkN4a3RndVZjVjdvMVBJMTgyRlIxM0phTGRTU1BhbDZmMkt1?=
 =?utf-8?B?cDZSQ1B0ODdjYzh2MTV6L3poNWl3bjlCZ1JPQ3JsTnlwSWlhR2NmV2phRE9E?=
 =?utf-8?B?czNObWkwOXhOSWYxdllEL2NmM1NwUUdoR0h6YWM5b2JGY0JQSTJHQy82VTkx?=
 =?utf-8?B?TzlQN0NuamdIcGRvR1FxdnhUdFdDZzltck9EWjJHS3Vua010NklrQ1RFTTZ3?=
 =?utf-8?B?QnZ2elRNWkxjYmxpV1VyZnFMZ1o0WTVIY2ppa1ljK3RzQVBBVENoSDRneVMr?=
 =?utf-8?B?bmNqWFBNZENTc0VWNVBWTzlIQ29GMWZDWHNvOTFKOGpEK2krUktZVW9SU244?=
 =?utf-8?B?eGk4OVdMa29WSytETDcyTDJIYlkzekRNQVJhSGk4cUdhKy9tdDJPZ3VIMDFB?=
 =?utf-8?B?NHJod2pPai8xVHZJaFB2cFN2TXFwWkZtZGdpWEN1NDZuenlKYklramd4TFlS?=
 =?utf-8?B?T0JjQkxveTAwNUd5TXdxSHQxcHhOTGxlV1ZRUXRvRG9JcHBDZE91NEFhK0dF?=
 =?utf-8?B?MlZVOG1RY3REMUhNMjJsVDh3THRhd21ZSVpNclROWFdybmI3cmxpZkJpVW9n?=
 =?utf-8?B?SkFhMkI2bUhoSnRvU2o1WHdvemRjSkdqQldDVWRlQ1ZjOUcwN2NYbFNPMjlw?=
 =?utf-8?B?SXlRczFyam9reWFmZ3hMSlU3MVNDTXpmWjJvc0NyYndyeDhOdHM0TDBxMzUy?=
 =?utf-8?B?WGN0clFMWGFqRXUxeG5DaFJFQ0VBU1JhdXhCM1NUNTN2Um1yZUxjRGltcHpk?=
 =?utf-8?B?SVlkZmR3SGZCM3lOc2dLTkwxczJvV0Q2RGhGTDgrUE91VFpuaTl1aHRzenlk?=
 =?utf-8?B?Z0Y3aXdOakVFOENDL1dBMjBHUFV2aUM5OHpqcWtRWXUxVThwTDJkSmFKVi9M?=
 =?utf-8?B?TU1TbDRxSjUxbXFweEdHeHF5VktZT0tXbk5GZS93OVVYV2pOQnNtemJPOWIw?=
 =?utf-8?B?dW5PNVlaUG5pak92Zm0ydFdybURrTitZeGtvcVY2bS9LTXphbWs4SDdQbEZt?=
 =?utf-8?B?eHFvc2RERE05OWRxa2VaTjQ0VVFJQWZ5K29Ld25QSXBaYzVwbUpuLzVHbTN3?=
 =?utf-8?B?aU5YcFk1NktIWnhRT01pY0hRWVNKbmFUV2JXNll6NWFJeGhndUwzKzh5anRo?=
 =?utf-8?B?eFBkY2RjcFRVZjVxVzJCZWZRTkQ4QVZuSWN0T2dOUC9mbTF6YzFkbHNTWk9E?=
 =?utf-8?B?OWoxMkdqRkxQUXhtTE9iejd5NkI1ZWtERUV4Znk4N1dhcFdnSGhsbzNmNVhO?=
 =?utf-8?B?bitzMVZWdk41Mjg0SWg4MlFQWTEzTVVMNHhPWTN2M1FsZVpSaUsyNHQ1bTJY?=
 =?utf-8?Q?SlxVd0c0gQinLy7rl0o6QeFZ4odwIAeDfD2co?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8463260-b2be-40ad-b678-08def3f661cc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 20:07:46.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWXumWxEoc8huvH/I2T2pQdi2j6KggaCdQj1/jRmBKos0IqibKc+BlFcy4W9gHa2ijJ3gyC3+iDWYkPImaAHb58ilw+Kh5lfHBFScLLHe0lVCmjpiLemn0kCwuSe0wFf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12002

From: Frank Li <Frank.Li@nxp.com>


On Thu, 30 Jul 2026 12:33:25 +0800, haibo.chen@oss.nxp.com wrote:
> On the i.MX95 15x15 FRDM board the two CAN transceivers (attached to
> flexcan2 and flexcan5) share a single "silent" control pin, which is
> routed through the on-board PCAL6524 GPIO expander. Both transceiver PHY
> nodes therefore reference the same GPIO line for their silent-gpios
> property.
>
> This series makes that sharing work correctly and puts the transceivers
> into the proper default state:
>
> [...]

Applied to (imx/dt-indend), thanks!

[3/3] arm64: dts: imx95-15x15-frdm: fix duplicated can-phy node names
      commit: 7a6460ea60c5dff7240c6e3bc307aee252fe0483

Best regards,
--
Frank Li <Frank.Li@nxp.com>
