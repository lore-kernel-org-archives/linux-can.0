Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBA4377AA9;
	Fri, 25 Sep 2026 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347566; cv=fail; b=OSp0Rp9lXONpzrvvI8EoItg/i4/aU1j6hFeW2iiojhXemTMRtbnE8/yms08grH4fEvAAx1bewLLWPU0GPvCAldaNuYMxByPRzoqRISN/BgRhFtaFS42s2i0SPpH3iUDWKR3XzCJEKoGwuZWbJTluivMdnmJ6q5eKEQmA0/dP6GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347566; c=relaxed/simple;
	bh=7oP4NQxZQYwsSIVVFkxaqkQ66MW7mbqqnHNJc2IGLrg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OCaBjHxk5hoTEYsrJQMHd9MnXG8qfblrwxAxqtM/IDu/ntAZveWoYEAZ6fH4LFcW/u/tJzi7Ckj+JFe1wIzs+TIRE+UXlu8AWSRaLeV3018AFJ0lhRsUGHpBMQ5q49Dpxgaj/OgukSatWXj6pu5Uw4NkRrVzD2d8z8u6NedBSF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uKraH9br; arc=fail smtp.client-ip=52.101.69.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uKraH9br"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIZkMwHRCAylQ/doY2HaBF6do3oCHPAdyRNw7uhn0gXHtLn/B9SPjchxsYObsdGIph9Um270IPptEGmRM8RLc4OsA4dT0CQE38bnhrkj3xRLj/BpppnzsLbfD5p+TIsCOHnd/Rux8FcbTC10gHlkK7KV8pE2cylrlNyEETQru8mTla4KUTdWp7QNWGtz6Op5XakGm1daTbA989FIxXeVFzqWN046oAnb3Wwfi5DCooqxxpNb7lS5Z1kiYi21d0e2pAcEe8G7SqPYANewFhwWVy4afx0NEAJVBGWyfcA7SghHcBvmEPkh0g7HuMnxf3BfQofc9KhpuhP2JAyobwXeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhpVTrDr2g6eMmoCiBaOsemavw3N/0BNszyS+LBl82o=;
 b=HAwpn374snQbNrbgcfUAdYaRbx+KrzNhFmg6O2/6j/CuAssU9J96WG2Ae1/3SUW3JhzopcIlJ9GvKyhXFXGsDH/6ih3/V65qsPo4sDn/ZhSbCZq7as9wqOB0UbIf4YRg4nwexCL0AaL3QcTFtAvmkRHO3LrcDTNMtHq8R82rENYdP1/MzU0wBpzAN6meda4PEXFnFXz42IHJUOolZESGAW2+O6jiAQ4u2PEVZ5f+oTc/OMwo9D9DPbv3XcUYgHTuYy7zou0rvjgSyhfEy0ztGDJmpiRwo+3B+5ACVpnl0pdkXfaNFysqCJ1W6dOMd2yc4nN9O10j144ShkU0FtFOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhpVTrDr2g6eMmoCiBaOsemavw3N/0BNszyS+LBl82o=;
 b=uKraH9brIuRifwygcDMU25VdxgZ8ljWdF1Wu7ZqWPIOtcmIchUXzDVCCpve/WUhEJbMoEwF6YgUZKfL1Jbwv9SQ3SV1Q/fIpZackSLq2II+POivwyPz6FzOH2VJyhf+oI4pt5RGeAwnWFJVFVOfIwXvzjYoKCng8tMfg6V7Tv2FO4NnzRY5RV36JmscXVHHLbtA1+HyZpSqa4r6/42xCFBujbEWK6KXeq9MUCsC/XsN8kc3zTpUW5SN6ND3RB0dGw+Mx17FjuvGixIalcj125KrOwoBezZDybTPEo7yMnPOiG/zpca2TH0RQrltaTrHbv4U3MitX9W6yQ4zUu7sF9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by BR0PR04MB337759.eurprd04.prod.outlook.com (2603:10a6:2c8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:46:01 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:46:01 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Max Staudt <max@enpas.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Ming Yu <tmyu0@nuvoton.com>
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	imx@lists.linux.dev,
	Haibo Chen <haibo.chen@nxp.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v6 0/3] can: rx-offload: add a per-IRQ receive context
