Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D853C1F41;
	Thu,  1 Oct 2026 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872581; cv=fail; b=Vm43S2eHnZqJ+vUsbrmyhqGwhLqiKKviazWXCQGi1Jikj+cU8F5+ueRBGAog2nLHj8tOgWjUb3VFXn/kYEG7mrqFkCZq16h9UaP32xbPeMsWnp95NYFyy2NrknGHgrWcxK7/HkXKyMVpEJigPeyp/alQsSC/+7BOQ04RgV8z2gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872581; c=relaxed/simple;
	bh=9kJNhrnBNSSZr0GNgzQSrJwJfikalNYUCy3igbIupRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hPxle4RrqCZfKuL9YV9XKsu8THsOqsw+u3ivjduOSuvUmpXFbAECpEuBWAGaVBAjguncSspXoZkIJQfdynOn+7erfkjqMsMJ+L0MfsjA2iG/GHqyvLm6Ms6LHAUKKH+Ixc5DNWEvqimPO3rToR0fkYr1Ll+dAFbqsslwYXrMsBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=oaZT77fe; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=SWSMgI+v; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="oaZT77fe";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="SWSMgI+v"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 691Frw1M2133255;
	Thu, 1 Oct 2026 11:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=TyMWMRgVmuopD23N20wrSP2QWBfFOsn8pGLbQFYzh
	oQ=; b=oaZT77fe8ZDw4l0fAYwEe+Foio6xlf14dBDZhxfaukzO4TYJ6NgJBb9Fg
	E9Inf3QHRflLeRRhf6kNM/Y3v2ILIDb9ppIkHcFdmabG+DWA3GgVMD5Um7w4enG7
	B57yonmZ2ZEVA/9rvyzmSt1xPsTtZLW0dVtgi8EeYPUatXY2NHJJdbP5pTOvQVZq
	Uvj14utFH72A+pq/UI18Qvf9Mwh/imPZG0m171sSV4SFTGmzSkUcYDwqc7lPn86B
	iWGTVMOHFA2+EO0oipLgsaCIiDW4FwX3zndbaOaK/UyG5neZHvvr32OqwuVws+yd
	smYKwdtkz2Fm7f2Ls3VE5wxfxE7TA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	by m0380145.ppops.net (PPS) with ESMTPS id 4h1kqyk35u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:35:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzyVZaEgPB9avmR/DaiRfnphpykst1o0qE1kaU7m7aRUdzxt1RQKiwGHyR+UK70aqeRFn0SRC33wW4M1nYEMWXA+uG74XFwerkJGhTXnPGGRaJMc4q2lrMOdlvbxXwi8YLnw5enuCyIY4WkAS2J5gYZWapS6wiE3aH7EroOEgXMuKxwAdJom7P4+/8cMWjZTsb4F5Y7DdfXYmT37PftJOpC9GPhiSItmkpKXlg0AWVidpI5VzKqUj/Oby9p00QRh/BelGkd76w0+wxW2FSoOt1dG5zCneFMjESX/IQKj0Hw1jOU/sB2zK3Gfclv61BtjzgF65vSI2xfLTUdNjjRW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyMWMRgVmuopD23N20wrSP2QWBfFOsn8pGLbQFYzhoQ=;
 b=MXIbWsXBZUyE6LPg+LX1hYo6aav8isptKdG4SjrNbrr/HDlUWyK3tBg90QsT/Fjgd4Gvo7Hq2pv1AzKKf7tty9aW64lEu6Lz4o+SOb002QO2z1CDSC5Mw7CNhFZp6RQkzmbaPPt+Hf9s6u4iXLjrqdEiUeu0VNn2t3Jf3+S1EnTpMAbOdAYvlMKssVqtI2ycnHyDx0XHrrjcyE048og4XZDV4g3j2SoYPVOrk8EzNAMeGt+b5p9M0eSrtUT5b1mKK0O/csl2ye5fVo3cnWk9DXtqDtvBCZ1ey58/uqEDF0X/03G9l393GADaPL1xL0/Y/a4yE/4MlTW8HlAlGOfbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyMWMRgVmuopD23N20wrSP2QWBfFOsn8pGLbQFYzhoQ=;
 b=SWSMgI+vJJMjBlsF/YqBbxn57BNw4rBQc9HkaW9iNYmg1Jqp1Rk5qYYSetQce7yF014pwKaXo1/LQIXzW0ukkOBD7IvJ6iDj+OJaAouoUornKTH4CSVB3BBtXn98aqj8+PGNmcLJdv4a9qdIOIiYetmOHOpBexnZ8DYIWDu0QqM=
