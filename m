Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453FE369D67;
	Sat, 12 Sep 2026 21:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789248457; cv=fail; b=WhZ24dDXpNkVTU369y5ueNbg9b2jtIuSHi1K38s4YYA3s69zc4TnCUP6e+n4NcqE3h+GrWv3ewbgMRqukugvJPbBLrMK21Gs/IdOz4OLZLBWqYqWwuGn4la6rpJKIiv+YEMAbwcavQ3xvu9qOsjxBrCngi3xItqjYDYhjHeERYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789248457; c=relaxed/simple;
	bh=08VR900awuGx5jIMqORKv5lQYS1+5vO+R1+adBIH8O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=S3yzK1MNTEIZtFZHu3nBWzIVP7nDHHfrhnpNidRj0y36f8g8QCRPuoHz7KIyiF8tEih2GEc4RwZgRv5THITI6jQLVgY285c2e807fwiQ392h0ZEAVmqahwcpfVAJcVkrvlimtVhE8JrrtVxBq07uRPKzKhVwhdvY7JK62EF4JNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=lWWnqYun; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RUxbKHHz; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="lWWnqYun";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RUxbKHHz"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68CI1YFV837051;
	Sat, 12 Sep 2026 16:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=RvQYVMI/Jrqhn5l8yZaFA+svtJ5+ouKsvPHJRmGO+
	GA=; b=lWWnqYunPeAE8ekubCF31lBqou7LzSWIjaBXCbBM8Q52c7WP2AONGw3b/
	PkQpUAicwOCxzpqkomhbDtemo2Vj7AdA8M/n/A5nyBl+2PXoWf9kq4exdTpv9jAF
	+oV6aNO3q70F6im9kileCG5wAKyxjYIdRBPoOIABhbX5JfiJK7G/SjKNPlZA8Dk7
	IjZDQS8iZhzPja/p8WzYTV2Ct1PVGsrGEHESFKcw6JPPU+re40zeKdRe0OSfUKL8
	tjJJqX2q7+d15/t8RSefutJS93MhBUEeOZm+llGdu9Db+mV8rf6NpvB+T46ReHsE
	ySucQrJ1SYC3XIxgmI+P3HGptd5WQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gmy5db5g5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 16:27:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXl3F1FELT8BDlengP14h4RTGP6T1q633uzq/ghCHrdcQamB4W5WI3hJNYKivh4mslNY8GATrD2k0FiTY80yjcT5oV2DekHlb6h1F+ohbhN8Mxch9j9AsyNgWMJGbvcxECy9IjF27Wea8GcnE2nrKB6LpymYU33fptAXAQRQgcc17jMoQx207Q36YShg2zJEd2jIHWI3CnpRGzy1O7uy4D7dSjjf4UPNaCYQdOJDt9vb0bV+PZGRS6W/X8EVRcMVVfHU6R9tyB74Qy/TCiBu0oWczZXrmDv9sHkSTwdQ+c3FdeuXVIPAWoOii3L8sXaguxb7SAdOGM0wJFHlH6IuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvQYVMI/Jrqhn5l8yZaFA+svtJ5+ouKsvPHJRmGO+GA=;
 b=Pn3lZaNnEHo+71EIMLkXA5heHXUjsWFgjJLgRtJMSx365VES++KcACK8hP3jZrZ7qMZIUOy/eyG0lPTRVzbcV7oweLKSU2XYZ6ga/2sMsGa3uHdoUNvRXf4HwAjZil+RBNxOPX7ECBh6JRJ2hggBFasSi38Y2RQKP5p57GEZmhpQAqpF6xI34WZKC3K36s0qvZTglcHUCenO358QemYtMBnVP9S/lUCeZzfo4W9isFJp4oeLrIiA1jf6rAXGd/f0Xe3sCCgIgWlvfY1I8hvOYdUCXClrIw30TjTn4sF1f9Gj2zAOsb8u/Q8lZyf14n81qVm3DlWtCF6x2HG5pG3M0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvQYVMI/Jrqhn5l8yZaFA+svtJ5+ouKsvPHJRmGO+GA=;
 b=RUxbKHHzYfMWsCtpNT14laP3gE7zJ+Mt6psvnFIiklWDfm1U3x9wa9F+F5LNbv+LTKUBgjLGHGQyEGypfV85qrH21/BVzchMMhNJy2VzhOO20eMoqYcSrvcmrDIkTFo72nPIF42wUpJLodhjfAXAlL14R4KKFgnjzRcB27+yvoE=
