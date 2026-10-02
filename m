Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FCC424D42;
	Fri,  2 Oct 2026 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925167; cv=fail; b=LX0kRwkEuvYaNPge8vJHY+szMNEu8z2CrSO2X18YGvn8JoaE3Ec9RPNaQrilp8DDPCgcbl6Ldl5CQ/8I5SvZSZtKZfXVwexOEXkAftG0dUz7jrBCt1F2EA7iIbuqzz5qjt1Z1v4sCcBUB1veWq2O9JuYBWZc5MqXQifeE3MclFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925167; c=relaxed/simple;
	bh=kSpndLfimTE4QlGUaJ6ww5zsyjYJTMXtrA7bYW5gFOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F+r7YUP04iykEeMnyy7mWgrzOer0ga6ZbApb3LYYYmeIcxXzxg2YGVl0rRXRcAGTrA1JbUh6Woo6h2fyuTE+CvaegSJbgTe7ZChcqMqDXG3OPchRm2mCKOxZ0n6c4rxrFPA/Snv210PAx9o6XYU0cf/KarJCEGWxCY74dntvyNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xxptEGal; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xxptEGal"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CirsrxioPR6cvQ0DubexEBHzeAb9ZTk9XHCIKdETW1pAN2dLZHkn3c+4KGQDdMwKzIFB+qj/57h423Qcun8m+EGMScdUW5RWFORmHEqovXkBxhVWDcTflSn4OzLUAvE9qGQ2jQx/yNlcFf7UJjUOfKk7/xq+SpnLicRdFlxXh3jhgv42xKx2yFNJtsKX1nITkYvga1NwA3kkrDtMUtoYnkbKcZeaghb9dZ5RuNvkKycLGXUKooU07kD/mFPDW0Zw8/4wRd3OdQlQm0SOW2gSGn148F32E/0qG5MHLcm9T1R6CsnhXtwEp3GBGTPsxUls9dxX0R9D1IjZYwCBtifjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwHGxTU3Nx0ghA5AgpPdHVQWqPrARCL/y2i6iTdSJe0=;
 b=ts4Gda0UkNTAf5XsEaHSPlbjflKawtuqOVzm0T00qQonv0MZO0bg6mH4DjR+5Ke4RlXRvWOblFhYNawxWipy9jkqVcZKp+jnolcJj+aetdbY2frjn2cdqvdgs+vuWup2Z6ixrNPyC48/Da6sye0drMWMlw0MX6YTWgX3jPzfs7W5s+GOs7tkjPCpWlsKEPO9ysQjT79SmIKbvs2BVi0CYI5nfUCVZHI5KepQND4kMn5Cv3BAyOr5pRmBjlJykT+WUQ1kRQWjX8qbjlErdxv7fDHmcGDWEOlHebmJM2dOItz1D7DBn8vyxYWGXk0IVBqIdduGS55SddHM93JENZaSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwHGxTU3Nx0ghA5AgpPdHVQWqPrARCL/y2i6iTdSJe0=;
 b=xxptEGalxCNMl2pGfhF++5myE1R+azhrTsue97cIAwaqrYxeJ4/1HeIXeXTZ7KTX/CQJsvrVXoSKUtHtFKVYN49PkY4mCMnzcKo5StHLEo0rFILKdaIMaHwLDnKqBwlOzxSFN+UC0+vwCgctrL+JbeR1CRaXrQ+wYofcKEXjKJP7qIOlm99SieEMUu9w52xa/daevf8WJGEomasQNgyzt8k0tHvplnbtOhqpywltP9OoPOvnSxg+yyn62ZFyJwKnw6sE7tAbg9WHRweCQw5o0BvZ3r6YBzImJiLLEGoTrZ9fs5zO8Pl9PcEg9kLwTkKAC5ZrDLmc8DaXsQ/YRT3HkA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AS5PR04MB9825.eurprd04.prod.outlook.com (2603:10a6:20b:672::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 07:12:11 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 07:12:11 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	imx@lists.linux.dev,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v7 4/4] can: flexcan: use one rx-offload source per IRQ line
