Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9508418A33;
	Fri,  2 Oct 2026 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925142; cv=fail; b=OV6wwiQjYgoJcTpUvTGOMRAyKCbHCkKGHNLpAi0twpfRLg7iHAxaJjmee7qZGyBOJSN+DpT0r2vCXfnU5P11WwAje6CFGUahpKHKQYT62U2QcbWdzm2F3YJ07DaT394SGW6i6koYeXyB+90Wt8AhCNqhXabF6g2YMD0VWvhvfgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925142; c=relaxed/simple;
	bh=aV02A2+XElLSXgGcFaH+K8JTarqXJhhg+xDTmo1vJlc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i04GI0OFWXHG9kylvIpspsYKYspWHZbD+xC6IY3iWHWYcBHfImVnnQgMgYnvBMZ+/z+a5fcDOLnD7EVVlbuhu1yg2bYw5mxRIJk0tM7CVasYb5fu1+FHHK8ON5HXI6BmwmwCdurYn6zfsnWZkg1YpVRmFxos3iJZNXd+RjTvIi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nE46WX9N; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nE46WX9N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tG5QAEPjV0VulqZUoLOSv2El7WZ+XeV/YB2ARYIJ/qPl8PqXqCkATY3troKblCkZAwj9QaA1/3GZVtkHkk05bTf4JmCDYjKugQ84UNKaavDyvEOYAKw1bEfpLa4GwIGGX7OFfj2rJHlVrzkbcdu+ekwuO/QwKNnnXLkNSkVEiZSLWV4F2cda2zl/yYReDRPW5Tn+gCEuQn4TBbZRBjMIPq9eJiKGTGsvrtFVDOSxsYT9PAdJfJZ6yELF26zmxNFvwKQ5EDt3f+z8qdA+fUs9G5rBUyMSZochZMGys3xC8/aMUAKMjwPu53ql3nOzjnY/yGIyZomgN7wgR+ff9Elgdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fsyQryMt+4AOyih/40O3biL4gPLOU1+CxwySgQMDiE=;
 b=OBp/Jq4jdeExS21DPDksIpbamqoGMHAozjGH9nx4bRV295dSjutOQff5WPywmmGADYAWuRrZpWJS1JWk1sE/431VE7eKSmIP7pyQNUu7CMjIsRuyKJNKoVydWnOdhg7JoRQx9He3llsjzbmU9HvFKapDL8oSo/JfclEoD6+n59SVqnUHhludzQq1DxaAbzCZAbpuzSc83XxRdjy9yB7E5vIJP+gGhS45oYJ+j3QTS0noyBrc7U8HKzTghGJx190LsYr35du1Zt/yls1tv3uhvsuDrPBrLj6diJT9dnAokG7qOWVB1dUORdtRVfSAJgd1QnzzTa4NU9t78WWL4zeB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fsyQryMt+4AOyih/40O3biL4gPLOU1+CxwySgQMDiE=;
 b=nE46WX9NC+Basvr5pMuYucE9OqgNIUx8lyatVzUKfBfO/sWDPPek98BZHL++yu4DVzYzkx/wVKDe9ySRYGqBthFRU3AXaFQr5I0wAAsfVlD/EJWbHTI0pTwovvy37u7Px0NdrFpaf66YJfkOszLM+ZXLYVPpVlKeyA0m3ZT52G1nPdWtwMlXHe/eJN1/1VlPXTG7Opqc2bpHe+pOu8M2ntlQvJZ3m3v4dEDUL4jvSFkJmZfTYF4VucP/DtSlSIoGdPCDc0Vmtl6lYdNNb5pC4as4Q8RR+1DzjLI1/nfyidkV2Yp4ivHqS456vU9bP5sBtIdH5pDm9uHJurHV/fO5+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AS5PR04MB9825.eurprd04.prod.outlook.com (2603:10a6:20b:672::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 07:12:06 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 07:12:06 +0000
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
Subject: [PATCH v7 0/4] can: rx-offload: allow more than one receive source
Date: Fri,  2 Oct 2026 09:11:59 +0200
Message-ID: <20261002071203.1287650-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::27) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: ab37cc43-c881-4ed5-a4dc-08df2054771a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	7J2wn7TNYQ/xHHQML+tCvypuDiLtWlvvvHEJURwmwhMcPDFCDTdxn0YogV0AAOrmT8YvudBlocsyCpSUkc9Ga/aohJhlgfSdHuaq+WEqpClFqAvfY2wkm8RR/ss/gqRHViUAiM05uDKxz/zn2EdyYrf4FAPzS8ckpJJksRdD7m1FNXLcavMnZ1AAUa2qxnh7Ty3Q9YtW9rsUp3ChG1MykAsEFt0ZgIBlx+coZ5vCTfK/+Lf67Y3OYv0KfevE0kSant6eyEy2hGbgX7p0HGlnAodDDJQJQ8bx+bB+9vzPMmOSs8JCViekdyjFs2VUOdBZq4tAPKlbxS1Z8npel51wBwAoUHB7vlyw5w4uIlPkZsKBUbFPZBqD1q8ZFjAI9e04zNEpR6MJZc4gEIy8PDjdja+UH1JHcjQO8WnXxMQtAsIQ903jkEgS0wbsuH25PTnh6V8pvT7pQjN9lOidX46EGK8qGuyuP8FV4P1doWZOoREoajKy12jLRXdhr9S+767yU/6AH0WrjbHSysygNPjO9DTQ56GLqCgwqeLLtnUMMgCvODLbiMPyYb72xesTpizwckvksbVR26gN6r01OBsPhIjVtO4XKrmj+/fxp/26tippVAAw78M2+E6puVwUFiHRcpp5cgy4ekMeqlqHsv+6o+aEDrLErRBA8npwCFK8f50=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWhvWnhSNllLbXhrV21TM1RCbnRPbThkdnFZclJJNGUyQ1ZueVdoenI3UzRl?=
 =?utf-8?B?aXBpTTlSUXdFL2YwdkFhM2ZTZWtCNElDWTI5a1lkYkYvVjlrVGdVVlNzN1Z6?=
 =?utf-8?B?YlZyR3Ztc3BQa0FOOFZiYnFUS1cxVG4vVVhBT2Y3RzhvWmNpYVRTQjdNUHZ1?=
 =?utf-8?B?a1FZUmhDeWlEVFU3Z0FTQlkrbkR3cjQ2NHc3OEpCZmFHdnZiby9xcElHUGdI?=
 =?utf-8?B?MmJ2eVM5SkhQZXdwQm9NdmI0cGt0cE5qM3o3cUVnVjlIdjJwdGNuL1dEamVa?=
 =?utf-8?B?ZllDeERlQk1ZVEJrbXhLbTdWMi9rbU9QS2JjL0hVcDhTL0xXNGY3bzBoNDNs?=
 =?utf-8?B?aytzZWNISlpZYXBtaUtpajUvSVJmK1dYVWhCK1RiNllzMHNhWllVK21YMExt?=
 =?utf-8?B?ZE9wWjZvM1RmUzA3cVNNSklScSt4YUpHZmQ0azhqVW9ZcHZPMTRLR0F0azEx?=
 =?utf-8?B?ZnYrVlhBaktqSDQ2WHRiMElMTW52YytaZXNUSGt1RVpNeFIwUGR3RzYxd3Nk?=
 =?utf-8?B?VldBc0c5YW1HWHkvS0pQQ1dJOGt1T1oySUZQdWdXQ01iVlJ1L0ZGK0hUeVZW?=
 =?utf-8?B?czlrS1ZCWUhOeGJpS0xtUlY2QkR1eHk3bzQ1dVdnWmplODc1Wnpub3RjMkdh?=
 =?utf-8?B?Vk94MExGdkJGM2g3L3VpT2djS3FBbkY1WnZsVmFEUlVSdWUyVDRtQnY5cC9D?=
 =?utf-8?B?NUZmaWZGUG81VG52ZEpFR1RwSWhCMXdUeHBYUEpUV0hMSloyREgyVVhwUTJX?=
 =?utf-8?B?YjdTMlFPQ2hyaDNFRzFYNVR2UGVmbm92SGE1MEs2RlJLek5GNjNLQXprUkhJ?=
 =?utf-8?B?eVNQV3o2M0ZQQVY2NlNWTGhFUE1pYW5WSUx1ait5ZFlBb0RJWURlTXoxaW9h?=
 =?utf-8?B?eUVjUGFpTE9OYjAwcWFNbm5rdDNCdnhPMkRVQmEyZXhWeVNnS29WaEhLM1k4?=
 =?utf-8?B?bHFKYngvbys4a3RZbGtLemhkVlVhNUpHdnF1NFp0ckVxYnBSeUdWdmxKRVRC?=
 =?utf-8?B?Sk9tUTc2dDBPK1hiS2hjSjZKOGdYTnRHaVd4L2VDeUUvVnlHM2ErNVRYN0xr?=
 =?utf-8?B?T3RuYk80bDVzWVU3YmxzRzhrM0k2UHFpUC9iaTlmTFZMTGpCTmhZWGo5OVFo?=
 =?utf-8?B?VnJNWXdPbnhTMDkvWjhyZzhTT3BBcmVQUmZhdlQ5R3piSlA2bjl6UXJVRUdG?=
 =?utf-8?B?MG5vT21SS0ZJYktENlhjTjVyUkZvQmQxQ01uU3RBeDZJSlFBckhORXNId2dT?=
 =?utf-8?B?K2ZXOFIzbmlvbWZNQjVqNEJ6UkZSSnp0aXhFbUZaMEkzalI0bXVyM003cWZW?=
 =?utf-8?B?Q0lQYXltRlg5bUVPKzgvbDlnb2tLVWZuSy9FbGZLd1hYU0Y3OGNRdnJiNUYv?=
 =?utf-8?B?enFDbEJTbDVoY2RXU3BCNHE5Q01mNmFwQTBYVWMrbWJBLzcyS0hWdHY2dDJC?=
 =?utf-8?B?N20xVDIyTEg5dmljV1BiSlI1TVVQSkhHVEFVeWhoUkYray9kOVRPL21kL2xU?=
 =?utf-8?B?anhiNHNmcTBBQWZaSE5sMUtoaE9UMHFPbnB1bm9Zc1doRC94NmJCYm40d3Fr?=
 =?utf-8?B?a0l3czBqdzhxbE9Sd0pReWl1NXVCblFnb1hweDZUN0dFVmFjcm9lWVhOcFB5?=
 =?utf-8?B?UHEzWTRwR0ZicFZzOWhhOVY1NnBEckkrRXUzay9xRGp5VTJzS1FjamVSNmQw?=
 =?utf-8?B?T2VLTkYwNUFDaUZHSmZzZTBOa2NlNjlObHVNdVp5ak5RZ3FoYmx3dlBNekE1?=
 =?utf-8?B?REpFUERLTGlkK0NENXNOdmNzZ3VSaWxWUzBGUVFndzd1TFRYczZlSGl2UG90?=
 =?utf-8?B?N0M4TDBxQVRGZ25JdzljY3pNb2xMNWlZdEhlWUtDZlZxeVgvYkVCVjZ4SHdS?=
 =?utf-8?B?M0Z3Vnc3TFNuQzAwbW9kbzl4dTZHOGNGaWNKdWs4ZDlBbVgwRHlud1FseVU5?=
 =?utf-8?B?Q2hBbEJyaGhnNVhPREc5TzkzWHh1Z3cwRXluYm5oU1Bxb2VOdy9QODdxbldR?=
 =?utf-8?B?Q01yWTZWUGJBZm1FSlhTeTVjNnJYVWNtc0F1T2xVRVNkSzFjOHIxWXNGSXRM?=
 =?utf-8?B?R2NvM1h6YmZubnNJbTQ0MkdFSDlFc05idmRwaDNuS3BaL1VpLzFJdTgzZlVy?=
 =?utf-8?B?YnZGMFdEVUJEYksyQVozbmJBaStCejhiZUQwa2E0bXRLOS9CWEtrM3ZPQzFl?=
 =?utf-8?B?REJDU2xMMFV2WG1CMlp0NnR1ZFl3MkxWak5vdmtSTHdLakc2R1k2ZUVlQm1r?=
 =?utf-8?B?dUtoWldHUEZpK2FhMWQzcnVDT1Z3ejgzR1JEc0ZlcmNLUkhuS28xMDh6U0tK?=
 =?utf-8?B?dEl3bHd1c2VpVFZCMXYrZ3JSQldUNGk4TTVBdzlNbGtkaVl4Q2c1WHJBdkZx?=
 =?utf-8?Q?L5RsuviAX3KYHrGI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab37cc43-c881-4ed5-a4dc-08df2054771a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 07:12:05.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukywA4eK7tbm9eYHC7yz/QBFCUpSdrI0i1vb4Srhp530Buq0x9nJ47eMy7pFYREayxDToqR42mCUlHSqtRU3Kl/YvvOIpJbzuDmitDg2HyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9825

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On S32G2, flexcan uses the same IRQ handler for all four interrupt
lines, so the handlers can run concurrently on different CPUs. They all
fill the same lockless skb_irq_queue, which can get corrupted.

