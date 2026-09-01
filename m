Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F5137F007;
	Tue,  1 Sep 2026 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251977; cv=fail; b=erlp1u8zoHbrhdW53CAoHxycB1vzTSiTRGgQtNQN0cFqCL9MxdOh4JcamooWShcS0TWj5uBQQX1kOMLulka3zdFgtAqZ+n0LUhtnjYW2co5Oa/XMlDNi+tJqn0s2YQ3hIgJp5rcoeXri7TmRDQxXilKkpQWz8tIlUdlcJfY2g+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251977; c=relaxed/simple;
	bh=nH2wEEh/huxut2zRVhEmUvOUsDgaNqWzQ7kG58N0nxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y08OV1dWrc0dbyWiVv9rEmkBk5k+tPWaP2mZSW8qdxpv+eJL/upkNAakkdKiDdqhkZJCsHHX96odXu/auw5mcJx1rlrcuY/M7TJvWdxwQ3u4Wjui2Ra8kOTVj3+6cb2ijGqEFWblpPbML34n5F1kgGtC0/IfjfIQ4xt4QKDg0Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=keht3E83; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="keht3E83"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYen1GLnkzwKQTjcl/ENF7XXr8X8Mu0cifvqM1v9clvrqZEPrwjfsQgbfhWmlxEV6yojGfXunV4bis3rSpOH+aU/pB5lx0pZveIds9i6E5QclAHSP5MOxzXkr6R8yfangA0imbWHTt7hzQSWWzog9LT6pwBXnGNnNcWcs+LVjM7SupKIUos3giu+kSsUq/Hcnse56DIaQPameIitvBshBqEk0Lgtae3MmSpgtQeQbNwr7nAcFqLgQpzIfn+4HU2ZSH9HmJWZm6HswR8lP1fr+D/SGIwu7cuiItRkxeqbQmwjZZy4HBHzMVPklB1fPi7kwKOAPyWMsen/M5w5UXRQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FBWJeS1MQOSdXBgxfttU7zMh63dJLVmgB54nZNbWEU=;
 b=a/+l/uAXFShmZ3E6MrWwCk3IytmMEGP/dUnsEjOfpW0aRHJtXMaiSTQABsSYAJhWqxF4vGaKMvOCA4qcXFsELJ2QAH+cJejZjv98lB57U/jGoGMtf65zT0waCCvBUE9RqbFwQB1Bc9KTKs4ruuj6kydjWhm/C1XocUcf39CizQFDMFl726c4Yrl/hotAi59D9nTgSNnZl6fNTv6Dagz5H5/FOR8Mnx+eMv5zzA36uhAAK2eio19mo/zvAY+CtmjeGo6lwLXys4wx0b9njMQlg+YNs0EusKtec0bQ6U6fq/u92NKTeWj6laFkzMoWWeBoj1u+2PzhXYHjAo6FyPVAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FBWJeS1MQOSdXBgxfttU7zMh63dJLVmgB54nZNbWEU=;
 b=keht3E83RmUiJMAkTJnd7ZTF5UEhKa60mPlvtZMUtZPwIf6aA8V+Rl/bmRdIFZMg5gW5gWIgSPGWPo++WiF10ErLWuvvVe/g3I5a4iZdfOce7zX9kTHIiABf6Rq2bNO59f9XG9bHodP75jKfHQ4Yut0z7ijJCJE4Lz+8Zq18aIls/DRtT8FYAgJpDvuCCTn39GRwbVo1Hnd4bojgRVML2T63JtN2Q4a8wCs2Ab6RgeyEW1IjtMgVm7KdvEejxqrqvHgRccngq+x0Hw8E09eIYZlcP+uXsbnGgr2zFv5FjI75Xhk2u7nAwOlmRussXZzatRxnxo32uPJWAkvZLE/6Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AS8PR04MB9077.eurprd04.prod.outlook.com (2603:10a6:20b:444::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:39:31 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:39:31 +0000
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
Subject: [PATCH v2 1/2] can: rx-offload: make skb_irq_queue per-CPU
Date: Tue,  1 Sep 2026 10:39:26 +0200
Message-ID: <20260901083927.316283-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901083927.316283-1-ciprianmarian.costea@oss.nxp.com>
References: <20260901083927.316283-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0307.eurprd06.prod.outlook.com
 (2603:10a6:20b:45b::32) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AS8PR04MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb9d1f0-36e7-4733-5430-08df08048ae1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|19092799006|376014|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	SUqxtMMEjxYK5nBqd6/Y0kH2IlubGwtpam3xGGP03fckQyl+lP3XDRwIMLHmr54G7TSEwJnewMogJm1QCDD0jiyL1RjRSNd4cXLDLO7uGAtcC1i5IEZwl2LIpflX27SPLZvrrHuP93N8z7uMo0qmpwrkaW3/KNEXTiQH4h7LdhgfoHGStmzWvOIYB7zFzEIVV3WqThGBfOU7lFBBOxjSMofvNmaJcrpPVsYNiwmlTr7nsTtbiVGfXVGcfbg6zNZfmnaOBL9fG4+mLFUUeDrU1OMnec6pu+r31G8J9X5/HpU9KIayJ7ao245pJJF27nvVNZy8uGOG9hhY60RNfBeQyGiVF7pEGWm0pz0oIO9klkwac1Q0ktRRBj6gYl7WdeKgrwQiGgd83G/MPHEI6zcLo0FNkSzxDL1RuyJomL2+3ADXaTgZnr3SDDAn0YnWO800xApgjqX/I+/M0bhR88lwLx3i11/e1I5dXnR6rqDJubUc/E6eK8hCnQH6sek8VbJyg6UTtodmq1nQ+2OQiDY14+EeqP559Bh0wqfIxxn5nSKSqyKc4I0x7+ZSw3kPN4NpEyyQIJqYIYUw8yaQA8t1TbRq3xZJJcOkAuMJ+E6/AeJ6WWcm4FUMgl0VWtliSQFATAcjjfNA6LKPoS06uE9nMBjFvsElOJuG/iKnKQJIE3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clpzUEZwZElnV25vaEFxU1h0cVBuNUQ4M20xV1VrR3ZaL3pXQ1FCaGtTWjFG?=
 =?utf-8?B?bGVyczdocjJMYnlnUmRvNXJ4ZXBjMTZ1YklvSFJnTkQxeVlWVjBLYVU0QXhQ?=
 =?utf-8?B?WGNGYkZ3YW4yUzJQTk03QVlnZlBMMFoyb2p1TWxtOCtNRU5mMmUxMENzTThj?=
 =?utf-8?B?cXdSalFLRnI5M0tNRTgyWXdDWDA1a0RKOXVhaHk1MUE0SS94SGFrWmF4NEI5?=
 =?utf-8?B?VWNjei9oYW54RDZISFNFbUFXMTJvMFpHYmNWVDNMNDI2RzBGS1lNNlRvWjBp?=
 =?utf-8?B?ajZ5SWQyeFVGUzE3YUZRWUVsdEQ2VHhReU9sMno1cCsycTRZTVBYbkU0bnRR?=
 =?utf-8?B?djJmOHpLNE1IcmRSVVdBSFdwbzM2TmNtZVp2NHJjWU1HcWpRNVdFOVlad21P?=
 =?utf-8?B?aFFpZUViV0NYWTdOYjdrYlZLTGQzTERQZ3ZxdkNNWlE3UEcxRFpTMEcva2Yr?=
 =?utf-8?B?Sjd1Mmx0K3NlMlFPVnB3VGkranNYR01ONGI5UlUrVHBSZjcydzMvLys0d2Mw?=
 =?utf-8?B?RWErVjF3blhIUDFlSHRydFhZVk1jODFKaHNqM20vbzZXbUpybFIzS0pTWUdY?=
 =?utf-8?B?OTkrUkh1MWtadTY1bHdjRkJaVU9DNTJqSnZPblBOSlpZNC9mZlBmL0Z4alFp?=
 =?utf-8?B?eE5zRmJXeW1BdlVlRWJGZS9BTnoxeklUd0F4aU9vMmtvTmxsWU9id1NGdWxy?=
 =?utf-8?B?SXA1Y09TTWhZb1pRU1EwQjgwOGVKQUN0UHBRb3lNWHRUdGlteXRIdTM3VDlO?=
 =?utf-8?B?TVBMQWdpcVhGNnM0OE85RHJaeHhPSXlnL2EwejZyVWw2ZjdSMzBaaTBiZlVG?=
 =?utf-8?B?am5ZWnRxMCtUYXFWdGNZRURMbGZONGV2WUtlUEhPZkhXYW1Cc0FZdW9jSlkz?=
 =?utf-8?B?bWZUUFBpUW9nWTF2cmtkRnNIL3lNTzIrUUR5Z3dQVXBJR3dJdHkwYUp6eHRx?=
 =?utf-8?B?anA5VHRNckV1dEZwMGJka1p5bk02R1EybFAzU3hPSldCV1U3dkJ4TG1NV21H?=
 =?utf-8?B?ZlcrSnFvaXlkWHdlTit1S2I5aDBRZHNTYytjNzV3UDJCTTlVUnl4b01YYTZm?=
 =?utf-8?B?eEE0eGFWSkF0bFJPWHV5S0VHWm9ucFcxbVg0UUNsV2s0WnFGS2NuMmcxUERK?=
 =?utf-8?B?eGphYkdhVVpqYkdZQlQ0bFJkNTRkOW9iN21wSDNWdzA1K2tWZHQrdWVJc2t1?=
 =?utf-8?B?eXhrR2hYVU9oMm5CMEZTTTEzREhQWkhJazNVdmRWam04dEE3a1ROVFl6dXRs?=
 =?utf-8?B?YUM4YzkwZyszaVF5bWFqWnAvcmZxQUNvSlVjd1ppc1pyd2N4OUl4cTVaWnJp?=
 =?utf-8?B?SzdXaGpESStYOGlBSmJzamp1YmpsNnBhVjJJT1NxZ2kwOVlhemdGVXpVaVg4?=
 =?utf-8?B?bCtWNGFtbmFhZ2dSYjd0cm10TzR0SUJabmhzS20rTWt4UGQ2aTdUdFVyYUF1?=
 =?utf-8?B?Mk1oNjFNalN4eUp0d243cFdhQW4vc2luN3JkWHN4dnJzNUxtUzV6Qm1DbkRZ?=
 =?utf-8?B?SjB6WDhyUmE3UkJKZVFrb1E2Y2xjVkxBTEh5OFdvZzBpd0ZjbHM2ZDdqQjN3?=
 =?utf-8?B?WVl5ZW1nWUMzKzcwZjFBbzhXN3BzK0RIQ0tqbXM5SExlbVZmNWdxdHlRL3Vu?=
 =?utf-8?B?ek1KVWpkdVFNVzhvRXd0SDRNOVBCVm5oSFlONE1pcWF0V3BsdnNDd1B2Vlh1?=
 =?utf-8?B?dTBiK25jZVF2MVFnREFOTHdpOTFkcUVXNHdkbVo2NVU0M3dXUXZjQlI3T1RC?=
 =?utf-8?B?dFRSdk13cWo0MkFwN05rNE5TdHpoVmZHK2VDSnQ5cmU0YVlBTklsaVBQMTM4?=
 =?utf-8?B?RG5NRVBsYnN0UlhYaGd1cHRzemdkb0RVcCtiWUVoMmRMQ0p6cmdRcW9raWhN?=
 =?utf-8?B?M08wYyt6am8rbVR2SW5hSmxiczQvS2Jhd3BLbHJSL3BoNko4TzlDZkxabENi?=
 =?utf-8?B?N1NBUFlEdmJlV0ZqMDhCcE9CdUt0UG56THBGK0JEYWxBWU0zdnJzWHNmK3da?=
 =?utf-8?B?U1g5TTBTRGxObUZXVzRLYzBWUGMvSHQzS1JkTENhMW8wVkF5azc4OE8wamNN?=
 =?utf-8?B?NFk1akdFbStndy9WWXFRM2tzQ3lvZXpjanAxODFML2JjOEE1bXpJcEdPb2hP?=
 =?utf-8?B?TCtPMHI1bm9ScnlZbEwzTnR6Y1haYmh6dGt0bUZ5WG9TbWhzeHlFTk50Vkxt?=
 =?utf-8?B?eVJITzBSeUdlRTBMWUM5QitsNmdwc3pVNHZZY1k4TEZHempEd2RYT3pqZ3Jz?=
 =?utf-8?B?RWFpY2VQRFVjbmk3clBPT1NNU3VIUEFPWlhDMFRIRUgwV2F2Q3VyanM1Smd4?=
 =?utf-8?B?bHBYVllqdTRhQmZOdk5uTWdNSmd0M3FQa2RMQ0VHNFRQMElYbGVqaSs0NVJL?=
 =?utf-8?Q?rAsclRe6uZveMtPg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb9d1f0-36e7-4733-5430-08df08048ae1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:39:31.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3qK2iRB7ipgTUsY9TxtsRrnOtRUv/7aHa8o0efZpk0E7LzpdXIH8w/fC7ZtQdlJYoi5fMrg+fejQq8rA3M1aEQnUprmGxDbUgcfHc5e9RA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9077

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