Received: from SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::23)
 by CY5PR10MB5915.namprd10.prod.outlook.com (2603:10b6:930:2d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 16:35:53 +0000
Received: from SJ1PEPF000037AA.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::17) by SJ0P220CA0016.outlook.office365.com
 (2603:10b6:a03:41b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 16:35:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000037AA.mail.protection.outlook.com (10.167.244.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 16:35:53 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 11:35:28 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 11:35:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 1 Oct 2026 11:35:28 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 691GZSao2285140;
	Thu, 1 Oct 2026 11:35:28 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Thu, 1 Oct 2026 11:35:23 -0500
Subject: [PATCH v8 1/2] dt-bindings: can: m_can: add ti,am62-mcan
 compatible
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261001-temp-v8-1-489dd82e4b50@ti.com>
References: <20261001-temp-v8-0-489dd82e4b50@ti.com>
In-Reply-To: <20261001-temp-v8-0-489dd82e4b50@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790872528; l=985;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=9kJNhrnBNSSZr0GNgzQSrJwJfikalNYUCy3igbIupRg=;
 b=1dGe6cf6RUQbPHINW5H7fiVjCThA4VxbKZHF4k9QtbBN50yQ0kpe/m+/XLRw/K7TrZwnuTTEk
 gy88S/NviJNBxspMv3VaVLiha2lKm9etWGK6bVepuwvRuXEMzrb9erY
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AA:EE_|CY5PR10MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 57239109-65e9-42dc-6a7e-08df1fda0fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|82310400026|36860700016|1800799024|22082099003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Mssr/io/CTEufDFwhwra61W7MrEpVDaCFSjKpWLivPPAzCXuGaGCoiy1ki633uHQtJmy7RX9KpXADPzN9/vLEIsSeT5JXPOg1MtNiAgogBSCcJO65CqWMUKd8NWPZLMhAB61EDCJfJJq82/UkYDuz2L51P26fyuN/MYnJvJOifZ2YjPr9WjEii7IW/4tVkifNFnSlDnAv092WqIJCDjzYfgOGReiSHqqDUqBT/vtLKx/DlIWjGp5RlKur5cQUYzwwoQ8DGs1+KeI5q+34Kw4sZrtX8YdtlMZuS7YLIsKSCkNeVP86f1fn5jWefIoc7gHGSDKwyFqKkbMIrkzkr/cuqnWKc7V5KI6FC0Ji/kaJ3UCr1PbstBRSyBlc4U5TQ1tdAIlxSDiGw3zrtqOmVDdtywowAgmOFy9i5FOfSe3/b6g0mfgz/wft2HwVSyvqDaex6SCuZNKwxVZX6PY+oQCQBAZ8a4X3uK0JvwefImrfJRuMDu06glbR0bPtDTJhFGqSTCPG7OTcsjqaZ7xAsnKDae9c7MJLhyfSc4f+7kRhezx9zjcB+0RW+7hZJEfP/7oS5VeMUncWis8F5uWjHFft+GFZ9E1IpfK5bSfgfUoaxfLhWdjaaNhaltD3XCQimGEiWapAJ1rG9gpESuhfjPrm1M4E97Trtjd5XTuPkkLGy/8QLH41C/kCxY4Wod78RVcUMBYKkf9hufFBrars8ryjg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	URIc/mbTIkydLyvwjagSzXsjeu+nVY0+suLXk2t+6kO9UB25Lcvxn8crlaBWBPSSn6lR07Kc1ROLcPEJdJ0EGCzhxLjs3m8BGdSgQiLc0jCbpCgLEVld8WjGveeNuabOBCeEZLlcqNsE7bp5JMuqMx407O+h37xun9l3LKVoMC+xVur/OAwqF7XCdIpU47zZv4ZrDmEwxgsPyXhfK5EI52JBYx215Vry2LXtbQv9DVIw/jtRzQXT6+DYOEUX25R7P/wi0e0ztdhBks4IgUbMU9fgZmjz4A90A8HvW2aHMopJMh5F1KuXZGMHeD9cVC2ddt5B76AVgnNKAUiaZ7bOZqjsokvLjR9FYh20Y7+5O0OuTlt13COLdtM+3cFBYsHbibfa7MYJlt65b6w6N/7WkggWx48RqChb3MNY3hKM0jsmwS7p+7LnfRi50tfnrP4p
X-Exchange-RoutingPolicyChecked:
	fFB2zkEFvol2VC7jUrXVvjs/n5vilzb9QAiEJV6rApUqG+a1aP0Ma4Oz0LMx7+QI2/4DjAc2C3TZbkzQOKqElBiEAtInSAQvdlF+sAVsl/1HdVcKS2vftegHrUmOvmUUFObyHVgSbF6XkPWIqn3F85m7HVBcfiy6r5InOytp5L7z8OpCTtNsjTeMfmLmIzpkEYXqJuWqkEwpi2LS3L+u6GvXVVSzXuHSyktLdTcToHvHgtqAaJJdEPKpGjrhgYpqI5m6AGWTEf37z7Yt1tWadLaFi0iPP0EMipCD3PCo43IJFNJGpEcyAogsD2Lxj0sHcK8apsdar7bBM0ub82EZqg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:35:53.5767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57239109-65e9-42dc-6a7e-08df1fda0fb9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5915
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX7apl0Lxr5nYP
 iD6x1AFEBa9lFs1UkfetWVrNSaLrNrGCEUjRY+acQPtHKYQmxBXEGIWxAEIUSoS6/7tE/A/R68H
 6YB7X7AR28Qx7iYbvDmsMfP8JAnTPqQ=
X-Authority-Analysis: v=2.4 cv=a6alZkSF c=1 sm=1 tr=0 ts=6abe8bef cx=c_pps
 a=l7cXxZGRKbMfBYROU17HtA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=EUspDBNiAAAA:8
 a=sozttTNsAAAA:8 a=OmYI-GrVpSx3wQj1XFAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX1OLP1XbZHX7V
 teo+P3YqxuxlI2uR/J/4/6SDFpbSC0OhGkIUXqzFFlcQgpXfUS6bcSr1+ui0BBict20HBIWx2fY
 chnFmjXFb32ja6wXbjz6TV0JbbK3ivnN/hkGWQT3w+ITUKKxN94Pk5I0OlB+oz6hfEBI2qJQzo6
 bmj3Qld1bcZQnG8x5KGqPQDlQ7+0hFFqftQzYXB07GFmHROYnJaTrKfDcGt4CvUkK00ZsSCiWrh
 IjO08pK01vMbkU6kSyJCZufQimmNNuWWqKaWDp+n8wlmVwkdWZnMYWhTzA8ST0gIz0nAEecLBYp
 Lg7+pB8F9jXJNG+eCrd3Vprdv6h7gJV1jyEpkxPKs+8NbI/8HX9gLGTc9Ud2JmOMohhKjEmRg4T
 WsOGAMvNIsmZGTckt7/Avho+hayqyr4Jw3tcga0eCGNI5XKMcj2SQcjJ6zbg7azOhaEmyQ7B8tO
 eByPrShKG41pqWpN4cQ==
X-Proofpoint-ORIG-GUID: w2AvZlzVSHyBNkk4P0_2gKvYOz7320HZ
X-Proofpoint-GUID: w2AvZlzVSHyBNkk4P0_2gKvYOz7320HZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010066

Add "ti,am62-mcan" device. Device is fully compatible with Bosch.
The device supports out-of-band wakeup capability.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index 2c9d37975bedd652b3060ab11ba75c37565edaad..b1d77b57cb75d8c0b48491f2376d8e186a3ad27c 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -16,7 +16,11 @@ allOf:
 
 properties:
   compatible:
-    const: bosch,m_can
+    oneOf:
+      - const: bosch,m_can
+      - items:
+          - const: ti,am62-mcan
+          - const: bosch,m_can
 
   reg:
     items:

-- 
2.34.1

