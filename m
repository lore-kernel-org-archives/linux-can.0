Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831E3806C6;
	Wed,  2 Sep 2026 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788383061; cv=fail; b=fPfrGoiTIl2YNZetgoQqog6cwzMKq4nIychEPguVUqBCFkvpCTmONyiJRaoL2pEE9JVFAMqIDBKqg8EHxmSazT2cFvHPKywasKkzTI7ET/4novLE3Wdidwlg79pphGdbxppckWF6rXrlpyq7FAVcqJ0/bkRZu2DkHTWAhOPQWfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788383061; c=relaxed/simple;
	bh=2+K3QL8d0R94KEeGdrR61ULnSC8I+VIw2BXcqSfNM2A=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=rRwXyVK5C2U5TOntJhe8HqQYXrykAKy8Z5qhn4Z7V/HnygDVuTquwqd1JuIKJGE1v5XoT52roIDSgO6w2h60kHZ6VvHv7IWicJSE7f/n/S8C1R7vwl+aCxaklU3KBdoJ/xQ4M2/Te+gNqDcpaUeHlopCe2t+pJkjPKQXXv6vcKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=oMhaab2a; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MFfAPjMl; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="oMhaab2a";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MFfAPjMl"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 682KH4F83234081;
	Wed, 2 Sep 2026 16:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=sF0IS0PVt5+I7
	Vy7NHaBQnnR5ZnzPu5jXn6yTb+GgcM=; b=oMhaab2aJpo146tnPqt8CHvhSPN5u
	vUPyapWEa9rUDRCFmaUobtwDCCzGHYpCocrSJHnkNUgyhGjvAatwlmgn5XRTyUbc
	J23cVqy22J6fF+gU/Vs3/OodAjNcqUiWpDr1aAJoEjM633BIgpQEiHcSLN3A8kmH
	p81eZzp5DXVvXVyT+Wafo0jVAhA5D8ffCoOr7u39P7iyY/M+pCbGxE9R9SiFFpLD
	WEYJbfLgqIOcmlar0NDUaqoYWQmqxUQWxMtclslv7cg8uqb2E6hTcNyXiy8M0A0D
	WZpGIf2Q3GQpjpqZBwGrEDLeCwjILR2OYeclFgzOtlUENdDMzAkOu+A/g==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012001.outbound.protection.outlook.com [40.107.200.1])
	by m0380145.ppops.net (PPS) with ESMTPS id 4ge7gqfab8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 16:04:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKPw+rbtFtydluI6prnSOAdIO+5jMtHGrHrc0upjgq8Tv9LNXKRhogbxIsNTQ/6PJnOaC3SsI0T6SoDguxA6coTi7Rt2cqK9rd1SEN2A7nx4G5LnUbhUewrQnB1taIyAnwVZkCNjU6CIB7qjof18zTtaK5FFNJ2p7d0gC9PXgiKSBLsHIIgMFm9+QfZsa35uy7BVe8D4CEkw3hc3rgKEnQIUwtjspLRbfSF55OspmW67MdXbvpsTfK48iKDFbSQ+S/44uEkg4r96gWzMd+SSoFrDOgEeHtGvONmOAWpQ5kWR6geTQthKrQIiT1zQXvNPdBl4eo8lbw3pKaPeEFcMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF0IS0PVt5+I7Vy7NHaBQnnR5ZnzPu5jXn6yTb+GgcM=;
 b=KHGxmLQ6mdGfma3bU0zGnqhYgwVmuAGMMOIedpgCRJai53kvGos4wLkRnJqdG6fY41ZRWQTYffG1zi1F+aD4zODbgmx/ZPQ2zeg54hnftuRbULAX9yJO11yjO+WnxaZVwkPd8YC57eIFqc3oTBqf0mKmimkJiyWLQirIWt8RknNubmb5uN+pbZXttgvB/9lEXINnKLINQ/Rs1ChhG6M2hziJXNFq78j2LEZZvtdcS67Kid2tZF8g58XN/nQt156AEafL6rNjZfBsmOlbFDsFt5r7lzxOX8ACTyMyByxWT/jVBmUOxhtVCq50p5gXRbRj04ZLSmwYDTgDXplPYS6SHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF0IS0PVt5+I7Vy7NHaBQnnR5ZnzPu5jXn6yTb+GgcM=;
 b=MFfAPjMlmNUNukNSROBPByLLItXwfIwPC2qlx4hG7Sb1oQFxGY4WTK/N3eMwHttZow6NVupAEzgskNifldR+wtVoC2IyJJqptvq6OLId8PXlS8An+n9Z4O/Vr4X1S/7XEhWUm9ze7zoFNs0f2pP9AuYirHlU9X3uAugu9OGGrMY=
