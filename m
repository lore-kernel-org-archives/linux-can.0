Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013062.outbound.protection.outlook.com [52.101.83.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402AF4078D3;
	Mon,  7 Sep 2026 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778200; cv=fail; b=OF3eqG7MDWGTGoLaIDfKSINnNsSlPX5YQTCjj907/lH1U7fROMERl52sMHvlXfed2j5plvxWLceQh91YBC8k0+ZTdtdPYSHuID6dYDgmIfcQkKMwoDyc331DWva8B953XZH594IHKyA41XbyyZJdVFWcgCkmEDR0C9BgXGLSwgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778200; c=relaxed/simple;
	bh=aPpCgWG3aYyF5Auwtcx23U1ci+YVFxyD9frh6YtcOZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BwPaqYUt0RxaYm2BNRcZEH/Tmcf0dTxib48xmZ25w8rB7+19osBOv6y9b8q0sXEVsmhmQO60arXLSOAbttwrejVjF61MtbKYJKBbuumGVMZxtFT/jr7/KYrG+SLGZyNluCiJzTagRbptNvZO7E7c1pPJIU4saXXn8jv/u7igcP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=O+9eAljM; arc=fail smtp.client-ip=52.101.83.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O+9eAljM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCPYrTA/vy/aZgHE1qKy8qpCtNUKLSqo/FgDT3WCaFb6p8IknuegEqx6GwniJd5b9T+8sLUoes7LXr1Bl5R5TSwclLcAtH8G8cvGPnQ1PDcqcrxhyUzCepQaQNqZTu8cXckt9h2l6/u6mZw4vZpJoBCN3xoYxIHAysO/T7Csv7yrVLsGoLHtsUFrdYBDLW8KtMp7VGfZAdnUKFkr+recYi53Gg91yccOHsxtM9vfu1a5LoQwQG0qLYMoXtFwfCKhIsaE5WwWHvR5Wgt6CMbWZvLprxl7rRXICbZ9psh14lbCjQxdolYrDuQkOxMspQn8VwZH3SlH3EVjxSUTaDvxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui2LZy02JFlVW0P1xpWSvQV2qqf1SWSzWcCL4wlV0V0=;
 b=E3vPSuKZkgUC7x1aPz3rdnoTG5ggp2v0zCVfDvAtN6++f/4wi7oNMGSm6ilzStvPmWbrRSi4s8b6UwsIbnDcluucxlPzhrXqfAOcqSccss/mK38+uxVvwq2kpP8W9c1/mYpeW4BJ90Yz2QZJ/3aLmrOH+lM/HBoCTy5MWoW3QFAbSdybiiqvVwxPoLCJjpGNYFCZhRQdZEvqVBboVc6gGhckMbwwhonVopkQjtLz7KaXOx7Af1vZviGOngKpzkBgmj5F8zZAiSVXcVDhE9fUCCZW5JK40vI6hjpMhtrJkeTG5BgE51+qYSjAbS+PJNS90lzK2mp19LtHDWdqC4a3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui2LZy02JFlVW0P1xpWSvQV2qqf1SWSzWcCL4wlV0V0=;
 b=O+9eAljMD1XDZZv/PhTV63oKgE3sYCJKLILskdKsAcvwxZFR4IU7Rtk2zTvdPDpxCY9itTiO/D0vJe42btGAB9rmrxQqCO8cA3Ch1LWGk10JGx8MfrTnt4myl8NZS5Vkfz6Y2oZ9R9V0qgfcJXOpgEKDAA2xhB/WHSEw70709ouM+x3LXk31LQjgn6JzIr1eDPworlqc/iQXzXJn5ijn/xCZvehW7J25u1ZbPnS7Paivz+JfcI61BhhNyyaJC9BrA0154BMAgL7BrByQHq3n9sxBjbMwbgeaIsg6cTNEKOWEX+Q7d8j7vt9krAkUXXhOzmrXIFyBrI3j5oKN37sc9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DBBPR04MB7578.eurprd04.prod.outlook.com (2603:10a6:10:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 10:49:45 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 10:49:45 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	NXP S32 Linux Team <s32@nxp.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v5 1/3] can: rx-offload: make skb_irq_queue per-CPU
Date: Mon,  7 Sep 2026 12:49:40 +0200
Message-ID: <20260907104942.17089-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907104942.17089-1-ciprianmarian.costea@oss.nxp.com>
References: <20260907104942.17089-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DBBPR04MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb41ed7-1fc8-4a3e-f7f0-08df0ccdbb2b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|7416014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iMpMSz+xVRdI6nH+GjqnYWrTa0Cs448x1P+ki3OOP709H66yH/n8/mJ6x04nN7ZQqhsFS8gM2OfcsgseZBFaWtTKUpv/NIuEgi00W9Y4XCbcXnwT5jAKBpk4Fnum2MJoDzhNL3FdmSQdOw277v/XsQz/Ai2gxdh169C9e9Dty2DSSZtULcjV+q3d6lW3efIR1WARM8x28j5qlAnAkoe0mCxy45eObAvNL6LKGFk1puRWwh7cPIrSTM6m0zjbhDfyTZIGQLyPbgc5jr6nGhcs/4SHu5VaUEGKQwyqETIYxZASywcMzQnnjYmVPtjscubF3kUCsCq3ksPc4jP2qxPg0Y1agVYBVUzoB3m7vWV/j05wPaeY5DNsCpmlTWRRkN5KcAhkqu0JmcN34Micv535nyiSBxpxAFXz9XUjMs4CiewBJIu5I0n/HVBG36TKIMoh2JLaQlSGYN4O5BeUqsiPUaBCA8XbRThKmm4C+/2fUR4lM38ZUjoBYEBq1Rlhk2xOonSALs48e6lXRFHGQpItbqhksqFcVhy3CtECfqCLcAOPdL5WhnCaMZ58lZxbH7SHKPxuFVh/6072PpgLbrvOzi+6drPQEbT6aYlEWdt+PAfhaixw+cMOpK1eAtyVGumg7dk7IPw5On/WbO2tMeVX48KY8jswNMzjlYvd+yNErrk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(7416014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk1XK051VCtIeTRIU2tlK1FGdExKZEJ1ejFISzJ2V2VVZUlMa2tYTUZFT2hJ?=
 =?utf-8?B?eXhjaXIwQ1NZU2NTcC9oTjZ3QzFPa1FsTDgzVlVlY3Rab2lMS1MzNFhaM2NO?=
 =?utf-8?B?WksySlZ5NGJydEhRRjZnajRFQVoxOHlVajNWMEhxTWhqRFo4MHlhS1YyR1RV?=
 =?utf-8?B?Y29QdHppaTJNUlhjMjhDbnN5NDBteERQOTJwSG4wK1l0WjlBWm9nYy9jNTdZ?=
 =?utf-8?B?WG9hc21YYVc1MmxwczgrNEg3K3o4ci8zTnQyanZINkg2Z2dUQy9aV2RDNisy?=
 =?utf-8?B?ZHVBQ0w2Ui9BWnpZa3BCMXZxZ0dXc256bTFMVFRyOTcxMkxHSDJEeEdXa0dU?=
 =?utf-8?B?K0RBSVpoTWV3QlNVcDdlbW9HZEdDQmhub1ZQVDMvTFZXSE1oMmtjVk9xNFJE?=
 =?utf-8?B?cXEwVWIvWmxYS3dwMFBIUW5ZdzEzb3h1T0RPN21hbG5Fblo5cTRZTkNGNXZo?=
 =?utf-8?B?K2tIdGgrVWhVbkFBZ2todW9DRFJ2aWs1NTBrS056cml2TXVxcm9seXpNRnpO?=
 =?utf-8?B?cVM5NnlxNGwwN0RLempWdXFqYkFFdXoxSGl1eWZhcDhXRFlKUGlTdWluM0M0?=
 =?utf-8?B?em40WEF3THN3d0Z0MHQ0Mnh1elViSTVPTTFhOFAzSXhzSEluV2RKcVBRRWZD?=
 =?utf-8?B?bnpkSk5zTXV6OXhMTGp3QTRxbVRSTTFyS21lT0RrdG5ITTdDblJwSTRiVlpK?=
 =?utf-8?B?dXI3QW5rcjVPYjdUNGlxNm5DQWtVRW53c3p6UDBLa3Y3b0U5V2VWdDk0QTBC?=
 =?utf-8?B?ZUVORW8zb3ZrYVRmT1JVMVNkamJxWEtmdkJWYzhoalEyaUhYRmFpRHJ0aWIv?=
 =?utf-8?B?dkQ4RnprYXpUQm5NTHBZQkoxSFpxNitVWjdmVVdJa2ZBSVNvbTBRN3ZDUWpI?=
 =?utf-8?B?bzM1Y01jWGd4WktORjFaMVMvRHFhWUlVeUY1cUU3UGdER05IckVkZFBpcDVS?=
 =?utf-8?B?OTE2WXFTcmJ4RTJIRGw4ZGk4Qnk1Mndyb2pnRFEwbTZIeXd3ZHRSd2JKRGZK?=
 =?utf-8?B?NnU0b1dBUk4wdmpqR0U3NE1XTjBmWDlpZ25IcnJIM0toTTRIZ3pSUTVHWlh0?=
 =?utf-8?B?TXdmTkhsbG1RREZLTG5VcklYVjhWR0JJVEdpOERCZEhLakxBRWpQWkdUb3pL?=
 =?utf-8?B?M2NWRkErYTBuU09hZk9xM1cyemNXSXlLUnF3TlVadEhpUlRGT1VQU1pHMGJI?=
 =?utf-8?B?SW9LcHVPT3dXc3RKb3ZXMDNJZ0dSZENSTE9tZXZNY0l0aThyUERhSUdGQ294?=
 =?utf-8?B?QkJ2RU9nQkkrbUw5cExZajAvWDFtcVp3UFJ4UVhwVW4wZ2xqM3dKY0w3Qzly?=
 =?utf-8?B?enhaMDlJaE54Q0owMjJwVkQ2TlZveDR4K2NuRUk1endhWWNTTjRtN29zd1Fi?=
 =?utf-8?B?UUh1T3U5RUdDLzA4UzZ6RjNvMWlwb3JEdC85ZEVoYWIzeldMOHNwT3o5TlJr?=
 =?utf-8?B?TG01Qkh3SUMyaUFlcGoxRUthN3l3dVpib3d1cUtpTlR1MnlITDVMR1N3RkhG?=
 =?utf-8?B?ellxWDZxdnU1dmI3dVZDVEpQVUhMWkV0ZVZpTkEzZDhiNWs5TXZqRDlNTHUz?=
 =?utf-8?B?SVlMdUF4M2RrWTY3TUdGV3U4Q3hsUmpqZUdob2tUTEdKTHltUmFkSlNUazhR?=
 =?utf-8?B?OTZ2UFFCcUVkbFhqTHlmdDAzNitEVXRMeHliQjNjU05OODhTOTIrN1JRTjBP?=
 =?utf-8?B?Ui8xUzJVeHMyR3l6M0F2cnVFVTZvRUxpV3YwcG1ScnB5WDI4T25Kc0o3K2Vx?=
 =?utf-8?B?a3pNVEFrc3pSLytabk9ieGxIZ1d0TVljTVRRTDZ1UGM0WTEvVnhtblp2YnMr?=
 =?utf-8?B?SXcvTjUwZGdEYklHYXZPK1lVOXZJSlltVmFtZnllUUlpcldzcDd2eHRCMlI5?=
 =?utf-8?B?N3NjcFpuOFA1NnBGTVJYSHFyNVdZM0dHYnFBcmx3MkVNMkFNT2gycVNHc1Rl?=
 =?utf-8?B?cjJYaTNWVWczMGpRV2xQZjVLTTZCeDVYNUE0SlJGaEpHclVKR1RHdXFOczBP?=
 =?utf-8?B?eEc5cXFSQ1hWOXdWSWd1OTBEWVpRMHNqVGdocXlaSThlODhxRHhBVzhKTnoz?=
 =?utf-8?B?TGV1eFQ0RGgyMlNjcVhtTVdSeTVPTVpJL29yRStDcmcwRFd3OWNFMnBHUzdH?=
 =?utf-8?B?N2Y0SFN0NXp0K0syWkx4VzY1VTVxMU03SFhvMk5TM1BCRDhHM2dqa0VTRFk3?=
 =?utf-8?B?RlFUSjVSdndsdG9UQS84RERGSzJBQm9ueVhxNkZVTHpORjFqVXUyQnVuVTVu?=
 =?utf-8?B?d1V6WFJXRWdITU9GT3dReEtGcnAyc1c3QWtLSW5kYm9nLzR4ZCtDMjVtMjZB?=
 =?utf-8?B?SkxmMlUxUzJaZ1JtdDlJVkEwMlMzNTlaWjJMZm9oM0xBTk9leWZ1dXVqR2hN?=
 =?utf-8?Q?fhB0HOUZXKKIXsPY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb41ed7-1fc8-4a3e-f7f0-08df0ccdbb2b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 10:49:45.9146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4HDPYJ17OzliKFzNE05UKzuYL1ZZgtnrKOyRqgDU/jYFVg46EB+BqfAX+ciFFpfuvFIprZRt+ERMXVcJ956elvuAPaoS/SnynQop2LNXhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7578

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

skb_irq_queue is filled by the IRQ handlers using the lockless
__skb_queue_add_sort() / __skb_queue_tail() helpers and later spliced
into skb_queue under skb_queue.lock by can_rx_offload_irq_finish() and
can_rx_offload_threaded_irq_finish().

This is only safe while a single context fills skb_irq_queue. FlexCAN
on NXP S32G2 (FLEXCAN_QUIRK_SECONDARY_MB_IRQ) uses two mailbox IRQ
lines, one for MB0-7 and one for MB8-63; MCF5441X similarly splits its
mailbox interrupt. When these lines are affined to different CPUs both
handlers can run at the same time and enqueue into the same sk_buff_head
concurrently, corrupting its list.

Allocate skb_irq_queue per-CPU so the handlers no longer share a list,
keeping the enqueue path lock-free. Access the per-CPU queue via
get_cpu_ptr()/put_cpu_ptr() in the enqueue helpers: this disables
preemption around the lockless __skb_queue_*() operation.

can_rx_offload_irq_finish() runs in the same context as its enqueues and
splices this_cpu_ptr(). can_rx_offload_threaded_irq_finish() may have
been migrated after its enqueues, so it splices every possible CPU's
queue; this is safe because each per-CPU queue has a single producer and
that producer runs with preemption disabled, so it cannot race the
splice.

Cross-line frames are now sorted by timestamp only within a CPU's queue
and appended across CPUs on splice; each skb keeps its own timestamp.

Fixes: c757096ea103 ("can: rx-offload: add skb queue for use during ISR")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/net/can/dev/rx-offload.c | 88 +++++++++++++++++++++++++++-----
 include/linux/can/rx-offload.h   |  2 +-
 2 files changed, 75 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index 46e7b6db4a1e..7616a16d9049 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -7,6 +7,7 @@
 
 #include <linux/can/dev.h>
 #include <linux/can/rx-offload.h>
+#include <linux/percpu.h>
 
 struct can_rx_offload_cb {
 	u32 timestamp;
@@ -175,9 +176,18 @@ can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
 int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
 					 u64 pending)
 {
+	struct sk_buff_head *irq_queue;
 	unsigned int i;
 	int received = 0;
 
+	/*
+	 * get_cpu_ptr() disables preemption so that the lockless
+	 * __skb_queue_*() below operate on the current CPU's queue without
+	 * racing a migration. This also keeps this_cpu_ptr() valid when a
+	 * driver enqueues from a preemptible (threaded IRQ) context.
+	 */
+	irq_queue = get_cpu_ptr(offload->skb_irq_queue);
+
 	for (i = offload->mb_first;
 	     can_rx_offload_le(offload, i, offload->mb_last);
 	     can_rx_offload_inc(offload, &i)) {
@@ -190,20 +200,25 @@ int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
 		if (IS_ERR_OR_NULL(skb))
 			continue;
 
-		__skb_queue_add_sort(&offload->skb_irq_queue, skb,
+		__skb_queue_add_sort(irq_queue, skb,
 				     can_rx_offload_compare);
 		received++;
 	}
 
+	put_cpu_ptr(offload->skb_irq_queue);
+
 	return received;
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_timestamp);
 
 int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
 {
+	struct sk_buff_head *irq_queue;
 	struct sk_buff *skb;
 	int received = 0;
 
+	irq_queue = get_cpu_ptr(offload->skb_irq_queue);
+
 	while (1) {
 		skb = can_rx_offload_offload_one(offload, 0);
 		if (IS_ERR(skb))
@@ -211,10 +226,12 @@ int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
 		if (!skb)
 			break;
 
-		__skb_queue_tail(&offload->skb_irq_queue, skb);
+		__skb_queue_tail(irq_queue, skb);
 		received++;
 	}
 
+	put_cpu_ptr(offload->skb_irq_queue);
+
 	return received;
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_fifo);
@@ -222,6 +239,7 @@ EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_fifo);
 int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
 				   struct sk_buff *skb, u32 timestamp)
 {
+	struct sk_buff_head *irq_queue;
 	struct can_rx_offload_cb *cb;
 
 	if (skb_queue_len(&offload->skb_queue) >
@@ -233,8 +251,9 @@ int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
 	cb = can_rx_offload_get_cb(skb);
 	cb->timestamp = timestamp;
 
-	__skb_queue_add_sort(&offload->skb_irq_queue, skb,
-			     can_rx_offload_compare);
+	irq_queue = get_cpu_ptr(offload->skb_irq_queue);
+	__skb_queue_add_sort(irq_queue, skb, can_rx_offload_compare);
+	put_cpu_ptr(offload->skb_irq_queue);
 
 	return 0;
 }
@@ -268,13 +287,17 @@ EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_timestamp);
 int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 			      struct sk_buff *skb)
 {
+	struct sk_buff_head *irq_queue;
+
 	if (skb_queue_len(&offload->skb_queue) >
 	    offload->skb_queue_len_max) {
 		dev_kfree_skb_any(skb);
 		return -ENOBUFS;
 	}
 
-	__skb_queue_tail(&offload->skb_irq_queue, skb);
+	irq_queue = get_cpu_ptr(offload->skb_irq_queue);
+	__skb_queue_tail(irq_queue, skb);
+	put_cpu_ptr(offload->skb_irq_queue);
 
 	return 0;
 }
