Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3CD4FECD6;
	Thu,  3 Sep 2026 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463445; cv=fail; b=P2xlsDb7eBgjz286GulKipLUmqg6TPI/YHICz3wL/2EruT/3/l73hsmJZ/IyNggVbT9PgciWEy7rYdwS1GpEdRD/3paez9oQLmRNy4FGZK7WCh/seTI2Tmqc7FBskr00y+WwxsEgFvBgy01Stqg1mLOPlj2dAq4gLB/7zxPG6mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463445; c=relaxed/simple;
	bh=ZWDGJNmNtUudJrmnIQwauh85PSPjIcQfASvf5YX/hLw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTr2CcV5LdeA1/KbDSEITSyOrFDs1IiJApB4Su9SWj3FeKKGW1whA0+c5DjXzlqeEFYVKwXoj4Mhe+inExtj7lR3Fl72tvlT2EYwxmRuymYpWcTmKWkjcSNhjsNfQXPhtZOMIKFr+/nTi+teU/+WQrq2DstC4b5UCw7cBHWqMZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=n6ycEp2b; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=siD8z3DV; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="n6ycEp2b";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="siD8z3DV"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G0iew1130400;
	Thu, 3 Sep 2026 14:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=aBIxYmsYacDrwt7
	z3xp6bcqiG8v9en4y2JXrOj5mkJ4=; b=n6ycEp2bAR4rVWXpkvoTjf/fG40fMal
	1L0H3kwxE24CUTtrz89nK2q4eZJVuT4ZVIzf5DdGI71/xrYRC3zP3P79MS4Ig4aX
	lY8dwZtSF9ua32gE/VnjdC7lARhnGJeDswVL8l5XQJZltLfgScepHNJ57J/2tVnA
	/xwRiHUlAQANICWZ3tcRXWCTLH3J1OXz6NHEyLNYqFkfYaI1XjwE9Qak3qQyAmHi
	uQuoBNd2r/CLIFIjGqK5gR1Z/ScfCA5XxaJwZULvH7oM7y96kVEyVar3O8RR8CwL
	Rlx/iQk8ctuW90FkONuBImX58NSxl7M+TJGgaa8SZMA2+ZBYLYVwx+A==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gf68jc3sr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 14:23:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNANBbCZhDEeiln3/cT8Gl1bVzgbV5OQtrpG9hiNjKExKDP29srma694vGUUkUxVNUf0tUNlVxY6HzYRzKHQknNtE6yOjkEMK0Lgrj7SF91gSYvREwfVYSYQuRR7316Lfnp2T5zqaDMwkvohADFAlg3vF9Va0LlI4+HtB9j3Ia4hfumVPoMU7DO3Xfp2YsG4omaYiIbmZFf7XZrjh+e3X2EfzxVf8kls6phqcAeJGG9ao2SkHWjthfpTIGTcSNhEYCW41lihBaPHny/tyo9EnJu7yJKjGboTH2PXIKuWtb0q3X60z8DSp2A9GlGIdSN4TtDKUjv1X+3R8n0044sQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBIxYmsYacDrwt7z3xp6bcqiG8v9en4y2JXrOj5mkJ4=;
 b=dQaE/Rf24KntT9E+vmiAFyy2eaehwY8fhwII7GZVlL7cWVDIwZHzQ5ZSJpryrJlmtvc4pdkw/OlSpVqWJPom4lw0SiS4XKuLF/e4KaQFAsg6HheFJ4+KSFVpsvxA2jBSNsm4k0CWMraDAkrfGaMITB3JTjQXYC9HOB/0wwpOsz4Ol1sSEXN5LbnnAHjIui/suqQomfYPWuyHBR/nWIAQx98Vmdd2yMl50pugr8mrqtUnCYSNvpJxGMaj5F8j8GbPT4ImwNaUjtKKCG6xgsU4Ks+pTGHv6Ols1GNmNQCXryO8mVjVv2NX0rw5Uji4/0DAew88e/kWvG8JfdTda/itBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBIxYmsYacDrwt7z3xp6bcqiG8v9en4y2JXrOj5mkJ4=;
 b=siD8z3DVTA8CQQ13u7Lcp4yqo4CTLFgX2v2SIGFBAkFw5Yyo7ZJAuM6z2zSMi0JGJu7q1mql8r59AbF8f73GAUSc7pKXjdWa51t5ULTh0MYu13AVJE1KOSdAigYusVtGB7CRJpAH6qHr+Q7t9QPMoovdgkmHw82Qlu7s1YxbTAo=
