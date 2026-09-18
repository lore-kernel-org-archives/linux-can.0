Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC0551EDFD;
	Fri, 18 Sep 2026 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789759348; cv=fail; b=JI/LQq5BQ03hnk5kHkEQEBX1K7InPw32rV1QK5yJS/UaMdTSU6U7NPeIdQczfrBKjPOrNyweYEt/XIu+OBA/jGKEqlw5ReKkyJ7HLAFh73/wP8MWcPJZyB/YvO8bwXfL+yVsIFw+VxjOWMxl2mQxhL7mIWCK60DhvFLQyJfDddw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789759348; c=relaxed/simple;
	bh=9lD/K7MvKttnIcviSqsGz9FVu6HqqhBE9bAPFgWtuiA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkoLfopt7wpiYepF+pvH/oqcJv2R7P0SmP5IvEmrNaoLEfjKG3om9r7Eck1dmyBlhIntFqbnu1kljRbjPyCIiSb1FaHKEk5e4D8RPsWqc+AYEbYlzTQlFHV8SwPgEPumhBJYfhioTIDgcwnxN+M8IKpA4EzQ0EY0EnDlH1b2X5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=aZ973Y7O; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W/lPfDjI; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="aZ973Y7O";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W/lPfDjI"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68IGoTPv2034883;
	Fri, 18 Sep 2026 14:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=CH0mj4KGHq0Udo2
	AUND2x/hEVe540q8qs4AtgT9cvt0=; b=aZ973Y7OaeJz6yY88p/CUzmEmgsVdlh
	vzO20YYYVDYfwbcyIe/Yt80336dTxE5eLpRAqJjMyWd5r59lOc32m+s9bT8Rjw2j
	lGY3ml1ua+ybw2waeT4K8zFRV84a3JZI33EwUvqlKK3r/TB/py5r0TRaGRQTDKFg
	IJJuTs+CdfuzRq86AnLzLr9sqBEdmFi0Pes5Whql+g538Tvaqess2ApObnGgml0z
	XnlP9LQChYikfegfN0Ytjw6inYCWZ/tTRPDaGkDVa7ULTbt1Zy3iSXbWK79jwJZM
	3mXvFp6xY7k4KUS+RhJeggjKbj7mgrAhWyWKGKhtGFHVHK5rOtp+71Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gs2ux36wf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 14:22:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEXxDk6vz31TPYdldmwVg78AW6d6gXWz77/urfTngWKe7RW/a3LeNIoBI/pBWkHd+95jRSEb1BNWxVIpFQYeyHCUX1qIiU3oOupZTnBvGzr9JRFqOXegnjNOpd6ihOEQqagu5POqiAM5JgTk1Bet8WrPJOub10o3QEAQfGZ9wu5v10yxYm/zc6CqstpDIp+bCQHLFU3yk8KVU/I/Y5swEToSUm3wy2o015wIFU1mL8RzTAUxueDX2ICRuVe3+oyquEprDSb368R+fRVUndlWipg3JJaAW+n/MKSAUosYCesBVAb7DW8FwDLpku/y/eiJU4eRFMrKgQCLwK28KBu2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH0mj4KGHq0Udo2AUND2x/hEVe540q8qs4AtgT9cvt0=;
 b=AOf7cnniz+FPle/PCKZMWwBfjI5jNFkKQJnEcXBoFFiTrAV4EuzL2GdyBw2ykio+OSvHSDpC+VHuGLzNkuxWok03TcNM8WLen13nWK0zJzLgIj7hRDBRDe7B6S9vNgRkHme+pEvlheIVuV7mXZmBfkeDbxGuJGgrv4MdAM31SKJYQ9V+qQgqwAmJVGPfXyeHfprWHYIVCmiIyz6oPq85KVsZy9c5UasMycW/QEo6KrXBMp3rja7R696ISf6HVdY5H+CPv+m+Bti4RtqqS2Xp91yp4v+Om9r6swCb3GBJscZGtLTJTf6NS366HlQaGHX2lY12nfWZ8XWiJ+G0mM+a6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH0mj4KGHq0Udo2AUND2x/hEVe540q8qs4AtgT9cvt0=;
 b=W/lPfDjI0homZXM4dHUbMYn8Sqk28AgZbobKkKePXW6dRJ9WYEaPRVD3fNVxscmr/yLxbZyN4C30h6h8T8DEJkm0GPAATkEpG2oSL8Pt4Gur6XANA+4w6IdsgwjwpAjf/4pD2NGREaLcDKtX31dEFKqeHY9ncdLGpskjSb93elQ=
