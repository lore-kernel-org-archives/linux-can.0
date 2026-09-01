Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA7713FEE;
	Tue,  1 Sep 2026 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251975; cv=fail; b=EfZF0WKXWVuGguERrXjORFeFiBmYZPQgwuQh3lArJ4ueFDoOt3WoNKyOmuFUKUvPZHh2RLhHnlxz4Wc2A4Qeh0AnDddfcomlxZNHAzI6u6eE4T+SJVH0fJ8k6Un9wVqaufJ2QK6/NVI1HjTIOVwuOMSXOpKiAI+f0onKXryAdIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251975; c=relaxed/simple;
	bh=I8WW6fExgz4TFPSksTWARPfRmrHzZW6Z9PBnuNdiwD4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QLAH9w4aWy+LJALZxnADK4rHhH4L6SgtzqZDFlf1WbXmF9su2+3d7ki0UXqrtrsT9UgCIGbt634fpPmxUAtMEJI8tqdXMxhq7Eap9VFkqmmcT1TC2eLmVMKjiKD+RvLmlP1dPvjOR4Iy48HzzUaJZHNWjUF7w4M+u3VysKODaOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xqHHw8sS; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xqHHw8sS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkMyh46FthJUMa1mEuZqxa+ZWHm1AHaIkqu9XRnBsJlhoqIpH2r/8AouQgpv0dP9X3kmIrIqwDXhx9oPegTklKnnr/x5mFAyXPxqEGhgWFV1VaWw/9/PE8kTEFG+J0/kP51qlACOIVJfbSJJFLiBucBwirn7blTks/nR9QRvZ1HSG3ArDESpH8RSLHW4ohZo6Wmvel3vxL17LYR5b424Ns7uVOoiXuFtqZ8y0Jjb8FwcZQlZ25CVXHyQjgt/TACbskZIXsbRpbVOezjt2yT9SGVOposJHOW3wQn6dZ6yA9GHQbXUTmDaKNJZclJVeL+cyoisH0POvXeiF81Uceml1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuUEW51uzRbtSbmP8EaSsaMoH9kQoJut/ROGTshIgm0=;
 b=P7WZxZDlvwtnEzZ0kffk9Y+rbIAWOnablWTMBxFcuENkHAm0Dv1c5Lh1uia6QjbUCESGhSnI4ldXVGvxblZtIczaryf3VytwBElxqWG83VJDVbp/pwJoiy/X0qFSMzI63USh/0wSB1tcRCeHVFUpy+5+Kxg/9pvs/0DEttZwi+O1KYkWoCxqGUWH/bPxStWSSm32S5F4PEUVGjJCyLwmcnhFriRszpDeWohxI6YdVJylQZjJUjcmD9KP+VEE5Vm1MClRYwnxaQUdk+DTjfV2m2WbIi0hoYijXEqrvz+D/ZOXRoLkDGZsCP6pXtzEV/gegkSASY8Yrvr5Q1KbLmIZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuUEW51uzRbtSbmP8EaSsaMoH9kQoJut/ROGTshIgm0=;
 b=xqHHw8sSYBGhgcpEaS/K/n9OpdXG9eJzyl0T/TH/rT0nO6WyVYLk3GYCOvGDIl7mjbLUNvH6hHB8YBdCMEIilQSJi99xBa+/GEDOTocFuXsT0qbl2QbUU6l/YjzMD4ljRTz2x+/gOld+ILMemJ3dy0ZUxdZv8CyeN8FYPVXqSyZhzVfxvOc1JvtZoZXQSX4g6CXuYVo0MjhTSxzvbJVOyPF9HH8yNaY9HB3MRmeZVNrySOC/ByFRxY3WTUIzBzaDy0OqYSXKC3vrIDnEPpiU3k1j+3oEgm6u/1UzczDEDLOqd83aY99kG+0FS/BNa2CZDUa4k5vfRYJFzAQYCgFQVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AS8PR04MB9077.eurprd04.prod.outlook.com (2603:10a6:20b:444::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:39:30 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:39:30 +0000
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
Subject: [PATCH v2 0/2] can: rx-offload: make skb_irq_queue per-CPU
Date: Tue,  1 Sep 2026 10:39:25 +0200
Message-ID: <20260901083927.316283-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0322.eurprd06.prod.outlook.com
 (2603:10a6:20b:45b::6) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 2088e230-f3a3-4a2c-73ac-08df080489fe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|19092799006|376014|1800799024|23010399003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	k0nwa3D91iv3CScN5Vd8Icoh0ABDVnc0zrBfwmqWCSvcHzpIyPaabkCQ5wmKzCCAR2cD6PJRt5QuYbe/8HtFe1hvNefrT1htEst0iQYI3bnuknPUa22A6CJJNy6CTuVKws2aHHyCtnAi0e83LyW+0zebvtvVtgZajHkENV8Z1ag3LNJBZYTb2Z+f5cejs+xKk97fSveo8Cm8Wg9NpHk57Sl2vsWy4TcKDiJU989HlVKUCoIQlT0Q1urd7x2SHeCDR8zZLtFOOCXS60hYNNO8pBv9lGARgwg9NOkif9vVNlVlmYH+H44eyAAComK0VlpzzJz+tYcjpE4oYSDbV6jiviUAMcDdxLQc7YKXIy51Up35AkMKYRPYDPQrm2iRTwmUgTO2lTgWKTuEqmlihCBuCbkBu888iJf86IuDqnq6hEM1stoUNeR202kw2H56wuC6k5AYrbNokiiBeYqjltcW1be2gkHlNmVKIb5iUx/HsJuKQn0F2KPQBRoWBOE6Fp+aD/hyjDO6kd/U5VGZS65tvw/gzeuiroplS2VJGABriZWorn11cL72PICUGTgwwROq64oHP1KJbuoSBvH6MRWBysS9wrzs0v5oH0oIN56dt4X6+fM0C98xetl4/RC0CccV/EyTS1FcgUHCvmGQ9sGPtT/76ClFxheLG9ANccjn0hQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(376014)(1800799024)(23010399003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WU5WSXZRZnowcUF2RzhvWFpSSHc4TEN6cVpvdk5Pc2NKRHNLbUQzRU9nZG9B?=
 =?utf-8?B?OGQxRVRVTVpZTFVoVm1nQ3JhVi9oVlVzTXlWUzE2N294b3VOOWVRb1lneUZq?=
 =?utf-8?B?NkJsK1krUUZQYlBXNXIxSWx3THVjZHhZMWVybDRhelpnNHduU04xNkg3VnR1?=
 =?utf-8?B?alY5a3BMWkF0MDhYNHI2V1Q3dHcrMnlwbzRzK0tQUHNVZU9Ma0RpUUw5NkdK?=
 =?utf-8?B?dEs2RDNwem1tUUh3MERJalJOWWhoRGhJWVU0eTZXdjNsenVGNkVSTTZISUkz?=
 =?utf-8?B?OUJYeWIvTlFvNXhrYjVKbUtyT3J0am03VUVSYk1Pemp1eXlRc3VjUnNGODM2?=
 =?utf-8?B?QlRiNEo5U3lZWDcxc3J0a0VsdldvcEM4U1VXcG84OHhlQ1I0dE1FODlESkdi?=
 =?utf-8?B?dTdmc0NhcE1jZjBSVzZxWENIMWUvckFqdmZVWjZ4bklka1ovRmRUMkg5WjlI?=
 =?utf-8?B?V01yeDB5aTE4TFZDRmNEaDM2MUduSHF2S3phYUExcTk5SzBkYlVWc0drdTh4?=
 =?utf-8?B?NHc1WG1iczJZTWVGdzdUWE4vanhRMW9oUGhBQnhIcEJrdVRNTERpYzZHK3lU?=
 =?utf-8?B?L0VQWEpwMGVaL1ZxZFlJYk9MbU9uVlhua1NIbmNpRDV1Z2lLWVozbjVDR3Fv?=
 =?utf-8?B?QlYrZVpQSHhKWjR3VmY1WkcwV04ySUVuMHZXK1RhTCs0QzFoVEZOS1VDRzVq?=
 =?utf-8?B?OG1ubllUS0RaS1ZkVnNzWkRkdzMyS2FoOUtaVWVNaWV4QTZ3S1Vxa3J4cXNP?=
 =?utf-8?B?N2pqSUEzemkvYTg2ajlNSm5oV3dTUVoxekMzNE1uWC9mS3E2aEczUy83b1Nx?=
 =?utf-8?B?NGZkbjA5b2VuR2Yrendvd0xOTnBObHlpSXg2bm1aRkdTS1I3cnYvV1NBeW45?=
 =?utf-8?B?Qk1rYnRMYXV5aTZwcmJkTE93Q2s1Wkt0cWJxNmRkb09XTHd5cjZvZlNnaEox?=
 =?utf-8?B?Z0swS254bzl6VFRNWFFqY2FlQ0ZGeFFVbjFhMWZzMnM2OTlaL3dwREtaY3FV?=
 =?utf-8?B?eHVFSjZORDg2S1hkS0kwQkJJM3RKY1Y0T0ljbDJxTTRPRzYvbDBlUTlJK1NT?=
 =?utf-8?B?QmRLVlZaVnZ0WVN2QVdabG9PampUWVZSNitEa1ZSWTRNdFZsUjF4clNyNjlT?=
 =?utf-8?B?Ky9OYTY4VjhTZEtZdDBHQXhwWW5DN3RUa3UrWmNxSHFLYzRWR3pzcDYxOElR?=
 =?utf-8?B?cEJhTlNvdWdJZlJnemo0MVRtRDc3bkpoSTlLbDlwcUR5R1NOV1BzUkZjWmJs?=
 =?utf-8?B?eTFBVEkwczUwWnBkd3E3ajZyVUgzS3VtRzFBNkNIYW9XaVhlNGViVDNZb3Nm?=
 =?utf-8?B?RnBJRlhrUXlsNzltclcyMG5hem9pbGJ0M0wyaVhvZENhdGdablZTUzJSdTc1?=
 =?utf-8?B?YzdUVWpvL3BwZXhjMEVCQTdZT3J4Z3M1b1lRTFJVQURQdjZSSVlBU3E4eVVE?=
 =?utf-8?B?bGw3RUVoZWc4VE9KMEt4VE5RdkFabnB5Y1lwOTNvMEsxcTh3YzA4dmdlMCtV?=
 =?utf-8?B?M2UzMGFnOHdjODBVaVVPdXpTNy9hN1V4VXlqUHV4RERDNnZWWjFjL3pNaThz?=
 =?utf-8?B?d1Z2WlJMSFozd3dTSE9JQVg5UW9QM1FoU3FUVk1CTk1DOThZRDV6RHhNK3JV?=
 =?utf-8?B?M2dWZllKNDY5SC9zR3NlYU9QVlBYRzdoUWpmeFFmWWVWd0t2VzF4elBNU1h6?=
 =?utf-8?B?RjNaLzR0dE9aTVlORmI3T0J5OUpGZmx3SW9jb3kyY2c0dVJoWkZtZTJZMzBP?=
 =?utf-8?B?L1dkUkREc204Ykg0elFFSEc1NEtteklxZWZOY2xBTCtHNG51ZWtuMjFSYVN3?=
 =?utf-8?B?bFJrc1FWWll0ODAya21pc1lsWjc0eW9mU3djVWc5WE1jY1VYMXZQYWhQeGlQ?=
 =?utf-8?B?Ynk1VDllSUVxUVVkSnEycU9ZZTRhRjROdUNzdnliM0VQeHJTaFh5Q2dOL3BQ?=
 =?utf-8?B?S3VJd2tVTXRodWNaZVJMRlNmRFdMSmhsZWZqbmtMRjlqZVNoY3QzbUpBOWpt?=
 =?utf-8?B?NmVjMmY2cGw0MVl5NGFqTXdRZFNSTXg0dGNuWEJVRmFLM0dZU0xUSkFTdUlB?=
 =?utf-8?B?bFhQTU1BcEVyTUVZaWY3YlBtZXVWbTNvMm9WVFhEZmd4TkRsVW1GK3FBd2t0?=
 =?utf-8?B?RUJ5UkUvdFVlM09HLzFDM2JzK2RHaXVDeDQvOWI5TUJURHMxTDNPa0x5UU40?=
 =?utf-8?B?TUpLY29OWlJLcDAzcE8wWDJDNk1GeVlnWGlyelhsTWV4Sk52MXNNbXp3U3Fy?=
 =?utf-8?B?N0tZZXF6bjA3VHcrTE0wUFR5VkF4S0lUaTF3QUdLVjhzdUd0OGJSMi92c0xR?=
 =?utf-8?B?bnJ0MS9xQUt0L0RWU0Z2Qi8rMWxmblB0RXVFOTRpZld6RTdTV0xLTUR0dk81?=
 =?utf-8?Q?vdS2d44J0LyKiwIA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2088e230-f3a3-4a2c-73ac-08df080489fe
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:39:30.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cBz0msmX0IoGfeUT2B0PqDwNmyv6ydzqUa/NipEKLwp8onf7l9LM0/OXHYpXKraTNuCncwj06/m1Fweq2jx+3d7fo63k44/TvUySkS0PsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9077

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can_rx_offload keeps a lockless irq_queue that the IRQ handlers fill and
that is later spliced under skb_queue.lock into the NAPI-facing skb_queue.
This works as long as a single context fills the irq_queue. flexcan with
FLEXCAN_QUIRK_SECONDARY_MB_IRQ and mcf5441x use two mailbox IRQ lines. When
those are affined to different CPUs the two handlers can enqueue into the
same list at the same time and corrupt it.

This series:
  1. Makes the irq_queue per-CPU so the handlers no longer share a list.
  2. Adds the can_rx_offload_del() that at91_can was missing; without it
the per-CPU allocation is leaked on unbind.

Changes since v1:

- The enqueue helpers used this_cpu_ptr() without disabling preemption.
  All four enqueue helpers now use get_cpu_ptr()/put_cpu_ptr().
- Guard can_rx_offload_del() against skb_irq_queue == NULL.
- Fix 'at91_can' memory leak by adding missing 'can_rx_offload_del'.

Ciprian Marian Costea (2):
  can: rx-offload: make skb_irq_queue per-CPU
  can: at91_can: add missing can_rx_offload_del() in at91_can_remove()

 drivers/net/can/at91_can.c       |  2 +
 drivers/net/can/dev/rx-offload.c | 83 ++++++++++++++++++++++++++------
 include/linux/can/rx-offload.h   |  2 +-
 3 files changed, 72 insertions(+), 15 deletions(-)

-- 
2.43.0

