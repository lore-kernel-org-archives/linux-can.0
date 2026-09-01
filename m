Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013039.outbound.protection.outlook.com [52.101.83.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9455D39023A;
	Tue,  1 Sep 2026 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263359; cv=fail; b=DYfoMZSTFORPEic74nKrajox8dw7ORbFPTJyXndou8rSZawubi/rP91A3C7/yfqHDE2+tHSY7NgUOodagXrOIEH2qg+aBw19rOp7lIn2R1XWmLIZdkRpJLPtRZdr+XKmpt7KAZqfa9OVnepZMrCwXRLK/UhpXpw3fK3Ho1oTT4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263359; c=relaxed/simple;
	bh=bQ0YpCqCtS05GiO3Zsae6jxSI6dq6iFoH7aSjBEUtpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=byyF1MuUoH7jEjVGCvaTMmtp14tWhhM5Ac5FUorAwtOs1IOkB4kEm0fRF1oRLrFmX4zniM82HDp8B3hUlwNIzFcCVNV1Q97OWml4KVOC2jZsLAMlLlCKV929BZeeDXNpYgFaCxYibRITyCBfrsoQluwA2Ol/AOacAFTzh4NgHpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oe3Cu0HC; arc=fail smtp.client-ip=52.101.83.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oe3Cu0HC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC/SDxuXiSnwPR961S82MDSdrsA/yvbGFpYDRo/UReLr1F2crlrf8Zks5oU74T/WBXPj0KJ6C0zyHHCQJNeeHHCAYkzAjHx/MPKAJ1BNikPuyWaV/4HmwCoLVbnFn7ZSm4Dz3XP8ZGwBomlOXE/puPf9yjSEVFJQhXyfHfPN7NxLrh2RCiKAEJKLCO5zpdQ4WEGCrPu84QLbG6ok7bd/vmd/iUAtp/Sa5mRhYNIn5aWXItLUtqLoqlDQyzVP5JAqpDmqFlIeGMqp98CG+ReBxvVgTrbZTIQ3WpZJUG6ZbYhpmNl6pn+RCVdca7UhG448+b9jZp1jPwObtKtiWkssUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q078mk27nv/IA37Knfv+c2HeolLnRl5HAWrW7WTYj0E=;
 b=LjzJGPQDrUfxaaOLKKEV1V4gO+Tp5UEbnVMrGAFQXlHJux0VTFAvVi0vQ2F1hgSqcv9SuNJdcs9+7CPLggFkJ5xUB4XWeHxWqssA5xphkNF3qXYZw++rkzFhhy019n+vqFuUO0H/rm/r1JJuAHAI3cRfyBzzPJlU//VZehpwPAo9I9dhbhhqXasvNf072tPA/SheW6EmqF1l/v4wl5gyb/h2vtwkSWyHkyrCaeq/wz6LD/SmvWPY0aeXilFbiNRIzbDS8/NT3ulpBriNSM/I+Q8IC3zWQMk3Cuncmcmb+dHA4Onv5TWQhpYGPm6Vk7RlsN2IKwnLEhoiL5G0WPe3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q078mk27nv/IA37Knfv+c2HeolLnRl5HAWrW7WTYj0E=;
 b=oe3Cu0HCvYMuVzjolkQOL50RwR7g6AJgqqFvo6IbKgbyZhIXdYKxhlRfzMhNuxm3RNvoaLcRCcdWmTcBme5v1QnO8jJO65PlC6CarPLec+mVORgj1c3Dm/vZDcbsTUpKQIlFMc5U6VdHVMJwnD0DkIBBQ7eMnVvyBAz/ItI5blEh5fj2mJY+Yj5ludEd1oVosG5SbjciJ4Vted5JUvplNfU9omn9Qd7lr1PUDDn1XTF7NqjBEh4OZAUZjMLHjbfMdLT0hAIhuDk7AqPT7py1rIz71MswHuQG3xysfhXUsa1YPTNKGuGzdPKK1RUQWUUhACKqlqV81RE4tZGwO+Xqbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU4PR04MB10717.eurprd04.prod.outlook.com (2603:10a6:10:584::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 11:48:55 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 11:48:55 +0000
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
Subject: [PATCH v4 3/3] can: gs_usb: check can_rx_offload_add_manual() return value
Date: Tue,  1 Sep 2026 13:48:48 +0200
Message-ID: <20260901114848.500591-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901114848.500591-1-ciprianmarian.costea@oss.nxp.com>
References: <20260901114848.500591-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::15) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: a5019a96-0f90-474b-f8ee-08df081f0035
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|376014|7416014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	xUJ/cxILTIHyZ7x0stmSbivxOjz8fwZ0JIN5gpVV/Ym5CNvNy5ZPuuQjCM2CWNcWpFsloyKKHRldvgE3HxyW2CycT08ZdltrKKJHqjGKsuPWwwRFidCzENpDpLs8hipnupZ9yuCqSxwK5dFDLh0x34pNojKlEEYmjMQAyK5w64yGTIYZx6XcbRpeg7Qi0D6M5Dx7lMd48MabOZeNMVVKWNzO4hPNtiYxaWbfyxlr8sR5XoPbmaYip/+FP2MZ5E284E7hiIB7KmbmLfefloHUlwgkHb3lwHjrk8z2rTRn+zwCCXPZg+ZMegNNDU+4OA8Qq2w28dhgRgeyeOCMNok0VSBUm8vZsMjg8xjqQg2V8XGobbUs8vDS5XSBXYafCr4L7wOObnybojbTRoSvVg7xzStqQOYgP2kGuz3mmqSLklsOiSqGHFkuCnox/+TIl/SbnvFN85WsHf0jBF8iwoqycovtvmPubuZOw8GE1iHpf04DFHGYzfr7MZtuzl3M6la+wvpixKfmea+UBZC8Ufp+xlaf8+fByvFJxRM12movif602CWHIfuKU6ncgobo6FmZE7wovyGqgl7Gi1bn1I1Tzae/R/YPY7j2Y4CP3RuM6g08FrwftJfZGohxU8kdIjkQnzc8oX60cCuujW0pPgHt3o7GA0bggBuIkHOmNQo+SFg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUlJZHJJYWl2RGsxNjBBZkV0RXQwWWdiK2xuRTRsUFd4cVJOS2dRY0QxZWhS?=
 =?utf-8?B?bVBEbWI0REZKQXY0bnRQTnh5WDhWMGtIZDZMUzhhNFdlajRDcHNsZUVFMitI?=
 =?utf-8?B?OHdjZTJVSEQrSTNyT1lqM2ViT1NjKzBmWWkzdHJhWHVXWGNZdzl4WjhNem4x?=
 =?utf-8?B?Z1RTVzZ4OUo4c2FueWEwNVVNVzMza1VveFJLS0JrY0w3VUxFVE5TeUQ5bU5s?=
 =?utf-8?B?aTY3ZlBrVVNtN2hPOW5iQ1Y1RVpwVXJ3b0RrTXlaRG9lZU9EYUxqelR0dXp0?=
 =?utf-8?B?ZkFGNlRjcmpZbmxoSG95WW85alR1T1BlT25XVWhQOXJBelNkcjM2MWpwUjJu?=
 =?utf-8?B?NE1EaU1FbmdGbTNwV3lFaWRSQTFKS1BmZlI4MXdBMVJVU2F3N2hWNXVEaTBU?=
 =?utf-8?B?Z2ZhTnlYRDZseCtUNWNObmc4QW0vVVVwWVpLeHArZm0yUWV0cktleVUwQjdW?=
 =?utf-8?B?V21rNFlrSSs0VWdJcEF5TEhIdXZQakdDVzBMQldUb1Y3b3pFNG5HbWdPWGpL?=
 =?utf-8?B?OHFYeEQ1N0FCUXF6N2pPQXh0RjM1L3V5RGZqcnk3SkM2QysvUWNKYjVvb3ky?=
 =?utf-8?B?b2t2Zm03cFd1T0R0UUtNRTUzMCsyQ1I1UnNUZjJTUkloQ3laZlV1Z3lLbExW?=
 =?utf-8?B?T1ZTUHNReGc3TTVzQ01MVVJLczBMcFBDN2xzNXNMUm11SWx5NlhRQ1YzNjdH?=
 =?utf-8?B?ajhjZHk1UHpYM25jN04rb3U3L2VXbUNJdlJEc1g0RDkrcWhVZzNteWRibFFC?=
 =?utf-8?B?aVoxNXR2Z1RnWlpmUjBxMFFZWXVaV0ZxOU9LUE5Ib2NHWngrUHlmWU9lNll1?=
 =?utf-8?B?aW5nUlRPNkQwUUlFMzc1aHRud0JBb0xLSkg2WVVFbEJTWkcydkpQSitrY3pa?=
 =?utf-8?B?RnJFcHRkei8yL3U4T1VCakZ0ZFMxejJ2S1IyUUtzY1Juc3ViaTdTRE9QOHZU?=
 =?utf-8?B?WWxiaFNuNFE4U0luVVp2ek56U2RzRmJ2MmQ2cjNvWTA4VHVoelRpVit6dk9W?=
 =?utf-8?B?akcrZm5aWkUyTHpmeXZCclZPV0w5UmczU1B5TEhDS2VwRW1HK3dwNSt0aWxC?=
 =?utf-8?B?d0NDdjkvcld2Y0d2Nk5RYlNPUThRQmJQOUdlTjZjdW0wbzNsenA0WFhiWS9T?=
 =?utf-8?B?Y1ExSUpFYTJ1NDhoeWJoclNiRkFLQ3hnY09KT1RuMWNrV3hQVUpCVGQxaTZt?=
 =?utf-8?B?WFNaQXVCOVJMVXRWcm9mNUtoRTlSclUxdzYzT2ZFUEpES05iMmo5UFpvRElk?=
 =?utf-8?B?Z0lqWnltY016eVF2eWdSaGc0U0g2RFI2SXBKMldQamhQS2oyRWNMWGxSTEhI?=
 =?utf-8?B?QktLMnN6OGZWZzhwTk5SZ2RicXl2QmxhVzRDTzZIUXhIb3ZJYXpuZUdnaUFF?=
 =?utf-8?B?dEN1L0xEc1VwRUVRdXRTU1BrSWZ2K2Z2K0NKL2lGUERFUjl6R20xUWVUYmRm?=
 =?utf-8?B?aHo0QXgxeGRvR0l2RTRqRUVVZFhSVWphRWdtSnhPaWJBemprLzlJUTlzT2Z5?=
 =?utf-8?B?YnM1RTBWN21BaWFrVDlWajg3UitMdjluMXUrYkNWOVpNYXYwSWUvQ21JbHlV?=
 =?utf-8?B?NEJXYUFBWWo1Y3lKTlVUVS81S24yTWZEUU9aY1RWQ0dhWDllc1lIVFd4USsz?=
 =?utf-8?B?WjA5d3I5YkFWc3gvRHE4Y0crQ3F1QWxZK2VGT2xSdXNSM3RRd3I3eWNSVWNh?=
 =?utf-8?B?UjhYdXNWclBqdE1mQU1QemZsRHUxQ1RzZFIwQndSUnNndGltSVJiM0RVTTRI?=
 =?utf-8?B?d1M3UFNUS0RIWmhhVTNNSGtZcWEvbGNDWUFTSlVYNXVFanJZS2FDbHNJV1gy?=
 =?utf-8?B?azg5SmpUM3FNZ1U4Qll5Vm1DVnZGTkpsZlgwUTQvYmE2dEtGbUduNFZxTkkv?=
 =?utf-8?B?ZUN1YkFrZkFKMmVjWmxFSU9Cdmo1L2FGTmU0REUxRDQxK2QrTHAyenRLNE44?=
 =?utf-8?B?L09aRTNKVi9DT25ydHFiQnZGZisxdit0blhGNmRqa3RtaGdubERpR3hjQ1VO?=
 =?utf-8?B?VS95RzVSR3E2UTcwc3lOdEhvcGxtNkNvVmhzVEVIVFNVelBBWEg0RE5YeS8w?=
 =?utf-8?B?eGtBQ254QmxUU2N0VEJ5SVhsMW9oNmVoaDNURzV5a2ZzbEFpVTB4UkJwUkpC?=
 =?utf-8?B?UWZKdG1WbjhsbStOMDJ4dUE5QThwcGJKeU83UjdDNXlLcUp1cFVvNG1GcHlR?=
 =?utf-8?B?Tk9jMVBjRHRBbmptRWZyREJNNVdvcGw2N000eWZvbUc3RmhsMUU1UWhOaUdV?=
 =?utf-8?B?TklzSU9pZjMvd1dyaHpiV1poeFN1cldqdlcwSjBvVm10L1J0ZElMeEhFRXFz?=
 =?utf-8?B?Q1lDTm9uWlY4YzlxV2RQcUdoS1o0WTdOSDRNQnFiQzFtVW9ucnJuVGFHZXF3?=
 =?utf-8?Q?i5cZR/iFDdLClW4Q=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5019a96-0f90-474b-f8ee-08df081f0035
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:48:55.1595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70ovyQhqxNHovgP+A398wkyWhI8MhuTvV9rkwPYMPtOsd9F4B1s4nzpXctWkYXFuK7tbYgsj1bGLH+9wNehGU1DZf8KPyc3S85iNJZjF2p0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10717

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

gs_make_candev() ignores the return value of can_rx_offload_add_manual().
Once can_rx_offload's skb_irq_queue is made per-CPU, that call allocates a
per-CPU queue and can fail with -ENOMEM, leaving offload->skb_irq_queue ==
NULL.

Check the return value and exit via the existing free_candev() on error
path.

Fixes: 24bc41b45583 ("can: gs_usb: convert to NAPI/rx-offload to avoid OoO reception")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/usb/gs_usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3b9b2f104d86..cac4ce323a1d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1487,7 +1487,10 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->can.fd.data_bittiming_const = &dev->data_bt_const;
 	}
 
-	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
+	rc = can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
+	if (rc)
+		goto out_free_candev;
+
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
 	rc = register_candev(dev->netdev);
-- 
2.43.0

