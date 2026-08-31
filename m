Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4144AB81;
	Mon, 31 Aug 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186508; cv=fail; b=AK0/y70Chfxvd6FtgikJYlDrdD6YN5gYEHMR7KWaC+w5czeDkQt2kqH4uJoAO9I9G+eRZixUgjqQveLnTCu7scqnC3MdaK+Eztf9Rc5iUthv9YQ7z40JaUfklAVcYW9i7UTKRghqzOEuWcLqe8QqNR2r1J0P2+UKXhBbVQHJXJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186508; c=relaxed/simple;
	bh=S0UkN0etTniPfkfS1/xf8sVem68IarwZqu0KWvG0CL0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oIB0d18iYKIzC666qTn5V6Ld7Iy8ZEPSgPkSAUN/LbBar5poa0DKWnZo8vV9/uZlIVwQ+nx/M+Pgc+/dZdLlHt9U37YQF3ROH8lHF1WWs1qQhOtlVpwKtcK8f9fPZYZBrAT1nPjlCEH8hEG2XPmd9fvpK4yQ0takX7f1vLAQLDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Jql2EC+7; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Jql2EC+7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1o6FU4tsRrXA67uNRMreicdmbz2K5B3q3ztC1i/wbcYogHkl0v9ra9QbQ5CTzFreWLqjqR1dqQxE8O/Qm+urfwkKLrIWKPq7+hI/uCVgQPDY4Z69QH5lGWEPtuMZ6sClxNtjzVxuUvLgtMM94LvXN4A7eUgENER2pA6qZHGAv8633BPtW/bQaie4wDk+Ijf3yk4YUXugn54QFbszA+9agqUeGTdcOlI4IZ43x1Znn3uiq2C2DXmHrhznyXf2ogsGFC1sVegkWbdPcuPQbbdqxC9kwyVzXA+fE2CUSdQBCEqqZrtun8turTuRNxmrxZDqpBv/KVUqJQX6/2+0HNUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hpYVceh3jdVZPnC4NQybKwROwVwbkG1JawOA/orN9M=;
 b=K2CaOG+IMY92ZSNLmOAVDl+6rxCeCI2bBgWBsbUmaDnX63Lzo3I0uEL7wM11Wa+Mkdawv/O37eFbWDb7r7WWx8aqE7KrVbDx0vvAFF/tD2Qu4MVcMJVW8w8YLZofzmzFxtmEmiKzfc5ecmfeWHK7+IIdUUuQyPIbHHp6c/G08td2GQAAQA3vdC3ftITdurWGvo1K3U4mWaab2YVB1+zErEZa1BC6EuhYkG/wu7/mylSo8bPkODXR9bPftU+Rb7YhK9H15cdNfCqij8cWfOZZMm1soc9CL8RdvTyawX0s7CvqnKfPqmxkwquW5+NmoU8sbKU5SBNtiJKied9629pwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hpYVceh3jdVZPnC4NQybKwROwVwbkG1JawOA/orN9M=;
 b=Jql2EC+7CqgGSYa2D7xmkuHAswWaaFJhVzc/wnUcmFNidcpiX5It2xWjIvYEBb0zuXaKRRF4KQEri6XvCTT73j1oTWRQ30UPI+IrzGAuD2RzJO0Tu/B3+vCUsEUP4OPTOv2FgV0kXoLkNAcLC1HNvklGqVbF5CgnCn4hc9C1kzK8/zWCUzN9wULyOJxMY1I+kwvGhv/r9+/WUIx3l21ozZt2T1yqwh/Z2/JUKhGK1NZqoUj0Rrmb4nFAx9dO30/Cr0/6+5I4Ss2dphfK5knGG/QGGDn0iHM00t6jE2KsWGPnw21i8PSjhNvHhstscAuehRnc6wPXSoEy5UpMZensew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by GV2PR04MB11423.eurprd04.prod.outlook.com (2603:10a6:150:2a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:28:22 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 14:28:22 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP Linux Team <s32@nxp.com>,
	imx@lists.linux.dev,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH] can: rx-offload: make skb_irq_queue per-CPU
