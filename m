Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013030.outbound.protection.outlook.com [40.107.162.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C52944A72C;
	Mon, 31 Aug 2026 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186897; cv=fail; b=VJjhJ72s8uXiHEDrULrAb9cs69FsM99QaLE0ZarPC19d4eh2SAQs0Uj9ral64dkgcIMTef8XUWGajqMoDcYrkjEnG9zQb2yzxmTbefA+X934r2n4CtXYIfdn4oEtyJfTRW91A4zytFSZwKg6PP7hKMkkUld2qpJlisz+Tb1463Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186897; c=relaxed/simple;
	bh=sG3q3DY3SHr4252w4Ey+fAdBPYrbfr6FdhS3E0V2YK8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ni3ssVJERZKxYlvpXT4RBesENtIna6yma0BiwPJtqePioFwCeDBo9Uem1lyDwAHcz0zoSaksI+HRBbSJGROLjsk9Y+WBMP/ZLSfsLGQsrzOr2avXMFBCMcdRbi+dqzoqvxXIBY9WmjzxEtGsB5eY2XBPsrWZyKdS22vhs12lgUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fOhwrUQ9; arc=fail smtp.client-ip=40.107.162.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fOhwrUQ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=av7gAzlZ8OE1bIic/5ugv3Nu/CxInAwL+qf0Bl4LoIeUMiwE2Ko06SZ4RuHa4rJWc+/Ccxqj7tX9EieXizl3LYR0SwqP41hiC3CI5N+Qk+4L0/R6y7yGvapv2WaIHGraLv4f+jPGHt1O5EQMJu30y8TRuAyKYNhdwgnE6m+fCYM3VYkEfWPjdq6u6DzVHI2Yh9nr4LREgm5qMGiNqEbcSHiRe/w1cu0oMgcy5fveVpBsWkUGa0/0gQxSxh6du6g74qNpL1n6pChrFglqj9ZUwZHS/Df9A3c0Wh3ytilWjm4OrKiOhTegAvNL+zjY+vQ8YPaf5JItvADHiSbbs6tW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlvlVeTagF4349BURMGmiNHO/BW2Ibv7FcW56sf1Cq0=;
 b=BrqTNblcmMvrSFx3mGic5RFz0PRZ/YKYLcyZ7jrPF/OleOvTOOLh5F1oas/PPfW05ujpr1yU0FelspcWHIrm6TztC+QSVBzp6DMMpDLSUX0p70fcNEoB1UT+TaoGSO0cNvV2jCwXs8OT9Dl6WC/jkmlZKP+HlS1M7S3j5/SoTe+10M6eyHM/uzYkHH3irvGHmTPkn84KlRmXNyx+wV0OOgMGEafArNU3D1BMpX+pqO+yc/0ht08//LhibW5cQ0vAPNPqfhtO6AjhiAH5vmvhXI70nBXJsugYJ1thEMtJdv8+HXn8XjGAWDzR+BUqPI0gyD+GLWEUe9O/BDXGj/W6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlvlVeTagF4349BURMGmiNHO/BW2Ibv7FcW56sf1Cq0=;
 b=fOhwrUQ9XKMYWYz2AneIPTs8tpJXeASSioyRW6F+DV/UuoTzHtjX49XrW/aIN5ybd+7oIkix47ocqGGGCOXsWouipqh8Dn4J21iAAgowa6aM8KCHxXPCg33FtPr373RhzYt3hHcbjVcICjVw06VpwU9AhwG6Kbl67axsdlL4TG2/I1z80YxOmO8h/gHKR8wfE5+gXNWFBtTcJU+228XlEQw8ZGT/uzizrijBIvG0pb8kvo/z7+1v+qw1tM662oF/u4TSx6xroZ0wAbXFJ6PLG1qelFYOOtIc5Ha1i2neBcEmapnd8A18gQISZNTTnJtgqJ/iDt0fjgvliVfWOzxYNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DUZPR04MB9795.eurprd04.prod.outlook.com (2603:10a6:10:4e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:34:51 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 14:34:51 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Dureghello <angelo@kernel-space.org>,
	Frank Li <Frank.Li@nxp.com>
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
Subject: [PATCH v7 0/6] can: flexcan: Add NXP S32N79 SoC support
Date: Mon, 31 Aug 2026 16:34:43 +0200
Message-ID: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0174.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::11) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DUZPR04MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d97d487-6dd2-472a-7f91-08df076d03f7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
 PXthEkbx+cHRyqBsNM16eHS7XdUAkXjRaTyh4Dkt/Olhpc96lyP40bjYh0qz9Nog7l27jnP20ae6HiRKZwUyJ1lQ6ZsL+O7C3mne8XLZ56E0F5kqfR/IMops1ca8W3+FJE3cK5iO6rx7EDcfJhWpvUvfQ3ZR7vXv9B8VKr06V7Ft/5mhwNqDMQ8fD43OIKu5tDs8Cm2j20pjOWeaSjyFnzzwqB515AWTn4xB/g7EGOSea6hF9OXDhiK2seJpYlYmWlZ6thXHcYPbM3q+YL2BMThRmnnZG6ob2fXe2+oTx97d9vLVXTQNBpndPIkqZHb0wSUs74cF3NwzkoFfRmRepwPzgw8g5cpGBYemjZ0NcyVmt9V54pp/jHDvpjwnXzjq6Q/sg1qSDMc7Fl8iY9PCNOfZq/aPfunQ6ZWjhcvtsozo/ZG7+0dFPT2ThIO0AJ38zRiBNppX4UrsoOUVfbIC2qnvJC7m4njT1XgzZVkLHGbXmZTdHqPm6OaBA9leh/Efv2zu6IQrDCkYQzbPFJaXqreJ+SZltjGdSKv+xH5zrIX4neitr3oXG9SCvFxsVU58usrw+G18B3BZGScZv2UxMx/p/yp3Uu/x7CWdF95GlhNSnZ6HOYmDbIoiyIJKFhJUAELR+Y1xzSVTDd4L1KDaoNqQBvuzMSYkGyrZ32Y0MMM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bTU1cWdlTDF6MEVrRWJwdWloZWx0cnBJL1BWYnI4UFlESjcybjI3M0dMV05s?=
 =?utf-8?B?eFJHcEtrRE9pRk5YVkczeGRCZlUvTUR2TXg5MnV0akpid0pVSjhTYVZPZFl0?=
 =?utf-8?B?M29aNWtVYjlaU3ZoUlRhV01Rc3Z3dmJ1cGs3WGlkTjZNQ2JCQ3hMOXlONmQw?=
 =?utf-8?B?RDdKMTAxNDRtR090TEp3ZGJUNCtpUFhVQmowbGdpT3h0UzVJUW94dkR0Ylh2?=
 =?utf-8?B?bVh4YUswcC9OS1JyT3NzM1g4NHUyWEFFQWJ1TUh5TUNxRm03aEgxclhxNVZB?=
 =?utf-8?B?eGlQbGducm5mS0w5Q2dzdnFqeHNFc2U4elpBbnZzdlJ1SEt6Q28wdHcveEpx?=
 =?utf-8?B?Y3BibGNXNjhUWDl4b01jWkJQL3BwVlVEdUt2ckZ6Y1FNM0M4Z2tNZW9SN0M5?=
 =?utf-8?B?dHI5NlhqQm01R3Z2MWJkMjdxRlFOYWJ3aDRiT2Z1TTFPLzZlSk5aV2VCUjRQ?=
 =?utf-8?B?Z3k3S2x2R1ArTE9ZenBPOEFQcWsvSFlLeGNrWFBKTHFlV2RLcTJIbkgyZFlm?=
 =?utf-8?B?M01VQ0Z6ZDM4M0g1T1VUdEluL3lyS0ppN3dKdDZyQUxPTHo2QWRXZnVObWJo?=
 =?utf-8?B?YWNwbnUrNCsxNkZEQU1OcVdVS0lxZTQvSldYcVhiRWtPa0RYK2VXbzJzb3Mx?=
 =?utf-8?B?NHRDOUhWZUpCeEhpVkh5dExOTGlmdncvemJQWDBpUGFXMDZiWWg3U0E4b1Mv?=
 =?utf-8?B?L0Izem1RMGlTVjJIblBkbGJZblU5RjRROW5ZU1M1TmVtVmdmd3ZnazdpVkU2?=
 =?utf-8?B?R3J0T2k5b3JKVnVOSExEZ25HTGdSdFo5YTNlQXliTWRGeXhEbnA5NEpZaDBi?=
 =?utf-8?B?WHNZdE1mL3BxM3dPcHhOWHBqSjN4ZkVrczRDS3RidWgweXFqZncvYVorVDZw?=
 =?utf-8?B?VDc5Wkw2cDRvZ29FR2xXRUZ1S0U5RFNqTCtHOEk4QWg3SnNqTnd2QTdQbnhG?=
 =?utf-8?B?ODU5U1YvWXo5elBJajJuYkxhV0xzeCs4a1BZaUdNR3F5N1ZPN0VHZFlkTjBF?=
 =?utf-8?B?RGlYRHp2VGFDU3kwZ3JXSVRwc0tYeWlKTTFabXUyZUo2N05JaVRvWFNUZnY0?=
 =?utf-8?B?cVN0MWR4MWoxaU5kOUI5clFVUG9tZ2hNQ2V2VVJwMi9KcStXZWhUZTJBRnhH?=
 =?utf-8?B?bjJMWmJZaWp6OFVaWTl4NjFXN0s5citBRGFvbG1HY08vNnVYSzBMMEsrS1hy?=
 =?utf-8?B?Ym9DbklGeWIxcG1NekVwNUtpMFdWb2oxV2YzeFkzd2RNRW1vYlJERTE3d2RP?=
 =?utf-8?B?T1FZQjhKYnN4OVpRZGRYZVRLQVBaQ01ManU5RDRZOFpLMURVbFF4SWozdXpN?=
 =?utf-8?B?RnRwZWZzSEtUMHo1QlhMTWVCc210Y3RDNmMzcHpDcW1NeVZrZmNMd0JTL21p?=
 =?utf-8?B?VWxXV3BYSHVUV0JENXFnU2ZrMGZQRXNwbkpieTVUcld6U0hLZHNQOFBVMlRM?=
 =?utf-8?B?VGd4REdTY0tHMjF3ODFrVmFCaDhreHg0bmdTMDkxdzZ0UVBIR2RDRXZNRE43?=
 =?utf-8?B?M2tseTV0eWg1S2xUK2lUVU1yYnhEZkVGZjBWeDdWM2w4UDVSM0FZQ0tJeTMz?=
 =?utf-8?B?UW93MXhLUjJRaFBJTURhQitOdkVPYzlvQ3JMbmQyVGpqMHBXZW5uOWxISHBC?=
 =?utf-8?B?aERRd0RNUHI0TEdwanZEYUtkNWJsRlIwSG5GTDdGZlhTSGtES096UmpXd2tQ?=
 =?utf-8?B?NkhNcjIrME9jT3BBaU4rd2Z5bEREREhQMVJxOU41TEpreXlpeFdDcW1sbEFx?=
 =?utf-8?B?Yk9GVUt0bXBuclA0T0pIZGhHVGpLR0FXMENpZGhNM2pDSkMrTEl5OUE3YVk5?=
 =?utf-8?B?OUZrVkZPSURpak9SZ2FJYkxWb3diRUpzajN6Qk5wSDJ4YVluOURzSmYzOGpX?=
 =?utf-8?B?cy9QZlhUcHludjZNRjhjMGhwS1l6QUt0UVo5UCtpUitpOTNQNktuRG04R3E2?=
 =?utf-8?B?aTVZNTY4TWFGMk9KYUtDYXdHRXlKbGI1QVlEWjJ3d1NQZXRPSlRnalJUbUd2?=
 =?utf-8?B?Vmo1bnBZVjZxR0Q3R2lBRUJ2bkpDZ0lrSVFRV1ZKLzU5R3JLdzFGVndjbi80?=
 =?utf-8?B?R0dJaFlZM0gzNG9IdE13YjBrZkR0eG91eDROc3BaRWpPdVRjdFdxZ3hUK2Jq?=
 =?utf-8?B?OUMxYTlwTS80TzNGWUNZVjRIazF0Ri9EOVRVOGthamMyeUNHc2V6WkwvdTJo?=
 =?utf-8?B?OEgwOTdzS0F4aVZCclVkNDF3cXQxSjhBcEN5UkNIQXpQbW1iTUpoZ0wrMHZC?=
 =?utf-8?B?ZWthaE5NdjhFazZRaFM4UFg4M1dWZGVTbHRHbTdwV0d1THJISmFmK3lQT1Ra?=
 =?utf-8?B?RTFSTm1qQnVLWnNUcGNtd21lYVViVGphazFBN053eFRncEpUN0RrcHAzUy8x?=
 =?utf-8?Q?9bb4tuhqG48hGdzA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d97d487-6dd2-472a-7f91-08df076d03f7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:34:51.0455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6+dpTg5/UnOumcCwH4vwMbU8rL/Td7r8uEqlZB1oUerNlxJzIerP2kbNYtzcAJlfaGHF994uUtM3s3ghyHchFZQsnT0GXXsfR+aDObu/R0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9795

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

v7 -> v6
- Fixed an issue reported by 'sashiko-bot'regarding the
  'FLEXCAN_QUIRK_BROKEN_PERR_STATE' quirk, caused by irq handlers refactor
  in this patchset

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
 drivers/net/can/flexcan/flexcan-core.c        | 229 +++++++++++++++---
 drivers/net/can/flexcan/flexcan.h             |   2 +
 3 files changed, 232 insertions(+), 29 deletions(-)

-- 
2.43.0

