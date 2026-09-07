Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013062.outbound.protection.outlook.com [52.101.83.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A735E953;
	Mon,  7 Sep 2026 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778206; cv=fail; b=Va5jV1nn5+mraK243rPZV488ZhbEDuKz0mFr228Rl2c1gq3hQJNu/HtU1tfhrQMJlWZl8nnZqHCbS6axCUMF24r4zs8yqR4foUZ4W0VNcUsHDhLqc9Y7AoRW47Phxa3gJlKU9AaVw7IcodTtCpRr20LsYNqsJp3VoHqRuaYqh5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778206; c=relaxed/simple;
	bh=bQ0YpCqCtS05GiO3Zsae6jxSI6dq6iFoH7aSjBEUtpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fYdvjaE+oVjTOzWFM0IVgeWyCkLF8DHadTxvqCn2D4U16xeg/1aMxB8Gx5VwBtKM5gSTmgICc+X2ybBYmDioYj6Z+vFsK06g6sXXVk8oTTruFA8DDGsakLkK15Gm4ZZihpETEua9nj5gPuOCeX+0sh9lwXkKLrkjgW1XSz9+5Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=upp/S3Rz; arc=fail smtp.client-ip=52.101.83.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="upp/S3Rz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAd2fUE5O4UtfsjABD4Ki6IF93c5PzarprSUSzPM6qS+aBRQHMQSpm9UD+JaP9Q5L6uhHb24cSf9232C5C3nBkXT7OciNK27vAwmX4lCAtcM0jIIczW9eI+doeYhxz+Q6AFpz4Tyb+fXF6JgPHNx90rwpqigYz2asTwJDpHSLS02HEZC89Pn0hZMJLdaUTwAxhjO2beijffm1Nu0URPRe6ZcDn1AYW+UDrfVrmYr8AXpK4KiSMbasTioWgUrD9/iPSMAXJGI7bKcFw/d8BmCuH87vjtizPosWC/rb9VlOvNZEhfKvdoAlc4d2Z/WPh1lTm1FFxYDYo9HqdJ4HggGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q078mk27nv/IA37Knfv+c2HeolLnRl5HAWrW7WTYj0E=;
 b=s+vKh6CTpLmTfUpRo0r5l0jrip6DQhgHylbbW0X3rHNmIAGP5JDpD0H4cKhDNLyntQ9pS8u5VFNH/0eqmMQiX+wN95w2r+BPoqjXfWeUc+jggtRiTyEM5trcB+oKNcHuo+dSaqEPYA6Z2OCI7/Q8HhblBzi2EvyTpkqi7PQxcOzs+m0W1vM58Y8HEtdSRDfAuUoat6HOe0EEKlwYYcorggToIIcFy8krdCfzIG2dccju/Xp4IekS0y6ilYBkT02T+jydySaxqlZtm34jbc+8rWh4aG4z1OCixrW1h2mRpreQiGV00QCg9jZMjzhvUBvqrbVRZL8OdPyPulcARvIluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q078mk27nv/IA37Knfv+c2HeolLnRl5HAWrW7WTYj0E=;
 b=upp/S3RzKSbSmwcJC+uIj33/B8OfvpZjJWQViHvixYr6vo1M5+tDanQSHo18StQZZqejQMEv5sRzmWkqlUktbvAANrKJAU4Y7+91yRX3LrnGDSc7t5TaYjOZ6e2UdnmxyW3nehPw/MO0pDR+v8HdGyEllwRUoq8gTocFqVKmke4VQoHTtfMmnASffEyrW+Yq/vrbMB+ZNo57MK/ZGeqo3iOMhaCrCy3bCtWBhQjmydzf9R7dLam8WsMPYZK1Wn3Ot2svgwAMhhMj8+oMdDYVJ9aEKLlC35JHk6cCz3mCuJ5a3Jo1N1Pz4qxHSHnARkQVoNcUQ3LNeMurpaj/u0hNEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DBBPR04MB7578.eurprd04.prod.outlook.com (2603:10a6:10:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 10:49:48 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 10:49:48 +0000
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
Subject: [PATCH v5 3/3] can: gs_usb: check can_rx_offload_add_manual() return value
Date: Mon,  7 Sep 2026 12:49:42 +0200
Message-ID: <20260907104942.17089-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907104942.17089-1-ciprianmarian.costea@oss.nxp.com>
References: <20260907104942.17089-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 3c2a3220-5d42-4274-f624-08df0ccdbcba
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|7416014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HmphdOtHGITeR4gASindsa1vJfuq3sVsse9lo/DEIbFGNwyWgADNDNa16tBmqnNr5iPs9QShyEfBEvTdtWHnMbApKwhZ3B+XlHrcA83TRwCbmt6mUXkQOqtqVpO/ZdmPqGJRfZvoIecLdxQDjl8PksZITuZnjkJid3BuxvAiFjxaSZ4KVy//xkfIjhM9qPO8Ztidt0V1Urf6S83F73NEUKP3fCDq47Bj736vyYHHh1xJkhjaPyQp861sHRSDCBraP9bB22Y69/HkiUzOnNADc/hMYdrGisskzSXEney4MEmR9K0o2EAm5fSxxw0ImJcC2hqtBHLHqeZ34ypmQ4IePx7xIxGNkWm9E3lGZ0KCfz0pULQDDPMyDDoCdfvg8ReaWJc5VZHNmqzfODa6Zefh0PMBowxxkMOCHMwRPjoAy9BixeIjFws2ARvDWM8Ervyjg115OjlAY1YxGWPNhcBzKcHtXhP0LWIEKjsLf6ihc8pyRREH0SmCY0u1qEHr+pcCyrMvS0j3c0DFCrnQ1eAwiuqciQJ8mNX8hUxVFWky7jXQbqWpWjsVlvObEXa0350SlA3/8MCUFJ0lMlFW1lG2pfsMViblBaDhcneirXhIz9H7m3v/+ajvyKCYOrrIxIFEfFVNesPtsIlJ+MLVWkOXyHjaSuS6RM0ESR/Z9iqXlK0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(7416014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmpKN09rNG1CT3VEcXYrTU1kV0pTVElhUnRGbHpFUXdTaWFlNE5LZmVndHJK?=
 =?utf-8?B?MXZ1MEpvY09KRlFVK1h3Rml3MlBMZElKS2ZwNUdFZFNrd1U2Zm90aEdnRFRt?=
 =?utf-8?B?TWYyY1RZdTNPQ1hRVUpIaXZXZkFKOVQvRW5BeXVTQms0SnpRRWtzNkc3anBs?=
 =?utf-8?B?M2V5WnpJWnVPVnMvMENNZ056MTA5ZU5QTVgxbGpsK3BDRlV0NmRMckFOOGxZ?=
 =?utf-8?B?LzBtS2Y4UmYyekJNVnh5c24rQWo0K1RXMmpVYzlDNWlNdkNkdHpCVUdweG04?=
 =?utf-8?B?elp6MmZiMUowNE9pUGMyVW8wd3hmWjBxRC9od2FwbG83U2djQXIwR3FLWUcy?=
 =?utf-8?B?bzdNRSs4Q3I3My85dWV2eXlPZ2psNGt5UENjcmNKbDhZNWZnY1VCYldDbFpB?=
 =?utf-8?B?dFllU0ZhZWRlTlVXckw1V0xkTXlVTjgySFRVZUFDYjRpeUhWZ1owYjU4Qlcy?=
 =?utf-8?B?QzZZWHdETmJXRmJEdkJ2QkRmaXJvWnNMR3Q2RXlsM3BBa1QwWDF0Y253VWkr?=
 =?utf-8?B?SjFNcW0xWUlsTEdGdWk0a2d3TnlmdDF3ZWhiWFVic0NpR3FCWkZmR1gyQ3ZR?=
 =?utf-8?B?U3lrbEQzV1JFUHFSVm9JTDhibEdFTWhPWUR5WHpmSERVMnFCU25wdXVRalNK?=
 =?utf-8?B?UEMyUGkxK0s3TSs4SWtmTTNnUDRiNWVETmRwSVUwNldqWjR0VEpuZnhiTk9q?=
 =?utf-8?B?dTFiSW1YcWxjZS85cGJLZ1FhVmZKaFBJUmVWQzBhRTJlcDh2TUpIcEZCVDNQ?=
 =?utf-8?B?all2YURZcnl0VCszaGNHd2gyVW1Nc3ZwcHBQN292RWMyb3padFVPcDFSQ3ht?=
 =?utf-8?B?b1pVUEtkWlZubG1KM2tUSTYzYWE2bEI4SWx1cktyd0duTDB6K29rUkw3eHJT?=
 =?utf-8?B?TmxMRW9xNEFGWS83aDRoWFlWYWlMTXI2emE2Q3NsRHE0aTZqMDkyMElqTXZl?=
 =?utf-8?B?RlhLUDlHenNSRlJwU1JuOU1aQTFEMHR6VklXL3RvR2twaEtHUFdsb3NJeWFL?=
 =?utf-8?B?Ri9pY2cyK2dxUDdWM0h3ajhhK3ozZzhiL283cm84c3RrMnpyb0hkZlM0Y1Jl?=
 =?utf-8?B?N1Ftd3hSdnNHZmNjTWJDa3k4Q1Zzd2xLWHlrTFpLYmhRWFhjUEdrUHZMMVpM?=
 =?utf-8?B?UDlXa1dHZDZqbEc4RDArVFZJVVFhcmU0MTZha3JyMkgwNU8vWXBoZzlNVHVS?=
 =?utf-8?B?MzdiSk92TmF6eTVWenNlbUJTQzI3WE5WRklnc2UzcmFmaHQwZDFkREhIVHlo?=
 =?utf-8?B?aWYzcWlBeHZISjI0czhidk5haDZKZ3pQVzFhVHM3andWQ0w3S015Z2I5Z0M5?=
 =?utf-8?B?aS9IWXRjWHJwU1RyQ2FiL0p6NDdacHJkaTlvamFONExrZ3JSZnNnRkRRRkRn?=
 =?utf-8?B?Q2xKWER5Vkl4b2QwM1pQZzVNNnhqQlRjNUpRNU5VWW9oZ3Z3ODBPSUpVMEJv?=
 =?utf-8?B?Zkc4MXc5L3g4aENZZHVOUjhhMytLNGxVbkNvbGs0MXNlUjJSa0Eyd2t2RnhY?=
 =?utf-8?B?Qk9OWjExczBFc3Z1QkY2b1lnMjdza0s5SHhuSUllUS8zMkR1NXk4a0J4RGYz?=
 =?utf-8?B?VEtZT2VCS3dyeEJiRWk5c3g4cDRxa0lrUTlyOUNNekljT2pOcktIbVlrYXdZ?=
 =?utf-8?B?NElPSnZzOGZGSHQ4SVBBNTluOEdLM21uVUFKU0VRR2EreDZHQlhCUFR6MGJm?=
 =?utf-8?B?ZUQxcWo2QTlFcmJ2UktEVFBtcUdqUVRxYWk4WmdXQWwxc2doayttZnVjWGRG?=
 =?utf-8?B?T2Q5aDFUa1VRKzNGL2Q2UnluVkVZNCtLRExFUHNobkRBMSt6My9HcUFPTzN3?=
 =?utf-8?B?ZmJpWW8rS2pjNmZqVHJNeUpGd1VZN3VXSnR5OW1uMTdHdkFvaEdQOHgxS0t5?=
 =?utf-8?B?YUtSSitxc3ZyTEJMSVhSalBzU1VrRkVUM1ZXczNQVGE1eFc1cmpjOUs3dEhu?=
 =?utf-8?B?RDZubTRsM2xMNXQrVUdxY3EwVTVkYlV0ODZvRGRvN0NpeUwyUlF1Y0NqQWI5?=
 =?utf-8?B?ZXZDUjA5cU9LWnRyV0hZd2EzL3c0U0hZc0VZVjVzUHh3VXQzalVJeEkrWElB?=
 =?utf-8?B?V3JOYmhMU1BaU2w3Y2o3UE1Yb2hUMWFvUmRjWGdVYjZXalJzL3hmM1M2dGRt?=
 =?utf-8?B?MEVNWmE0dFRpMnJSeUhOcWRJU1ZDbVY5S2ZvTitpRFFwYXFFeFJPT2diaUxG?=
 =?utf-8?B?QWxVWmYxc3ZMallWalo3NzgrZEYwWGZVZ1dsRXRleEFDcHM5Y1J4WjVjOTJO?=
 =?utf-8?B?NzRyZFNLcGVONmtiREpGdFFDTXIyOHpUU1ZVZzJFNEN0QlZTYjN4SDdzUGJk?=
 =?utf-8?B?cW9BMVYrZ2JjZ2s1TEFIOWxTSi9pZlFWZ1JQdzZUV1daZnJRYmdwRy9PRlp1?=
 =?utf-8?Q?LFk9xY4ZUPAhLmgM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2a3220-5d42-4274-f624-08df0ccdbcba
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 10:49:48.5233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6OQowA/vzFPJ1ec3fV+yAOXn7PbJzrIoktLmd1q3IMjE0yDh7ZTTi1I5mS8Foakm2Kia7pwlgxuShj72Iey5chtjBgcLNkruLYcDv3BRA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7578

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

