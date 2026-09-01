Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013039.outbound.protection.outlook.com [52.101.83.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC73AE195;
	Tue,  1 Sep 2026 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263339; cv=fail; b=B5W6a4ttjCHbl55S7/hKamSp9Bv+EYiTOyM/QRjaVSd7j8MKyOokztzKIAqwb7JTdOfGaCYp32mfyA1ZaFFpX+vB2UGVlWeB/UJLBfG49EGBca7OQ9A9PxVs9eE5PaY2oMjhx6WL6yQZU1E26koyr6GUsUg+QdobYABpFNyIe3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263339; c=relaxed/simple;
	bh=nH2wEEh/huxut2zRVhEmUvOUsDgaNqWzQ7kG58N0nxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xv0NxQ/Lq3G7Uz3AT44NzIan2427C+JxfpntRqNkpvBuWXrXs7grhUa9HDegm/Ax5aj/tC0vHcXEF4t1K/07U1NatoJ6uGPJ8zYzijK3FSeQVM5mD0ztg8ERoyejtUBQh15tZJ34H6+0Ee2ZoDIzRNa5AHd1znwRYIMm7imM4j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=S1cXktB4; arc=fail smtp.client-ip=52.101.83.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S1cXktB4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTMa6sQk/SKc/jvHIOinRTgBdyINOIRSaWSa68sTfpRyWAemXLJ8GaCry2jOhKodYTRy95vjBBHOrUo3D/zc9QWoT+hQxrf8mvDYB/tBjQ0d8sNVI3EYkmQfJimrRUv8DOEzdG7CO9Z26H9unQ89r6XQm/sB0jYVr+tC5XO9aSlHm2uFs2ewaxQIJT/zJTLWodJWoqudg2/5sntHs4g+A/LiJIyUJgAsKZzC5f5APKxckYivFFLqfD9Njp4OU4Xp4zCim+11jQEL78GWtTKPIGnwKofsmcldN9iam5ViYa+Y97ge54ksLwGJnVuu2EKMK52a15VQNEIZSgAKCXrgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FBWJeS1MQOSdXBgxfttU7zMh63dJLVmgB54nZNbWEU=;
 b=sTL5PVX+Yi+YAtWIZpefxGs07IXj5N/YXU9vZs6oYjYKmyZT9qhPSfLis4cTwf7GtggrUXEMXQ3km4h3ZNRDwx60v5bAGQfgXCLUkbiQVUksA4bsOQCavOWddZmMPZYBs9w7ULXQz5yfivT9gZ7EkXWFIvk8uZ3A9MxEGqFS/PexTZayUnXfbIXjsKuO8GRjb5uOU3Qa+IldBkfWJBADlLvjDbFrqQrXgjP6ETUX2nHWfa94MWtc6B0x4VMOCT8FkMPmG/FehwXBzKPkbXX/IlAhXVD6RWgsUq7jl0MU1I+t9SJinlUPjEGvjuPHbtxvhi7Z+vi5QCoYWbqG2kkOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FBWJeS1MQOSdXBgxfttU7zMh63dJLVmgB54nZNbWEU=;
 b=S1cXktB4brImSMUd1uhnV4JebSwjCg2PhftkfFnbpz5NW6324RjCqiAHWltAEVqNXKDD8cFwhfONBA5MlTwdNPuTMKE1vkh/E3Y8JK0e3/D7VjOg3YSvqZPAk8cK1r3IXqYqrFWjvUnxzXHHaXkUn4vMsOie3Pi33AIUPGb2OQXnZ91o9tUCuHywXLTXFP4FiJNTDU5C30xhyPI/hZhSZM60ty5aDNgWLDiK5uISFWhthfMOYp8CjkkrYq9QBa7c4Bqc+SQk/zk9taNC7N7A0Tl5YpS08cTZ21L5BpyBIYwF/e9Z1T3YWfSsOTA+nshn9dL5587Os20zV60Yk1Y76A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU4PR04MB10717.eurprd04.prod.outlook.com (2603:10a6:10:584::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 11:48:53 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 11:48:52 +0000
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
Subject: [PATCH v4 1/3] can: rx-offload: make skb_irq_queue per-CPU
Date: Tue,  1 Sep 2026 13:48:46 +0200
Message-ID: <20260901114848.500591-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901114848.500591-1-ciprianmarian.costea@oss.nxp.com>
References: <20260901114848.500591-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU4PR04MB10717:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd6ca00-1e1b-4bb6-c239-08df081efe98
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|376014|7416014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	U+I52vR1QjEclxKVK753g1TRBTZnj95a7jjAvwf3ePntCZJ2spshqWIwEWLF8KJopITZ1+vDkG3rR482v/19h5lxMjk0RUZTAe44uvbBGhc7XCzAW8N80boUQYeoYQ1x6MztGK+n8SvXNXY6xtMhOYFFNzP840l9m4IKzwnCtGguMpWvc/cjEwPDylHU6BZ0EYeICIYnWhov+XP2c2BAvA81ExxkLvhqjiInnyS0PlfXfnCyBOHq6DMowFouzO2sUB5eWDg8FbbBn84QYjt4J5lROzQ7k6nSSxd5cs5w6SMo09bCJgEufYxXobd4z7a9i9BHySRpLfwQegMWARLRS7ef8haJ9XAu1ZIWNc26XZP94gFEWqFMvW4Jn/v/RBDFSv86gL+c0p0wkGPW92NMvCFoh8teCeDVp9CgsDeborW/CtLq6ECkun5MBEWDJ33+DAeZlsFqGypmQg0QDCq4hn1ObnqVAVRjRgO+GQPIOsPOLP5qsEzAMFOkkU/fr4NWhxJqXQZ5ebU+szzKCWdZU98CShRsuX+0Y69nfkPMQnoRhMI2M6z6wrbVW0xyNtNXSsHLSumVfu2qFtIf1CA6Q6td0c2a26gOjoutAPMMqFgD3LwcF9HJ3DQbCpkEYJfz30reyYJb6zrDVLcRLokiPpQX7lZmDo3avuRnL6tq6Q4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cExOdU4xeXpRWE5SVmh5MGlIQjFDdHVIL2JwdzVDU0JjeUZOYnM0RnAweWk1?=
 =?utf-8?B?MENBN0RHZGRPUHlTUWpiUk5kN2k2cVVraThqN1REaXphbG1xdHNzbnBiSk5Q?=
 =?utf-8?B?ZTdHeklaeDBYWXAzODY2am5EcU1vVXNmWkVJS0U4ZUtTa3hOSWpHc0xKQlBD?=
 =?utf-8?B?c29LOHRjRnQrWjBTOFR3NHVhcWNFS0VMU1JaZUNmSFdYeDFaVklUNkowU21V?=
 =?utf-8?B?SnlJU2p2M2NHYlBDM3BLM25sUzliRHNCZnNRVkpqWTlEMzZramJpUFplZ0l2?=
 =?utf-8?B?d25BSXYvRDlvWS92djZENTlmV09lZ01aMllxNWxXcU9HNm5RS0V1RnFFVTNu?=
 =?utf-8?B?WlhsRE5PNS9QZStnc2FrOGMrdjl0VXp0bmErNjh5MUNTQ1BCN05WNTlVOUFu?=
 =?utf-8?B?am9Bd1lURFhIWXdQQmJjMi9DRE14TE5DbXltbE1hbUQ5MldZd3VtYnQyaGNM?=
 =?utf-8?B?Ri9pQ1h4S0dWQURNVlU2bHZHVlY1WkFCbERWdTZ3SEZRUWdqLzlxTVE1YVA1?=
 =?utf-8?B?aWlRb1U5K1JNTW1xWWF2OWEzYzBXZ3QveGp3d3p2NG5ab0oyWGRpZWc5bVZT?=
 =?utf-8?B?VlBkOE5rc1ZUYjQ2cWNKeEdvSjdMRHRTSzcwSlIvMGQrdjFZZmJ2TzNvNEF2?=
 =?utf-8?B?eXVudGg0RjRCZGl1YnMydWFBaWppY20wcmttbnJGNzlrN2NYUWFac25iL1ho?=
 =?utf-8?B?MjdYV09Hc1gybjFERHM2cnJEV0srRXowZzNJU0RFUU9ISlZGT29WU093WG5t?=
 =?utf-8?B?bFhUcmIxNHovaGUrVUYvdU1hVXVIWW51Y1F2Uy9NZjZpTGhxLzRwcFpadEkw?=
 =?utf-8?B?M29IMGFvdDl5TkZMMVIraUx1ODFnbCtKY1ZIZVV2OUp1SnV2V1k3NDZyU3FQ?=
 =?utf-8?B?RFRPb3NQYlZhZDBteVVRN0d6ZGRTMk9OczhUOWhXUE9DUlRhU3BlckU5eHRy?=
 =?utf-8?B?MWVvL29EOURWUFdSN0lSeDBodnNKbkszeFhVc1NZaEN0TittZXVmanNMWE90?=
 =?utf-8?B?cUU1YnIxN1V6b3V1bkVTK1BQNEJNeEJFT1NRM3paMDg4UFN5R1BZRSt4VzB4?=
 =?utf-8?B?NGRxZkhHQmlsTittUUxrSGg4a3VGNTNjUXBicVJCbUNRSmNyVXNFS2wvbVIx?=
 =?utf-8?B?KzRSR0ROVnJsQjhMMU9jcldFbThiVHlPYUY2YVNKdUwyNStyNENNb1pjQmwz?=
 =?utf-8?B?dVNVbmRRT2t5VXhtQVRMRlZWRlRGZUJmVHFzL3RKeEZsOVBPZHRoM3F5Nllx?=
 =?utf-8?B?eEsyMVZla2tjVm14Q3FtTWU5RGF5aWEvOHpUVzNmTGtYS2NNTkZJNzY1NGdr?=
 =?utf-8?B?VWhlSmZGTFhNK2h1ZjQxNHE0dTlOTnQ2VlhXeUJHdTJHdHBDNjd4NXVXa3ZK?=
 =?utf-8?B?QzliOGFnUHVnb1EvaEd1SGU5Y1FZT0N4L2ZiMTBsajV1T2lYVFdCQ3ZISkRU?=
 =?utf-8?B?S0NidnlheUoyTzg5cUtmTkJGWjF1eW9kcTB6cnMzbWFTeW9nRitIS0pHUFlW?=
 =?utf-8?B?U3dOQjVPZ0txWEpiYXU0RlhXbnZsaWRPOTZGd0tRMzExek1CMnpLSVB5TFJK?=
 =?utf-8?B?WGJ1UjY0RmJ5SGZtZjVrR1lpaDJZb3FpaE4waG9ITitBbXFtclBDTXgzb1V5?=
 =?utf-8?B?THRSb0FlYlQ5RnFUdnNMRjBCUVpTbGdVdW85eXh0L0VwaFJ4QW1jSEw4YnRl?=
 =?utf-8?B?enlySW96c0hzVUtEdW93TmRvK3gydDI1bjE5aFkxRm5MTzdadjJqOW8vSjJS?=
 =?utf-8?B?UVBPL2s2UlhSMnpiOXZ2c2FtbnBqeWcvM0hCZm1WQXdmKzhPaUVydHl3WG9X?=
 =?utf-8?B?a1l1cjBialJNQ3NPdSt4MzFZV2pZbUVzVG9jbzVQU0tVR01GNElVdTJvOUxp?=
 =?utf-8?B?YXpyQkd1VmZRc1lMTlFJdy9jWFNSTG93TFVrRS94SG1CMko3dkRsaXRwMkxw?=
 =?utf-8?B?L3JLQlh6WlBRbUZvWnE1YlJvU2UrWnBvNFFDM3R1QUF1ZnZ5a09aTkJuS25S?=
 =?utf-8?B?T0pIcU5GVXBXOExaelFnalZxVTkwLzlrZFRLLzZxYVFQa3ZrZHJZM0pmZFhX?=
 =?utf-8?B?SXlSVWVoTmlyeXg5MmMzcVZKOW1DejVMZ2tBbk04UzdGNFpVVGRNVmtYb3k3?=
 =?utf-8?B?UUYrYVc2NW1yZWNOOWhKL3VOYzBpVXRiU0NwK0NhbzNaZkFuYllOdklLRVk5?=
 =?utf-8?B?SnNYSHJPS2syT3VKY1d4bWo3d05aRGpHS2FCdEYxUEIvSVYvc3dOZXFhZy9r?=
 =?utf-8?B?M0lUWmNnb2t0NW5KamkrWU5PaVl1Ky9ONGNsQ1JFRnhqYWFnbiswWGVUQzBr?=
 =?utf-8?B?dWxnUzA0VERiem5jZ1NWUm16WnhxNGw0aUZtM2dpeHVvUVlyM2dzbFc0dk1R?=
 =?utf-8?Q?Tpnjb+AEFq/ZQ+ew=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd6ca00-1e1b-4bb6-c239-08df081efe98
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:48:52.5190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQd9rB94SlULt4Xrp1yjoxoZJ+fH1jsI9rWQQDTXoFq/tDEAUpmltYK5K+wGUYFJy8JzqZ5vrnQN3WRRhT+p51sX4wGpkSAmQUxqzbF8dV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10717

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

