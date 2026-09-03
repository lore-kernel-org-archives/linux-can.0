Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A927C328635;
	Thu,  3 Sep 2026 21:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472114; cv=fail; b=PnOyZAudtP9pd/B4lhj7c45YK9pd15s9tpsUrBju/5U+58gGuBkjaRBhkCZMdDrF6vY3OfThE+EIxrLjuxsEPCydoXOpaa4PaZGDY5NRi2ZIjW7dKdX1wxv/TABFqsT7n4zqwCGWcIdco6ZvB5Zurg5S6GoGCZzaRwlx3FjjSiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472114; c=relaxed/simple;
	bh=ofop4G5ekPDTsK69j11w2ACwhxf81Xm5zz/jQFV3Mp0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/5nrKZR4QjYms6LCkFjx6Du9SBLnKmjWWi2DpwjXbh+Oyo7nY2VASQtFxEJ0W4RaUO7uNSJuOVyRnXd4vGqz1lqDLt1Wz1blLfQ0vxpHKsvNbiKHsQgVQgLtuQyYR9ogAQLDCro+jxgFwrxLo8FfYOAfzPm3E5YAefpOibY4OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=I4uRhEih; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MpfMgR2z; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="I4uRhEih";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MpfMgR2z"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683JpJaD1572760;
	Thu, 3 Sep 2026 16:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=s7TIeDHsSPo/z6s
	wdt1SHr4FerfsZrRIvHhlp9yzkQE=; b=I4uRhEihAGLiau5L4mcKQ+bXwcETvZc
	/3P39eiolHRvjDVsr6vzFjMoeETuJQKZtmoGPZ5NkDe+gNDLc9XTKQKmyEiOXKsU
	Ic8jJHed40r7pMBD1hjY5utC0IuPzTLTELWdl7AQym8xMwqPYePX+rCPh1zIkazm
	+xhC3GR1IkEWWEsC89xYwtijaRGp8AtkJIQaCgZUuCq+QRrbZyJwmaEP1OvbiqCU
	kiEa4KquBU9Gy9vNtE/2/sFzOQIDhVZdT6VVufBYm1icMG4GPjK32RjJT8eDYKjf
	Sg5jjsMS8S5hDnvjVp6T5tCF03iLDOlWMhPl5mBQ/Ha3FvOpz7Exwzg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gf68jcy6s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 16:48:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inCX2FLh/DVIvNfmPztybku9jI/hJ+4zXMetLxfoAkByzrA4o1b4slziREj7UI41UrmvgmNOZAh7Qw7Y6NSshduHkVyxR0LI15iRX5Kr2sLVtZOCBUUeO0t7DVHZbPA2HXtA/THSHCUOQdVaK2z/9DirzuicqWcoEdW5gS7v+KxCWr5JAQJoDMqeXscboVGpklQ+4BI5BHr2WBMheq2bYxNGKlJyl0CAq75A0doCliIwA/68drHllzejtp2eGX0e1FUAte5ORH5h+a2Bbf/DmMvZKg3ICkqH7UHWnqezqC0TYSPJRetlUJ0c1qIDTayWgzp8meJHEU12m8uN9HrNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7TIeDHsSPo/z6swdt1SHr4FerfsZrRIvHhlp9yzkQE=;
 b=jxJUEFWSpHlkFFu6zEIYICGk5Oon1why7dYJTpXxG+6w+Wt4/MDm/u7D2DKv4imoXV7ZKTePbI5KLeGFaVJajJhXEjEKpybmqWOkNLl3lIBInRsJhskd9waSq1pKbVxNjvZQUo2pVYqf1coUcxafIcmk0GSuZtf5iUHupB5j5Yqs5VErar/aEmJCoJLcUXdJr+LEx+84WW4s+uMcuxiZyDxmNH9tyqtdzi3dNq9b5c8HaKf35TuKISetoIKEKvWbvZz4GCxKZ+BGJyUfo48hscntUY0nUeiwPiUn0GVcSrn+FWV6jYnYXuCSv+3xeQM8xaIvquj/QMoBOQPQj4cPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7TIeDHsSPo/z6swdt1SHr4FerfsZrRIvHhlp9yzkQE=;
 b=MpfMgR2zrzw7zsT0tBhlLoHsmSEKNSk1shB1Y+qcnk8jIq2e0FiCrHcm1X5ooxCPtwYLn5XlGkhwH+rI7afxku+Hf8x8lYVN2p08HSAjck2bRnwE0jGybFvaO3TeH6KZNaHxdwtIF5f9wC+iyupqHvRfaQbhiqFqc/E2iHHzV5I=
