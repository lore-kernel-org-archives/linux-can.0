Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA55D417D86;
	Thu,  1 Oct 2026 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872571; cv=fail; b=HlTI40UpLmLnvOa1zO5hgJoVewaYMBLUUa2brr6P49hTdB773gkCEqDkCNsuMic5PnFdMmU515iyHwDSGH+0JCBp/jlNhe6AEE4BgWTapG6amfHkbA9dw9GNRKF6DEFnQUh4d3krx+SlY+ozblu1JHivNMW5wV/Jg3nAIiCPoA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872571; c=relaxed/simple;
	bh=AUMsaI8OWrYkS65xiG/zLfbAIV2XFDitVTaUGnQ1NlE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=EDk7Lyt8AA6vtrMcya9CpzsJ7W1FG7Qi5B8HY8dZefJ8ZGGb15GsB824Sx0TtGNSuN9IGDKQwZhppXigj0wadrn79GYIJyL6JLKJUfgJ8lpJlCSfXkO3fb7fq1wBWwgPns+VHMmfz8TdYwhRebyXcziE3qit1NBgHQWtPPyvsec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ADSawyIB; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=bmFJZnux; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ADSawyIB";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="bmFJZnux"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691FsxvD1848571;
	Thu, 1 Oct 2026 11:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=YvIcROzidtR2I
	Zar021GAh3wpwhppGOWVFfwdnyXG9s=; b=ADSawyIBfQoa8jGhw7Fqt4MRHu4Ka
	jBIDrngL1+PutuMNFhVwxm/v3Zz1pSIEZZ2cPiVvaShcYgxkQv5tDeNt/bskxGa9
	+LY7NaiDSC1WMAbQCVnf/xs6TtsPaBOJVuv52+nG5JgAZCa6RdgbNjMTkAXigmKb
	zq3oKPdVmj0um7U9wjctp4CJcfeLs3jsy+EEwF9TUlwV4InanQZfS+cTeKDw0Vo4
	G9exCYdGLkppQImBMLBa/vFAFWf1WjDR8VD2s4cspW5He2PC72lYpMGy0y7dXT8g
	cpnYjPrR8fj0XTU/SxAjklhD90Ti5Kr9OVSJm4l4NlTi+laVrQtr1BaNA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h17djy005-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:35:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKC7kC14K9PkIkYkmi5hgXYRtwkg+OWvdf4kDXaAHON0YYH7e7MeOi6/QcrzVzlkig/7p5Zzouhp1gRqAPJaxygUXdBOj1GbPWUMvcwIjtqic6caY9IouR24zXdBvpfhAZqCsQAutLxdCCv4/57YMZYt88m/WN7MDrbyhXjZXVUestmpEKXpw8Sa8alu2ldxMmzjOTrjL/oYvBtnQ97FmHrZijIExISl5JgmTvrsyV4I09U8YOs12kX26CDr9Kgf7fQ4HZpHXj2LD0KtQNXfTVU+KYDzr8Fk6rHJTGi7D/16FXpbcgfIuurl/i1E7RlI+qJtnVD77VLjJToAyEvgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvIcROzidtR2IZar021GAh3wpwhppGOWVFfwdnyXG9s=;
 b=xEOIqMyUCgco156XxEjTHKSvl9Ym7ATmxF722UTLuuSIlBhDS+VYhr8Feb15uFpBR3KvSV1wlFjUAXokcIDYfYgfkrtbF3I2jxZpPC06Wl+AgHUzo191gXvxXF+mtwzsRSOFu6BCHCiPkWu6UfmFdxCqxUUhSQqiwdQkCagewUbdCzyWAfdAsrbQo3Ns20WXprWH4jzOuVog3U7Cwt7IyBD5p10hxSJU8w1CrjrHVypKtgfLnGCD/BXf+nHVNQarKS/sfggIm8MvCCBOme+o55MhaDNNDnl+JX/YaJ2QgV4RhS3oS76EaduCQrTSeXsYqkntJBNl3+LnQjrnCC71XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvIcROzidtR2IZar021GAh3wpwhppGOWVFfwdnyXG9s=;
 b=bmFJZnuxjoRccTyIBFARw0tSXdsH5AakX8c5N80TnikjFk4mMTW1WY+sOA3CCjanUJc6oACfFAZI3MofgHRm5sC6+3W3MlGQtGL6EcXRS2l4sioYkfm8ICj6TxKlTYX4MH1iuxwY1oy6y/Ojhfo/e+UtTWm7AVPIhURoEjX1fO4=
