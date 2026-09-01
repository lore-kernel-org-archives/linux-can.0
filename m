Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013023.outbound.protection.outlook.com [52.101.83.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5F47AF5F;
	Tue,  1 Sep 2026 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259275; cv=fail; b=n52bFPWZWra76XbHWV52NUSs/shMp+YdlNrxEej56ganVF+6XJXmLimo2KdvX6iwf+WRuA0hDr4VgE9pWs7P31KSGOCPeeo7dY0Oygn3bSW/mn+Jh/IzZmiIwlJciSlLopumiKppBJ6jlDBRAc7G0sT4mds50dptnqWFGMidKc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259275; c=relaxed/simple;
	bh=4C7wUr8D1qgJ7fbVB49cLdCe0x7o1fQ+PrYV1mmhhlk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fkE86loTjnaJ9+Wquoy3/9w4Q93hAg2KqxqdFJ+q8PxoN+/D9eMnMre4W0O6JJjTHcYHUqfqdqh0l74ZoUvN1UjfJYGpTRuhnkfqx2kaxjg+R9JM0wz6fOro1Ri92nctt73NkRwA+K6HsR9DIWw2BkrVcZYOYTksgNNWEIdmqoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AsCkSPgv; arc=fail smtp.client-ip=52.101.83.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AsCkSPgv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWzXBRzke9ay+/vtsXTnDITGw81KqpFSVHWzYyf7XD+PRA0MMJtDlO8Pjq38X8bwYTPUKiBJeVaNFRWQrwsAFZ5LIVgLCWP1FS3PRAMOQwCLTuZs4Sya1sNHlBRyoWL7cphutRKe5vfCDc3gR5QZXmjtffpObkMM5APhC9wdFfR7/U6luP6TxKzC9DMBMW52T/aEBWndJj/jlGhzJ8qalFuuc7egFsuz/GVgFjCflK+Y811NDEeZYOHKiXjf5Ngkc5sq+4kIFWuavnoy5+TlMNqopv95gz/Fr6CSSe0k3lWH/z3Fj752qkFXoRXrI9Z6FPXwd9L+fKXMWbDM3/vK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHTFxBi+cQfTi1HvlHTr8rxuF7Bi/uOcd1Kp6tANybs=;
 b=TGNfnpu3JiyyS4YylM4/T06RPkBvc8sUH7rdrYAK4Nh5kT64iR6vKrkKC37KkVU6d410PqeVzBtiDxtkzl/Nbt8pJWyeW0ejRQjn6lbIz7PQTeIGmvDGaTUKZcFTg7Z6D3hhYwb5Nb9pEQ/kzliINxLQaM9HWOTyOih2FGmTh9Z2Joydk/n/tgzWyxwwf7Br/URVwOOXLtP1EDrcRMSF3xqmeUGU5Grumz50yurQZu7Dh1lB469qMZwnBeHZWC2I5u6KPYRQhm2Mea+xYVWuwhT5jYEvcuOnPyO1ho82V/xIfr/04IzLSd+HN9JAF7W1dwPyL+hRT7LfbUcwHe8u9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHTFxBi+cQfTi1HvlHTr8rxuF7Bi/uOcd1Kp6tANybs=;
 b=AsCkSPgvZrQfp4vvkXgGCv8vHTaUiaFYhiTQzmI+1awdlNfwDttTj5BVcY9DiLvEgGh+s6Qf7Nt6NLwKg5HWDH81wJDE+lmvunnXONmrXbPBveYSrY5uG5eXOKNJejOko80gMMOVemOAlxjP5j/0P56HSwIw4MGmPLWuUDRL8qEpHrc2okTwvFYmZGNNNY3R5JfpjMaYCf1V1CWpTgfOf6ESp0co7HWTi2TF3NEUHo/0LKqLCyaBGexE6U1/MOMdr3xlBibk133Nj0HIZum88TGdJyz4xIMAVEnDcJmNnDIzXNrKtKO7RpK9/vy8TAkfw36MSdaBQ6BUanN4hHTt+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by GV4PR04MB11942.eurprd04.prod.outlook.com (2603:10a6:150:2e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 10:41:07 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 10:41:06 +0000
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
Subject: [PATCH v3 0/2] can: rx-offload: make skb_irq_queue per-CPU
Date: Tue,  1 Sep 2026 12:41:01 +0200
Message-ID: <20260901104103.458619-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P309CA0025.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::10) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 5b59a541-285f-4dbd-914d-08df08158758
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|7416014|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	FmBgXD3DmLlDl4tOJJ3fg3ns4IHj1gJDcZRnPvIRpldOqxz2vtPkinyY4IEyfqBM2TUbL7hfNbi+N9T9zswRLI2J3wrTNamkKvC0URjQalXWqD5wtAqkj0ewV6LXrtCm8NoaEuhwH9tAKs8FSCYPXx/Nfv6ysghfT5tiHA3O8z359A1qqQaJYSnGg1wmHOZL8MU8z2dMq8ZhgGVfql9UmYc4IcuZxAJeTl5p+/Pe94yVaZPKxuGOQzZE7LjiVpQylFZkCYwUBFNMZFizHpccvzdq7LDLTOUyqzPWDOq6CI6Ev/zs9Q9E9J9CpxebAYU0WVYY+RVJRhUc6Uez1fCRn1ywHOqStt8U5FSTPs5kAzCJGdmR8tjH1iXjMsIM+IkLntfMHUau6QSgxhMjMjdvDtb9XfiGMGLOMEMgmNhMvbYVDALAWKb4hNQSc85hp49yyZu/1/BTHMHw8DmNlYqdUdRk+E43v6RG+qtxBbt7y/7sFdZauW+BVOU3IPqC8JkLFQZuUEJyAnrZCmtkEMudPYPrZLToTHAi0bGynrE3gWkjwFWr9sT6XO2Hw4qbl5M6ajNitTU9FaQOiL8wqsvvLNcMFkniRzodFrTltDFqy8uUoEuROKQsJ3qG73Y0SQhdnpPPG2Zbe00+GwQrVsy5Fmmcx7f+L7aiaGdyy4RFyr4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(7416014)(376014)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZS92TXJhYW1nNEdGZ081TVpnQWh5WXhyZDBGVDdEYXU3NThKY3VqblRGOVdE?=
 =?utf-8?B?aGRTZFZtc254TSsyNlZnZlloMXZlRXlIVnlqU3k1aUxVSytJaFFuRlRjMnZx?=
 =?utf-8?B?enJQZUZaSlJDMms4UEZMMW9aT2tNOTZPZVErMG13VEthQ3dCajhYNDZFQk14?=
 =?utf-8?B?enN4MWxTbWpDdjlLMS80UFJPajh4ZWwrUDdhbndEMWQ4ZXFaazVHcUN0aDM2?=
 =?utf-8?B?ekxrakpIVlpNUlhQMFZZZnZBR0VWem9WZ2ZVT3I3ajJoWHphMnVlSU5xV3FB?=
 =?utf-8?B?UC9ZR2duWTlxeEtMZW5SdWJuYUVHd1FFQ1NtSlQzOXc4Y1pUZDJqcG5JTE5G?=
 =?utf-8?B?Y2RJZi82NjdYQ0Vzd2FFdXE3ZmFpWHdkZXlNWTE3VUFoemhIZmlZZXdmdGVv?=
 =?utf-8?B?dUo1WUR0Uk05LzBGeXpLaHpzOVZaS1ozSm0wYWZ2U3gweEwzSFRHeUNiU0Nh?=
 =?utf-8?B?RWs3U3dDaHBZNHl3UHpWRXBYdDVIVThlUmw3bnFjOEJjTXdId1paWHFkN2RD?=
 =?utf-8?B?UFJuVXNtYWpwemU1eG5qTlZuNDY3VHVZQjIvRTBzUFNJc1RMUFVuQzcxNHJn?=
 =?utf-8?B?SDhkUVVNSnJzREZzcXdjcklKZExxb2NIVnJsNFNSTUg3MmtQY0F1NklieXhh?=
 =?utf-8?B?RFRNSkJ1S2pXTTRMTHVncytZWDcremRrcFl5VnBxU3QvTC92Uk9sYnlPMnpU?=
 =?utf-8?B?bWVxRHRWWXNYeHd3aG1TSGlRb2tNSXZMQi8rWlpmZG01L0FBaU50ZXg3Z1FO?=
 =?utf-8?B?QllRVDd6ZjRpNXlUMzh0QUMwU2laKzB4YnJtTlg0NEROWGxwTUh3TUltZ3Rl?=
 =?utf-8?B?a1NQWmJXMlhVZytEdk1MNkVvMzZiYkowM3poYlZ0ZVpyaXBvQkFqaXZsZGk1?=
 =?utf-8?B?dkl0b0FKUUNaUHl5ZncvdFBuU2JsUUQxUWZOeEJOTm1FNWt1NSsyZ3lHMzVB?=
 =?utf-8?B?by91N090aTRIcG1haE5pYkg0dUpkK2JieHZXZzZTZlR2VWF5Zm53VURyNGpM?=
 =?utf-8?B?WDI4R2xhMFQ5N0F4OTJmeUhXME4wbStpdVFVVjZEVmFJazJHTGpZcmZlSVpP?=
 =?utf-8?B?dkMzOTNnQ1VoSlI5NitHckN5ZHV2NVdxSzRUdmw5SEVLL01KeVdKVnR4Ylp5?=
 =?utf-8?B?NVBrV3k1aUw5TngxVHBpVDJkY0l6TUZtazZCQUpQNjlFWDlhM2lIWFNQaGlt?=
 =?utf-8?B?UFFtblViUzgyNjRhSUJLcEJTOWp3ZHZPNTFJb0xNYmFsRW9kN09SKzJ6cFBP?=
 =?utf-8?B?MnQwUXN0Y1pmSE9JQlRGV0N0eWhyYXlDT0g5Q1NqRW8xQVFoaldhUXVLN3Q1?=
 =?utf-8?B?dVhLaWFGV0hqZ09jbGtwR0FTM3JlbStUR25nYm52bXFQQW1RQjNyYklSajUw?=
 =?utf-8?B?Y3VrdkZscTdFcHBVaTU0WUJrRHdZL1hUM0FZN2xvOTBLekdMU1IyMWRtUkZq?=
 =?utf-8?B?MWdnMTgyZFRnTElDbG1NS0pkcWpzdTBrQnhXNFBJWWxpalVucC9CNWUrK2Rn?=
 =?utf-8?B?R3hEcm5SaEZxaURoSTR3ME9ndkF0OWlFNDZzaHlxKytkdEZvendDUXpvYndV?=
 =?utf-8?B?MkMyUDZpVlR6OURBV1RvdTZ4akVZS3BDU0NnRC9FWjVENWl5dHMwTzRhTHFD?=
 =?utf-8?B?Vm83blBtaS9kVzI3L3VlbzBod1hhTzUyenNBSGVNTCtuWHFMbnRnNXo2KzVW?=
 =?utf-8?B?R0NWZUw3Vks5SitReTkyeHJLNVRqL1ZTS2lDdVNneE4xSUI1dyt2NFBDVW1x?=
 =?utf-8?B?UGhoZmRjangvb1lybnExVytHMFpyYVhsWis0d0xpY1M3ejZaaGE1Q1VyTkRP?=
 =?utf-8?B?VmtOM0QwalVubzNQMmVtU0xkcFl3MEZjT0ZkKytrRXRJYjdsTzc4dmdUODZI?=
 =?utf-8?B?QmdOUTllQU9wSXpCUFRKUm0yQzlVWjd1bWducThNRjdYd2tRUzR1WFh5UHVT?=
 =?utf-8?B?WW9OWDYwYys1L2ZzcnIyNS82YTI4MHAySzNzbGtuN1ZHRW9XQWFIT0QwQXpT?=
 =?utf-8?B?SW1ISHp3VVI4UVFRZlg2RW53QlE3VnpmQ0dJalhHN0ZsSkhMS1VhWGJ5NzVJ?=
 =?utf-8?B?citpWFArNnNmT3llQ0YvbnZtS3lmbzJNRDQ1clhxekp6QW0xUVZ1ZjZFbm5t?=
 =?utf-8?B?WjZlNVljdEtxbldKbUgvTzN6SlRpYnJ6Z3dGZEVGVVRUUHZheGxNNTB2SFdw?=
 =?utf-8?B?bElvYklUTkZDVTV3SnVhd0R1NFJ2Vld6Zy9WcFA4cDRzWFdCKy9oa2RVT2g1?=
 =?utf-8?B?S0Z1Q05IbllDZmlwM1FwZEIxMWx2S1NYNkcwdFRFV2t1bU5adDgrTC9EQnVC?=
 =?utf-8?B?b056KzY0SmswMUpWWEc2QWpNUWE1UllRVThxNllVZDJrUzVIL0pMM3prUGJ4?=
 =?utf-8?Q?i/F0Xk/Yt/EoiMgM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b59a541-285f-4dbd-914d-08df08158758
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 10:41:06.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUdKv/l8+ERxRZZ0mUzZjJsP1nGiqG+zLPMOeFNW9KxspBuq7jTXa95lu/z7pn1wpBh+aphVxqzCdeHeecuwIeA3rOwB0/2jA6Sea13/Alk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11942

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can_rx_offload keeps a lockless irq_queue that the IRQ handlers fill and
that is later spliced under skb_queue.lock into the NAPI-facing skb_queue.
This works as long as a single context fills the irq_queue. flexcan with
FLEXCAN_QUIRK_SECONDARY_MB_IRQ and mcf5441x use two mailbox IRQ lines. When
those are affined to different CPUs the two handlers can enqueue into the
same list at the same time and corrupt it.

This series:
  1. Makes the irq_queue per-CPU so the handlers no longer share a list.
  2. Fixes at91_can rx-offload teardown.

Changes since v2:

- at91_can: also add can_rx_offload_del() on the register_candev() error
  path and check the can_rx_offload_add_timestamp() return value.

Changes since v1:

- The enqueue helpers used this_cpu_ptr() without disabling preemption.
  All four enqueue helpers now use get_cpu_ptr()/put_cpu_ptr().
- Guard can_rx_offload_del() against skb_irq_queue == NULL.
- Fix 'at91_can' memory leak by adding missing 'can_rx_offload_del'.

Ciprian Marian Costea (2):
  can: rx-offload: make skb_irq_queue per-CPU
  can: at91_can: fix rx-offload cleanup on unbind and probe errors

 drivers/net/can/at91_can.c       | 10 +++-
 drivers/net/can/dev/rx-offload.c | 83 ++++++++++++++++++++++++++------
 include/linux/can/rx-offload.h   |  2 +-
 3 files changed, 78 insertions(+), 17 deletions(-)

-- 
2.43.0

