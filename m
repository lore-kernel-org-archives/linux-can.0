Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A8044212E;
	Mon,  7 Sep 2026 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768949; cv=fail; b=Rq7Zi50g8QircT3hmpPobTxPInRKyRj4j/9zOf5djg0EoL++Ft2+DFQf7qGpuB4bazjVsfyf9ki60TUvfbVThzDJEXkGGQsFYNiajiWoT6jcmtcCxlo0VWSogDpYbnkvOAbz4429GbtMeveuF0nfC62U49Qsc3BGVVZr9Bme3mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768949; c=relaxed/simple;
	bh=0lNMtSqIso2fp2AyclVKIE95G2Ei+VC59Q/R4Q1sfZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tcxmlpq8Qbe5iDdA5lSt+sbOjrc/Pw3PnFoZr0XcyQ7+Ya+aJ5chXTFyHOBSC6FAicXMh1FJgcLYn+Y77bzB1m7XVpV5VCPTClGWKW9jKtBm5Xn1A2OYAdhobeTrfG0aL5D+XF2xRnKO/m7WhqkaKbFmQNqPKsKnFem8tMjnnvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XAfnuEqp; arc=fail smtp.client-ip=52.101.84.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XAfnuEqp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQv0oOZeMFCDnE5XDlrUDRjaplpG+JXM2a9DCzT9Gqqsgd9UBAmJs/vLHoUN+qiDYIQqXhAL1NNZK3n39Og34UoCja3SCYGOzVc5IHzHUbeDXoaUOSQ73hwF+IH3iwgLFuUdSEJbDEBaBgFmOy9K7bTd4rRT5b35y2BFw3C3ERYH/5CrEpIwXej8nLyi1EWCIlsxNg0zxPYw/GMhAXC+b7DsgnGLQBG6KyAvFdogRV3qMYUr8I9ux2AHeXI+k22CvP03P8Gnc+XKCtw/lkXwj3+i/jNx333R/WTPoUR/VrdHt0JiTo2sb0AlPir0gDYIfxnTA2+YsAKFjUk2uR99hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66NirmErgYN4Jex0VD/LhDbDWC97x8tuT1RPf2KnrAc=;
 b=IdcGYOxhYhbLQ+d0uDK5EQ4DOEoUgc+OhvpMTAwuMJCKuWPXwczq044qLBDGcmDhmYmLoUCurvjmLsQ7pdCzcI6Xjj4RjcETPSm1jV+IlOOgZ/qSLD6onUnTV3X5aODejqtpPq9kA8usFzBTvSNaxvWwS9tnf9oqxRBoT2Jp9e2QvoLURSfXIMnH/yDLT8ZOAlgM7rO5ANFx5yMx5h2U867fijDoSsNlCTBYkWAecvXNoPohsLxPt6/dw3FnrlZPqGzQmD/XndrTqjgagzDYzAlqr2m7CD6uAqnaribrx4dyxH4pIHmIfIOh9GG76qRdq12NDgMhO6+ijFpQNDFwtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66NirmErgYN4Jex0VD/LhDbDWC97x8tuT1RPf2KnrAc=;
 b=XAfnuEqpqrpBWjpvEmmtmRTUPx7PBJ/Gp5hNV54Cfl8x5DQCAEGGvqC8ECFPyqkBifo13xh2Y2tscl7Vm51ywPlFcHpm7IIywGY9c37U2hIbyY69TwezT62nGi5hlFps5wU6vkZR05OPIR9RBTkjjDoEOEPpZqIluxsVWJpFD1VZ9zt6lQqfLcSSQsKhf9Rva/D5r+5W/y0NCse8A9qq/oS9qIEBrBWPU0bCJlx2aqjGIW82jD0vQUpRXZJLsSsktdvB5IdRNOaHXYYeQs44OnFdyi8k9mY4At4VO6XZPHzCsgwSfaTim2xR3BfIu0ioyNdkZX+9G82mC3sLqMpl4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by PAXPR04MB9229.eurprd04.prod.outlook.com
 (2603:10a6:102:2bd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 7 Sep
 2026 08:15:43 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%7]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 08:15:43 +0000
