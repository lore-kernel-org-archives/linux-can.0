Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.133
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794207982;
	b=dtD+P4aTPl1RMDWgMdbWH6rdfwZXxTn7E9Mx31VLQfo+2/RsoFIvRDVtBapBAOyxdJ9n
	 tEo2nnv3Tm7H8RTp5SQymIWVcDcsBf2BSIIp3m4EHu5f2qy5AMSQhsSga5x/Rx7daBTor
	 zK41Hqq7rxbie9rU4+cb3kURzNp/DZLbKa1xvAUOhApJcBMab/p2GArzoM5p1l9HVU1dr
	 XeGYLPqUKGocwQYsQ6hGFX1lEZ+L0h0czTp0zESOOWMaqA/uuW1gM4QetCo62d2LZqkKT
	 V/6fjFxmU3TBTiJPebiwNfW1LWHBHIkVXBcU27SpUPqNz30n94k8jX5869vWhRb1aXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207982;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Authentication-Results-Original:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
	 References:X-CodeTwoProcessed:X-EOPAttributedMessage:
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
	bh=lbO8W9gVRSUidoeoa+VQkZYgcZiGmvCnFxkosXRtuu8=;
	b=BAXVLJExaAw7Jg/3GDQPkriP/G6N1y98+0rlkSt1W3QNDA+xR15s8xP0+6IqFXIK1A6d
	 CQLp460F8MxjohWVvhVh87X1pSPjEr8yAsdozU8JFv24AoWRjh680soEVFCqh5/3x3izW
	 vmZ96HuEbZqY28kzsaNhtgF5Z3RVnBb3GQmV1jxmtGP236mc9yfAoPkGcHmHhv0LIS9/P
	 BesgoKeToUoNpuC0uIKrYNavLakE+APKhgA/ENtLBDryQwojn8pIrBDCKdc7ffzL/YGRa
	 jCFFYS93lpj6RNDgvor6UwB6tc3dx8HOLqCk8j0brUF6woBECR4AWv9h/6jOlzkRS6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=topic.nl;
	spf=pass smtp.mailfrom=topic.nl;
	dkim=pass header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=qHjGOMzk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.133
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020133.outbound.protection.outlook.com [52.101.69.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48808606A31C;
	Mon,  9 Nov 2026 07:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48808606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=qHjGOMzk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxv3MVZmaN+cAUq1ONKpixQewqpv2niQQnupxRlgxz9lLe6VsFQOgbrwDU4FpJ2JVtXLWrLwVyn3MU5jqnwTmsv5kfs/7vLfoKMFx+riwy67yyzoRR/uYRn9J9BSmIBHCdqnKR84AjlzWshtlY5RY4oIpIxc5jDf/ZW0a70pR69RJyw00oWYZbobN2k+YHTY+PRi9iefkU0tBKrrIjJheM+2J/td0OXMBGMjF6+PJWUcCH1hDPyzZNbR8GzCttVxPHqHlyM+kilyMWc8uCeckDTIkn7sLS5lZBmt9R4WFDk+P4dMqv40/SLRJJsPZWLX1/8R/ThBkAB6Aqp7nrBXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbO8W9gVRSUidoeoa+VQkZYgcZiGmvCnFxkosXRtuu8=;
 b=CE4qvkhWcdEWD6m88red2QyI2NP8AoiYx4WehnsGGzAVR9t2g3AT8+hGbWSCR8Om2lD5fVUS05v1Yi52jzRTkAy6T28lPayajR+TN+LWY2GW3J8g6KRdKInFHiHwwphYpcVRRRbWMi+7xDBahRBlBvGbOShr3iFcmg3O+QSRVJsEUdMoiGo+Z67gefiGMS4EyyjClkLTjDMF1XfAPluDvr5l5Re62EWdLfFC7H18kP0GT/lprZcnGK3c2gPkwW5ZjVHwzzJN5BSgk8NPHU/uI7pAC3wbib/w13YfZZKxKYTKT0/kAy6XSI2O0x3qOBJFfCJdZPmRWls/MOXglLo/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=topic.nl; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbO8W9gVRSUidoeoa+VQkZYgcZiGmvCnFxkosXRtuu8=;
 b=qHjGOMzkr6WDKQPL/VwjQNH9wjRAayZ8YBaJWApuuHzIB46a/SRxguQ3630notD0XmTmunWo8+pKt3QMEpDKTxLunDU7csEC7obQCnhukSQ8a8Ts2NTQkd8+rJ43fG1FOEgkCffRG4CHK3MAHYgIL7JSm5JTkVSsqJXkbs0z1vE4gNINs5REktnQRS49FnxKJ0xyx22G5INpe4kz7QBPmyjN0oQ9vCaqyNG9Q1DnfuXiUJhUWYzIAnHbUai3b9yHaVTGJesHNKtl4dkYfYzej49bV8wMjPddl4qJbk4aiQlfmff8zrZxjf27I0ISRqaYFEaXWFj/8eK/ZTmmZTl7kw==
Received: from DU2PR04CA0320.eurprd04.prod.outlook.com (2603:10a6:10:2b5::25)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 07:06:17 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::77) by DU2PR04CA0320.outlook.office365.com
 (2603:10a6:10:2b5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 07:06:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195) smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 07:06:16 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.65) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 09 Nov 2026 07:06:16 +0000
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by PAXPR04MB8368.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 07:06:12 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%4]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 07:06:11 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-can@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: mcp251xfd: Always stop on BUS_OFF and call netif_stop_queue
Date: Mon, 9 Nov 2026 08:06:03 +0100
Message-ID: <20261109070605.9761-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0031.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::11) To VI0PR04MB12030.eurprd04.prod.outlook.com
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
	VI0PR04MB12030:EE_|PAXPR04MB8368:EE_|DU2PEPF00028D0A:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: eba8453c-c8fc-4243-e609-08df3e2ff2e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|23010399003|52116014|1800799024|38350700014|56012099006|261021135927099003|261021130227099003|261021121427099003|261021133027099003|261021123027099003|261022075727099003|261022105027099003|261022113327099003|261022115727099003|261009223027099003|261026130827099003|261026121527099003|261026140227099003|261028144727099003|261026135527099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 Lf7BOJxOY/GBXbmiOvNkesyHn+xV3HF+PCsMSkmLoE2ZFz+egHV1tH6padxbLhoZ80xgyysuYVqMBpw4V5x+RWqO1IXQlZHN8VByLx407hOzuLRjEJyOCFk+yFKnTL86HKOF6nAroRB507IXPIt3YmoiW/I0pQaZp+dxfqMwTjxNupyLOgb0Fa/C1JAJ65FXnA9H3Gycnssw+GwNviEMU+BoS4d5OE2wY4Cn7NslGwC72GDap6SsKc7uHoXA81k1dHbRyE2bs3HONc02s9l6/FnV4r+FMeEjl6/1ZMvUJB6BztILFvHeyw10k956x3zAWmS2UveY0lg53C5mRVeOMIfWipUR696PfOitwQNV6tJOfgNMRKFph7shNCAXkNXAVHPphMRJQxXACETE3VupM+fJkRov9kk/xBHV7ekeqF2taBIE1Uezz/Mbj9uDnWq2WYapplcAWgfrB9SFG+pU67Zc8bioyUez3jq33ucQXvfWl9BJOtr/eBH7q0JDJsUBe7gYTDCdKT/54yvjO3jr7Je7dWhhmoO7ku/vudq+W0DGcTD80c2kR9fTI9NPfwRJc2cGMBh8U44xPLmfE4lW0QicbXd17yneOSKAM4MPp8e7Jffaxih0POPsfw00xicje6vh7cskZIchFqDdG900uzYJP5/XtbMHvYDMO2obm3l5kfSBOuY4tbhavQ0EM9PaKDENVXuH9DfPzrmRdFcGgcNxttZr4GY/S4gPRyT/B48=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12030.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(52116014)(1800799024)(38350700014)(56012099006)(261021135927099003)(261021130227099003)(261021121427099003)(261021133027099003)(261021123027099003)(261022075727099003)(261022105027099003)(261022113327099003)(261022115727099003)(261009223027099003)(261026130827099003)(261026121527099003)(261026140227099003)(261028144727099003)(261026135527099003)(261102123227099003)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: FxSa1Uz5pNsSYZArt8pLO/7Py4UFZBkkOjRW+Sz2K+JLxoqnZjU925aOj5JYC9/7kOBfy6taKVPy7UG1ml/uUvB/JsMOhu5vUAw2VVBFdSbEH2uYmvok7Q2D+6fx56dnGb3aTB5BfRanH2i4zv7ykT+Bt9/Aw2uLLmDjxfi4qBW7LlX6041ObTe3x0EURVcgSu7vtoH/rRM7EzW1VOCj005SWpwqO9li7d8MEWKd8YLhdSmv2KoG9YTx+3/08gYBA3xyx3fCYNh11CePJHrAhD8WUoka25a/8whaGZWjmI3rs1nkfF/Y2h0KgtiL9GG4HWi27XBQ+ajZbSoQt/yzng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8368
