Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794227571;
	b=Gi30tCFUxOto4BZANRnzIuj3EmRFdjh5CLDgw06F/WIZDejnu7vEn7nRatx/ZEQBLui1
	 DrlDD74kfZ+fTez4aE1OHQkccLmdRSlBajEqQvAbcwZLvc2k/cTXqEHKqova2k0gRp7V1
	 mMqwdquiWwiUDddz2i8ktw1H8ZXjGm4kcCn7TtUXzdrujtTku6LPVkcu2DwxprJkYRjJ6
	 31fJI9t167idugci3zBec+e+CR//WalvGx56/jKO261kb2t3FcrpPFHXh8xeUYxFYPnQz
	 TG0ES9eofc2Gt3+W0+gJ/1dL0EJpeZZZ5ol7GtikydEza+DDV15Ha4zwh5sftkCPqxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227571;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Authentication-Results-Original:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:CC:References:Content-Language:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
	 X-CodeTwoProcessed:X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=F/vCcfystt6fsUMx3mAFNIQS4t9xpW+zh7gMh91WnsE=;
	b=BtIfj2XboEXnaWJIILFuFub+jPctYWKjVzp4uXWUGZxgusr55Mzxrqr9+ZR699Ar8Lgo
	 38FnqFfokNiCDotgagyUx1nTDKFgsotiew3bXMsNjjUXsAF3I/k4i5fNF1C4GySQqaUas
	 b+TlMHpHs8s/OMKd2ZMBUZhIWzS+5IQGr2+Y+xq4qEiAVJI12kvXhA4kbzmURLAjpw2Vo
	 kTBCAJ4tWRINPAf2uxa8xLCinrk3jS3djK6Y3rTIWSsMtJ9yaUd0jFagOzeFiL4lqgymh
	 v9dHcjFP9uEtXZw7SI3bazFOtl8Y1kRN6ntv9odJ42V3qyV5hpPh9EZyReIMatmxWag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=topic.nl;
	spf=pass smtp.mailfrom=topic.nl;
	dkim=pass header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=W2TEp4rJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.124
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021124.outbound.protection.outlook.com [52.101.65.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E001606EE86
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 12:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E001606EE86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=W2TEp4rJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSDHtugj2moTMWzixeSMSoVy8cW6A288l71PWZtTO42YkloF9Z3s7DwCzOJ3PX78r9FJIWajus7vypVohT2zYJpQ3HibDxM2gbN7TF5sFpbNUXL6lzyZ2l3XZOP6fQnHiQYy21HSnCFWNI1K54XngxVBkEuhX0aescKwNAqhUg6312y14BSy57YoAQcdhU8wzXNvWXIX+0W3RM2pzgYdMGTSd2SnP8F+xjQn1F8UCxuuNzjpTUMXd/BN9dBCNfi93Cmx/pdfpmLn5NmFxAI2d3/TjLACHwwmSimwfD7oHV2JlXAX2P1Pld1rxmFFhzTxn8HP6Ve3OdwSlyNzMxnfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/vCcfystt6fsUMx3mAFNIQS4t9xpW+zh7gMh91WnsE=;
 b=Xw64vqiJ8kass3239JBrHbwaNJj2kUsphEBXVjWPoIPsIIp93DqFkqHT6F+BFbtg9qOmdQ2NoDTHkaKLyNNyKgTp+b133yDuQ5TtmFpvhC2Ugx2u8hPsaNxxlao5FbQfwBABB0VVot2E4fiEywh5VBKr/ZnIywUKcr+V5h+xBRO1uDam7EtBTRyYS44ZiAljr+QY8AoItQakNGMAq70KaDlkOxvhCMOUic6lSnWPUaYjV7o0Vh6w36BMsEa7HMjWTLqCDebYxb9iK3HlxJpcIPVQWvs7d3xHZBj/M5itW2mzv5zUOnU/hk+T3mgbi6Phfgm60Lie9wwIxD4WY+RKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=topic.nl;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=topic.nl; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/vCcfystt6fsUMx3mAFNIQS4t9xpW+zh7gMh91WnsE=;
 b=W2TEp4rJlCnUs5cQhV/XhoXGQNoljRkCdmVrf4ZAzyC72x3Z7Ao5KbFG1MMHl2MZN4/v06vzPsmiuO8y1eKR31jHZdAK/ta6AcUFPopc1MWS4kT4yBvBuk98odQ/luWSdVhL+jRyVeUWxCIcj0nQ4jV5oAWlZeprBvkJhK4dG0ajl3SP/wvuznaiALxpl9OlcPfc1SpCXnG5Tsgg0ywgChChYvaQet1xRlqQOZToq5INs/qL5FvC70ZHHDy53KQOlsLUqK/uAeRIx8ls8ufMiLkRYt1Bt7UsVJg/rgwWFaRCfJUWIiZz9mpsnZQjVGYeoqA48E2cK22o4Mg/15AeZw==
Received: from MR1P264CA0185.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:58::14)
 by PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:32:46 +0000