Received: from MW4PR03CA0317.namprd03.prod.outlook.com (2603:10b6:303:dd::22)
 by DS7PR10MB4848.namprd10.prod.outlook.com (2603:10b6:5:3a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Sat, 12 Sep
 2026 21:27:13 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::21) by MW4PR03CA0317.outlook.office365.com
 (2603:10b6:303:dd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Sat, 12
 Sep 2026 21:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Sat, 12 Sep 2026 21:27:11 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 12 Sep
 2026 16:26:56 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 12 Sep
 2026 16:26:56 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 12 Sep 2026 16:26:56 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68CLQtTW3503647;
	Sat, 12 Sep 2026 16:26:55 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Sat, 12 Sep 2026 16:26:56 -0500
Subject: [PATCH v5 2/2] can: m_can: add ti,am62-mcan compatible with
 out-of-band wakeup support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260912-temp-v5-2-2e3201c02109@ti.com>
References: <20260912-temp-v5-0-2e3201c02109@ti.com>
In-Reply-To: <20260912-temp-v5-0-2e3201c02109@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789248415; l=3456;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=08VR900awuGx5jIMqORKv5lQYS1+5vO+R1+adBIH8O4=;
 b=RpZp+q72Z/z6RZYZ0RK8KyPOuWkCCVmg0RdnXD49p0rLE+XAn9delhQ+Qp/VpSqmhHixyMd7U
 x+iQ3QOB5+5BMcPEcPzEyuzL6U8dh6VPmQdr0Rx2p+vs9m0JMGTbYAL
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DS7PR10MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d9fcb8-a8d9-4cde-f72e-08df11149bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CiFVn2uil7nccF8hIdbB1p7HitDcZjdsjMjHrbJadrtSrXwlht3cbxhSHmxWKeaOVgrni9gO2JwJ+SFxKgQy8E2IyfbE7oslHasGDKP73dzLPCDnMVSnpYR4Fq3vspL4FACPTBsnY9DldY8KYeWzWSr+sUz7GduDfoL3HmELQhZKZrnuLFnHCgdJcsk0GWI+5tLykidS0h7XnlZ2VYkQIXMqHZLBqx/M2xFfWBdq3u8ocE5JQWyDJnBjyzw5AmDSDMaJS/RKcSyhlMmzBzypt1SDw2LUKSObt8iUL+USyErABiC76LAFXmxGUXgVdpB7voDi5OnSq8xUUykYBOf/2UZknb8eer2nS1sljaHDwTmayJHbETbUFbmFzDhqXRHnSffeyz0plOWXKEof15/x/5m+v4baS8YjOPJGf2PqmWk4fPspiowjsnpq3wB7O74i01KhDBSmUBv0Z1Dvv/CJ9RthuIicmDE0EEx5yLy12U7YjEC7gmjNEmicPqjCzEs/MaeeXkDyztDyHZaru3zjCpTrERYHLRgdPdO4zu5PAQ4PMNqKY4VTpdwadukIX+WFpaKVFar2VyuX+yS7ZKSqs4zUkwnQjh3Unt2hnNuK2IUz+VyGD/mdCtc4VgqEdwz3yJjcr+cPXSmPvqVCOnYPAJZTCdZSRwaknMKWrZuDIHa3vQ6hBPDGxOD/spqbRpGHVvpn7iDtHqTCyyDn1ic92Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fEfANkcnhxeAm+2QH4fSxEIx2pXGU5aaZl4Fd7f5Yctt1NpZ1XS5FWznnl/NKxA4UYRM/8VAj9W4ekZjKyoW71+DiFaLDdpqK5tREsoFevMCXFIYSte71CbvKrbWS1eLDKzRcLje2+kwBBLPn9Pk9Wcnck7z5s7dczsmw57j4n2FHRaZehhAF0d9UIn8UIVObGNQSDrUPsIRYqfv0qlIMEyioxEDLYvxJE/h4ztBKNpzEO2pZ5m8D2hpX78pzlAblAIT9zNC9+1ms7jy5xkgUeHA84VPOGislJq2LshadhXxPY7UZoLinlDvuD/PMPqCRLudBpQsDXV59lGr0xIn5M83zyySchWj62vtFO5tNQe2oWwbBdOp1JrQTMHb8roBl5LZBWynd7xtj2xN52azzMusyQx/eHuK+BGu0aczxWbcqqSqwva2mSnu0fRyUdeK
X-Exchange-RoutingPolicyChecked:
	Ma7lBjIIybbTozwGTvw7znPX3FkDCxyNTnfvfAmsNLO/okkdYBzN30XcEAAs4B2jAge4gXEN2tlVYNO4AQz1l/iaoatbCGpw+e/BlyRb5T40iorOAR1xD77FGvk0bQ5JugJtwQZkLA31Uf5gizw+6cixs5leW0zRP3mDiXEclAbWYkK3kKFF56y4SqadNwpi/SiIcdY+/4weAqMOmuPmIxtRt6gD3K/xXDChxDAhyESJlnJOt+Ri8Q6BS1MZPgnm5MkEEcL5eWKRT2gepH/ns5s/7875QjUKfJshKDIaGX8cIJQB4C/Q8oMj7thndf/lG6+flyB1GLeE+AQmMqgVJg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 21:27:11.8490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d9fcb8-a8d9-4cde-f72e-08df11149bbc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4848
X-Authority-Analysis: v=2.4 cv=XPal2ghE c=1 sm=1 tr=0 ts=6aa5c3b4 cx=c_pps
 a=GhmtI3pHzNGJg3++3mR9yA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=q7fBzAs-YHYjZ8l8ll0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDMxMyBTYWx0ZWRfX+BpFn+7NeNcn
 IBN5DUwXJR+0fx9f1ADHDuqh4zepV+lD0s1HuGadsdayZvPpdyr56AniI4gOuhVpwplYYXmK/xN
 VXNvLWeintQQTbhM/kVwuCkuUziatbQMJKyjoezrZ3Ai18SjZDeRQi1rXuoS20K3et6T0kRD24s
 uDYl6QpUjIz2HKTJXgNdcn6miLf1YtocgsEetiQ3FhCOTgigbozmrNjPrsDTfW4NJRMUzNfNfxd
 0CBgi5EsAhSSgcWwxXgmHYiMKQBJLgGVuONDREQ0WxrYLJ2+VPQ4u64MtVTaSLVqIcNjM1vNF30
 Zt4twc2kmo3aneDDpIL2u8SPVMAFYvjpRPQdx/2d9BP1yfW8dE9KLPa0WGX8/5VcQBTDd/gmVYK
 gfr3jnaa1eMTtxponapat6l+InSaS3KYuGZXQpDDdDOfYVxZ7Rt7qFj7W1/IhB7F7LZKkBegnAW
 J7Hqqq5oL7F+6+PnYsQ==
X-Proofpoint-GUID: k9LPiR5xeGBUCme0GHTB9g1H4xqaBRyd
X-Proofpoint-ORIG-GUID: k9LPiR5xeGBUCme0GHTB9g1H4xqaBRyd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDMxMyBTYWx0ZWRfX+0XTQbwfCRWv
 lJRclBVqJ8JkTMuiHu3aJKt99sTEbJZzjkjk6RfrFpYzEz5WQsXcdsPonWH7lEa22jokBAaa8vn
 a25OaRt6R+7RERSSueAELr5SWpuUAnc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120313

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
 drivers/net/can/m_can/m_can.c          | 10 ++++++++--
 drivers/net/can/m_can/m_can.h          |  6 ++++++
 drivers/net/can/m_can/m_can_platform.c |  9 +++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16f80607e150e2ca2950616ff2c39b7aa13710b4..67ac6995a7f27c412b61bbe235b4aa0f5980688e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2622,8 +2622,14 @@ int m_can_class_suspend(struct device *dev)
 		cdev->can.state = CAN_STATE_SLEEPING;
 	}
 
