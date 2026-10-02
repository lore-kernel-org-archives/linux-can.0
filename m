Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819AA42466D;
	Fri,  2 Oct 2026 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925156; cv=fail; b=c1wTEvdWqGLi6PiD4yfkIseAz5r8fq1fJDOuNU0EyKmOU9/eXgLwWXmUtpZsg4NzoNASBiQZDiNBNhdzz018LZJw7x7s2ELaC9YKKOuoVazqv5FgJyiQ3JPBDVgIVxBH9hgu79q3H4I17yK4hDMtEox2PQbXRKrAeol+mT5Qrr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925156; c=relaxed/simple;
	bh=HGFb54v8oiJJMFrpigyn1BFx/iW2thXNE0ZF6izNi58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g205rJyWn160lbNsjjUyTmdvWlT/cpyDSzm22OdmCgGLj2u5mSVrWFTdK6q9yuOvNEUXttMwHcR4cQF0dgir8hRV6kwqziVxxu/+6c2awdLpWIUCbrJr160Jgn6fp83pI2aAdqvSQkIuPxC/zxzdaj8oWps9n0A5efPz9zIWduk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qbmELho2; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qbmELho2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gM86ZTZF5xQFC4TqD4E39dR3UD3l3haezk3qkwaIMSo8gb62A1fWMEflLKX48RqD0WaYJ/yZdxBktGGuX0HXVrkGn+lSEa9pyUVa6lX8bIaCCeeIB9CLx/gwbzlWMNKYq3BznLAEKnIw0abs/x25gHfP8Y1JBSdYQeY0q0ROPszzwUC9dinclDMrLTShbY5knGPc9Hv+mG/XwkjHpBcIOSpbkyJil5dd/I+YAvKtE0q8bM7rFn+j9Wo/R/5WPf132wNCPWZpmooGbXL7VCGPkXSEeR9UZ46fnKu74xovSbPApXDOMmN1QdQYmpAH4g5prmOA9oGPorJde3w15D8gug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ+JyF3JgokRWt+uThC3R/xADR2aJax3bEJADhtJbKk=;
 b=u31+6Nf37ZbUsnNkNPCu9xn7wcymvymCM8rG0a25Dhx7kg0h/l5f4Tgu9q736G+T/JuQLe4FuHqrvltAwbK5y/X2K9u01NEnL7WhbtqYMvoCyN4J71yH1DVXX3ZC4C9X3lFjfBLX5sW52YVTgkhlsrdW7aziO9mqRwElriVPJFqBJHHWyrlQ9BwspSq1vDDtyniiljCAg/7bbYCmGH3WGvz2Z6831UUikltL6mhxLOc+deM6+Ac/XfTvA/+p+1k+ektjm5v6mXuwF5xwsHSGPORcIMlFRrXJFBQHo5IUJV3bafq12JUQiM/roC1tHOt4dQ/Gdh1pcUaEgb8ctKscAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ+JyF3JgokRWt+uThC3R/xADR2aJax3bEJADhtJbKk=;
 b=qbmELho2XyJ6wfTr2iVTzAr19FbcUuuOo2JvIQVZ8l3/okFcsgSxEHSkStRU0jJ+bahGp+7/nT8HL8aJg5dWtd7raZNVcEWRMtcZTzNn6RpZbWABzCrqf1B6YLzM0IPRSQr5EF4spisG2/2oO6hKDs6/mrYey+/6BUqP3MpfruZKI9lxBWNbQtTA31em0dyi76kqqVu3/lwk9lD9MZG9xDw7TS33+/c3PzxTVRZjoRVGx7Yj7jX0pU6xIYAKVphgd2aQBY/9T6h92eXvO5LN5ZsxRMf5bmwTm7RTVigDGkSsDyXnsyM0sCLaciQLIIEoSxOjeof7HXJBNmO4POxl7Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AS5PR04MB9825.eurprd04.prod.outlook.com (2603:10a6:20b:672::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 07:12:09 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 07:12:08 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	imx@lists.linux.dev,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v7 2/4] can: rx-offload: move skb_queue and napi into struct can_rx_offload_queue