Date: Fri,  2 Oct 2026 09:12:03 +0200
Message-ID: <20261002071203.1287650-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002071203.1287650-1-ciprianmarian.costea@oss.nxp.com>
References: <20261002071203.1287650-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P250CA0027.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::32) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AS5PR04MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c5ee79-6b4d-4cb4-7cd8-08df20547a57
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ltFbmJbBPnyZ6iJPYj+l1Nv41+vAoMveZPv6TOrlNpPO0cBm4hTVn3Poxa4eAEqfeHYj388u/HcuxnV8sYHlXO44CoGHcp74qpWn6bn+baIJX4Mp+c6+fSkokwpKs8ptwF30XW1bAIUViA6Zp/Cr83tN4MfV99ACc5K3UWM0BWNXROKypo+fDkcjgCt+nDYAkM2GzlkL3kDDSpE0QmDbOAEf5xmM57P5jbwwp9bAYotjsNWrr8o3ZuhsKBG3phEFPZcFX6y4J64zKoxnNRVyq2yu8XuMbPvLMar1FjxVoxSJP7S/IonV4OGXijQEYhj0YJ8kyCfcB/NKNGNKaopOfXQXuv4elbcz4coMaKV0mhRI3tZ6p0qru9op1YeHxzU4qgeJCezwOuBfx1N/Kv47U+1Vd1LI+7vxNCEf/bAkbFxwplhkyEncv2AbCzfpAGkQxIvtmQHNixhlAwtYeCc22lYgEFrNLW/lOQXRbjJxcR0sVOVVfFvv6kQsHGjCi/OzndsYdA9O1WxF3l3CPA4HqYVBeXCkYBastL1ig0Gr8ndXomHLX9F2eMTejXCmtjEtn9PMLgG8bNVUi7+BInzL/IEPFmvSM8c4icp69UAWANAc2+v22tLksm3z/lDOn71XuQKwiO1LGgpOv+Alkl4BIxT7I+ADNgDpMn9H2BGXANc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cERvNHpXcjJYaXhpZFAxK3llQSt4cFA4OGptUHNTU0EwNktJaXFIWi8zcVh2?=
 =?utf-8?B?eFlkV2szc2xqaFNySWFUTVlreFRkZ3dnTldiU2ZPUGRnUG11ZkwvQ1h1Ylpl?=
 =?utf-8?B?UmZ0Y1BZS2lNYWNZc1JIUzZ6SFdXdFlsVTl4OUloZnBlbmY0VFZXdDFXeGhP?=
 =?utf-8?B?M05Kc2R2WGcyL3NPN2d1aDVjMytmMllXMkV1bW45djh4dnB2ZjV1LzRDdkV3?=
 =?utf-8?B?bUJhZkpyaGRDRkRKZzRVa0NTRzc2MHBObFloYlRMU1poL3lwYkdDTzUzYUc0?=
 =?utf-8?B?a2RQZm1nOW9DRDMrS1NNQ25uWmp5V0QwMWtoSlpNQVhVUkg4OFVLUGFQelVF?=
 =?utf-8?B?cFV4NEZsNWJSODd5VC92QlhyUU1MYXoxSFBacy8zczk2a2ZFVzl6cVIwSEZ3?=
 =?utf-8?B?TG9iNWI0R1hUWkgvbmtqZ1pZQVgvcXdxdmIyRjNwOFVKQ1RidFpNZDBjdVV1?=
 =?utf-8?B?VE5pckhQVHNHakROa0VGWGJZL3NrL0lFV2FvMlVtYnhNOHF2YWsxQmJWNVBM?=
 =?utf-8?B?U081TXpTZmJrU2c2YkpTVGNFbDN4U2djL3N2VCs4bzdqWHhpZ01FOTQ2ZmhE?=
 =?utf-8?B?Vi9KZnpwWkdKRVZIN09RaTB5SHE5RDlkcXZtWVA4UXFlY3p1QWRIeEc5Zkpz?=
 =?utf-8?B?MTF5cUJFNjlOa09oblU4cXNiRloyL21rVWxWWmtwbEYrTlRtSHIxU0dRdy9t?=
 =?utf-8?B?QkdUamZjRWJUWFJDcXU2SCtBQlFjSlBNbW1vZTlCdTJzZmJLTjEyNzFEeCtJ?=
 =?utf-8?B?RjJQWnR5aktvTU5nTnRDazJoWlV1WVpZakl6Rm1pcTM3d25aR3YvdHRzRUpX?=
 =?utf-8?B?aDFKZXo4aTR4eENLZ0dLZmU0aThjWU5JNEN0dEVJQzhoN0dqdE1KTTJaN2FY?=
 =?utf-8?B?c0dyUE9UR1V4RXhrWHZROHlhYzJ2RytPMWl4Ym5SOGRSdldOUlVNVzZjRjlX?=
 =?utf-8?B?UmJzRGFzUHh5c1BrZFRTUlJXL3Q3T0xtZXlVSWFwRDVlR2ovelhKdGlxU1Nl?=
 =?utf-8?B?bW1MN2ZXeUI2QVh4MTVhY1FHdEVSREc1WENVVHVKYWh0anVlbUhpZENCelpt?=
 =?utf-8?B?UVA5d3FBT0d6bWJzUTRHUjc2NDdDblNCbHVZRkhrMlFHWFhnMkptR3htQmF6?=
 =?utf-8?B?b05GMHR6eWV5N3ltWUwwek5Uay9aVnJHQmt1N3pLM0hKMVNiMUhYOUxyejRo?=
 =?utf-8?B?bXh3ZTYyazluRnFtN3pxaXBmL3BZNXNBcTRiOVQrZWFvS052QnB5NCtvaUlK?=
 =?utf-8?B?MzlNWkNzRVM1RTN0dHhoUm1EN2kyeEtNQzhza2NSUytUOWw3MnB5c0g5eFBw?=
 =?utf-8?B?alprU1ozTHVKWXhyMk4xTTRLN21Oem9GQ1oxcVlIL1dOYms2UUdXbXdXRkZq?=
 =?utf-8?B?ckdmdFlqS2lqMnFHZi9YUGJYNHM3VlZ3bmN0b0V0azJhUVdIOE54YmVVMFJ3?=
 =?utf-8?B?U1pYQ3E3azdweHFWSjFvYm5OZXBMb0Zsck4rRDRHdHdYUmJZU0ZKdGVnZHU2?=
 =?utf-8?B?a2FvRFgwbm9hOE0wSmorSVVkTGpYcE1YWFp1RHMwbkx2cFA2VkxzMEFIQ1Q4?=
 =?utf-8?B?NFhuNHphSHJ0UXlkWnQ5bkRQOVFlWjFWU1QvRUk1VnFEQWtYR1N1MGpleGFJ?=
 =?utf-8?B?OTlwbDFlbU8yMXgyQS9heDVIQWhOZFBlQldPT2pJSTlWSXJoUlh2cE5qaWFx?=
 =?utf-8?B?Sit4K1NFUDNtZFozWUtSOFpabjRhVUtLRVdwR2J6Q1NIcStEck4vZjAzd1p6?=
 =?utf-8?B?TlZ5b0VnYmJLQVVRcENLTlA1WEFEQ1RQVDhLKy8yKzFxaGtyekZZaVJ2Ynho?=
 =?utf-8?B?eW15Wk5NMkJlQkRuUzBpRGVsS2dHZUM4U05Nd1JmSWVJVXlaOC9OZ291TkZD?=
 =?utf-8?B?VG9sTlVTUm9HNkgxeUUrUXZBamVjajkwZUZuck9VL0tJYk45aXhFL2NLZUVr?=
 =?utf-8?B?V09BT0FzWjV3VkVRdHA3RzNmdUF3QlFiZk9QYkhsY2VObnRWZkJ5UWJZcS9t?=
 =?utf-8?B?bmFadXl3aTVBa2RkQkxxLzlidFR2aG9CKzNPNGw3Nm5NRXlkRlcyR0M0TjVl?=
 =?utf-8?B?Und5dkVidXkxVHd3OVBjZ1MrSmhSQUI4ang2TERLMjg1SnQvNDloREQvVUIv?=
 =?utf-8?B?bzRMdGhxZndnblI0TkZJdTgrS2FlY2NMcWh0RmlGL0k3S3VISWhFeGJJR0FE?=
 =?utf-8?B?RkRHQklROU9BVzJMVE5uTzhGZGRlaU11NHhxcmo3ZjJaN1pGRUpmbzU1YVZ2?=
 =?utf-8?B?ZnhBSlV1UVo4RmUyWG1KUiswMTlmeG1CWUZSSkFaak1iQ2pTWkhTditJTTRH?=
 =?utf-8?B?YUUwMTdMdjVZbCt2N2FaT2t6cUJ4YXlGbGI1ZDR1SGRlNG9hN1NpOGZHSDAz?=
 =?utf-8?Q?PMD2Y5ukCFCvcD68=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c5ee79-6b4d-4cb4-7cd8-08df20547a57
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 07:12:11.3749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNimq2T29MnrZkxznk4D04H9kOxuqEL8HfV+hruslMhQq3GkbRVMEO386rnFxu6pHybeoiRwvqByJtXv/60I9Rdnp0HkLLqvg5t6wPJ16x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9825

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Currently, flexcan_irq() is requested on every IRQ line of the
controller: the mailbox line, the bus off and error lines
(FLEXCAN_QUIRK_NR_IRQ_3) and a second mailbox line
(FLEXCAN_QUIRK_SECONDARY_MB_IRQ). On NXP S32G2, which has all four, the
handlers can run at the same time on different CPUs and corrupt the
rx-offload queue they share.

