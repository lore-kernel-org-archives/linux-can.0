Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794950592;
	b=HyT0+IYVX4I/dLrkf8Jy8hG4kF2H4hY3IOz243rVeCr9nYiKsV1tI/jem/ZDkiZ8zd5X
	 5frda+vcjsAOpr1ssiddgiNctz6jtp/XtDyFdd9CqGKO13yBLG5F5H4avaQDcurfG02rw
	 Tt+ifbEnrBGCCnmW9/L0W/Mwxf1Kb50IQku5/ReGpGnNo57giJ0L61Dal28GumzDrAGYv
	 QVYc5M5Y0ymesPBssPHw0p/4CKwFDmDxSXVD1yK8yUFu1j/VIoKg1Vd1PB9h3yAbDPls2
	 nnAS8mrr6Orp/j+6dgnpuxWrOC4YJ9qt2aKep8UhaNwGWmdFimGP35ioIVQ/i3NxrLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950592;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=v0c0GxcQrklu4mLcBUGSRhmvIdiDbDxk/VjhiR+sbSU=;
	b=L+C/DjARfTpkHmDZW+UGqkW1AJviHXqKw7dpfl9NpniOX/82iFAuEe7s9m1eSh0KvGer
	 UETjx3pFJJTktF5+5mKQsOxQuoByVVZsiu7reLuG9111A1bcDeG6PVzjatMRFhlWK7OBr
	 E/Dt4a0Vvlv1GfNrtgSZynP+E4+Xccd+Av1KDyyIj1XTnWghHyQBRYOZYqEskg0yzrIzP
	 D4IEOKFuPBH44ZPFyiFP4UQNStRrIa1d0Yo0WF5iornGTd91LLoPV3iuwgp5uKPRxkXZa
	 f/+vSLrPz6zKwTqelLY4FEyZbn1LWbL0ul9hnto3dy0l77CHvSSdicxaIeGDaNTnLeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=C9u78kpy;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=pPvMWuTh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6347F606A31C;
	Tue, 17 Nov 2026 21:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6347F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=C9u78kpy;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=pPvMWuTh
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AHKLp271494307;
	Tue, 17 Nov 2026 15:23:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=v0c0GxcQrklu4mLcBUGSRhmvIdiDbDxk/VjhiR+sb
	SU=; b=C9u78kpypCauVoPArxpmCbR0WM6OXimUDEWlLoB/rekez9G7vekJO2u8w
	QO2CO86oR0chkKfs4hPrGMTRQiRCnA4g7TefgAGGRZALcdeZs5xXt6awCxb6j+6X
	Q21o8xV+PZbt74cbpt7b0QOsltOevy0vEynneC7C/4I2tzWohaY+2hupFtlpt/Ez
	YqjFMEfniRLKLTBV/ZTMI0UC3htocGa0ekmsVo5B71axtT2rYV5qo5xgMWIWLVMo
	p0VVL1/aAj+nnQbtLotjAUyMcyPjALd2YQQkw3eC+csVYia5oiJCDCfXhHEQoZnl
	aqF1XgD7HPU5tOejyZY5umR0L1DjA==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	by m0384305.ppops.net (PPS) with ESMTPS id 4j0kxqv7t1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:23:00 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jb+Mb4LohT7hsPqwTgADC6QkJmfO0XfLP0O77m5dZOsyix12YzJNAq8SqE74UXctnNn7ch7Ylc5Pb4hwyysM24Y9zs6c2GpUBRXxvQ+peEsrF6icUNvH97XYXXu2/2t6/uKYh/BVrIkHg0mgowU57DH+CGq1sZKYJ2HjLqx1TR7UGQESoShal9Jn27+9GO2upMWtdO5Og1CYvNdKLYEvSFDST+/WAHFVchOv8X2DrewATyE/iGOdmTzSybPko60EuIq5MTycIFixezMO/7cmKOSJ7y3IPp+r0V9Q2VbgLDD6hSNQ893Z5xQ2wcrr651GA4MY5x6Ne7Gv0MuyC2Mj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0c0GxcQrklu4mLcBUGSRhmvIdiDbDxk/VjhiR+sbSU=;
 b=hAj4ct9Sej1Jb6qE11mHrs0xxyuJG4XyDYuYJuv0DQjsV4kWBVossCQmGArKI/wnwpsqO5u2r3i00xObCB2StR88TuMsYUgs3ki6gT2jJ6er5AnCMkZRm0TejlQ+EY0y3zdK86glnbrVKYypoaPDccbS5RJh+PmueD01bDA/snta8M4gXMv42RhwMsHaHYgXceMQrGEQsE8VTGYc00sZ0Af8LdBcKExNhKBZD6N/nSz4mqo6Fy38G3+1ist97n9KUeG+sFtVupBaGHugEFcrBi39nxMHJOBW+j33T/gHJ941WEpe/TLW2TJEHx73OpV7UCd02IDDG/U0Z9OZqX3iZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=samsung.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0c0GxcQrklu4mLcBUGSRhmvIdiDbDxk/VjhiR+sbSU=;
 b=pPvMWuThTjtpTzoP24ekhlB4UY+Q5h4WbYFsJ+pD3xBO7CDxYXLdJsRUfdaA1zqXh4emidUtGoPY8aItSQKUl5t9Rs1jceJZV9Ux7T3qDhbHw7+wTFx04FOKRCUoj/hhd9cZDt0h8kQnpgPh2JfY1XOXghfchYufqs2jDNKqIs4=