Date: Fri,  2 Oct 2026 09:12:01 +0200
Message-ID: <20261002071203.1287650-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002071203.1287650-1-ciprianmarian.costea@oss.nxp.com>
References: <20261002071203.1287650-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P250CA0026.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::31) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AS5PR04MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: ba16403a-80c2-4136-8218-08df205478b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CrFcJFZQHUA4ugt2HemEGyTXpdw6s75hU/bRQZUs1tj9bo5ugscIqHDqODpFWv6UfQew/LK2bI0d8b1x/x1Qy1TKUGj1BlU83XKBpehYXVhOzjeD4EQbLV9YWthr8U/1Z4DBsF3s8dxyVJzS0kbfZ4wtqZi0FxfOx7Mlohc7jaKWPGdzKxXZ1w0v1on4LbozN2l3ahB+l6sjlGhDyUOusw9D/9jAgOb37XZjpndaFh1739Ff5gVrkSblIiOOU0/sGDt+qgQ0JABL2U21PSQ4yY3fStKdbC3ayULVy8x8vd0RlkPeJbn6txDurSZmNql/M0H26+KSHz2R6k0VziMZ2snKRcuImMD5DAXLU5prVx31RPNvfNAg1rCn05qaTLCiSgw5JjTT6cPZGCiU1gy7zz6u80rfAT7VTDEfhaYHmbrBTsecTkMxT40DF8uLWJ96VxAYR8hGZMbwhiROPWjJ5qblGTN7wbJm0OefHrEn1aJQqSDHpae0lqJ7BG2sqN6XWnQFnOvH0Z84CAzql5ToDVg/gtjoD0YdgzxTp8l5PnDqJmyzT4EfntBKZPoCaDD4Z4OSIuZgwGN4dpeQSLiwwRFU3Hbbe5zXOYO9MQNZlJzSV/L1LVIicqn13Se00f8f6i1YfwXeZKtLZN25lym/Q/Zi8QbHNl4fbVLF5swXqGk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MThZbmw4cFdXZjh0YkpyQjFCSDhGejdtTVhUejVaQS83TjJtNUNLM2NsVU9K?=
 =?utf-8?B?dXVCWnp0blBYZzZZeUtpK3pLM3dWVWc4UDRpYXIwQVlxbjkzS0laL1dNVGtP?=
 =?utf-8?B?bHB1YmpidHZyQmFGSzFFd3ZwaGo0RGJjRyswZTYzdzRqWnJVWVByRndNMloy?=
 =?utf-8?B?TEcxRVF6V1duajMvcThxK0tjRTViVmlzcmp5MlVvcGhsWStPbGhxMVBIRkxY?=
 =?utf-8?B?cGR0Um10N3JnL2h4Ni9qeUxHMnlZaldUU3g0VWdRdGxxbm1zYzgzUUhNUlJ0?=
 =?utf-8?B?bmczWlpQTmhUN3ZsS0p4K01wSStWa3lFTlJGTFV1VVIwNkY0S0UwNjVoRkcz?=
 =?utf-8?B?TThQalk0eGZ2OVNEanJZeXo1RzA0SGg3VDBJR2JxU1ZQVEk1Z2Y1M1AxNi9S?=
 =?utf-8?B?NU55bUc1bGF1bU84SnFjL0J2ZWZ5VUN4QklhbFJVREZqdzdMMDd3ZnZzSGZa?=
 =?utf-8?B?MFo0WW1jR25hQi9qbW9ZWTVmSWVlNVQ5RXZoZExzQ2FXM04rYmRWdHdOenZT?=
 =?utf-8?B?WHpiUWJ1TWhQYTh1bmEyYkgwNmQ5L0M2enRFY0crcnJLUjVtR2xCZFZhL0gx?=
 =?utf-8?B?LzhUclN1M0R5c1V4ejFIYlI2QTFXYVg0cU9xQ3JWYVoxbVhwcEV0OUF1WE1i?=
 =?utf-8?B?ZWNLeml6akdGWlhNZ1Nhdzc1eEM1cWY2VlI4YnoybFljRUp4TDM2aStQNGkw?=
 =?utf-8?B?MlpDVUlMdlFpcUp1QkoyN2VFUE9wbEx1QkpVZnFheVMrcmQxT2hMejZvODMw?=
 =?utf-8?B?QURKUUtnQ3VPSGRFKzdLNkt6QjhpQ0NzR25oOFpUZDhiU09nMDdzWVlZQWJZ?=
 =?utf-8?B?VExLN0NabGIrbklpVGZna1J4UDhvTGhTSUFHYVU3RmV1ZFVtTEZNdzhDRXZr?=
 =?utf-8?B?MGlVRllXc0JDTnlBRG5lQ3JhUUhXOXIzWVh6UTV6a1BpZng1d3BXNFBLM0tl?=
 =?utf-8?B?a0hHbWlNWExuMVV4VWhkTytFRzhkYlU4QjNOTHYyZUJ1RFgrblYwMkpCRlFJ?=
 =?utf-8?B?cmdBWGlCTloxMk5YRXg0OGNSamJuQjhoa0FSY0h1QXF4bmE1VDhSbURncHpQ?=
 =?utf-8?B?NHlBWldJKzZJdW9YbndLVE5CTXpFOVBCR3hSUHFJbms0Z2ZtdzJEa2tSb2x0?=
 =?utf-8?B?azlVdU5qVHMvUnFERUtDV3Z6NlVRUWdtTGFHUzZoT1FNRUhIOTZxNktMbzBJ?=
 =?utf-8?B?aXVLZ1NnVW1HcmRUYmxEZDZzTFY5a3RydmFnQ1piQ2hpcHBLZlRtTlVoSTB3?=
 =?utf-8?B?NG5QM1UyN1YrN28vZW9GaXRUS2d0ZlpjMEdxTlhSaWY0RTVsUm5YNGJzV3pE?=
 =?utf-8?B?bTlxd3psRlk3M2M0anZTaTZWZFN5WFBsbHI0cGZhTE1iS3h6Ynh2VVhaVjQx?=
 =?utf-8?B?V1dwanlzWXZ4Y3Zzemt4M2NFWVowM213NllpM2phdlRGdnBkSW16ZkpGWTlU?=
 =?utf-8?B?V0RRTEtPQnhLOUVkSnZ1MDlGZXo0Q25hbm9OeWt5WC9QMjV5M3FYd2t1MUVS?=
 =?utf-8?B?ZzJFWTlib3E2ZnpxK3JTQVZUbGY2RkUrMjA5aS85U2xOaVhrWWhwQzk2OXpM?=
 =?utf-8?B?N08wMkJPTFkrRGltdGpuZDFFNUZsRmZWKzU3RDU5TnJtemN6R2dHVmZRMVBS?=
 =?utf-8?B?UkVIOTRsWldLTE13U3JOcWNjTitST1gveWFaL0ZsNWhhSWIxME11MDNybUcy?=
 =?utf-8?B?QkpoVUFzRTFHaSthbENkL05zYlQ2Qk5nZjlBT0syb1AxNTVPSEh1UHRxOG1m?=
 =?utf-8?B?eFB4UGJyb2tpRzZKV1VjY3ZMczNDS245Q0N6cG53MjQ5WVRLY2gxZFR0QTVF?=
 =?utf-8?B?anBCaSs0aDhJanZ5TFB5alVyTDFuSmtCa1ZMd0lUejljWU9VL08vczdtaEZZ?=
 =?utf-8?B?KzFvNWhZT2F1TVhSOWdLSlhZQ3FkQXVrenhhZ1M0dzdGRVdLa3UxY01JZENW?=
 =?utf-8?B?VGczVElueFlMcGtGNkZPU3BWM0RwNndyQUtBNTRyOFlHWnpzV1JiUDZKWC9R?=
 =?utf-8?B?bHlyY0sweTJ3QmQvMXZqSmlHeXZkcUplMHlpNDNjRjh1d3RDNDdlcGpaTE84?=
 =?utf-8?B?aW1ITVNYQk5MVmNvK0htdm9nKzRGbFo4b0IwUUsxUWJ2UEpyQVVCV25IaXYw?=
 =?utf-8?B?WlVYYzNBMzlBR2ZJcGtkRkc3Z3pkZHN1eHBpVUovMTVKMUVOcUZrMWRrQktx?=
 =?utf-8?B?M0U1ajQ0Zi9EZjVKVjY4SS9nVjZncHVKdjZ3SDQ5a05DTE5XdVp0NFhZVGE5?=
 =?utf-8?B?bmhJL2swejFHVGszTVFYOHBFZ0Rob0RQcXpOUVI1eEE2ME0vRUVtTjBzUk90?=
 =?utf-8?B?Ry9XNDM5Q1lvOFVtM0NVcjFmWUVqcWJaSzdObXFqQS9JRmlvN3dpekI3Vjhj?=
 =?utf-8?Q?TW6uKkF+5Jqmyv2w=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba16403a-80c2-4136-8218-08df205478b5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 07:12:08.5364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pF7TIfC4WlajrHHhQA51k/0jXlkRWyTEgO5eG+MUpPalwSBtYnjNcExq4DnIw09EdJaOOfYFwoQfnchuctVuJD5g+U3pNYter5GFV6mdPuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9825

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Currently, struct can_rx_offload holds both the state filled by the
driver's IRQ handler (skb_irq_queue, mailbox range) and the state it
feeds (skb_queue, napi). To let more than one source of skbs feed the
same skb_queue and NAPI, the latter has to be separate from the
former.