Date: Mon, 7 Sep 2026 16:19:54 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
	linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, s32@nxp.com
Subject: Re: [PATCH v4 1/3] can: rx-offload: make skb_irq_queue per-CPU
Message-ID: <20260907081954.h73o7vzgr3obpqyr@shlinux89>
References: <20260901114848.500591-1-ciprianmarian.costea@oss.nxp.com>
 <20260901114848.500591-2-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901114848.500591-2-ciprianmarian.costea@oss.nxp.com>
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|PAXPR04MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8ef551-6688-42d2-b168-08df0cb835d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|19092799006|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1Hf9MD1Yh5pY62fYGaSsmQGy14xf/BbUpunfPh3xzrkfTal1ofPJI3Ek9m9bfLoDNykJAdFGr+n3jmvBQr1spwPiV+x0FXWU+0CzFYQTDqp2qtuIAlaRo60V8DRPordrIsNgzvfqatwDUNkOnvHx5Dbja0dLplQP+Qw7z1an8QZTYyM11y7i6C85trd4i3eDpeizGvxjpegTrysWSDXAJygtiSpBopswSRcnKFst85Bp71Mei1TdyAi0/JXXmbxD843o9vYFBX9FU99kHNLFMO7kFt7MYzfUEsaI0gv9YOSr/Rwyf1oVZ/KJB88PSTbmRW45PI4u1gJ8jEmkcWB3pkX4AdXFlbjw90K6v/NjvK5UiI/m370VKKU3e4e3/tgvkFfI+bnEn5/McprSkfk6fDbEG0kwqSO8h2lhbdBKrJ9N1hUiaFRX7ZFI0uzRjLs/K7MvLbZl0ku7dAljFmIKNScGLqANp76V0qeBBXdDPG3CFONfrPBTamROUOQftX1LxmuedsCf2yBNPebOIO1/IyXlJTqEOg60OanaGbLvcAbfstXKP9HdLJ2o+KWXfAmq8QxWgk9OushR0UW/KUib7ZhRTABeYqU0t/10ZbU4D75aYxAcKDlSm4rENLl79WAGO8lkJLCxXXkSaY4Ln3XQHUJn2n7TdGpxlWPzzklo7Tc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(19092799006)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RWUMxA04RWjiXus+I4HLOGU9D8nDq/1yrfGbOb5HFiNIscCZyjoDb03qPBVZ?=
 =?us-ascii?Q?m5oZLOxYUtI6AgWRD61730y6LG0vHIJR3Bu/m9t6ZQu3VQXcjv2pYUnMPfeC?=
 =?us-ascii?Q?MaT5hp/bAZ2aXGfsYbBRbJHn1QsLGx18R9rAaQt6q+e4obgkvh3/RXO7BJWT?=
 =?us-ascii?Q?lxo/P/YhIpu4T5yLBp7ljRCHMXJrPtDKjxv/v3+HwcC7MKjhWrpS65fHRdeB?=
 =?us-ascii?Q?KrHwH3aiML1PVDI2kAXi1Qz8oIgxVCCLQJTbQgY7OrrcKgUVE9EdZ2TI3ejQ?=
 =?us-ascii?Q?058+18aAqQUhgY4Dt4s83KKEUe2XSWjsM5/DX5bj6dhH2ng0Y/m8uRzAqbqO?=
 =?us-ascii?Q?rm/YQsMOFhnazNqDQZTqxclA/qYSlPNoDBVOjqo1a+NvdSxsWriFTLHd05+2?=
 =?us-ascii?Q?9lEwFqXCCsaVhAM3rAgjImKtTU76aggpDhFDNKWKqi5r0U2jQZEfbgp1RIRw?=
 =?us-ascii?Q?hF6kUm+m3zZJxDx7wOXDtwjJEkS13AbxDP5DdzNNf9JZdLooMi8GCW/w3wuj?=
 =?us-ascii?Q?1tiCzGmZ/bvHXtq/HUM3TpQ0+VJvTCteryNBvwLRY3C7IbDdBMFKIuWghOic?=
 =?us-ascii?Q?T/ilLlnhx9jkSAXRmXYlUmUhysZUU0TdgU6znL3WLoglIFcO6Re8cmjEMmOl?=
 =?us-ascii?Q?H6QqXZF7gHkDCBxPsxJNcxO4EtthLuq5rXSdY6pHT25+79fE0DQsH1ZP4z9y?=
 =?us-ascii?Q?VMUnTAH08tEtcaN04bHJF+WtdK1XBAxea825snr0wCvRmaQravB+0r8d7Fmn?=
 =?us-ascii?Q?kFSFYHM3B+t1rpDqh8Szs6p+Mr7oCZteGjcPjk9GaPFkhp7d1LoKVEjwtA1H?=
 =?us-ascii?Q?gtSoySWFuakLd+8MOr+nUs/qtCxjXYUP6c8R0sdYlDVHdrVhz15j71tuYSdz?=
 =?us-ascii?Q?lBsvv1AQLd7xlqkutc87FKSSTmyl0bnosE5+6oZaMn3atERWTySywjYD0Rqd?=
 =?us-ascii?Q?ni0ByOc3uYB+au/VNSly/izGBgmAFUHvWEI3Ubv0OzcubHeAjmGkqldbXefe?=
 =?us-ascii?Q?u0HCMSiD2dCRSWfY1FieIScR2Nm57YXpcLWOV3+mhuPykmIKqQXsodTe7wPa?=
 =?us-ascii?Q?WCdFEJWqMZIrhjf+dk+OjimHckZbEeM+PTWzQro6D8ecoRKQnT4rzcvB4O2d?=
 =?us-ascii?Q?TGUbhL4aPdMHHny1Bdc4BVYspu/PdKBB3k+cmIkatpA6Wp1UOaX95YmgsV0H?=
 =?us-ascii?Q?Ypy8xk7BGkWucAZd5KZsaGM6/Uu6qeHY+ZGdNi4IN1Nl01BLaVrLGrFrRqhj?=
 =?us-ascii?Q?vvDP4DqisGIPWVwDgRkds2dHQ3lK+2uncC1elu8c7BDDPQVyZ9vdpvl1v9Zw?=
 =?us-ascii?Q?URNYSSpzwDKvUhFc9Puvpu0HjI4mHlfF03mn2WNnH8uR5hKoZ7dsmJUxUaCw?=
 =?us-ascii?Q?cbSR+V6E/Lm0duL9QIy9DQGNJh/HBJhpzQrlXs4G2aY5ZAUv4dFO3B8cG82z?=
 =?us-ascii?Q?PEWO0Gup6btG0FTeUY5tpvLyXvzg/tqysOFm07EdkzU9YHX/JJ6ugrsBTGxK?=
 =?us-ascii?Q?6MFSzgZ7zjyqanIB6GhBGj3UkyTHRJ26hwOzWB3ImUB3TET5WKgyr08p77Kc?=
 =?us-ascii?Q?jg3CLznBu3tIig81joiIFZzEP3sf0IRBEeDssQjjZuySu72sNb3u4RD0OHYU?=
 =?us-ascii?Q?o8ZWJVbubDE3wWeqW3ka7NQIP33LxltBTKx2NJiqPjQmyTZfL0UY9J9YRQXo?=
 =?us-ascii?Q?ERTOYIQAF9WDG6N/Y+VzP8Cw7EmgXPzSCqUM8uzgm5UVE1q7HjofyK3Jlaj1?=
 =?us-ascii?Q?7PrZfyRG0VPA0mSf7lcpQdW9M5jNOb8d+ndIb2fpR9UolBnPi8Ru?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8ef551-6688-42d2-b168-08df0cb835d9
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:15:43.0303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22KmRoT34kqiHPhInuETiBXFCvSbjawTAGyTV4FxT8Va29EvKLsg+iowEg1xq6GqP35OYHiNS9vPVPN2pEWXlkfpbUoT1dgodRzimUVcM+Bs5rX2I6lpgtXqgSpyUpkT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