This series gives each IRQ line its own rx-offload source with its own
skb_irq_queue. struct can_rx_offload now describes one source, and the
skb_queue and NAPI shared by all sources move into the new struct
can_rx_offload_queue. The primary source is added as before and embeds
the shared queue. Extra sources are attached to it with
can_rx_offload_add_source().

The IRQ side stays lockless, as each source has a single producer. The
finish helpers move the skbs into the shared skb_queue under its lock.
With more than one source in timestamp mode they are sorted in, so the
timestamp order is kept across IRQ lines.

The rx-offload API is unchanged, so only flexcan is converted.

Patch 1 is an independent at91_can fix. Patch 2 moves skb_queue and napi
into struct can_rx_offload_queue, with no functional change. Patch 3
adds support for more than one source, and patch 4 uses it in flexcan.

Tested on S32G274A-RDB2 (can0 <-> can1, CAN FD + classic, IRQ lines pinned
to different CPUs).

Changes since v6:

- Moved skb_queue and napi into struct can_rx_offload_queue instead of
  adding struct can_rx_offload_irq, so other drivers are not touched
  (Haibo).
- Renamed "per-IRQ context" to "source", added
  can_rx_offload_add_source() and reworked the comments (Max).
- Split the rx-offload change into two patches.
- at91_can: add Acked-by: Max Staudt <max@enpas.org>