Received: from BY5PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:1e0::37)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 21:22:56 +0000
Received: from CO1PEPF0001885C.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::59) by BY5PR03CA0027.outlook.office365.com
 (2603:10b6:a03:1e0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 21:22:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF0001885C.mail.protection.outlook.com (10.167.249.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 21:22:55 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 15:22:22 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 15:22:22 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 17 Nov 2026 15:22:22 -0600
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AHLMLg9563881;
	Tue, 17 Nov 2026 15:22:22 -0600
From: Kendall Willis <k-willis@ti.com>
Date: Tue, 17 Nov 2026 15:22:15 -0600
Subject: [PATCH v9 2/2] can: m_can: add ti,am62-mcan compatible with
 out-of-band wakeup support
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261117-temp-v9-2-1d094ff918c6@ti.com>
References: <20261117-temp-v9-0-1d094ff918c6@ti.com>
In-Reply-To: <20261117-temp-v9-0-1d094ff918c6@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>,
        Marc Kleine-Budde
	<mkl@pengutronix.de>,
        Vincent Mailhol <mailhol@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>
CC: <s-kochidanadu@ti.com>, <a-kaur@ti.com>, <s-tripathi1@ti.com>,
        <vishalm@ti.com>, <k-willis@ti.com>, <linux-can@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794950542; l=3611;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=61skcAhvBeBg2WRUgMUqoWUGktj4d0tiaM61TjBwdho=;
 b=Mnij1m/f0Ko/qIkg4JbmMM8iZY8CSHQfWfHsuZxtTuO4QjFEdtmh83ybVbZJnbDTzslcnZS6Q
 c1uxKNmSJQpCsqTPbgOVi5Q2VXtHHB2zwWTj6wwn7lhlQph3fkO4wqK
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885C:EE_|CH0PR10MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: 46abd157-fb47-4b99-d2c4-08df44f0f25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700016|23010399003|18002099003|22082099003|261009223027099003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261022113327099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+hnQOY/gXXgJK3nyk9QBSAQ5k2GgrkJjXJK0M/t4rbAdSv5OXYYLUuBNmliTZCkt//gqeMgkLZJmyCTaJwO3PGW1EMd96CwI0uNeGl/jovtWK8zIT2DU7XFbnkX6CqvEhClfTpSn2hNsgukXzQb1wxlZacYnjSwywUS7K39ubOIqqDHYZguJqng3iyusGt/14h3czNIg6b+h6KxQ3bKH3KpeRpPlhGu7cZ1VxUfG4OV3YCR8Giv1eR8NbFFPTfwQQIi5nEgg6cyGWuResZz3og+WfhY6oNyQ4t3Wi8IjO+Fi4wBIzvtr2cC135DATSmOIcNDZ3DdJZqOhfoTtGYBHBYOD4b29aezLLYYqhTK8NKStbAPiGJQ/v8URDbvyLNrBkNujvfFYem7xgnGhzkWXCvPjsLI5bSmjeDsw1i/Y8hSax/fBzGb0eq/11xjn5C1UmXF4LxApoFd58umi/R2X7EAuISi5339YF5uDf+8vHH+AvCzG8JB5BrU8ocaNCCdgkOSd3e8n5R/F7Jg9NO7r3ySookWpEve+ofgrqVIFm2gXEMLaQEWF8omQZpllItMBgDAoJBl92zsrrVTkjkrv5F+vSc6ofYNaG2Z6RaBrNuMkPVQZhTZZRo1lQVO0yGEha0fK2JeyAurjxvQ+xvdajQiloJQwN7nfatZTl4ZQ+3ziK4V6vQ/f0BzgGcac63i4ehNwmOK/fIOEWfcqBv66A==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700016)(23010399003)(18002099003)(22082099003)(261009223027099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261022113327099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	59GI9Og6MJEudw2ZdvxRVhBApWXRc9+IASAxjAnGjgx9kuFj4LeyybfbqzMjg65WLtmbLER4/NWiBg2cAnf97KdlLQLPINpTS91ktVvms3KHWv/zaKtpar34sElmc2Xm0iYavgbC4CM4xFERNY3gvzCkd+o8fwZ6TOnw9XJpUa5PaZWOx5t95AqsVQW2nsulMNfbnFHqZiICBSgyLTJgal11yDJhvLiciJa/hRFBzBXiIYI/ckoJ3DmRUzigQdbYo+Y9ad2LfSgoPr8AYSrfGX2lLoM5ODofQ9nfDpJ9mVKoRwqElgb36eHnErX23HJDafW6hqbSm9Nj0qTP78fK8pzvGxP1UyRYuF+NV5fUKe89WTamucIHwik0F2idXE4IIoyxr83NANu1+9vlvwU3QDdlt2qFddIi6xisKeT2ktYSnSUMNnbemtsh4TUOlUN0
X-Exchange-RoutingPolicyChecked:
	ZXKy8+WSj8i7s2kuzL2s/h2sr7dO9e/5kMvwQOkfq0milW3CaQbz1H58hFxThzNFSdtuiY6flD9CwX8mIjxNDP4xhIB9ys5wMTeoKFYqi2R0yMtwtQaInTrBN3k1HnpcAA9UKtrYURJs5Wgs4toXtzJyyNPvh6c2XoNHuFqlWmRM9v7D6hYXeoX/gtSnPwX6xV2pmmKpEHz7yf/8/oyxJ5rJxXSweT6oEY3h3X60UxGIEv3EKnjwkwqo/icV1QKQTPP0o41y/L/PBD/RRd6mIRbyoFaCR9h4XNoSJhI+ub2/Q6Dc9UMYHXa8Jry2K9SP/Xg4+IwgwDKdNT8E/yVOpQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:22:55.7488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46abd157-fb47-4b99-d2c4-08df44f0f25b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-ORIG-GUID: ms7P4Awlq6qwVG2XB4HhhNIeWSpy2bAd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4NSBTYWx0ZWRfX8fuXse53fIla
 9wm8Wa9N1Dc78Uq8LG8RXe4zfUebvnCDvVpdzl7FSiy6UJ1B6QgnBRJ2TxhjUbjJQl6pgC56Vjh
 nGwmowR1WNmQOtfZGxF65GXUlp9T2NC6G83L/gIZlICxCrZeK2WFRbq4VnSBkrk7IQKbNnDlFHw
 WYXeJrf9l45TdG4m7fZEQ/+DydNU1Uq+wMoL8MmzZMwIvN2l7sMSAWrmDQzMdebbiaW/YZJf/yF
 UDY8NT0ZWwr0CJIh52yCqdxe6Bi1xLU6pMVB/4PFt8QJWVW00JljPjTBgZwMnclXhFn2qBPsH9m
 j2raMVTO/KcN8/GKcT7zd0Y0V+JT5OLULGx1kapAP7odI1w1HIei8beyFGVE0DscXXD2Mjydt9+
 WkkhVNGwM8EavQ9x0SOjKNX2YTpl/a5QhxM4Hdd/DbYpEirlDWkBT7VI8VzhJIvtrcC18hBu9RO
 4loVNWxgj53L0QbEMLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4NSBTYWx0ZWRfX4YKBkRACZI6M
 1D7UVTYtoSJ83rknyVzhM56EWap+9LG4Tsh0E4X4HkKr9NtKJgVcDdfQCZ4JUI2y2GVxOJbCUfC
 RVvBWBgiFaQXmu87qDbWWGi80Sy4s3M=
X-Authority-Analysis: v=2.4 cv=DqzDa2/+ c=1 sm=1 tr=0 ts=6afcc5b4 cx=c_pps
 a=skQXzUdJ1yZbsxdDph07EQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=q7fBzAs-YHYjZ8l8ll0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ms7P4Awlq6qwVG2XB4HhhNIeWSpy2bAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170085

In TI K3 AM62 SoCs, the M_CAN controllers are in power domains which are
OFF in the deepest low power states. However, the m_can pins are able to
wakeup the system from states where the power domain is OFF through its
out-of-band wakeup functionality.

Introduce the ti,am62-mcan compatible with match data to identify the
out-of-band wakeup capability for TI AM62 SoCs. During suspend, set the
out-of-band wakeup flag when the device is configured as a wakeup
source, the "wakeup" pinctrl state is present, and the match data
indicates out-of-band wakeup support.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 drivers/net/can/m_can/m_can.c          |  6 +++++-
 drivers/net/can/m_can/m_can.h          |  2 ++
 drivers/net/can/m_can/m_can_platform.c | 13 +++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16f80607e150e2ca2950616ff2c39b7aa13710b4..8943d83ff19c124840607adfbef66f1f843c5050 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2622,8 +2622,12 @@ int m_can_class_suspend(struct device *dev)
 		cdev->can.state = CAN_STATE_SLEEPING;
 	}
 
-	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
+	if (m_can_class_wakeup_pinctrl_enabled(cdev)) {
+		if (cdev->out_band_wakeup)
+			device_set_out_band_wakeup(dev);
+	} else {
 		pinctrl_pm_select_sleep_state(dev);
+	}
 
 	return ret;
 }
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 4743342b2fba3823819b9e2bc5b085cc0fe6d1e2..7b5466b02666a4e1d327e3c8d8a4b57efd0c6eaf 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -132,6 +132,8 @@ struct m_can_classdev {
 
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pinctrl_state_wakeup;
+
+	bool out_band_wakeup;
 };
 
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 56da411878af0185ff9cc512e325137428a68255..4d903cb7b39c26ef8b5ba841ee5808219f25b973 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -18,6 +18,10 @@ struct m_can_plat_priv {
 	void __iomem *mram_base;
 };
 