Received: from BN9PR03CA0586.namprd03.prod.outlook.com (2603:10b6:408:10d::21)
 by PH7PR10MB6203.namprd10.prod.outlook.com (2603:10b6:510:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 19:22:00 +0000
Received: from BN6PEPF00000074.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::e) by BN9PR03CA0586.outlook.office365.com
 (2603:10b6:408:10d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 19:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN6PEPF00000074.mail.protection.outlook.com (10.167.248.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 19:21:58 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 14:21:25 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 14:21:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 18 Sep 2026 14:21:25 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68IJLPCI2279374;
	Fri, 18 Sep 2026 14:21:25 -0500
Date: Fri, 18 Sep 2026 14:21:25 -0500
From: Kendall Willis <k-willis@ti.com>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol
	<mailhol@kernel.org>, Sean Nyekjaer <sean@geanix.com>,
        <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: m_can: Fix suspend deinit() error path
Message-ID: <20260918192125.yjbqjwivucj5wyuf@uda0506412>
References: <20260918-v7-3-topic-mcan-suspend-fix-fix-v1-1-e24fa70c754e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260918-v7-3-topic-mcan-suspend-fix-fix-v1-1-e24fa70c754e@baylibre.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000074:EE_|PH7PR10MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2bf785-ac4f-4001-dd9c-08df15ba1bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|6133799003|5023799004|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	gatmdwWhfohTlzW4ApmjI81JtIl0cCG8i6WSDdvG8OqWv/si6qVJV5GMRtZiEbBfJojSwKuH2U8iofhttvpl2QGP1jHhyXbcddV3akEwlnqvR+yEyQEM+C1M8tx1V/MvX1cNi49nwziYORvRVjGSMduM1omFkdP23WAvQzeF44kbsKH5Fcd9j0A14A7uEdBeQ24Wc5FW3dFBWgtGIGjz7db4FGB+9n7tlplP5+JH7Y9sZ7o1bNAIr6sEKU+SB8DsLKjQXrAFG4ZC3TjZxwL0Z/w6IIHbLAuF8Yuf882LdJb4a71cmFn5Ei+AuQIOpDnOFYzPHPKAX1Xt9H1rVBj26bvZTQVKKOJPog0z89MsXW+GRf7YWM1SlTFjz+mtTsBCp2MpCOHDRxl+930F9O9E7tu/M2rCQMvA/7gOc1yIdAPtLMQCXkYI1Br18Bf5lAOxYb21axBdo/rQ82zth0RL2rKY9TdNSCCMkYxTFGT5CTjuDv+Mhu+vO0AD9qHbzenqTxnAGluSrQk/Y++G+iwg2wTOw0v0yxkOixLx0PHcAzeCy9CtnIqeG5TaeypP/CtxicBCqgdEiBToKNSQPe9JK6fRhPVvbx9991qemyS2H9ExP88YwzuAdrzNhAWpncdhYbnCLwDodJGKlQKgVR9Gs4rLQBajORd38Clg0uua86RDkPXnmeble0vyBWPv05jnmEQEFby+XuXJlMqRTaWh+g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(6133799003)(5023799004)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pSflaNGP7KlosOSV9BE/4XGRy1IWA+4zr77/pWC4+fpEpkSx+JpvTLd4K5Jgv/zDfxHhdeVUEH6DyuHGg4Mr2DQttW5rPdIt+8qE7k11lH/Hwbuf2jCiz8Y9gupCly6km1CNoJwR6DjZPAbsHkLDUAg/n33+2t+GJeMVFlOvO8vwMbzigtu7lM7kGm+lPNtnn1Q2WME0EKtOq7IxnMNhLfSFzTnNaiVbpbDoRcYPe0S88tsXVMUAdsyKe2EmUUrQd61VaiYeTJeNTdwK6LNxr3PZ8sXqcuphVDbO9SCI1lwcNzR6VCS4jS/DGL93Wv/JVl0IWQ2rE4GHZaFjB96hTVr0lt86XHonOvIpkBmRbDlCMzN0OOPep1peVSjwegQGftUoGpi78eOzqQv8PE4x9Pv2zqcQq7b4dYZDNVHKBhrrD2dgTh1pjvkQurEsiU6P
X-Exchange-RoutingPolicyChecked:
	RxTrgl4QjjLgiKj4RzNz446DEx8+mgtf5NUIbdWDfV716NC2fKIEfUEpY2lmrhxupOf+dKzT+OEyrEwCn1tlI9gQaxa21e9jotbbUpivf7JQUx0kYfEYQTfWjMlHzVlA4NnyEtBhLRuCPa5U7/Q1rOLEizD1QIO8abNiRZXVtA66AG+YQhfNNIcGvPcSMvhZJvntI84ACVGaqXfs9f2fzKy3BmZ5ql39kghXizvAqSxSD1pnJMSO6ie7TnnaU+bJBEbV1JIlt9i1AI8gZhpjojFaiEyhfOxPTrjfVpHDOfELcKGUW4XphD2+Ec6v5EVZzLxd6++X14CmHLamypCxMQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 19:21:58.6548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2bf785-ac4f-4001-dd9c-08df15ba1bff
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000074.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6203
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI3OSBTYWx0ZWRfX00Ufl7YYLOQ3
 YO9zJP7Ec1qLTVw1na4mn4MYt4/1NLV29eGY0R2ELNgKQ7EUbE61HvfMqs+WNh8V5Lqq0pTQARl
 w23OswpghnXWarC4MoZTMv99a4xj19QIHFfPJW5wjboCqcyd9ZAzJ8cQBnmHxM66FmXv3+T3h0l
 FOflIopeyekYzlnseR7RghLSrkbp5hwxUsk9G6FHFyE5tYP13l3kzwE57RrcAqb1pjmLjCymdpp
 qkeZxwAvVD20zY8XwK4/hDJ+1FnR7a2+MdvNCE+pk+SCi7G8Kv3AtfD3P0RhKnCrb295zh2an8h
 Nx8jhinc2Ir2V/bE7d92XziTE7v95os0ZaHxb/vHbfT88J61PSbl11HfltZlWJCQPb8CT766ad/
 swX7PB9qwvWfQlQ9gk5HcdzKxvL99sdtd7gt9pULuqAFh82tzYBS0v5tjRPTDDMX1hn1GuOyKX7
 dKy0QkxoSC1V+WTddRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI3OSBTYWx0ZWRfX8/i5EiskPzBX
 mQOUKO2uTS9Q+sH1PRU5hL9VfSTNM2GDukpwSWs/SjYL6lWZeIAZuWQi5/9uO2qQKzwyfJORP4T
 vdvg0NLLFIKKCKcJdT8+X54WVj+2YDY=
X-Proofpoint-ORIG-GUID: 3oCpCUfFNbG5vcJ7w83snATP5w61LMtI
X-Proofpoint-GUID: 3oCpCUfFNbG5vcJ7w83snATP5w61LMtI
X-Authority-Analysis: v=2.4 cv=adH0Dhot c=1 sm=1 tr=0 ts=6aad8f5b cx=c_pps
 a=IGlUesXJXvI2YQKUC5af4g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=IpJZQVW2AAAA:8
 a=sozttTNsAAAA:8 a=mG2dZ4WBFOi0VBxQVV0A:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1011 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180279

On 10:29-20260918, Markus Schneider-Pargmann (TI) wrote:
> When suspending mcan, deinit is called and its return value is returned,
> but nothing is restored. Returning an error in the suspend function will
> stop suspending and resume the system immediately. So on error the
> device should be restored to its previous state.
> 
> Fixes: ad1ddb3bfb0c ("can: m_can: call deinit/init callback when going into suspend/resume")
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> ---

Separate from this commit, but does cdev->can.state in
m_can_class_resume need to be moved to outside the cdev->pm_wake_source
conditional since in the suspend path it is only in the
netif_running(ndev) conditional?

Reviewed-by: Kendall Willis <k-willis@ti.com>

>  drivers/net/can/m_can/m_can.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 16f80607e150..91a0c5eca260 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2612,8 +2612,14 @@ int m_can_class_suspend(struct device *dev)
>  			hrtimer_cancel(&cdev->hrtimer);
>  			m_can_write(cdev, M_CAN_IE, IR_RF0N);
>  
> -			if (cdev->ops->deinit)
> +			if (cdev->ops->deinit) {
>  				ret = cdev->ops->deinit(cdev);
> +				if (ret) {
> +					netdev_err(cdev->net, "failed to deinit device while suspending %pe\n",
> +						   ERR_PTR(ret));
> +					goto err_restore_interface;
> +				}
> +			}
>  		} else {
>  			m_can_stop(ndev);
>  		}
> @@ -2625,6 +2631,21 @@ int m_can_class_suspend(struct device *dev)
>  	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
>  		pinctrl_pm_select_sleep_state(dev);
>  
> +	return 0;
> +
> +err_restore_interface:
> +	if (netif_running(ndev)) {
> +		if (cdev->pm_wake_source) {
> +			/* Enable interrupts that trigger immediately if
> +			 * something is there and keep the hrtimer off
> +			 */
> +			cdev->active_interrupts |= IR_RF0N | IR_TEFN;
> +			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
> +		}
> +		netif_device_attach(ndev);
> +		netif_start_queue(ndev);
> +	}
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(m_can_class_suspend);
> 
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260914-v7-3-topic-mcan-suspend-fix-fix-b943929d8fef
> 
> Best regards,
> --  
> Markus Schneider-Pargmann <msp@baylibre.com>
> 
