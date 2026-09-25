Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8334837F315;
	Fri, 25 Sep 2026 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347576; cv=fail; b=b3pCgJ11kgic7E9CB6wDVtqRPe5JW5OL+qDbhGcevyFZV0+Z3IKqI/ot75zBfj41gEZj0i+tKKukfziEefEcX+Uoond5HcFCr4DOfkBc9RZMclLB4hp5YhB53paPsXD3LXMp+jvyzdTbH86wtKausDFtilHEdO/0Z6BJRs+oHzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347576; c=relaxed/simple;
	bh=BRL3y2m3wDCeNAII02Yuse+nSQz3S06tZxj6bbuuzAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PINR/+HfDWQAl2jup8qQpSFdAaL6NkHMl0zbO0euqAqUO4eQPkokNE8Eyv2/BPZGub5bXuRhw0NwPj2XKMoqOy1j0H2geUeIlVV6yUT5RaipJ8RQKAg5AUPhZG68Swl+4dZqiYnTbHHRD18HXld1EqvJ84SgVOl8cIs9JrRufTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xxf+Jtqv; arc=fail smtp.client-ip=52.101.69.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xxf+Jtqv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcDDd2O9IVUNUmj0+hqipJu7XyMvzojLmosKxsdbavpe8UafNa9yu/n5qgUChfA37FdPzdxi7k0vNTTdvq5S3viBnFjV5sHihoenC+qa8XmC6N1R74A1VPJAGnYWzQGLDNuEAQlLzyQQ4RtU3ghVCYCHD8FXMGM5qCKoB/fKAU6OB7WyoHUUovB7J7QEhFdWWblEKxj2HTWe34LT9lWaZvFF5ZJ3rLl7NtN/xC65aVd9T2+GYo8BsZ8AeQBmN5OHGmaM+cc9TsD32GS2j7ZDGA6hzzmpk4xvANsNz5UquyVb+MM4a04wwE1pC30qfKHuAHpK/8oY2dJUcev80b/hEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc5TbSsuRTN+cZ1DzeEA7QfO8KbplnJWWL3CecUwTN8=;
 b=KVNGfAnoJOq6cdvPHpVptQWzDIw+0GWbbq5VBXGoVM4NVDQf7CFuR5fllNCtERtyery5vcvfLMNLxO2Bqjt3sO5qODTAQlHvKu1EuTln1ssLlGkI/MsunA9n7BgDD0u/rj6og1nSz5CEFFDcxmm23vdeXNFpp1vcI6Z0/evO7EeHq7FLH8fT0STBcSL51xng60laXvbwVElfkKuw/0KjNXIOsAURvwq47+bJu7t9JWMdL3c5GG9A6MmIrrKIV8gJdf8gy2piOrprUo+rz79OqNi9/uwR+KOyO+eVDoOgn2l0QA/IgUChOUr2UUCaRevJX8E0fyw/2f2aviSveU1jQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc5TbSsuRTN+cZ1DzeEA7QfO8KbplnJWWL3CecUwTN8=;
 b=xxf+Jtqv4Eg7YIzDq4tRCbmi1GiXIJCOoRhC4h0cgmGdZ8mZrZFnrz2yHNVmoV+vo43xop+lFfGuMYZJs4LY3bofMGClu3758NqP6SG0KyBkaEAarEz6kedJS5cAxpgwpz5K4s1ZxZDYSYVIbe70yuogTghsqXmJtr8f8ImMHQAy/lY9zJgmMqvS8NpHp30Flv1Pra2MF2zFkOY0qWgwzwh7tvHhOAJ7C5PcmbPMPsOIWv0LACE8UwSSOZJpRR7hpfOVm0oDCtBcehy6PU4UoomxZj8cvZYKbXL3FcOaAewFsDnndNbHtnv/zt/jCiZjOELsG0pBIY8K/Kq09LL0uw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by BR0PR04MB337759.eurprd04.prod.outlook.com (2603:10a6:2c8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:46:04 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:46:04 +0000
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
Subject: [PATCH v6 2/3] can: rx-offload: add a per-IRQ receive context
Date: Fri, 25 Sep 2026 16:45:57 +0200
Message-ID: <20260925144558.2909639-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925144558.2909639-1-ciprianmarian.costea@oss.nxp.com>
References: <20260925144558.2909639-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::7) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 1523cbec-8c53-440d-6e2f-08df1b13b995
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|921020|11063799006|10067099003|11062099010|56012099006|22082099003|18002099003|7136999003;
X-Microsoft-Antispam-Message-Info:
	SFm+w6mPhe6w22UAYqpTdp2nqcpZybbscVZtkms36Puig+m5p/BZ/6A2pggrwRbY5lGO2J277B1JcFAOMHglD+90qFdOTYTMdw8lkL11DPvEp7fcfl1lsyHTTFgh7ax8VeivlE8AoMTVQ3XqCd9jI9IizoG11sHPuGA97FF3e7Tz/O/w3Sg+V/FT5sOFUn07y19B+n1jgJqOkQSxofVxvnF+Pe5LlnRGQTq4vPjBW1R+m2eIP68YfPIQ21JfCjv9sZLHwK7cTbJ69V1FbTsh3uVnpql9sL2upmGH/iY/6zWrhCBQp9QxGPMohNSzqyXTuqODQ0zQMgXuW1mjMzi4t9ealdaIkcIRuVJBflSPtItqkalJoewIVnMDfWvtKEpwuBR80xQGx02S5LFq90BI6aTd8pihlcoBsKUQOhhFBPqD4xH0EU7DLEVh24B+UX7X5VGwHwfL/gt0EJpvbIKWoKEagXJkRSRmZLRlzMijmPFngDBxyDhp3u4J6r+laoRGqS2g0h3rxJaYQWl5cVJ1PLC05sBefT2v7ILRikui+oaliy+vbIG5gDnx8bHP0v30mOHqfuHGXZFe7ZjovH08Zz1dImivjGGNq3xgFUGOmVfDVK8zYpkTTUZNkh99pD1eBaQhCxVW5aNo0DlGZH+Vo/dPkmTiQKvXhaMixNLIt1auKQ0V9XzTnDI/BljyEuSaZkFPASsfS4R6GV2BZt9ocQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(921020)(11063799006)(10067099003)(11062099010)(56012099006)(22082099003)(18002099003)(7136999003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzhyNWpKTDZydFRVYnFTc09kYW5MRXZCUlM0T2RicmlzU0xyRkt3cFNrZnNl?=
 =?utf-8?B?VmRoQUZPQThYTkd3MDBUQnNNLzBkYTA2SHRjVVM1Z0dzNUVUVzN6bDBkK29F?=
 =?utf-8?B?V1ZvbTVrSzh2SmsvcG5hejFtY3dzQzVLRTNOUFlsL0VRNE5aQUs2SXZnOFZN?=
 =?utf-8?B?bmFjTWRqOTNLbDNqTUF0bnJZVXgvVzA2NjBtRjlzbHBhVmRpbitSSFlWK1RS?=
 =?utf-8?B?MTFkTFBKVVlNaUYzR2x2MHFhSHZHN3BBRzNTTEpsSUtROGtBbmJXSG0zclYz?=
 =?utf-8?B?QTJRbldSY2JucWxCckVHT0ZpTmNEaDBEVlNXc1RlQTFUZ3N0N2MvUWRvK0dD?=
 =?utf-8?B?RGk4QlFwNnBFWWc3MldIc1phTVQ4WGVXTVZHUmZsZXU3ZTg1V0p0bzZXdG10?=
 =?utf-8?B?OWR4dklaZ1NnVU01NGYrL01QK24wNEpVUXhyQ2NmRnkvbmQydWlaWDdMV0VR?=
 =?utf-8?B?QXhZZHRZaHNIQ0FKU24vcjdxUFNMeEQyUkhXRUczZFNybTVQcTBJZ1ZIZ1R2?=
 =?utf-8?B?WmZrRUJtbm15cjVjTEVodlpoL2dxeUJjWHpKSlU1SFFVbnl6bzNQaW0zZWp1?=
 =?utf-8?B?N09HUkNidjZBak1sNzlrcGtIazlzSjMyRjBZQWJ3YlUvbXZkWU10VEFvZnF5?=
 =?utf-8?B?b1UxNUpDOW5YZnM3M1U5NlJTTVVuQ3JGek5ZRW9vcTdkMzNXVVM5RXRISjR1?=
 =?utf-8?B?WGlWOEJnUzFHdDNPQVJUUi90UzZBb1FuaXZTTkEzQTErNVVJaEZ3cW9xMU1j?=
 =?utf-8?B?T0taMHR1aDdUZmd0eUg0bDFPVDlvV01uS3lJK1NqRXA1NkhoSE9Jd1pybEhh?=
 =?utf-8?B?UEpHN0lFdVpCM2JLQWFZV1JLRVBWK1pvTFEwSmtNenBSRzFwTmhZckdKS1oz?=
 =?utf-8?B?OTlQNkExOXVlVnRKdjI3T0IyNW4rd2lBN0VPS3NKL0IwdXNuNjFnTDJmRUtZ?=
 =?utf-8?B?elFtWFFUc3FBU3dvbWVTMGp0eFFQME5Td2I3UUxtRUVXR2NEVWIySXFDZjRp?=
 =?utf-8?B?VloycFE0eXRESXdYVHFPdU45RmVYRWg4K2d4VUJqQnBqeTQ3YUJBM0pTWTNG?=
 =?utf-8?B?QzJDQlhoekRWazdFdzJFRnpNZzJsRHdSSGVQWWV5MnNyUmp0M2FCMUM5WEZL?=
 =?utf-8?B?MVBoNDFjY1JXYy9OOW5vNUtDM2hNdlRUTldqOU51QldET3Y1d2tiaEd0OVFG?=
 =?utf-8?B?REtBbGVrTWk5YUZxSjZZdnp2Y1R0c20zMFdHOFcrV2J4N2hxU0htMGJuN2dN?=
 =?utf-8?B?Yi9oOVBFVnVNM0RJbW9CL3ZFd2RkWjhpZzhzMGNWaU04Uk9LbkJ5U1gwOFkv?=
 =?utf-8?B?cXJkVXg1Y01rTFlFeGFFRzh4MUs1Uzd2SnI0b0RDbUw3cFNXa1BIMk1xUnNt?=
 =?utf-8?B?aEZNWmVtNU04Q3Job2p5UnhubXBtTWNyZnhpSjFyMWh2Z0ljWVJ4aEswcWxC?=
 =?utf-8?B?ZW5zZUR1dGFSaFVjcTBDWkFZWmpkbFpZUklMUXBGa2tVeHQwWm9oZ21ZQmdB?=
 =?utf-8?B?OHB2TjJuZUxtQzMrVDRWYUtRNTJ0WWVxN3d1UGlseVhyYXdBVnQvZW1LRXdz?=
 =?utf-8?B?cDg3VVZ4K2Z2eFdaeFh0dm5jNW54R0t1cG1taWlRRHlXTFN1K1B3OCtLcVJz?=
 =?utf-8?B?WHRGVmZzRW9UVGg2Zm5Hc2JiazdGVGJsV1VneWhZdDEwZjVaUndJTlliYnhG?=
 =?utf-8?B?WVRpa3NCd1k3dGhweE9YWXBHRnVBZGNNNXVBbUIrN3pIUHoxTGZDbHRJMjhU?=
 =?utf-8?B?bWFHS0tkMHJYRkdrYmdIRGliS0k0VFNPSmZGVENKUTlINjVBaHk3aFhBWFJQ?=
 =?utf-8?B?aHBVN1B5MDRiK0cvYk1qcSt2Zm02d2xkSnhVZ0czWnNEWXpsTGFPei90bHpE?=
 =?utf-8?B?N0RzTkZ6RHB5TXl3S0lmRGJKQktNdm1MNHJjWVZFa2R1M01MK1RJYndSek01?=
 =?utf-8?B?ZXM1cDlPaDVrSk45S3NUcVpha2RmWDFpd3RtZ01uSW42NWtDRXg5VU4wZFlZ?=
 =?utf-8?B?L1JWNjVLY2VXUUdQOVFKUHBpZW9IeW5PMDAwK0pJUWVrN0RnRytjM0VRSGVm?=
 =?utf-8?B?eGZ3NkUzaENSV1BFQ0lUVnh0TjhkNUJpMlJpOFlyazQ4RWN1bjhueThrMGtk?=
 =?utf-8?B?dFpRNExINEpqeFg0TGcrcE9YSThTbnZORGFxQ1VMdzJsYzNVbHR4TUI2cEtD?=
 =?utf-8?B?Wjk4ODZ1Vkt6OWlpcjJnVkVmVGdPQmpsNG1ROTg2YU1VWnNZTHBNejU1MllU?=
 =?utf-8?B?dTg5TG5ZWW5teUpUcFF1RVdBVGZUQmRYeWFwY2J2d1ZjTTR5U1dRVktGZFF2?=
 =?utf-8?B?RkJFNS9odnRkbXpOd2Qzb2pBc1BRU2ZuNGRwQ1FOS0kzUnRpclBvanVDMjFE?=
 =?utf-8?Q?NYT6zrW3zW/PMzvU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1523cbec-8c53-440d-6e2f-08df1b13b995
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:46:04.3131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMHliLPgtWoHJhG3VSRaldmk7UMOBii7SSYi0PaDQTF/cA/AtYAdCe9y+bMSR51G0gB9wa+9/Y8AT/dhPeL15Eez05ZXBjeQezx/q6bUJ/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB337759

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

The IRQ handler fills skb_irq_queue without a lock and the finish helpers
then splice it into skb_queue under skb_queue.lock. This breaks when a
driver uses the helpers from more than one IRQ line. On NXP S32G2, the
flexcan handlers can run at the same time on different CPUs and corrupt
skb_irq_queue.

Add struct can_rx_offload_irq, one per IRQ line, which holds
skb_irq_queue, skb_queue_len_max and the mailbox range. skb_queue and napi
stay in struct can_rx_offload and are shared by all contexts.

With a single context the finish helpers splice the queue as before. With
more than one, the skbs are sorted into skb_queue by timestamp, unless the
driver queues them without one, in which case they are appended.

The queue, echo and finish helpers now take a struct can_rx_offload_irq,
the add helpers take the offload and the context. The NAPI weight is the
largest weight of the registered contexts and the queue length limit
derived from it is shared.

Convert all users to a single context, no functional change for them.
flexcan is converted to one context per IRQ line in the next patch.

Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Assisted-by: LLM
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/at91_can.c                    |  18 +-
 drivers/net/can/bxcan.c                       |  14 +-
 drivers/net/can/can327.c                      |   8 +-
 drivers/net/can/dev/rx-offload.c              | 196 ++++++++++++------
 drivers/net/can/flexcan/flexcan-core.c        |  26 +--
 drivers/net/can/flexcan/flexcan-ethtool.c     |   4 +-
 drivers/net/can/flexcan/flexcan.h             |   1 +
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
 21 files changed, 263 insertions(+), 153 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 09aa676a03fb..f7b775f7c6d7 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -151,6 +151,7 @@ struct at91_devtype_data {
 struct at91_priv {
 	struct can_priv can;		/* must be the first member! */
 	struct can_rx_offload offload;
+	struct can_rx_offload_irq offload_irq;
 	struct phy *transceiver;
 
 	void __iomem *reg_base;
@@ -568,7 +569,7 @@ static void at91_rx_overflow_err(struct net_device *dev)
 	cf->can_id |= CAN_ERR_CRTL;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, timestamp);
 	if (err)
 		stats->rx_fifo_errors++;
 }
@@ -745,7 +746,7 @@ static void at91_irq_err_line(struct net_device *dev, const u32 reg_sr)
 		cf->data[7] = bec.rxerr;
 	}
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, timestamp);
 	if (err)
 		stats->rx_fifo_errors++;
 }
