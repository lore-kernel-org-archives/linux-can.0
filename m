Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013023.outbound.protection.outlook.com [52.101.83.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2747CA94;
	Tue,  1 Sep 2026 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259279; cv=fail; b=LPOYgwqTjx9QskP6Gmd9BYP8HL7RZ9A81mxsTLCO7TCTOZUN+YFJ3qHpptAH5/FR0V6fy9iPm8YSotVWAyv1ZNLtlqwsNAv5xIev3vxFBjyDyaGjc71GBzy4i2QdeuKBdh+ZI5iUcmszwUDAXH9Ran1fZ1O0Fy9jNkHHS9kMBrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259279; c=relaxed/simple;
	bh=LsMMtqRj3M0OWc3uEs6GojWNGvi7dfMNwtUn9xBZoDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZZXQSZV7clhKjdV04kbFBFO14RKgsTlbgzT90TfOLkr1//UMB4C8xlO2KEVk5dJ/u9di+Su/9GQyR5AnSxKF60Lyl1MDgv+PUjgqyYhLapp2U5Ljyk5mgWkP2yMaAsU9LNZ/u4yr/G/TqSq8O8a1Tuio8mPH8F/lpA+FTQZMZyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iP85eXsH; arc=fail smtp.client-ip=52.101.83.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iP85eXsH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zu/bq/0wxVFq4pRWhyD5kf5LlINS7/TOS3FkQjTwkrVZTjBxX8Ceko/sxt8Kj5q4hHStF0/cWh+pYFT2QT0L/BOlLU6P0xGXipTmk3bWUoNz1HbDUivJQb0czdEzrp2BpwZodAuzKG6cTW3Dg0r2mxnB9TzmFLNRUNgQn/4XBgydexx5r13LE896fT5uKOvx0tV8QLGlsB970GzW36/fascpQz3he3i9KLec0+jzjiv9TypI+MWAb8jSXAMFlPavpZyo5dPfFHJg+KXjizF1benA4chfL911mNyzd8xM82sKsaZHTFinBNeonXAtl1cTnChCg0d0Rq4+9OxV7cZJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZMRLx2jnL+NjNb1tkWootG7u1lAvnyAwkpLwwFr6LY=;
 b=UeTk7tad/JvYq0vgRfP+p0nvevU5/9pR/Mxn+sBRADtkRN3qX4gU0WH/sbwYiA7uoHQJwf2rXbXE9s6bnycPjeahC5vBUSGEkcknsqXTzKggcyeUfFJ+on3yd98fK5vuXeR+Cq/qXuSEB8eYpWhjDW3acnUhHX6WCwyVjBbVk5axm4w38vTfOdVXL8hTp1UaEFC/VTh7PHyIJlzK/iVZLZO9T7Xw4M+6GaGzq0n0ftvv0jc2JHIqpBZvLGG1NqIOqgdnsMWIg3ToRtdDxa0xyOXpaN17BgjVuwXTmz288xLQZy2K5CUMN8qR3bCb9P9EujYJwQzKA5OS8ik5p+wBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZMRLx2jnL+NjNb1tkWootG7u1lAvnyAwkpLwwFr6LY=;
 b=iP85eXsHJ5RXlbo/qnXhvLZkwj8xbg2Ch8KtUK5TiXXM70ecNwyip7BhA6ohnNlUUfVa5g3m4D3RoNBznkuB291HhU7txMyXWpxuM/1uGWYHyBO2SiY00cUXHAO07uXO9x3kTYPFqcKlqijqgl2ZakX5XCQ+soTo5AzQgiPg9z5LmFW83WR9yXHE2SBKX/L3BfT5P6igeIUhvUkCV6Mk7L5CYA06d1F6aJKzQF210T1MLQeSlcc/LmAggbaWkRGH3/bHm91kovRV1ALoskzCK8U4MJpAwacqAC8u3TSHALXkzwo0UbSgIENwNyQyurwDmW4WxeCBDm3/Lh1LcnlnKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by GV4PR04MB11942.eurprd04.prod.outlook.com (2603:10a6:150:2e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 10:41:10 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 10:41:10 +0000
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
Subject: [PATCH v3 2/2] can: at91_can: fix rx-offload cleanup on unbind and probe errors
Date: Tue,  1 Sep 2026 12:41:03 +0200
Message-ID: <20260901104103.458619-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901104103.458619-1-ciprianmarian.costea@oss.nxp.com>
References: <20260901104103.458619-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P309CA0017.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::21) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 66fee8cb-3e64-4b78-1ad5-08df08158954
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|7416014|376014|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Q8wML10nfOoQgq7yZNgcQH/pFAIAxFx5xjWfapGMN5/hKkMJf1buGkaLA+wLSMwzVGsbmRzMQbmmuqhZ3pjfV44c5XM+RScaj62nA+yvDIcDGbhy9QpPCfuPLUmELM+JM6Uck7RFEJ+vO12bg+WxKwSKHMFtyONcT5FCj9RiCf6ZKhgUNxGl0zrssJa0NT4mUfy00kzR+o5o4v6IOb2FekTJ+uwa9b+ZBm2h7skOtFcsBBN4raw2QrYV1b2R0Nvm1H4svfqbGxz+mWMj+87X3hysuekUWrsMsx4RsftVWSQ465rxnINxlA7XyBmEJAP9YU3aZFbcuQLJVyiZ1joz5EItGjheaNa3gYR2IhlUYuh5+ucJT1RRqxTIIGK+epg1jdcLZCdE1xfONl7X1imar2xmjoxVvp/jq+T/gq0l5gH+tsYO0siDz4vZ8frMhhxhr8cxK2OZpUeP9JC+Jbe9gMNl31AamDZ1sZVEaLqlLdPL1oQi1PI4MoyrkOHGU9RCOo2KHfSM5lLDI9QtSgR/jJMPuYfQQ/h3hGPe4tblGbbbz75wvoFPgoJHsk1syUcIN8MFVwKe0+a47+vt5f4SrY+wycP5T7alM35tjh3Kf78jzet/z4AWaW5+/HT8CQbxqzZwHMzmJgcpx8B+nbokmIWsQyxnRc4vqR+/2vQXOZk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(7416014)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUxyU1dzVWJ3ZkljbFJEVDkxK0NiOUxTbHp0UjZGNFBjY0JBa2hPRllodjRj?=
 =?utf-8?B?RUpraU01Z0wrU3NjNEFUQ2JVaVJDUFI4S0w2YnRscHN6dlRPZ0praU9peURi?=
 =?utf-8?B?Y1NQU2htQ3kraHo1SUpqejBoRnhVOTBuNFk2Y3ZCTi9aQkp3ZWU4ei8vWXFY?=
 =?utf-8?B?MlhsME1acHNOV0lQZ1piSFlrUEpDd3AvUnBnM0R1VkN3dHozMnNhOFJCaWVi?=
 =?utf-8?B?cFgyVDhHM1MxOXJrSkQwZDhVZHFsYkg2Y1dIWFhWZk15ZW53QUF0VzRqaGJv?=
 =?utf-8?B?VGJ3ck1NOHdQY2s5OU5ZbG5tU1JpYVpOY2xWeUpKbzVWbWk1WTdPOEZjd2ZQ?=
 =?utf-8?B?VXAzdHB0bzBHa1lZS1loNXBybk9BdXhhcmZJYVdvSmZOcksraXRVTTlmcUND?=
 =?utf-8?B?VS9Ia1BkQmZIYWZwMFVMZStEQ3lweHZBblJmZTVQU1M2YStqOXNiSGoxY3Ju?=
 =?utf-8?B?S2F0N1paT1hlVDBxeVdzUmc5Wks0L1ViMU9nK3pEQ3o5SC9SSjBHRWZKUUdu?=
 =?utf-8?B?cFl5bWtwNFZ5UngrV21uVGpWQjJXQ3pabVpFaktTSktXdVFVRFp1Z09lOHph?=
 =?utf-8?B?c3JVUXh0czNyQ2lva1IxbkpsR2x2SnlIMzJlZzJGSktKeUpVYVVQRDFLK2Vx?=
 =?utf-8?B?eEk5RWpYZ09kZEVjemVQNE5lS3orUko4bFNhdjZYM1IzSi9aSGhkeUJSY1k1?=
 =?utf-8?B?Z2lBU09xb3pYeVJSZWZ1aHhEYTRKc1VzUGVmN05GZkl2R3YwYW5TUmFCZTNN?=
 =?utf-8?B?SkNQNDFia0NEcldwM0tQUWgwcEIwdnBwbkt0Q0NJY2xBdFBLdWpXb1dVMDZv?=
 =?utf-8?B?L1ExMS95d3VpcUxWalV0M2s1R2tBVytMVU9HS2FIT1BiVWpvZVZ0OVk3bmY5?=
 =?utf-8?B?VzIwY2JTemc2Z1picmh1dUxiMG42Tm5YczVoRW1LWUh0dk9PMzVIYWRFaFc5?=
 =?utf-8?B?TXVHOThpdGlPdnF3MlRpTDhReXBjeUpmVHpYMS9tdU5jRHNFVEtwZ2ZVKysz?=
 =?utf-8?B?Ym00aEpaZStTR1BDNkFmVlNtcmxoNDlyekY3Wkx1SFRNM040OWx2TERoSEor?=
 =?utf-8?B?VEJkVmRENlUwZzh5ZWFLbkVJS2hETnREaG1GT1JPblNRWTQ0U2VGSG4zeEtx?=
 =?utf-8?B?OTRzd3NPWEt3MVU1YmlSYXc5b0VJK0w0R1A1T3RDTFl2THh0cU9Kb1JDZWU0?=
 =?utf-8?B?Z0F1MnZjZFJvYzlqMDE2R3FhbGFtYnVJVjAvTmQvSXpZdkxjTWpEVUhvS3N0?=
 =?utf-8?B?eDl0WVAwNDcvYzYxZ1dKZTlNZndKcHpCN0RQak5jSXVHVlJGQVg3VFNQRkRt?=
 =?utf-8?B?RklaWnpnbmx2b0RFTHUxL29MR2Z1T3Q3SmJvN1kzdklSdHd2dGJkTUtaZnRD?=
 =?utf-8?B?eWZVT0h5RGMveXhPZjhZdGF0Q0dKaHgxZDUrYUQ4TVdmc3podElpdHVXS3cx?=
 =?utf-8?B?aUhRdWVGTCtDSFZZMXA1Y1F6dWlWYUxxcnVyYmVGbnlDSm8zcE41SCszQWla?=
 =?utf-8?B?VWZ2VlF4VWRIYWRkMlljbFgyN0VvSmtjb0FpM2NQdFlrWkZnRWVmdlpteE1v?=
 =?utf-8?B?dXBoUjZIKzg3L3NnelJ4WUI5REdlbE5vaU1EMktLZm5YK3pjWGR1RkgzcUx3?=
 =?utf-8?B?UVhMT05uMk1NenhqbDI3Q3QrZnVGNmpLZTlleWhHNnRSOUNVZmZqd0xXVTRo?=
 =?utf-8?B?ZzlMNGd4MjloRVZ4Um83V1RrME8xRW9raEg1WGJrbVZ6bHBjc2lycUhBT00w?=
 =?utf-8?B?eE0xTkl1b29pR1pra0JiK2VlK3M3a1BUY011NEZ2MEZ6b1NLVStrdEQ0dEJx?=
 =?utf-8?B?TkdTRVFGWFZFVnB0d0FEVVpXaC9UejJDaEUvTFBOY0tLMmZKbGF1VDR6dzM4?=
 =?utf-8?B?U29HZ2N6ZHNxdUxJVXJvWUVSa1dXZkVZam9SbUZZZ0VFRmIwcFFPYnc0bTVa?=
 =?utf-8?B?YnpPQWk4Rlg0RHQ2UEJlL0w3TlRxQTZZb1c2ekRURFZWbEJmYjluNjBqMklE?=
 =?utf-8?B?cHJONndDWVExV0RsWXErK1ordStSTW5tTHVMSWVSQ0FDbEF3Ynk1ZHNrTmt1?=
 =?utf-8?B?UTRya3p2VksvVlcxVTY4aUswd0xxdkd6cnFOVlJkbytvY1I3YURycHFhWlBU?=
 =?utf-8?B?cTZCcDl6OExGVnhQWU9lMFVuTUJqZmN3UmZEdjRBKy9VRFZkMUtNaGU2VTI4?=
 =?utf-8?B?eURLWjJDdHIxNFB5THZFanpDdTZEVHQzc083OG82bXk1c0lNNzA3Z1hZdUQx?=
 =?utf-8?B?Sjh0T1FhbkU3ZnNVeG93eFNhQ3FVaEZxd0JzQi9GMi9hTDBFdkFyVklZblhN?=
 =?utf-8?B?azJRd0N3NzhtWXZvSnl1NUc4czZJY1J1ZzJhREVaTHJlMjAzUzVUWk93eldT?=
 =?utf-8?Q?HuS1FcCF8LMQ2gBM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fee8cb-3e64-4b78-1ad5-08df08158954
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 10:41:10.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfxSQnJ+ByxR+nksH8txfsodZIECLiSZxMcmGJZSbJof0Duj1i0LnLZrGwyLcAVX1LEW5zcld2x4kAExHlpgtAk6xzYC25bbquQfNgSSbw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11942

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Making can_rx_offload's skb_irq_queue per-CPU (previous patch) adds an
alloc_percpu() to can_rx_offload_add_*(). That allocation has to be freed
on teardown and can fail with -ENOMEM, which exposes three problems in
at91_can:

- at91_can_remove() does not call can_rx_offload_del(), so the NAPI
  instance and the per-CPU queues are leaked on unbind and module removal.

- The probe error path after a failed register_candev() jumps straight to
  free_candev() without can_rx_offload_del() and leaks the same objects.

- The return value of can_rx_offload_add_timestamp() is ignored. It can now
  return -ENOMEM with offload->skb_irq_queue == NULL, probe still succeeds,
  and the first RX interrupt dereferences that NULL pointer in
  can_rx_offload_irq_offload_timestamp() via get_cpu_ptr().

Check the return value and call can_rx_offload_del() from at91_can_remove()
and from a new error label taken when register_candev() fails.

Fixes: 137f59d5dab4 ("can: at91_can: switch to rx-offload implementation")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/at91_can.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 58da323f14d7..3f6c5bb373d3 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1123,7 +1123,9 @@ static int at91_can_probe(struct platform_device *pdev)
 	priv->offload.mb_first = devtype_data->rx_first;
 	priv->offload.mb_last = devtype_data->rx_last;
 
-	can_rx_offload_add_timestamp(dev, &priv->offload);
+	err = can_rx_offload_add_timestamp(dev, &priv->offload);
+	if (err)
+		goto exit_free;
 
 	if (transceiver)
 		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
@@ -1137,7 +1139,7 @@ static int at91_can_probe(struct platform_device *pdev)
 	err = register_candev(dev);
 	if (err) {
 		dev_err(&pdev->dev, "registering netdev failed\n");
-		goto exit_free;
+		goto exit_offload;
 	}
 
 	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%d)\n",
@@ -1145,6 +1147,8 @@ static int at91_can_probe(struct platform_device *pdev)
 
 	return 0;
 
+ exit_offload:
+	can_rx_offload_del(&priv->offload);
  exit_free:
 	free_candev(dev);
  exit_iounmap:
@@ -1165,6 +1169,8 @@ static void at91_can_remove(struct platform_device *pdev)
 
 	unregister_netdev(dev);
 
+	can_rx_offload_del(&priv->offload);
+
 	iounmap(priv->reg_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.43.0

