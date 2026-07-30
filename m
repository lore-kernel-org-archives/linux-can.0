Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011039.outbound.protection.outlook.com [40.107.130.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E781339F18A;
	Thu, 30 Jul 2026 04:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785385855; cv=fail; b=OSng/aDTKJsvUVxFWb1aKgJslx9s8pCBpboQUHDA0cA7qavkovdrmhe2uDsEQtK8PJAjLPPJiXvP6fpNRc2vL1XPkSEqrTapJ5VLP70tyMW1bW2fGYSSo8lNR/Yt1UJBzTAtB33SBISsBV+IGMQTllLQAvBAkcqjMsR6y5Mh2Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785385855; c=relaxed/simple;
	bh=OKyAWvghpmmUFGhAJCSdEhEO2TJvatrmlPzGhTGX71Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mcrXp07yVN9K9DO8BOlkrSKCTHMB70r61HvCAc7TYFxHB6tlczKa23h3fYYw6LedUg4t8RkOVw8gcet8wrWYTzbs6wr9iK12DZIqYdZDsfFCU7b8ELfVXqV5W6Y/iMu9dHFK2V1Xe74697oilXq1qerYxgPKIdZ+yD4ExYRTj1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wPz55pag; arc=fail smtp.client-ip=40.107.130.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wPz55pag"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiVgoGtVJxEnRiBql7QlwunDRes6PlS9rRG2e+O+AiNPZwwdYRsuFEDqDTznG9SflTHKyhYY21+EG5dY1N2hDforfvklV98kGGuLhi9oGscfVXkvRYCdealsnJM4JtQ/9Q2T7wvWH94OubR1ZnLrqbQ8jj+9ELwlokjz8GzUiJmVqgB1iIgF4KXYnl8FyVtSHw2Q5Wdh6/KRxHiyGk28dvCXaEfgnOFA7kZv+0amRbmtc7VSem2P38mXQbdDEmukEpGbOSvRpbAZMrBBq0HiwLIlFLWwgtBjsI6MYg3cwH7keLTiFNu8QlQ+TOsWFO9DvSPcsLmIf+LH4GMD0FVimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXh2HrbKb63EwCLsoxEbFkfikhrAtqW9gD19zGQvGjM=;
 b=Brv5SS9yxO7/24Y96Xqe41c1Nnm37ldorGX9i+IiChqo33pKmpPC0+RMw4ERRvY4GCaarpLZift9DLOY4SfAjzQGGHFLJQRpJsc784cIo7GW1tSXKSX91S2nwzNOcEPJR/ijh2gWqTlUB49cxxvODE8pjyCwAutqu5ZqIstlOfondgzKK3i/upT/2OefqZI6Q/r7DtV5viPw969Aur8lgY5SMOLOeOoXsrIFWKanZ6u5t6q1sIEOOqrfuVDbH8Jm+LiXHWET0DV39Rps9cEXxcuEZRd8owDiIgMtFegdlbqkkjAspWj6WRTtmoRk914AVaVrRDJUie90aD02IuNkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXh2HrbKb63EwCLsoxEbFkfikhrAtqW9gD19zGQvGjM=;
 b=wPz55paglojnq8sHZW3TKCTM3ogZAfrFLI/mwwX8fJSaFxhaTrToTM2q830qFIQ5tG+pXGUOSzuolM6kTQ86gFgRkvvCCxL7GQpZ5JZYs2USYEkm39JZO1YUUbBhoS1MrDGaOkRN4WlD3p8CGWI4WVYVYxdBYD9UTJBH2MyUu/nWIOPHRWpKObm1STzsiQFeMwY6Ct6XUjgCeN/pDP4Yv9S804oZkg8CK73FDK94dWDTWe8bvkBpAZEfCNhXFwO8o9E/JaM2NTli0hvWGPiv8oY5FrQBwRxDfg64u3JYQ0MRuPvDg4Dc+dYxyhghW24BGCuJkXM4SYxOzxyrQssSqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by PAXPR04MB8239.eurprd04.prod.outlook.com
 (2603:10a6:102:1c2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 04:30:48 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 04:30:48 +0000
From: haibo.chen@oss.nxp.com
Date: Thu, 30 Jul 2026 12:33:28 +0800
Subject: [PATCH 3/3] arm64: dts: imx95-15x15-frdm: fix duplicated can-phy
 node names
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-can-share-silent-v1-3-63fd603f943d@nxp.com>
References: <20260730-can-share-silent-v1-0-63fd603f943d@nxp.com>
In-Reply-To: <20260730-can-share-silent-v1-0-63fd603f943d@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 Haibo Chen <haibo.chen@nxp.com>, qijian.guo@nxp.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785386048; l=1270;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=7uMvv4Dg9dy/srwn7HISIR435FWQXJfkNeQC+ucvX1A=;
 b=Ck15RlYTU67cI4RaZQBInmybj7kpvJvWKct1oXzR30PzAJK7RmOk6SsTisRc8PhBsOD5u97xL
 P6hECJMNknUDQz7eMQa0eTuvhxThg6pmOt2KRIKQPwIJbcMgyzipd/U
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|PAXPR04MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 625f4de0-fc23-4633-6f8a-08deedf35474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|19092799006|376014|366016|23010399003|921020|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sADyB6Tww6sa5gI6Cz7sMrfUFw/4bRUoKs7jwGZXLTpl3SA+wHQKo3sdaoZ0Rk7hMTPPB73YIwYbw/SahayIzmFjhsx7HFanMKQt4HQ/uqcrlDKqlW5ljfzi5V8HacFFQDUSTEZdA4ofpfukaEyuPsaKL50aFqH9tLL8QvOvVi423j4/Wwc9QO8eErAHyf3s/jln2xS+CBLc2+l7hbup3q6R5+dxyTrAkMvg2AC7iqG4ADMxxELgM8m0VPXcqpgjsRxgtJv4mt2GKfbuG/4LEJv7XLbA9HeM4Sq3iSzo5y4YUbCn+ZZ9EtMSlmy0IPKeM6QXqgCwuAb8cYihFjF+mh9CCjF+zeMX/B7vyk02zLJzwNgEUjg3pGkXzzIzB7xrlU7/9bNg+uF4xgPVUxOpj74ffxyynRHMhlEIkkfO+i5Uu5nMRHFQp8C3qzQBFAWQoQB2FzIQav3WWf6MsnfuipV5EL5sK1Uq1qW0He0ByXQ8bSbG3uYuDNrHElwyDT5F9mhU7KYE4Smauz0A/oOFnBRCaFUzIUwULZKlnI+Y+ZNrtvpIcSh2te2xyXKp+TcOTI/yUDJFsm09elRFSO4fZXhierjDSFBB9A30bAJD3U/zM+1wV7F1bblBVVUkxD7gff/Va06s1fMbTNIIuHpfdqbEbzeMVCYBdb0mQwNW7CKFSVsMYEQMIAh10PgfCNfDO2DGIvsEZGdemU8K3fJ3GA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(19092799006)(376014)(366016)(23010399003)(921020)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGQzYjBTRWc0enowZmJTOVVvVVd6cklXalBySldJb3JtVTdqUjZqSWhMQ0sz?=
 =?utf-8?B?K0lKVEY1clNzM0xUejVjMGg2SGhDNFBvUTZyYU5XTzh0MFZ6QWpvZHpjZjF5?=
 =?utf-8?B?QXl1OFJVenl2WGJaVmd2eXhqbEF2Q21vRzJwUVFxek92c3UrOVA2UmlSb0dl?=
 =?utf-8?B?ZlVLYlRwalJNcm5tK1dvQ2JpeTRmQkdlVWExREQzK3ZYK1dUaDdTVnZuSnhN?=
 =?utf-8?B?QzlVWFZ2eFd2QklueVpzc1NwREJRWkZWdDY4bGlvYy9TY2tBazJGcVQ3SEIw?=
 =?utf-8?B?aEh2bkxvMGQvNUp2KzZCLy9WcVQ1KzlUc29ETU5UdytKSUl5YUxDQ1ErOCtx?=
 =?utf-8?B?dlZKd0JVK2hKcXhLU2xJb1BPTG1pRW9mWmhzZGpZajYwaGNMT3hESlN1Zmww?=
 =?utf-8?B?QVdLRmJwWlo5Yk01Zmd4Qjg3bGJ1ZnBwZDNLVVBpNDBnb2k5UGpWckJ6UE1w?=
 =?utf-8?B?OExoYjNPeTFJaVI5TXNtR0YrSzNBbm5HT3hYeWxJRGN3aDBvUUJYV0plSWNB?=
 =?utf-8?B?MktrWFphc3dFN2swbFMwbFdWUzVNR2NWTnNmVGhrNEFxcXM5TUlOT1dzM2Rr?=
 =?utf-8?B?djZZUFlVMWdkQWdFVGVPLzlJRnZZRXliaVFyL2dxcytUWENiYjVMYld0WjRY?=
 =?utf-8?B?a0loOWJLZW1JZnh1Z3Y2TTZyWGFackFxS3NNSjF1b0ZoY3lRc1B6eG1jU0ls?=
 =?utf-8?B?SVhBNUpIcWQxZUxxTVFkRHhVWlYzbmcveG5ZUm16RW51aTRIVE81RUg2MzBK?=
 =?utf-8?B?YzQ0SjNIalhSVjhkU3ZrT2xuWUZFMHd0U1d5TTFkSEtzRUpyN050VnhoZFVo?=
 =?utf-8?B?V1BPZ3p1bGJRV1oyZ3lwVmIzdUtjUHpsMkpIcDRIU09aWHp1L0Zlb0U1SSth?=
 =?utf-8?B?cllaVnVyMzBGbHlWWjRuY21sblZmL1JET1haSlQyTXZ0VWU3ckE3a3ZCM1ZU?=
 =?utf-8?B?WFMya2E0Qk5FNHd0SHNBdWh5T0ROc0RUaWtuR0g1eHhwU1VDTHlPVmEzeUwx?=
 =?utf-8?B?SGNoRy9KbkJkeExxNzZJOU5WblZTNkVVdXc1MHM0ZEU4cUF1Z2pPZkFKY3Rj?=
 =?utf-8?B?RUs4VEdMcFVFY3FoYzFvSVJJMnVLS3RMamRaWGlHZVFPckYvMElrSUtYb2ZX?=
 =?utf-8?B?bHVlaGZYNTRDR2VhNW0xSXZRUXlBQUlNbkdrL2VQaldDdGtxYlZrdTRqSGpk?=
 =?utf-8?B?VlFLVVM5T2lRSXlCc1RGMWZLWFlVSlQvOW5aUWtQYVNPN3o2YUVmZ0o1YTNx?=
 =?utf-8?B?VlRNU0R2TDhGeTJxTjRNTFFFQytqZGUreXAwYXpvUWFpdDRCVCtPa1JVU1Fi?=
 =?utf-8?B?c1Q5SjNkckxWWjZRQ1B5VVpRbEJYUTVuZTUvRU4rdzBoSEhwTUhlZ2VoLzZQ?=
 =?utf-8?B?WFhNam1DNE5uZWZ2dHd0SnN1RzlldlQrcWRKT0RLNTVzR01ZRXhpQTZvMU4x?=
 =?utf-8?B?Z2dwQ0txcDVDYnVyZ2lzcGxRUnpZNXA0Nmk4azl6bzZvK1Z0TU9tVXZPUE8x?=
 =?utf-8?B?bk9taldYbGtYaG5NdE1uRUxhVzE5UHpBNVVncS9heHF3SUJUaFFOcjBzRHZP?=
 =?utf-8?B?NXpvcUNhRDZGNVFNbWF6UThKcUN1S3hzWGFhRndvWUxJZU5IWlU5V0JHUU1Y?=
 =?utf-8?B?RmJZNU9OdXVvVnNqWld0QmJGNEFjaWp0c3FlTmRTWTdBNEJRaSs5c0drbStO?=
 =?utf-8?B?TXV6U1VMVE05dnFBVzJDdG9EWjY4TkkxYzZCMlJFZ1VSQWhkdlRBN2FtRG1F?=
 =?utf-8?B?bmN6SlpqUG8vY0lXbEw0MFp0MENyVXZGcDVSK1pYYk0wSWVRU1EwemJrSDZz?=
 =?utf-8?B?OGZpVVNVQjB2NzFyS1pHM2NMWjlIVDgxRFBLTGszTkErOXFwRzBRWGN0WUJ6?=
 =?utf-8?B?OGJhNXByaWdaemZxMHpYK3Y2R1JRY3Y2bDRLT1lFRk4rcVdBMlJsN3RwZXJx?=
 =?utf-8?B?dDQ2encvYlhmeWJWOXVKQjlDbFIyWEZ4Y3FBaVhXMTd4SFE0WTdGMlU2cXhQ?=
 =?utf-8?B?VmFERFMrMS95SWJ6WVNIaVUrYzd5dXV4YmJ4VEoxa2RsL25yaThEUWJMd1Y1?=
 =?utf-8?B?OTkzL1Z6cktvT3JMa1F1NllUTlQyTUFiTCtPMU9HMGJDSmhoeUZKazlQK21a?=
 =?utf-8?B?U2pHWU9MVE1UL2NNMWpaSkJacHcrdXBZUjQzNkZJS3hTcnRwcmFEaGwwRDdz?=
 =?utf-8?B?cllMYkFuVGx3cWcyNy8zUXA4bDhiMEhhdjYvMXdra0xPTzdNSktnVThwK1RV?=
 =?utf-8?B?VVdKdW9jempRdjkxbzRYenJ1cnBlNzg3L2NHRzdmV2FScDQ3UHN5ejgvbEIz?=
 =?utf-8?B?eDNSYzNHNTdpMzVkZW44bHhNUkJ1VHhKM0cvOE91SEdOYXljaGRVZWhBbjhw?=
 =?utf-8?Q?WrqchK/wDMgFV0bEoUl9fBcaelDDoWBkU3d1v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625f4de0-fc23-4633-6f8a-08deedf35474
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:30:48.3893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kx8vASO4c5a2fe72p9BDhYA0aej2xc0/lHHtftfviestYzRufKC8bZjtjp5LCfNSPawNXtCcqNstyhvyZUapFmDwo8hV8bYR8J/mPI7mDMz8HF3QePiJ2crmYOoIsvnq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8239

From: Haibo Chen <haibo.chen@nxp.com>

Both the flexcan2 and flexcan5 CAN transceiver PHY nodes use the same
node name "can-phy", which results in a node name collision. Distinguish
them by using unit-less unique names "can-phy0" and "can-phy1".

These two CAN PHYs share their silent pin, this shared GPIO can be
handled by GPIO shared proxy.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-frdm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-frdm.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-frdm.dts
index 0f43e3be70589532763f65f1699f31dd361cc841..7ed9ff978432edeff4198f189247a154fc1016b5 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-frdm.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-frdm.dts
@@ -56,7 +56,7 @@ dmic: dmic {
 		num-channels = <2>;
 	};
 
-	flexcan2_phy: can-phy {
+	flexcan2_phy: can-phy0 {
 		compatible = "nxp,tja1051";
 		#phy-cells = <0>;
 		max-bitrate = <5000000>;
@@ -67,7 +67,7 @@ flexcan2_phy: can-phy {
 		silent-gpios = <&pcal6524 7 GPIO_ACTIVE_HIGH>;
 	};
 
-	flexcan5_phy: can-phy {
+	flexcan5_phy: can-phy1 {
 		compatible = "nxp,tja1051";
 		#phy-cells = <0>;
 		max-bitrate = <5000000>;

-- 
2.34.1