@@ -307,14 +330,15 @@ EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_tail);
 
 void can_rx_offload_irq_finish(struct can_rx_offload *offload)
 {
+	struct sk_buff_head *irq_queue = this_cpu_ptr(offload->skb_irq_queue);
 	unsigned long flags;
 	int queue_len;
 
-	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
+	if (skb_queue_empty_lockless(irq_queue))
 		return;
 
 	spin_lock_irqsave(&offload->skb_queue.lock, flags);
-	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue);
+	skb_queue_splice_tail_init(irq_queue, &offload->skb_queue);
 	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
 
 	queue_len = skb_queue_len(&offload->skb_queue);
@@ -330,15 +354,34 @@ void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
 {
 	unsigned long flags;
 	int queue_len;
-
-	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
-		return;
-
+	int cpu;
+
+	/*
+	 * Splice every CPU's queue: unlike the non-threaded
+	 * can_rx_offload_irq_finish(), a threaded handler may be migrated
+	 * between the enqueue and this splice, so the frames may sit on a
+	 * different CPU's queue. This is only safe because a given per-CPU
+	 * queue has a single producer (the enqueue on that CPU is
+	 * non-preemptible), so no producer can race this splice.
+	 *
+	 * This assumes a single threaded handler context per offload instance
+	 * (IRQ requested with IRQF_ONESHOT / handler non-reentrant), so each
+	 * per-CPU queue has exactly one producer. If that changes, this
+	 * cross-CPU splice of lockless queues would need additional locking.
+	 */
 	spin_lock_irqsave(&offload->skb_queue.lock, flags);
-	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue);
+	for_each_possible_cpu(cpu) {
+		struct sk_buff_head *irq_queue;
+
+		irq_queue = per_cpu_ptr(offload->skb_irq_queue, cpu);
+		skb_queue_splice_tail_init(irq_queue, &offload->skb_queue);
+	}
 	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
 
 	queue_len = skb_queue_len(&offload->skb_queue);
