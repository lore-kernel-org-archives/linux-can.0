Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D53B7746;
	Thu, 20 Aug 2026 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262010; cv=fail; b=NDpouWyk/An77SyqEmT7sS07VO+/oIVtwURZNgw3kA8Az0Oip9X5H9PAUQQehKvFDwCIfi0eITNnuiSGmnnP1RIxE6ByD40ovyWHz/zamx7Xqy+TAeC3mWu7iKP/ILxkuVbGEDZYKaty0E/G7bdcp1KCfs+m5fjZsMj/bpOrWsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262010; c=relaxed/simple;
	bh=zUw1h35bS6/sFA0V4mjV7BYrFqRx3kf9PoPM9wSEoNw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=MWueuIVkqr+grdP3K1aAT0nNWgOtOvZcxDP1CCsOEfbJ3b9nTi1BeR6HqLOhSrvCPbAk8HeCxGlquhhqWTlmW1yNIrlGP139qFHHIriIZ2D2/5rinryd/xKn9Sawvqu4Ixx6uNCp0AQR4cmbfR7QbxT3aKvK3u7YxMmEq9jPm1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=imaGdYaQ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HxAMFodQ; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="imaGdYaQ";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HxAMFodQ"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK6nw61537724;
	Thu, 20 Aug 2026 16:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=YYschFb76oiXc
	QzAC61q3tIpu2SAHXUaBRWIy3Bf97o=; b=imaGdYaQXrp1RoLXY+86n5WOGijbY
	wacfU/59CjkuYc/ZPtZiUPfQKhffWzY+0Q5eQ4FEcWbF/0r+cNRCdCH5ZPeYbvfx
	tw6JjyL57llJenAI0uKNTME9DYI2kS9hUUib8gX0HVLKF/q4guFrjhy5barcg4Zm
	AJs32H0sBhJtuIckl0bAx/h1FIOdG/ETyi/+pw1VicCemjYigoiNVrW3HvBn2V6O
	NuwKeOd0k4OXCDXFxvlRtK55oWEukcFuHWKGRQzB31FCfvhtudapABRcW2JFg+9e
	KekgI0EEyw3q1mz3T2ZycfVS7efRwwDQ2d4CLNxgtCQ+T70ncgyfd/wFg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g5qrkej8f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 16:39:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRKQ1lwUBZRiiCjnw0oDq373UsiR/LSiS+DGO+TxgE5c6M8PwXFan3hwxITgRH2VYJXrM354XQPnqwcQEnNlrBzyMLV1NsvNjo01EPCBWttN7gqI1k79ChsHlpz98GZq5/mxj2VhoTgg1+nMNdmZVy0QlpfBusCBDGlklC75j2iKqILfVxH+D5G2vA4lgO8jkkNKHrby23IKErts1b9V9pqSZ2bsvOeb5o0kr7dadMez7uKBrvAkqpzp4Wk7Za0BJwhmtCOICB9ayJUAL4gFQETFYaREoqR8r4MZt98k53f62bJc+FIL5IETQvaKXVrYZqdq7EHAmuv7G9HTxx6oeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYschFb76oiXcQzAC61q3tIpu2SAHXUaBRWIy3Bf97o=;
 b=Wzo6/8v1Wfe+oMaRUX2bo+wynUgFVNz0VApGoLNKsuxQgpFbMZZ5VNbXXGqXFTpEqiy5EMHTu2Xr44m1fFFPIRfgcChDdxTVOJY5jHvaFHzXttTLNDA+wcBUtDFaZTiz8B/6B9Fne6NL3oeH0J1uCUIHSAHcEj5yFhPTdWPpi06zq5iB5ErZl67vA48XKmWgFQtR8Axu+3TWihzh+YVz5woVSBGgdwbUGRhksWnaZVvL9tfa1nioNz28UJA7NcnV+xIZyKnGLrizys7Fe+oLwSICmFXNIrj8sQ43sN+6CnqWkdvuBfSJH6787eIGrxJmaphcX31R7ikO115EmuKA8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYschFb76oiXcQzAC61q3tIpu2SAHXUaBRWIy3Bf97o=;
 b=HxAMFodQfiA0HiBMK8x0s/7NYSw6OwTnDrq8o4HjGkQQ2pGRCz8o44soFPebdxtDYdivA4+NES5NZKGoUG0WIUuG8g5xTKpIb0bWzFOljlShvs63RPskYMFgaPPJpCrhmvm4CZ0xmO29uQXisMWt/srW+6he+EpnBNx1OUysnxU=
