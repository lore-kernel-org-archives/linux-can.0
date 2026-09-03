Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9D501F4F;
	Thu,  3 Sep 2026 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465734; cv=fail; b=OZvQ0kceQwElF80e42spPmC/PR6DTSkswE9RCNGsj66Fd8Esbu7ebbc6WEiyIecazVjX8AmKoi3H12ZpYNYEx8lkPtFT4qntOwmXzlj3RuYX+ygXvGrGvhTifZZwhMhA2CHMqlFdliLkBg1otMBIGkIOrEa3tjm+LhNF44m3uNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465734; c=relaxed/simple;
	bh=KEmWwW73xIkATtdx6XnPKwF7ayTEZEw2w4bdsOXnmcA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNW2ky3KYAZ9ELLKPW4ld8vLqzvx6uA/gOs7yAUBqZmtBkw0sykVn6kQo45U99phCc43CZ4MDuyQOXtEf9x0iuAQlsr64deI2j1r7gEtDJM52rnqXmI65kXFqZqDP2ypdoHMIBg2iO4234hokWueZEoTZms7uWahsybvmesafTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=G6KA6/Dy; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pqvTeGtN; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="G6KA6/Dy";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pqvTeGtN"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683Jp6I91936334;
	Thu, 3 Sep 2026 15:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=6ilguIDfCjhTR45
	sOrc/OeGbGVRDZC7OP0N/bA0+uYc=; b=G6KA6/Dy2x1vIOtaMbfKoBx+Ruw+5gR
	+JOhamOsYRbybFLmAufnRp3dmXaEpiuRC/5fVXhsHXmBnMzG6DAjdyyjicIkb+a0
	v1kwgb5+YtNoz00LNwG3FFvheRlK0rD2wsnKoj9KSOUnxGeA7I0cY2+rNwMudz14
	PVdvtg+YcKGMH+sYUPKHaylDw9XQ+b7OF4yukPI0ryUHObTDiD7uwSKkvwbeH6pX
	Qu54Z4ziYymJCVrkgKGwB5S9joICPKryeyH6ghw3SOJabNhCmcu+iupF5AInPgxP
	sZfVuZzYlIQx241mqu/i7xR6ULbE40Unm7px2Ud+mjC9rZHFDRk53xQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012042.outbound.protection.outlook.com [40.107.200.42])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfdfq10n9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 15:01:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAVNjApacNxT3AxuxgD9zjrcdstzZRv63oVimlAKhqMcH5w9WaRE/I33TeCB1VBWXLdLPn5hedkvlrBS64pFFhc38+mh8k7zjttaoyqWeh7Tfcz0yfVAnly21wbG4ERlK979iJWPbr3/48tiLVzh3IROoNRdQsKsj4LiaiDBDS901uSPgclSDTt8W23V8+1L20UDZGX1QYH/Tdz0BWdyRkpZp6RFGuVecJ6q4qHKdfx8yHil87yFELPRshlQonhGQzBfvcfMajGSsZLu2oZ7ta3dnfq71TSDOSn0S48SyqhxqQn11ZV6ZEG2HuvMOZ0rY+m/IgpolOFylyqAfjBDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ilguIDfCjhTR45sOrc/OeGbGVRDZC7OP0N/bA0+uYc=;
 b=hlhMjgU+wwohfzjLAMoaeJDg9D9feHqRQGRYSmu4V1FRQnt8+5+p6ECLlYRtaHJ9zsZ6uehFevo7YCe3VTbSmEPcllRDlrITfaPukMWQyp4jczRUY2EF/s95lq1dJPpxNRD497lu7e1doyy1JBU3fgdb0hKINdzcQwYj0VWZpucuIeh9G1Lxv8OV5lBGOx7wj76EtpODgigG3M0heFT21+S0y9xPWRrPBYLfJPaKgpYdtQ3QzRRFT3CFDf1U+UuiOw+U0Ed9c0N90IevvObmLHvfRAz9zpYvOLOm2/J0148DdAfo4pwBr6oDtXLd9YVSmoXbZwDQp8Tezj61ePrxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ilguIDfCjhTR45sOrc/OeGbGVRDZC7OP0N/bA0+uYc=;
 b=pqvTeGtNF0ksAvzpfw8CA00BGvV3qqYSLLAi3d/lbrXiOk+vfJlky0tsHaj+25z4PBQlAuKWrhRaKhW+7eo/T+6OAZULGVQ7Oeby1OXort0ABJNgn/hXXYXC2eQxiNBO2ZQ7LdAF7N4tVmkAOlHCqbD5bO7iiKX0LCEm0oLflgU=