Received: from PH7PR17CA0033.namprd17.prod.outlook.com (2603:10b6:510:323::7)
 by PH5PR10MB997711.namprd10.prod.outlook.com (2603:10b6:510:39d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Thu, 1 Oct 2026
 16:35:48 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::40) by PH7PR17CA0033.outlook.office365.com
 (2603:10b6:510:323::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Thu, 1
 Oct 2026 16:35:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 16:35:47 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 11:35:28 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 11:35:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 1 Oct 2026 11:35:28 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 691GZSan2285140;
	Thu, 1 Oct 2026 11:35:28 -0500
From: Kendall Willis <k-willis@ti.com>
Subject: [PATCH v8 0/2] can: m_can: introduce ti,am62-mcan compatible for
 out-of-band wakeup
Date: Thu, 1 Oct 2026 11:35:22 -0500
Message-ID: <20261001-temp-v8-0-489dd82e4b50@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMqLvmoC/1XRy26DMBAF0F+JWNeRx2P8yKr/UXVhxuPGiwQKB
 LWK+u81jzZhwWIQ547NvVcD95mH6nS4Vz1PecjttQzu5VDROVw/WORY5kpJZaQDL0a+dMKj8r5
 hVraxVfm06znlryXm7b3M5zyMbf+9pE4wv10DFKC4ULiK9jaKNokmXKOYQIAIybioqbaywdcxH
 6m9VHPSpB7aKbmun5SQIkZMjgIR1LwT+CxgE1iEDwTJOWm88juhH8JLtQldBDpvko1giN1O1E8
 C/kRdhGJUEqjcVO53mGdRb8Is90igAaJBop2wT0LpTdgikpaRE9e+tulf/Kw19Px5KyWOaxePD
 k+HbbWeM1CMbZdp7WK4DR2XHkqDy9N4jeUPRZc4nUp7c3AY6bykGKqlDQ2a4FAmQIhgKVgtEZV
 T7HxkcgHTrJowsCiHu+TxdJjsEUVPupz05xepjUj7dgIAAA==
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
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790872528; l=3899;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=AUMsaI8OWrYkS65xiG/zLfbAIV2XFDitVTaUGnQ1NlE=;
 b=JAWljIuj0+mAbbgJ6Sj0halGfh2L2yVZaOnTeldIbzSeiuXOQtt4SDrjsYMSlGd7nP1KYcXjk
 QU/J8zfgTuRD5+BlhRLnH1BO2Jc9jLM52obr0Q0dFZ3LorSA6jqdtfK
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|PH5PR10MB997711:EE_
X-MS-Office365-Filtering-Correlation-Id: de0ac073-d368-4ab0-66d2-08df1fda0c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|7416014|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XAqzzUkrOkFkHWPdtHwkBtYnS5GWHgP2nMTmYruilunT/4UkwnphZIeJQwXB2k2pRB9Kt6oJCSidKlRRGADSLWeJyQhljrN2/WIeiq6NaepPxnqWR0mo4HOYtqI+Dm9hXZpz8OCw8kGDDUlItyYRaYFsrHt3TdSKI74Z/xc1JlAEzHPaSpef3/TCUf/81Acuxw3LU1NOm9tLL6Ob1M9PcBSGbsyJd5keNkxACpP8e8IH+ZEiiajVuGLYQsA9C/O4Y73J6qbol/84fw9tOh29B5RbmZMnxVt019IjZH2i5DQjzwGEtA40Sn3VhH+KuplEJK9bFImnPPfhtPDdRZlqJC/y3yKAO4cM6w3+pbq9g/eLqs/zSz8O9V4PbmVVp+L2YtpZ1xyj0oiAAJGPf7CaQxmK6OA2x2QfAUeKkD/A7OoIyPRMxONz4YN/0YqzWxj/i3Tu8e1CFghKjSASOIaDsCezkG1+EN+dNXUf5KSJ5D9MZsaYPSEQsu2q9srzNw3dtwqU4K1uzpS87kSI/rxltvJsgwyTSuSh87CN4BpAd9q31V+bPM4O7q5kHaActG6eZIpIQfAdKZJERX+O6GL0K4YinviwnkIXNYqVajnxZwu721a9Wy/jHaBxavBW0WJjHZJJ0IaKv0qE85V6NvihEOeNBvMEnOE4ze8/qxJgYOuFdJ3I32NWc/tyyYFjTA7lI+C0I+1kqWOx7RWkmjG/Qg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(7416014)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZFi5Etr2+lExU5BA3uMb9xNsw18gUZBGJuIGfKMLpavHX01mpG0hykohrn3ieV9k84lB0jp6T4VUv1Inslz/hNnXv+rl9DugbB1eaOLTFYF+yUyE3r8uvE4uWjyxKbAKUy54eXW/ZZY40ZQ81qLg8W7x4kJI5UlcxzaNfTH9LB4NfLDJDEJ7L3kMFursanG6jJbLfSjvCbWTNkqYaahLQfhkvZ3Gnj+yopsShbqstczAVrKiR84DaiQ2gUrjez/TXil+HmxhhroEZPeBftU6mq5OTzz9qwH2yf2zXKTl+ZpRz3aLOScgfXix5zclIO0Q4cyb7dqtgnZeMCZEfFK9KieKvSPLnBmt9UXY+e1TcTaZ3+YrunnLIeOXF05q+TprD/NTQifqjhLQyIlbNf43hQTC4rd9UeH2y6jw3ImlS7GYtrMpaHQwF0RAheyh4h8w
X-Exchange-RoutingPolicyChecked:
	ST064snSczXvLy6vdFhbwYkpSnP8rFlTTmXzB04JTuyjg2o/qfYwxRisgOVdZAulqhwlmDN44kZIbXh2RSWy4oR9RU9EYYITzqK2pkPjly7hbHT0zyNVQ4RecNEW2XA08jIE8Chvm8I7ilr94llGSwu42rPI4xZrqa4kt4OzT5igOrq6DjqesVqoYoKfynbnhaSwRnRNzfdTX1jyI8sNJykXGmUJKxzlrHcLmhszLVrEE/Lc11G6AwBRu8HmnjGEKDHE/bUBJwyOuGyFCYcL0esLaoPR5TfwZu+527sUVRanwOlZbYukMvfbL4XLBUO/s/ZMgg95ZdbiH+WAYjr4fw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:35:47.9563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de0ac073-d368-4ab0-66d2-08df1fda0c61
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997711
X-Proofpoint-GUID: QUc6YQdTWehALoojwuURSN53onPMGHCy
X-Authority-Analysis: v=2.4 cv=aswnmiZV c=1 sm=1 tr=0 ts=6abe8be8 cx=c_pps
 a=e/sPstj0vE6DIEdYTBOJlw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8 a=IOcPGU-4WoNUi0UXtpYA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: QUc6YQdTWehALoojwuURSN53onPMGHCy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX9I2/lRWwNi3t
 gdNjjHraC57mKnJB8VMlbvTCR9ExOJspp1tNRyHsI9iaB0xX3h8v+ClL4R1AeExGBAxQh2Mv12f
 D4vao8M/VR++vFx8646XaoMsLuvHQSo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX683F9aTiCT1B
 yM6QIbzId3Yvo8HcjkfB7fXrW0M8Tiar5wj6XrIqKzE/HJGA2nJVuR3awQhZeJNwYolqizPECyO
 bP6BO5cMBGIZ9XWE4efeh+iinJWj+/bGFdixDjOkryLpLzbe3QHcj0U/M7BoF3iOEv2OyM36IfW
 ZQGOVLhQ2+yFBBYwgXuuLCKGa4IgdZXvBH018c6hL/mVMgZ+Sd2Yn+5Cco0G+H8VHB4dYpz4mR7
 0yTH5YN6jkCiPfR40i2VR7HYdPiQ0qzQ4RVFskXx+B4yeXmTYru3ttL0Uh9r6Gheg8OQgAEaTK8
 iGQaDqLh33a8xRwjsbuIfAscYYUm+4YYOopsHSBt/MS3iSkBbLe6CiqizKbq+5jFZtvPIlEv50/
 d0D4lBm1kJoc8TY66ogpgiOa2q2z9NTxL2hPBJvEFOhrwgTNughkBrzlo70AOUv8Qf7bU3TriTq
 FxsTFXHVjmjJyBafJsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010066

This series introduces the "ti,am62-mcan" compatible which adds support
for out-of-band wakeup capability in m_can devices.

A corresponding DTS series enabling this feature on TI K3 AM62 family
of devices has been submitted separately:
"arm64: dts: ti: use ti,am62-mcan compatible for m_can devices"

Rebased on top of "can: m_can: Fix suspend deinit() error path" [1] and
6c507ab36a83 ("can: m_can: Remove comma after sentinel-entry in match-table")
so that maintainers can pull this in on top of those commits easily.

Testing
-------
Tested suspend/resume with CAN wakeup on AM62P SK EVM.

[1] https://lore.kernel.org/all/20260918-v7-3-topic-mcan-suspend-fix-fix-v1-1-e24fa70c754e@baylibre.com/

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Changes in v8:
- Remove redundant error check before the logic to set out-of-band
  wakeup.
- Move m_can_of_data definition from m_can.h to m_can_platform.c since
  the struct is only used in that file.
- Link to v7: https://lore.kernel.org/r/20260924-temp-v7-0-f40defe5957f@ti.com

Changes in v7:
- Rebased on top of "can: m_can: Fix suspend deinit() error path" and 6c507ab36a83
  ("can: m_can: Remove comma after sentinel-entry in match-table").
- Link to v6: https://lore.kernel.org/r/20260915-temp-v6-0-ddf1411d63cc@ti.com

Changes in v6:
- Fix indentation for items under the compatible property in DT
  bindings.
- Link to v5: https://lore.kernel.org/r/20260912-temp-v5-0-2e3201c02109@ti.com

Changes in v5:
- Rename compatible string from "ti,am62-m_can" to "ti,am62-mcan".
- Update dt binding to use "oneOf" with a fallback compatible chain instead of a flat "enum".
- Rename "struct m_can_pdata" to "struct m_can_of_data".
- Read match data at probe time and cache it in "m_can_classdev" instead of fetching it in suspend.
- Add "out_band_wakeup" flag to "struct m_can_classdev".
- Guard wakeup/sleep pinctrl selection in suspend with a return value check.
- Link to v4: https://lore.kernel.org/r/20260902-temp-v4-0-3896f7d16ce8@ti.com

Changes in v4:
- Remove patch for "out-band-wakeup" property in dt binding.
- Create "ti,am62-m_can" compatible in the dt binding and m_can driver.
- Add "struct m_can_of_data" for compatible-specific data which keeps track
  of "out_band_wakeup" flag.
- Replace check "out-band-wakeup" dt property in the device driver upon
  suspend with check for "out_band_wakeup" variable from the
  "m_can_of_data".
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
      dt-bindings: can: m_can: add ti,am62-mcan compatible
      can: m_can: add ti,am62-mcan compatible with out-of-band wakeup support

 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml |  6 +++++-
 drivers/net/can/m_can/m_can.c                              |  6 +++++-
 drivers/net/can/m_can/m_can.h                              |  2 ++
 drivers/net/can/m_can/m_can_platform.c                     | 13 +++++++++++++
 4 files changed, 25 insertions(+), 2 deletions(-)
---
base-commit: dec005ae90a2946656a090f37bf1cfbd22f08e57
change-id: 20260819-temp-93299bee27b7
prerequisite-change-id: 20260914-v7-3-topic-mcan-suspend-fix-fix-b943929d8fef:v1
prerequisite-patch-id: d60701b698565843ed0630ce15cda0c46c35cb39
prerequisite-patch-id: 6c507ab36a830f131d17ca74033282e89dec8a3f

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

