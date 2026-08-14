Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7635E930;
	Fri, 14 Aug 2026 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698217; cv=fail; b=Q+mgnIRVh8NE/yALqC+97/aJWbF8Z2w8dcXjdmSd0kiE0hzAUsUvbPRWcM4kH7ZL1ROLhzgMRYIJUBdSnfT6l24dMZbGDoUAR+wMQ780jgV2/lZJ5QnDDsHWidQldHqJjtD6YvVM4CdReZe8G/DOyNhe8Ar06yna3g3TcG2C/xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698217; c=relaxed/simple;
	bh=qhmfD2AxaOMuq+vy7TjZkkjjqyVbXAB2QMnIDx07L3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YMe7romoPoEXbQufrDllv4zYxHvhcb7pvbRuZSmISUlqUz4i0L8GyajCF6IIy00swWm3i75Vi/Fg+TCzSTBvJpwlvJDc4TRQjCfIdV2bOsP+OABEjVU33E/EpIZNcmpBtjwDu2pyTsHlG9OoVMHBrKeEsZkfSavvDEW2cFILERY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WDcH0+PG; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WDcH0+PG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uo+UQSr7YALTaR/2XT+H2fM/HvqhQLD5KW3EPqXpL9Pg0g82ywcdnXtbCBJOBAmI4RFXnVya3XWzn2wGyTL9oiyJYSdfwzBhX5VMxG3cOH5DWq2usqo3mPaIIUTFH8Wwtn7j1c6oCxf2C/q51DM2FdjbGdYPTm5F5IfZqHV0fcSs76R59+JM9UUHVBjRWCsg2K8PuijSusbRXNC3uqByJguQQpZZclK6bFiZsyWZkVWVXhjSMpvgppVehOU7rU9rn0U/xkzxBMOd6u07B82Cg2PeQxH7r7LE59lpMY3y9PBjTWuv54PwDGRqZ1JD+YQukbHgN87chSc2aPxgZDp5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cr5ij74tYnvdvl7zgYATzrBfCWM7e2nHzLUYpxmRo00=;
 b=XrNN/fX5VrFsFNMwocvKWQLclzUwoUHNCmZ/uL/ZpEMy84ki/l/zeku18HSoYCoyk4SOi5JolByYrzm83K2x8sVmt8TmjaFtlqeL4CPd0ofHxg4kAhzLd/7xcjd0w4BKdoxRqLTCzZMEJ85nApjhe1vSuzUd0IloAq4ObAL4Px1D+Exwg+sZTdaoJcHzOvZxesPy0QegsN01FOlC9MRJ2lz1YeXyJAcYyKoHeXrdfe5zajPKxrHM7WcvNpLwhR9/zOWbSgMu9C/u4uWfQhFtuKjLsljXBRvr0p0cfPXAKzJmkQ/F4FRhLwTqAs2CGZHknVuIjw/7Xy3aKudjpGd4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cr5ij74tYnvdvl7zgYATzrBfCWM7e2nHzLUYpxmRo00=;
 b=WDcH0+PGqNyzV5jAfNq9edG56F6H+ypsX4geJuaac9HR6nBLEYI7w8NS8W8bKRDWcP8rLdMKRDOqnawwa7cqtvqauG1i3ZswR4tnl/cWX7ZTTRLXtmVWhT3p4cTK2PEtFvrZHGata6x7eniE4lUuZ0iRBuIfohS17KPLRl2V1GP1wCwbZJm0c3SwQ7CJm2GHulEzkKjof/8n/nDnk16heF6FlIr+PZiZoUJAI6noeyE6IC/yD7kv99kWhN/acXRbdWrUvyABgIrUasnTdwslBE0EJdI289Xze178ZXNewaSKZsfGNaowDE5OLoyE7f2d23bqF8/2scOdx2TZCDG2kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AMBPR04MB963705.eurprd04.prod.outlook.com (2603:10a6:20b:75d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 09:03:33 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 09:03:33 +0000
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
Subject: [RESEND PATCH v6 1/6] can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
Date: Fri, 14 Aug 2026 11:03:18 +0200
Message-ID: <20260814090324.647898-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
References: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::8) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: c9c215f4-94a0-42f3-ef1e-08def9e2eac4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|7416014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 J9bBHhImZew4qhKUZxG5POZXF228FPp4Bg/GQO8IOxSm9hrfSJJJqTkgeaNJgZbbEWOC0WpgKVmdmKrXszG/saCbeOyhpNUYTQZqUnnJ7q8kP0sv/T6jDY21ExlJL2I9pgSGsDi8oIUGf1nndDWT+Ur5Drg8LkuWwxXtxzUOMnrvWh2nVK0SiT6zumAESI2QY8S0Dj7elP6atGlMPr3x/7kGYQN/Vqz8r/rl9YdXsWuPFxV1QbtWCeJBXfeXcHkZHe1NshHIvLSeLKiQy0NHd0nFhJ1hJOwlwm1vmkBzauz3aHEacQEdHqKb84nF+QWEHfO5Ly4O7zS2yZlo9Nv204dIKaav5qybSmIaDzinNTtdlfOvTt2T8PvU0cYtLwK3CFKSf8Ihl0Hsw1qs9d8iJhdrTa0QGAwsMWurrh3wJmyzlPf7e6YCJI/gUvNMnHmkB/GX0Va5kTzrRVEJn+NZ4nA7EsvAW7LAI4biCGNt+fDwx4GwJBMZRmwT3/y/V3zn2wVGtLnJC4Ql6ZNk9pZRDy84DTbEAbLN6oW4QL5Mg1oyf9sCsN72+hNaGjxdrjdOROTIV3iV/icCBfp39VcD3d6PMItHexh/jIU6t9+dREnstvfLJ1A/hQUVZ5fznqy5ppE6Pzwmj7Rkhg6WL8KHDcKkugVn8L4I8hx9iVUuBFg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(7416014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RVVYODlOV05YVXQvMy8ra24zWmJGU2RvclRiMk1ZOHMxQjhmNG0vME16YnZT?=
 =?utf-8?B?SWxiTGp1enRCbHphMW5NQkxjcUdDS2dmWGY0SXZ6aTMzNHFPckdKeVlxUWd5?=
 =?utf-8?B?cUVCNU51WXAvbThnNDFPNEVMVllCQThNMStNOFFqZDBrTE12dVlLTVhNMS81?=
 =?utf-8?B?NjJzRkhvK1dwaGwzNzJvSDhGTDBMVjhNWTZMVUFYemJON1lmVnV3MHZjQkFT?=
 =?utf-8?B?K05zUU9LZ3UvRmpIemhrMmYwMTFPR0ZGMDQ4TXRpYkE3aWhnUnJHUHhjVEdj?=
 =?utf-8?B?VDNzYk9INHdlS2Evb2NCQlQ2OFRTdkFycGI4dnE0VG1qZnRqM0F2eXFEdE1J?=
 =?utf-8?B?bEVQRzJSOTJFOFVKaTJ0aTE0ZWdxWHQ2cG40Q1Z0ZTVoTzBlSm1JS2N1cFgv?=
 =?utf-8?B?aVUwMmpVNUQ0UlVtZ3VIdlFvTXA0dFAweUVINGEvaC9BMXhNbkVDdk5IOTFH?=
 =?utf-8?B?eUovUmpka0ZSYnRNZmdKTUlWdG1OSEE4RmlxUzNDT0xQMUpPZ3dYYXRGVDBl?=
 =?utf-8?B?MGpxYnhKT1JZcXh1QlZLZTNLa2lwRTBKTk95cVhwSXBpTnQyN3BHWE9Db2V0?=
 =?utf-8?B?amluelJyR3hoOVJJc1IwblVuWThvSnA3RGtxTGI3aXFQSEFIeXBtOG9oSzBn?=
 =?utf-8?B?QTU3aGl6Sk1qWkRzY0lLajJSTWdWWXRrU1NpdVFzSDVtQ2hnOUZ3WnR1YXRH?=
 =?utf-8?B?Z3QvbVZxOHBzS3VSSXUzbTIxY1dESEs2bC9peTNwWTQvdGI5aWhPOVdZaUN2?=
 =?utf-8?B?N0hHZGpWZ0Z1cHRNWlR2RzU5eTlPdHowby9RbnRkbzJaS1NTVEFVRU01a0tl?=
 =?utf-8?B?VTFERldENEh0allDMlppT3lRWFYzeEVwTGFiNDU0VmdVRGhBTi9LdlNPekcv?=
 =?utf-8?B?K1g4Z3V2TzRQRG5JanF4WlpnVUhiTThvVndiNUIwN1BQRW8wbFFPWkkzSVZV?=
 =?utf-8?B?Yk04UEdEclA3ekRieGRNSlVoeXNub2VkVGxzWHBLaWNvYkhid0lJRE5ibUhX?=
 =?utf-8?B?bXh5NlIyemdla0psNjBOcFBscHdyNXZTellTTmNCOU9mTG92bWl0eGd3RDQw?=
 =?utf-8?B?UTdlWDdtZ282TnBBMmxUN0FCdDZuK3h3MGdSSERiSGk2bVV3ckg0dDF5YWN1?=
 =?utf-8?B?eks2STVrbDltOUNrR05iSHYrZGxxOFBSSkxja3BSRFlkWGwzeWF5anhBRjVi?=
 =?utf-8?B?alcyakNsMVNwakc3dXlXSEViUWFEN2pRbDMxOUtUTEEvdXV0YTJkdGVqS0Zk?=
 =?utf-8?B?R3hycWgzQmhKMFFnNDZWSmVQU2pUWlRuTlNoRmJjS1I1L3pLTmNlK24vZDB6?=
 =?utf-8?B?Qm1kUW1Za09Ha2h2RnlXOUNSQjdzQVJydE5PUENXTU9lNEhhN2kvY3pMbml1?=
 =?utf-8?B?cXkwZk9lZk05bEJwUTVhMFptclJwZ2V5Z3NLeUpxTUk5U1JOSnptVENjTCtZ?=
 =?utf-8?B?TGtGUjZ6MGpQK3ZWdHFlN09wai9Ua1l4U3lIdy9tTW84eDNURWg5eDlVWUpZ?=
 =?utf-8?B?OVpid1RYWnFuTmpTYk42L0llM3RBZDRTLzBjL05rZmsycFBSM0d2Um50ajhW?=
 =?utf-8?B?R0hmKzFsbWplR1N4ZDJpSVhEL2o5d09TVUIyNlVSU2R4NHVwWGc5YUg2dGgr?=
 =?utf-8?B?cXR4aXE2NmhFaG5PZ2lReGczMmtjdVF2OEQ4Tmcwdm04b2JXSVdJd3JadER2?=
 =?utf-8?B?V3F3VkROYUd5UG9TNk5CUVg3VjZINzBBUmtGQ1U4YlZKZlcwa3A2T0RqSzRk?=
 =?utf-8?B?eEc3bVdWMWhOOUZwOFc3NUpSc3BNaGQ3c2N3NlN5Yld0bjNYU0NwdUFuSTlE?=
 =?utf-8?B?dnBaL3lrYmR1Q1R4Wmk3a2ZnSXFnY3JKVkZRb204UjMrRWVBOHNaOHcwTHdk?=
 =?utf-8?B?bUoyTDFDSWl0OVpiQTdUK0haRGRXUDRKcGQwOEI0ZDJzR1J3TnFuTnJwdmtC?=
 =?utf-8?B?Z1dtbkF4QWpnMDFkZXhERXBaY1NNa2F0WFRoTGg1U0pzQ3Z3UkNqT3ZpblRN?=
 =?utf-8?B?SGFyOFUrK2ZiQ3labHJFbjZZeDdxeHA5a1FML3p6VmxOMGhWOEIzUms5SitW?=
 =?utf-8?B?UkhJZU9HbStxdXE2bWJjb0xRN25jc1dYWE02RWtXdml2U2pzSVd5emlTOTZ0?=
 =?utf-8?B?TlczUytIV29vVHowTEV1U2xWL3gxbmUwa2Yrc01oQUFtUElVL2cxdFFrLzJi?=
 =?utf-8?B?dnJZM212M0JCcEtjVFIvd3RvbDh1bVp5N1FodS9PcHp4MnFoRFJyQWtXRDht?=
 =?utf-8?B?NklUanl0YnhVc0hHQjFyVEhNZGs1YkE0UWM4V3JBbWFhZmdMbk5VZDlLeksv?=
 =?utf-8?B?Vk9md2x6aGRYT25mNWhnREl3Zlc2TmtSK1hhemhvUzhIdTZucVZoc2phSmp4?=
 =?utf-8?Q?klngUZJXkEEn9LB8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c215f4-94a0-42f3-ef1e-08def9e2eac4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 09:03:33.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hn/whHlb6mgMtHc7mZkkUsZzE5IV5lBQuI7hooL+gEGMUsVRjxkQPfnKz5b+dYH5KupRLXBo3jfI9aKXHPmlUXIaX96k7OcuwPbScdY01o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB963705

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On platforms with multiple IRQ lines (S32G2, MCF5441X), all lines are
registered to the same flexcan_irq() handler. Since these are distinct IRQ
numbers, they can be dispatched concurrently on different CPUs. Both
instances then read the same iflag and ESR registers unconditionally,
leading to duplicate frame processing.

Fix this by splitting the monolithic handler into focused parts:
- flexcan_do_mb(): processes mailbox events
- flexcan_do_state(): processes device state change events
- flexcan_do_berr(): processes bus error events

Introduce dedicated IRQ handlers for multi-IRQ platforms:
- flexcan_irq_mb(): mailbox-only, used for mb-0, mb-1 IRQ lines
- flexcan_irq_boff(): state-change-only, used for boff/state IRQ line
- flexcan_irq_berr(): bus-error-only, used for berr IRQ line

The combined flexcan_irq() handler is preserved for single-IRQ
platforms with no functional change.

Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 128 +++++++++++++++++++++----
 1 file changed, 111 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..f73ff442d530 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1070,16 +1070,14 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 	return skb;
 }
 
