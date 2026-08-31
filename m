Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013030.outbound.protection.outlook.com [40.107.162.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE124A2635;
	Mon, 31 Aug 2026 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186902; cv=fail; b=daWgT31KQ8Q4eS08N1YmIAWhttRcPXHH5DmM0NKNaCztcDYrIV4+DiD7c/JOYNu7Tn2iAYTfD8RylVFjq2uhYYIWuMw35YOn3RI0ee+QGzjzQv0fsT/enpAjGpPlmovfm0t2MxLkmo4v6b/5t18RMI/8gIFGYRLsYvfUpspJe6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186902; c=relaxed/simple;
	bh=R8h2KY67on7m82GvTF/z+jFrrRnFujMelg1Cf4zJU3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pCFEOwczWfZ4kp2RN0l4oN1l9gGOYNVLFcVgfWzJ3TH6/a9LJysr4A3/wTdIT3+m2Bmga19YOwwB0gCfPDtJQB88+UhyEXapYpvFAe0aQADRY1gdLac+7UpwHy4473kCtI9bHwqD6kCNxX1uZjTNgC1qWrO/vr3hFes3P9xNj2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dWgB6TeJ; arc=fail smtp.client-ip=40.107.162.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dWgB6TeJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyGBK3jgzjRD94tF3sEZJ+u4+WGCthn219wR4c1H2U/mBIypp9Z8j2lQPkm8TG2q2RcyrkskPFbT7sEBdUB2DI4KFrlyl6sO+SA2oBYnwmDpENMmyRydzAm10gh4sLq/3VUqGLx2VaNitIV42anC1DgNTkIQ7Vv0piJti4OdmngnPzZVPj4bffzXf/Le8i/OYKpdCXU2zvLaynBBUelJgVXNjmSP1JItsHBtfTWYSkOacAcBpI4V0zP2FvFpjQphxakq/QComXdZY6sWpxKMaV1iT/l+8ppMsExo6a5v9W6/30CKpyqeKoe/FGu1uFk+4NqCIi8Q14ONuPZtWNnFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSqHCp1UBsJev0m8Ytq/vhm1OFakx9qVqlMTfmSqAkM=;
 b=kz4RsW+azZugwHEE6gFDtRiyYuRSs3bR6BEov1CIa1kR5gmk22UcMl4PDsR+17XwVYRsN38Tqz+2/1o+GsGpNa+YrvG7u+iY+shRT20rmtfFF7AOLsA+2h0b/znP47UmGGZLaOPi2oxpCXB3zcuqgcjOfwXOuittbVl8Lcl+rUE4iM5l+v90aYeaa0/Haiw/CPIcA2gBlAAW9Vgf/T5k/Rd7wDePePhlPMGWWfUpalK7fyBC80bhIk7mPGIGCWNESFF/1Bw1rvQyaVmGvscuc2Y2N1aN7tFGohRnrAIKJwbkiis4vzYTBxD5mbbD+3S/iadyCuze/qNSBBHLS5a8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSqHCp1UBsJev0m8Ytq/vhm1OFakx9qVqlMTfmSqAkM=;
 b=dWgB6TeJUXQpEUagjtD7MevSlBY61eh85ETefGs8TcbYKvybp/AvBmQy5e//d+JbFHoNF2Gna3wd/o+Fk1F4uib5vE62LPx/BlCk9JHDR0gXuCw2mcSlumLPkzXk5ZzVyDUhZ60pI6aCgfJIigNjbq9ircB/G9R2efLdIYJVVJ+5RFPJP2aoz7ehYhEDhGxtS3wqFrw/cASjCRrMKuRWj4O7sR0fnWQ0qh7cykgdS/Wno0vKYVCwJQVko3pRUilWOtg5VOeB3tB7GqK5LU0vqDQOSvQ0tQdCg8SBPiOWwbKCLjzODcmvwBl9M6STqzcbj7n0oT82FF8kwHaeA4dBbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DUZPR04MB9795.eurprd04.prod.outlook.com (2603:10a6:10:4e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:34:53 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 14:34:53 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Dureghello <angelo@kernel-space.org>,
	Frank Li <Frank.Li@nxp.com>
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
Subject: [PATCH v7 2/6] can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable()
Date: Mon, 31 Aug 2026 16:34:45 +0200
Message-ID: <20260831143449.12828-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
References: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0185.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::22) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DUZPR04MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e0b870-dbb8-467b-e4e1-08df076d057d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 EwJZUJ+e8MO3ZoyTWcsDKCa6XhB/y+Nhn4Pm8qksp10lFy322FJS4rSgF0B4fdSOsI9TC59CTR7tisQO4alD1XeaOfWKKQ5l+CNX2TpmqNZvA0T1obq9XQKmGwEGsg+YtfDc0nbx6+3j8U+WMpE8Qizaq9UPOabJuD0x8+LLgnkL6NwAT/pZO0T3IAXK1vSsKTuLGhAH9aXK39vkPrKigwpg2VjrpudLJiziXxvmFdc4QBO0quFgxa3d9/PVdv+PGY4cultDAAWEDOiEhv9ulu1O/4WBIMrm5gxGm2isTwoUZVkDr/Nl6rWHKPSjOHrXShyJ7sWLdl7Dix9QGUUI+nvluuuj2Jt2QlHe4/MreXcS8dXjmipMW43NCsz+PF7ybrMl4AGU6o76xHAa8xvQtqy1GM+8psdV6BpICZQiKwPpXqbH8w0K65iyNfqlItzi/FL6l6komXBCgsXMFNUzf0BI1djcQgvUijVQ+sxucMNqzvxV6s9CfrZvuKdplBjeQkbUwApcz+XF56w3StlCHeiM6SCIiqG29LmiG/tdMHTI83ZWYItg0HzU9i+729L/kmkTDJAtW0dMTv1vx8zP91Ge/akYaFx3GYKW4G1xb3WZ4H1V17bb5mbJ1fVGXNdUgfmMF3QQY1BN2ZScA8Yoa8eMWzjHq5bgYa+VJyjAIQs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OWpoNGRrZWRMcDA0L0NoMUlRMUhoRHJGdVkrbUR4aWoybkN2RHY5VkV1ckMy?=
 =?utf-8?B?aVN0VDlJR1kvdUJDajNuYWpJZEhEc1lieG9hSTc3Zlc4SzNPWStPdTVIbU9V?=
 =?utf-8?B?b1lUWllJdjltRGJjQUR5cUlnOHZQQnVPdko4ZE9mQVMvKzBHT2o1UTlRa3oy?=
 =?utf-8?B?SXA3azF0ZGZRcnNXSFFiUXAwZ1pVOTRxWlUzK0dlQ2Q3OWlwR1k5aDNJV1NY?=
 =?utf-8?B?VFErNFlJeFEwRWZhSTYzbXN0T0NNSlZXbkNva1JnWnh1MThuRUdBWjBZVGo2?=
 =?utf-8?B?bUpYK2RQTXVTbnVXYXgwYTRBdmdOSFZYUGY1L0I0NDRzaVpjTVRTN0ZxdGFw?=
 =?utf-8?B?NmtFQi93MWFPSEx6cElRQmFVV1loQXgyNG1ocHBIcWF4MG5yTmlGNWFNVG1Z?=
 =?utf-8?B?TnRNbzdZYkpnY2E1bmEzVnQrQlNCS2toZk8wUWczZUNzV2VRMzdLOGJuYXFG?=
 =?utf-8?B?MjdSenRHeGpyQ0RQUGJ4NVdKaUlNdGdldjUxdkRIZmxDS25sQXM2VW9paDFP?=
 =?utf-8?B?bEVJUjdxQVNpeEhuMXZDU2FuODZmcW5jV3l5QmtPZSs0dHZaRHR0UG12UXk3?=
 =?utf-8?B?S2hweC9wbk52SGpOQzF3RFhmR1hicEV4empKOXpZazROSmZYcU1NQTloYlhn?=
 =?utf-8?B?LytqOUtSSnloSGR6S2UwR0lzMitNK29OOEpPcWU2dHVJb3c2Rm8wcnlJOWdz?=
 =?utf-8?B?OE91QVZob0pjUVpoWjBoeWtNOGN3Tkg3NDVTWS9TeFVpZklGMWkrTm9SQzBw?=
 =?utf-8?B?RGZwMDNMQW9PQ3BUcjhkbzRDVkNHSVk5ekhVdnFtM1MrRFMwVzJodlZRazBh?=
 =?utf-8?B?TDUxWWdnVzQyNVpLelUrdGoxZDhNM3VacGRPZ29lZ1NpUDBKbDcwRlZWTkhT?=
 =?utf-8?B?NDhZNGtTeENSV0lOZjB6ZVdLVUlZOGsrMXdZL2hyVFZzTUVDZS9GOUtpRUgv?=
 =?utf-8?B?V3VkcHZUbjFpQ1pEekJYVnZTQ1c2MnNhdWl5ak9NZ0JYK1ZYVHFwNDc1Wktx?=
 =?utf-8?B?VnVCb0ZDdlk4SGdGYnp5RENMZWxobkYwUHdEY1gvQ0hqK0lSWC9qTWN3UzJi?=
 =?utf-8?B?NGUrNDQrSS9HQ3MvUnI2eVBZblpzR2wzeXFhcXBZM2NFUk10ZG1EZ0dTQjFK?=
 =?utf-8?B?aHRTNEpoVW9ybWZoU3NkVndFcUdtdEV3N21oV1o2OVoxQm91UjQ4QmJyV0Vi?=
 =?utf-8?B?M28rNEtxL1UvWUZYT3l3THlMMmNlbkcvbURGS1k1ZGh5TDc1dndzN2V6OU1G?=
 =?utf-8?B?bUpZS3BZbWZiTWZ0WW51TDJxSVRQLzVSNmM5K0c0c1M1OW1MYjlrVitoUjN5?=
 =?utf-8?B?M1RteHJQU1VORlRSc3l0blhXZENuc1UwaExDaTFReEhZWHJYRGlnSnNnMVFy?=
 =?utf-8?B?TGZDVit4V2NRckRoVUFCYllvNDVWbTdURlUyMWNyWGxuc3NyT2p0R0xIdXgy?=
 =?utf-8?B?cDY5ajFET0NzVTRQalZaZENlbVdmSUpkU1RmbWhpMm03TWw5RytPOU9nSWhn?=
 =?utf-8?B?eFh4ZTJmRkpZaFZ2TUdkQjlmdHVPbTVYWlZTY2tvVytrbjZzaFVjMWE2ZzR3?=
 =?utf-8?B?THBrZmxERnVGVHF6RFpzaXJyQXE4UkRicUVsR3FZTDFlQWpsSDRMMVZjblFW?=
 =?utf-8?B?dGwzcURJdXdWb3VEd2pZbGtRZnNxYS9Lb2NmeXZvM0REeFJnL0RPbUZxK3lK?=
 =?utf-8?B?K3E4b1JtUFRHMy9yRldhTnVycWhSR1FZMXV4RmlneGFuTkx4MitmZGtEeGRW?=
 =?utf-8?B?aVpUSy9sSDdHeEJqR2QyZHZ0YkFJWm4rUS9nOWRDN3NBSGxkUk9MODJvSlZs?=
 =?utf-8?B?b2o5Q0lWK2ZrbEt5eDM1UmJMR3hXSDlrSCtEbUNGZ1BhSDBPMnUwZXkvVWRY?=
 =?utf-8?B?N3BGa0NGWEswdzdHb25zaWVTaGcyclIvcXZhdnhlNExKYjJNeGhUOCtFMVZK?=
 =?utf-8?B?SUNjMVNRcDJ6Q0dTNkx1Tkh0NE9GZlNxenRHbHdTMWNJV29oVmJSdzZkZ2dH?=
 =?utf-8?B?VVVvcGZXM1Z6QXhaUWFHQzVVYzlGWlpTNFFOdk81Q2pmVFhzOGJDcUVnb0py?=
 =?utf-8?B?a3U5alJpSGNTRkQrUk0rZCtaNFlNdmR3aGVlTjNZZU53N05tc05jZ0hmRTFx?=
 =?utf-8?B?VGxWZ1VqWnBzakxTVk5TMkJYdERyVW4xL3dzc3B4aUMxOWE0MHJCV1Bad3h4?=
 =?utf-8?B?Yk1EbDVWK0pHWittaFpiZzNnaDZwRThSWHJEVC9XcWZXNkZ2V0ZVM2xpNEtS?=
 =?utf-8?B?YUg5RzFrZExmdzY1cnE3VGxpcEs3emtJRWFyenhVaW5ScHVvTVpPaWViVzdz?=
 =?utf-8?B?VkpoYmErb05VWVBRaWlMMkQyQXhrT3RrME4wTDVEUnBaQTN0OHBkS1ZzUisz?=
 =?utf-8?Q?miGhfoxIbkBkEvuY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e0b870-dbb8-467b-e4e1-08df076d057d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:34:53.6555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ay6v6l7kQTJPRIKBHaJ2NWHfP3Gxn/aertuGrS22zLHTzuNz5tBXSFWrHUNa78OErEFRsZe9AOYVcFU4y47EA+nv5RdGUDBiSMUdY2q1Bvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9795

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
index 2e9df2d14b34..4eda54d2169e 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1522,14 +1522,28 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
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