@@ -810,7 +811,7 @@ static void at91_irq_err_frame(struct net_device *dev, const u32 reg_sr)
 	if (!cf)
 		return;
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, timestamp);
 	if (err)
 		stats->rx_fifo_errors++;
 }
@@ -836,7 +837,7 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
 	 * Some bits of AT91_SR are cleared on read, keep them in reg_sr.
 	 */
 	while ((reg_sr_rx = at91_get_reg_sr_rx(priv, &reg_sr))) {
-		ret = can_rx_offload_irq_offload_timestamp(&priv->offload,
+		ret = can_rx_offload_irq_offload_timestamp(&priv->offload_irq,
 							   reg_sr_rx);
 		handled = IRQ_HANDLED;
 
@@ -864,7 +865,7 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
 	}
 
 	if (handled)
-		can_rx_offload_irq_finish(&priv->offload);
+		can_rx_offload_irq_finish(&priv->offload_irq);
 
 	return handled;
 }
@@ -1120,10 +1121,11 @@ static int at91_can_probe(struct platform_device *pdev)
 	priv->pdata = dev_get_platdata(&pdev->dev);
 	priv->mb0_id = 0x7ff;
 	priv->offload.mailbox_read = at91_mailbox_read;
-	priv->offload.mb_first = devtype_data->rx_first;
-	priv->offload.mb_last = devtype_data->rx_last;
+	priv->offload_irq.mb_first = devtype_data->rx_first;
+	priv->offload_irq.mb_last = devtype_data->rx_last;
 