X-CodeTwo-MessageID: 26ba63b4-3e7c-43bd-acfc-43b675f9eb1c.20261109070616@westeu11-emailsignatures-cloud.codetwo.com
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.12523541-9b07-4081-b2ca-c8093468f69e@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9f2fc825-81ec-4610-7f41-08df3e2fefcf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|35042699022|14060799003|18002099003|10067099003|13003099007|261028144727099003|261102123227099003|261022115727099003|261022105027099003|261022113327099003|261022075727099003|56012099006|261021135927099003|261021130227099003|261021121427099003|261021133027099003|261021123027099003|261026130827099003|261026121527099003|261026135527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	5ebHeC7XLkquoE0DMkTydzP4Ft5XmL/3X3cAD6f1I3qxhDbMuUjN+Q1HtH7o7IXOI1S8w4riU/5SOeiF1wbbrsIb/CVkUVbNmZRzHdNj5nEvsqtZ3c5LkloL+crFDyhh3Swgq7yDqnq0Uu0iFPthjjoKLxT+7l3Fom/fwKsntCBCdpvxnR7fAvmmQfV8QWdKDEgt/vx2S4tPF2PayJQ9L6PMvwCqAZi0q1EM+vZOC7ly4BmYH5TMATI4Gn1rB91Ixm7Y6jweSbamtryUfzdLZlIhrPmeAJLzTGGb1ZqXTrL1ESgZ1+OWeIUpgyX4nQLtOBwA+wGP7CaaXWpJPJMUaJHzRVV74loJJMb9VYuAa5FiP8zNPdTM7b3cOTjKsS1FPWcvybvgLIRSoFRkZcdDcL8lwzd3qr5uqdaQAkFgj2NzQo5RDrUEHd+gIIC3KXau6igz6qY1V14rtpBBLSyGPAEozX+JGGcxTLWgRnuRVSfwjxM415R/Wsx17COB3kPdPobgT5O877FOTNlpXW0wtYfDmQ+9QPskzPoLei1f8JU2FZncttJlTlZaAIDLZHkf/d92J1InZax3RXwURz2EC28dtSn9zpgwpoXmKriSdA2Zvjil9A7IqLpPwXSEdaZat4Lomsg3fDGqyDQsodDVFA==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(35042699022)(14060799003)(18002099003)(10067099003)(13003099007)(261028144727099003)(261102123227099003)(261022115727099003)(261022105027099003)(261022113327099003)(261022075727099003)(56012099006)(261021135927099003)(261021130227099003)(261021121427099003)(261021133027099003)(261021123027099003)(261026130827099003)(261026121527099003)(261026135527099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gy/47tA8Fhhb9NULee394A5nNsFu1UtUjzn6c1YGa87WV9+sDX/68ZonopY9D6TFbEGoM7NeBJfM0N//rOiQ1aKS92leaQskj8XIJ1RVtmvDWzHAd0QfH8Q67zpQfl8dPtHYCyw/fymoiXAqCbZxc1Q+Dgg8tUidn7K+yCpxcMVMYdYlk7U2tV9NibKQmzFd9oxWIuWVOB8Mi5ENoo+tSzYJp4JecIF4xuuu+dTeVIHRiB8/5EAQDnnBGpzgoB76fSPpOuuNT24abncs7IzCpCnsLtQbmy/Myjip0ElPwmxXfbi78GIrymr9uz2GW+0TvzG1g01uE6vvbIEijrd+MbJMJ2+DFhxBrk0JsByVyWF0Qa4zxjeDXYrBXTgZMetGHA9vQ5/6zG+jm784FJWYRXL6I4k5RF2IR+g3aNF1e+0jXsMLsh70Cy1FfNdfhVfk
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 07:06:16.8470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba8453c-c8fc-4243-e609-08df3e2ff2e7
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066

When there's an error attempting to store the BER counter, don't abort
but continue shutting down the chip as required.

After disabling communications, also stop the TX queue with a call to
netif_stop_queue. When the interface restarts, mcp251xfd_set_mode will
call netif_wake_queue and resume.

This fixes a hangup in either send() or poll() from userspace. To
reproduce: I ran "cansequence can0 -p" to flood the system with packets.
While running that, I shorted the CAN signals, causing a bus error.
Usually communications would resume after the CAN bus restarted, but
sometimes the system got stuck and refused to send any more packets.
The sending process would be in either poll() or send(), waiting for
the queue to resume. To "unstuck" the process from send() it was
sufficient to send any packet on the can interface from another
process. To get it out of the poll() hang, only bringing the can
interface down (and up) would work.

After adding the netif_stop_queue call, I was unable to reproduce the
problem.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/c=
an/spi/mcp251xfd/mcp251xfd-core.c
index f441f2265299e..9770416b24723 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1131,10 +1131,11 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd=
_priv *priv)
 		 */
 		err =3D __mcp251xfd_get_berr_counter(priv->ndev, &priv->bec);
 		if (err)
-			return err;
+			netdev_err(priv->ndev, "Failed to store BER counter\n");
=20
 		mcp251xfd_chip_stop(priv, CAN_STATE_BUS_OFF);
 		can_bus_off(priv->ndev);
+		netif_stop_queue(priv->ndev);
 	}
=20
 	if (!skb)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
branch: linux-master-can-mcp251xfd-queue

--=20
2.43.0


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
