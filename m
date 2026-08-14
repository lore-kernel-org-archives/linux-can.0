Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121A4570E2;
	Fri, 14 Aug 2026 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698229; cv=fail; b=TT5UTVl9sJgDODraUIcvgkCcKuahkf0rukoCozHBwMdzRqcjGEvVl1AeXs5FrfHHSh9Bix7OVv3SsZUw7alPsiY6KFqaABAl2lVYcpH39Z3Qp8p6wh9S03b5UOhehBiH78dAKcD/ML9TXtmrLm0FXwDdHcJ7WL1r0ICzzd6ply8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698229; c=relaxed/simple;
	bh=L2GeK4P9A0OCzaBg3VY0hDTGq0jlrEjH8CorYuCjNb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ow+8Z2JnQsMVc3pFiNRaFbBCDKnSfOw20oyzg5ynWYy2qNAijkkwN03DYVQ7qLZsdkfWxbkJrFv+J/me51FpHVn6BN4x34JFA0TXxZAP8GcYlelFKKbZo6g8FW3RbRP2VWq2WIe250OcOgOvHZY/MFX4dN55zLhDSnrHrc8Dw9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JpMFRRRj; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JpMFRRRj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoI2HSv/S86Qbg+++VeIvjvtB2N7o8ik7UD7a8iwmYjFz+RB77xUGIUvJ7SiY7uGPoS03OP1BQDFYOlxQDvNkuv4cSIKHiYarmBaGg7bRSvPJLbHMgCnCCilHrsR1T3hDawSj+w1ixQSuHzCxKIemIDSlZ6O21FTAmB18Zzo95iHSeeKN6H55tGmnRbK7m70UDkf4rqHHrkkZV68zrtSApMCisFHdWIOwlWuB5w9KP8la5l61OxGPF9J+Fgg1lglhYfyYN39dXW8iXlQqvDcVdlOIYLAaxFH94/1Iv5Eev8O7JdPusE0H9BH/YMqHRVWcpRUgjFR6UD15Ccp+Oojkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYysnO5TUDX/ijxoCX0C5JjYD7tZK3PMESQ9/aXD9cU=;
 b=Bik2FUe8xT0qfdWfyLPssPFg9bXk7YdRy+ZTpEmPAErygqQrS4JCeD53LzKwIwx9qWMGmOMs4O3/dXnO4pTCtVv0Ahrh3Kp/eB6T7wXQ6/kxrqNBAVW6UcT5jJvSljl+1TpG0xfaHLswSV6s86q3r+rBwLmhK31PbU030vnvDtp12trXcOHzFdipyPh3wK2WmyoMlbMTI87tlid4aCltmFwejvLihcMjQQJSkk5Rh/PsXt1V9J73X4ybpKQ7eMMDx3P5NEZNi592kYkCNRpN/U9hrTNca/vnlfj2iqrn1SvTxC0gwCt+1DFfqL3xT+6hyugThfCu6ytkfVK8MeoX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYysnO5TUDX/ijxoCX0C5JjYD7tZK3PMESQ9/aXD9cU=;
 b=JpMFRRRjebDyI1ir/21Qw8TziXE+yKceOkuSGZqWNxl0qOQ7L7pYhznrMN3BDW7LK2NQLw0XZPVuTe1YJ10SFD4PY/RII7b6oYxdcyNtV9IrgHgnK7xf+uGP/+VybIOJjOQRHbe4FX/7go05Zqo1xG1uI9uVlRLpHtb4UcT1s3XcbrAT/AEWj/C0Hn8/gTqvxqhhDZ0ldowav/NYT4Ki/0fyGdaYQSINrcr7iLWiJ3HMPmns3dIMwjNlL8oE2/yG7kxPSwWtM5c/Rtggz9ldnbnLkUMqIogtMA7rPoLVo+gQmBNXuDT10FPGNJTCuTHYafri1WIdjUPXee70v2+lFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AMBPR04MB963705.eurprd04.prod.outlook.com (2603:10a6:20b:75d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 09:03:39 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 09:03:39 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Dureghello <angelo@kernel-space.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [RESEND PATCH v6 5/6] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
Date: Fri, 14 Aug 2026 11:03:22 +0200
Message-ID: <20260814090324.647898-6-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
References: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0319.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::17) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AMBPR04MB963705:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e018e6-5b55-4c4b-a584-08def9e2ee7d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|7416014|11063799006|56012099006|10067099003|10063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 JTW8d9Ee+k9oqGqBNaw8ubsXV0z6+NZKEZLnxwZLSFXTYkLTiuUwuQ5+ZY02W+d5UfEhYrfq+Op8xxbqyYXQ3o4IjZRFOtt2ZahNJDe+HWMBjsvDsWxy6yz+T6FZqNqhjKQ3r4+vVCgMCVcYz37SgyGa5y2zf0aickCi1hPeGXXNKBSrQwFQW9FZhynaIGX1YX5VXRP57zj5GMAvHjtH7adsyj0LPh2WgeHMl0g4xO4LZUSC3pnSoZ59tQcb9ZCRKvK29tc5uszV5VkK2vB1Rxz4qg0bQDVkKbKIv9mp6Dr4DGWGoyvKbniZa2C4XI/h+5so5PkQFlUxNVrGIJCZ4V1zgulm3iLmG/NRt/ox8nq9KGsPi8hOv2fBYATz1+bSShrAb3yIQwMQQptWuqdHFaJQgPHdsP74X2dO8C+V3Mfb8xhq5t3gz1WUaZUHgFxx7NUnjI4gqD7vql02K2Y3Azd4paCyAujCxN5oY0t38SzIb2XsjM+O41sRJM9IgUsxfh57dMBGqCIfsMpkI09HPBxd17Hc47/Sf2r91nZU5xpqz1mYki5Y+etg9q2xaJ6ULeb+PNf6wiAS1bBxLwl0KDs+CSbW2+H82uWp/nTwhu2YexSPNPMY/F3jV6j2KMokv1Hvso98F+V93Nwwaw9pAiz301p/04jCdHd8SQteDaM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(7416014)(11063799006)(56012099006)(10067099003)(10063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MUVXUkl4d2QyWlhJL1RmaDVTcCtKK1hoUTlyZVNncTFuTFlldlBtazhuTG43?=
 =?utf-8?B?TmwxY3V1TTNJamJibWJQMUgyTmJaK0hSYVcySnRFaEVROW5pU0QwTjF1cTIr?=
 =?utf-8?B?VFlEcEZGcGQzSnlMakUwTFU3WFgzelBBM0lZOEhSamtiR0Yzb1dqNU9mbmU2?=
 =?utf-8?B?TTA5RDZYZzNFQjUraVRkTFJmbHhmTzRrekxlTGQ2OStENVlobE1zWDA1WmEz?=
 =?utf-8?B?N3Uxc1Jia3VxeVdzSWkwYmt5ZVFTWVdyeldMM3hLTTZOMDdPallEcy9tZEcv?=
 =?utf-8?B?UzllQVZhdUM1Nm9DL2FYSXAwMzA4MGNMZFVZajJudmVweFVKRHpiQ0ZrbkxN?=
 =?utf-8?B?VlhHZHlwYXhRVVRyajc3S0lTdERqUng4WmFHenRqbXFlcGNQeUx2eTM2VXBk?=
 =?utf-8?B?NjRHK3VteDVPYk0wNzFqTkF1RVNtcmp2RXc4T2N5RTNQK3Zhdm5Gd1AzcGw0?=
 =?utf-8?B?ckl2OVViclMvUWhHcXdycjhPbm5wUU13L1dydmh1cW9sR2NKWEFqQzhMc1li?=
 =?utf-8?B?M0dGTUZHSnBadEl3KytTamgrSW9WZmtuYXNYWkdVam9vaUtucnZ3UUVkcVJq?=
 =?utf-8?B?RkRVRE50WGhJSWFZSHhGTXZyZi9OV212RXRPZmtTN3hGTUU2QitaVmZoMll6?=
 =?utf-8?B?VENNUmJVQVlmYk1XVEhycDZVMk9wSE11Nk5hbWROWllabExvUWpmbGRKOTls?=
 =?utf-8?B?MWpFc0M1Zzd5OThjQVUrQlJMWmZOcnZ1ZDJNUXNPODFLRVpuNVpmeDJGdTcx?=
 =?utf-8?B?dkpLMndIRElDdEM0NUJLZ05CZUJYTU1SSm1OQTZSM1U2RFc0RVVFT3c1c2pD?=
 =?utf-8?B?eTlwaGNDRlcwdjF0SnZ2R25uTVlhMzZEb3lnUThVSmJtMFJoWjFKNFlyL0s1?=
 =?utf-8?B?SEFnQ016ZFJxUXVqK1gyVmVKWmx5a1psaU1TbXhrMXJJNVZWZ0pyelRPS2FT?=
 =?utf-8?B?bmloZHhnSmtFdllJSE1ObXM5Ym9sK0xVN2VKYXlTOEE0QkR6eStjVk9oSitB?=
 =?utf-8?B?bURrZ0dRbHRORW5YRElxc3JBSmtNd2duRENNY3JYL2JOQ3ZnNEtRZHd0VlNj?=
 =?utf-8?B?U0NVNGcvbDRGNE0xdllqMVc2eDRZZkNIYjVBMFhUbjExKzI1ckI1dXJXU3Ez?=
 =?utf-8?B?Ni9pRVhuU2JzMmRtMFBRSkZseUN2alZXZWFIZm8vMWxXWnA2dlYxMVJ6L1R5?=
 =?utf-8?B?WHdpa2tzblJpNHpnY3Q4ZlJ5ZDNZTTUzNTVTQkNuOStmVldEaDByRzJhWnNu?=
 =?utf-8?B?cWtvcTFMWWdpTFpGUFZaSXRubi96QWxXWEQ0eUo0WGZRSVlFUk85ZmNBazU1?=
 =?utf-8?B?NkZ5SU1jKzJkeXQzUjluY2h3OTJNRk5MenB5WnlXYUFXd3lKeTlZMzBReksz?=
 =?utf-8?B?M2kwUnBiOXI1MGhSU1VUUGYwNU9mNlpwc0ZReEhWQ0lVWEtHbFFRdzlvY0R1?=
 =?utf-8?B?bEpTVjBKUnQxLzlHVm9hTmxwcDJySUJIbnFzVkpiVzFpcnc2ajcrWDdLRXgr?=
 =?utf-8?B?YzZ6OXJieGZORmRiRDIvbndkTS9oYmY2N0FNbjNSRXduQUs4bkJXMUkxc1VT?=
 =?utf-8?B?REVYdzNNdmJ6TDkxUDkxdzhKZ1dYQkZzOFpqTVhuR1IzY21sNEtHUnlKRWNX?=
 =?utf-8?B?OGgweGZuQlFnNFVFSTd6QmVIZDdCUHJZS3BQRGE5SW5CejcvS1V4VlhIM1pw?=
 =?utf-8?B?YVpYVTZzWWswWm5DdVptVCtJYkpCZkVZS045ODAycFBKZjRaQzdheC9iQUQ2?=
 =?utf-8?B?ZFIrZWk5dWtYajZkS2FTeVBSSVV0b2ZqQkRBYSt2eGlMa2o0bWJiWlZUeGxS?=
 =?utf-8?B?OTBSN1Q4R01OWnNuOW4waFc1ekZwV01WMFowOGJpbkRpOURORDhOTEk2aXlR?=
 =?utf-8?B?QlJjcElFYUF5RExmWjBtdzMvYXRSa0QxcndtL2gzZkoxV2Qydmt1Nk82SVNW?=
 =?utf-8?B?ems3QUpUMHRZVFU1OFBHMktLRnVXOTVmZ0tqL0M4WHZnWnlJUVplZG1Xa1Fn?=
 =?utf-8?B?UUlGcmZBTnNzT291ZTBpMVltS2FZeXVYbUxkYnRFdTlnekxkc08wbXhXMmx1?=
 =?utf-8?B?bFJ4QTkyUmNzTGZ1M1ViVldOaXFVOUU0THFEeFV5bEhua0srRlVQT3FOblFw?=
 =?utf-8?B?WHAzazIxZytGK3JzUWpuVkhvQzFFVXArbnlVa3UvSkZCbWhKZ0tNRWpRR3Jy?=
 =?utf-8?B?dXRINWQ1bDltUitRWThQNVlaM0VXb2pCcE1IbktEbkZ2bjhzOWh5elRuY1U4?=
 =?utf-8?B?Vk82Q0x0UVhJamlyMmJZZDZmL0U5dzRBNERtUVkzTkl4bmcxMXpFTEhKRVA1?=
 =?utf-8?B?ZmpOZ2UrbWZNYXB5LytZRERHUFdhdTltc29CcEJySS84UlZKak9WSkJaSWMz?=
 =?utf-8?Q?PAkYMgi0AyIIj/kk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e018e6-5b55-4c4b-a584-08def9e2ee7d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 09:03:39.4308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ui0nQyrgSUbmkTyyeBsQLaSuT4Gc+N4ZPOFEdMJGuNkYiv4k+IGrMw1uCki7HfE8EG7jh4InrcJ+4J9AGt/m5xvDeNEXjqqwiR+7h07DcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB963705

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Introduce FLEXCAN_QUIRK_IRQ_BERR quirk to handle hardware integration
where the FlexCAN module has a dedicated interrupt line for signaling
bus errors and device state changes.

This adds the flexcan_irq_esr() handler which composes
flexcan_do_state() and flexcan_do_berr() to handle platforms where
these events share a single IRQ line.

Also extend flexcan_chip_interrupts_enable() to disable/enable the
new IRQ line during IMASK register writes.

This is required for NXP S32N79 SoC support.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 53 +++++++++++++++++++++-----
 drivers/net/can/flexcan/flexcan.h      |  2 +
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 8b70952f7f05..e7e3fb41f55e 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1300,6 +1300,22 @@ static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
 	return handled;
 }
 