Received: from CH0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:610:b3::15)
 by MN2PR10MB4176.namprd10.prod.outlook.com (2603:10b6:208:1da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 20:01:43 +0000
Received: from BN5PEPF0004698B.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::57) by CH0PR03CA0040.outlook.office365.com
 (2603:10b6:610:b3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 20:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN5PEPF0004698B.mail.protection.outlook.com (10.167.245.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 20:01:41 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 15:00:41 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 15:00:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 15:00:41 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 683K0fTR2143726;
	Thu, 3 Sep 2026 15:00:41 -0500
Date: Thu, 3 Sep 2026 15:00:41 -0500
From: Kendall Willis <k-willis@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Markus Schneider-Pargmann <msp@baylibre.com>,
        Marc Kleine-Budde
	<mkl@pengutronix.de>,
        Vincent Mailhol <mailhol@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        <s-kochidanadu@ti.com>, <a-kaur@ti.com>, <s-tripathi1@ti.com>,
        <vishalm@ti.com>, <linux-can@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: can: m_can: add ti,am62-m_can
 compatible
Message-ID: <20260903200041.uz4hguhoihvtsyza@uda0506412>
References: <20260902-temp-v4-0-3896f7d16ce8@ti.com>
 <20260902-temp-v4-1-3896f7d16ce8@ti.com>
 <20260903-swinging-carmine-oriole-75b35a@quoll>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260903-swinging-carmine-oriole-75b35a@quoll>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698B:EE_|MN2PR10MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 50845b99-0b13-4b03-5dba-08df09f62c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|23010399003|36860700016|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CO6G/V0guCs6hUJvEgB2g4hopYJR56s772+m/a4io86Z+hsiEbRN1DjDWyIHIsMyO4HuncLxx7KXH2vfQmMj0BfHSpIsKHMN28lZpFn/Q7/AGzFr9R6ZlNOwDzuRLQ/wVjRjPBDbCUDkw70wp/pr/kBEMKQmUBtgrQcRlrzk4DwSJumpyH6tbJLWv2u2Dxy9hvbyPwdeZfdUFdof1d3ECNgjTYwVlViEx+ueqXN7Ipu3yi4jyc+1gHWAxtuNlPVpqsZg/PaiPUVt64vzk8guO0XGLkVd3A00d8lLkfdYXM6nzy2+0Eat93iIE+qxncfJ4SuQjxbEh3z/P5oCHFZY83TXKq8AHXlscRgD50Y3324IhOKQ6DJhZGURjuZtJNRX8xt1UQ0s9GvZJlBZdED7CBD8brC53z4dgXCq8OOYAjbRaHFn1KLLScQp+Sa+yr/YgVlUET/vzyh4/RVjx6CmTAT+cUWEfibZFAvR5S60mPJDVbvC1Q3QRBOrlVzEbI4J7/4cSFVLNL8DPPtGlk3+fwRcxr0lRsK2Yo1llLCCieYPSYzsof7At/ySWN0qsfDGrWLhtfUs4inOYffeJen22SgMsxwDtKfIQDYtioDCU91NPMk6ODs3iZHb2zDFkNszUdlZXpSI2r0b/kEUVaaIGfQ+6bJkus9OIMhQbma37J5mbDq4On4B8RkABGImX1/g258if91MTIU7FiNYAHh4uw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(23010399003)(36860700016)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hidC9byKO8EemfN+pJyG4R3UnHpcFHaqOQoQIVu9qnM3eY/L2wmHQ1F9hkuIslUHMykDXBikCBVUICTz+iRBDt1pKx9LkmQ6hFUpHaPUzhnCPKt3GFeKUvZjtViHdmQ8ej9YV8ikuBE0sAxN94mDin0wJkiU7LbbkwrnF4gD5V2M0pVegbEq1wsRobyTH9gU8tEznyMsiRtk+0zZpJB3i+2j1mNximMYe7HPVBlg+nkpMYXS4dX/jKZalPPP8Y4cED1Y0pVdifN/JC1lEhMNEj92E4vkruZ5q0hnF5MQocOYWyH9hmnKm3fHI5vT5fymP+exC745yY2G55z/vv7YdF0I0MWlX884K/U5s6bLyRTCB8LyvWvYBJoLQTW+2NztSpt2O2t0651jTJqdqAOr+/bkd3Z78+yghNX/+R7sqXxNNWegM/t2Lc9lpgeyF92y
X-Exchange-RoutingPolicyChecked:
	Dzx3b1S0rtt6BGW4kkrW1sb7wab5PUZyf0MljBNoOuulY0Vof+97tpu0HoHjKM6F23s6FEsZs8Zlw8o+I4vtw47disoa37JSwSl5JzOJXoe1t36xOua5EHZo9uJYdXumQWKyHykOLLWc1OVu8PQi7XFlfO7+eoRUzY19AEsZ6X1iCkAWG7pfXZ5ubxIfNFuCzGvX3KyUSNavRcDqejQYMZj5Nklw2HPX1/n2/eQ3ZkvzGJe/imZkvwt4IVPXk1vMtq3xFoJnJcPRycXmeL5ntdC+NwOlRKhorOlN/9aEZ3iTJvKOaOyAl9g34+hBHJqL3zq2ff4bquxAlTwCmhtVpQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 20:01:41.3555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50845b99-0b13-4b03-5dba-08df09f62c01
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4176
X-Proofpoint-GUID: O_jyh_NzZM13_R9GtK065o0CJe-Iq02I
X-Authority-Analysis: v=2.4 cv=K8YS2SWI c=1 sm=1 tr=0 ts=6a99d22b cx=c_pps
 a=YY8tFW9l/ybvwHvNOAc4kQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=BLkfqAu0e_Nn30-umgYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE3NSBTYWx0ZWRfX0kdecu+5slQS
 EaRiDdYvikf0ffnA2u3Voi+eBTLi0RTsWAURkFSGdMORMpBaej4tQ0JE2vTYPbDXwbaDajR45sG
 OMLh/WJNf5LVO6hWBh01/6w1H61XxXyXARhqCrcuZB21eXDATa/g1dFvfx+0NssLuRoCzIglS7Q
 M04thXJKhRD9401hMl78+xeCCZCtLMGh540E/uQg2vuCclo57OR06sapPVKc5QWutPK8SthUcnY
 +kBsZD2Ap80LyePS0sRIrTM4CvqxApy8GrjaUXTWrMDnoRCuKUw2hLz5KbM02iLOo7BIeh7+cB1
 cMP9f8wGWVUJMm/6CMYiVERsl5Agtw2XH4B5CarXebudAfqYIBtewyj5u3poJbUdN6S0FJt0CCF
 VXeqrEmATX+dzXViewoTaAHyS4KYwFIcpAHZoRhzpzomRWGnI9BDO+8fkbNLZvXjPHYvr/TSRCq
 LmuR5TT0OE/uZb4CDbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE3NSBTYWx0ZWRfX1TyIJILuV+e8
 /WiJmRBbw5B6pAxDbToWB9usn3x95wwF6Vc1E4RTTqYAFDIHCwu2aOpJ+mH2bmh8k3eqOWD43EW
 k8uc+ZrVox7j5jvaiG1Yjjlo/riy8gg=
X-Proofpoint-ORIG-GUID: O_jyh_NzZM13_R9GtK065o0CJe-Iq02I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030175

Hi Krzysztof,
On 15:45-20260903, Krzysztof Kozlowski wrote:
> On Wed, Sep 02, 2026 at 04:03:27PM -0500, Kendall Willis wrote:
> > Add "ti,am62-m_can" to the list of compatible strings for the M_CAN
> 
> Compatibles do not have underscores. Poor existing examples are not the
> example to follow.
>

I'll change it to "ti,am62-mcu-mcan" in the next revision.

> Also, no need to repeat the diff - we see that from the diff. Just say
> "Add foo bar, a baz-baz device, fully compatible or not compatible with
> Bosch because of this and that".
> 

Noted.

Best,
Kendall