Received: from CH2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:610:59::39)
 by IA3PR10MB8539.namprd10.prod.outlook.com (2603:10b6:208:580::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 21:39:49 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::3d) by CH2PR03CA0029.outlook.office365.com
 (2603:10b6:610:59::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 21:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 20 Aug 2026 21:39:48 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 16:39:47 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 16:39:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 16:39:47 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67KLdlXV1940503;
	Thu, 20 Aug 2026 16:39:47 -0500
From: Kendall Willis <k-willis@ti.com>
Subject: [PATCH v2 0/2] can: m_can: support out-of-band wakeup capability
Date: Thu, 20 Aug 2026 16:39:39 -0500
Message-ID: <20260820-temp-v2-0-dd3f8cacc15e@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABt0h2oC/yXMQQ6CMBCF4auQWTuGFgXqynsYFm0ZZBa0pK2Nh
 nB3Ky7/l5dvg0iBKcKt2iBQ5sjelZCnCuys3ZOQx9Iga9nWvVCYaFlRNVIpQyQ700G5roEmfh/
 MYyg9c0w+fA41i9/6B6RocLHaoX8l9BMa7UbMAgXqqe3Hi712tWnuic/WLzDs+/4F89Hzf6EAA
 AA=
X-Change-ID: 20260819-temp-93299bee27b7
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787261987; l=1428;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=zUw1h35bS6/sFA0V4mjV7BYrFqRx3kf9PoPM9wSEoNw=;
 b=IK36Umj/ZVXL0sPYjMA78Y8uz6yE9Kxng/PdZzAx+zO7cCRTuwUpsX05dytYiAv9j5shyQBU8
 J0lfEPj/uzvCu92mcV5FQ6aoC8T1xEeqn8r2zDcRI+34DR8chIt5X3t
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|IA3PR10MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bea41e1-19c6-40e1-a61e-08deff038f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|36860700016|1800799024|13003099007|56012099006|10067099003|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	JP6rqUF3Ge/HANgnM7vrXv4nIoZdeGbAyEcoTJ6WV5b0AMMh6WGjMYjcytfjDnO7lVKQb0OY9HZEKMKqsIO5sXfA13Vga5qqwS8uM1D1iIXvv6e0BA/o1p5+gI/qPTiFpYcGELoY+BSVU5an+Aglh2uuCLk+Zrjr0qzZ/7ja+nJmkAiC5tv+4KAjDpzYuMxv5RaZzBj7K0YRZZEP+E35U3G6MQsbmI2X0/QnomhrUgoaa5Dv7F05SCZdBBfAUcZVNhc3USBWzqedYcNLg9iyskpN9PMwMELe5hVOeWawyU3h4MGvVclP3odd9FGXJ4TFbIGGjoeguP1rogacentzGxAtAQ0b0c+U2mFlALSYUARs7PZOU6zkuZTnMJNkEUnSCZNDQnudpeMOCD5zKaiAOxwliQ/dMuxvXTv2XKEAD/0DdtFYYViK5HpiivAOLkEXwD5YvlKpFS24Nb05/RJprfjtlXMyMzi4D9idDnR0taZeROjKBNYSBhq/VCamJixytTcB8+8zXs5OVw9/gj6kzhY4qY2ONssk+CsUityRF8/7UJltx69O4vS+vSYQCnkgm7m4dt9JYMixmh7jc3RdXNnl7KvF5S6urQXLrvOVNktI7tB3Si80gCtbZ8WoT9wdsDvvNfRwvwmG3Rswul8STS51+o76P/nReHFLCEk1SZC1Ag+JQQrX4DyeNLcMFuDdlQzInn7GGuJaogohtAZ5iA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(13003099007)(56012099006)(10067099003)(5023799004)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ocUwTm0LrRVWKk7SVNaCNkF+Miv15vDGwOu2BaPez+grYi/ON5It4nXdSQBzz87LZy5scQOUjRY0u+4IEWXrAi6Wust9NCvlGp/NDBEg7an9nCod9Mjtz8XLn0ANjucMMSfoVGB2x1P2Ndk7/ZLKG4oB124pfS9rWo0fE4AuC9Ys+54UgoRzFHNsCjUBIPRMT2QxTWpYyAiW4IvkTQAqRt8VUixAMp443lQCLJFb1r2o5Im3dbFbj7indFn0N++xVS9ajYmLS/+X/bIqmCm5eEbQ/oDWJNdWIDdB6cuTVk9elQmZZtc4V02YRNiWG8QttexzfeNtI1UTiCbpBIsKure8JfGM+UHp6Ds/gScVQ1JxNDcaAVMP74QT2C1iPxR4I9abTo9IF/nciyQsGAmqGdb/aOcPEF6g8b8KrhiHmqwGjLjOzObNEC49yoEs/QhC
X-Exchange-RoutingPolicyChecked:
	jnkhissFahdlIOE/WEiM+W2tGUpT5TDhQ93mEeqp8ztIJGd73QnpctOmE1ffpVAr/lVGj5hm1vhopNZrEU5RLXdrb5jM+Yp/y0yZaC5yc7pm/j6HX3qSZuiTIqT5LmbezAWvkrbuKHLpBdq/MKYeEul0LFe+9CJn+EqS8d0toX7BwCMsoeFHQ4Ieqgj3lUVMdKD7rpteX3ozWDfEcq8q99zfY03wh/5fmPnnb7hUE+oeETDyD5q0+kIAK8xfR6RmWsA7tABTDYBgq7viHYhbhElNmjo/RWumq46gZdTmIhvdIEZDu/W0HmjN01Aq+OnZAE430ErKXaybv0RlThjlJA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 21:39:48.2133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bea41e1-19c6-40e1-a61e-08deff038f0b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8539
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX+R9u6WcAuPkx
 62O5BA2nXnVdpaOYgJfIqDIH520qyeIMCzKy6E99vavVvvlSXdOp/FhktMWG2FBRkJbFhadSPm7
 gDaiCNRBJfU/xI+TNlf00cUzsdL5Y7VkXRfk4R9FOraVo0rIWE7WNySJx7Re5Xv2gqlQ77i/zNz
 CGWf0vgjIDZf7paP8YXfssZjUaucz6od3FjuUUsNuAJtqw4foGuzIWJ8LD6zOac7RoS+ipVXF3Z
 IDF/oc9811godBeO+PeIiiWnaTrk3/mTbgJIATYvFCyPPJHckXtfbOFb68g7RK4AuKtNNauqRhf
 WmgN9hXA9sZzCcwX6VfoJ14sCaKDEwfav9AR11wIeV9aNhtobgiwC5N1af1MqoBdDQbtIz5GZ/B
 t/0uKq3uL9rj1Mv6dXPiLlUOMrRP4uKI2Hn6lFEqHg1dmgoaDCTSOHMZWgucZIfAGEPyqkS01fp
 zc//lYbo0rwNMiA7sfQ==
X-Proofpoint-GUID: tdnBrUqOlP25b-lIFjpq_pZi5EWZJbCW
X-Authority-Analysis: v=2.4 cv=JprBas4C c=1 sm=1 tr=0 ts=6a87742b cx=c_pps
 a=nvwb1BjkeYK3HDx+lqLWkw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=7GicGiQX3eiQMNblofQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tdnBrUqOlP25b-lIFjpq_pZi5EWZJbCW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfXzRPXJHjeeQDU
 LjKgr4Pao1hhSeRPEb8Dq62OeDmYfHX/NU36sjiWCOLMSzr6wp8FmxiiUkfqCEMmNVFSVTIYrKo
 q4cXF+qVXnLx+qV2zVCC++wAn8Wwwvc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

This series adds support for the out-of-band wakeup capability in the m_can
driver. Some CAN devices are wakeup capable and can wake up the system
while being in a domain that is OFF. Allow the driver to set the
out-of-band wakeup flag during suspend if the "out-band-wakeup" property
is present in the device tree.

A corresponding DTS series enabling this feature on TI K3 AM62A, AM62D,
AM62P, and AM62X-LP SoCs has been submitted separately:
"arm64: dts: ti: add out-band-wakeup property to m_can devices"

Testing
-------
Tested suspend/resume with CAN wakeup on AM62P SK EVM.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Changes in v2:
- Create "out-band-wakeup" property in dt bindings.
- Use "out-band-wakeup" property to set the out_band_wakeup flag upon
  suspend.
- Rebase to v7.2
- Link to v1: https://lore.kernel.org/r/20260213-mcan-out-of-band-v1-1-af68d4c570b3@ti.com

---
Kendall Willis (2):
      dt-bindings: can: m_can: add out band wakeup property
      can: m_can: set out-of-band wakeup if wakeup pinctrl exists

 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 12 ++++++++++++
 drivers/net/can/m_can/m_can.c                              |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260819-temp-93299bee27b7

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

