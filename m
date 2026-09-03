Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163D93D6477;
	Thu,  3 Sep 2026 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462308; cv=fail; b=LsdKHGOSdCnarqKJPcxgU2oG27BXsMvR576nD0tFuUIiCVJEOJw7q3b1UTSkfJLe/ATaccW6RmCg8QLY/FGEGma+nxasxY/3jrjBcyLslU+xZaEqyce1SXqdWu8X/hU1q6fZ+5DqvnIJrGqIBbed8ucMBGHTjOp2TdtuqfhFwLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462308; c=relaxed/simple;
	bh=EpztXqm0h+33C8orfxlOTwm7X2NdzAWM9wYwLlIHmIo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsrBvm82SZTinjZlvpmfL2cYG/Of86l6XsNA314kyM2s+L785L7Vs6ju8Mmhw5SfuMXGSo2827sx6MJWbQd9OKE0e5AzdW2YITIaHrudqsCXzNhtH40Y1RDynlduA/iF3jshH2Yk8yueK4C0wXfjJt5N65Chtb7Rf+Dyr3KJxdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=g+k4G1Hr; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ufkns/BM; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="g+k4G1Hr";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ufkns/BM"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 683G0dHq1342679;
	Thu, 3 Sep 2026 14:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=L335E/YWa1xlq2F
	X6D6+3d94ZayAj0rTQoZPFmSwZ84=; b=g+k4G1HrdmfXhZyQ9MzafhdNw5VVs9f
	wMUNyL4uBqR6DwPdX03GfKJHiNclnzJ3/wcirb5/cF+OwJW2YrQ/lZ15JOSUrZt7
	Uq5dPHiOCpz1CRjRmB3ywYJ3TSxRVflnIXyXyAWeGhNGji5uIanrHrSXg4BE2Esz
	SXj4uTaQZGvwYrPhJrR0R6FWwToQx3xp6WCAD953oJGPXBnQzaF6AYvwmStdYz+z
	TEVdcP+4g9y+/bY+Xn4K/bCpTxa+VJd5HGrBw8SH1izgCof6oUG/8gwUYqdY0wMC
	Tpgu8ev5NupWOQ08cPiWSZXzlUGhAzM/PJiLhfFDxXVfJ1IqUPiOw9A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gewt8pjvs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 14:04:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJ3la7na6sKI0Z9yhRmsxp8qrmDdigkIU6PHQbEUklCf/o6FNrxyFhuWj3HGb+sY0aU2lHc9r2lISXKElPG7Gh6HW5EUE/GVSALwFj+o2PN7BxE7SUQUAyzKDnh3cob0uI/WWPW+LBsTMhM9wJFKTAvf3jQXd5vDPoOpC1cR7jIUWQkbP3RyAB75QL4c8T+rfS2JBDyMmfkNZUdlFXpaZVkh15AgwCifhL2bz8H625EfQ8Ern34qf9OghhAvxLVA/21lrSbsR+1dbBactAjnii2SW0G5GvX8emoVCZom8xmGNO/lsmTOMtivixqwCNd+hK1IKA2vFqWKIqXhAtJW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L335E/YWa1xlq2FX6D6+3d94ZayAj0rTQoZPFmSwZ84=;
 b=K+NBq2V0A+9LRWSzoLlTIgDvXx3OsrX+i+CtNFWpuQYpfzFaL3wl6KedbXkaIV5vkR6binn596gjcnm7y3Zlnx1gobs2d3YqZlgCYF1J7EdRA1wGGFNQvs13y24j0Yb1zvXUXaDuxVDEeSC8FU3+HCEqpX6eX7VGBhT0NcqAcKKMlz31XAeC76KIk9+z+Q5mXLbvBeY/ekU9uJ+93rcueCSEx0uqaphupBSSKgGL4chKKi4lldSx2NrBlUNPVdSeV18nLID7PkHeA8XG5+p6Ck0fSWR+vXNReEkRxXW+qv0IscrGN64QnkWsBhU/65pOyftf/BSSm8nl+Fd02xCsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L335E/YWa1xlq2FX6D6+3d94ZayAj0rTQoZPFmSwZ84=;
 b=ufkns/BMCmfdIXrQqrF9bOSJrGxwmHbg3x5H5aRjALBOVoCUq5Rhib68VcLwUUrfJkuhnpGxyULj54SYgwmUZMGwWsI/T98jgo/fpCmDNAr+b4hNhVmTG7n19JBwlI9l4lxpvo5ncJheA0dvKBiZySjsts9zfozG58rxHpJk7Hs=