-	err = can_rx_offload_add_timestamp(dev, &priv->offload);
+	err = can_rx_offload_add_timestamp(dev, &priv->offload,
+					   &priv->offload_irq);
 	if (err) {
 		dev_err(&pdev->dev, "can_rx_offload_add_timestamp() failed\n");
 		goto exit_free;
diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index baf494d20bef..fd032e094ee3 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -165,6 +165,7 @@ struct bxcan_regs {
 struct bxcan_priv {
 	struct can_priv can;
 	struct can_rx_offload offload;
+	struct can_rx_offload_irq offload_irq;
 	struct device *dev;
 	struct net_device *ndev;
 
@@ -420,8 +421,8 @@ static irqreturn_t bxcan_rx_isr(int irq, void *dev_id)
 	if (!(rf0r & BXCAN_RF0R_FMP0_MASK))
 		return IRQ_NONE;
 
-	can_rx_offload_irq_offload_fifo(&priv->offload);
-	can_rx_offload_irq_finish(&priv->offload);
+	can_rx_offload_irq_offload_fifo(&priv->offload_irq);
+	can_rx_offload_irq_finish(&priv->offload_irq);
 
 	return IRQ_HANDLED;
 }
@@ -507,7 +508,7 @@ static void bxcan_handle_state_change(struct net_device *ndev, u32 esr)
 	if (skb) {
 		int err;
 
-		err = can_rx_offload_queue_timestamp(&priv->offload, skb,
+		err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb,
 						     priv->timestamp);
 		if (err)
 			ndev->stats.rx_fifo_errors++;
@@ -592,7 +593,7 @@ static void bxcan_handle_bus_err(struct net_device *ndev, u32 esr)
 	if (skb) {
 		int err;
 
-		err = can_rx_offload_queue_timestamp(&priv->offload, skb,
+		err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb,
 						     priv->timestamp);
 		if (err)
 			ndev->stats.rx_fifo_errors++;
@@ -618,7 +619,7 @@ static irqreturn_t bxcan_state_change_isr(int irq, void *dev_id)
 
 	msr |= BXCAN_MSR_ERRI;
 	writel(msr, &regs->msr);
-	can_rx_offload_irq_finish(&priv->offload);
+	can_rx_offload_irq_finish(&priv->offload_irq);
 
 	return IRQ_HANDLED;
 }
@@ -1008,7 +1009,8 @@ static int bxcan_probe(struct platform_device *pdev)
 		CAN_CTRLMODE_LISTENONLY	| CAN_CTRLMODE_BERR_REPORTING;
 
 	priv->offload.mailbox_read = bxcan_mailbox_read;
-	err = can_rx_offload_add_fifo(ndev, &priv->offload, BXCAN_NAPI_WEIGHT);
+	err = can_rx_offload_add_fifo(ndev, &priv->offload,
+				      &priv->offload_irq, BXCAN_NAPI_WEIGHT);
 	if (err) {
 		dev_err(dev, "failed to add FIFO rx_offload\n");
 		goto out_free_candev;
diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 90f5e35f3c8f..6d505ac7d8b9 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -69,6 +69,7 @@ struct can327 {
 	struct can_priv can;
 
 	struct can_rx_offload offload;
+	struct can_rx_offload_irq offload_irq;
 
 	/* TTY buffers */
 	u8 txbuf[CAN327_SIZE_TXBUF];
@@ -272,11 +273,11 @@ static void can327_feed_frame_to_netdev(struct can327 *elm, struct sk_buff *skb)
 	/* Queue for NAPI pickup.
 	 * rx-offload will update stats and LEDs for us.
 	 */
-	if (can_rx_offload_queue_tail(&elm->offload, skb))
+	if (can_rx_offload_queue_tail(&elm->offload_irq, skb))
 		elm->dev->stats.rx_fifo_errors++;
 
 	/* Wake NAPI */
-	can_rx_offload_irq_finish(&elm->offload);
+	can_rx_offload_irq_finish(&elm->offload_irq);
 }
 
 /* Called when we're out of ideas and just want it all to end. */
@@ -772,7 +773,8 @@ static int can327_netdev_open(struct net_device *dev)
 	can327_init_device(elm);
 	spin_unlock_bh(&elm->lock);
 
-	err = can_rx_offload_add_manual(dev, &elm->offload, CAN327_NAPI_WEIGHT);
+	err = can_rx_offload_add_manual(dev, &elm->offload,
+					&elm->offload_irq, CAN327_NAPI_WEIGHT);
 	if (err) {
 		close_candev(dev);
 		return err;
diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index 46e7b6db4a1e..854be0b2c051 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -21,19 +21,19 @@ can_rx_offload_get_cb(struct sk_buff *skb)
 }
 
 static inline bool
-can_rx_offload_le(struct can_rx_offload *offload,
+can_rx_offload_le(struct can_rx_offload_irq *offload_irq,
 		  unsigned int a, unsigned int b)
 {
-	if (offload->inc)
+	if (offload_irq->inc)
 		return a <= b;
 	else
 		return a >= b;
 }
 
 static inline unsigned int
-can_rx_offload_inc(struct can_rx_offload *offload, unsigned int *val)
+can_rx_offload_inc(struct can_rx_offload_irq *offload_irq, unsigned int *val)
 {
-	if (offload->inc)
+	if (offload_irq->inc)
 		return (*val)++;
 	else
 		return (*val)--;
@@ -118,7 +118,7 @@ static int can_rx_offload_compare(struct sk_buff *a, struct sk_buff *b)
 
 /**
  * can_rx_offload_offload_one() - Read one CAN frame from HW
- * @offload: pointer to rx_offload context
+ * @offload_irq: pointer to rx_offload per-IRQ context
  * @n: number of mailbox to read
  *
  * The task of this function is to read a CAN frame from mailbox @n
@@ -126,9 +126,9 @@ static int can_rx_offload_compare(struct sk_buff *a, struct sk_buff *b)
  * sk_buff.
  *
  * If the struct can_rx_offload::skb_queue exceeds the maximal queue
- * length (struct can_rx_offload::skb_queue_len_max) or no skb can be
- * allocated, the mailbox contents is discarded by reading it into an
- * overflow buffer. This way the mailbox is marked as free by the
+ * length (struct can_rx_offload_irq::skb_queue_len_max) or no skb can
+ * be allocated, the mailbox contents is discarded by reading it into
+ * an overflow buffer. This way the mailbox is marked as free by the
  * driver.
  *
  * Return: A pointer to skb containing the CAN frame on success.
@@ -138,8 +138,10 @@ static int can_rx_offload_compare(struct sk_buff *a, struct sk_buff *b)
  *         ERR_PTR() in case of an error
  */
 static struct sk_buff *
-can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
+can_rx_offload_offload_one(struct can_rx_offload_irq *offload_irq,
+			   unsigned int n)
 {
+	struct can_rx_offload *offload = offload_irq->offload;
 	struct sk_buff *skb;
 	struct can_rx_offload_cb *cb;
 	bool drop = false;
@@ -147,7 +149,7 @@ can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
 
 	/* If queue is full drop frame */
 	if (unlikely(skb_queue_len(&offload->skb_queue) >
-		     offload->skb_queue_len_max))
+		     offload_irq->skb_queue_len_max))
 		drop = true;
 
 	skb = offload->mailbox_read(offload, n, &timestamp, drop);
@@ -172,25 +174,25 @@ can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
 	return skb;
 }
 
-int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
+int can_rx_offload_irq_offload_timestamp(struct can_rx_offload_irq *offload_irq,
 					 u64 pending)
 {
 	unsigned int i;
 	int received = 0;
 
-	for (i = offload->mb_first;
-	     can_rx_offload_le(offload, i, offload->mb_last);
-	     can_rx_offload_inc(offload, &i)) {
+	for (i = offload_irq->mb_first;
+	     can_rx_offload_le(offload_irq, i, offload_irq->mb_last);
+	     can_rx_offload_inc(offload_irq, &i)) {
 		struct sk_buff *skb;
 
 		if (!(pending & BIT_ULL(i)))
 			continue;
 
-		skb = can_rx_offload_offload_one(offload, i);
+		skb = can_rx_offload_offload_one(offload_irq, i);
 		if (IS_ERR_OR_NULL(skb))
 			continue;
 
-		__skb_queue_add_sort(&offload->skb_irq_queue, skb,
+		__skb_queue_add_sort(&offload_irq->skb_irq_queue, skb,
 				     can_rx_offload_compare);
 		received++;
 	}
@@ -199,19 +201,19 @@ int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_timestamp);
 
-int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
+int can_rx_offload_irq_offload_fifo(struct can_rx_offload_irq *offload_irq)
 {
 	struct sk_buff *skb;
 	int received = 0;
 
 	while (1) {
-		skb = can_rx_offload_offload_one(offload, 0);
+		skb = can_rx_offload_offload_one(offload_irq, 0);
 		if (IS_ERR(skb))
 			continue;
 		if (!skb)
 			break;
 
-		__skb_queue_tail(&offload->skb_irq_queue, skb);
+		__skb_queue_tail(&offload_irq->skb_irq_queue, skb);
 		received++;
 	}
 
@@ -219,13 +221,14 @@ int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_fifo);
 
-int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
+int can_rx_offload_queue_timestamp(struct can_rx_offload_irq *offload_irq,
 				   struct sk_buff *skb, u32 timestamp)
 {
+	struct can_rx_offload *offload = offload_irq->offload;
 	struct can_rx_offload_cb *cb;
 
 	if (skb_queue_len(&offload->skb_queue) >
-	    offload->skb_queue_len_max) {
+	    offload_irq->skb_queue_len_max) {
 		dev_kfree_skb_any(skb);
 		return -ENOBUFS;
 	}
@@ -233,7 +236,7 @@ int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
 	cb = can_rx_offload_get_cb(skb);
 	cb->timestamp = timestamp;
 
-	__skb_queue_add_sort(&offload->skb_irq_queue, skb,
+	__skb_queue_add_sort(&offload_irq->skb_irq_queue, skb,
 			     can_rx_offload_compare);
 
 	return 0;
@@ -241,11 +244,11 @@ int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
 EXPORT_SYMBOL_GPL(can_rx_offload_queue_timestamp);
 
 unsigned int
-can_rx_offload_get_echo_skb_queue_timestamp(struct can_rx_offload *offload,
+can_rx_offload_get_echo_skb_queue_timestamp(struct can_rx_offload_irq *offload_irq,
 					    unsigned int idx, u32 timestamp,
 					    unsigned int *frame_len_ptr)
 {
-	struct net_device *dev = offload->dev;
+	struct net_device *dev = offload_irq->offload->dev;
 	struct net_device_stats *stats = &dev->stats;
 	struct sk_buff *skb;
 	unsigned int len;
@@ -255,7 +258,7 @@ can_rx_offload_get_echo_skb_queue_timestamp(struct can_rx_offload *offload,
 	if (!skb)
 		return 0;
 
-	err = can_rx_offload_queue_timestamp(offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(offload_irq, skb, timestamp);
 	if (err) {
 		stats->rx_errors++;
 		stats->tx_fifo_errors++;
@@ -265,27 +268,29 @@ can_rx_offload_get_echo_skb_queue_timestamp(struct can_rx_offload *offload,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_timestamp);
 
-int can_rx_offload_queue_tail(struct can_rx_offload *offload,
+int can_rx_offload_queue_tail(struct can_rx_offload_irq *offload_irq,
 			      struct sk_buff *skb)
 {
+	struct can_rx_offload *offload = offload_irq->offload;
+
 	if (skb_queue_len(&offload->skb_queue) >
-	    offload->skb_queue_len_max) {
+	    offload_irq->skb_queue_len_max) {
 		dev_kfree_skb_any(skb);
 		return -ENOBUFS;
 	}
 
-	__skb_queue_tail(&offload->skb_irq_queue, skb);
+	__skb_queue_tail(&offload_irq->skb_irq_queue, skb);
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_queue_tail);
 
 unsigned int
-can_rx_offload_get_echo_skb_queue_tail(struct can_rx_offload *offload,
+can_rx_offload_get_echo_skb_queue_tail(struct can_rx_offload_irq *offload_irq,
 				       unsigned int idx,
 				       unsigned int *frame_len_ptr)
 {
-	struct net_device *dev = offload->dev;
+	struct net_device *dev = offload_irq->offload->dev;
 	struct net_device_stats *stats = &dev->stats;
 	struct sk_buff *skb;
 	unsigned int len;
@@ -295,7 +300,7 @@ can_rx_offload_get_echo_skb_queue_tail(struct can_rx_offload *offload,
 	if (!skb)
 		return 0;
 
-	err = can_rx_offload_queue_tail(offload, skb);
+	err = can_rx_offload_queue_tail(offload_irq, skb);
 	if (err) {
 		stats->rx_errors++;
 		stats->tx_fifo_errors++;
@@ -305,20 +310,44 @@ can_rx_offload_get_echo_skb_queue_tail(struct can_rx_offload *offload,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_tail);
 
-void can_rx_offload_irq_finish(struct can_rx_offload *offload)
+static void
+can_rx_offload_move_to_skb_queue(struct can_rx_offload_irq *offload_irq)
 {
+	struct can_rx_offload *offload = offload_irq->offload;
 	unsigned long flags;
+
+	spin_lock_irqsave(&offload->skb_queue.lock, flags);
+
+	if (offload->irq_cnt > 1 && offload->sort) {
+		/* Merge this IRQ's sorted queue into skb_queue to keep the
+		 * overall timestamp order.
+		 */
+		struct sk_buff *skb;
+
+		while ((skb = __skb_dequeue(&offload_irq->skb_irq_queue)))
+			__skb_queue_add_sort(&offload->skb_queue, skb,
+					     can_rx_offload_compare);
+	} else {
+		/* Single producer, or no timestamp to sort by. */
+		skb_queue_splice_tail_init(&offload_irq->skb_irq_queue,
+					   &offload->skb_queue);
+	}
+
+	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
+}
+
+void can_rx_offload_irq_finish(struct can_rx_offload_irq *offload_irq)
+{
+	struct can_rx_offload *offload = offload_irq->offload;
 	int queue_len;
 
-	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
+	if (skb_queue_empty_lockless(&offload_irq->skb_irq_queue))
 		return;
 
-	spin_lock_irqsave(&offload->skb_queue.lock, flags);
-	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue);
-	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
+	can_rx_offload_move_to_skb_queue(offload_irq);
 
 	queue_len = skb_queue_len(&offload->skb_queue);
-	if (queue_len > offload->skb_queue_len_max / 8)
+	if (queue_len > offload_irq->skb_queue_len_max / 8)
 		netdev_dbg(offload->dev, "%s: queue_len=%d\n",
 			   __func__, queue_len);
 
@@ -326,20 +355,18 @@ void can_rx_offload_irq_finish(struct can_rx_offload *offload)
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_irq_finish);
 
-void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
+void can_rx_offload_threaded_irq_finish(struct can_rx_offload_irq *offload_irq)
 {
-	unsigned long flags;
+	struct can_rx_offload *offload = offload_irq->offload;
 	int queue_len;
 
-	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
+	if (skb_queue_empty_lockless(&offload_irq->skb_irq_queue))
 		return;
 
-	spin_lock_irqsave(&offload->skb_queue.lock, flags);
-	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue);
-	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
+	can_rx_offload_move_to_skb_queue(offload_irq);
 
 	queue_len = skb_queue_len(&offload->skb_queue);
-	if (queue_len > offload->skb_queue_len_max / 8)
+	if (queue_len > offload_irq->skb_queue_len_max / 8)
 		netdev_dbg(offload->dev, "%s: queue_len=%d\n",
 			   __func__, queue_len);
 
@@ -351,64 +378,88 @@ EXPORT_SYMBOL_GPL(can_rx_offload_threaded_irq_finish);
 
 static int can_rx_offload_init_queue(struct net_device *dev,
 				     struct can_rx_offload *offload,
+				     struct can_rx_offload_irq *offload_irq,
 				     unsigned int weight)
 {
-	offload->dev = dev;
-
-	/* Limit queue len to 4x the weight (rounded to next power of two) */
-	offload->skb_queue_len_max = 2 << fls(weight);
-	offload->skb_queue_len_max *= 4;
-	skb_queue_head_init(&offload->skb_queue);
-	__skb_queue_head_init(&offload->skb_irq_queue);
+	struct can_rx_offload_irq *pos;
+	u32 skb_queue_len_max;
+
+	offload_irq->offload = offload;
+	__skb_queue_head_init(&offload_irq->skb_irq_queue);
+
+	/* The first registered IRQ initializes the shared state. */
+	if (!offload->irq_cnt) {
+		offload->dev = dev;
+		skb_queue_head_init(&offload->skb_queue);
+		INIT_LIST_HEAD(&offload->irqs);
+		netif_napi_add_weight(dev, &offload->napi,
+				      can_rx_offload_napi_poll, weight);
+	} else if (weight > offload->napi.weight) {
+		/* All contexts feed the same NAPI, keep the largest weight. */
+		offload->napi.weight = weight;
+	}
+	list_add_tail(&offload_irq->node, &offload->irqs);
+	offload->irq_cnt++;
 
-	netif_napi_add_weight(dev, &offload->napi, can_rx_offload_napi_poll,
-			      weight);
+	/* Limit queue len to 4x the weight (rounded to next power of two).
+	 * All contexts feed the same skb_queue, so they share its limit.
+	 */
+	skb_queue_len_max = 2 << fls(offload->napi.weight);
+	skb_queue_len_max *= 4;
+	list_for_each_entry(pos, &offload->irqs, node)
+		pos->skb_queue_len_max = skb_queue_len_max;
 
 	dev_dbg(dev->dev.parent, "%s: skb_queue_len_max=%d\n",
-		__func__, offload->skb_queue_len_max);
+		__func__, skb_queue_len_max);
 
 	return 0;
 }
 
 int can_rx_offload_add_timestamp(struct net_device *dev,
-				 struct can_rx_offload *offload)
+				 struct can_rx_offload *offload,
+				 struct can_rx_offload_irq *offload_irq)
 {
 	unsigned int weight;
 
-	if (offload->mb_first > BITS_PER_LONG_LONG ||
-	    offload->mb_last > BITS_PER_LONG_LONG || !offload->mailbox_read)
+	if (offload_irq->mb_first > BITS_PER_LONG_LONG ||
+	    offload_irq->mb_last > BITS_PER_LONG_LONG || !offload->mailbox_read)
 		return -EINVAL;
 
-	if (offload->mb_first < offload->mb_last) {
-		offload->inc = true;
-		weight = offload->mb_last - offload->mb_first;
+	if (offload_irq->mb_first < offload_irq->mb_last) {
+		offload_irq->inc = true;
+		weight = offload_irq->mb_last - offload_irq->mb_first;
 	} else {
-		offload->inc = false;
-		weight = offload->mb_first - offload->mb_last;
+		offload_irq->inc = false;
+		weight = offload_irq->mb_first - offload_irq->mb_last;
 	}
 
-	return can_rx_offload_init_queue(dev, offload, weight);
+	offload->sort = true;
+
+	return can_rx_offload_init_queue(dev, offload, offload_irq, weight);
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_add_timestamp);
 
 int can_rx_offload_add_fifo(struct net_device *dev,
-			    struct can_rx_offload *offload, unsigned int weight)
+			    struct can_rx_offload *offload,
+			    struct can_rx_offload_irq *offload_irq,
+			    unsigned int weight)
 {
 	if (!offload->mailbox_read)
 		return -EINVAL;
 
-	return can_rx_offload_init_queue(dev, offload, weight);
+	return can_rx_offload_init_queue(dev, offload, offload_irq, weight);
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_add_fifo);
 
 int can_rx_offload_add_manual(struct net_device *dev,
 			      struct can_rx_offload *offload,
+			      struct can_rx_offload_irq *offload_irq,
 			      unsigned int weight)
 {
 	if (offload->mailbox_read)
 		return -EINVAL;
 
-	return can_rx_offload_init_queue(dev, offload, weight);
+	return can_rx_offload_init_queue(dev, offload, offload_irq, weight);
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_add_manual);
 
@@ -420,8 +471,19 @@ EXPORT_SYMBOL_GPL(can_rx_offload_enable);
 
 void can_rx_offload_del(struct can_rx_offload *offload)
 {
+	struct can_rx_offload_irq *offload_irq, *tmp;
+
 	netif_napi_del(&offload->napi);
 	skb_queue_purge(&offload->skb_queue);
-	__skb_queue_purge(&offload->skb_irq_queue);
+
+	/* Drop the contexts, so that re-adding them (e.g. on the next
+	 * ndo_open()) initializes the shared state again.
+	 */
+	list_for_each_entry_safe(offload_irq, tmp, &offload->irqs, node) {
+		__skb_queue_purge(&offload_irq->skb_irq_queue);
+		list_del_init(&offload_irq->node);
+	}
+	offload->irq_cnt = 0;
+	offload->sort = false;
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_del);
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..a81132d3afa8 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -885,7 +885,7 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	if (tx_errors)
 		dev->stats.tx_errors++;
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, timestamp);
 	if (err)
 		dev->stats.rx_fifo_errors++;
 }
@@ -932,7 +932,7 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
 	if (unlikely(new_state == CAN_STATE_BUS_OFF))
 		can_bus_off(dev);
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, timestamp);
 	if (err)
 		dev->stats.rx_fifo_errors++;
 }
@@ -1088,7 +1088,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv))) {
 			handled = IRQ_HANDLED;
-			ret = can_rx_offload_irq_offload_timestamp(&priv->offload,
+			ret = can_rx_offload_irq_offload_timestamp(&priv->offload_irq,
 								   reg_iflag_rx);
 			if (!ret)
 				break;
@@ -1099,7 +1099,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		reg_iflag1 = priv->read(&regs->iflag1);
 		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) {
 			handled = IRQ_HANDLED;
-			can_rx_offload_irq_offload_fifo(&priv->offload);
+			can_rx_offload_irq_offload_fifo(&priv->offload_irq);
 		}
 
 		/* FIFO overflow interrupt */
@@ -1120,7 +1120,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 		handled = IRQ_HANDLED;
 		stats->tx_bytes +=
-			can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload, 0,
+			can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload_irq, 0,
 								    reg_ctrl << 16, NULL);
 		stats->tx_packets++;
 
@@ -1189,7 +1189,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	}
 
 	if (handled)
-		can_rx_offload_irq_finish(&priv->offload);
+		can_rx_offload_irq_finish(&priv->offload_irq);
 
 	return handled;
 }
@@ -1410,16 +1410,18 @@ static int flexcan_rx_offload_setup(struct net_device *dev)
 	priv->offload.mailbox_read = flexcan_mailbox_read;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
-		priv->offload.mb_first = FLEXCAN_RX_MB_RX_MAILBOX_FIRST;
-		priv->offload.mb_last = priv->mb_count - 2;
+		priv->offload_irq.mb_first = FLEXCAN_RX_MB_RX_MAILBOX_FIRST;
+		priv->offload_irq.mb_last = priv->mb_count - 2;
 
-		priv->rx_mask = GENMASK_ULL(priv->offload.mb_last,
-					    priv->offload.mb_first);
-		err = can_rx_offload_add_timestamp(dev, &priv->offload);
+		priv->rx_mask = GENMASK_ULL(priv->offload_irq.mb_last,
+					    priv->offload_irq.mb_first);
+		err = can_rx_offload_add_timestamp(dev, &priv->offload,
+						   &priv->offload_irq);
 	} else {
 		priv->rx_mask = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
 			FLEXCAN_IFLAG_RX_FIFO_AVAILABLE;
 		err = can_rx_offload_add_fifo(dev, &priv->offload,
+					      &priv->offload_irq,
 					      FLEXCAN_NAPI_WEIGHT);
 	}
 
@@ -1600,7 +1602,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	}
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
-		for (i = priv->offload.mb_first; i <= priv->offload.mb_last; i++) {
+		for (i = priv->offload_irq.mb_first; i <= priv->offload_irq.mb_last; i++) {
 			mb = flexcan_get_mb(priv, i);
 			priv->write(FLEXCAN_MB_CODE_RX_EMPTY,
 				    &mb->can_ctrl);
diff --git a/drivers/net/can/flexcan/flexcan-ethtool.c b/drivers/net/can/flexcan/flexcan-ethtool.c
index 50e86b2da532..e34afafbbd54 100644
--- a/drivers/net/can/flexcan/flexcan-ethtool.c
+++ b/drivers/net/can/flexcan/flexcan-ethtool.c
@@ -28,8 +28,8 @@ flexcan_get_ringparam(struct net_device *ndev, struct ethtool_ringparam *ring,
 	ring->tx_max_pending = priv->mb_count;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX)
-		ring->rx_pending = priv->offload.mb_last -
-			priv->offload.mb_first + 1;
+		ring->rx_pending = priv->offload_irq.mb_last -
+			priv->offload_irq.mb_first + 1;
 	else
 		ring->rx_pending = 6;	/* RX-FIFO depth is fixed */
 
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 16692a2502eb..90f9c2b9fed8 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -88,6 +88,7 @@ struct flexcan_stop_mode {
 struct flexcan_priv {
 	struct can_priv can;
 	struct can_rx_offload offload;
+	struct can_rx_offload_irq offload_irq;
 	struct device *dev;
 
 	struct flexcan_regs __iomem *regs;
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16f80607e150..be66c52a09ff 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -543,7 +543,7 @@ static void m_can_receive_skb(struct m_can_classdev *cdev,
 		struct net_device_stats *stats = &cdev->net->stats;
 		int err;
 
-		err = can_rx_offload_queue_timestamp(&cdev->offload, skb,
+		err = can_rx_offload_queue_timestamp(&cdev->offload_irq, skb,
 						     timestamp);
 		if (err)
 			stats->rx_fifo_errors++;
@@ -1100,7 +1100,7 @@ static unsigned int m_can_tx_update_stats(struct m_can_classdev *cdev,
 
 	if (cdev->is_peripheral)
 		stats->tx_bytes +=
-			can_rx_offload_get_echo_skb_queue_timestamp(&cdev->offload,
+			can_rx_offload_get_echo_skb_queue_timestamp(&cdev->offload_irq,
 								    msg_mark,
 								    timestamp,
 								    &frame_len);
@@ -1303,7 +1303,7 @@ static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 	}
 
 	if (cdev->is_peripheral)
-		can_rx_offload_threaded_irq_finish(&cdev->offload);
+		can_rx_offload_threaded_irq_finish(&cdev->offload_irq);
 
 	return IRQ_HANDLED;
 }
@@ -2535,6 +2535,7 @@ int m_can_class_register(struct m_can_classdev *cdev)
 
 	if (cdev->is_peripheral) {
 		ret = can_rx_offload_add_manual(cdev->net, &cdev->offload,
+						&cdev->offload_irq,
 						NAPI_POLL_WEIGHT);
 		if (ret)
 			goto out_reset_control_assert;
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 4743342b2fba..dfec64aeffa5 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -81,6 +81,7 @@ struct m_can_tx_op {
 struct m_can_classdev {
 	struct can_priv can;
 	struct can_rx_offload offload;
+	struct can_rx_offload_irq offload_irq;
 	struct napi_struct napi;
 	struct net_device *net;
 	struct device *dev;
diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 37c1c22c40c9..db4fa0c8a171 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -563,7 +563,7 @@ static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
 	if (!cf)
 		return 0;
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, timestamp);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -608,7 +608,7 @@ static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
 		cf->data[7] = bec.rxerr;
 	}
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, timestamp);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -641,7 +641,7 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
 	cf->data[6] = bec.txerr;
 	cf->data[7] = bec.rxerr;
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, timestamp);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -715,7 +715,7 @@ static irqreturn_t rkcanfd_irq(int irq, void *dev_id)
 	if (reg_int & RKCANFD_REG_INT_OVERLOAD_INT)
 		netdev_info(priv->ndev, "%s: OVERLOAD_INT\n", __func__);
 
-	can_rx_offload_irq_finish(&priv->offload);
+	can_rx_offload_irq_finish(&priv->offload_irq);
 
 	return IRQ_HANDLED;
 }
@@ -930,6 +930,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	}
 
 	err = can_rx_offload_add_manual(ndev, &priv->offload,
+					&priv->offload_irq,
 					RKCANFD_NAPI_WEIGHT);
 	if (err)
 		goto out_free_candev;
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 24e87daa1df0..85af71cc60f2 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -269,7 +269,7 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 	memcpy(skb_cfd, cfd, len);
 	rkcanfd_skb_set_timestamp(priv, skb, header->ts);
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, header->ts);
+	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, header->ts);
 	if (err)
 		stats->rx_fifo_errors++;
 
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 12200dcfd338..3cfbdb2b8373 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -160,7 +160,7 @@ void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
 	if (skb)
 		rkcanfd_skb_set_timestamp(priv, skb, ts);
 	stats->tx_bytes +=
-		can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload,
+		can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload_irq,
 							    tx_tail, ts,
 							    frame_len_p);
 	stats->tx_packets++;
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 95bea9bfd8a2..6b4cdbaffe4a 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -472,6 +472,7 @@ struct rkcanfd_stats {
 struct rkcanfd_priv {
 	struct can_priv can;
 	struct can_rx_offload offload;
+	struct can_rx_offload_irq offload_irq;
 	struct net_device *ndev;
 
 	void __iomem *regs;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index f441f2265299..e4ad461cd9e8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -972,7 +972,7 @@ static int mcp251xfd_handle_rxovif(struct mcp251xfd_priv *priv)
 	cf->can_id |= CAN_ERR_CRTL;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, ts_raw);
+	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, ts_raw);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -1077,7 +1077,7 @@ static int mcp251xfd_handle_ivmif(struct mcp251xfd_priv *priv)
 		return 0;
 
 	mcp251xfd_skb_set_timestamp_raw(priv, skb, ts_raw);
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, ts_raw);
+	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, ts_raw);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -1151,7 +1151,7 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
 		cf->data[7] = bec.rxerr;
 	}
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, ts_raw);
+	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, ts_raw);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -1515,7 +1515,7 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
 				  priv->regs_status.intf);
 
 		if (!(intf_pending)) {
-			can_rx_offload_threaded_irq_finish(&priv->offload);
+			can_rx_offload_threaded_irq_finish(&priv->offload_irq);
 			return handled;
 		}
 