Received: from DS7P220CA0045.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::26) by
 SJ5PPF7A7588508.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7aa) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 21:03:54 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:224:cafe::61) by DS7P220CA0045.outlook.office365.com
 (2603:10b6:8:224::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 21:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 21:03:53 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 2 Sep
 2026 16:03:32 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 2 Sep
 2026 16:03:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 2 Sep 2026 16:03:32 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 682L3WUK267827;
	Wed, 2 Sep 2026 16:03:32 -0500
From: Kendall Willis <k-willis@ti.com>
Subject: [PATCH v4 0/2] can: m_can: introduce ti,am62-m_can compatible for
 out-of-band wakeup
Date: Wed, 2 Sep 2026 16:03:26 -0500
Message-ID: <20260902-temp-v4-0-3896f7d16ce8@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB6PmGoC/1WNzQ7CIBAGX8Vwdg0stgVPvofxQGFRDi1NW4nG9
 N2lrfHnOF92Zp9soD7QwA6bJ+sphSHENsN+u2H2atoLQXCZGXIsuRIaRmo60BK1romwqiuWT7u
 efLgvmdM58zUMY+wfSzWJeV0DKCQ01rQQbyNED7VpHSQBAowvldvbouK1PI5hZ2PD5lLCr62Qr
 +8TAgfnpFfWWCsK+jPkryHehsyGNlZ4pXipUX+MaZpeImvrTgUBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788383012; l=2071;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=2+K3QL8d0R94KEeGdrR61ULnSC8I+VIw2BXcqSfNM2A=;
 b=0CvOxB3uQcxa0Hxgp0hEQCEddMTFQ67ncCVPeBQF5H6HosGb5XLxjOgE9u2vbYsMJeYI3o0M+
 e98ub5bizsNDlu/5vAfrBHQ21QjN+Y5e50dnZ3tMTK1xCSV7n9YHOIc
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SJ5PPF7A7588508:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd540e7-cbf0-42fb-f20a-08df0935b224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|10067099003|18002099003|13003099007|56012099006;
X-Microsoft-Antispam-Message-Info:
	YoB6/peOi7sajJ/+wUPpLDSbShKyjJolPuIeW6H6dTlIZ3HffM4Fn7+WyHyjY7Ojn5HLM1XffMmYG3nn4uHS9oxmlTLFlueSdWGmSsqU5jF7C+2X09y7QCryP0sHx6ymCRj5bIG/FU2yayYWo3yiF2lEarZlk6cg2WWdajDXIfZuqEgMPE5jzlxMuSNzh/eOsIx/TT/48wvvlF8rgkZp3xi8dFpl2djgBMlRiWZOJ5N9kPRTyOO4aHYBZFy9zizv2IhMpffFT03ZxxoLlCJYaFCGxWIxFUpsJ/Ut9CeLT2HR5X87C0FTH3WwnfSMsM2+WtraO5co1ycz7vb8Y1GBCWgrq+2KVVuDrM8ww3ktw4UQ0ZN6EttxgUEaRGb7bgW7Ah3l4MoeDFLDe3xN8m0NNIpxks9eGVFLrEtgRkLweD0VVLzJ9VY0OiBF8NBZBRgtEa3YXyJ83LMeHZKPfAZB2epqNXEmQt3XGHaxTM1vi9u4krYqq2U2f6fyksi0D0tK6hDVPOGRfaoLTHiHwJtC20d7yh9S8Kr587MZYhxtA1a09EVxmXPpVVEOVesBi8JIfDfilFGlqWxrSRn5TUJ1YSA75egbqDf+6/DOYbklJF3Tz3STx7VttobE9sxkqZ80z/6RJi4mHxMAUY6Zszsy+f/Sfj6Mk6YCOWGIF+TFQqlHvYcFb8Qt6Bd0NZokposYzVV3cdwFSEubGoRL1mrx0w==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(18002099003)(13003099007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L+dHREb5A/bCrOb325zyhiXZkw86NyVDuhyl2tqmFLlif02SS5/Q8eidaiOz0aeKGeNocDUBPjfYGkPpHV3ps9GKFreUGGfalAJqGVSA2Bij2YMxZuHcwKGiXtzcEV2/81j7XvH/E8VpZKH0Ysg82nH3ehTIZVyhAkhJsM8KzIJk+hdLI1+UopajMHxFgxOMZVnW7g3fGWnxB2tVfuHkJBGmbeePAR/FcM87cGZpgJ2mOSCeLRZcnvtETGff7uxOdlsfJCmDF4vlKjyYpd18QPMn+KJMxKfxUC8Qw+9LO+esZnxHKm/Jv9Y2JY8yEj3DMdZ2LX9gFdfnRCjBCzrMT32YV5SpIK7jitsFe/l1xBgbl788mBf0CHwi0DDxnYL3qd8hoBFV6W13eBzf/zpchlfy1yej1KFs7rxzbuwA10EQV3EEXR/CSGOP9oRy6TOt
X-Exchange-RoutingPolicyChecked:
	d2M9G1it0mYBzxyIr7cvvRaxkxlQTyRJu1h3DX8U++ODZPzcEve359MvPStke+idIt2XejmNOilqSYS2qJze58JApVpauh7QIbUA5Kv1QGkoAHH1uY5bzk1DnP3TKAHbcE+Y8qegveXpOof/7nSilw+asZsBy2yHqs+wn/aySaDGNdXDtwnYiw05ZTdZMGhTUAmv8VlASyZC+mOXDiiIrH4TKZK+hkFcLAo5cKw1C+eL6UEa49m8hacdS75tj/g8roq0sKYnFaAn3g2HCwmWorcAoIR1Y8nFhZujPpkpLBUqE+t3Y6eCzlTyKIq1TALqcTm8IRvZn/G8eg28oIFJyQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 21:03:53.5503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd540e7-cbf0-42fb-f20a-08df0935b224
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7A7588508
X-Authority-Analysis: v=2.4 cv=fZ6dDUQF c=1 sm=1 tr=0 ts=6a988f41 cx=c_pps
 a=c79N1uTKLHxLQxOLln6vMg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=_apd-cNezfhFQdyv5gIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4b3ExLANA2Tzrx6cQueuoyOrJlm46dZd
X-Proofpoint-ORIG-GUID: 4b3ExLANA2Tzrx6cQueuoyOrJlm46dZd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE4NyBTYWx0ZWRfX99HV0WzRD9yV
 rmP7Fd/ex0sES4ZdZUnQYO6+sbkySllHt23eOcHUv2/LA5uJOLTOuIdlcbim8hIvWRFNBZLCxzv
 rWwO3+55qxnHAyjJjDQE3rbUSfJ0PrA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE4NyBTYWx0ZWRfX4k9LxlxfinvT
 ujF3ujHc4vY4TgQI8S8HZWwZWR2QSQMSyZadnDa34UrS45POIrQoQ/g/DBjjyS6x8P3WLivLSiD
 6J5/DZ7NRc6Ulejfl+T4QIqd0wFrAkF86pIu16B178JogW5odQKZHlTClIn+p8SGNNbKEg3jRIN
 jbCXQl+UtuX3WmikUAMNJGPDjk+Q+ZGd755L5kMd9BKFZcqD1JmDCQ/ZvIN4xLMn3rerqEtZagz
 KlfW5XffcuTAiLMtUO46vXVYGOrjBk/lW2TK/gpYsMAlZkr+xjpICjQcGjBhIYWnh2gUVkqOnSH
 kjLY8eD/nucGWsp3dE7ltA0Y4IE3jGWusGJzOkrs0251pmLTLOUXv+cWCKMooXKhyDKmv7ZRUT6
 3ZCgeplaXZE86JBbper50ow4W5vJzKRBi2c1Pjov3izrVsfIGf24V1G/PpMxE8Da6JooVz2BXuq
 R7TK+SAGY3nBYIWUenw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020187

This series introduces the "ti,am62-m_can" compatible which adds support
for out-of-band wakeup capability in m_can devices.

A corresponding DTS series enabling this feature on TI K3 AM62 family
of devices has been submitted separately:
"arm64: dts: ti: use ti,am62-m_can compatible for m_can devices"

Testing
-------
Tested suspend/resume with CAN wakeup on AM62P SK EVM.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Changes in v4:
- Remove patch for "out-band-wakeup" property in dt binding.
- Create "ti,am62-m_can" compatible in the dt binding and m_can driver.
- Add "struct m_can_pdata" for compatible-specific data which keeps track
  of "out_band_wakeup" flag.
- Replace check "out-band-wakeup" dt property in the device driver upon
  suspend with check for "out_band_wakeup" variable from the
  "m_can_pdata".
- Link to v3: https://lore.kernel.org/r/20260821-temp-v3-0-9ac1f8806929@ti.com

Changes in v3:
- Remove definition of "out-band-wakeup" property in dt binding.
- Allow "out-band-wakeup" property in dt binding.
- Link to v2: https://lore.kernel.org/r/20260820-temp-v2-0-dd3f8cacc15e@ti.com

Changes in v2:
- Create "out-band-wakeup" property in dt bindings.
- Use "out-band-wakeup" property to set the out_band_wakeup flag upon
  suspend.
- Rebase to v7.2
- Link to v1: https://lore.kernel.org/r/20260213-mcan-out-of-band-v1-1-af68d4c570b3@ti.com

---
Kendall Willis (2):
      dt-bindings: can: m_can: add ti,am62-m_can compatible
      can: m_can: add ti,am62-m_can compatible with out-of-band wakeup support

 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 4 +++-
 drivers/net/can/m_can/m_can.c                              | 7 ++++++-
 drivers/net/can/m_can/m_can.h                              | 4 ++++
 drivers/net/can/m_can/m_can_platform.c                     | 5 +++++
 4 files changed, 18 insertions(+), 2 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260819-temp-93299bee27b7

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