+struct m_can_of_data {
+	bool out_band_wakeup;
+};
+
 static inline struct m_can_plat_priv *cdev_to_priv(struct m_can_classdev *cdev)
 {
 	return container_of(cdev, struct m_can_plat_priv, cdev);
@@ -83,6 +87,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	void __iomem *addr;
 	void __iomem *mram_addr;
 	struct phy *transceiver;
+	const struct m_can_of_data *of_data;
 	int irq = 0, ret = 0;
 
 	mcan_class = m_can_class_allocate_dev(&pdev->dev,
@@ -148,6 +153,9 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class->is_peripheral = false;
 
+	of_data = of_device_get_match_data(&pdev->dev);
+	mcan_class->out_band_wakeup = of_data && of_data->out_band_wakeup;
+
 	platform_set_drvdata(pdev, mcan_class);
 
 	pm_runtime_enable(mcan_class->dev);
@@ -218,8 +226,13 @@ static const struct dev_pm_ops m_can_pmops = {
 	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
 };
 
+static const struct m_can_of_data m_can_plat_am62 = {
+	.out_band_wakeup = true,
+};
+
 static const struct of_device_id m_can_of_table[] = {
 	{ .compatible = "bosch,m_can", .data = NULL },
+	{ .compatible = "ti,am62-mcan", .data = &m_can_plat_am62 },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, m_can_of_table);

-- 
2.34.1