Changes since v5:

- Replaced the per-CPU skb_irq_queue, which does not work in preemptible
  context, with a per-IRQ receive context, as suggested by Marc Kleine-Budde.
- Added patch 3 with the flexcan conversion. The bus off and error lines get
  their own context too, not only the mailbox lines.
- Moved the at91_can fix to its own patch.
- Dropped the gs_usb can_rx_offload_add_manual() return value check, the
  NULL pointer dereference it guarded against went away with the per-CPU
  allocation.
- Dropped Haibo's Reviewed-by from the rx-offload patch, since it was
  rewritten.
- Added Assisted-by tags.

Changes since v4:
- rx-offload: expand the comment above the for_each_possible_cpu() loop
  in can_rx_offload_threaded_irq_finish() to add the single-producer
  assumption (IRQ requested with IRQF_ONESHOT / handler non-reentrant).
  Suggested by Haibo Chen.
- rx-offload: add Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Changes since v3:

- In gs_usb driver, check the can_rx_offload_add_manual() return value,
  the same NULL-deref the per-CPU change exposes.

Changes since v2:

- at91_can: also add can_rx_offload_del() on the register_candev() error
  path and check the can_rx_offload_add_timestamp() return value.

Changes since v1:

- The enqueue helpers used this_cpu_ptr() without disabling preemption.
  All four enqueue helpers now use get_cpu_ptr()/put_cpu_ptr().
- Guard can_rx_offload_del() against skb_irq_queue == NULL.
- Fix 'at91_can' memory leak by adding missing 'can_rx_offload_del'.

Ciprian Marian Costea (4):
  can: at91_can: release the rx-offload on teardown
  can: rx-offload: move skb_queue and napi into struct
    can_rx_offload_queue
  can: rx-offload: allow more than one receive source
  can: flexcan: use one rx-offload source per IRQ line

 drivers/net/can/at91_can.c             |  12 +-
 drivers/net/can/dev/rx-offload.c       | 185 +++++++++++++++++++------
 drivers/net/can/flexcan/flexcan-core.c |  86 +++++++++---
 drivers/net/can/flexcan/flexcan.h      |   3 +
 include/linux/can/rx-offload.h         |  27 +++-
 5 files changed, 252 insertions(+), 61 deletions(-)

-- 
2.43.0