Add an rx-offload source for each extra line with
can_rx_offload_add_source(), pick the source in flexcan_irq() based on
the IRQ number and pass it to the functions that queue skbs.

flexcan_mailbox_read() is now called with any of the sources, so get the
private data with netdev_priv() instead of container_of().

This only fixes the queue corruption. All handlers still process the
whole mailbox range and the same ESR events. A dedicated handler per line
and splitting the mailbox range between the two mailbox lines will follow
in a separate series, which also removes the lookup added here.

Fixes: 8503a4b1a24d ("can: flexcan: add NXP S32G2/S32G3 SoC support")
Assisted-by: LLM
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 86 +++++++++++++++++++++-----
 drivers/net/can/flexcan/flexcan.h      |  3 +
 2 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..2ef06ed0c744 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -828,7 +828,8 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff *skb, struct net_device *de
 	return NETDEV_TX_OK;
 }
 
-static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
+static void flexcan_irq_bus_err(struct net_device *dev,
+				struct can_rx_offload *offload, u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
@@ -885,12 +886,13 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	if (tx_errors)
 		dev->stats.tx_errors++;
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(offload, skb, timestamp);
 	if (err)
 		dev->stats.rx_fifo_errors++;
 }
 
-static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
+static void flexcan_irq_state(struct net_device *dev,
+			      struct can_rx_offload *offload, u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
@@ -932,7 +934,7 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
 	if (unlikely(new_state == CAN_STATE_BUS_OFF))
 		can_bus_off(dev);
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(offload, skb, timestamp);
 	if (err)
 		dev->stats.rx_fifo_errors++;
 }
