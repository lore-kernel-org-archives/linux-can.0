Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABC34EA393;
	Mon, 31 Aug 2026 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186905; cv=fail; b=V+sFSlH84NeVMwABAbW6GULBgxtJzPOq3EC+B0Gb5m805A2g29MEUoyo58MWuC2a4L/kTSfWGwPDHchV8NLLE3jODQuqg2S8wwAOhNti1KlBEdVrk1iTbzuXrL4k/6fd4ns02Z4l8tmNFxhe3p3ZfCmYd/HHeYJ1xTGiD3G93Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186905; c=relaxed/simple;
	bh=0hES/NMnr5DnMHWSKE0bizXfy2zVOsfRvDMlRiRaavg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EOcgDQuXiSCVXkLz4RsKsz9rpl0zbKunc0JBwJJ6ggL+wBhVl6n/wzKIGCZwk+2Er3jsXeeJFC1LpBsD9RTXksBD6rMUK4atZPQQP9dbN0VtO9Z74J0CMKbBpk55MOq4MKiCfZZVWBUnE8GkLk/1tZSbQd0RCVkcj4tiNElAVtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FjrBdvgN; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FjrBdvgN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxuDJGVQDH1OEQmg25WOrIc+gkx1c+jygt97Bwmlf931P/scYJkQjVqf82oC2mYanQqYx0ylHiFhSHxahyqnKlC1cTtINfYirPCNQmu3m9IzujUcxvqZrYI9L+wB6msU8FvU/qPaUiFBg0wAI3d+pvFA+BFnigjOlMxKSwoWMv1vfrErqnv3I0QFWYDwhPJMcVFK4NNfONV0DGi3o8hNC0zs/xF6BUf3g33JTrAM0RSU32nuk8XkzBtRRzPvlXe8j7FSddmJqliUcXcf2pS7lC+F15yGCFuot9MSqB7Gtl837XWw76qjnHplH3Ky9NHjdfRSr9egKHthYmlnKCfZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3b7aFrDTMdy22HjQcTIJRwZNC/0hJnvYKlfUwiNMKYM=;
 b=Q8DyZ8LmnR+Y89nfMgOm8Yzw/BQ6TeKeekGUpEbBzcYYQd8r0KA/wj7yXRPg2z4h17mVeKyScTeuUOg3XqpqE6aBhCuxmJNgL6tB1+6Nk3VLjAZwb9NK7zu8j7ar1KPlm/3spEP/Nkrvt41WSBUvPyMlL5KlVYJSaOBO9ta8q+2qTwKUlxcjuKdp4BBxLo2MWTUiDbwiQI8rX3kAyX8gsaaHMfjuDC+p8Tog0d2WoBqGjvu74HH01obmXRwCIqVOA1/QOpjJK2Zd1JSzFaRvO+y1ZQ/wNcbTWZYJyWIxa56/yILZjLMZWxAdlouvG2RXZ03+RitWoR/ws2brV7AQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3b7aFrDTMdy22HjQcTIJRwZNC/0hJnvYKlfUwiNMKYM=;
 b=FjrBdvgN7qCkPgTkFqynA2qP+rPb7ehnrRmrQlxb+lSEMWgq6SCHOM6lBLScUOXwajpVW5t+WsILUOHW3JhXkhzris/IFKfkxAzZOdX8V2CEscPX6m02EhCzr9BRjR6vlgD6eHvEa3FaKahf+g3+As/b3JXh6amJ71xeOU62xphoxDmGUKtFcc5C9e6MC9PoZLxBwwHeXLUEpRwbTlNUNLZbI5u3YfDM0a9+mu7o5TQgagsuC5G6/plxKrU2o5svN6XMbrUfWN5XYFBE+8lQ2hYiGFXnGzTlyEkx9cy1Sl+6v8xQWnAFHI60VJIe7Je0dmw340aZPptzn1Lh5Z3j2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:34:57 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 14:34:57 +0000
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
	Larisa Grigore <larisa.grigore@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v7 5/6] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