@@ -1610,7 +1610,7 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
 			 * directly.
 			 */
 			if (priv->can.state == CAN_STATE_BUS_OFF) {
-				can_rx_offload_threaded_irq_finish(&priv->offload);
+				can_rx_offload_threaded_irq_finish(&priv->offload_irq);
 				return IRQ_HANDLED;
 			}
 		}
@@ -1619,7 +1619,7 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
 	} while (1);
 
 out_fail:
-	can_rx_offload_threaded_irq_finish(&priv->offload);
+	can_rx_offload_threaded_irq_finish(&priv->offload_irq);
 
 	netdev_err(priv->ndev, "IRQ handler returned %d (intf=0x%08x).\n",
 		   err, priv->regs_status.intf);
@@ -2358,6 +2358,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 		goto out_free_candev;
 
 	err = can_rx_offload_add_manual(ndev, &priv->offload,
+					&priv->offload_irq,
 					MCP251XFD_NAPI_WEIGHT);
 	if (err)
 		goto out_free_candev;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
index fe897f3e4c12..8c5a371bcf61 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
@@ -201,7 +201,7 @@ mcp251xfd_handle_rxif_one(struct mcp251xfd_priv *priv,
 
 	mcp251xfd_skb_set_timestamp(skb, timestamp);
 	mcp251xfd_hw_rx_obj_to_skb(priv, hw_rx_obj, skb);
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, hw_rx_obj->ts);
+	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, hw_rx_obj->ts);
 	if (err)
 		stats->rx_fifo_errors++;
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index e94321849fd7..752068691958 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -104,7 +104,7 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 	if (skb)
 		mcp251xfd_skb_set_timestamp_raw(priv, skb, hw_tef_obj->ts);
 	stats->tx_bytes +=