@@ -967,16 +969,12 @@ static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv)
 	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->tx_mask);
 }
 
-static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
-{
-	return container_of(offload, struct flexcan_priv, offload);
-}
-
 static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 					    unsigned int n, u32 *timestamp,
 					    bool drop)
 {
-	struct flexcan_priv *priv = rx_offload_to_priv(offload);
+	/* offload may be any of the sources, see can_rx_offload_add_source() */
+	struct flexcan_priv *priv = netdev_priv(offload->dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	struct flexcan_mb __iomem *mb;
 	struct sk_buff *skb;
@@ -1070,11 +1068,34 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 	return skb;
 }
 
+/* The same handler is requested on every IRQ line, the line it is called
+ * for selects the rx-offload source to queue into.
+ */
+static struct can_rx_offload *
+flexcan_get_offload(struct flexcan_priv *priv, int irq)
+{
+	const u32 quirks = priv->devtype_data.quirks;
+
+	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ &&
+	    irq == priv->irq_secondary_mb)
+		return &priv->offload_secondary_mb;
+
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		if (irq == priv->irq_boff)
+			return &priv->offload_boff;
+		if (irq == priv->irq_err)
+			return &priv->offload_err;
+	}
+
+	return &priv->offload;
+}
+
 static irqreturn_t flexcan_irq(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
+	struct can_rx_offload *offload = flexcan_get_offload(priv, irq);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	irqreturn_t handled = IRQ_NONE;
 	u64 reg_iflag_tx;
@@ -1088,7 +1109,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv))) {
 			handled = IRQ_HANDLED;
-			ret = can_rx_offload_irq_offload_timestamp(&priv->offload,
+			ret = can_rx_offload_irq_offload_timestamp(offload,
 								   reg_iflag_rx);
 			if (!ret)
 				break;
@@ -1099,7 +1120,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		reg_iflag1 = priv->read(&regs->iflag1);
 		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) {
 			handled = IRQ_HANDLED;
-			can_rx_offload_irq_offload_fifo(&priv->offload);
+			can_rx_offload_irq_offload_fifo(offload);
 		}
 
 		/* FIFO overflow interrupt */
@@ -1120,7 +1141,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 		handled = IRQ_HANDLED;
 		stats->tx_bytes +=
-			can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload, 0,
+			can_rx_offload_get_echo_skb_queue_timestamp(offload, 0,
 								    reg_ctrl << 16, NULL);
 		stats->tx_packets++;
 
@@ -1143,12 +1164,12 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
 	    (priv->devtype_data.quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
 					   FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
-		flexcan_irq_state(dev, reg_esr);
+		flexcan_irq_state(dev, offload, reg_esr);
 
 	/* bus error IRQ - handle if bus error reporting is activated */
 	if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
 	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
-		flexcan_irq_bus_err(dev, reg_esr);
+		flexcan_irq_bus_err(dev, offload, reg_esr);
 
 	/* availability of error interrupt among state transitions in case
 	 * bus error reporting is de-activated and
@@ -1189,7 +1210,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	}
 
 	if (handled)
-		can_rx_offload_irq_finish(&priv->offload);
+		can_rx_offload_irq_finish(offload);
 
 	return handled;
 }
@@ -1381,6 +1402,15 @@ static void flexcan_ram_init(struct net_device *dev)
 	priv->write(reg_ctrl2, &regs->ctrl2);
 }
 
+static int flexcan_rx_offload_add_source(struct flexcan_priv *priv,
+					 struct can_rx_offload *source)
+{
+	source->mb_first = priv->offload.mb_first;
+	source->mb_last = priv->offload.mb_last;
+
+	return can_rx_offload_add_source(&priv->offload, source);
+}
+
 static int flexcan_rx_offload_setup(struct net_device *dev)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
@@ -1422,6 +1452,30 @@ static int flexcan_rx_offload_setup(struct net_device *dev)
 		err = can_rx_offload_add_fifo(dev, &priv->offload,
 					      FLEXCAN_NAPI_WEIGHT);
 	}
+	if (err)
+		return err;
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		err = flexcan_rx_offload_add_source(priv,
+						    &priv->offload_secondary_mb);
+		if (err)
+			goto out_can_rx_offload_del;
+	}
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		err = flexcan_rx_offload_add_source(priv, &priv->offload_boff);
+		if (err)
+			goto out_can_rx_offload_del;
+
+		err = flexcan_rx_offload_add_source(priv, &priv->offload_err);
+		if (err)
+			goto out_can_rx_offload_del;
+	}
+
+	return 0;
+
+out_can_rx_offload_del:
+	can_rx_offload_del(&priv->offload);
 
 	return err;
 }
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 16692a2502eb..0b09e94d0010 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -88,6 +88,9 @@ struct flexcan_stop_mode {
 struct flexcan_priv {
 	struct can_priv can;
 	struct can_rx_offload offload;
+	struct can_rx_offload offload_secondary_mb;
+	struct can_rx_offload offload_boff;
+	struct can_rx_offload offload_err;
 	struct device *dev;
 
 	struct flexcan_regs __iomem *regs;
-- 
2.43.0