Move skb_queue and napi into a new struct can_rx_offload_queue. For now
every struct can_rx_offload uses its own embedded instance, reached
through the queue pointer.

The NAPI poll function gets the netdev from napi->dev.

No functional change. The rx-offload API and its users are unchanged.

Suggested-by: Haibo Chen <haibo.chen@nxp.com>
Assisted-by: LLM
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/dev/rx-offload.c | 58 +++++++++++++++++---------------
 include/linux/can/rx-offload.h   | 14 +++++---
 2 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index 46e7b6db4a1e..92309ed47bac 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -41,16 +41,15 @@ can_rx_offload_inc(struct can_rx_offload *offload, unsigned int *val)
 
 static int can_rx_offload_napi_poll(struct napi_struct *napi, int quota)
 {
-	struct can_rx_offload *offload = container_of(napi,
-						      struct can_rx_offload,
-						      napi);
-	struct net_device *dev = offload->dev;
-	struct net_device_stats *stats = &dev->stats;
+	struct can_rx_offload_queue *queue = container_of(napi,
+							  struct can_rx_offload_queue,
+							  napi);
+	struct net_device_stats *stats = &napi->dev->stats;
 	struct sk_buff *skb;
 	int work_done = 0;
 
 	while ((work_done < quota) &&
-	       (skb = skb_dequeue(&offload->skb_queue))) {
+	       (skb = skb_dequeue(&queue->skb_queue))) {
 		struct can_frame *cf = (struct can_frame *)skb->data;
 
 		work_done++;
@@ -66,8 +65,8 @@ static int can_rx_offload_napi_poll(struct napi_struct *napi, int quota)
 		napi_complete_done(napi, work_done);
 
 		/* Check if there was another interrupt */
-		if (!skb_queue_empty(&offload->skb_queue))
-			napi_schedule(&offload->napi);
+		if (!skb_queue_empty(&queue->skb_queue))
+			napi_schedule(&queue->napi);
 	}
 
 	return work_done;
@@ -125,7 +124,7 @@ static int can_rx_offload_compare(struct sk_buff *a, struct sk_buff *b)
  * from the device and return the mailbox's content as a struct
  * sk_buff.
  *
- * If the struct can_rx_offload::skb_queue exceeds the maximal queue
+ * If the struct can_rx_offload_queue::skb_queue exceeds the maximal queue
  * length (struct can_rx_offload::skb_queue_len_max) or no skb can be
  * allocated, the mailbox contents is discarded by reading it into an
  * overflow buffer. This way the mailbox is marked as free by the
@@ -146,7 +145,7 @@ can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
 	u32 timestamp;
 
 	/* If queue is full drop frame */
-	if (unlikely(skb_queue_len(&offload->skb_queue) >
+	if (unlikely(skb_queue_len(&offload->queue->skb_queue) >
 		     offload->skb_queue_len_max))
 		drop = true;
 
@@ -224,7 +223,7 @@ int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
 {
 	struct can_rx_offload_cb *cb;
 
-	if (skb_queue_len(&offload->skb_queue) >
+	if (skb_queue_len(&offload->queue->skb_queue) >
 	    offload->skb_queue_len_max) {
 		dev_kfree_skb_any(skb);
 		return -ENOBUFS;
@@ -268,7 +267,7 @@ EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_timestamp);
 int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 			      struct sk_buff *skb)
 {
-	if (skb_queue_len(&offload->skb_queue) >
+	if (skb_queue_len(&offload->queue->skb_queue) >
 	    offload->skb_queue_len_max) {
 		dev_kfree_skb_any(skb);
 		return -ENOBUFS;
@@ -307,44 +306,46 @@ EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_tail);
 
 void can_rx_offload_irq_finish(struct can_rx_offload *offload)
 {
+	struct can_rx_offload_queue *queue = offload->queue;
 	unsigned long flags;
 	int queue_len;
 
 	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
 		return;
 
-	spin_lock_irqsave(&offload->skb_queue.lock, flags);
-	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue);
-	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
+	spin_lock_irqsave(&queue->skb_queue.lock, flags);
+	skb_queue_splice_tail_init(&offload->skb_irq_queue, &queue->skb_queue);
+	spin_unlock_irqrestore(&queue->skb_queue.lock, flags);
 
-	queue_len = skb_queue_len(&offload->skb_queue);
+	queue_len = skb_queue_len(&queue->skb_queue);
 	if (queue_len > offload->skb_queue_len_max / 8)
 		netdev_dbg(offload->dev, "%s: queue_len=%d\n",
 			   __func__, queue_len);
 
-	napi_schedule(&offload->napi);
+	napi_schedule(&queue->napi);
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_irq_finish);
 
 void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
 {
+	struct can_rx_offload_queue *queue = offload->queue;
 	unsigned long flags;
 	int queue_len;
 
 	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
 		return;
 
-	spin_lock_irqsave(&offload->skb_queue.lock, flags);
-	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue);
-	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
+	spin_lock_irqsave(&queue->skb_queue.lock, flags);
+	skb_queue_splice_tail_init(&offload->skb_irq_queue, &queue->skb_queue);
+	spin_unlock_irqrestore(&queue->skb_queue.lock, flags);
 
-	queue_len = skb_queue_len(&offload->skb_queue);
+	queue_len = skb_queue_len(&queue->skb_queue);
 	if (queue_len > offload->skb_queue_len_max / 8)
 		netdev_dbg(offload->dev, "%s: queue_len=%d\n",
 			   __func__, queue_len);
 
 	local_bh_disable();
-	napi_schedule(&offload->napi);
+	napi_schedule(&queue->napi);
 	local_bh_enable();
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_threaded_irq_finish);
@@ -353,15 +354,18 @@ static int can_rx_offload_init_queue(struct net_device *dev,
 				     struct can_rx_offload *offload,
 				     unsigned int weight)
 {
+	struct can_rx_offload_queue *queue = &offload->own_queue;
+
 	offload->dev = dev;
+	offload->queue = queue;
 
 	/* Limit queue len to 4x the weight (rounded to next power of two) */
 	offload->skb_queue_len_max = 2 << fls(weight);
 	offload->skb_queue_len_max *= 4;
-	skb_queue_head_init(&offload->skb_queue);
+	skb_queue_head_init(&queue->skb_queue);
 	__skb_queue_head_init(&offload->skb_irq_queue);
 
-	netif_napi_add_weight(dev, &offload->napi, can_rx_offload_napi_poll,
+	netif_napi_add_weight(dev, &queue->napi, can_rx_offload_napi_poll,
 			      weight);
 
 	dev_dbg(dev->dev.parent, "%s: skb_queue_len_max=%d\n",
@@ -414,14 +418,14 @@ EXPORT_SYMBOL_GPL(can_rx_offload_add_manual);
 
 void can_rx_offload_enable(struct can_rx_offload *offload)
 {
-	napi_enable(&offload->napi);
+	napi_enable(&offload->queue->napi);
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_enable);
 
 void can_rx_offload_del(struct can_rx_offload *offload)
 {
-	netif_napi_del(&offload->napi);
-	skb_queue_purge(&offload->skb_queue);
+	netif_napi_del(&offload->queue->napi);
+	skb_queue_purge(&offload->queue->skb_queue);
 	__skb_queue_purge(&offload->skb_irq_queue);
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_del);
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index d29bb4521947..fafc00fc3700 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -12,6 +12,11 @@
 #include <linux/netdevice.h>
 #include <linux/can.h>
 
+struct can_rx_offload_queue {
+	struct sk_buff_head skb_queue;
+	struct napi_struct napi;
+};
+
 struct can_rx_offload {
 	struct net_device *dev;
 
@@ -19,16 +24,17 @@ struct can_rx_offload {
 					unsigned int mb, u32 *timestamp,
 					bool drop);
 
-	struct sk_buff_head skb_queue;
 	struct sk_buff_head skb_irq_queue;
 	u32 skb_queue_len_max;
 
 	unsigned int mb_first;
 	unsigned int mb_last;
 
-	struct napi_struct napi;
-
 	bool inc;
+
+	/* Points to own_queue. */
+	struct can_rx_offload_queue *queue;
+	struct can_rx_offload_queue own_queue;
 };
 
 int can_rx_offload_add_timestamp(struct net_device *dev,
@@ -59,7 +65,7 @@ void can_rx_offload_enable(struct can_rx_offload *offload);
 
 static inline void can_rx_offload_disable(struct can_rx_offload *offload)
 {
-	napi_disable(&offload->napi);
+	napi_disable(&offload->queue->napi);
 }
 
 #endif /* !_CAN_RX_OFFLOAD_H */
-- 
2.43.0

