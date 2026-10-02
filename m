Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC542255C;
	Fri,  2 Oct 2026 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925162; cv=fail; b=Kj5zqFvn1E5HOv14VlYndNIazCDzfupN593QM3WG3MfL4OhYcXpYY7/dplW/IiZTtpmtX8MIn2FuW0+mhrK3eEOmvWTfsZ5KKICdVbvIzS2kk2gxlXPLW9cDG8AjPZ2ogF+1nD9r6+vgiXk5aoN3PGnBhKJ06l/rBG3iLVCuOlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925162; c=relaxed/simple;
	bh=YYi1QzCy3m2mJ+kkChqdJKAV4AoPuGNg0EBt4//rPys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eBpClwrI4Cal0VCJXi692EH66kUXVSKl59/wfFWRpOklk405680bXh1pIANdQTUwjYhtdD9kVVQWtVR0zwZ4rnC6ZhHUsa9FPdLJtzIIeySR0MXrAT46uFEUHw+2AAKFCEkL7fE2fCwOZth/xL9wwEh3Y1wYrlx10wH9b9+ohAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SHLnrP8O; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SHLnrP8O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3I4wP5c+Ql9k2mjUU03epLf6KSKub9G2sjdTsPatLZOwoRYCRlRSn84cQYK7oDBtXHZj4wuZTQ85yjh1hJkqgFIriNejxzbRyqwmruXDGE0chzuBXtU1iC/H4UxwcmmioneFilLdA/RlBKZPVQdQ5spCSsfBjFnTl2XhyjgWv27rXPNXiW8TvE5ykGNvBY+JwzdTLrmnlMw5Kmid+m72XXNO6yeKl7Vp+vdwst/ld16uEvq4fujyROVgJv7Tueheqbyr5+GTTKNeIogdRttZ0Nm+gcEV6kosTgUPEZ5Kqn+VO23ZlxvoJK8bP2XMaTbMx9Jv1FEjSRIwbQE3Rfaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xO9synZCjZ7+G2Hcd/ZPVgNCLHWpVFLXHdWGb3tw+E=;
 b=OvY+logR5yRLg1uM3f/DHVIl0Bq+OLFiPS+7qcXdyYdRy3ezQQyjsXjw1u+G3p3Gu4ukWUHSP/nImyESA6p6CscyUai/dbc1HfX8gR3/GVc0VaEX1igHJdCNJ1CfQdS4He/Flm+v1ltI0g+kHs3yOVq0G4ZVzMfgHbDsuVL36neP6ekf8tUKrbXeni+azk8NNjCmyN07aQQzi6sgpPjheloPgiy2ume69iaMvzsBfRcL+3V6uutuaDyqaeemnzu7Cb/1IrC6Amt265R1RTcgK805fqE7FM8IgfYvG+v7itxVZeg3g4X6kNI7OzAzX9TNXOqSni/uoMrrPOAjFenE2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xO9synZCjZ7+G2Hcd/ZPVgNCLHWpVFLXHdWGb3tw+E=;
 b=SHLnrP8OQwTXhk5osKGoIw5s6ik6nO8+5IjZOuDQXaPaa8grGUZvPkagLL/cfbfrKc0JVJLL1LbgSxvf/l7JQI/qTHTZVv/KSYIu0BYu+U1ZQNz5YsqiEq4wkZYR37QavTqkZ+sRrvvY/19gLsGtxg2hlYSHlGWDW0f8qoII68dpdavb6D8lTe8KLf01HwSZBWn0v7nQdyGnQdmkgjHIXSy+btxeAdIYvLl7KWgTc1wGsRSQtlWGjfKVmqj18HHNqdhdecifn4shuSJ2rUuLJw1l7JoBB6dNgwRjvZio5bLLhs/dHdLrC8ShAE6mb5mos+PaLEuzLvy/K+SWojF5Qw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AS5PR04MB9825.eurprd04.prod.outlook.com (2603:10a6:20b:672::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 07:12:09 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 07:12:09 +0000
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
Subject: [PATCH v7 3/4] can: rx-offload: allow more than one receive source
Date: Fri,  2 Oct 2026 09:12:02 +0200
Message-ID: <20261002071203.1287650-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002071203.1287650-1-ciprianmarian.costea@oss.nxp.com>
References: <20261002071203.1287650-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P250CA0030.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::35) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: d204a9ad-d80d-4391-74b7-08df20547977
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UXiP0qtatSXj2iNc2wdqqt0z39149Fm0ke6zEP5nNtoaTTIeN8fLPGWjVcjZt0IBaUKaBqB7ghYGBxNvxaUCMxGBUiw+3Q9/EydGjRMXN4MsqwLC4wx9sICwUC+Wy7HWqXyn5Sv76ceIwdauTOHboSYTpC5Kti3iiBVUx5ybE95XXBb6fGcH2iv40v2tZT7jY2hax/VGf5pOcgAWAZnNKovBdCZcC6bxj0uteGuzi+/fsCNc3CqCoEpMomqaB5KJC+ysT334snLZ25PgP2qL1BQeFxh7VWZfkcWsF5YLDU6GZ1aaZgofDr0/qrJF504XJE7iOsTrFNTlEXFXuxnhMt3biHw6L3hU/OOXnQtxnsGG7hr50zZA9f+oUhw58kh+LrlIXACSURuTVTvYgkeNLvIggb/HF7efzQowyy+YS0Iqw6zPGlkeR5/Uk4oH2fJop6giz1rltXbvUTXiILQVi9YswMhQa86Te9TLC4zaysGuiKw06WcV8hP6jGItX6aKgRUsWffvwsKPB3oRE3wZiJjhev/NEIOSu3xOvFDFm6zsB9/2OGzMby0BxhMmufB1zte4UJ1XuxqB+e07I1EncSA2WIT7XtXo2w6vm9aZcyPWtTUnhmPPm5lieP6kgwOlhNe3Kty4hHf3bLGP2aIrS2eGS7BwiiMUSPPFUFj/+rw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUN6MU82Nkt2OFBlbTV0VjM0alhOQmpySnBYRm9mdzYxRzcrTERnRFl4NEoz?=
 =?utf-8?B?SVl2ZFVDb0ExMzR3b25NTnNwUFRSRzNPQlZZSXlSOGgycm1QOTFmRVp5c0lz?=
 =?utf-8?B?MVl1eWh0USt0dVBBemhWYlZScVZEeHdGQ05JTXRKRUdvVWU2WVlsYzJCQUZG?=
 =?utf-8?B?ejlzNXdnYnljTGtSRTdTYjJiM3orQzhJUTUvMXI3Lzdpa1gyQlpNR1VIYkFt?=
 =?utf-8?B?N0xQdHM0RUlHdGpCYmsyNDh6S3ZGWGN4ZDZLVzN2QlZVRFNqa2lKN0tOOWph?=
 =?utf-8?B?c0tTZWpxejlTcm1MNXRLdnRPWU5RM3lrRG42ek9maVhPQjd2Zk5GZXFYYnBx?=
 =?utf-8?B?WTFmZzhNNlRiY1g1ZjFhb2g3OXhKNTJqbFVHVjVMQ3hwMUllNjVFY3pZb2pW?=
 =?utf-8?B?ZjVKSVh4YWJ2YXRZUDFVUFZ0a0l5Rk1jbC83bHVndXhSTlB1RHVjS3dpTElK?=
 =?utf-8?B?L2wvbGN0dTlkYmkyUEVXTllRMjdSTnJkazhhajZIVUc1QUxhVk9zcms1eTNX?=
 =?utf-8?B?bEZxUjRmZ3lnTWhGbWozSzVHTW5BTWVXT3RrbVlNZERWRHdYWjBPZ0JZL2pw?=
 =?utf-8?B?dE1LdG1xcnYvVzV6NkRxVEdwRXFuSHErRER5Zm5jallTNy9GZEFBZUdmTHRs?=
 =?utf-8?B?eVM0Y0dWc1ZjbDYrOWR0STJEc29TMDhKT01yZUxTUXBhTFdJejRYMHNpOFl6?=
 =?utf-8?B?Z3NQR0lNUFdBRDFnS2pVNkc1NmJRRVZzbE1zbVRTZDZRRDRZQzZkZlZhQUk5?=
 =?utf-8?B?SWZ2a2dXTUsrYWJWQzZHMHFkR0VCSSs1N1BmU3d6VXpiUVRieDJKWHpJelBy?=
 =?utf-8?B?QmFNUTRWNXo0U2JlbzI4eU1xL2ZoUDNTNFFGd2l3STZUTHRYSENpWHdXZ0d6?=
 =?utf-8?B?dUpYNDMvVkVJZjFvUkp2NzBsZjB6NHRzb3VJNGZiTlE0UDJJTUNvd203OXNi?=
 =?utf-8?B?cTF1bktoYXRaWHFZRFdZcXhZSzhWOHJxOXB1ejJqdDk1c0FyRHd0NmpIM0tn?=
 =?utf-8?B?WTlxRnB6UUdab0wxcm10YUR4OWlleThNbFV3V21BeStpQjFXb3kyN0VnOHZD?=
 =?utf-8?B?YVpSZVdJdWVWa2FvOWhUV2oyY3NENU83cC81emM2Z0hrVXY5SHNSY3ZLR3Bx?=
 =?utf-8?B?TitNMzJjeHNnNHQvYUhkcUFBYlJ3UHZPN0xBaW1zeitPVnVGQXVEUXJTMlVk?=
 =?utf-8?B?ZlRyTGpLM1Nqa294Tlp6NjFLR2FGdHdYUDBvc0Y4K2NmU0tLL2YvbUlrUWNj?=
 =?utf-8?B?dkt4NkdFWW8yeWYrMUhVKzZHMWRpdER4d2I0ZWlDMGhVWCt6dE5HMjVjWXla?=
 =?utf-8?B?cys2Yk9kT3NYRmUrN082aHJDV0V4VjhaNkhIVnZQSGxqYkl5V2Y5dzA0Ukwv?=
 =?utf-8?B?TDA1OEkxeENvbC9uQVFGT0t4QktCcjFaQ24xeXlKV2liM1p4bjZNbXFEZUpU?=
 =?utf-8?B?MmxXWWpKSzlYaUJYQWVsN09zaDc2U25KeDhjbUFnQ3c3M2MrZHFOMWZ1Ykw3?=
 =?utf-8?B?N1h5dXB0N2ZKOFpBbFlFWFNkMnFjVmZPZDMrenhZZGpmVUJ5NkJZNHlQa3Iw?=
 =?utf-8?B?d3JOenNaTGVWNEtyQ3l1RDV6SFV2UDVtTit2VDR2OUFkR1hDalRWWlFPckhz?=
 =?utf-8?B?V0Z2T1ZFbnF2SzhzN2JJenc4OGZnSHJCaG5Id25SVU9SQllGbWVuQ0JMVHFn?=
 =?utf-8?B?VlVHL1ZRbXkwWEVHRi9WOWpjeGVydmxlb3Q1R21QQjlvSHN1alEyQTJxTGh6?=
 =?utf-8?B?YkphdjBBUHE3N2tTVG1FQWRkZHlPS1Y4TkQyV3E4QzErS3A1NnFFNzlLVXlB?=
 =?utf-8?B?b3ZTRjdnc2FJQks1bkN2N3ZTZ2YzcTRFZmtzQ25ZRmlzSTFRYzJNMWpLNGJE?=
 =?utf-8?B?NHZndko2ZTIxWDFxQTMrUkRIVFJ0QjBJdkx6R0JDbHVvR0JCeTE3WDkrMnd4?=
 =?utf-8?B?U2NYaVB4YmRmMjRFcXh3SWJZTXZGMU5rclJJNlJuRUQ5ZUJFWFFLblRPcjhM?=
 =?utf-8?B?ZUxPRHlLRGFwbktaczNDTUIyamRjZUorUUhRWW1SbVhmM3lLa3ppVHBjVGhr?=
 =?utf-8?B?RnRnQkVOQUl6d0dFTkdlZ2pyQk9IOVlMYWU0b3piTmQyLzZZaythTlhqaTE3?=
 =?utf-8?B?Q2FpaWN3N1g2d1gyeE05NUp4dHRxWHc4eFpTNUEzUkFDVlpaSHpselozUm9N?=
 =?utf-8?B?b0JGeGFzUkdtZDJIL04rbjV6Mjl5NDVMVUplOTVqS3FoQ09HR2hGSWFOT3hW?=
 =?utf-8?B?YXQxMXFsdXI1V1d2N3NpVjR3bjVuc0g5TUpNanhiMWdLcTFUQitSVVg3b0NZ?=
 =?utf-8?B?aUQrTkczTGpMeTZNeDR1NUhXWXUyeDRCN3NCK1JJWkpwY2RNUHJWQ04wVXdj?=
 =?utf-8?Q?fp/f6OYbIKesQGl0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d204a9ad-d80d-4391-74b7-08df20547977
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 07:12:09.8641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XMlXug0Ug/KIAx3OXv/AYarJpWQf4nI4MIcO7DG0rT1rAK7dEdU9KooX7k8s+dwu8ZVCAyM5RPOlncI5GDLQUk/tNykLBSVskZa6drGLMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9825

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Currently, the IRQ handler fills skb_irq_queue without a lock and the
finish helpers then splice it into skb_queue under skb_queue.lock. This
only works with a single producer. It breaks when a driver uses the
helpers from more than one IRQ line: on NXP S32G2 the flexcan handlers
can run at the same time on different CPUs and corrupt skb_irq_queue.