Received: from MAD0EPF000008BA.eurprd04.prod.outlook.com
 (2603:10a6:501:58:cafe::ab) by MR1P264CA0185.outlook.office365.com
 (2603:10a6:501:58::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:32:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195) smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 MAD0EPF000008BA.mail.protection.outlook.com (10.167.241.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 12:32:44 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.48) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 09 Nov 2026 12:32:44 +0000
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by AM0PR04MB430977.eurprd04.prod.outlook.com
 (2603:10a6:20b:7f5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:32:42 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%4]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 12:32:42 +0000
Message-ID: <8bbefef6-b6cc-4462-9d20-79bcca96231f@topic.nl>
Date: Mon, 9 Nov 2026 13:32:41 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] can: mcp251xfd: Always stop on BUS_OFF and call
 netif_stop_queue
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: linux-can@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol@kernel.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.12523541-9b07-4081-b2ca-c8093468f69e@emailsignatures365.codetwo.com>
 <20261109070605.9761-1-mike.looijmans@topic.nl>
 <20261109-kickass-thundering-mule-ead9e8-mkl@pengutronix.de>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20261109-kickass-thundering-mule-ead9e8-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P192CA0020.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::6) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR04MB12030:EE_|AM0PR04MB430977:EE_|MAD0EPF000008BA:EE_|PA4PR04MB9366:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e8ab41-88d4-4bb1-1a22-08df3e5d8e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|52116014|366016|38350700014|4143699003|56012099006|261021135927099003|261021130227099003|261021121427099003|261021123027099003|261021133027099003|261022105027099003|261022113327099003|261022075727099003|261022115727099003|261009223027099003|261026130827099003|261026140227099003|261026135527099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 TVj/6Ti8RSbNcth+PZcNdvVD6VLrGffnuZjxzSndQF2qYb8OlG87YUAvuOX0/57A5WlX4D0IrShYuDOYRPv+koPb47MZnZiCOXS5f5ZlHoSITy+aSsJz8qjBjR+x4vF7GzNeUmCiitatda3PU2qIiYD/T6146sRHZXNkroWzUr4/avyIyGlrgH/zZ20snN8tAmCAlKiwo+kdUgEyIY08GW5lavt1ANCMCmEn9yKFQXQjOv80FDaGTr/T66h0fp2QKV7wujqk+DBhX+KH2iGqtbXtBV0jSP3vN1NkFIWVGg7HhPx0HRaklvCXUa56ZQ3/VqSG73i+/y1k/Bl4VR0zrjMtrI0h8aLWbClgLMtcLGvaSqI60bJhW/7mkGJjEIc8Rts7YZ43z+Qhmg3a9qo4CwbCDMONNYIHKcxWKSujdaWMYuKXv2Lc7duEc4kfgqykbYrZvI8hfaYnr61o+AXePjgJCJCCcyYiJ891Y4aBqYW/RkRGhqYmxr5dG5HZkae+MXDe23DDtdOky/S/y8ma9CQev5lMFRJsiO1YPvippMrFi7GhNXaEGvsC4jkL+OzjlscfjqRVYVCcwvZrO+F+EVHBcbqoP3/tSG2bynroWGy8wnBf63nqwj/is24j1WxYIFQU53ydhoY135O0ZPZGGh7RwNQWAe70MmXiQ2ZkCZY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12030.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(52116014)(366016)(38350700014)(4143699003)(56012099006)(261021135927099003)(261021130227099003)(261021121427099003)(261021123027099003)(261021133027099003)(261022105027099003)(261022113327099003)(261022075727099003)(261022115727099003)(261009223027099003)(261026130827099003)(261026140227099003)(261026135527099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: mT9UoaGxmFmoaiTv9UBesM/HhNWx4OhHZxm1Gr0/6f1tGPhVTP2B97bG8ev+OAMGgvD/TdZdfRcbTcvbq9mc8P+g25LdC7PzWg6hbwkUG8+RkmcWxTzGM91Rgt0JKGomR8D+E63BJOxWE/gWsIjWVJH6mwN3DHIUmuVFVGTq/eTuqEbzDI6g+5I3dYl3ViHh8qEOh4tDO8SooCNLwNqg5iRf0rsZSclnL0A6LTgVc4V/ktDb3Rb/MDG8PMDqY0P30wAZdsth/THYqFQUzYCP8Dk7xNH35n/BhZcKEFV/JW7GuU7fewH6lYEb+8IuJwDu40EkY6g53NaDNoyw27wr+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB430977
X-CodeTwo-MessageID: c1c1b955-10c6-40de-93ca-d2b4347d811c.20261109123244@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MAD0EPF000008BA.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4289225b-f968-4a71-492a-08df3e5d8cc5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|14060799003|376014|1800799024|35042699022|22082099003|18002099003|6133799003|4143699003|56012099006|10067099003|261028144727099003|261026121527099003|261102123227099003|261022115727099003|261022075727099003|261022105027099003|261022113327099003|261021135927099003|261021133027099003|261021123027099003|261021130227099003|261021121427099003|261026135527099003|261026140227099003|261026130827099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	yz7OZ8bw+uPkw7crkQW7TyMd/crXBBV7PgRZCPYjRRZ85jyK1+hOn8daD2Rfj32NYYKf2KUSwEH8IWlJBvyWeNCStxaTXfC3ZSxnbC56u4I+IND6HMG/zreHXmAhITXQ0H+dCrV/Ax5JeWs8q+XoLEY4PrEFnQutGo1qzhu3D5pOW6xlp++kKSAt88LRDp0XJYge+ZJxeNm1fx7SRLhSzQFmEYRCvi/+l1XYOxI0FNan9Stm2OinGQr06WQ8AoYqS5ZXT3+K3NBtdUlbCZ7Wxl8Xb5gI22Uv+ey2iT9wykP9HGEvfjEA1jlkQ8g1QdVoErsLlCXIndrqxUOV1xdFNpWp74LGvm7Oh+qFiXLbPVCgL6I2ElvFrrkbDQE72xIkKRGYVK3NxfqP7tjvWiFIOMSvApLECzL7z2awaREXKMWFZnR79PKnQm9AyLSGbAGUyjLRPZcuB1UJ+kUC3FWcu4FzH1sI0E+6ni5FEIYPZeGblYgta6R0bpkFnzXx03Ub96pLAYxXRxhZSaM87IhwjlDidX7o+jnEZGPYFAnjeb3DaadsaPWhzLEuXVELddE1slPCDdr6QC68d09utd4FrZnpX67WUKW8uNbzwAGapXAbTyZfShxNiMiI5APGNETZwMZTrIcLHs5wzOVtLp2QQw==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(14060799003)(376014)(1800799024)(35042699022)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006)(10067099003)(261028144727099003)(261026121527099003)(261102123227099003)(261022115727099003)(261022075727099003)(261022105027099003)(261022113327099003)(261021135927099003)(261021133027099003)(261021123027099003)(261021130227099003)(261021121427099003)(261026135527099003)(261026140227099003)(261026130827099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SfiS6OnHEkTzFSSTpFFT9uYdfmBmk5tbB9jHe8ZM7Puixy7LXjPKXXEuF3vJZdQrVS4WfCr/YjbB9VWOiN7tP1VRAWo5HafrGXG3UE2oVWgBGn/53yYrUGbtaOeT49YqGon9FigseL5hK1EU/jZdXQqJzWKwKikaeO0BW0j/LhkqAoOE161yImIGPwWkOEfgpSn1RYFnnN3OlgsxnKk7jSZpx3uCL+b9R9/wgmGYMkQgUcfpYJhHJ+2qyaXckBODjA4GMNnAipqemBIbPvkfyrm25ClI7DoLwFDRGgVsm/gsfRsYHx2Er8IW9odMYUV0k39PK9oKuOJuX6k8bJ2rM1WkUUwZJa++3PV0dRp3U+7L+sTnLoEtUzGB4S6E2IVSmR9R9zRimcycRslZjOwGx6KglSCcfh4JfNMgpjTRxfcmfJKfxbEnOIdOPO62UwnX
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:32:44.9523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e8ab41-88d4-4bb1-1a22-08df3e5d8e80
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008BA.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9366

On 09-11-2026 12:26, Marc Kleine-Budde wrote:
> On 09.11.2026 08:06:03, Mike Looijmans wrote:
>> When there's an error attempting to store the BER counter, don't abort
>> but continue shutting down the chip as required.
>>
>> After disabling communications, also stop the TX queue with a call to
>> netif_stop_queue. When the interface restarts, mcp251xfd_set_mode will
>> call netif_wake_queue and resume.
>>
>> This fixes a hangup in either send() or poll() from userspace. To
>> reproduce: I ran "cansequence can0 -p" to flood the system with packets.
>> While running that, I shorted the CAN signals, causing a bus error.
>> Usually communications would resume after the CAN bus restarted, but
>> sometimes the system got stuck and refused to send any more packets.
>> The sending process would be in either poll() or send(), waiting for
>> the queue to resume. To "unstuck" the process from send() it was
>> sufficient to send any packet on the can interface from another
>> process. To get it out of the poll() hang, only bringing the can
>> interface down (and up) would work.
>>
>> After adding the netif_stop_queue call, I was unable to reproduce the
>> problem.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
>>
>>   drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/ne=
t/can/spi/mcp251xfd/mcp251xfd-core.c
>> index f441f2265299e..9770416b24723 100644
>> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>> @@ -1131,10 +1131,11 @@ static int mcp251xfd_handle_cerrif(struct mcp251=
xfd_priv *priv)
>>   		 */
>>   		err =3D __mcp251xfd_get_berr_counter(priv->ndev, &priv->bec);
>>   		if (err)
>> -			return err;
>> +			netdev_err(priv->ndev, "Failed to store BER counter\n");
> Do you see this error message? The only thing that can fail is the SPI
> communication (and probably some OOM) and if that fails we have a bigger
> problem. Can you adjust the error message, that it prints "Failed to read
> BER counter\n", which is a bit more towards the root cause of the problem=
.

I may have seen this trigger only once ever. It's extremely unlikely to=20
ever happen, but if it does, I still think it's better to at least try=20
and tear things down further than just giving up and leaving things in a=20
possibly inconsistent state.


>>   		mcp251xfd_chip_stop(priv, CAN_STATE_BUS_OFF);
>>   		can_bus_off(priv->ndev);
>> +		netif_stop_queue(priv->ndev);
> I think the cause is that can_bus_off() asynchronously stops the netif
> queue. Can you apply this patch (instead of yours) and check if it
> triggers?
>
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -156,6 +156,12 @@ static inline bool can_dev_dropped_skb(struct net_de=
vice *dev, struct sk_buff *s
>          u32 silent_mode =3D priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
>                                              CAN_CTRLMODE_RESTRICTED);
>
> +       if (priv->state >=3D CAN_STATE_BUS_OFF) {
> +               netdev_info_once(dev, "interface in %s state, dropping sk=
b\n",
> +                                can_get_state_str(priv->state));
> +               goto invalid_skb;
> +       }
> +
>          if (silent_mode) {
>                  netdev_info_once(dev, "interface in %s mode, dropping sk=
b\n",
>                                   can_get_ctrlmode_str(silent_mode));
>
I'll try, will have to re-assemble the test setup.

Meanwhile I'll post a v2 patch with the suggested changes. We've been=20
running with the original patch for at least a year and it made the=20
occasional CAN bus lockups we saw in the field disappear.


> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



