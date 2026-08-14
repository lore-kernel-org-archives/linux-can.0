Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F624570E2;
	Fri, 14 Aug 2026 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698219; cv=fail; b=t8KXtUS9VPUpBa8dfKBEHhYgMmeDCH7k19ibpr7kZGWqcCPM5Jc9vIHPbYi6g8MfAva3ky5ggLFkYjfCLvG3pDFIj/uBGGM1foH6+zAvh5hNKSsdMbnfiFdjOdKKCYxPMHZWb+LWnQe5yuv+aLLCcQsIIVk7bCgmYRGRzNlqWIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698219; c=relaxed/simple;
	bh=jEKc1mHUxTPgmopcleEEXBhGsLlzVY9kPz//6GeEJ28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nd4X4VTSe9RYeW0RQwreNI0e1hLXsF0Fz4gsZEKfcRGqAO+k1/Uv8BigblP7evnj3gXX0Y//1LcQlH20pvQ/FGUnQfOUyYEKbyI0NL6BT0KhbYfKFJoA1RDrpdsDEdzQYFH4Lh3Kug+5scMs4uI0hRzH4a3Z4oTqahC+P1TKqpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uI33C/Z1; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uI33C/Z1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwqyImCu9mef66aVqMHocnMLpM+b3+ofbpOISf0r1I5nNfU1NipFiHY1mJVs1Nd909LbtcEJvf0Mm+2eeyK0jepeZkQpJiNjy8+J+aaKF/hnygI0u5JnNl8xt8CBbCZAQFi5gaqGBpC2QXdsIQ0W5jFOaxvGj2E1a1KALbGTJ/gnq4FY15BHbY131z2p9Xo2k4C/MwuYt+CV1pB01r2cvBLUalGAkdG14TwQ4fAik8ez3x2vzwmjLLeZRDuIqSDlG24ddHuD7MJZqmPKUfpM1CfrTT7J12oO2VXWY8gmonAjhx0vj+zqMsg0KK/DA85+0EXVYaupFxDAJN4aEBjoIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIwMQuNSe7a3jJkFFm2nuBoWfl5Wt9Oyitq8ajx+img=;
 b=v+G0RNqpYby3a0xPMolEwyJk1JmMgRZNJjOl5ucQFjK8/13WfSUTE4eupdfo1zZ2DNpE/ozAHetcawSJqQe/ZI2dmIvJ/tk/Uj3+2USEbIT3ozfbJss3lA3jj8j3fCeVN3FyfVwcDVo6y9qtRikRJD9241vznGso1tY/2vcyjOhLqu0qZxpDwACZswu+Ue1dUNuOrFmaRf4qBH2UUKAe0rGAvL/epHTE4rdpO6R2yAy5xWnWf64W1FY8DwKcG9q0E2ACJQj3KCJ46QrTB/fNzdCS5p1saKn/tpdARR5y1oRL9TJZtx40C1GM28oUojJrw//3+8u6gQBHpOBCVlAt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIwMQuNSe7a3jJkFFm2nuBoWfl5Wt9Oyitq8ajx+img=;
 b=uI33C/Z1RACEYu69wLuw02PvmR+tz2p1rl9qANrtAjXlWkSNfMKd+mVkHrmFw0GCM/fevfBVjg0Pj4pnNUgC38Sac4t5cBdqhVToF5ctWQg4kDTwkzpzy+pqI0RqrstULsu5BGYFQoyjdIrOkaRhOLcM7u1Dra0hUXK8NmVCz9Hf8hGISCWOE3BAW4UaFApn0bpxFJLp/88V5BA1PKiJ+opDvykDfpS18rM9YI9xfVX6AiEo5K5PV5W7B9jAx27sGbwzW6yWVimbE8PvcWgEs2zQduYiaz0R5xe1+b63W9mLPiAXHUxQKL0mYEAZ1BtMAA3g0nHXaqrENjME4P0LgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AMBPR04MB963705.eurprd04.prod.outlook.com (2603:10a6:20b:75d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 09:03:34 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 09:03:34 +0000
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
	Haibo Chen <haibo.chen@nxp.com>
Subject: [RESEND PATCH v6 2/6] can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable()
Date: Fri, 14 Aug 2026 11:03:19 +0200
Message-ID: <20260814090324.647898-3-ciprianmarian.costea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e24bf3d1-e19d-4841-7749-08def9e2ebb2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|7416014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 cvW80Vzkz1tMeUDZmVnbMBuqDenJAu5uivK4sfNEDZ/0Q5rValNOKu7/sNS8USnnIUE81xVVhHB/3BxjaHPi6Q83dszKgmwqeQwYa/EILNoECFY1k0ek5Z8c0cNaWApKTpwe0k7MQyLFPmdnu9b+1azE9MIxGjAQZA2sjpzYDGYMRgWdwoMbSNfaHKvDUFEJHsUbwvuYUkpNM0Pk27/z+091vdNFJEMbyd6Gsp818dLW4kE18xCyoYpToAiqvwBuDgj2AdrAb4BW8waqvixeNBWr3jXmPEfnbd893uCQ/NzPv6g3aTzngKqkhj+kQBS9sUpsP2zGetcHlxpGcePBmINGpgm+X3Z3QVrD39HLfBHxZH2OiFdcgbii5iz+cOXy1lWQ6mYv0pctcQAle9xEbOiCmNVHtY/M0FMi2dvg/cex2YKrn74KnCFpDR0iyDKDXtnbDBby6DmtBycrKPdF1El7W2Yz9mIfCLLGiifHjeTxwSJyN7Rny4abbkkPj0zZeMtS9tmkKU9tcsVitEnKHoF/Y+HEO0g/sqEBBs4bBfcYS+2kjsrFfOXBjuVkyuyX+xGTFvRiCEZnthXBhLT3B7ag0Qcwt1qhcWSCOShW9MTApRX1HB8A7SzRI2PGkWh6nT+jIsBqcf/i5JaWAI/o9OuzJqILzu2RIEA4l3kT344=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(7416014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UG5GcmNTcTNWMWErOUtVdVcxVTQzMFloYXVTNHk2UUdxSjg4Y1R6ZFdnSjAx?=
 =?utf-8?B?ZnVOMS84cHYwajNxT2E4VTJRUnJtQVRMVWUwbjRubzU2dU55WnMvbGVRcDdq?=
 =?utf-8?B?YWVVMVlNU0tVcVRuamJEOFZ0NEMyZUo4MFNpbU1HT1lRM2pVbHFLdGJ5U29h?=
 =?utf-8?B?cXdpem1RdDNYMTcwNithL2hnTDFJM1JvYk9YcVpoZmM4MDJhNTVHV2tXa3ps?=
 =?utf-8?B?bTYwVWJlNVBOcUx4OTVSY2I1N2cybnZ6Ukwyc3RaWVhEdnV3THRBcmgvbXVH?=
 =?utf-8?B?S0pKZHRwby9jbldYWnNpdldyMWZ3V21tTStHUGs0N1gwZitHZUFOQ0hsM2pl?=
 =?utf-8?B?S2d4T1lzaVBQVmhYRkJWWFlHTzFLODA5dXRaZjlCMXpIVUcxTU5Ya004cFNs?=
 =?utf-8?B?dC9GdkVaZGwySlI0VHNLRE5CZERxNmhhT3g0OHhWMVJHOHQvaFdORTNnQUlh?=
 =?utf-8?B?ajFTd2VIWnJ5c05kYVdtVm56S0xSc3loNnl6SnMzVTVmNjlOcEhJSU5KbUE0?=
 =?utf-8?B?R1p2Z1dLekdXTU1uT2IraU5HMHNSZjhwYTBMK0pnSWsxNzV2cWdsallWMm4v?=
 =?utf-8?B?bWFZSWsyYmw5Sk1STHRPZUdPd1g4bzFvb0pLTE9xVStvVEkxdW10Q0pzSGlp?=
 =?utf-8?B?cVNuR2Y1ZVhWNnBtUjhaMGx1eHl5bGZoK1JuMHJyTGFsY3NUVFhDYytuM2dM?=
 =?utf-8?B?eCtFUTNZOHVSMmVBOE1lRVdvRzFhU1gxMHlUQVFEaHJRaVdlaFV2d2RuN1NO?=
 =?utf-8?B?ZFR3MjZhT0NRZWRkVjJFeHcrVXZaK1I4L2VjMGluY2Vsdm94RFNJZHFiTDVO?=
 =?utf-8?B?dlpWUEs1T3U2TnN5ZHBsRENia2ZNZXRCK1dCaTYvL2hSckJkNXdFb2hReTBG?=
 =?utf-8?B?R1hFQWtnVEs1U0cyclpxSW1zbURpVmkvQ1VQclZTdVU2VXFFU3dGdGJEVDQz?=
 =?utf-8?B?TFEyMkFlTEpaMEQ4ekJxNzVCMVdqZTlPUUIyVUtVUXZlUDZqTVRkVFkvbHVX?=
 =?utf-8?B?eVpFVDZ3NmMzU3VPOG9tVVhNMGNwOC9GTGF6dytUajc4a3RQNnZEaFVqVVJZ?=
 =?utf-8?B?all3TTRpUDU5Tys1TTdHNUtKMVgxd212WGRySzFJVm5GKzkzUnQ2dkJlMUMx?=
 =?utf-8?B?QiszdjdsQ1I0N004UkdtTFd2dmw2SGIvY3hWTi9IaE0yL1BDVUVkbmlYK0h5?=
 =?utf-8?B?MUhuYzU3UitGNXVDRFNDQXdob1Q3eFdlMC9ZenB6WWhlWkpjYmNlc3M4dGNH?=
 =?utf-8?B?dWozUlZIbFBqR3UyYjJuU2pCRTFhRk9Tclp6Sk5TRWhmaXlQdm80QTdYdEJC?=
 =?utf-8?B?VFlJeEZWRG1YT3JjcWFJK3R1MjJMZ3hMMlIwVUdXdHJSVytGRGgyTHJjVFJO?=
 =?utf-8?B?SkdTUGMxWHdmSW1UdEdZaDByaUFxeG5qS2llYlhQZFQ3b0hJR1g2WmhDdWla?=
 =?utf-8?B?V1NyS0svL2dtc3EzY05UTkJtWVdGNjBqcVNnNU9yTGwvbmkvNzcrdDJvb2FH?=
 =?utf-8?B?aVYrWlN6T1A1RUdWM1laN0RxVWcyb0pjMDU4cnZ2OXJqWU1QNlVLOEQ3b1hX?=
 =?utf-8?B?M0w3SkYzZHVoYk1IeHEyNlF1SXcydTFZUUFxbWtXZnh3VUtpZHBlaUxyVHdD?=
 =?utf-8?B?c2xxOEVEN1h4b21CMmpMaDR1bjdyd29jT0ZTQ2NUVndIMU4zRkVBbTlVdW8z?=
 =?utf-8?B?MC9DTUVjY2RMcVp5cS96b2hBbXZXY2FIK2Vuc0RzT29HU2tmVk41dnUweDNQ?=
 =?utf-8?B?c2JjVUtMMnNwYkU4SEU5ZWJGaXp6MThNcFFuOG51cUFncHFnZGQxZzJwaTZY?=
 =?utf-8?B?d3B3WWU5YkFrMkltNk1hNytxYnNReWdFcCt3c1gxdGhidHR0UUgxMHhHY04r?=
 =?utf-8?B?N25udjFJUEo3WURpYUt2eGZOMjh6U1VsbjF3aytodGs4MUtvNFJZTjY2S3BD?=
 =?utf-8?B?MFVVeWRIbnFQd3RVeXF0M2pKUkFKV3F0cld4L3VISHIxMHhya2ZIVUFmR3dT?=
 =?utf-8?B?M2hueXp2N3Q1YWttQkhhY0FwTCs2VGkzRGxyWURrK2x2WlpadUVrUkRNZWZ0?=
 =?utf-8?B?N1daRmRoa3prYVhYUmsrSjV5MEdTUXlJUkJNNjA3MlBnZ0dlb0NkRktYemZB?=
 =?utf-8?B?K09OeXVMcmVkNTdnV0hkaXpZdmFpWlhSTVJlVHZjek5lVG1xRWZ6bkpUdXl4?=
 =?utf-8?B?dEVvd0UyUFZnUU1TSTJHWS94YUlITC8raGpZajhoYlFKZ05TSVJTd3JtY3M2?=
 =?utf-8?B?QW9RZ2lyaER5MUxrMVRwZDRPK1FESE9Nc3NoWnZsY2tFS25zb0hFcEZ1cWNw?=
 =?utf-8?B?b1JuQjAySmgzVEFDdjhiRnNUSEVZNnVPcCtqdDI4Z20zMzd5c0ZucUp4YkZ1?=
 =?utf-8?Q?my67HhcebGWy+oJk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24bf3d1-e19d-4841-7749-08def9e2ebb2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 09:03:34.6829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvz+fekJj/Jcpy0gTQ4Wl9uQHJjThpHnLhfqZrvXwxSuo8wjQcQwXq8dqm0dL+XnuyaJpop5m4tAzhoznoXYjEXx7uWK2q4EAgGky6D6pXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB963705

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

flexcan_chip_interrupts_enable() disables only the primary IRQ line while
writing to the IMASK and CTRL registers.

On multi-IRQ platforms (S32G2, MCF5441X), the additional IRQ lines (boff,
err, secondary-mb) remain active so their handlers can fire while
registers are inconsistent.

Disable all registered IRQ lines around the IMASK/CTRL writes. This
also fixes the resume path, which calls this function.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f73ff442d530..7dde2e623def 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1519,14 +1519,28 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
+	u32 quirks = priv->devtype_data.quirks;
 	u64 reg_imask;
 
 	disable_irq(dev->irq);
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		disable_irq(priv->irq_boff);
+		disable_irq(priv->irq_err);
+	}
+	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		disable_irq(priv->irq_secondary_mb);
+
 	priv->write(priv->reg_ctrl_default, &regs->ctrl);
 	reg_imask = priv->rx_mask | priv->tx_mask;
 	priv->write(upper_32_bits(reg_imask), &regs->imask2);
 	priv->write(lower_32_bits(reg_imask), &regs->imask1);
 	enable_irq(dev->irq);
+	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		enable_irq(priv->irq_secondary_mb);
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		enable_irq(priv->irq_boff);
+		enable_irq(priv->irq_err);
+	}
 }
 
 static void flexcan_chip_interrupts_disable(const struct net_device *dev)
-- 
2.43.0