Received: from BL1PR13CA0275.namprd13.prod.outlook.com (2603:10b6:208:2bc::10)
 by DM3PPF72E3677A1.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 21:48:15 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::a4) by BL1PR13CA0275.outlook.office365.com
 (2603:10b6:208:2bc::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.4 via Frontend Transport; Thu, 3
 Sep 2026 21:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 21:48:11 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 16:47:39 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 16:47:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 16:47:39 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 683LlcEr3306927;
	Thu, 3 Sep 2026 16:47:38 -0500
Date: Thu, 3 Sep 2026 16:47:38 -0500
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
Subject: Re: [PATCH v4 2/2] can: m_can: add ti,am62-m_can compatible with
 out-of-band wakeup support
Message-ID: <20260903214738.utkkjnyjdpnug6hu@uda0506412>
References: <20260902-temp-v4-0-3896f7d16ce8@ti.com>
 <20260902-temp-v4-2-3896f7d16ce8@ti.com>
 <20260903-crystal-wrasse-of-trust-a9dbc3@quoll>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260903-crystal-wrasse-of-trust-a9dbc3@quoll>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DM3PPF72E3677A1:EE_
X-MS-Office365-Filtering-Correlation-Id: c50d9c5d-a8bb-4e9c-9a26-08df0a050cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|23010399003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kJUYyXLZ4L62UduWPsMlTr1zum40+U2fWFRPlnW7b5n5rwHeOoziJBKmUsxSK3SkJPjjC1rN0WYoeHsywTeJpvMIfODjZknPhTRzRzfLpokBoejoHGbk0cV0HZCV1qYJ8xzoUayRc9tARCn5m0Omcpc6yIlgR+tJugLoJx+llC1dyd4Wd8v5NogA7JmQ1upzY6q2GYOD/4Zj36DHtBx/Ewz0+CAzIMwXco95N6TIp16AnUEkCD8bWqbL9O/lLkwoHnr/jRU4hPBvqlpl/JMG0JV9u0VsyFpnCT0BKNYl7IGzj8WzyzFgHGx4KhWseUvXDMQuSnGnj3COGCVOfTvB2QqJnUaxSapIJ65sMF7jvs/YXJSqLgq81HLg/UnZNhch2TzjL5weu7pjc8FJFRVLK1uIX+Z0tp+9J/20D2WlI/NWmTJgla+fGlxJX6stc/m/7/0EpcQ6mi9n+5rxJTdr1q6NUKwZ5nxeM4mxK+b3sAfox7v/J8vpOQE3BAMwb4VA2SPsQHLd9A0ezbrpajcTBtq87b30uHh/GHuuFsh9+O6rOK3I/B8PS0XMXZPJWjD4lsJJ7SHl6Xvj8GgY1+UuSePCF+V15hyVokgFXDA5xA88Tc2n5ZRx3v7ZyRDj15DxQJjxXPwWKp/F0aLzsoxl8vjOq9F2xFTuT7tcjoBf1K0KWAdQs9XDXLAwOm3y8J1quMmti3R7xpuyIf45+M78cw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(23010399003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DKCG3tH9G6Vpfzo60d0W3YMqxw5lEUplN4aCXIc4AnChMMSpzmZQhVFRChNA9nySDAUysX3uByDtgCSjzYXVmM9wlQdzcC4llw9tr/nY6v5sYizKUWs03nnue4LOaj98LKR2IEwWJptkmsbIuZYaee1zWRDT5ObQkc6jTeaj96nSgxkbRxccP6Uom845ryeJPnyqmhakkZIfd1NrcwAkLhRhJVPpwAzs1EmuEvg9LoF5VnQkWllCi9Rd95kHtuFJfWbvZhvfb5aQNi6goiN7Nfub8I7z6t4VUStxRCyYRvQpn8ZP46WkHto+5gDaQqICA2OTUKikdwTFOJm+BH5DKtm1FYCtPEvZxjP51+5cEESMz0wBsB8bFfJzOMUilGr773iK91cCkGP8uljJTzLngJ7HDDODQsYdHNseXsCPDtWWrIvht+LHOXaoKRUmLO93
X-Exchange-RoutingPolicyChecked:
	Ia6z9z4Qdv4MiTFAfQrIs+omtgWr4vHxw1gzdDWqaBXfrFfffswOjDVAlWsWuaQ6+QaOKMP6JENZRkyZNdSNgOAz6DTWmsnuP6tQDEOvBVo7Xz4kfrnKlXz/9SXt9GVWlnlsVVEcsZxBhLDpl2UlTnr2eLBNT+f32QS2J571cQ4ei8SfvUPDP0HKu/nCqAlngTN+VsMXDC598mBhHfSsrQtG3MUlek813zwoQuXmO8FN6Eif9QsCdqkvGgwGY9s4h+AeD7NGeTuC4Q7SwRY8GKs9Egx5U3NZZz5PIMir9hg3H89mTqIP7P1+sfpi9IBwH9sEpr9TmWgFh75iM+z1hQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 21:48:11.4226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50d9c5d-a8bb-4e9c-9a26-08df0a050cc6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF72E3677A1
X-Authority-Analysis: v=2.4 cv=MvBiLWae c=1 sm=1 tr=0 ts=6a99eb23 cx=c_pps
 a=333l4QiDdYhx7c8CB7C9lg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=tg3e-6LJfw9bsfWTEsIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: B9uOpoHnG956iRg7_xJYvs4ybWsBw5Zu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE5MSBTYWx0ZWRfXwbf0ZGbrapcX
 ifHq59W4W6HzSekZQETCujjyRc/7tsi/D+9Fk9jG3/isYM7VbMYTopZeoV52ZeEcx33jJprOo5m
 fe/oENPf5dP09F/mF6oaW56NdBVO+xjXA9ObjW0wuXj1B3H2va//XSKRYZ6dXvvKz44+XSmoihl
 +nrHgrTZZyxzOzCKLlwLFkhT0X2dHwS7zYvfBBXO96LhCiDlsS/heE0dgl7xzUmMBLWxhlc9ecw
 LaYAXk48nHyQUFma3y91fDmH1a4jq5IFvsY9Gvb8ROjaLBuoOnNn+34Nk28pRMY7e6+bb+o8HPw
 oIRHdSiF2IaXZghNRjhBj9udBVhWTb/ieu2nZX5CJ19IrYJZ075CD7umiMWzQ6YwPSdl3/DZIgL
 sD/cnbLm2YDvVhvhajsOltiag+eN7zjFY2trwCC7iYeM/sqzDAHPuOu0hbFfuF65kzPEWDfHVYu
 ttY4tygxhj8YEhTJF2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE5MSBTYWx0ZWRfXxMgr9lpmGpos
 iQtADwnbN5YnPdQmVRwX6ZO0Y2/K1mI6TITGTf5h/G2QKlTVwMpDX4SA4R5MjN4A/hToyxS/uAU
 HsmRWQPwKu2d4py/6GnvUx1tqWa5Q64=
X-Proofpoint-GUID: B9uOpoHnG956iRg7_xJYvs4ybWsBw5Zu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030191

Hi Krzysztof,
On 15:46-20260903, Krzysztof Kozlowski wrote:
> On Wed, Sep 02, 2026 at 04:03:28PM -0500, Kendall Willis wrote:
> > +struct m_can_pdata {
> > +	bool out_band_wakeup;
> > +};
> > +
> >  struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
> >  void m_can_class_free_dev(struct net_device *net);
> >  int m_can_class_register(struct m_can_classdev *cdev);
> > diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> > index 56da411878af0185ff9cc512e325137428a68255..ae2d89b65fe8da65b1ca73cbf80cd8ee8483e2e8 100644
> > --- a/drivers/net/can/m_can/m_can_platform.c
> > +++ b/drivers/net/can/m_can/m_can_platform.c
> > @@ -218,8 +218,13 @@ static const struct dev_pm_ops m_can_pmops = {
> >  	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
> >  };
> >  
> > +static const struct m_can_pdata m_can_plat_am62 = {
> > +	.out_band_wakeup = true,
> > +};
> > +
> >  static const struct of_device_id m_can_of_table[] = {
> >  	{ .compatible = "bosch,m_can", .data = NULL },
> > +	{ .compatible = "ti,am62-m_can", .data = &m_can_plat_am62 },
> 
> How exactly having out of band wakeup makes this device INCOMPATIBLE
> with Bosch (in terms of DT compatibility)?
> 

It does not make it incompatible with Bosch. The DT binding is
incorrect for having it be compatible with both TI and Bosch. I'm
correcting it on the next revision.

Best,
Kendall