Date: Fri, 25 Sep 2026 16:45:55 +0200
Message-ID: <20260925144558.2909639-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::9) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|BR0PR04MB337759:EE_
X-MS-Office365-Filtering-Correlation-Id: fa479e71-8de2-4f67-6a1d-08df1b13b785
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|921020|11063799006|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	wiu1x8HCp9pTcf4DRB+Z8rqvQaMdfdIlkOfflEXYZalZDPli/Q9s3ekJQJsWpSea/yOrFMZcEPBL3kXxmzq71jOLNA9y4vy4HuBSqOXSI9VEMW0Vqnvx+8UBiFEOmGFwIyAz993CT/ZDpJ3Rc2UWz+csL8V83P+wwzx1XmKKyeNP3cc5xYmIj8bu09k17Q+IZWchYQOREsoqH9Zih2fbsKBa0CyAAuxtyNJ7W32LbJ/J8/XN1N+LDNBJgsxSlzfW5O98Y+ZZTpuuRT6HbBBc4xCzbTb/u6tbPRAK2WGUgQ7jDfceurktQnLdSlX5SBDeWHKRDCuWLLq7YjE91wjnzUi7GSDn3Mg4keghi6+snyiyfeMDXH3ZAXC9MiCp3lWhtwiOU1+LTcgnadA3rkUI6UDduUtBuRX9Q7JVpvRJcRLHpg3ZXz34IR5Xf53OslB+tdcVL8nVnrqcpkwKrbk9uJgmIEGOxH01XQ887OHmB7/n3+rGbmVE9OtymrINOZz1bYLjKSDeLWeXo7lKXSnSncmdQWbazEhLkVWX0txxtvKKFg0SDXC2cMccBh4YKTtTbxyEiAUIhSfoiFNzXPrtCmvcpsjVkwrNSKGrwRqeDBqgNd6e5fKP8UdKN1nT5Bw3cWOAzqQqtv3ez75mY9ZFFOb0iZ0hY0B6ekZdZSITQ140K/D7OUeH5GsLgCzksuOVV3LSmz/DCfcG9eZ22DgPhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(921020)(11063799006)(6133799003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFBoMEZwVlN2aEdwVGRucytDREgyUEdFalNPaUVtMmNIdC9HU3V3bUxpOTIv?=
 =?utf-8?B?UzRHN0o5VEk2MkNUdXlMU1VLNklYeGQwNWE5dU4vcGJRQzJEZFgrKytVdlZn?=
 =?utf-8?B?UEZUZVdJcGFMN01jbGlGcUhXYk0wMWhtRWxtc3l2TUFKZDlXcVVMR0hNMWFD?=
 =?utf-8?B?VXhVclJLRklRY1VnQVo5Uit5Vll0VS9BTGN0dFFoM1RLUzVYUXFrR2w0VE1s?=
 =?utf-8?B?Y09keURUQ0g2VjhmZU1XeExsMUJPYWU3M3hueDhGamJBMlVNTnlsZnh2emp2?=
 =?utf-8?B?bkhnTEZkT2tRVmd0MzBCSTNxb1NjTXU3blFtNFNNMHRlQkNUWXBieUxjVkd2?=
 =?utf-8?B?UkZGZkhmUjJWNnhqTzBOMjlzQ3NwQTkxdVpzWDFndlMzMHJ0Zjc0a2dBNDVh?=
 =?utf-8?B?L2syMWZMYVFNVXkvU2RBZk5MUjBpdlgwVUZ0SjA2M1BKbnBMV3c1ZHlrOXFL?=
 =?utf-8?B?VVI3V05VMVEzZzB6QkZKSFJuVVpvZFh2VkVtL1JlckhFV0lHbjhGeDlYZ05T?=
 =?utf-8?B?ejhzOERneDh0UHMvUEhhK2NDb05nUks4anpYbW5IeXdkSXYyYWFnZEFYSjdG?=
 =?utf-8?B?RC9IYi94cFo3RkNTb0VrWjJWdy9hN05MazBVTUgwYmVSakNkcTJEeG40dHA1?=
 =?utf-8?B?SlFRb1lTSXM3QVVReWdxRDhTUHI0RiswQi9wZHEwc2c3TG1nMVFQZTg5YXlG?=
 =?utf-8?B?Q09ZQTkyQmtnWDMrYWFLRWNBcHF2MGZ5R05tWGxnaGF3a01MQXBydHg3Wjl4?=
 =?utf-8?B?Z0NOVHlZeTVTbGcvTXJqV2htY0pjRzkvWjBUTTVUSldtMzAyQy9ZaHJJUUZM?=
 =?utf-8?B?U3M5SS9LWlhDRjErcFFRSkdzaEZJQllIUHBidVV1c1d0UWR2UnBIVDZrMVZO?=
 =?utf-8?B?eGZZcm56dmM1L2t1bWZENEYvbkJsUWtxODVKY0hPeW5WdU9xQ1pqd0F0ZWFR?=
 =?utf-8?B?aEJtVW15N3Jsb2lhY2hJcjNKRlZuZXFKUmtwTDBaQm1xZTc0R2I0NGF3b1gy?=
 =?utf-8?B?cjhsa2lyaGlnTS9ML1l6YXl2eTNoc2tWa2lpVnpjTG84RDk2RGZFSklXem9R?=
 =?utf-8?B?eGo1ZGtha1ptU01EZnpMUlpPOEpVa0xybTFUcnc4ZTJRaGZxcVhZS3pmcnJB?=
 =?utf-8?B?VmhZcnlvNGZuYnBJUVZvSjUyU2Q0RUVTZHdEMTJDMlEyVWhUUndZY09rYmI2?=
 =?utf-8?B?S1FjNUhFQjF5VGJzaEdJY1hMWndDNGNzcmp5QmY5SVlpQ0FVRkVjSEg0L2g0?=
 =?utf-8?B?UVl5ZHo4YWFWRlo2NXVWU3l2LzRDZUpkTjYvbTBvYjdOeElZTHBRaVpFQnp6?=
 =?utf-8?B?dmtoVllUWEZ3bDljclp3N0ZlVC80d3prSCt4YUZUWGwreWh3Wjg0NnRiWTNS?=
 =?utf-8?B?MFo1MHRXT0N3c3gwdlNoR2UvY2p3VHp4MUZMUGtwRWJKS2VNNzRjZ25sVENq?=
 =?utf-8?B?R1B2d1lkMCtZZWx0K3BoQnNHcnYzQ0JKZ2ZhcDlZcjBTTU1oN0xrMDlZd0l2?=
 =?utf-8?B?bk5QeSsvMm5OOUpKcmEyc294Q1NjMG56SVFjTHJPNHE0ckFjQlZ4dy9qNEZp?=
 =?utf-8?B?bGNIL3lEbE91YVFtN3lISndaeWR4TGdMNmZSTEVvamxSSzhLSTVaUzdmRVpy?=
 =?utf-8?B?WTVKVHNBcHVtOHdBMkxyYkwzWXVvVGdIQjZrSnNrMDN1Q0dqNUQ0VWlOVzNj?=
 =?utf-8?B?RS9EU3BWZm1uVWlMOENVaDFLdWRtWXM3Tnp5Q3NocXFYeGU0Z1V0YmN4dnlD?=
 =?utf-8?B?SFlXZjV4dFdlTWFTTllMUUNNcFR1Z215dmtQVWJqZmNUZmxyNVlzRDRwV1pw?=
 =?utf-8?B?azNYdElGNlpFWG9qVTRVL1NFZkhFeVU0VVBQN0R3bmFpUGVGRndhTHlLSEVK?=
 =?utf-8?B?Vy9jK2pRZHFqZzZLWS96RUZqMThUTnVVL0xjZGdFREZmMTVUUHhBdmxzelBR?=
 =?utf-8?B?d2dqNnpVQkpvRHJvMGZuOTVlc2VHOUdYRkUxVWNnWUV2ODlWd3hGa3lqV2dh?=
 =?utf-8?B?R3RhM2tadUhlTVNVWXkzZUdEWnA2cEE1bUhJcEE1aUlFVEVEalJ0VEwyckU1?=
 =?utf-8?B?SEJwVmE2enlFbHozdWU1TG16UkFGbzBhYlZVNEdXZFRxTEQ1KzVaYmFGNHpF?=
 =?utf-8?B?cUtLS092cmxnbWRONFV1WUFyZENzellLbk1mWXlDZW5Mc3FIb2pJeHprYzBN?=
 =?utf-8?B?NGJ4RG9qMGJaSjhXUVFtL1FyVkordVFBZU52VXJUOTluc0poWm11Ni9ZaG5R?=
 =?utf-8?B?ejlsTTNoTXR3SHhXdkhmOGpod2RObll3VmZEREJFaDNCb1dMaHJrL1JTd1JQ?=
 =?utf-8?B?NGsyMEJ1eXJURDdHTnhXbFU5cW9Zdk9ISE9yajdRNDc2STVmQ2c5Y1E2eTVB?=
 =?utf-8?Q?12VIOGdmAbSFRZNs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa479e71-8de2-4f67-6a1d-08df1b13b785
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:46:01.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHEbTueyahMkB533D55FQIh+xXmxeGl1Lyzb0RGL6R1JrHfoqgORWGGvaw0dLL2tBR/I36XusxRjcOeTYTnohTguNFDhUhE1rwDyUKL1NFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB337759

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

The rx-offload IRQ handler fills skb_irq_queue without a lock and the
finish helpers splice it into skb_queue under skb_queue.lock. This only
works with a single producer. flexcan requests the same handler on every
IRQ line: the mailbox line, the bus off and error lines
(FLEXCAN_QUIRK_NR_IRQ_3) and a second mailbox line
(FLEXCAN_QUIRK_SECONDARY_MB_IRQ). On NXP S32G2 all four are used, so the
handlers can run at the same time on different CPUs and corrupt the queue.

As Marc suggested, each IRQ line now gets its own receive context, similar
to NAPI. struct can_rx_offload_irq holds skb_irq_queue, skb_queue_len_max
and the mailbox range, skb_queue and napi stay in struct can_rx_offload.
With a single context the finish helpers still use
skb_queue_splice_tail_init(), with more than one the skbs are sorted into
skb_queue.

Patch 1 is an at91_can fix, independent of the rest. Patch 2 adds the
per-IRQ context and converts all rx-offload users. Patch 3 gives each
flexcan IRQ line its own context.

All lines still read the whole mailbox range, so two of them can read the
same mailbox. This series does not change that, the range split is part
of the flexcan multi-IRQ patches along with the S32N79 FlexCAN support.

Testing on S32G2 is in progress, I will follow up in this thread.

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

Ciprian Marian Costea (3):
  can: at91_can: release the rx-offload on teardown
  can: rx-offload: add a per-IRQ receive context
  can: flexcan: use one rx-offload context per IRQ line

 drivers/net/can/at91_can.c                    |  28 ++-
 drivers/net/can/bxcan.c                       |  14 +-
 drivers/net/can/can327.c                      |   8 +-
 drivers/net/can/dev/rx-offload.c              | 196 ++++++++++++------
 drivers/net/can/flexcan/flexcan-core.c        | 109 ++++++++--
 drivers/net/can/flexcan/flexcan-ethtool.c     |   4 +-
 drivers/net/can/flexcan/flexcan.h             |   4 +
 drivers/net/can/m_can/m_can.c                 |   7 +-
 drivers/net/can/m_can/m_can.h                 |   1 +
 .../net/can/rockchip/rockchip_canfd-core.c    |   9 +-
 drivers/net/can/rockchip/rockchip_canfd-rx.c  |   2 +-
 drivers/net/can/rockchip/rockchip_canfd-tx.c  |   2 +-
 drivers/net/can/rockchip/rockchip_canfd.h     |   1 +
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    |  13 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c  |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   1 +
 drivers/net/can/ti_hecc.c                     |  18 +-
 drivers/net/can/usb/gs_usb.c                  |  23 +-
 drivers/net/can/usb/nct6694_canfd.c           |  20 +-
 include/linux/can/rx-offload.h                |  48 ++++-
 21 files changed, 349 insertions(+), 163 deletions(-)

-- 
2.43.0

