Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A49476CC1;
	Wed,  2 Sep 2026 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788383084; cv=fail; b=gkVlEQxpR8shECuAB01nZk+cJOp5jWfDlz8Kfhlhpmf1QwWekMHmHhsuDzkxTj/k17+inTz/D4wYGdyYN8PjKoyeg92r5PmA+Xl6W+KCVavgA4v4VZn8cRcH8hslEL34zHWPZjPdpM4gjc8OczvcEAx97ssiktXRWe1FgPcdUTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788383084; c=relaxed/simple;
	bh=aVedX7Tw4IhGJOqU3RidkoaGLENDgNV3MzaMMouxS3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kgYirvtOghNiWH13PCVhanbX810l9Qk2qSxI316r+LHRdZUuyigrH+0Kd81me/2wvt+QY6ThpgANS+l3beMXXKv6SWYFzmGVfH3kJFV6UxB/cHR4XanpvP0hvubIMHo+hHysg76NZVHicauPv1Cb2sonvrgHE20t5THoKCvyoJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=IjQej8zK; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CautvphX; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="IjQej8zK";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CautvphX"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KISOc3395880;
	Wed, 2 Sep 2026 16:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=hPJw28oEc6I/YL0dQBPZj30yTLsNhRGXp4uDT1KId
	kg=; b=IjQej8zK9jUOXrp2EhdQqyKk5RYXOyKbV8/TsP+/OfRK1p5KJv/NygjEX
	0Ofs0eqvHxaAGfq+/qOhfq6XoXyOvMMcpChUG9/24aGYnb+jk9fx2GjdH6wqcDN2
	LE8D5/Jk2CzhoNDRGL/hqrmf7Kl708/IfXnHc1p/In6YR95GLl6XNwBONdWFgNjp
	QPXh9nEFyMAqj6+jYNA0NoRmZ/TZpOmGw1/8bThoPvQ4/N7HsBk1kjZVprcsnWei
	wA6s2kiUjW7Ap7gS5aL+6bFvNOrH1iv7OZRLaK8KYSRfQAERg8a6rd2WTjrQKJpB
	hn0FLxg0IbxeXGx6FetfytUNea2Zg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gen86jxty-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 16:04:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYIFS0p+3aS6BggkfVniU1YX1O7S5ZDAfmnZgNlqNDquqKCSaCDTasdMmzVFf6Pr1aS/uIwwcwVsNF9Mjh5zWipxK2WOcQ2wxVybU9s74cD+qpJQ695fHChFw4OvmpcggeXJ5dztJEQm4HueMP8kXqiI+u7IT1OdotG8Gh2sDJkQqiUaKLs+Y7eMj+EcraonPItLXLqNCDW58R/FhVOA5fyBJVX0dQn8R32iadgJVwh7uApejjRnDTH6oSp+GdHOUrReLRupEEZGiRE1ii9SA+dlD2+7YLvb/eHeYb71RB4CNlVx2VSCRetMZTAQse1FkROQnZwhAu04WRlgNP1k2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPJw28oEc6I/YL0dQBPZj30yTLsNhRGXp4uDT1KIdkg=;
 b=a9eZ0jN2RaPpX3ORvWptSdsawCvCteX1SeKEB+MHLobTJA4tK64Mx4mybqpwWbl2xH7a/7b8WjsZfwN601yWVPuizhdxL90PboZIiVu6kvEMCyAnuInUUR6iS7FH3LGMlAuzxm5B8TK5PQ4xgYFv6stHoXYggM/6akRbzDAJHuPhyUH+1XzigNDp0IG1wDs9eEHsYIin/jd8/XgR2/BhB9afQZevfNIS90vQNUgH1/b0s6AgLt4lWRjQgEznV9YG5Sd37PrZGuZxhw5SsxVx9aPRMt2BHHQkWWgT4dLFXwoOTTPPH5Eu3+kQcdBfO4iUyeBeSDeErxZRXwPqvJE0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPJw28oEc6I/YL0dQBPZj30yTLsNhRGXp4uDT1KIdkg=;
 b=CautvphXLQPzrCJo2Bzf0XvkvFuIMnlbPNCpRL8f1k+lttV8YAOeierLuvGVz/nei1YeS60Td8C08vH7ENWKnOAbLG7E2TvnJDnivIzVyeRSIPaZs0LwjX3Is9rJO6grNNKhb4aqDbfFIdTZn9g+4tdMuXbIRGi2hrDM2u7TLn4=