Date: Mon, 31 Aug 2026 16:28:19 +0200
Message-ID: <20260831142819.9318-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::15) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|GV2PR04MB11423:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e7af1ee-12ff-4429-772d-08df076c1c4f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|376014|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	jposvkFq7hSZAFgNCfca/AbbAUlgE11k54mCTCUivFJZbSedp9zG8zN6E1DsODP0ctSzJXM6l7ybH/5AFDSH1C0kCvUi5uo7op5HPtdaZu0FR+YlzcyVToYspUuzqy+dzKLBzY7ryeZAD6urXHFc4UG+dzezAHnTFgYLWkqwu0n/7/TwkhGhyliLxalZA4xNPFzXuDn6FWOVTLaSp96h8/MMZRmLvXTPsoJk0EmGffIdVIN08WkGdi3lIOUyCHOHLRfbjzdvpb7Qmu5cMjmeefjtkFf+SU//htI3p0j6ZJzCdxa+rpb6qmPe0K04NrBmXdABFCHb3bpAAYvyxdngN7j9xeiuquEvExjm3TKaGyeQz3qizdNbvDlfJE4hp7St1PxMMDABED3xQNXtWPI/8cweM7tqpjaS0p1DoInOLuGr2oLLE9it0E2Af5R3WG5pD8KRGRN5QkSCkrWHp4mnXCNhNa6Lp6mXJ0q3kp04WezdqROM41/ZQgHW0FzIiZUzCiwSA6ndxeAHeh4WVPcK7HySUjhnTEXM6zhxpyGqxUb1K/NAXBIAtq25zoUIJtuxaEOtyDCSze1OFdZbKPUwQuAnQut2zYYB8XkDj7iGIugCUJr3GOdtduWVvenT7yYev+Eg5nA8ih8WacHaN/ZwbIYy2+0KNmnQ7nKiU9L6dzs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHc5Rlh4ZGlmUHF4Qkd0NWpReFowZUg2U25uUnlVSDcrZFZKcHZiZElXY0RK?=
 =?utf-8?B?aFBQbHZmVzhwOVk1UTJHV2hTMTZRNWR6Qmp1Nm4yUytFNVhWV1VnMTBObW1I?=
 =?utf-8?B?YjF3RFdVYXQ1c2psdThHaGtkMjRSVDhHdmowckpwa3piYTR4S1hSenpWZmhG?=
 =?utf-8?B?OVFIVDYzMkIrb3IyY2pYWVluYjRtQVlTQzV6VE4zc29KekI0MWxVQ3h6cWw5?=
 =?utf-8?B?YnVJTWJpQW5PSkxiZURudmxwZ1M4Vm5PSTZnVnRzT3NFLzNBdWVHSVRHaUFy?=
 =?utf-8?B?VlRONldQRlI1VHVja1AxZFhtcnFyblpidUtvaCtobzE5N3ViQWRqTzVGUUp6?=
 =?utf-8?B?QWpwZFN1SE1aT0kwdHl6NnBYTm13akJCSXhaa1l1M3Z2eGtyNjViaUdPdlpC?=
 =?utf-8?B?emY2bFp2cmgrWS9tUVZXVjgrRUVwOGxrNzdBaGRpMEpRUmxoKzFiWGM4Z1ho?=
 =?utf-8?B?Nmhta1RHK3hzeEo4L1JNQ01jMUhPQTI3WjdOeHBQVzBDbHk1aml2Y1dVL1Ax?=
 =?utf-8?B?Tm9jT0lCTmlaNEtISXh1Z1J6RE03MFc4MG1ZcVJlU0JFU2p0VFZmdTJCTldh?=
 =?utf-8?B?eUpjejNjOGorSHU0YnBTYzBWcjdjenhhWW9LWkYyOWRSZ2NrT0lvRDUyeGov?=
 =?utf-8?B?MU5LTEtxenE3ckxpQm5Ud1NVb21GOHhLZWpRclZTVkZBbXQ3WG5JWnUySmJu?=
 =?utf-8?B?L0kxVUtBM01ZanN6ZEtuZzV1V2w4NzhLeWVVeVVTejNudEZJbFF3TkM1TjBM?=
 =?utf-8?B?MVkzM3ZSbGE5c3JMekhQcGZQNSs4NVlRV3RiOTdQQkJaSjByc1FVSE5EUEpp?=
 =?utf-8?B?VWZRb0Z0VTlHeDlzNEdwZkhzNFp6MXpZT3lhS0ppR3ZRbUtSZmhJSU9pT21h?=
 =?utf-8?B?Tk1zNnhzd1I4cm5WSVltRjFXK2Jjdm1meG1oL3pMZ0xzb1Jtdk9ZMjBrNTV0?=
 =?utf-8?B?Ui9UZGZ4a0ROSTQwZnd5RExudGRiSW96MWkrWUJGV0FtckJlalJ1NTBmbUI4?=
 =?utf-8?B?cEdZUGlHT2wyUVJtRHk1d1RHbmtadDd2TXNXcUlvTjNBMGEyT0RlS0REcGVO?=
 =?utf-8?B?MWxDVHp0SFROQ3Z3NUc1MFQwTDN5dGhDaERicHBsLzd1SXZhU0wxOHdwbFJQ?=
 =?utf-8?B?SVBwbXJBR0Z5R090Wno5RUxML0VjY2NzVHpHWHJQRXhXQkRXbWFyVTYwMHdW?=
 =?utf-8?B?S0c5dXZNUUk2eElIVXQxSmxCTW1JZXNGa1g0QUR4V0hlSDZoMHh4enp6T1Zj?=
 =?utf-8?B?ZnpFay9pUXkzb1VxamVYQWxyZEVnSUw3VnN2eXJYUm8rQnlSM2VvTWQvZXVr?=
 =?utf-8?B?Y0k4YURkT2k4MnZja3BqMHpDZldtZUkyRE16clJQUzZBcmpmVkVKUlhWaTNI?=
 =?utf-8?B?aFRtMDg3UG81YU9peUN3OXlQa1pMbGphdTNiSnBvenBwNkZHZ2dmbDNIeWFr?=
 =?utf-8?B?ZEw5Y0R5eC9oblptWnBWWW95bFRXTmZWTFQySXdqVGNuNERKcDh6VFFaNHQ3?=
 =?utf-8?B?WktCVGhxcGs0aUZBS0ZxT2orUU9SemQ2RGo1YkpsemJ0czY1MXQwRFpsZk1S?=
 =?utf-8?B?MThycW1UY1V3VTVCOTlXeloxeU9PRmdmSjZ6bnlnSElZWVIrWis5U0NwWXJJ?=
 =?utf-8?B?UVpJYXRLeXIydThXSHlYb3ZCd2lMbjAwNzA0NEhncmsvRUNxRHhzV1pCaFFF?=
 =?utf-8?B?MHBzT2E0dGh4YVJQRU5TQXdpQTZiRUEwNG13OENZaWZaR0NuUk85Y0dBK0VF?=
 =?utf-8?B?bG1lYnpBanNkZjk0b1NIR0VZVDRROFlJalc4b2VlZG1wUXFCbnYxbnBGWkh6?=
 =?utf-8?B?YXNoSTBGaGVLNytVZzBLQzJyZnZYOVRUTThKdTVHU0hYSmo4M3ZLTTVxM1VH?=
 =?utf-8?B?QlFWcDVmTkQrMGxTUkFNTVZESGhwdklJbDNCYVF3YVg1RkxPUG5lRC9QOFps?=
 =?utf-8?B?a2lEOGNxTnNiMHJLbVN2WHhRMnI3K2lrZnkyZHZOdHFKRFNIT1lPWEMza3lh?=
 =?utf-8?B?cFVpZno2d29vOGhGZUtJSFdvMU5nSENVZnhDYWdhZDRuQ1NMZGdIZXJCc25p?=
 =?utf-8?B?N1huWTFVWUw5YlZxclVjSVZqUiswU2VxQmJHRThUYkNoK1EvQzB6emZIbEVp?=
 =?utf-8?B?MGwyc2dsdzQvZEFOdHBkSFl4clNBQkhUTkhvVG0wV3JoYk5WYmJRUVNCOEZv?=
 =?utf-8?B?bHhBdFlmZXhreC9VKzRIZFZVL09MbElCV3lIMFBhVjdaUk5yWWpuK1VOQWxQ?=
 =?utf-8?B?Z3RUcDAzcFV2L2x4ejdSQW15bW8rL2xkd295bDFxUU5YaGJ4dlBKVy9hRko5?=
 =?utf-8?B?Y1h3MmpVYkhqKzE4L0FFNzlCR1Vtd0hZWkwwaWtXZW5hRWV6T3prcTdCejRr?=
 =?utf-8?Q?rcW3d3uiDC+EifAg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7af1ee-12ff-4429-772d-08df076c1c4f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:28:22.4378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KuPcGxat2YmCP2601DXSqmGAe2naI778iZ4owpXND5F1/9hPBsKXhPKN22gm2uczqmBJHV8Zs2cJyRvrKtYlXk2gLPkbkWNPZc0tsEV8lM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11423

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

