Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31423ACF10;
	Wed,  2 Sep 2026 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788383058; cv=fail; b=f00Hk+muigxZH3PT+WPpoYw6KxQr/0BAZocTua0aVl/9qP8LzE8h4ALK43Vmgz0xqhbmunrDOB0TNALgWyIwtsv/fCMLLOhw4Jsz5sJ9mnVs4MfwZr41Vt7VTtGkp9TW1yT3vX8qgXo9wHwZxW05ko4AOysjzI37KgaJvJ8m6LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788383058; c=relaxed/simple;
	bh=GQty70LRzLtR8i8ajZBQw2ecHqsTQU4xqoQTrtvxkrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=l3YPkvrOWu1SoYwzQJAXLf+NNeVb8bsRRT5IACBuM9nDT2X2l6nmcVSnCKxPaURybA+kjHGKV1mgOtocB+1KgyWCcw3kQcc3p0idcUYbZp1OoWOJLDp969kCvxf3Qy6/qctkH+7V3RTdHxQN0WSYDrPgo7rhtgywaEYTjrAE/ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=jSbPqWUb; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lEGyEeUQ; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="jSbPqWUb";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lEGyEeUQ"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KIJx53395511;
	Wed, 2 Sep 2026 16:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=bOocpaBdhYG1d+5xmj1E539OJyG0fm+EO1jVSCrZ6
	4M=; b=jSbPqWUb3zpSyGhlElj4i1K93r4zu/+MaZ1zQOVNIubqo4MxG5WLUDuLY
	UGMzMqnqyllcwK71o4dReAnc96GKg5u54of3S0LLzE4+RXGMoZ0keSFnVJtTr6Zu
	m7HQ0ZvJ20/zxLjGo2KFkSGxyRYQSfAbnbXltBiD1ija7DduxE7IkqxOY5US4wad
	r41wEe9hCwxGCrBRLrhMG6/YbaY3TYC+eOoHV0erLrQZp/iKl9IekZvS08QVvD3f
	iYAoJm6SnqscAUsTlLy577u/bMaygGhvGfKBtpPOgqkJfqGIgtaAuv/1UG6e0aWm
	sVrtBgLWkaA3TpHqwJ3332cZcmrdA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gen86jxqb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 16:03:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWG6gPBTcEm7URws+x1vyAtditkriTKIfoOIpEdayaG8GDI7Q3HC90q4ogF5JFZtjGEfWgyATQrP8mrZsPvWdfAIQsTCwKaQ79QiObe9j+2bOa9DKddZkerbF44euuEIyHFIr2j0A1zV9Ze9cjN/bx42EGD0mGQAu4kB9QC+n38A+ZgOAQl/WVvwrHmD9eamkGQEyPMivyMZxsYr+9xjGWU5ANvGCSVbHDqaG3AjBKIScCNyk1m/JEkKNkB1wYqgD/PNCyhg7k9sXmau4noTdAy+nBQTa3EBoaJrqQI4adwLLVhkstCma8fGcB6sPR47gGS7+X3PTptStF7yJFSz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOocpaBdhYG1d+5xmj1E539OJyG0fm+EO1jVSCrZ64M=;
 b=MhyNpE+zMdo+Z0ysjo0Fen1WYf2ne7pdg0CZT4O6Z3LZnZZPzroKG9o0vh6Dl87tv3YDzDt0DbZSDUzqbZ/Ncg0PH8hdcPkdhA9vYz5IiPFwaXizzgm8z5r4x6/AjKzhWG/1Pv/HUm59S9FB5llewJxDrCFurHhwnO1oqjI2+cTieh7Z3YEqSdWawwEpKAzzrVXAYPRSJ1MtT4rVgvq+lp5orAvmnE+Ivd/NpeCM6cDcVx5zDFb3X5ujnAJRNLAa1k88qp6FTCIh6MxmRYMXWk6S5g02BrOdl+K7XfTgEDai7p3URNaP2JOgP1hInoHUUe15zJXHNhcd+PnacgMBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOocpaBdhYG1d+5xmj1E539OJyG0fm+EO1jVSCrZ64M=;
 b=lEGyEeUQ34dWZzxr3AI8ykie9VztJbEHe2leo3wmbZwnsFZzD48b1jEDqsmYIIu32NDwaqSIvvVdebkWcY81m9Tjx1oq6c5clnMj3OXAYNLuYPTcN1+rlCvxlDsdoadBBQU/+36MVvZ7gXXJ8ziIgbiZi8xgPPtKKDXqKZXBwB0=