-		can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload,
+		can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload_irq,
 							    tef_tail, hw_tef_obj->ts,
 							    frame_len_ptr);
 	stats->tx_packets++;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index d3f4704e2678..0706bc5459be 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -624,6 +624,7 @@ enum mcp251xfd_flags {
 struct mcp251xfd_priv {
 	struct can_priv can;
 	struct can_rx_offload offload;
+	struct can_rx_offload_irq offload_irq;
 	struct net_device *ndev;
 
 	struct regmap *map_reg;			/* register access */
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 1d3dbf28b105..bf7a2df0435a 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -177,6 +177,7 @@ static const struct can_bittiming_const ti_hecc_bittiming_const = {
 struct ti_hecc_priv {
 	struct can_priv can;	/* MUST be first member/field */
 	struct can_rx_offload offload;
+	struct can_rx_offload_irq offload_irq;
 	struct net_device *ndev;
 	struct clk *clk;
 	void __iomem *base;
@@ -623,7 +624,7 @@ static int ti_hecc_error(struct net_device *ndev, int int_status,
 			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
 
 		timestamp = hecc_read(priv, HECC_CANLNT);
-		err = can_rx_offload_queue_timestamp(&priv->offload, skb,
+		err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb,
 						     timestamp);
 		if (err)
 			ndev->stats.rx_fifo_errors++;
@@ -659,7 +660,7 @@ static void ti_hecc_change_state(struct net_device *ndev,
 	}
 
 	timestamp = hecc_read(priv, HECC_CANLNT);
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload_irq, skb, timestamp);
 	if (err)
 		ndev->stats.rx_fifo_errors++;
 }
@@ -747,7 +748,7 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 			spin_unlock_irqrestore(&priv->mbx_lock, flags);
 			stamp = hecc_read_stamp(priv, mbxno);
 			stats->tx_bytes +=
-				can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload,
+				can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload_irq,
 									    mbxno, stamp, NULL);
 			stats->tx_packets++;
 			--priv->tx_tail;
@@ -762,7 +763,7 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 
 		/* offload RX mailboxes and let NAPI deliver them */
 		while ((rx_pending = hecc_read(priv, HECC_CANRMP))) {
-			can_rx_offload_irq_offload_timestamp(&priv->offload,
+			can_rx_offload_irq_offload_timestamp(&priv->offload_irq,
 							     rx_pending);
 		}
 	}
@@ -776,7 +777,7 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 		int_status = hecc_read(priv, HECC_CANGIF0);
 	}
 
-	can_rx_offload_irq_finish(&priv->offload);
+	can_rx_offload_irq_finish(&priv->offload_irq);
 
 	return IRQ_HANDLED;
 }