-	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
-		pinctrl_pm_select_sleep_state(dev);
+	if (!ret) {
+		if (m_can_class_wakeup_pinctrl_enabled(cdev)) {
+			if (cdev->out_band_wakeup)
+				device_set_out_band_wakeup(dev);
+		} else {
+			pinctrl_pm_select_sleep_state(dev);
+		}
+	}
 
 	return ret;
 }
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 4743342b2fba3823819b9e2bc5b085cc0fe6d1e2..da64e6bbcef2a721a330e67fd852ca4a703c5794 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -132,6 +132,12 @@ struct m_can_classdev {
 
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pinctrl_state_wakeup;
+
+	bool out_band_wakeup;
+};
+
+struct m_can_of_data {
+	bool out_band_wakeup;
 };
 
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 56da411878af0185ff9cc512e325137428a68255..9deded10e8a6a99eff5ff1a78696f660db443db6 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -83,6 +83,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	void __iomem *addr;
 	void __iomem *mram_addr;
 	struct phy *transceiver;
+	const struct m_can_of_data *of_data;
 	int irq = 0, ret = 0;
 
 	mcan_class = m_can_class_allocate_dev(&pdev->dev,
@@ -148,6 +149,9 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class->is_peripheral = false;
 
+	of_data = of_device_get_match_data(&pdev->dev);
+	mcan_class->out_band_wakeup = of_data && of_data->out_band_wakeup;
+
 	platform_set_drvdata(pdev, mcan_class);
 
 	pm_runtime_enable(mcan_class->dev);
@@ -218,8 +222,13 @@ static const struct dev_pm_ops m_can_pmops = {
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