-static irqreturn_t flexcan_irq(int irq, void *dev_id)
+/* Process mailbox (RX + TX) events */
+static irqreturn_t flexcan_do_mb(struct net_device *dev)
 {
-	struct net_device *dev = dev_id;
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	irqreturn_t handled = IRQ_NONE;
 	u64 reg_iflag_tx;
-	u32 reg_esr;
-	enum can_state last_state = priv->can.state;
 
 	/* reception interrupt */
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
@@ -1131,25 +1129,57 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		netif_wake_queue(dev);
 	}
 
+	return handled;
+}
+
+/* Process bus error events */
+static irqreturn_t flexcan_do_berr(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
+	u32 reg_esr;
+
 	reg_esr = priv->read(&regs->esr);
 
-	/* ACK all bus error, state change and wake IRQ sources */
-	if (reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT)) {
+	/* ACK bus error interrupt source */
+	if (reg_esr & FLEXCAN_ESR_ERR_INT) {
 		handled = IRQ_HANDLED;
-		priv->write(reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT), &regs->esr);
+		priv->write(FLEXCAN_ESR_ERR_INT, &regs->esr);
 	}
 
-	/* state change interrupt or broken error state quirk fix is enabled */
-	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
-	    (priv->devtype_data.quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
-					   FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
-		flexcan_irq_state(dev, reg_esr);
-
 	/* bus error IRQ - handle if bus error reporting is activated */
 	if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
 	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
 		flexcan_irq_bus_err(dev, reg_esr);
 
+	return handled;
+}
+
+/* Process device state change events */
+static irqreturn_t flexcan_do_state(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
+	u32 reg_esr;
+	enum can_state last_state = priv->can.state;
+
+	reg_esr = priv->read(&regs->esr);
+
+	/* ACK state change and wake IRQ sources */
+	if (reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT)) {
+		handled = IRQ_HANDLED;
+		priv->write(reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT),
+				&regs->esr);
+	}
+
+	/* state change interrupt or broken error state quirk fix is enabled */
+	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+	    (priv->devtype_data.quirks &
+	    (FLEXCAN_QUIRK_BROKEN_WERR_STATE | FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
+		flexcan_irq_state(dev, reg_esr);
+
 	/* availability of error interrupt among state transitions in case
 	 * bus error reporting is de-activated and
 	 * FLEXCAN_QUIRK_BROKEN_PERR_STATE is enabled:
@@ -1188,6 +1218,65 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		}
 	}
 
+	return handled;
+}
+
+/* Combined IRQ handler for single-IRQ platforms */
+static irqreturn_t flexcan_irq(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_mb(dev);
+	handled |= flexcan_do_state(dev);
+	handled |= flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Mailbox IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_mb(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Bus error IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_berr(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Device state change IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_state(dev);
+
 	if (handled)
 		can_rx_offload_irq_finish(&priv->offload);
 
@@ -1761,25 +1850,30 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	err = request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		err = request_irq(dev->irq, flexcan_irq_mb,
+				  IRQF_SHARED, dev->name, dev);
+	else
+		err = request_irq(dev->irq, flexcan_irq,
+				  IRQF_SHARED, dev->name, dev);
 	if (err)
 		goto out_can_rx_offload_disable;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		err = request_irq(priv->irq_boff,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_boff, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq;
 
 		err = request_irq(priv->irq_err,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_berr, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq_boff;
 	}
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
 		err = request_irq(priv->irq_secondary_mb,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq_err;
 	}
-- 
2.43.0