@@ -930,9 +931,10 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	}
 
 	priv->offload.mailbox_read = ti_hecc_mailbox_read;
-	priv->offload.mb_first = HECC_RX_FIRST_MBOX;
-	priv->offload.mb_last = HECC_RX_LAST_MBOX;
-	err = can_rx_offload_add_timestamp(ndev, &priv->offload);
+	priv->offload_irq.mb_first = HECC_RX_FIRST_MBOX;
+	priv->offload_irq.mb_last = HECC_RX_LAST_MBOX;
+	err = can_rx_offload_add_timestamp(ndev, &priv->offload,
+					   &priv->offload_irq);
 	if (err) {
 		dev_err(&pdev->dev, "can_rx_offload_add_timestamp() failed\n");
 		goto probe_exit_disable_clk;
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3b9b2f104d86..db9c17642131 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -305,6 +305,7 @@ struct gs_can {
 	struct can_priv can; /* must be the first member */
 
 	struct can_rx_offload offload;
+	struct can_rx_offload_irq offload_irq;
 	struct gs_usb *parent;
 
 	struct net_device *netdev;
@@ -539,15 +540,15 @@ static u32 gs_usb_set_timestamp(struct gs_can *dev, struct sk_buff *skb,
 static void gs_usb_rx_offload(struct gs_can *dev, struct sk_buff *skb,
 			      const struct gs_host_frame *hf)
 {
-	struct can_rx_offload *offload = &dev->offload;
+	struct can_rx_offload_irq *offload_irq = &dev->offload_irq;
 	int rc;
 
 	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
 		const u32 ts = gs_usb_set_timestamp(dev, skb, hf);
 
-		rc = can_rx_offload_queue_timestamp(offload, skb, ts);
+		rc = can_rx_offload_queue_timestamp(offload_irq, skb, ts);
 	} else {
-		rc = can_rx_offload_queue_tail(offload, skb);
+		rc = can_rx_offload_queue_tail(offload_irq, skb);
 	}
 
 	if (rc)
@@ -558,18 +559,19 @@ static unsigned int
 gs_usb_get_echo_skb(struct gs_can *dev, struct sk_buff *skb,
 		    const struct gs_host_frame *hf)
 {
-	struct can_rx_offload *offload = &dev->offload;
+	struct can_rx_offload_irq *offload_irq = &dev->offload_irq;
 	const u32 echo_id = hf->echo_id;
 	unsigned int len;
 
 	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
 		const u32 ts = gs_usb_set_timestamp(dev, skb, hf);
 
-		len = can_rx_offload_get_echo_skb_queue_timestamp(offload, echo_id,
-								  ts, NULL);
+		len = can_rx_offload_get_echo_skb_queue_timestamp(offload_irq,
+								  echo_id, ts,
+								  NULL);
 	} else {
-		len = can_rx_offload_get_echo_skb_queue_tail(offload, echo_id,
-							     NULL);
+		len = can_rx_offload_get_echo_skb_queue_tail(offload_irq,
+							     echo_id, NULL);
 	}
 
 	return len;
@@ -743,7 +745,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		gs_usb_rx_offload(dev, skb, hf);
 	}
 
-	can_rx_offload_irq_finish(&dev->offload);
+	can_rx_offload_irq_finish(&dev->offload_irq);
 
 resubmit_urb:
 	usb_fill_bulk_urb(urb, parent->udev,
@@ -1487,7 +1489,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->can.fd.data_bittiming_const = &dev->data_bt_const;
 	}
 
-	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
+	can_rx_offload_add_manual(netdev, &dev->offload,
+				  &dev->offload_irq, GS_NAPI_WEIGHT);
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
 	rc = register_candev(dev->netdev);
diff --git a/drivers/net/can/usb/nct6694_canfd.c b/drivers/net/can/usb/nct6694_canfd.c
index e5f7f8849a73..7d0360708b93 100644
--- a/drivers/net/can/usb/nct6694_canfd.c
+++ b/drivers/net/can/usb/nct6694_canfd.c
@@ -133,6 +133,7 @@ struct __packed nct6694_canfd_frame {
 struct nct6694_canfd_priv {
 	struct can_priv can;	/* must be the first member */
 	struct can_rx_offload offload;
+	struct can_rx_offload_irq offload_irq;
 	struct net_device *ndev;
 	struct nct6694 *nct6694;
 	struct workqueue_struct *wq;
@@ -172,13 +173,13 @@ static const struct can_bittiming_const nct6694_canfd_bittiming_data_const = {
 	.brp_inc = 1,
 };
 
-static void nct6694_canfd_rx_offload(struct can_rx_offload *offload,
+static void nct6694_canfd_rx_offload(struct can_rx_offload_irq *offload_irq,
 				     struct sk_buff *skb)
 {
-	struct nct6694_canfd_priv *priv = rx_offload_to_priv(offload);
+	struct nct6694_canfd_priv *priv = rx_offload_to_priv(offload_irq->offload);
 	int ret;
 
-	ret = can_rx_offload_queue_tail(offload, skb);
+	ret = can_rx_offload_queue_tail(offload_irq, skb);
 	if (ret)
 		priv->ndev->stats.rx_fifo_errors++;
 }
@@ -202,7 +203,7 @@ static void nct6694_canfd_handle_lost_msg(struct net_device *ndev)
 	cf->can_id |= CAN_ERR_CRTL;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	nct6694_canfd_rx_offload(&priv->offload, skb);
+	nct6694_canfd_rx_offload(&priv->offload_irq, skb);
 }
 
 static void nct6694_canfd_handle_rx(struct net_device *ndev, u8 rx_evt)
@@ -262,7 +263,7 @@ static void nct6694_canfd_handle_rx(struct net_device *ndev, u8 rx_evt)
 			memcpy(cf->data, frame->data, cf->len);
 	}
 
-	nct6694_canfd_rx_offload(&priv->offload, skb);
+	nct6694_canfd_rx_offload(&priv->offload_irq, skb);
 }
 
 static int nct6694_canfd_get_berr_counter(const struct net_device *ndev,
@@ -305,7 +306,7 @@ static void nct6694_canfd_handle_state_change(struct net_device *ndev, u8 status
 	}
 
 	if (skb)
-		nct6694_canfd_rx_offload(&priv->offload, skb);
+		nct6694_canfd_rx_offload(&priv->offload_irq, skb);
 }
 
 static void nct6694_canfd_handle_bus_err(struct net_device *ndev, u8 bus_err)
@@ -363,7 +364,7 @@ static void nct6694_canfd_handle_bus_err(struct net_device *ndev, u8 bus_err)
 	}
 
 	if (skb)
-		nct6694_canfd_rx_offload(&priv->offload, skb);
+		nct6694_canfd_rx_offload(&priv->offload_irq, skb);
 }
 
 static void nct6694_canfd_handle_tx(struct net_device *ndev)