Date: Mon, 31 Aug 2026 16:34:48 +0200
Message-ID: <20260831143449.12828-6-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
References: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0191.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::28) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3ea235-b4b6-4d9d-f121-08df076d07ba
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|1800799024|366016|11063799006|10067099003|10063799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 H4zvNg0YcgpGtf0VByLx9O7yx62UV1pktqUiPlHcMeuSzS6pCikM6mZmsj8ijogOQo+7wMuVkJKmFbvvVGM5FB4VsrogTxsXW6nC5p/WtlUbo101MkzuAY44p4+9peXtA0kxMXTyZGom2asbunyAuz8z+scxWsNzax+SzTI8shbAdYAor009hXrTshweB9xeBr4NuDVihKDmaLZQR81wu4YfGACYCE32BsNCWZubinAjsHOyOt4PuXdINzFdLXLoO5ybSbatlFG/ymaHx+wXgh8Y6msX5Q6LPyWFQP+IUYwPaiW5TBUQe93fHAJP7JaDkJUj4Klrt8S6m8hadwQWqIn5qcW2bj+chNVaBtZ/6XmuvAEGwEPEk0Jsn6fCMvRLwRvtA3z6/OB5RiGOxrE+8hVrXwE0h6uyicEBmidUKb9Ph8mdjhtPJE2uMlF6C5XTYPCoY8CKHmFNqLC8ztfsxralUf6OLn49w+FdVXAK5Jgb7P7eoQhtK6XCtjd6eS0vq7Wdtl5pypfD16vqQysTIXWBxM0B0Gtgt8cOLjEnWZhZBJmWJz3RklYKveNx2KGk52fserr5D2jwqhhSaZMITsQS8MEsCCcQ40euqZ9nQqaxPvvgnY+PDv99ic51wCMjYczvYlAyRlpIBD1GQqBZ59CXN+BJFEjID5YRI77EvbM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(1800799024)(366016)(11063799006)(10067099003)(10063799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WHBWT2o3Vlg5bytWTExNdHQ1OFFRVUthSm4rTWlpRkZnMmhyb0wzZEovTm5G?=
 =?utf-8?B?NERUTEQwdUhUQzdNK3F2anpnRWtnczZjc3VOWTkrNGZIWG9wbkhXZUZQRDBC?=
 =?utf-8?B?WFF3NVJySmNXc283NlZ5OGd1NVl3ZWJuRk5LRVVjUUtGaENNelIxanBhM2Fa?=
 =?utf-8?B?TWx4THZaK0pTVUpoeXMyU1VKbW42Q3hReTdPcjBhcjVtNG5hSHJSK3BYOXNI?=
 =?utf-8?B?N2h4MXlFaHBYSkN5Tkc5aGp5c2wra3E0aW9DMTE0eFFPUDlCOHQwTUMyYzA2?=
 =?utf-8?B?SXNVZzcvV3ZqWnV6SldwVCtYMGdBdE5ZS1Y0VDhYTXBkZERBNlNOQmZKM25G?=
 =?utf-8?B?bW1hanNzaXpNR3JVWFErNmljWDhKdkRFV29RZTU0RkMyaW8yWmpkSG5wbTJH?=
 =?utf-8?B?bnVsL2ZTN1BCTEdGdVpZK2FmYU1iMUZ2UUJUK3JxUU5ocUJNdVhscHpBcGM3?=
 =?utf-8?B?SmpTMXA4NGlPL296RlNnTjJpUzIwQW1MMm5lMzlwbVJIakVCNU9kSkZDeXcr?=
 =?utf-8?B?QWZBbEJkR05HeTMyS2RsNnJKdWM0cmNNOVJRVDMzM28zM3UzVWdSOFNRWG96?=
 =?utf-8?B?SjlrMk1TVmJnemsvSmJ2WnZERTlEc0VSSE1wYmV2M3FpN3Yyc1NyRmg4dVk0?=
 =?utf-8?B?RHRpUStCNnF4ZjFMSFpiTXgwTEdxekFDMFo2dGhFYUdpMmpIT2wvOG9NSVdp?=
 =?utf-8?B?ekhYL2tTZ3RGRGwwV3RGT0NwaWNMTTRQdzFYM0VyTUFqY3ZYSGhSb0I1YjVy?=
 =?utf-8?B?OGcybnpLWGZrUldzV2tZRDgxcGUvczBiS0N1OHk0YVRSejJ3dHVEWEY3MlV5?=
 =?utf-8?B?K3RjTmdtS0JkRktCSUpyZ2loZ0pBVlRQbkFiZXBtMW1OSllCRzN3Z2EwMGpK?=
 =?utf-8?B?bEJmZzNSdDBpcFNSY1pwRTVBVmJJSEIzbWM1ZlovOWRnQVdhWFM0WVZaZUh2?=
 =?utf-8?B?ak9OVnk1QnJTWUV2QW1xRHE2S3MwVWRHT0hya0lIaGwzY1FpWEplSFR1aVhs?=
 =?utf-8?B?VEJzQi9YQTNWZDg0U1pIZy9zZXFqcFYvdWtsK0kvZk1OOGRBZGwwa3F6M0Mz?=
 =?utf-8?B?aW93THlldER4ZzdmT2ZOTlZza3BIYUY4Nmk4RGNja0ZvZ0VuTkE4dWRYMHBY?=
 =?utf-8?B?alc3bHdqMTltV1BkaElYaitickdmaG92U3VMbTY2WjhpU0VmYmJGYzFQanR1?=
 =?utf-8?B?VkxhNGpiY2NteURGeng2REVzdVp3RVZ2UWkzWUZXbzZvVFYwYWo4dzh2VnBE?=
 =?utf-8?B?TVNPMUJ5MXE5SnV0SXBuSWVvTGlkdjRiNUJSdHdRQ1NPUTZaWjRWNnZzZXc3?=
 =?utf-8?B?WVZsbWIyWUN0Z3NEK1ZJRnVCa2k5SGJwekt0U3d2UXBXais2c0l1SnpxUjJO?=
 =?utf-8?B?Um9xc01MSDZBSERzM3Npb09iWjhYaWhFeWtUVE1FRkVKWEEwRGlxcWFhKzVF?=
 =?utf-8?B?RnFjQzlrV1F6c3ZMZWpzQkczWXVoSUZkRUZpQkVuaXlXemxRZEZFeEMrckQ5?=
 =?utf-8?B?OTc2QktDYUJpaHA3ME1hQ2E4bjVBTjYxN1VzVkZNNVRjaVM1c251K2Z1Vm5D?=
 =?utf-8?B?WE9UV3Z6aGRYSW5QZzdaei8rRVJIcjJGUWFpV0RpTzFxWDQ3UzF4V1lxeUh0?=
 =?utf-8?B?MjN6OG1scnNuQzRkeGhHUnUzTWtYNHJzc2VFRXFuY0tRZDlKMHhuMTYvem1X?=
 =?utf-8?B?c0pZNUN6UTVTS2xlMXlCcjBtZUVLbVYzblc5Q004TW1YUVRPbGZhVUFiRlVO?=
 =?utf-8?B?eFp3clBXY2tpdDgxdlIyRS95UWJudmNEMWM2Vm5NVkxTay93Wm9mNnNHMUxo?=
 =?utf-8?B?b1RiRlZaQWdISkVtR0IrbTUvbWZ0Y1kySGhJTlJCRVIvTmJNUzArblBsakJC?=
 =?utf-8?B?eWhWd1Z6RVFJQThYZGwxbG15VFJXQ0lQb0U1cEhRLzkyNzJSRFRuTGhYZHYz?=
 =?utf-8?B?bTA1S2Uyb09OQ1g1N2Y1K1cwNFJBelVKOVNqZXcvL2RReUdkZVB1SW9qLzNa?=
 =?utf-8?B?OXhFNUZ2NU1ZOFFna3E4Y2hVdFNvVXB0RVowNk9LY2tXWW9UenE1c1dVK2RO?=
 =?utf-8?B?enNIUWJRUXFMKy9sVzcxc2tpU0h0K0FwVXV3TUdMUFo3QzZtVjZhS3lPNlVy?=
 =?utf-8?B?SFZuUFpCWm1VOWl3UmVzb1hHT0dQVUE2WjJ5VUEreko5eG9LVDM5cjQ2TXpw?=
 =?utf-8?B?Qi9rZkVMYS9UQzAwc2t2OHRpRHZlTEsvMktlWTcrMXZqVGc1VEZtdmtxU0Jp?=
 =?utf-8?B?MERJcUQvSHVZZUx4bEVuK3BzbGJiWjBXdHNaYWpLd01OdFVyR1JZVE9HTHV6?=
 =?utf-8?B?M2NvMkRKRkpTTGFYZmZWY052dDl3ckgzenRvSXFENjdkRkU2WWsySGIxK3Zj?=
 =?utf-8?Q?Sli1J1nnrAvmrpeg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3ea235-b4b6-4d9d-f121-08df076d07ba
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:34:57.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Au5mr3AMjWgm9f9EcJQoKChDne5vFxYKEFxiCjOHdt47gETGTqkUC6SVWVDGnWF6tOFnqgvAHkM3BJRehFodgsxi3/MVRu7iJxvZDGIxahs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606

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
index f28ff0e95b74..601d88bfcfeb 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1303,6 +1303,22 @@ static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
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
@@ -1543,10 +1559,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
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
 
@@ -1557,10 +1573,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
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
@@ -1884,7 +1900,8 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		err = request_irq(dev->irq, flexcan_irq_mb,
 				  IRQF_SHARED, dev->name, dev);
 	else
@@ -1905,6 +1922,13 @@ static int flexcan_open(struct net_device *dev)
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
@@ -1919,7 +1943,8 @@ static int flexcan_open(struct net_device *dev)
 	return 0;
 
  out_free_irq_err:
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
@@ -1951,10 +1976,12 @@ static int flexcan_close(struct net_device *dev)
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
@@ -2341,6 +2368,14 @@ static int flexcan_probe(struct platform_device *pdev)
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