On Tue, Sep 01, 2026 at 01:48:46PM +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> skb_irq_queue is filled by the IRQ handlers using the lockless
> __skb_queue_add_sort() / __skb_queue_tail() helpers and later spliced
> into skb_queue under skb_queue.lock by can_rx_offload_irq_finish() and
> can_rx_offload_threaded_irq_finish().
> 
> This is only safe while a single context fills skb_irq_queue. FlexCAN
> on NXP S32G2 (FLEXCAN_QUIRK_SECONDARY_MB_IRQ) uses two mailbox IRQ
> lines, one for MB0-7 and one for MB8-63; MCF5441X similarly splits its
> mailbox interrupt. When these lines are affined to different CPUs both
> handlers can run at the same time and enqueue into the same sk_buff_head
> concurrently, corrupting its list.
> 
> Allocate skb_irq_queue per-CPU so the handlers no longer share a list,
> keeping the enqueue path lock-free. Access the per-CPU queue via
> get_cpu_ptr()/put_cpu_ptr() in the enqueue helpers: this disables
> preemption around the lockless __skb_queue_*() operation.
> 
> can_rx_offload_irq_finish() runs in the same context as its enqueues and
> splices this_cpu_ptr(). can_rx_offload_threaded_irq_finish() may have
> been migrated after its enqueues, so it splices every possible CPU's
> queue; this is safe because each per-CPU queue has a single producer and
> that producer runs with preemption disabled, so it cannot race the
> splice.
> 
> Cross-line frames are now sorted by timestamp only within a CPU's queue
> and appended across CPUs on splice; each skb keeps its own timestamp.
> 
> Fixes: c757096ea103 ("can: rx-offload: add skb queue for use during ISR")
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  drivers/net/can/dev/rx-offload.c | 83 ++++++++++++++++++++++++++------
>  include/linux/can/rx-offload.h   |  2 +-
>  2 files changed, 70 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
> index 46e7b6db4a1e..649bfda08b65 100644
> --- a/drivers/net/can/dev/rx-offload.c
> +++ b/drivers/net/can/dev/rx-offload.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/can/dev.h>
>  #include <linux/can/rx-offload.h>
> +#include <linux/percpu.h>
>  
>  struct can_rx_offload_cb {
>  	u32 timestamp;
> @@ -175,9 +176,18 @@ can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
>  int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
>  					 u64 pending)
>  {
> +	struct sk_buff_head *irq_queue;
>  	unsigned int i;
>  	int received = 0;
>  
> +	/*
> +	 * get_cpu_ptr() disables preemption so that the lockless
> +	 * __skb_queue_*() below operate on the current CPU's queue without
> +	 * racing a migration. This also keeps this_cpu_ptr() valid when a
> +	 * driver enqueues from a preemptible (threaded IRQ) context.
> +	 */
> +	irq_queue = get_cpu_ptr(offload->skb_irq_queue);
> +
>  	for (i = offload->mb_first;
>  	     can_rx_offload_le(offload, i, offload->mb_last);
>  	     can_rx_offload_inc(offload, &i)) {
> @@ -190,20 +200,25 @@ int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
>  		if (IS_ERR_OR_NULL(skb))
>  			continue;
>  
> -		__skb_queue_add_sort(&offload->skb_irq_queue, skb,
> +		__skb_queue_add_sort(irq_queue, skb,
>  				     can_rx_offload_compare);
>  		received++;
>  	}
>  
> +	put_cpu_ptr(offload->skb_irq_queue);
> +
>  	return received;
>  }
>  EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_timestamp);
>  
>  int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
>  {
> +	struct sk_buff_head *irq_queue;
>  	struct sk_buff *skb;
>  	int received = 0;
>  
> +	irq_queue = get_cpu_ptr(offload->skb_irq_queue);
> +
>  	while (1) {
>  		skb = can_rx_offload_offload_one(offload, 0);
>  		if (IS_ERR(skb))
> @@ -211,10 +226,12 @@ int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
>  		if (!skb)
>  			break;
>  
> -		__skb_queue_tail(&offload->skb_irq_queue, skb);
> +		__skb_queue_tail(irq_queue, skb);
>  		received++;
>  	}
>  
> +	put_cpu_ptr(offload->skb_irq_queue);
> +
>  	return received;
>  }
>  EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_fifo);
> @@ -222,6 +239,7 @@ EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_fifo);
>  int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
>  				   struct sk_buff *skb, u32 timestamp)
>  {
> +	struct sk_buff_head *irq_queue;
>  	struct can_rx_offload_cb *cb;
>  
>  	if (skb_queue_len(&offload->skb_queue) >
> @@ -233,8 +251,9 @@ int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
>  	cb = can_rx_offload_get_cb(skb);
>  	cb->timestamp = timestamp;
>  
> -	__skb_queue_add_sort(&offload->skb_irq_queue, skb,
> -			     can_rx_offload_compare);
> +	irq_queue = get_cpu_ptr(offload->skb_irq_queue);
> +	__skb_queue_add_sort(irq_queue, skb, can_rx_offload_compare);
> +	put_cpu_ptr(offload->skb_irq_queue);
>  
>  	return 0;
>  }
> @@ -268,13 +287,17 @@ EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_timestamp);
>  int can_rx_offload_queue_tail(struct can_rx_offload *offload,
>  			      struct sk_buff *skb)
>  {
> +	struct sk_buff_head *irq_queue;
> +
>  	if (skb_queue_len(&offload->skb_queue) >
>  	    offload->skb_queue_len_max) {
>  		dev_kfree_skb_any(skb);
>  		return -ENOBUFS;
>  	}
>  
> -	__skb_queue_tail(&offload->skb_irq_queue, skb);
> +	irq_queue = get_cpu_ptr(offload->skb_irq_queue);
> +	__skb_queue_tail(irq_queue, skb);
> +	put_cpu_ptr(offload->skb_irq_queue);
>  
>  	return 0;
>  }
> @@ -307,14 +330,15 @@ EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_tail);
>  
>  void can_rx_offload_irq_finish(struct can_rx_offload *offload)
>  {
> +	struct sk_buff_head *irq_queue = this_cpu_ptr(offload->skb_irq_queue);
>  	unsigned long flags;
>  	int queue_len;
>  
> -	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
> +	if (skb_queue_empty_lockless(irq_queue))
>  		return;
>  
>  	spin_lock_irqsave(&offload->skb_queue.lock, flags);
> -	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue);
> +	skb_queue_splice_tail_init(irq_queue, &offload->skb_queue);
>  	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
>  
>  	queue_len = skb_queue_len(&offload->skb_queue);
> @@ -330,15 +354,29 @@ void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
>  {
>  	unsigned long flags;
>  	int queue_len;
> -
> -	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
> -		return;
> -
> +	int cpu;
> +
> +	/*
> +	 * Splice every CPU's queue: unlike the non-threaded
> +	 * can_rx_offload_irq_finish(), a threaded handler may be migrated
> +	 * between the enqueue and this splice, so the frames may sit on a
> +	 * different CPU's queue. This is only safe because a given per-CPU
> +	 * queue has a single producer (the enqueue on that CPU is
> +	 * non-preemptible), so no producer can race this splice.
> +	 */
>  	spin_lock_irqsave(&offload->skb_queue.lock, flags);
> -	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue);
> +	for_each_possible_cpu(cpu) {
> +		struct sk_buff_head *irq_queue;
> +
> +		irq_queue = per_cpu_ptr(offload->skb_irq_queue, cpu);
> +		skb_queue_splice_tail_init(irq_queue, &offload->skb_queue);
> +	}
>  	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
>  
Hi Ciprian,
The fix looks correct to me. I checked all rx-offload users in
drivers/net/can/ and the change is safe for every current driver.