Allocate skb_irq_queue per-CPU and enqueue via this_cpu_ptr() so the
handlers no longer share a list, keeping the enqueue path lock-free.
can_rx_offload_irq_finish() runs in the same context as its enqueues and
splices this_cpu_ptr(). can_rx_offload_threaded_irq_finish() may be
migrated, so it splices every possible CPU's queue.

Cross-line frames are now sorted by timestamp only within a CPU's queue
and appended across CPUs on splice; each skb keeps its own timestamp.

Fixes: c757096ea103 ("can: rx-offload: add skb queue for use during ISR")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/dev/rx-offload.c | 51 ++++++++++++++++++++++++--------
 include/linux/can/rx-offload.h   |  2 +-
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index 46e7b6db4a1e..48d814664b3d 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -7,6 +7,7 @@
 
 #include <linux/can/dev.h>
 #include <linux/can/rx-offload.h>
+#include <linux/percpu.h>
 
 struct can_rx_offload_cb {
 	u32 timestamp;
@@ -175,6 +176,7 @@ can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
 int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
 					 u64 pending)
 {
+	struct sk_buff_head *irq_queue = this_cpu_ptr(offload->skb_irq_queue);
 	unsigned int i;
 	int received = 0;
 
@@ -190,7 +192,7 @@ int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
 		if (IS_ERR_OR_NULL(skb))
 			continue;
 
-		__skb_queue_add_sort(&offload->skb_irq_queue, skb,
+		__skb_queue_add_sort(irq_queue, skb,
 				     can_rx_offload_compare);
 		received++;
 	}
@@ -201,6 +203,7 @@ EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_timestamp);
 
 int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
 {
+	struct sk_buff_head *irq_queue = this_cpu_ptr(offload->skb_irq_queue);
 	struct sk_buff *skb;
 	int received = 0;
 
@@ -211,7 +214,7 @@ int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
 		if (!skb)
 			break;
 
-		__skb_queue_tail(&offload->skb_irq_queue, skb);
+		__skb_queue_tail(irq_queue, skb);
 		received++;
 	}
 