Let each producer have its own struct can_rx_offload, called a source,
while all sources of a device share one struct can_rx_offload_queue.

The source registered with can_rx_offload_add_timestamp(),
can_rx_offload_add_fifo() or can_rx_offload_add_manual() is the primary
source and owns the queue, as before. The new can_rx_offload_add_source()
attaches another source to the primary's queue. That source inherits the
mode, netdev, queue length limit and mailbox_read() of the primary, and
in timestamp mode scans its own mailbox range. can_rx_offload_del() on
the primary removes all sources, so they can be added again on the next
open.

With a single source the finish helpers still splice skb_irq_queue into
skb_queue. With more than one source in timestamp mode they merge it
into skb_queue sorted by timestamp. Otherwise they append it.

The existing API is unchanged, so drivers with a single producer need no
change.

Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Suggested-by: Haibo Chen <haibo.chen@nxp.com>
Assisted-by: LLM
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/dev/rx-offload.c | 145 ++++++++++++++++++++++++++-----
 include/linux/can/rx-offload.h   |  15 +++-
 2 files changed, 138 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index 92309ed47bac..5352d70b6e93 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -304,18 +304,40 @@ can_rx_offload_get_echo_skb_queue_tail(struct can_rx_offload *offload,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_tail);
 
-void can_rx_offload_irq_finish(struct can_rx_offload *offload)
+/* Sources may run on different CPUs at the same time, skb_queue.lock
+ * serializes them.
+ */
+static void can_rx_offload_move_to_skb_queue(struct can_rx_offload *offload)
 {
 	struct can_rx_offload_queue *queue = offload->queue;
 	unsigned long flags;
+
+	spin_lock_irqsave(&queue->skb_queue.lock, flags);
+
+	if (queue->source_cnt > 1 && queue->sort) {
+		/* keep the timestamp order over all sources */
+		struct sk_buff *skb;
+
+		while ((skb = __skb_dequeue(&offload->skb_irq_queue)))
+			__skb_queue_add_sort(&queue->skb_queue, skb,
+					     can_rx_offload_compare);
+	} else {
+		skb_queue_splice_tail_init(&offload->skb_irq_queue,
+					   &queue->skb_queue);
+	}
+
+	spin_unlock_irqrestore(&queue->skb_queue.lock, flags);
+}
+
+void can_rx_offload_irq_finish(struct can_rx_offload *offload)
+{
+	struct can_rx_offload_queue *queue = offload->queue;
 	int queue_len;
 
 	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
 		return;
 
-	spin_lock_irqsave(&queue->skb_queue.lock, flags);
-	skb_queue_splice_tail_init(&offload->skb_irq_queue, &queue->skb_queue);
-	spin_unlock_irqrestore(&queue->skb_queue.lock, flags);
+	can_rx_offload_move_to_skb_queue(offload);
 
 	queue_len = skb_queue_len(&queue->skb_queue);
 	if (queue_len > offload->skb_queue_len_max / 8)
@@ -329,15 +351,12 @@ EXPORT_SYMBOL_GPL(can_rx_offload_irq_finish);
 void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
 {
 	struct can_rx_offload_queue *queue = offload->queue;
-	unsigned long flags;
 	int queue_len;
 
 	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
 		return;
 
-	spin_lock_irqsave(&queue->skb_queue.lock, flags);
-	skb_queue_splice_tail_init(&offload->skb_irq_queue, &queue->skb_queue);
-	spin_unlock_irqrestore(&queue->skb_queue.lock, flags);
+	can_rx_offload_move_to_skb_queue(offload);
 
 	queue_len = skb_queue_len(&queue->skb_queue);
 	if (queue_len > offload->skb_queue_len_max / 8)
@@ -350,6 +369,16 @@ void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_threaded_irq_finish);
 
+static void can_rx_offload_link_source(struct can_rx_offload_queue *queue,
+				       struct can_rx_offload *offload)
+{
+	offload->queue = queue;
+	__skb_queue_head_init(&offload->skb_irq_queue);
+
+	list_add_tail(&offload->node, &queue->sources);
+	queue->source_cnt++;
+}
+
 static int can_rx_offload_init_queue(struct net_device *dev,
 				     struct can_rx_offload *offload,
 				     unsigned int weight)
@@ -357,41 +386,65 @@ static int can_rx_offload_init_queue(struct net_device *dev,
 	struct can_rx_offload_queue *queue = &offload->own_queue;
 
 	offload->dev = dev;
-	offload->queue = queue;
 
 	/* Limit queue len to 4x the weight (rounded to next power of two) */
 	offload->skb_queue_len_max = 2 << fls(weight);
 	offload->skb_queue_len_max *= 4;
 	skb_queue_head_init(&queue->skb_queue);
-	__skb_queue_head_init(&offload->skb_irq_queue);
+
+	INIT_LIST_HEAD(&queue->sources);
+	queue->source_cnt = 0;
+	queue->sort = false;
 
 	netif_napi_add_weight(dev, &queue->napi, can_rx_offload_napi_poll,
 			      weight);
 
+	can_rx_offload_link_source(queue, offload);
+
 	dev_dbg(dev->dev.parent, "%s: skb_queue_len_max=%d\n",
 		__func__, offload->skb_queue_len_max);
 
 	return 0;
 }
 
-int can_rx_offload_add_timestamp(struct net_device *dev,
-				 struct can_rx_offload *offload)
+static int can_rx_offload_init_mb_range(struct can_rx_offload *offload,
+					unsigned int *weight)
 {
-	unsigned int weight;
-
 	if (offload->mb_first > BITS_PER_LONG_LONG ||
-	    offload->mb_last > BITS_PER_LONG_LONG || !offload->mailbox_read)
+	    offload->mb_last > BITS_PER_LONG_LONG)
 		return -EINVAL;
 
 	if (offload->mb_first < offload->mb_last) {
 		offload->inc = true;
-		weight = offload->mb_last - offload->mb_first;
+		*weight = offload->mb_last - offload->mb_first;
 	} else {
 		offload->inc = false;
-		weight = offload->mb_first - offload->mb_last;
+		*weight = offload->mb_first - offload->mb_last;
 	}
 
-	return can_rx_offload_init_queue(dev, offload, weight);
+	return 0;
+}
+
+int can_rx_offload_add_timestamp(struct net_device *dev,
+				 struct can_rx_offload *offload)
+{
+	unsigned int weight;
+	int err;
+
+	if (!offload->mailbox_read)
+		return -EINVAL;
+
+	err = can_rx_offload_init_mb_range(offload, &weight);
+	if (err)
+		return err;
+
+	err = can_rx_offload_init_queue(dev, offload, weight);
+	if (err)
+		return err;
+
+	offload->queue->sort = true;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_add_timestamp);
 