Received: from DS1P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:453::9) by
 DS7PR10MB5166.namprd10.prod.outlook.com (2603:10b6:5:3a4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.10; Wed, 2 Sep 2026 21:03:53 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:8:453:cafe::96) by DS1P223CA0013.outlook.office365.com
 (2603:10b6:8:453::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 21:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 21:03:52 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 2 Sep
 2026 16:03:32 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 2 Sep
 2026 16:03:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 2 Sep 2026 16:03:32 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 682L3WUL267827;
	Wed, 2 Sep 2026 16:03:32 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Wed, 2 Sep 2026 16:03:27 -0500
Subject: [PATCH v4 1/2] dt-bindings: can: m_can: add ti,am62-m_can
 compatible
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260902-temp-v4-1-3896f7d16ce8@ti.com>
References: <20260902-temp-v4-0-3896f7d16ce8@ti.com>
In-Reply-To: <20260902-temp-v4-0-3896f7d16ce8@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788383012; l=898;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=GQty70LRzLtR8i8ajZBQw2ecHqsTQU4xqoQTrtvxkrE=;
 b=NUgExO+GGQHZArv+fQoq35af7ZlSQswKvwVFB9J9xsoBw5Nlm+B2u7BSCaG8WWCZKugpIsoVJ
 KNHRkSFMxPyDwWxfFg/cfzvKm2UJajGUFKlglZSzjL3pRvEmaPLHOu7
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DS7PR10MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f83a26-b02d-443c-11c4-08df0935b1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|7416014|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Z/Qr9i5vunvawbHAKv/qtPcnFjjhLYaqNa3Wy3P5e986Eyuy2z1h7Amuho/wXa6T8QeF8oiAJk2A+SbMKTRSe2Jpk207FnbA+2i5lOJd3Mum+Btv2+z7T5DQPcnZxpl9mnTK5ONS+Iks91tj0fVxuUoDNMT6+/t9rHEVvfZcRgzjgRwJrVK2PrKuMGQjns9GlJSdcQTjec2uPvi3JX1lsnMEUkZ18R/RdDCsL1nsTwjIs5cK21xv8cfeqg1QMkSFCoHqIjJ37Wd5v2milUvsRMfE3hFXklRwdBKbEg+bbwuiMx36anQunlu0Aah2DFbbFHQQNi7hdjWleCaO5WZ1RX7ucR63TbRLD14IKrIdR15ZioOAxwlbx3CGLaqft+EqvW3zr3wbmA70YMayG0sV/dN4yKmkTsCorGUx5sn+NxP3erPZI0stNCWR0WyjE7gkUc+395mro3sOmgoBhSAcZbIk6vmf6VhTBii8KZnNU9G+NYTNDkBl/w9whattFRD+tFvWuzaDnFmr35WW8ZUnpfzAvGMHkiLEGVQxJwDj9da2sqjZ2/uuifNnIRamc/XmdBoWRf/n0RSQBahqrBVHTvO9RJjllw2efdGJB32/JqHjzRdaZ2R2fn993vPil+ho7r8YSMTDloF9cR79GbGR6PQYRP6HHePM8gdi50OCdOfut3/b6PwKTQlHgBOXe6JUIwJer4KEBuO446U7zCRn2w==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(7416014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qqqDC1N/RC7WyDO2KW9qKS/of3NCg139mucmDTHiwaTLwzUaRVOy6L21qs/Wz5WWK3qLeuA5ctmD89QJvm+1WK88lYG3oeEfrjejwgnWq60HrtIZGCeSzt3UzSWo8RiNIaR1rrBXEYGwEo/cTL5r9EqKkPw2VvBDhXYr0FuVtzvR9FesjbH43K5MCKbJYj345j5kh3wRKdSw1++f0xLtSSPiykV4t9sXIja42zY9T5I1TSUitZTF03o9t/Afx79lsQ/oWXwJkk9K17YFUCeq/xt+wP/+claCYkI6UiVxJ7vTCJ8BgOBPOegvDyNpmulL5rXC0ciMsfoRgMZh1WVdlfeZ6rCiyLGA3/pabbYUq8HNDFu/ejA5+d716cksyg5/i4ysR0NpqFbG9qsNPPbwFInOffm47QQhFYzsf2j+AXvYi4r4WHyXWrHquQOGiRz3
X-Exchange-RoutingPolicyChecked:
	kSTuMkj17UOU6jwkQUxmMQaICfFtZ5yD37UfIHbgEFEXNcvBfckdEd5NBTvsprfYKVWKGx8Kr8IBzFQiyzvlR63PbmhlnLfb/TNZ5K00srU6yY8q+zVcTE3IFqaG7xQguwK39nCdjQTc486X7R1Iagc5+SBnkRCVQ3EmjIKNMN78FGXQoMsDsVJOUKjHDQ0PmkXNZWmY9SIprN9lUDZcnOgC1NWpMQWZ3CXxeiMYBAoQs4GvSIyPBPe6V7/9l2MIRrInW1MfvgszO8Xn/k9uq4CJnQ5a6Dl06Xu0hCeUfnvkvMvMA6l68gHHoVqZygJoi/AkH8ITYRJi2DaiKkQv8Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 21:03:52.7667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f83a26-b02d-443c-11c4-08df0935b1ad
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5166
X-Proofpoint-GUID: AKCiE0KuI_c4jFFbm49McPbPKEdu2mhs
X-Proofpoint-ORIG-GUID: AKCiE0KuI_c4jFFbm49McPbPKEdu2mhs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE4NiBTYWx0ZWRfX6YaULe6kmOF+
 nEn94jqn9LuPBdGCv5TJcvve1fzuJdwcjt6NTtXqgfj+Ma1G9k9lHHe76zT3cP8BJxKBy2y/J4c
 P0iESS47eLzQtGhKu88O4MPiVM+UnhE=
X-Authority-Analysis: v=2.4 cv=HcMkiCE8 c=1 sm=1 tr=0 ts=6a988f3d cx=c_pps
 a=qNvklhu79FbMMzLDwJ4KEg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=rrEo7ybev77B6CUj9pwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE4NiBTYWx0ZWRfX4AjUTbl+nTyl
 qGYEO5u/KzYchu1349OZzVdTJ+vxxHp6KhTGHVdSW2Z6+C7u/xqLx6JcNO2nBuHfrqXTWudQ7q3
 NQpqdkVCSw3L7qTO0+siAwY7RrRQDvJ6NoJmMibFyG2pywTJOdhXhnVKTmJY9M2etcBmrLNW4gU
 xFRybXvGtwZYCyRKWYjzV4jJ2uDq1Ew7vd0JLdIuJn35OBtpZfoEE30kf6dIhbwtxat9aER7YLB
 JATsSm2Mpj5nUDVLtdM73k6PPCp472FY7TA4tLMh05hYkU7OhRkL7wdZDN7YS6kP1QFVFmnYWQd
 tgFTenTJNLw7XcVfA7hlcMpbfB6HG/hbUcmD9/SYNlQASBqphhoLZyWcUlmej/3+pE2/EFCZZ3T
 Ty0/UfsmxMYMgzQk0u8/d21c91Q3vLIo1h4XpwGb8B39NaCKzuKgpGKKvY/0T/tnC6HZHj+QARv
 cmBHSLKcn9mbw2Kjk/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020186

Add "ti,am62-m_can" to the list of compatible strings for the M_CAN
controller binding. This compatible identifies TI AM62 SoCs which
support out-of-band wakeup capability.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index 2c9d37975bedd652b3060ab11ba75c37565edaad..89e5a44453372c57506e9cf3a009b55a70cc4446 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -16,7 +16,9 @@ allOf:
 
 properties:
   compatible:
-    const: bosch,m_can
+    enum:
+      - bosch,m_can
+      - ti,am62-m_can
 
   reg:
     items:

-- 
2.34.1