Received: from DS7PR06CA0016.namprd06.prod.outlook.com (2603:10b6:8:2a::29) by
 PH0PR10MB997617.namprd10.prod.outlook.com (2603:10b6:510:383::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 19:23:34 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::74) by DS7PR06CA0016.outlook.office365.com
 (2603:10b6:8:2a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 19:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 19:23:32 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 14:22:46 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 14:22:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 14:22:46 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 683JMkPD2098889;
	Thu, 3 Sep 2026 14:22:46 -0500
Date: Thu, 3 Sep 2026 14:22:46 -0500
From: Kendall Willis <k-willis@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol
	<mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Chandrasekar
 Ramakrishnan" <rcsekar@samsung.com>,
        <s-kochidanadu@ti.com>, <a-kaur@ti.com>, <s-tripathi1@ti.com>,
        <vishalm@ti.com>, <linux-can@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] can: m_can: add ti,am62-m_can compatible with
 out-of-band wakeup support
Message-ID: <20260903192246.ui7gkoyfhpgk4yaq@uda0506412>
References: <20260902-temp-v4-0-3896f7d16ce8@ti.com>
 <20260902-temp-v4-2-3896f7d16ce8@ti.com>
 <DL5K0CZS9PDB.1HD8YBEQOUABU@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DL5K0CZS9PDB.1HD8YBEQOUABU@baylibre.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|PH0PR10MB997617:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a5fa0f-acfc-4398-1649-08df09f0d7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|7416014|376014|1800799024|10067099003|4143699003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xWrEg9y1QdY+Am0lJP6bHwjLQaO8JqaVx6p5HVxYzkdDesa9Dzn7x403eGy/lZOLZRmNEYhl5ZXMMHoQearkmyMYZgQH66z+uOXNuudguSnpYMn+FukM4rgHr5fKO9D8XJ2nTA8AUKJ1R6hiymKw0G0xk/yQYKb/l7MSwJ65YjK/wIQI1r3YcsL7uBwDmaescZTqKvSufh+osNGGZacXFe5fuPmq6oTFBirOZOopM2w6EempJBTYk168K9ISF7iPvsdjODc39GiEUWv9aLpp/R+fh1ylc00euA+9cJXx8ZpGe3YUY96ivNkSP5eN33Bc5TEFvOK3IaE3omxIPvUdyhxLUlJXFahufoo/o2vkQDADd/q1RTp6v9YIa7OqjLBbrNKrz5lkPP3JBgb3tCOUW4enxKqifB8vr3vYRPKDeeHibOok+j3zb80pZZXg0lG/mk/mUOiB2UEIg1eRVZJUgzwLQf20GKWumc2dYcbZhuCFQYATMpPiyT4c+AiMfnTRqj8qujUXXwmbKPtpeLe4cih6Y1paTdMdFDdNFGTSVIlle7Iy0zlNrFiM/hj5M5+HePY7aa5nXqHaY0Ey8sDeYXZQFE5JRcoV6VWAwF0/ibr0c9xfXrcvr7Xkt7fdni/Uy+/loxSNOMBUJIIgzn0AXKqYhTHhfaYqHQ3oeP6hY3OCJ+wjDvhv7tGkTx1DMX8CQrfl3l+9jIVQr2XCTnitQg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(7416014)(376014)(1800799024)(10067099003)(4143699003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wx4amsBNe0n/mnzz5hGFaFlJEQYIDmmMpYVanMFQhzujWmmA4OiF3U/0699ozK6LY0cZsyiA/xN3Yv2yGnxTBf0qTAsF3femf/gpLdtrKVPjKO+I8CQiHn6c0VepfPMKUH4EnG4a+rD2yf2gYUU7Vlc6uwQe8hGlqd8IFyP9BZsLxkPTDWsZJjUNtqmMXGY+uXxPwoO2HDk2s8rcPBqg4npU9hppL46B5SDefzzts4gK8moVRjjDZRZfdPNpOm1mJmEYxkM6tUYXl4FeJOhormCDDM67O1gAHnpY7aS9p7CDE+t+wtTK1v5BWrazYQiRF05SW5z1SARK89ejVP8wkGQUFBZx4lkQjvw6DEyTEV+GlqAR7HT3qNZoxf2hGtPoKiMNKeWtjzrdhWjRH5mvLLaxJvR6TfteQk/WyZH8nZ4WV9wAIP9GM3jDGI7YRdLY
X-Exchange-RoutingPolicyChecked:
	l0ouigDFfI/LQ3u09aDxe7MZ9FrcfNfdfI1w4QeRuBNlfuW6asXIPTMiQZP3IwfjVu33cMpRFBjci2FlzlioVgtcgSc/2KUsARErm+LSJYKCcFg3+kB3nRiUjzJ75OM9vx3SkxpK4UxwL4mcfKwKSdd7Qcq2+RzyHDJayO7tht/lK2bLZtRwCYW4uZBx+ONvA8v+6yPMLvqLRvB2m9NviKfm0VBF1os/WTzY/6bW9Rf/WT/0pR5loIwlEKcEuWZzkjEiD216eWBs+6z4mnQNxy8jS6wVBqL7TU5egIYkeeVRUHAecpN6cwAaTDhhUsY2jt4Ik8nqqZ9peuF14z5cJA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 19:23:32.8359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a5fa0f-acfc-4398-1649-08df09f0d7e9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997617
X-Authority-Analysis: v=2.4 cv=MvBiLWae c=1 sm=1 tr=0 ts=6a99c93a cx=c_pps
 a=s4741YMcG+xsu4HPw1GdWw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=2V11oBgUunfCPsBR5tgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: aeIQbB2CdQs370BgYeQcvoO6rdgh9vQ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2OSBTYWx0ZWRfX11R84sJ6FEEM
 CDz9MvImYrgsmiE49FLUMUNTEAgsDN2OJzNNAKTr4lwKy7j6aXxr1K/DoT2GFZwEus6WJ36ZgTK
 MbGuPIzhzqBT5sGMtZ4OOTs4YWQ7Plrh1g6d5vobyL+a38ymF1iukqEJABp9fsJgITyNa0ByHa6
 dlkMHz+4xd+1+wJba39cQh4nN9yzK+aQ90ussjdNj5Lw6Ka8dfGZ4Zv2M2Pwvtpv/zAKazx/UCg
 ZwL7UYxhk75EPzsfePlJSxT3kKsCIzUMlweJ3VYmMGaM608VaSyg9aKIdat//apCl4BcCiDqM4e
 9mNgsKkKFrj+68hZFxAh2mFgLPQq0QmTYPYq1hlKdereckxpwamcAgf2HIUtximLUsrStSgCdiX
 vYfwNpYymjIaUIhoOizm+2B4H76evFAP05OHxVc/f0VZw8ct5lwdVZjeeS9jDrqKTyfPqLw1PHF
 K7mXi9P0aF5tERgUryw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2OSBTYWx0ZWRfX3O7lA7wBu5s+
 ruyIM9+w3jjLWkyt5p7N1rp0t2Gaa1WbwTKgDSNcL8dHLLAtxSE405Ch7ho2ivc/zwWdxeuIVfc
 1tbKSQgERTFnzCCtGEzRnBaaF9RQafE=
X-Proofpoint-GUID: aeIQbB2CdQs370BgYeQcvoO6rdgh9vQ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030169

On 10:55-20260903, Markus Schneider-Pargmann wrote:
> On Wed Sep 2, 2026 at 11:03 PM CEST, Kendall Willis wrote:
> > In TI AM62X, AM62A, and AM62P SoCs, the M_CAN controller is a part of
> > the MCU power domain which is OFF in the deepest low power states.
> > However, the m_can pins are able to wakeup the system from states where
> > the MCU domain is OFF through its out-of-band wakeup functionality.
> 
> There are m_can devices in the main domain as well. Does this apply to
> these as well?
>

This doesn't apply to the m_can devices in the main domain, so I'll make
the compatible to be more specific. Maybe something like
"ti,am62-mcu-mcan".

> >
> > Introduce the ti,am62-m_can compatible with match data to identify the
> > out-of-band wakeup capability for TI AM62 SoCs. During suspend, set the
> > out-of-band wakeup flag when the device is configured as a wakeup
> > source, the "wakeup" pinctrl state is present, and the match data
> > indicates out-of-band wakeup support.
> >
> > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > ---
> >  drivers/net/can/m_can/m_can.c          | 7 ++++++-
> >  drivers/net/can/m_can/m_can.h          | 4 ++++
> >  drivers/net/can/m_can/m_can_platform.c | 5 +++++
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> > index 16f80607e150e2ca2950616ff2c39b7aa13710b4..0788816d881ef8ba84ad5a84a6d2d3e60517ea7a 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -2598,6 +2598,7 @@ int m_can_class_suspend(struct device *dev)
> >  {
> >  	struct m_can_classdev *cdev = dev_get_drvdata(dev);
> >  	struct net_device *ndev = cdev->net;
> > +	const struct m_can_pdata *pdata = of_device_get_match_data(dev);
> 
> The core m_can driver works for all m_can forms, tcan, platform and pci.
> I think it would be cleaner if you parse this in the platform driver and
> set it in m_can_classdev instead. Otherwise of_match_data has to be the
> same for all drivers which is not obvious when you are editing tcan for
> example.
> 

That makes sense. I'll add it to m_can_classdev in the platform driver
in the next version.

> >  	int ret = 0;
> >  
> >  	if (netif_running(ndev)) {
> > @@ -2622,8 +2623,12 @@ int m_can_class_suspend(struct device *dev)
> >  		cdev->can.state = CAN_STATE_SLEEPING;
> >  	}
> >  
> > -	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
> > +	if (m_can_class_wakeup_pinctrl_enabled(cdev)) {
> > +		if (pdata && pdata->out_band_wakeup)
> > +			device_set_out_band_wakeup(dev);
> > +	} else {
> >  		pinctrl_pm_select_sleep_state(dev);
> > +	}
> 
> I just noticed these are called even if ret is not 0, so suspend failed.
> This shouldn't happen, but not a problem of your patch. But you could
> add a fix for that.
> 

Yep, I could add a fix for that.

> >  
> >  	return ret;
> >  }
> > diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> > index 4743342b2fba3823819b9e2bc5b085cc0fe6d1e2..486d808bc677482acf446b1450c3a9b6b7405178 100644
> > --- a/drivers/net/can/m_can/m_can.h
> > +++ b/drivers/net/can/m_can/m_can.h
> > @@ -134,6 +134,10 @@ struct m_can_classdev {
> >  	struct pinctrl_state *pinctrl_state_wakeup;
> >  };
> >  
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
> 
> I don't like the pdata name here, this suggests to be platform data, but
> this is of match data instead. Maybe of_data?

I can change it to of_data. I've also seen soc_data as well, but that
doesn't really work since the compatible is per power domain.

Best,
Kendall