@@ -416,6 +469,46 @@ int can_rx_offload_add_manual(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_add_manual);
 
+/**
+ * can_rx_offload_add_source() - Add a source to the queue of @primary
+ * @primary: source added with can_rx_offload_add_timestamp(),
+ *	     can_rx_offload_add_fifo() or can_rx_offload_add_manual()
+ * @source: source to add
+ *
+ * @source inherits the mode, netdev, queue length limit and mailbox_read()
+ * of @primary. In timestamp mode the driver must set the mailbox range of
+ * @source first. mailbox_read() is called with @source, so it must use
+ * netdev_priv(offload->dev) and not container_of() to get its private data.
+ *
+ * Return: 0 on success, -EINVAL on invalid arguments.
+ */
+int can_rx_offload_add_source(struct can_rx_offload *primary,
+			      struct can_rx_offload *source)
+{
+	struct can_rx_offload_queue *queue = primary->queue;
+	unsigned int weight;
+	int err;
+
+	if (queue != &primary->own_queue || !queue->source_cnt ||
+	    source == primary)
+		return -EINVAL;
+
+	if (queue->sort) {
+		err = can_rx_offload_init_mb_range(source, &weight);
+		if (err)
+			return err;
+	}
+
+	source->dev = primary->dev;
+	source->mailbox_read = primary->mailbox_read;
+	source->skb_queue_len_max = primary->skb_queue_len_max;
+
+	can_rx_offload_link_source(queue, source);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_add_source);
+
 void can_rx_offload_enable(struct can_rx_offload *offload)
 {
 	napi_enable(&offload->queue->napi);
@@ -424,8 +517,18 @@ EXPORT_SYMBOL_GPL(can_rx_offload_enable);
 
 void can_rx_offload_del(struct can_rx_offload *offload)
 {
-	netif_napi_del(&offload->queue->napi);
-	skb_queue_purge(&offload->queue->skb_queue);
-	__skb_queue_purge(&offload->skb_irq_queue);
+	struct can_rx_offload_queue *queue = offload->queue;
+	struct can_rx_offload *source, *tmp;
+
+	netif_napi_del(&queue->napi);
+	skb_queue_purge(&queue->skb_queue);
+
+	/* the sources are added again on the next open */
+	list_for_each_entry_safe(source, tmp, &queue->sources, node) {
+		__skb_queue_purge(&source->skb_irq_queue);
+		list_del_init(&source->node);
+	}
+	queue->source_cnt = 0;
+	queue->sort = false;
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_del);
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index fafc00fc3700..06c2fb71cf7b 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -15,8 +15,16 @@
 struct can_rx_offload_queue {
 	struct sk_buff_head skb_queue;
 	struct napi_struct napi;
+
+	struct list_head sources;
+	unsigned int source_cnt;
+	bool sort;
 };
 
+/* One struct can_rx_offload per source of RX skbs, e.g. per IRQ line.
+ * Sources added with can_rx_offload_add_source() share the queue of the
+ * primary source.
+ */
 struct can_rx_offload {
 	struct net_device *dev;
 
@@ -32,9 +40,12 @@ struct can_rx_offload {
 
 	bool inc;
 
-	/* Points to own_queue. */
+	/* Points to own_queue of the primary source. own_queue is unused
+	 * in the other sources.
+	 */
 	struct can_rx_offload_queue *queue;
 	struct can_rx_offload_queue own_queue;
+	struct list_head node;
 };
 
 int can_rx_offload_add_timestamp(struct net_device *dev,
@@ -45,6 +56,8 @@ int can_rx_offload_add_fifo(struct net_device *dev,
 int can_rx_offload_add_manual(struct net_device *dev,
 			      struct can_rx_offload *offload,
 			      unsigned int weight);
+int can_rx_offload_add_source(struct can_rx_offload *primary,
+			      struct can_rx_offload *source);
 int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
 					 u64 reg);
 int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload);
-- 
2.43.0

