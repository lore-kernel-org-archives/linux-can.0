Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013062.outbound.protection.outlook.com [52.101.83.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED03C3F7C;
	Mon,  7 Sep 2026 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778195; cv=fail; b=W5l8dQsIayaIBVpm2Eh9V87iH5vIOPhehNQdGZwsGYxgGgmavvuIDF+KSG4+nO3Vwgd9wx6CVza3q+m1nMWf5eYfYzv4YZQm2z0NFkKgVEe+fYXCxU6tzD9P2xLlhSBDuIMYmBXbwgzDa6FScNkVmLgVZHVPLyFztCCO+4FotaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778195; c=relaxed/simple;
	bh=xEd6fZXsr0+QuuSbRjfsF+C4VKeIqdDLQNYvXwvG/QU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GYDohM4ukFxPRBRl636gQZtWjyZk4y/jbfcglY1f52bHQOaZvSi8EDhS7DrMX9hBD1MG0LVfnuJXwX4vFBi9ivmHZ0PsNFHfniKOg+ruyMSyU3X4Bxvf0EmfUtfLg66bSSZGnQTcNqb3WMmL/sf7HGKmcIbaobiQ0pLTGF6oTG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lDumJKhu; arc=fail smtp.client-ip=52.101.83.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lDumJKhu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjaqBUdoJRmR7rDK2TfLjh69wO3yyJ3rkaXKpl2KIZud/Rhp5+ETWBVVEfa0rjXFgG51NokhiTzYJejSf5osx7f6bmIm4KJ1AjMGAqV9OTLZJcGXnUAuaF18Sk34HJDD+kaVDftgxpS1QN8X2w1cGOQ3+Bhibxd+y6JuPsZ0lw/aV0b6UxaD4L5uhiRxOp+FiN9e6jBhMN0bV5BIFFCAeUjZcFq8zj4N/ELjAMuTtj91GEgUYi9c0f/uEedEEd0o05x7tlb8sQf6yfw41C8P7j3nv13Syslo+iqTW61RD5UiwmGHmDEHsjG9fvJ2YaIJsS2320SSQrLxkBelh+R7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHwrDMp7YR66ZFPRYbMyU5uAM94tQhZs7rifH/L3Ti8=;
 b=e76E0q2OAfkKUfURzupNeQPVvSFA1eFyumzt4HnO5If5rlx5W/5iKKGy63g0OgiHPAoGIVAbfkD8x6MS8Utu0JjKfKPnfxWa1LwfexVkvDOc1eHHEkP1nnsrIM37veOniZ90RCEoprm8kgMFOsaUC6AQj/zZC3+sCzTuGHisYegvwnV3ehSmCC0RZhZxkNLnnoyrH1QZOhygOAvT87fGekErO94jJntDW9NPEyE96oSq5kitqYiaY8C8KqWBNeRFmd+OuudnRZtwRVR+MNKObKkmEQMyg2vR89BOZFlmjuCtAjkoOw/6s9kgNHUlei9SZG8Tj26hR07jLDOiD0mMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHwrDMp7YR66ZFPRYbMyU5uAM94tQhZs7rifH/L3Ti8=;
 b=lDumJKhuVUiHKmKBm97f0fzIm6lmhl+bAkmS8CYUMvfjYthEb6wBGKS+9QDeOe0BdV/EXmjCbsN94xtaYc+DWKXsKVaOjXm75EkDd4XaWS/7gXe89jFYoHVJloLxvV06rq1QZbjpGuNiUwvi0ISj4pHNbPwEXbkbqhAbNI/Md0DkRpK4lAXN6EnFuEvUqSQclIv8hslin1tMbgQDPkNgAOX8JHg2uLc5SQc8IUvsyn6SP7fakfH24CLpQjWERS8W/sYWLgS36QmjZS8vHxSZSArJxaiqkeTIaZX+XTUUIA7VW6hJg811kc8Ht/WNzlxfrYYQp3hzzcGji1wggaCA6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DBBPR04MB7578.eurprd04.prod.outlook.com (2603:10a6:10:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 10:49:44 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 10:49:44 +0000
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
	NXP S32 Linux Team <s32@nxp.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v5 0/3] can_rx_offload keeps a lockless irq_queue that the IRQ handlers fill and that is later spliced under skb_queue.lock into the NAPI-facing skb_queue. This works as long as a single context fills the irq_queue. flexcan with FLEXCAN_QUIRK_SECONDARY_MB_IRQ and mcf5441x use two mailbox IRQ lines. When those are affined to different CPUs the two handlers can enqueue into the same list at the same time and corrupt it.
Date: Mon,  7 Sep 2026 12:49:39 +0200
Message-ID: <20260907104942.17089-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::14) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DBBPR04MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: f77ac32b-2eda-4d6a-ff76-08df0ccdba6c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|7416014|11063799006|6133799003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tFE6SUXU7a4K6hZQFn6facxyuO4Pk7nkNl11kniLv9WuAbF9hbo5ITC0EY25W9OcrTI98rs1CiGtOrU8GvPBXOZ2qdY1lA5McuMgV8D2rkWXJXJnyEdoh5jc03iL0mGS8d14TCgKBqPmwz8BLem5Eg/SVokZplonpFr2hFVLfymsMLcI0BNv2acW/7s/DGQNNy9oQKPaFEGsGUm06KQDby2yCn6+T5REEBfpGAaAN3QI48WyJHuzPXdmvUnDnCHn1D5oYVBmfi7mmy7Jqtde9Hzd9y5FhBFJGZyJw4lG14nreE2IgwP6YX74kTlGcBGpp0QYa97vRWuH+eWAzsfXQ5BoKSCgI4nTXk2c07g+PspdBKdkTFbrByzdD0/BK+xC91MHx+iq8Yy+rMQlJYD6qwAz5+XUF0B4gtc7rjDVIPWWORb9KmC801+Gfb5UFqq1onlyBN7x8Id0K/s6gHs7LP7uPoA1kazPMzH9KrtOdaizZaLtOHqJwZD1wAJu4FGYfiBZ0OxBJLjqWgu9HICN4Fy9qt6cS3TIt5ECBX3FA5xKmlYXmpanfGupc+YkfHYXQwuAl0mJVEVuWxYQTyfTAyJazadf0T5nOGkjIq3z9VOQ8cKx5k06meRII7UN3zG9MDmFtAyOg4hY+lqlftgUZT4TS6/TA8SbebUjEyJsT8g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(7416014)(11063799006)(6133799003)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWQwQVZxRUozRzd6ejNUb2lFNmRVajBYN29idmt3RTJ6U2xBeWlFSE5ZMFJx?=
 =?utf-8?B?TjdRQk55THd6a0llbkI2Zkk3SiswaGNOekJIQUFlOVA2bCt2Y0J5c3h4SWN1?=
 =?utf-8?B?TWs5SkV4RGs3Uno1dUNtdno3ZmlJQVNHNXFZR2FjdjU0b0lGTHRGNG1qcjhn?=
 =?utf-8?B?aVdiSFhPUzY0eE4zN1ZsL0tLVVZKMWFEMFN0eUx6OXB4djc2aFQ1Uzlkd25u?=
 =?utf-8?B?V3F1VEFoVENFTXgrbEh2emMvYmxBRVAyWHdwTmtTMmpsS0V6VDdBVlF3SG1n?=
 =?utf-8?B?R2Y2VTZXdXBpemNJN01wSXhNeHcrNUJLMGFqbUtNaDRUbGpqeDNTaWpob2hW?=
 =?utf-8?B?MjM1bkFIM1lsZUxtS3BMQmtEOE5aSVZkQnhnYTJQZWxwdnk3OFNyNThGdm1o?=
 =?utf-8?B?Qlplc0RZMFUrYkRvRHpTRTNZdk9CTjRqa0ZEMTRselV3U24zUmNNSkE2blNR?=
 =?utf-8?B?YnR6dXQvNXNUSlVaNTE2OVZLbjlaSVlkY0Jvc3pVVWhrVjVWRzBhTkNUZ2VZ?=
 =?utf-8?B?L0hVTUdWZmRXZTd0dkFoRVlvbHBLb3pUK0wzWkZoSmJCek9XYTIwaURBUUtT?=
 =?utf-8?B?WWJyNTFOUVVsSzdXeDdtQlVueHFieDVjRmZEOEZiWEo1VVJnUWRYMmtsY1lE?=
 =?utf-8?B?dlQyN0RnNE5JTmRMdk1pS2F6ZHc0bDgwNkVOdHpuSDRoWnBhQTN3NFFEUk41?=
 =?utf-8?B?SzJEZHM1Tzk1Ynp4bFhKOG9MUzN5cVVLeGpxdnNERXlLVlowSnMrS0h1cy9K?=
 =?utf-8?B?aHNjcWJmTVVBSmxRV2toZHBkYVJMYmVCRlpac3Z2Ni9GckpJdjdpQTRBSDVJ?=
 =?utf-8?B?OWs0Y05uMDM5b2M3STZLbktMa0ZKcFRiMU1Wb3FVbXlMVlR0bnkyLzl3MWNo?=
 =?utf-8?B?Q1pod2lETTFkSWYwZVQ5Zi9OT3lIN0lNSUNxK0xIcUpZZDkxWTFSYXN0T3hS?=
 =?utf-8?B?b0wvL3o2SlVrVGJKMFpqN0FTMEVyTS9oUlh0dVAwWHlvUFZHVktIK0VaZjQx?=
 =?utf-8?B?VDIveFJwZTNFM1FGUENoSDFybXdRUlB1V1NiWTI3Nlp5TWhyQVJVVnhGMEw2?=
 =?utf-8?B?TUh6YWxRQ0t2SmtoSmIyaC85ekJrVVdCcmJlelVLVHpNVzR4VUJYN0R1Rmp0?=
 =?utf-8?B?RmhyODh1c0VWM3Zya2MrOCtvbDhYUHovY3BKdjlkVVBoTENtVlZNREE3dDBN?=
 =?utf-8?B?WVhkL1ZGZmlLSEJQYkdFYmYrd0UwazhCb1UzWXRkbUkwSWcyRlRzRHFYY0tT?=
 =?utf-8?B?YU12RVJlcUtESTdZVFAyc0lsYWxxdkplVnI0QStSaXl4MWplZW04ZTNLeElE?=
 =?utf-8?B?RFlrNGVSc3hUSGF3b1RZVGJCQkhPV2NtZDJCN2ZuM0dsRzNQRDhkN1R5T2E2?=
 =?utf-8?B?ek9sMUJ4bXBkTzZxeCs2SmhaUit2WEJPalROUll5WTFsTVlNcHV5L0lCM0Mx?=
 =?utf-8?B?Y0VmY21MZ0V2U3V2aUZaSG1LMXNpN3BwZUlUOEdDajBBZ3hFdjdYWmVHdFNp?=
 =?utf-8?B?eUh0QnhNZFNHR0srVHNRNk5MV0FUeWJaa00yLzd5WlVsNWF6aTVGMzVmdGFO?=
 =?utf-8?B?dGJocXNTZ2hSaU1pSjVtaCswRncvaUVIZndvSWdXanJSMFlCZnh4czQxdGFo?=
 =?utf-8?B?YkhSQXdDaXpzOFJsdlFNcEM3eDhqdERpbUdrK1FFNk5IYWlUN0I5ZXh4SkJJ?=
 =?utf-8?B?QTNrOXZ2VC9QY0EvR3pnSU9SeVhiT09iS1RTazM3K3d1b0U0VGtLY0thQVJP?=
 =?utf-8?B?RXdGL05wRGRaTHFHSjQ1a2ZlTmx3c1AzNk1scHhHMzNJWFluNTl3Qjg4TU1C?=
 =?utf-8?B?TU9Fems1NlVLY0h4ZnJxc3d1blRHZ3ZReE92eitVT0hWOWpmWjliejVYWWsw?=
 =?utf-8?B?S1hGUEhWUGNBSFBIZSswSDFUbjlqVFJwV0ljMldQR0VUSVUxLzFudVBCV3l2?=
 =?utf-8?B?ZEhaWHl3NGRtcytwTmRFQnRTR09UWlFCOUpJenhRemtlUzU5WXhwMEhkd3Nw?=
 =?utf-8?B?ODQxcS9xdmhKMk4rKzlSdHJjRTJlcFNHdXh0MjE2akp0WlIyc01RYVBRNnh4?=
 =?utf-8?B?TlhZa2syZWxlMlhRWXl1NmhKR0oyaHF3SEhxdncxZHFIc2pnWGhETWN0TkpX?=
 =?utf-8?B?czFKRTFQVnpPN256QUdjN1JLUlBKd0dNdmRqM0lQUW5YZ2VWZFkvdHNHY01M?=
 =?utf-8?B?RGxKdXNDbzRkUGVuRFB4NHRyNEc4anltQmcycHhVT2Y4RTFtbzdEMlVYcHBj?=
 =?utf-8?B?bWo3SVl4cGVkZFZRc2h4M29CK0pKcXVHVFNKNXFPaXJmV240aE5mZVd6VkIv?=
 =?utf-8?B?YXlpeUxIR1Y2a3JaVXNXaVJIUUN1a01HRGxldWkrNDdxUHFwUzRkZXJyLzZI?=
 =?utf-8?Q?henIM10rqjt53xB4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77ac32b-2eda-4d6a-ff76-08df0ccdba6c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 10:49:44.6246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+pG9jEvdTjvMhkqaqR0Nm9waR29ILG9t9TqYkZTUKpUACEHR07td+DwpbPE/UO11RFYv7DAly4PCZ8tmS5kkXr6UyWHFrWoc6LNYgnAANk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7578

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

This series:
  1. Makes the irq_queue per-CPU so the handlers no longer share a list.
  2. Fixes at91_can rx-offload teardown.
  3. Checks the can_rx_offload_add_manual() return value in gs_usb.

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
  can: rx-offload: make skb_irq_queue per-CPU
  can: at91_can: fix rx-offload cleanup on unbind and probe errors
  can: gs_usb: check can_rx_offload_add_manual() return value

 drivers/net/can/at91_can.c       | 10 +++-
 drivers/net/can/dev/rx-offload.c | 88 +++++++++++++++++++++++++++-----
 drivers/net/can/usb/gs_usb.c     |  5 +-
 include/linux/can/rx-offload.h   |  2 +-
 4 files changed, 87 insertions(+), 18 deletions(-)

-- 
2.43.0