One suggestion:
the cross-CPU splice in can_rx_offload_threaded_irq_finish() is safe
only as long as there is a single threaded handler context per offload
instance, so each per-CPU queue has exactly one producer.
This isn't new (the old shared skb_irq_queue relied on the same
"single context fills the queue" assumption), and for the current
threaded users it's actually enforced by genirq:
they all use request_threaded_irq(irq, NULL, handler, ...),
which mandates IRQF_ONESHOT, so the handler can't re-enter.

Only the threaded finish path cares about this, and all three such
drivers request the IRQ with IRQF_ONESHOT:
  - m_can (peripheral)
  - mcp251xfd
  - nct6694_canfd
They all use the manual enqueue path (queue_timestamp/queue_tail), not
irq_offload_*(). Everyone else uses the non-threaded irq_finish()
(this_cpu_ptr only) and is safe by construction.

Could you spell out this assumption in the comment above the
for_each_possible_cpu() loop? e.g.:

This assumes a single threaded handler context per offload instance
(IRQ requested with IRQF_ONESHOT / handler non-reentrant), so each
per-CPU queue has exactly one producer. If that changes, this
cross-CPU splice of lockless queues would need additional locking.

Minor, non-blocking: get_cpu_ptr() only wraps a single enqueue, so a
handler that drains several frames per IRQ (e.g. mcp251xfd) can migrate
mid-batch and split a burst across CPU queues, losing intra-batch
timestamp order after the splice. Just as the Sashiko reveiw in your
V2. I think it is harmless, and SocketCAN doesn't guarantee delivery
order anyway, so I'm fine with it as-is.
Point it out just in case other people may have comment on it.

