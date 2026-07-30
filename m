Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE539B95E;
	Thu, 30 Jul 2026 04:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785385844; cv=fail; b=id3sO0cZsSQX936px0Z9Ww/EiHrEt2vxlGs7eR2xuNs9OoLNLWZZnpdkX0iaMgRGDrv8h3iNNrgYE1yk3yzhb/qMYbZNhZT+EjAhodJuNCmOxqA6wT/EkzfEW+TJZqfeSkyuKZwLY+mZZqL0RZ5M+e6biNFC4sGWcDOlsxsC95Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785385844; c=relaxed/simple;
	bh=mc9cz9esnxV6Ce3uckmjCjpS/qklc4MTpvl9Ym0IwCw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hPb9OYT3QIc7MadisTcTd5e1ZTXQniwCLLeWs75ErsLd4NuvDoZJYaETmI0AybCJNZHsArjz7Jqk4wIO51yOjbHWmtxC8kra9eJdWDSan7Zgt0O5TElhZOhU/5fwLdoZLHwUHXHPs4Pb7IV5CPd9OnAjl+6YVzb2v3mmTYvHrnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=k51b/PBt; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="k51b/PBt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l40pJrpj8ZF1/8edE3FBHQkvru8LUafhz2wn9l4Apyv2BiHnm+c/fQH2vvUfl4/3f9LCgk1wUycZ9yOoqZlb7kXfhiX2wVoyQagDwbZeiXVtmYPhaoanqmjewfcVwt/NYdF2y1vyb2pGWFfMUjQ0vqiWqc/TzZQxW3q+ZJiy1vQ7CMTls6JdLhShy94qajiZrx9+a91CMD890Ndq0f8hK0p93HbeBrYvxBd8vk6wRToSmjqssyHzImt+iUqMva0hVNyREsHGVZzQSUMtG6jQA0sVvlKl/SlSi1zi/BUs+ukUBxLFd9JpGi2LQB707xgiBCmHcUPUi+ipGe4Q/7evvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6r6LoFcjvAdwwSCOiYebLyD+Fd56qhid8W6j8lHMRs=;
 b=HxWtUrZkQgYQK5uktsTOQ01CEP2GiN7KWUYH+6+9wgilMvHN42lLk289x3NhE1L8SlUt+lx1Yfd7u79hUsYRbFdJYf3sxkV4IIz5q7mnxdhcjD55PFlE9FRAZbJJlMQRjW/aSOSSC+N91j32aUZUqvX1J4LnyArglvgZL7gmqGOuObeBfDytvHw85lo2nPfP+b5sESVeK2buPSsrmYMocynmAFSMP/MGdT+iiKDCBG+OTHeeZWzi2VqCnhBWkxsA6+R+3gyVzhEEugp5eqy0q3zUF7plYmwSk7BFZ7ZadDqgzh9o5WDtTYMi3XmQAN2Embk+9/OR4+hTS7nnZrebqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6r6LoFcjvAdwwSCOiYebLyD+Fd56qhid8W6j8lHMRs=;
 b=k51b/PBtUpIXxgmaLc2uKkRbPjejk9VVEftmc7JLzm9s8U/zDY1x/naDqlcWKFQMneRP8QkbvlVyRCiELRkuelSgWubtQScPRK/YMlIDPiE0SZYkZskopAa54RP3X3oO6Yr873c/J0ciGvr9N5o9v3nIZKIkegSqLQN6hzJkU0aBPBmj8Jr3jK/B4IjVluyb8958YL5GrHJzQ9l7A1xlzmpQjeTQ8IYsryiKiiazD4RY01teterXfwfv/ruivvz5/RIApvviNa/buslTeKKJtAiYRoQh9ZlNcxA3zLr9aOXUuo5LnyRN1+mNypUyUfuNr4ldr2+v4MftluhrlsvL9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by PAXPR04MB8239.eurprd04.prod.outlook.com
 (2603:10a6:102:1c2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 04:30:37 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 04:30:37 +0000
From: haibo.chen@oss.nxp.com
Date: Thu, 30 Jul 2026 12:33:26 +0800
Subject: [PATCH 1/3] phy: phy-can-transceiver: default silent GPIO to high
 during probe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-can-share-silent-v1-1-63fd603f943d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785386048; l=1514;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=4yWJwBFIygvyvEkt+rPfyqpK7T4Slssbx6llhB5ttYU=;
 b=Iihr55fovXHn0uDrB4fcu/dEyzY7kxQAa6Iv2rRayp+0wKMo5bdNYB7Dc9gnaLK8YWNLDg65A
 Qyfc/BPdut3CugiJe7za4kj6/3xbn7+bsVkybzqEahsUdLCFfdEZRjp
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA5PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::9) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|PAXPR04MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 013d351c-7112-43ca-9fe4-08deedf34dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|19092799006|376014|366016|23010399003|921020|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pT2uvN/pUKrtRdso2xuYH4JJk9nPwF5xIPHk7nN1RGw7LClwMeR0ty8vMLKKEDgRZ0DmSTVruoosI+/s8YH/QEH7Vm9emGbcWtI4mI/OmWn8vvq8Eeo+2ho7IUt6/VztOfB3P2TyK0nJOkn/8eL8mqEBlIKqip0cXhOi7s+6dGNYE0fsuSeS5kOdI+9WnpSpwAQ2Lw0KUrzf0tpC5LRIkX+L5MEEZa/emw3aSsMq0xlZBHcoNf3MMjgwJPz2h9dzD2J/BfEf2q0msg33Pwhf50RABmRxPQOb+vWldhjxiKQICa0O5QsOOZwBa4/vaiyln+3/XP2Vx/blzn5jqT10CVndb3a3PePTlHBLSRw3Fj6ygIYHurNRcbuI9iRMqrtkGTrq6UMOrRnV8fgRf3oefKqNRhn7/ybFnIRAHs5YKIylYrY91cRN5EPgBLt/S2mFMsfJo5lWCa7gr3cP97FcPk/0FsYIuuK4rM+34hoUWKaIN2PFEMMeZglGpVzrShozogOQfTO+vMkFVTbeCgJiboS/EliwUaIfC++Z6qQDYjKNh35ajNap8BjW6wj46g+qjcBAinZsk6gcLalbi7cNin956KmdbFZTTogH+eBeQaMClJqCDcceAiYePHIDJPTBd2bBdzuepU7lqmANV2lTV7oxYZW7uNvjsMf/FDeau6fkvlGy4vylaNT7tAsckoAGxyy34r9Wm++6QOpkP+Mvaw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(19092799006)(376014)(366016)(23010399003)(921020)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QllqNWhieVJYMkV2NmNpb3Z4WkNVRkxKNG1zOHkzV0ptZjUrWThSNGhrVFp2?=
 =?utf-8?B?TnZXZlYxaHBGcWJabmtiOVZmUjMwdDZMMmZCeTVGYjBjNEUwcFdKMU0xZFZP?=
 =?utf-8?B?Y1FBRWNmSXFWRTI2ZW9CeGVPalRJVitkUlA4YWVBQUdjSXhqdWgzMHJ3U3VP?=
 =?utf-8?B?bmhWTThiYS9kUXlyb3pRNlk2Mlpzc2p4REhIUnhqQjlyZmVNRjN0OEJWdzlv?=
 =?utf-8?B?QUtHRXdCQWpGQTRWWGVGeUdnN004S00rR0FhZXVYQ3FES1VtSUxQM0ZBR3Qr?=
 =?utf-8?B?ODNVcC9NZVZ1Tm9UYkxQaVlFQmVheFpkT25EVW91ZktPWFhodDV6bnZiY2Nw?=
 =?utf-8?B?TFlNbS9rTWF3bGZ3aDA1SXFKRUgyTTVQK3dJU3JlOHQxblAxc1lYbmFrVDVY?=
 =?utf-8?B?QjFOVmlvRU9BRmtQVy9QNWcvTml0Znd1aEhHclo0cUdGck93Uk5wSzZEZk01?=
 =?utf-8?B?NTVZSEF5MzFIV1ZhRHFpc2JwRXozbGlIMTBlalM0aDNuYXozWFRiZXdsWVpX?=
 =?utf-8?B?aWRpK3RmMDFYS2hmRklvOVRKYlJPSE9NSU9kYWhibGNGWWZ4V0pxRVZCbWRw?=
 =?utf-8?B?L1d2cjJaUmtZaG56TWF3YjhiSjBJbzI1am5zRXlvY3BYbXpzdTRlYi9CWVBE?=
 =?utf-8?B?ZXBKanJPbloweGFpdGc1RnptVWQxMmpNWXNSWDFrcjBPMVVTL3hYaWRVbkor?=
 =?utf-8?B?QVJIM1p2cnl3SDROZkwyd1hBWEh5TnRtT2hxODM1dU9XM0RzVE1tSjJVNVdu?=
 =?utf-8?B?NjBpdXJ2S2hZaTdRNHI5YXcxYk9ueUxlb3VDM3Q2YjNxK2wzbVdyLysvajh1?=
 =?utf-8?B?S2huaDVreVMwVFBsR1VpSGI0MHBUVVA3QVJpZ2pIY2ZFaVZLNmpnejd2eDN0?=
 =?utf-8?B?MU50TEpIT1o5WVJQcWN5bGJyZEgvd1VtYkRFcUQrTjVPcWdzM05UZ3RuWkFv?=
 =?utf-8?B?aHVQUEdUNS9HVDNaTUJjU2R4L0pieXFXbWo1NlJRSmlYdnNFZzRIRTI5WG1U?=
 =?utf-8?B?L05kTXdmL2tSOW1uRDJ0d0x0ZXNKbWIyRVBBYU4xN0Zyd253YXJ2VzA2YjJ3?=
 =?utf-8?B?NnJ2OWpXZEhLdHJpK0h3ekJrVHNoNzAvLytrQkpBdE5PRFNUREdDeXZ5bGdm?=
 =?utf-8?B?Z2hhbU92WmxXcFdGOEhLdVJVOUJUNGhHSHFlNzlkaDY2N1BybkxNaWczRzNN?=
 =?utf-8?B?Y2hEYVlIekVKbEJOZk5odUJTeVlLL0c2TFlRTlA1N2VmUzJQYU5ac0NGOCtK?=
 =?utf-8?B?Z0pVTzc4MHRJZ2VtcnVFUFovKzluc2FWUVplTzZLTElxamJkR3B3MkRMREt6?=
 =?utf-8?B?UTMxK0VaanVjLy9TVHFGNEFieGdlSFNpVndNSGpUckg0K3kzcDZnN0JUS3hR?=
 =?utf-8?B?bDRMOG56S1p0T2ROQTdWVExFbFBINjlPMEFyOUM4TjJZQVZYYllxZTlOQ29h?=
 =?utf-8?B?V3h5WGhlNG1qUXExWDAvWTJWOC9OTUNVRmRaMTJxTmY0dTYrT25QbDNINndB?=
 =?utf-8?B?ZHNWMERTd1R1NVBZVnFPZjZxWnBzaFpLckM4ZVFzRWo3SWMrNWRSWWFlNjdv?=
 =?utf-8?B?TCtyRlBuTTh1WkpkR0RWeDRXcGhTRVhDZEcwd1d4WWFjbzhjYXBkK3JZSUNU?=
 =?utf-8?B?MVR1djFEcExOaDBBN0dWRzZXa1ZHditxbDhHYlQwbmZNQThFMWJrbmJOelJL?=
 =?utf-8?B?RVlScVZEdytpVHMrWkI0RmY0TGRjNDM0SEYwd1o1eDFPaG1oWWJlZmNkQ0JP?=
 =?utf-8?B?M3cvZnYvTFI0WGthTFk0SEFFcGRhRXJXKzVRaWh3U2l0Mlo2TEg5REcyOCsr?=
 =?utf-8?B?UWorSXdFL2lKL0pGa1d5RC9UaE9MZkszMlFwb2htekFJMHdPQkMxZ0hzQlgv?=
 =?utf-8?B?TEtRU3pzWGhXclVKMEg0Q0NCdDcvMTZ6dEVQWUxWZnV0QmxoWGZYaXdPenQ0?=
 =?utf-8?B?ZUtXaGNSMEZFVlVxUlN2ajU4ZDhxUHRCL0Y3aFdZNmtKVnorRlpUVGxKS29N?=
 =?utf-8?B?YndyZk85cllDWTl5VE13SzZFVEFIb2xZd0tpbHZTM2lvNDFWZWtqNnZKTlZC?=
 =?utf-8?B?MjFaS09iSVNqeFpWQk9qQXNmK09NSEovQjNVWER2alNGamQ2VklnTHBpRGR5?=
 =?utf-8?B?WWc3S2JRdzUxK2dIK0xXTFRSNnpDdXlYNjdZamlKNzFlU1luaUlZcmlTKzlu?=
 =?utf-8?B?TEk3d1BVM1dlelQyRWZEZGJrS1JxdnZOUE00OXpnU0ZlZTFGLzROS3J0alI5?=
 =?utf-8?B?bDZtQnNnUWdlM21CdU9pY1hXTXdLME5rVkRnVkRBMGZ2RGdWUWFFWjkzKzF4?=
 =?utf-8?B?MHZSS3BhelVCcHE4Ykg0VUxVMmxOZDFrN2U2SE84TGNxMG0vaWtTTDEyMFpj?=
 =?utf-8?Q?gsdf1JoyqtkGMmQmFgG63FyVC0eZKbdkUruil?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013d351c-7112-43ca-9fe4-08deedf34dc4
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:30:37.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3PiIUz/a+kIaGBXcjrAKEq3cc0zGLhSygVKo8D/j/WClRTDrIG/JsYeMd7GYCU93h234zH7dTQQ+q7Lr0jPcuynpZhT5HBJrSgO0AL2k/t0SpXKveFpeOFG07R4rlj+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8239

