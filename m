Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013023.outbound.protection.outlook.com [52.101.83.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA647CA68;
	Tue,  1 Sep 2026 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259277; cv=fail; b=rLSgcJpiXGjKDEP5nLe8SaJnVE/EhmuzHCdhf1PY+++G2D/gagmXfhKUSls4IYuQwL73zNsoGUGVCU4r5V+odGgbDzo7S7UsX8mCI5yYwgzJAzNmGWMtabiutxItAecn6XfPQNG8yFoqjzGUEor7MfYpJ/hLVjPnHWc05v858N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259277; c=relaxed/simple;
	bh=nH2wEEh/huxut2zRVhEmUvOUsDgaNqWzQ7kG58N0nxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dy6BShDPLM0gDohaeBM15Q8GtnsLHafacw7shltRJP1hmiZe9k0a54k1W0df2z6MRuXGw1JbDEIScswjz97jUD5fSECutLBMcGuyACyMarVmbeitBEwHtbE6pShKjM6baJ4bo4KU/oUMMHuELrZqWItmyDMZTHbS0gnTRm86eCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZnHKr0UL; arc=fail smtp.client-ip=52.101.83.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZnHKr0UL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjdXmtVA2P+fCwqVyD2dtTbdd48Yq+L4vxqyOublt0NtxssttwPGQdCdStssfb7R8Yw4LhgoSvmBD6TwbD3VaMzM6CCe5QNd5XjpyTBaqTf6RI4tXrKv3N6OtC2fRyay48gotCiPorgFWSmLYs5TaR0l0EaG5Zd9dVD6k+WcK4XVglYC7za8Y8h6Ad0kWhAII/mKkXmIgWjTzvcUMvxxin4m1vYFmEDjH624IcU88JEoiEga9iecdKyClQYPS5pzlzTX30LgH5Mvh0spFdP4dIMXrOIPHeQALfs/P8hVIDsZ/178uyGiZW9e5RYgJZuDpBEjJFVGj50OAHcTxOKh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FBWJeS1MQOSdXBgxfttU7zMh63dJLVmgB54nZNbWEU=;
 b=vu0XCXD+Ahy0SNguEELuvx6jk6DLFeg5Y5xCj+rHc0qIYQOVzVqnXS9fLL62Le8/BySnTJXA7DO2c1faVEVDgXOoElb8YmPije8WL94BAtVguYHV3GZ1qKiCTWDN3InSXQWRRauUMEKQJifUEwc0zngNzvEN/Nu9y/mwVzCMOMdYKrImpiyK2RniVNc+Su6Gw7R5o57hDZc6kZf18Dgth65BmG79GnjH7qJZUq93lSZmpui3R9YYpLNWSsvMPnmEhZc0+mOdg/W6UypzIiX4ecEkdXMiwJyunyzBV9Ob9i8RQttptZEd0DfoKjgd85Skhlh5Z6vMDQ8DqFKghqYHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FBWJeS1MQOSdXBgxfttU7zMh63dJLVmgB54nZNbWEU=;
 b=ZnHKr0ULmESE7CnQkhFbbnmbA6EGHuIMIlyo5aP7HJ2u4ZRrUNtyhOMWk4EZo5TtOAToN25QobyUWfL7ytUYmfr2Vfh6hg77E+Kc0Zt2pi8kffZhJ7BeITSGoZqlkX9fAQ4pDOGKxRxHmkTPG5DTpgC1lC5Zz3MDlNs2oiBlERNHAOITAPlwXMfdUrCSWdwKH/7YX9HdNIPPG0bcxoyFEOr8WNL2VKkbOx9i/j+CvaBYdPayQDAmjU7xMJ923krmHHxJH0RJC6jGWc10YY7rs8M3koT8tYT0z2DtTEaCbKpa5ljsGc2uqkYoa57h/c9AvxYm3AQxTLhfjDlYd0RSUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by GV4PR04MB11942.eurprd04.prod.outlook.com (2603:10a6:150:2e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 10:41:08 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 10:41:08 +0000
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
	s32@nxp.com,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v3 1/2] can: rx-offload: make skb_irq_queue per-CPU
Date: Tue,  1 Sep 2026 12:41:02 +0200
Message-ID: <20260901104103.458619-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901104103.458619-1-ciprianmarian.costea@oss.nxp.com>
References: <20260901104103.458619-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P309CA0008.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::8) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|GV4PR04MB11942:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7fcb39-1440-479f-3145-08df0815884d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|7416014|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	H7Yc8vrmmbvjzicoksz8FDUowdoPt9X8wjWTktgu1hcRDyCrGtHIKuz9QKapKRfd7RpXFLYEH8ymVJGllFcjW4vMP9WGww9nEzsGs6FOuGF0253knY6+WYsf0OvvlvCQE7rffhsIFGwfwksi47R3TV8ZmPL0dT5xhxpOlYh7eSE/3zrfNMFBvsYTRPYe3R1R4jdd1mtmLmea1GzjX71IzmlP7eilww07fniBbdilRXcpiFRM6Z5QmmcBF7k/uv75vJvQA6iPKcFUZzibdNhnSWjmH7dPa7H+3DpOSw/pLF5gpTlzhIuMsCL0SSvIJWD2lAJBKpGyevzIrtyM+18sRRg0mkPC/FUoMLEvB3kNSNRq6h/qF8XCnBu5QMV0JZw2Wn8vtbRtZH9yXPqoBh47P7hMRgkbJu2+Qr65rgeUix9qCn+UOVYYIWdmFJEhn1jPe18Hl4NvH+svHJExjhBrNscc4ERA5vljL5WafzC7G/cIlIBp4XrRwR/CmfUEpU/KyNw7D16Oqq6SUFTuxRE4x4XWpVXLwodOZ2+D9ZUPxJ4vCH/Clwo7JzuyRhgW/SlHfI26a4/K/JQpNFBWPpOX5IdkF0hdmH/eGxKswOaVoTxQBaSuHX+nISYMKrviRyBuXpSwVpthbBWslvc6TSGhCtXkE1OCz9FgU1m5zYQQhJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(7416014)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1FJMi9KRkdTTU1UUlhPcitoWUtwRklVaGZiZU5GZFdaSCsxNEpvTElHNFpM?=
 =?utf-8?B?NXFkTUY4VEpoWkpBbkJINEpkR2lOUXo4MjA3ZU1TYWZxUk4xc3Vad3owSUJo?=
 =?utf-8?B?ODZUNnpJNVQyYm45WUFGKzRDbzhJZzBxdllnd3hiOGN4KzRVMmoyQ21PRlVo?=
 =?utf-8?B?MHJPVGJCRG1HdXgxR044WGVhVkVWM21VU3dQUlB0SGZPcjZtSkVEeGVhRHEr?=
 =?utf-8?B?VkdIY3dPL3ZSRGNqT1dBS0YyK0hqOEJQWlI1cGtrTjBWcFovSWs5c3lCSlY2?=
 =?utf-8?B?MHB1MXJ1RFg5Z1JpcHZEYVlBbTFmZllvODEzeFdnU2pEbTJiWWpqMG5MbDE5?=
 =?utf-8?B?L3QwQVdEK1ZMdVF3VTNZTk9yY2pjekdJaWtSa25JbGtkNVkzQ3NxbTM2aUtu?=
 =?utf-8?B?R3Y4Y2ZhdXpQeTFSMUpNaEcwK3pJK2ZGWGJwSEowc3JhWStPUFhpUy8xOWhD?=
 =?utf-8?B?MzdUeTNGVXRXWGt1cU1zbzNwNVNtY0h1MittMXVsT1NIWkdOK21mRmlZUnFw?=
 =?utf-8?B?U1JVM1pRaHgyUE5iMUJuV2IrblhISlpGNzF4RURUMkFJWmFYZzUrOUhkR3RX?=
 =?utf-8?B?NEJBeGFyYWd0Z3JpWjZ0WVpJYURvdlFBMGRaNlo1UVBPYTNDUGVuS3M2eWg3?=
 =?utf-8?B?WHk2dzVKdTc4WUNXb2xsbGdvbWI4STJpNjBlOFZzbWJjWFhTcjJCR2YxNHpy?=
 =?utf-8?B?OHFNRGNHRzlpMEZNWUduSmVKMGFuQnppS3BlODB2ZnFCbG5sL2FsTmR2K0hu?=
 =?utf-8?B?REpMUS9HUFQzWmR0RXIrdnp5NHowN1AyT0UwV2NaK0tWd2RDN0h4cm5tZkZk?=
 =?utf-8?B?RjBKRGxnVHhIakhzbDEyeW5wRVpkbmFYdVpYS0NFekdjWlNzTXh2M0doSUlQ?=
 =?utf-8?B?VUVOQnVkNDZXeURtSElDQ2lpQlZkZHNxS2VxSFM3eVppUXZxejN4eFp3WWgy?=
 =?utf-8?B?VXlESWprc0F1aVNWWERZTktnM0UzUW1DdXlGb1hVOFRRNVdKU05wMS9kcG5D?=
 =?utf-8?B?cHNDaFhPUWU4NjhRWUZjSnpEdS9VM0pvclBFRTVueTFZVHhsVklSMHYxUC9G?=
 =?utf-8?B?N09wclhvcjlqK1FnR1ZWeTdXQmY5Z2ZVT2pCUU9Pa3ZSRmhYMnU3WXA5NUc5?=
 =?utf-8?B?S0N6dk5xVGxpaWUwUTlQd3hnTFdwQUt3U0IzajJHUnFQTklmejVYRER3S0h3?=
 =?utf-8?B?S1BYWlJYTjVET1dGOVdwYXp0VUNXdUV2eWxpOEs0MyszYUNxUFhCeUpsODVQ?=
 =?utf-8?B?QzBNRGRzbTQwaitQQWFUTUdZOENxeGdlN1BvblA0NWNYS3hHRDlzamNOd216?=
 =?utf-8?B?S2ZWOHVxN2s2RThxWFFMNUZsSXFMS3RpWDFHTDNsVnQrY0NmdE44bGJKK2F3?=
 =?utf-8?B?Z0hyaitYOG1MSjFKWlNvSHBiS1M2d2FKWkQ4Q1krTllEREVmUHF5Tmp2ZW10?=
 =?utf-8?B?N0RVUHNkN3ptWjB0dGd6amJXOVUvQ0dCeGlsL25wUisrYnZNSzBFcWhvLzBL?=
 =?utf-8?B?MjlsYjNidmwrWjVjVWp3bUVZaFAzcnE5ZmsxR3U3NzJ0Q3g4aHBwQkdpVmVz?=
 =?utf-8?B?NFU0ZXNNYzJzcDlpK2FtejdsNFQxYWpORXQrNnFPaDEyZWJhUjUyK2JLTVpQ?=
 =?utf-8?B?WHFFK1lWZWxrUnMwZ3pDdVFMRXk4UWxacDdFMjg1eVBOMmtxa3U1R2t2R2VU?=
 =?utf-8?B?cjlpd3g5S1NqZkg3VmMyZE5nQnJDVThCdkE1OHUzNGswdzFIRktrL3c4amJt?=
 =?utf-8?B?LzNzM1FXWFR4MlpCQmhLM01waXZGK1FLNk9ERERCdGxidm5OMWpUK1VWaHpD?=
 =?utf-8?B?T3gyVm1sYjhTQVNuRnhJMHZYOWY2V2JuVzZMZWcyaEh5aldEVi9JeG9xRVps?=
 =?utf-8?B?WHpYc0pCa0cyQkVQTHVzSGNYam5VenZLN0VPQjcwRkhqbFdGc2tMZG1BZzBO?=
 =?utf-8?B?dmxlTElIOFNSVDduWllTK1NpRmIzbzFpUjZmbDA4aUhOb3p2TGMybWdpU25y?=
 =?utf-8?B?ZFNrRzh0ZmRud2xoUEJEUHF3VE5zSTNFL3hUSU9NNDBUNEJpMUx1ZEtFSTM5?=
 =?utf-8?B?bU1IUSt5d21yNUFCMXRTVUlCNmpKVkJSZ1hML1VKbU9DcHdVcXc5WVU1ZmJO?=
 =?utf-8?B?a1orNUsvdDNTTHhuUzMrUmJzZHZXaVNleUhZN1M5dEx2UU9WVW9KakpERG5C?=
 =?utf-8?B?elIzVWRraTlsSmRtTFk0cytRSEdKK0YzYjk1WlEzQkZrdnBmV3ozNkM0QTRZ?=
 =?utf-8?B?cExzRUF4cm1vd2VCOHdHUVpCY2NRdk9TY1JrZkNFWUE1d3NjS3MyNDYxRTlz?=
 =?utf-8?B?UHd3czNyZ1MrRFlCV3M4QXd4UE1QWERXQzZjZHVFVzdjeVpNUlp1eVlWc1Jh?=
 =?utf-8?Q?0dIpLnd/YWkGJ/4w=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7fcb39-1440-479f-3145-08df0815884d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 10:41:08.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +drWUL27YYt8sa3xXOr/UypJa4VbaUBkPHbFgv67t1uvuxsPMg1FA8hpmLjRwBqyF8gMuNECbzyFmGIc3955oNT7oags09bLN2D4qw6diW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11942

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
---
 drivers/net/can/dev/rx-offload.c | 83 ++++++++++++++++++++++++++------
 include/linux/can/rx-offload.h   |  2 +-
 2 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index 46e7b6db4a1e..649bfda08b65 100644
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
@@ -330,15 +354,29 @@ void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
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
@@ -353,13 +391,21 @@ static int can_rx_offload_init_queue(struct net_device *dev,
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
@@ -420,8 +466,17 @@ EXPORT_SYMBOL_GPL(can_rx_offload_enable);
 
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