+/* Combined bus error and state change IRQ handler */
+static irqreturn_t flexcan_irq_esr(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_state(dev);
+	handled |= flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
 static void flexcan_set_bittiming_ctrl(const struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
@@ -1540,10 +1556,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 	u64 reg_imask;
 
 	disable_irq(dev->irq);
-	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3)
 		disable_irq(priv->irq_boff);
+	if (quirks & (FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		disable_irq(priv->irq_err);
-	}
 	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		disable_irq(priv->irq_secondary_mb);
 
@@ -1554,10 +1570,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 	enable_irq(dev->irq);
 	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		enable_irq(priv->irq_secondary_mb);
-	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
-		enable_irq(priv->irq_boff);
+	if (quirks & (FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		enable_irq(priv->irq_err);
-	}
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		enable_irq(priv->irq_boff);
 }
 
 static void flexcan_chip_interrupts_disable(const struct net_device *dev)
@@ -1881,7 +1897,8 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		err = request_irq(dev->irq, flexcan_irq_mb,
 				  IRQF_SHARED, dev->name, dev);
 	else
@@ -1902,6 +1919,13 @@ static int flexcan_open(struct net_device *dev)
 			goto out_free_irq_boff;
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
+		err = request_irq(priv->irq_err,
+				  flexcan_irq_esr, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq_boff;
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
 		err = request_irq(priv->irq_secondary_mb,
 				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
@@ -1916,7 +1940,8 @@ static int flexcan_open(struct net_device *dev)
 	return 0;
 
  out_free_irq_err:
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
@@ -1948,10 +1973,12 @@ static int flexcan_close(struct net_device *dev)
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		free_irq(priv->irq_secondary_mb, dev);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
 		free_irq(priv->irq_boff, dev);
-	}
 
 	free_irq(dev->irq, dev);
 	can_rx_offload_disable(&priv->offload);
@@ -2338,6 +2365,14 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (transceiver)
 		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
+		priv->irq_err = platform_get_irq_byname(pdev, "berr");
+		if (priv->irq_err < 0) {
+			err = priv->irq_err;
+			goto failed_platform_get_irq;
+		}
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		priv->irq_boff = platform_get_irq(pdev, 1);
 		if (priv->irq_boff < 0) {
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 16692a2502eb..bbb1a8dd4777 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -74,6 +74,8 @@
  * both need to have an interrupt handler registered.
  */
 #define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
+/* Setup dedicated bus error and state change IRQ */
+#define FLEXCAN_QUIRK_IRQ_BERR	BIT(19)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
-- 
2.43.0