Received: from MN0P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::22)
 by BLAPR10MB5185.namprd10.prod.outlook.com (2603:10b6:208:328::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.8; Thu, 3 Sep 2026
 19:04:35 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::10) by MN0P222CA0017.outlook.office365.com
 (2603:10b6:208:531::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 19:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 19:04:34 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 14:04:05 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 14:04:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 14:04:05 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 683J452X2076463;
	Thu, 3 Sep 2026 14:04:05 -0500
Date: Thu, 3 Sep 2026 14:04:05 -0500
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
Subject: Re: [PATCH v4 1/2] dt-bindings: can: m_can: add ti,am62-m_can
 compatible
Message-ID: <20260903190405.pezcn5jufs5atxmm@uda0506412>
References: <20260902-temp-v4-0-3896f7d16ce8@ti.com>
 <20260902-temp-v4-1-3896f7d16ce8@ti.com>
 <DL5JFZPXGYZF.2JXFWOJHEMWAF@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DL5JFZPXGYZF.2JXFWOJHEMWAF@baylibre.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|BLAPR10MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3ece0b-5b04-4c22-4359-08df09ee319b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|36860700016|82310400026|1800799024|22082099003|56012099006|18002099003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Zvt2RjemG20XFgKo04Uy5QDHq8bVCRbpTCuL++Mwmnw5ySoQ9CE533O2FYHOsW93CEA+3C2cVuVi7OYVISAXBvM70pvj7w1cLMB96LXRu050TBIQVF2aZttKhEIP5p8THBPCzd4nB5szyOdVOGat4wO2mj+t6+ota8VnGw3jigisF+EaxkxUfVKut1U3nQYO8HQ9daD6zQKruVO2GSU6Fa/eRrnNcxmntxQSx3hFN95bkfJ//3yXmAIXrRxSOwv01c4dK/tF/mWJkSvGV+7qHMEMSVTGEdRc/oRNdOCa9R8KSWWOXnPBhb7Agdk+yrkc/e5vZGzG8hd6d9hIRZP4hccZZ+ilzTYjqDU+q7+jVfpmo6AORKQ2G+Ci7aHSqy8HurEfL3KxoY3oJIIZ4k7i+VfgXpJvdmgkLlofOP/dYl4hcECzEnLspoX8ZoUXHoN6n5ESjDJgH/zrjyUTXWuOFBdaOK8PtTLBrirlrW9crDPKOqSxkbLmq6ArjcIvRpyrpmtj+atMNRnh8sfpVwhj28GWr3V5U9doDXluZZpqts4siGuhoW3bScfVjN+Wr/SKCtqS3yAVAYbjsutOHkEI9vslzJXq6lgm67nDhxpRNYaHF5k47TGhqsDyPrNoGddlkswnjlk3i/e5vSS3JYFlWcmLnmDrQXFr6SOSH8kpntaHDswz5gUN79qFNEWrgJjXCGj4WcvpYAxNbMJgN/Yp7g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099006)(18002099003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1cmrS6A7KxiK1thuVCC8A61fzJv/sLaoFLg7ksgWWgXn85kpAIJwzNFHwtzibhgpDEB5kW2r2iAi60dAD+aImI3czEWzbpKsV62XBBoPLvNfj2DiVqxasL22b1W+b8BXrln3RnPoN2o747FirqwcRrdHZOdmxdVgljpy2oW1bURM8rLPgGa+ECBCqcwEAw6TzARdo8/eCgP0+BBkTxk3YgfEU72/YgmyevR03mQD9guy8oNHzpewkT4x2aWyzak7wXnpks4DhilkLvjSvhO5M0aT76lVVqQ2cbjB1VO+bt7jX3iVwj74C27tMDL4XWtd9mh71dP5ZRJbNlazGZCDMcxVu2GfJ2HGtaZx6Zr35fXhqoPIxE4EThzL4bkdNZYIkYkRMmjB3TClU1CK5IVStYFw/WeR8Y7JJ7mBpMKDt/gR5PU+NOP80WGNNX8gxvc7
X-Exchange-RoutingPolicyChecked:
	D6twgxt+hcfXpKxV8oos6AP5ej3V39SpWXmjUhsW2HDnBWgh0Ezl4G6zRWngaOb48pIuU9olwb2OUvGmPlrN5MAjY2niDchyKJd8hZapGe6wLCN2gurFsqJZWVDOi6DzzGsLP5/RVxd7g1k+4IXn7sx5p7vwXGD6mjgs6YhSM+pOObRmhshWx0tNt//3KlJGLsF4I/kzlQmt3BUiCbFS0mfyYs4zuP2jVjeWYTTWUs0Ggt0+/34UCECWWk+ZNhRDJn2X0L8AKfz5hduxgBvkbjj3cuDTv+ZhM95Gi7VK8pZjjUEjGWZ7OSIoFlUPsqEg7Y+60A+FUV/cE5mG8ZbfxQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 19:04:34.7765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3ece0b-5b04-4c22-4359-08df09ee319b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5185
X-Authority-Analysis: v=2.4 cv=de+wG3Xe c=1 sm=1 tr=0 ts=6a99c4c7 cx=c_pps
 a=JAdTqqN4+A8LnUbrk8iLvA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=C9Tw7BHAmLb6tzQSkUcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: WBM1_NBsrZDtsQe7eYEaaUD54Ijpp0WG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NyBTYWx0ZWRfX3x08KJKO2dzP
 8p7JCvqHUxO6niuluwq2iJjfCwk4MlyuByge99OmshQXMnvW9uFiYKzUCh7WPa23hrwy27wnRON
 7e6dgFVq3/wPFKjvt+z7E/gThuBJgoo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NyBTYWx0ZWRfX6XbdHgnEzKzK
 sAjH0RydXLgJT28GjQwgvaYG12EGitM/w9AscxkfBEslZKgbmMTukQBJr93LIdvZ5cxHZPWEUBz
 G/wJby5I5nxQBOa277P53g6sMmjJQ3/FlGPxvPAVd53u9GIA0AN6BNkubZMksmyiDlgkLp8mBYQ
 sFW8XMkH+X6oT975Ql7OdqqI5wmdXFSgvCsnFriaooi/zsS+2VtX1YghUtB4BH5i92cb9c43aHu
 DmDNafvW4CH6L8umI+FD2r8oWW+sqStoIILMTr5bfghobOIsbfXDZomOhLttCnmWLINWFpcojc1
 UbK43KapGQI0iNm6Mge8l4H1EcFSIhXV2xKnh0iipbEdUADimoABG/q2eg0bnsdlrf7OHSEr2sn
 nBQcVfcnR4FMNdOqEV/DpsvcAMglBxebiQXRrQ/24IU+uOFEBn+I8urjuqgjdHWTRVuQ1usOA+7
 AEVOQNxWzzssdjZDfVA==
X-Proofpoint-GUID: WBM1_NBsrZDtsQe7eYEaaUD54Ijpp0WG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030167

Hi Markus,
On 10:28-20260903, Markus Schneider-Pargmann wrote:
> Hi Kendall,
> 
> On Wed Sep 2, 2026 at 11:03 PM CEST, Kendall Willis wrote:
> > Add "ti,am62-m_can" to the list of compatible strings for the M_CAN
> > controller binding. This compatible identifies TI AM62 SoCs which
> > support out-of-band wakeup capability.
> >
> > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > ---
> >  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > index 2c9d37975bedd652b3060ab11ba75c37565edaad..89e5a44453372c57506e9cf3a009b55a70cc4446 100644
> > --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > @@ -16,7 +16,9 @@ allOf:
> >  
> >  properties:
> >    compatible:
> > -    const: bosch,m_can
> > +    enum:
> > +      - bosch,m_can
> > +      - ti,am62-m_can
> 
> I think you should use oneOf here to allow the use of
> 
>   compatible = "ti,am62-m_can", "bosch,m_can";
> 

Oops, yes this was a mistake on my part. Will fix in the next version.

Best,
Kendall
