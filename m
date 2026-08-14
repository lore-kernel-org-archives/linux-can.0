Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013025.outbound.protection.outlook.com [52.101.83.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13344C509;
	Fri, 14 Aug 2026 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698211; cv=fail; b=ZuehWB9EpS3bdUqeixWvysTIgD/DJQ5Pos7kd+n+AO2AHjUQCKKJes0QQpS8/CJX3q+x8p+KIpOqd4KvChWfXoPEaO5Mr+A03k4rMVT6S0IlMYVo0Aqs75TXovydEG6Qys+twnztt3tyTLBbRPFmjkMwUsr5UATbeAlCdaxU9vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698211; c=relaxed/simple;
	bh=DfXNhZ2zkjoGK0kdAkKUEnkuIstiAu+TrU03SpuGKkg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a90RI0ESMD4Fe+9bbiTlRb8N5IUXepULDsXhHhpX9PwG/sfTqgM1w2T1ariBl0rmWPYxhOt5YrgAzo2Uule06IYHXQCLktuAdiEF4A9fTryDkWCnupdQkjxDJ2HAB6imiQkB3h7t1K4UGoVNMq08Qt6nezQNnbdY1wy2ml/KOsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IvAj6iRy; arc=fail smtp.client-ip=52.101.83.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IvAj6iRy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tA5ZY1NZEj+eV17Rz+UBrZmaL4c9OP94MDRVsZhWPwfRcxFrcKlyhgfkPrNjjzPD+PeyDGh1st0LKJPuYIYiGZJ4tRVL2iifeISFohAgKCMJDJPI1IbG3WnU3lmLGWfP82qxOIPjQtf8QyXwVbdWdz8LBf0WS5dd6kKPJYko9MtZUTtK3c3fgo8YBGYyVxmUVp+dWWvBbwycZKyOUfwki4ukBEMi8sOXzCL/WGFXOTBanBH0aUwxwvQM2+m/IOr/RDYtZzmdf7ijunTOiwLT8RcfG0iqy2Q8AhE4b09K124+fjiir3+/X0wyiMDnlRTHmZ+PWAV2A821T9UJJ9SFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4neAEEIbvpAYMNKWZSF6baUKapACCKwEZLEBy6ijEA=;
 b=ZBPpSWT3+QQbTBrFpO0G9JGE+b3KFSJZftKogCI82ALWLti71dlb8iboFiP6IX8vK5P5YGKGuUbTHiMtD4NjRqEKcWrz8vdby88ZCBh20eBVkQdmE0hSiPJV+X381BhCnys0nArDnmwOVNEOJ3GDdIlZHM+G0b7z4L/Fka9TWjIjwo4UomdZhv/zwY6o0SLy88BqB94gXZ5ZlEf4jcFX4gIT6QvXyBH3v1FLRBWpQsm25+fW8GPNQFfnTKkOTCQvzqD2qwQDmgv2YA1yY14UrvZXFJPtTKU5UepFchWUsIeB03UP4eb/dXLcsUmTkOtsDTRh7/eLKcC7k77vrYpQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4neAEEIbvpAYMNKWZSF6baUKapACCKwEZLEBy6ijEA=;
 b=IvAj6iRyH+7EKy+mdEGbvk1dOiEpd13V5uT75sDYwPGX0XS8gU+t+k0FkHEPwvapB8dwcDKhWymK86ITEISz6YOYs/Bm/SwXKykJGMnfZRj9ZM3S5H7/TIqj2jeCcILjRXSPL9E2BAo/gStnaEgn7ntHf5MPAHXc9Whu/C+RceoDzc76IP0IqlCAVhw0ZGFk9XniFoERaEio/86faFw2GXpCu1RAsT/qxJmpuBy8tQ9+AoBsk2roLN+K4IfrEhG6C0C3enkD1V/GD14AP7Ygu0qxljnMHcLf1XlWHxx+e0X0piXJ3L29SUhJfeqGW0qxtIYGEgzRj+GhtXL0ScsHrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AMBPR04MB963705.eurprd04.prod.outlook.com (2603:10a6:20b:75d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 09:03:26 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 09:03:26 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Dureghello <angelo@kernel-space.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [RESEND PATCH v6 0/6] can: flexcan: Add NXP S32N79 SoC support
Date: Fri, 14 Aug 2026 11:03:17 +0200
Message-ID: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::18) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AMBPR04MB963705:EE_
X-MS-Office365-Filtering-Correlation-Id: 749f6bf0-e71c-4277-4108-08def9e2e6e9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|7416014|11063799006|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 hM9neETTlqpz5dj6qnJokFgCtmKOYzfycjunlkSezVDyzuvXVhH6W9YOOzqe1STBjeOJJqwbEezrUcpsQH8P9DOmYREhxWqVcNg9gehEMEia/mj1AJSoce6n/k3G1SwuNKK+MuvMrm4h3lWYLjo+8IHaCs/OdDJ5r3cCxrFqctXBoRgggKvMpSpzz+Q3c/uACJwabG8e+fxeMgxDvaiU9cM7bI+5s0I6+0iKwVCxjuqkPyBXZYPk369mPJ64VPuOdIxlbEaMwo+/w7njWrRdecGWUsk8ovqNEH9tIZtKO7CX94mZ3oz4RIH8obtPl4acF7Ndy0Z+8KeGhBIXx3jRZmwBcIryNASj1Nzk0NW73gxuO/NSby9dwKGw45C9pYlZhgGzOxZQ1xGREf92yvt8Ltuu5G04JWSlWc4cB1ZHPBp6q2drb39+PyZ8B4QMJOX5y7xrhQ2+QYWqb1NpuQ3ikm9QdcqPfYH7D/Fb99uc9+PX/RFnV29cF6f5WSeg++mQNQVoBfnoh29u9PJryx1tY6gddZbodhIfSQmdQugsRZzShK7GAO6mOuW3SgrUdKVCB8QWBJ7di1vONAs85wByU8yoHspLokasSOPz5W1adNnmQjTdnX1yAmt545nLInocsEx47Q8esGysQ/fmKR7bQI1d2C0Kp24RSPU0MVzpg6I=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(7416014)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MUhJL3Zla3ZJQVhaWXRGU3kvSDFmM1FJK0lxbWM5cFdvMDBXNXJDbTJjTnE2?=
 =?utf-8?B?SXowSDY2L1lDdVF3QngwcnpxYlh0MFNSa2Q1andXaWZIcjMrL3dzOTdJbjdz?=
 =?utf-8?B?cGdzekJac3owNjFIOHJGY2ZRZEhIcGZ2VEhqMDdhSHJKcGVnRTJmWUtwa3B2?=
 =?utf-8?B?ZjBrcVhGRjVOcjlBaWUwcGZoc2xlYWczdWdSbzJRM2tiYVRHY0N3TnhhT3Ri?=
 =?utf-8?B?VVRTTFZYaCtkbXhjNkVKUFhtL2ovZUovc2VGNzV5cGNUcUVmNitRd0JUMlQz?=
 =?utf-8?B?c083bm1nWEJWY1A3Z01IbFBYRFp1ZFE2d0xRdU05T2FUM3NLdUJiUWx2aWw1?=
 =?utf-8?B?NXl4N1NSRFFBbDNUbE9rOENmRm9iTkZDcGdMbG4vTStJdXdZSkVlay9jTDNk?=
 =?utf-8?B?RzRmQzRRbm42UkNaQlZRemhCNHF2WExHajdmbW5hd1Y0ZXRwdDYxUUNvaFZu?=
 =?utf-8?B?ZExoNmFIaFlPd2hsUldHQUlpdmJRSmtiQUUwQTEyYmVUZzVOMHhrZXNDVEEz?=
 =?utf-8?B?azcwYTdjSE9iR085QkpXSFgwWnZGOEREK0tieTE3RExkbUUvblNPTFlUVktr?=
 =?utf-8?B?TWxFUnFwYkRucm1FMGx3T0tybUw5MHlURHFnZDR1MEhRdDkyYTNjM0d3dzY4?=
 =?utf-8?B?Q2xPcGFFdWZ1aEZ6ZzJ0dk5qTFFKRGZWZGV4K0tsekY5dzhLeXhhbVF4T2xE?=
 =?utf-8?B?WUNyUitvMlQ1VTBqa1F2NnVjUFlLRUtFVmV3aWlpRitxRkt2QldZTFJQVG1M?=
 =?utf-8?B?Qkg4WkVyZWowU3hucVdFMkFtT3B0MlVUbU03Q3NlOE9RZW40enowSTZmbU1v?=
 =?utf-8?B?R2VWYVUwTmhmTkhaRitDSmpsOHFBbkorYVpvd29qdERTanFDWGcrdzBGeWZx?=
 =?utf-8?B?QVI5Y3RGVjRQWEozMVdqbWhnQ1FuSWxpakVJNVQyeE9TSy9ZeU1sd2lrM3Zk?=
 =?utf-8?B?REwxMjZpZThESVlWNlFObzFTZ0RhRkFVTkFvU3pRMUg0ZDM2ZEN3bmZsNVh1?=
 =?utf-8?B?YlJkZWhHRlRheDBhU0k3VFVVcVVkQXhjS21DMXc0ZzJZQThzK2hGZFFIb2dM?=
 =?utf-8?B?UUFCS09peWZvUm9ob01PNXBwakttVUJpUklMNjJhOWJzM0Q5VHpha2FUSEho?=
 =?utf-8?B?eGg3ZjlyOHEyRGNsYUs5VklrY1o3Unk4V2h0NG9xbWhxRFZ3MnltVk4ybi9w?=
 =?utf-8?B?ZHgvbE55eVovYlU3eElsc282Rno3Q1p2WGJWYjZTaWlFeUlHZTZ0VnEzQm9s?=
 =?utf-8?B?ejdraWNDSDRURWFDY0RkU0NJZ2xnSStVZzhIT0M2TTF3ZVBDU3d0WEcyNEJZ?=
 =?utf-8?B?RzJlT0lXclpraWV3bkhGeDFQalJSc2dqMmg5Mm1jc3RNNXJybEF3Y00yQ3Nn?=
 =?utf-8?B?d0dEY1hSTW9qSUtVTDdpaWl4c0FjaDhRelhsb0JLMHdFQTJaNS9TMGpVMStJ?=
 =?utf-8?B?WnNHYzdWcERBYXd5VXJTOWVDUDZ4a1NhZ0lvTGo0Nmo3dVFpaDBjM2RsSmUz?=
 =?utf-8?B?dElQQVNSRE00QThNd3ppZVBPTWVpMEdQamlPZkpNY3FDUjJteUI5V3V2SnNU?=
 =?utf-8?B?Q3VEMVJSUDBHM3lpdnhCMFQvZjZzL29RN05lV1pKZlRiOGdYOHcwNzB0eHBu?=
 =?utf-8?B?c1pCd3RHSUdqSno5TW5sOGxxeVZDYjRra2p1eldtYWoyU0pjNTlnOTNZRjND?=
 =?utf-8?B?Wmt1aU5wNDVxSUZnclQzOEVvcjlMUVAzWmxjNVhUa04zbWRUNkNLMGNOekpT?=
 =?utf-8?B?MmxzZy9SVkpYRlFFZk5WM1dzQmRGSm1zZUh2Z3RzclRmVEtnNlhpMU5NWmFy?=
 =?utf-8?B?VWk1YU9MekVWZnlSTzNlb0hvdzJsL3huTFBPbWtNVWhqZ0cwdzRvNkg4UGpr?=
 =?utf-8?B?K0xVcXJwcGJpa3p5a0JVMHhCVFVjT1FWaU43eTEzN3ZjODBKVmdqRGVwQ0lQ?=
 =?utf-8?B?aEdWdktJNmtQeDJ0a0EyWjF4UVRyWCtUQ3ZWOWsxZ2M5TGhCcnFRMmoreVhG?=
 =?utf-8?B?K3JvZnk4aUlQc2dLR2c4c2VkcTZ1QVhxbnlDL2IzeGFwTXdibS9nNTUyQ2dY?=
 =?utf-8?B?MC9XTlBvN2JWUDNjdlczTmRCTkI2YjBVb3Q1WWpQRFNCZ2tvekllL3EzRnpU?=
 =?utf-8?B?T0MxSUJEaGxUYVA4anMzQTJYOVdnQ1RJRjMrZ1Zqd0x0Sk96T1FFTmNNb1Z4?=
 =?utf-8?B?Z3FZN3NFb2Y1UUY4cWlUOFMxZy8xSjZrTmpnM2FEaXhiaFQwN1VHUlJaNkFM?=
 =?utf-8?B?R1BMM081SCtMekNtMGY3VURhZXI2dnpjRFVlakpsSy9QSGhYR0JJY3ZyeEpj?=
 =?utf-8?B?WTU4c2VxYzhPQ0xNZUZWbGRlcnMydC9YOVBWQ3NORWFRT29UMzk4VkVUaUc4?=
 =?utf-8?Q?nltTfYFytqNa0Seo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749f6bf0-e71c-4277-4108-08def9e2e6e9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 09:03:26.6835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6Ckzb/tLFLPXtmonXIQoRbGCHCbM9vuWYA5wZ704XkAbc3l93a4HkD3b8gotyBhCpjh2ocr777g42XRgciep564WKCeizz2+OPRrMyADp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB963705

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

This patch series adds FlexCAN support for the NXP S32N79 SoC.

The S32N79 is an automotive-grade processor from NXP with multiple
FlexCAN instances. The FlexCAN IP integration on S32N79 differs from
other SoCs in the interrupt routing - it uses two separate interrupt
lines:
  - one interrupt for mailboxes 0-127
  - one interrupt for bus error detection and device state changes

The CAN controllers are connected through an irqsteer interrupt
controller in the RCU (Resource Control Unit) domain.

This series:
  1. Splits flexcan_irq() into dedicated handlers for multi-IRQ platforms
  2. Adds dt-bindings documentation for S32N79 FlexCAN
  3. Introduces FLEXCAN_QUIRK_IRQ_BERR to handle the two-interrupt
     configuration
  4. Adds S32N79 device data and compatible string to the driver
  5. Adds FlexCAN device tree nodes for S32N79 SoC
  6. Enables FlexCAN devices on the S32N79-RDB board

Tested on S32N79-RDB board with CAN and CAN FD communication.

v6 -> v5
- Addressed a couple of cosmetic issues on patches 3 and 5 .
- Removed dts related changes as they should be sent on different review
list

v5 -> v4
- Simplified splitting rx/tx masks per mailbox IRQ line

v4 -> v3
- flexcan_chip_interrupts_enable(): disable/enable all IRQ lines
  (not just dev->irq) during IMASK register writes
- Split rx/tx masks per mailbox IRQ line (struct flexcan_mb_irq) so
  each handler on S32G2 only processes its own MB range
- Added received Acked-by tag on DT bindings patch

v3 -> v2
- Split flexcan_irq() into dedicated handlers (flexcan_irq_mb,
  flexcan_irq_boff, flexcan_irq_berr) to fix duplicate event
  processing when multiple IRQ lines run concurrently (new patch).
- Added flexcan_irq_esr() handler composing state + berr for S32N79
- Ordered quirks used by s32n devtype data by value.

v2 -> v1
- Renamed FLEXCAN_QUIRK_NR_IRQ_2 to FLEXCAN_QUIRK_IRQ_BERR to better
describe the actual hardware feature
- Appended new quirk at the end
- Switched from platform_get_irq to platform_get_irq_byname usage
- Updated interrupt description in dt-bindings

Ciprian Marian Costea (6):
  can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
  can: flexcan: disable all IRQ lines in
    flexcan_chip_interrupts_enable()
  can: flexcan: split rx/tx masks per mailbox IRQ line
  dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
  can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
  can: flexcan: add NXP S32N79 SoC support

 .../bindings/net/can/fsl,flexcan.yaml         |  30 ++-
 drivers/net/can/flexcan/flexcan-core.c        | 226 +++++++++++++++---
 drivers/net/can/flexcan/flexcan.h             |   2 +
 3 files changed, 229 insertions(+), 29 deletions(-)

-- 
2.43.0