Received: from CH0PR04CA0089.namprd04.prod.outlook.com (2603:10b6:610:74::34)
 by PH0PR10MB997688.namprd10.prod.outlook.com (2603:10b6:510:384::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 21:04:26 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::80) by CH0PR04CA0089.outlook.office365.com
 (2603:10b6:610:74::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 21:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 21:04:24 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 2 Sep
 2026 16:03:32 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 2 Sep
 2026 16:03:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 2 Sep 2026 16:03:32 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 682L3WUM267827;
	Wed, 2 Sep 2026 16:03:32 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Wed, 2 Sep 2026 16:03:28 -0500
Subject: [PATCH v4 2/2] can: m_can: add ti,am62-m_can compatible with
 out-of-band wakeup support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260902-temp-v4-2-3896f7d16ce8@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788383012; l=3135;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=aVedX7Tw4IhGJOqU3RidkoaGLENDgNV3MzaMMouxS3k=;
 b=5U0vvLPEpkHUVtNhqHeCFX3dxGuB77ocgddoE0XtjRDSI1/M4nihMeAgP5LVtcOSzThifhB5q
 6KFMbtmzW1xAviJBWRFgfnMdz/0wv4T3mBqCMJtANhGhh6y2nDVC5EV
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH0PR10MB997688:EE_
X-MS-Office365-Filtering-Correlation-Id: 58256f65-0f4c-43ae-d129-08df0935c497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|23010399003|1800799024|36860700016|22082099003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	X136b8Zz4QJOepsqCTYQuszqeTuZ+wtzyCYkp0ZLgtrQAvgWYcOj4s++QI+NgkKvlqLSFP7bV2shnRHu1Z225GEpenlWN65445wxDgL63TNNS0vlz1868QJpjRi/6C+bj0e767czn+U/+bHTAV6rG00NWiVR7HIKq42HtfxIKMhVsOeXFswRdZKMXuIpjsw7sS+BBnEtG37zE7L4ottimI7POOtZaojt4jxM7jP6Y9xObXMDOxG5nx47NhwblA+yy/t9qWvDZtwuLXGpBFpieAjTz7RfM/OnfEGfDRfRp1BWx41+qBoFpGMjDG0Qhe06v4GUcPtSXFoMOSHG1Siwcn5xs03O3TTij4Pi0hyYQ6zAu5YElfEmD0bboE/DOFu2Wm3rvxXfmUxKL+iH4tpQwpe1iqOhhydhFv+4QNOA8EYlT+zQ3dAEAaIxcon8+HlKGSwpbp6NeOOK+uIuWdfGNfezO4v8MiIBbOPa4NrQUmH9J61epeoJvjQcjM45TLO8ZGsY9OYZ2M+KAD3qGBAtt/73CHXU3UPZaBGcFEk/B5L+9set41MQUG2/xZd213whNw75Sa6WSXdCEPPr8f/gUtjlf33bk5ikCVIcGyG3y/5DwkvrFrezZteZRWwIafuSp9P+l0r9JAi21/7gjGuu19gqEeBRHIyR97INfzq8kp9p26VpmXS24JLv5wjn4ZgJF60gjx2ZE1nZfmoj/29ZWw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(1800799024)(36860700016)(22082099003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LbMug7THV7/45uCa9PPct1kcrW/hZ1jL4bwiKSfxKi8D0EHD3Y72yAY+MPKc9GAg/bDefLeLN5p/lSsSiOlbyDOFh3KLe/NT3CE8amdczyAZvZO46sr8/y1QWWL7gaDNsv8DRk/PoL3JXd8huNbMXm6cK3Al0rz9i4qRO5bUYmlQnsl8b4kvQIfaDIk7Iyo9Y8tmzOby6r+hB+VDwFCnvS/7u6QuATaKCmX81yQlf8/3e3rLjtZ1K7K0DQlalj7DaRbCJZE/TRY3xc/DKErR1pTwoRSGGaSdS7mVyxleY0ivk1RjNhkNB5ogAIt3DNdVkUC88TrgP82C2nRaITj4KNy7oFmfRB/PAV0N5UevCv/qnH/PYwM9EzYtUIxo7YjnuBR1TIyGISayfdQ60Xv/wpVFGXzVbyOsmFpqHmg5DevvzPDCBvXzjrG9fMeRkJks
X-Exchange-RoutingPolicyChecked:
	TAWVdbe3qFJ5YFlo67LtC7Xl04VqdasXEENwqLn8DQ0ldfSuULqIF0jM6GsVGH48c4eBvkAnk/vVWipzDpz29fBOliiUkO3iQ5ikSUDRtnHgio0/BMtH8uK2tiIsSmH+5FTq9ZnMju4xJXB5tENjPXNQXjkkzjav+m7RU5dMouKJSuMjjBQZqyOaSAkJW4cxOXpCcSg2pmOjPOPxPbwW8OV8dkfAmXLG/pZyW3AO0FAxg19xIKKmtrEYnQL2xsU2AtXJbrTcnXWooY6qdOHpJr6YPx7obTHD3sHHbBv7tLw852BALydB6Dv/IVGnYkISyi3CFHmlrUEdaR55bgfUkg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 21:04:24.4925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58256f65-0f4c-43ae-d129-08df0935c497
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997688
X-Proofpoint-GUID: BG8-fJeAgGxmK34Vms58Moim8WTW6pSh
X-Proofpoint-ORIG-GUID: BG8-fJeAgGxmK34Vms58Moim8WTW6pSh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE4NyBTYWx0ZWRfXxo4EMFrafNoO
 B3mHhlB3m+LEnAIwuFVc3/3tc2iFTT+lMRThXQPLeuAuMfJ5FWNxU7H9sFbCsgvDn50ZuWtMZeV
 0/+bCr2ADqR3HXyBCFh5crLQarHpKlY=
X-Authority-Analysis: v=2.4 cv=HcMkiCE8 c=1 sm=1 tr=0 ts=6a988f5d cx=c_pps
 a=uZgmHucj+isDzLb5E5/Wlw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=xGkXNJDq2qBzU6obw8kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE4NyBTYWx0ZWRfX7PcF0RqVcWzW
 fnwQBJTvTref+oyfcKJNm3P4HlWBUGgG6+8h+PhTsm/xhXUhB2tzTW1rhNnUSCTK+ddZP0JNhi/
 CUoixm4XFWcbQf/B7o55iwoag3voWIwYhHei6a6sd9YBOpjS7dhgW7JUW5MoVvV6z+9qR0PYVc7
 nhJQFuFL7wTmaXyWyZ0f8SQMpr2C/lUfNSipRVyQq+mXvJqMS4znZk8tcZqltHC3Cm/rW8Xo/6u
 qN5DJ0/qbmnwA2+px3dJT22B8DgKUdR/laWXO1SZE14VxwKGctHXFcMtsFobZbWh6ysR9pLmpg/
 Ppeo8ernujl0+83qm9WL2PoAmZgAGzmiimAx2vj+IWjbiNgf1e+nvUrp1+fJT/1/lVGaWpRetQn
 fResMgclS75osBaQScBORFxRCYOXjAs3FjHdhdHroqptqUUIXB2dZDL0/mKNpR1TJ8M94++EM2/
 LYu33haAoqT7ex3d1Rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020187

In TI AM62X, AM62A, and AM62P SoCs, the M_CAN controller is a part of
the MCU power domain which is OFF in the deepest low power states.
However, the m_can pins are able to wakeup the system from states where
the MCU domain is OFF through its out-of-band wakeup functionality.

Introduce the ti,am62-m_can compatible with match data to identify the
out-of-band wakeup capability for TI AM62 SoCs. During suspend, set the
out-of-band wakeup flag when the device is configured as a wakeup
source, the "wakeup" pinctrl state is present, and the match data
indicates out-of-band wakeup support.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 drivers/net/can/m_can/m_can.c          | 7 ++++++-
 drivers/net/can/m_can/m_can.h          | 4 ++++
 drivers/net/can/m_can/m_can_platform.c | 5 +++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16f80607e150e2ca2950616ff2c39b7aa13710b4..0788816d881ef8ba84ad5a84a6d2d3e60517ea7a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2598,6 +2598,7 @@ int m_can_class_suspend(struct device *dev)
 {
 	struct m_can_classdev *cdev = dev_get_drvdata(dev);
 	struct net_device *ndev = cdev->net;
+	const struct m_can_pdata *pdata = of_device_get_match_data(dev);
 	int ret = 0;
 
 	if (netif_running(ndev)) {
@@ -2622,8 +2623,12 @@ int m_can_class_suspend(struct device *dev)
 		cdev->can.state = CAN_STATE_SLEEPING;
 	}
 
-	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
+	if (m_can_class_wakeup_pinctrl_enabled(cdev)) {
+		if (pdata && pdata->out_band_wakeup)
+			device_set_out_band_wakeup(dev);
+	} else {
 		pinctrl_pm_select_sleep_state(dev);
+	}
 
 	return ret;
 }
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 4743342b2fba3823819b9e2bc5b085cc0fe6d1e2..486d808bc677482acf446b1450c3a9b6b7405178 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -134,6 +134,10 @@ struct m_can_classdev {
 	struct pinctrl_state *pinctrl_state_wakeup;
 };
 
+struct m_can_pdata {
+	bool out_band_wakeup;
+};
+
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
 void m_can_class_free_dev(struct net_device *net);
 int m_can_class_register(struct m_can_classdev *cdev);
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 56da411878af0185ff9cc512e325137428a68255..ae2d89b65fe8da65b1ca73cbf80cd8ee8483e2e8 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -218,8 +218,13 @@ static const struct dev_pm_ops m_can_pmops = {
 	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
 };
 
+static const struct m_can_pdata m_can_plat_am62 = {
+	.out_band_wakeup = true,
+};
+
 static const struct of_device_id m_can_of_table[] = {
 	{ .compatible = "bosch,m_can", .data = NULL },
+	{ .compatible = "ti,am62-m_can", .data = &m_can_plat_am62 },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, m_can_of_table);

-- 
2.34.1