From: Haibo Chen <haibo.chen@nxp.com>

The silent pin of the CAN transceiver is active high, asserting it puts
the transceiver into silent (listen-only) mode where the transmitter is
disabled.

At probe time, and before the PHY is powered on, the transceiver should
default to silent mode. This is the correct and lower-power state: the
transceiver should not actively drive the CAN bus until the PHY is
explicitly powered on. Requesting the silent GPIO as GPIOD_OUT_LOW leaves
the transceiver in normal mode by default, which is both incorrect and
wastes power.

Request the silent GPIO as GPIOD_OUT_HIGH so the transceiver starts in
silent mode, and let the power_on/power_off callbacks manage the mode
afterwards.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 75dc49e75ca0e0e90a1b1b140dcaf8033ec02c50..9aa30662105f063fb6d0e60fd04a95c8d635a515 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -198,7 +198,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 		if (drvdata->flags & CAN_TRANSCEIVER_SILENT_PRESENT) {
 			silent_gpio = devm_gpiod_get_index_optional(dev, "silent", i,
-								    GPIOD_OUT_LOW);
+								    GPIOD_OUT_HIGH);
 			if (IS_ERR(silent_gpio))
 				return PTR_ERR(silent_gpio);
 			can_transceiver_phy->silent_gpio = silent_gpio;

-- 
2.34.1