@@ -371,7 +372,7 @@ static void nct6694_canfd_handle_tx(struct net_device *ndev)
 	struct nct6694_canfd_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
 
-	stats->tx_bytes += can_rx_offload_get_echo_skb_queue_tail(&priv->offload,
+	stats->tx_bytes += can_rx_offload_get_echo_skb_queue_tail(&priv->offload_irq,
 								  0, NULL);
 	stats->tx_packets++;
 	netif_wake_queue(ndev);
@@ -422,7 +423,7 @@ static irqreturn_t nct6694_canfd_irq(int irq, void *data)
 	}
 
 	if (handled)
-		can_rx_offload_threaded_irq_finish(&priv->offload);
+		can_rx_offload_threaded_irq_finish(&priv->offload_irq);
 
 	priv->bec.rxerr = event->rec;
 	priv->bec.txerr = event->tec;
@@ -775,6 +776,7 @@ static int nct6694_canfd_probe(struct platform_device *pdev)
 		goto free_candev;
 
 	ret = can_rx_offload_add_manual(ndev, &priv->offload,
+					&priv->offload_irq,
 					NCT6694_NAPI_WEIGHT);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret, "Failed to add rx_offload\n");
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index d29bb4521947..6f9a5739ecf5 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -20,40 +20,66 @@ struct can_rx_offload {
 					bool drop);
 
 	struct sk_buff_head skb_queue;