+	if (!queue_len)
+		return;
+
 	if (queue_len > offload->skb_queue_len_max / 8)
 		netdev_dbg(offload->dev, "%s: queue_len=%d\n",
 			   __func__, queue_len);
@@ -353,13 +396,21 @@ static int can_rx_offload_init_queue(struct net_device *dev,
 				     struct can_rx_offload *offload,
 				     unsigned int weight)
 {
+	int cpu;
+
 	offload->dev = dev;
 
 	/* Limit queue len to 4x the weight (rounded to next power of two) */
 	offload->skb_queue_len_max = 2 << fls(weight);
 	offload->skb_queue_len_max *= 4;
 	skb_queue_head_init(&offload->skb_queue);
-	__skb_queue_head_init(&offload->skb_irq_queue);
+
+	offload->skb_irq_queue = alloc_percpu(struct sk_buff_head);
+	if (!offload->skb_irq_queue)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu)
+		__skb_queue_head_init(per_cpu_ptr(offload->skb_irq_queue, cpu));
 
 	netif_napi_add_weight(dev, &offload->napi, can_rx_offload_napi_poll,
 			      weight);
@@ -420,8 +471,17 @@ EXPORT_SYMBOL_GPL(can_rx_offload_enable);
 
 void can_rx_offload_del(struct can_rx_offload *offload)
 {
+	int cpu;
+
 	netif_napi_del(&offload->napi);
 	skb_queue_purge(&offload->skb_queue);
-	__skb_queue_purge(&offload->skb_irq_queue);
+
+	if (!offload->skb_irq_queue)
+		return;
+
+	for_each_possible_cpu(cpu)
+		__skb_queue_purge(per_cpu_ptr(offload->skb_irq_queue, cpu));
+
+	free_percpu(offload->skb_irq_queue);
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_del);
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index d29bb4521947..1b9e2a8ab39a 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -20,7 +20,7 @@ struct can_rx_offload {
 					bool drop);
 
 	struct sk_buff_head skb_queue;
-	struct sk_buff_head skb_irq_queue;
+	struct sk_buff_head __percpu *skb_irq_queue;
 	u32 skb_queue_len_max;
 
 	unsigned int mb_first;
-- 
2.43.0