With the comment clarification:

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Regards
Haibo Chen

>  	queue_len = skb_queue_len(&offload->skb_queue);
> +	if (!queue_len)
> +		return;
> +
>  	if (queue_len > offload->skb_queue_len_max / 8)
>  		netdev_dbg(offload->dev, "%s: queue_len=%d\n",
>  			   __func__, queue_len);
> @@ -353,13 +391,21 @@ static int can_rx_offload_init_queue(struct net_device *dev,
>  				     struct can_rx_offload *offload,
>  				     unsigned int weight)
>  {
> +	int cpu;
> +
>  	offload->dev = dev;
>  
>  	/* Limit queue len to 4x the weight (rounded to next power of two) */
>  	offload->skb_queue_len_max = 2 << fls(weight);
>  	offload->skb_queue_len_max *= 4;
>  	skb_queue_head_init(&offload->skb_queue);
> -	__skb_queue_head_init(&offload->skb_irq_queue);
> +
> +	offload->skb_irq_queue = alloc_percpu(struct sk_buff_head);
> +	if (!offload->skb_irq_queue)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu)
> +		__skb_queue_head_init(per_cpu_ptr(offload->skb_irq_queue, cpu));
>  
>  	netif_napi_add_weight(dev, &offload->napi, can_rx_offload_napi_poll,
>  			      weight);
> @@ -420,8 +466,17 @@ EXPORT_SYMBOL_GPL(can_rx_offload_enable);
>  
>  void can_rx_offload_del(struct can_rx_offload *offload)
>  {
> +	int cpu;
> +
>  	netif_napi_del(&offload->napi);
>  	skb_queue_purge(&offload->skb_queue);
> -	__skb_queue_purge(&offload->skb_irq_queue);
> +
> +	if (!offload->skb_irq_queue)
> +		return;
> +
> +	for_each_possible_cpu(cpu)
> +		__skb_queue_purge(per_cpu_ptr(offload->skb_irq_queue, cpu));
> +
> +	free_percpu(offload->skb_irq_queue);
>  }
>  EXPORT_SYMBOL_GPL(can_rx_offload_del);
> diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
> index d29bb4521947..1b9e2a8ab39a 100644
> --- a/include/linux/can/rx-offload.h
> +++ b/include/linux/can/rx-offload.h
> @@ -20,7 +20,7 @@ struct can_rx_offload {
>  					bool drop);
>  
>  	struct sk_buff_head skb_queue;
> -	struct sk_buff_head skb_irq_queue;
> +	struct sk_buff_head __percpu *skb_irq_queue;
>  	u32 skb_queue_len_max;
>  
>  	unsigned int mb_first;
> -- 
> 2.43.0
> 