+
+	/* Registered per-IRQ contexts, only changed on add/del. A single
+	 * context lets the finish path splice, more than one makes it sort
+	 * the skbs into skb_queue.
+	 */
+	struct list_head irqs;
+	unsigned int irq_cnt;
+
+	/* Set if the queued skbs carry a timestamp to sort them by. */
+	bool sort;
+
+	/* weight is the largest one over the registered per-IRQ contexts */
+	struct napi_struct napi;
+};
+
+/* Per-IRQ receive context, one per IRQ line producing RX frames.
+ * skb_irq_queue has a single producer, so it needs no lock. The finish
+ * helpers move the skbs into can_rx_offload::skb_queue under its lock.
+ */
+struct can_rx_offload_irq {
+	struct can_rx_offload *offload;
+
 	struct sk_buff_head skb_irq_queue;
 	u32 skb_queue_len_max;
 
 	unsigned int mb_first;
 	unsigned int mb_last;
 
-	struct napi_struct napi;
-
 	bool inc;
+
+	/* entry on can_rx_offload::irqs */
+	struct list_head node;
 };
 
 int can_rx_offload_add_timestamp(struct net_device *dev,
-				 struct can_rx_offload *offload);
+				 struct can_rx_offload *offload,
+				 struct can_rx_offload_irq *offload_irq);
 int can_rx_offload_add_fifo(struct net_device *dev,
 			    struct can_rx_offload *offload,
+			    struct can_rx_offload_irq *offload_irq,
 			    unsigned int weight);
 int can_rx_offload_add_manual(struct net_device *dev,
 			      struct can_rx_offload *offload,
+			      struct can_rx_offload_irq *offload_irq,
 			      unsigned int weight);
-int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
+int can_rx_offload_irq_offload_timestamp(struct can_rx_offload_irq *offload_irq,
 					 u64 reg);
-int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload);
-int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
+int can_rx_offload_irq_offload_fifo(struct can_rx_offload_irq *offload_irq);
+int can_rx_offload_queue_timestamp(struct can_rx_offload_irq *offload_irq,
 				   struct sk_buff *skb, u32 timestamp);
-unsigned int can_rx_offload_get_echo_skb_queue_timestamp(struct can_rx_offload *offload,
+unsigned int can_rx_offload_get_echo_skb_queue_timestamp(struct can_rx_offload_irq *offload_irq,
 							 unsigned int idx, u32 timestamp,
 							 unsigned int *frame_len_ptr);
-int can_rx_offload_queue_tail(struct can_rx_offload *offload,
+int can_rx_offload_queue_tail(struct can_rx_offload_irq *offload_irq,
 			      struct sk_buff *skb);
-unsigned int can_rx_offload_get_echo_skb_queue_tail(struct can_rx_offload *offload,
+unsigned int can_rx_offload_get_echo_skb_queue_tail(struct can_rx_offload_irq *offload_irq,
 						    unsigned int idx,
 						    unsigned int *frame_len_ptr);
-void can_rx_offload_irq_finish(struct can_rx_offload *offload);
-void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload);
+void can_rx_offload_irq_finish(struct can_rx_offload_irq *offload_irq);
+void can_rx_offload_threaded_irq_finish(struct can_rx_offload_irq *offload_irq);
 void can_rx_offload_del(struct can_rx_offload *offload);
 void can_rx_offload_enable(struct can_rx_offload *offload);
 
-- 
2.43.0