@@ -222,6 +225,7 @@ EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_fifo);
 int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
 				   struct sk_buff *skb, u32 timestamp)
 {
+	struct sk_buff_head *irq_queue = this_cpu_ptr(offload->skb_irq_queue);
 	struct can_rx_offload_cb *cb;
 
 	if (skb_queue_len(&offload->skb_queue) >
@@ -233,7 +237,7 @@ int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
 	cb = can_rx_offload_get_cb(skb);
 	cb->timestamp = timestamp;
 
-	__skb_queue_add_sort(&offload->skb_irq_queue, skb,
+	__skb_queue_add_sort(irq_queue, skb,
 			     can_rx_offload_compare);
 
 	return 0;
@@ -268,13 +272,15 @@ EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_timestamp);
 int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 			      struct sk_buff *skb)
 {
+	struct sk_buff_head *irq_queue = this_cpu_ptr(offload->skb_irq_queue);
+
 	if (skb_queue_len(&offload->skb_queue) >
 	    offload->skb_queue_len_max) {
 		dev_kfree_skb_any(skb);
 		return -ENOBUFS;
 	}
 
-	__skb_queue_tail(&offload->skb_irq_queue, skb);
+	__skb_queue_tail(irq_queue, skb);
 
 	return 0;
 }
@@ -307,14 +313,15 @@ EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_tail);
 
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
@@ -330,15 +337,21 @@ void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
 {
 	unsigned long flags;
 	int queue_len;
-
-	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
-		return;
+	int cpu;
 
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
@@ -353,13 +366,21 @@ static int can_rx_offload_init_queue(struct net_device *dev,
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
@@ -420,8 +441,14 @@ EXPORT_SYMBOL_GPL(can_rx_offload_enable);
 
 void can_rx_offload_del(struct can_rx_offload *offload)
 {
+	int cpu;
+
 	netif_napi_del(&offload->napi);
 	skb_queue_purge(&offload->skb_queue);
-	__skb_queue_purge(&offload->skb_irq_queue);
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

