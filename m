Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FFB405C29;
	Mon, 24 Aug 2026 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566514; cv=fail; b=ej+Jf0MLVZg0zFlw3phhY9aDzI70yINFtGbAgQBRIcPVhAdPsGdEz1ZnMjDgQwf47sfcpwa3JyjZXabZ1GNZOQhkOr1nXI8lC4Mzd7sr9oBNG55YykTfktRsIt8zRQHTgQ583+sLG5d+ecTFTIAao/cnXy55wP/3lG9BTW1wevs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566514; c=relaxed/simple;
	bh=Cjq9G6ctw1kHFkQGfEQCYGxXbQi8XlcCGIdxrX/0UWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WaIi7YgrTxlyySkF7V/Ucyh0neIlXGc4tAKaV/hdPLgk/E/tGB2usxkyaFNRrNS2BOdo3kL/9aafldsmBiGvHPDfGZzDux8CqSrYbSYJpK7yDz+sJpI+wMoMO5pkAtQltKBhl2Yg7khketocheiDL0sfmvn2L4aKz36tX2O6ddU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Yr3MbBgD; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Yr3MbBgD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEHjC1LmmviA5l3FnllI9ngVkd1xi8HfVJSG7Woaom0MpR+P0Lb6yMuykQZHkx/a+nI6DFxrnhffPiylATJf06jDF6+6FebnNLsb7ffTEeB3sMLEnx0lYNRak2TF6hPd29wMbx+X4lOIgVt/6Qttvj6UlQa002cHy7aM6lFkBENojOdGp9Nz12XxF9V90kopjydgu0leYD16JzUDOgfi3zY0Qt2btFvIHwv0gOXT+MqRFnmI5PXy8sDRzwvuZZ0J7Q3yP/CbV9xu8DJf0HltPfeqZrzuxDUevFeVpu6YFGxLhXDbG+ACiX8XCQ0I3YczR1Yz/2xGHvlsnC1i41u9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSOgq6sdNsUSiZ1U6IdDnAffRPqK4AZEUM3+w+x20Pk=;
 b=aOAjv4BIyxFs3t2V5Ahg0gqS7wYddiCGaMln/GSRTDP1iLmMP+xGd2dtYeJqDGImj6HWEuKVQAw1nOimoUYIWNMLWQOK3+2ekmVCx1F9Dj6Q3IJjcXrp3kBTXSTve5h2KsBn5sybJgG4T0VMtD8PMTpYmB6mNht+DOrOmdPdS1oBPeOaJAVrpZ6icIZDIxpR28MaOg38u0WQTWdTLhJrg43oAqcjk19HXnur39W7n/eXO7++VIYsd1s33/S01cJx+2ngXYcdQKLoDy7Cr5a5DArFdeGIWsGHgWa30aLyXMK3u9s1Vz5XOWTtAT69Nr+XlITWOSl14bgDvxpEFzm1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSOgq6sdNsUSiZ1U6IdDnAffRPqK4AZEUM3+w+x20Pk=;
 b=Yr3MbBgDqJi87upDkmVX1aL0bFRx/LTq0v9YZApcYSaipK+XwGRDq5QmehFPaCc/kMHM0gkFYcPh423te4cVj/hlmA1DkCSsbNqLuPd3Nh+H44jwGOKdBX1pDKd6BAyISd85B75ehXzvilbKxxLdd2FhgAZS0qN8YKmkudDq9vlOC0bnVPSyR5ihiKtLipAH7ugCvVP0LE062GEEqX9L5OYllJZUtCC5Z/J38iqnXmH6L1yUVrydEhHA3T50eeEDVvBlm1BZYVmBX1YuiDQuNmg1++BRLZAVpEUrhKog7BZGx2y6P5uOS6vxpw1YJj/Xf32FaHqwh/aa2CXj3M7y4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by AM8PR04MB7362.eurprd04.prod.outlook.com
 (2603:10a6:20b:1c5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 10:15:08 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:15:08 +0000
Date: Mon, 24 Aug 2026 18:19:10 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, robh@kernel.org,
	imx@lists.linux.dev, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	Frank.Li@kernel.org
Subject: Re: [PATCH v6 5/6] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
Message-ID: <20260824101910.bmh4nfcjuid3nslt@shlinux89>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-6-ciprianmarian.costea@oss.nxp.com>
 <20260713091951.047A01F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713091951.047A01F00A3A@smtp.kernel.org>
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|AM8PR04MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: b849d8c1-97a6-4b0e-b7ec-08df01c89334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p23EDNusOvTuB0wYVQ3GZlrOO9WL/Wv0CUyO/TDTER0S2tk0PoMKAo08yA3k1hdW7fbgHNeCnDNitSjcL7xPolZSiDEZgVLukU4OYLAO0W6ZKAzQ1Gtuk3rr+ilZYS36Nhg7PpS+d5pwz3qsnwzKKcyWXPRxgkjQERAYs3jU7gCV40zmooRtyB/RNyKoGjeB+aAwUiUNyRq785cmSSaFuRisROTxfuYsN+8tJ9QUShOr+cUEkWkqtzB3ErdbA0G6s2NQhFfwQWR/+lHTCt7nSJ6b4AQPGEI5i6V9W3X9ophQDtONzfyDrvMduwWBwaCRoFJtVQvuVdjOi440bUzQzCGF0V4oSe4iaWSKmFXdKe2bkYIYZhOScZ8uOttPvDR0LqBymi4BY3mFI9PATeUX/ajbDYlcDmoQ3PvpCkMyPWR+HXGzyxp7+vmeMLxZYeWxBeJpa24DcbgsarSFyLGwnPQGiYq4zcF7MttSnSpCscuqlRZbPad+/wT/hfJPm0uk0THdkRYXbonjTaze4hscZSahrPw/YrNSCrmw/Ya7TQKRK5L2PmCBrn5aQnM1FB+Cf+bwR+hxm/pbE5uGZjaqMaHZ38ctdPZd+yg2dTLOgBY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVBaQmh4WmRMMXJ3UTdtRDFyaHFUaUNBR1ZXSzQrVG52WXh3QXJwMVNYU3RF?=
 =?utf-8?B?eVNVa2kyMUprVHhLUVN2THpsaFdwdkRKUjlBK2dMNFptbU9nSmVPaUhJeEha?=
 =?utf-8?B?Sm5pekNTTzlkNXIwbkUyK1J3QVFHZDhEOXFmL0ZmaFZhanpHblBLY1lrU3pn?=
 =?utf-8?B?WmtmSXllT1MwdW5NNkdMVWpZd3lEclVRNDBpcFdQbExSY1p3UHloK1h2bGov?=
 =?utf-8?B?aysvOTFQTzF3R2VQUGdrTnA3OTROMTRlVnp2YS9nQ0ZVeFRmVWIzdmgvSWRl?=
 =?utf-8?B?YlVjOU9sQ2I2bjJJZFZSenlxVVZxc0VVT3gwSUdwTXdMeVYvNkxYLzVtcTBB?=
 =?utf-8?B?RDhHd3FzUXZSL2pJSG16RExtNDVBM3ZaZUxtc1UwMEhuR0cyei9mMXVCdkpP?=
 =?utf-8?B?c1RSRDN3eUpPYjQvWHZnck4rSkJDaGNOdkUrNFZXYzhrVzRZRHhYck5vdi9W?=
 =?utf-8?B?aDNReWNWeTZ4MVE2UUF3Q2JET2ROSXdtTTMxSG5mNzNjaERiQ3pjU1YzQlp3?=
 =?utf-8?B?bFEvWG5ENERkYlhFSjFRVjE2ZFZIYTF5SlpNY3NZMTBkTEw1dWw4SEl5Mm1P?=
 =?utf-8?B?dXV1RkM4NGk1bTI3Z0ZSbXFnd2JhSjlCbExvcUI4NWFIRGtuREtZb1JrR1RU?=
 =?utf-8?B?RW16TXZiZkpCMFZRM09BNlJJTzZDbUZkMkR4UCtqcWhCd3QxRERxei9MeEsv?=
 =?utf-8?B?d1lnUWp6U1YrVWh3NEdObVlnRUtoVTJlNEh2c2ZVRnMwSVVBSis4a3NsYTFL?=
 =?utf-8?B?L3pUbHF6UU9wb3RHMVVBYmVyaWZ3U0Q1QTRneWpIUUQrTUVOVjZIOVVKYURy?=
 =?utf-8?B?S2Vxc0RCVXhaVFpJTlZDUk4rSkhVYTZncEpnNEVGR2t4WEduVFJJaVV1WkJP?=
 =?utf-8?B?MVl1ZnVMUXdBWkdmSkVwK0krandZK2hiNzFjSVNOTU5pU0tSRFJqQzdST1lu?=
 =?utf-8?B?UmtuV1BaN1dCNXlFTXVoUUpCS216ZVpCTmc1NVh0ZkRuUmkvaExTVzVPWk5x?=
 =?utf-8?B?cTJpV29LU3h3ZzduckRDbVpVVzhaUGlsdmRNNGViZkFhaFBjdXpWQkZvZ1pv?=
 =?utf-8?B?M2RieHV6MmhDdjJyWjdRTnRQQ2JPdUZDdWdXb0JTOWJraGhldnFxTzZzaGlk?=
 =?utf-8?B?R0ZDeW1ubjJUTEtCWUNLVWdIZEMxUkxGdENYMzJlRXhzOEdGSEplUTZ3ZFN6?=
 =?utf-8?B?UFVUTlRtSitNMTNLcEN1cXEvZnNJSFB4YVdCV0FHVk9sQkFCMkJpdFFydzln?=
 =?utf-8?B?TEdJTXJRQmRhQ0E3czI4bW9PdFlLaGJRajcwcHF4U01jQnJqcFBlVTFsY1hq?=
 =?utf-8?B?VDFtalQ2cDVRTURwNXA4dmhqbVlzV2JiNVV4U2RLZUg5TFJXM2FhdUhkMzY4?=
 =?utf-8?B?TlQwT2NyZEFsdzVhRlZPWjVnUWxDbDR5eHN0ZFpqMzlWbzBPSlA3aWtJNlBT?=
 =?utf-8?B?clp0WUZVdVlaOVc5dDUvMGg2VmtCbUtHdzc5ZGJUM0ZjOVY0bG5NbGdSWS9h?=
 =?utf-8?B?Q1kvVTluQWhrQ3FrTzl0QkxlRGRCRVVnOHF5eE9jYlB2RklnOUxFRE1hYnRi?=
 =?utf-8?B?ckRvMm9sZGJjdVhLck90a0ZlYkpMYVd0ejJjTUlpeDdRdUdoZzJud3c4VVlV?=
 =?utf-8?B?NkZYb0Fyc1pyRWdiY0tOcUdoTnZHMW9aOW8rYXRrL0szM095YjRwUTBEZmhY?=
 =?utf-8?B?L1prd1RjTnB4VDkwam9qdVFYeFZMVWNpd2Y2NzB5YkZNSzdvRnVnUk1NSXVz?=
 =?utf-8?B?MDN1ZjJUSEVYUEt2elliY0x1L1BKMjI0ejhraG5ObHdHeU0zaDlxUEc0MG56?=
 =?utf-8?B?Q2xRUlZHVnozaUhpQ1VWblhZSFl6R2w0bGJQUTAvN3c2dkRFbVpnOHBzdld2?=
 =?utf-8?B?OTNrbFJYSzk5MjRSZ1ZMNnZ6SFlmMzVNOUFZMjRieHZmNmljdGlKRWwwd1Er?=
 =?utf-8?B?eVlCN0NtUFBzR0F6M1hMSExHTXY1UnRyblRiK3NFMlNwYXZ6TmxhWjU2V3Bh?=
 =?utf-8?B?K1F2SFVHUVJscmtiaVE3bkRWQXg3NWV0QlltaklpSW5PYW5PcHd3Z2ZMdGxT?=
 =?utf-8?B?TktSQWNDalQ5M3psalBnMmZEVlN1bXZ1SERtK1RucnVTQmI1ckFYQVRNOXRI?=
 =?utf-8?B?OWY0Z0lzVUQ0UU52MDQrK1ZBRm52MEgvRy9aUk1GWGt6WXoxMUw0UHlKOEJ5?=
 =?utf-8?B?YmFRS2NvdmJYR3Iwb3B6d1djeVk2VG9DRWlmdWxYUTVtM1UzeXBCTklsVGFp?=
 =?utf-8?B?eENFWSt6Nkp0bnBJTUd2dzBoMGw3amxjbUt1YXd5Y0hkTXUyaGZuMGhuTWwx?=
 =?utf-8?B?WEFrOVVHRDQrWVFrSWRuckpReTNMTlNlNldqdU5FSkh0MkVFUXkzSW0xdnFz?=
 =?utf-8?Q?H6kulymypNSjTt6QdnGgCg0ePOB7P6RHE5CK+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b849d8c1-97a6-4b0e-b7ec-08df01c89334
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:15:08.5876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxEMkSiEFmMCiR9EKUHtKWC3T6txWs0EsMB7S2M+o9ghIHWENk2At5v0mVlf+hEV1CQdoNgqSIMBw3anY1nUNaCY7cGhncYtVSA0105L7XRE6bUckE3UO8dxU65Blzfp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7362

On Mon, Jul 13, 2026 at 09:19:50AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Concurrent execution of separate hardware interrupt handlers (`dev->irq` and `priv->irq_err`) modifies the lockless `can_rx_offload` IRQ queue (`skb_irq_queue`), leading to list corruption.
> --
> 
> --- Patch [5]: [PATCH v6 5/6] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk ---
> commit 97d482f1edd202225930276cf268822cd49ea3d2
> Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
> 
> Introduce FLEXCAN_QUIRK_IRQ_BERR quirk to handle hardware integration
> where the FlexCAN module has a dedicated interrupt line for signaling
> bus errors and device state changes. This adds the flexcan_irq_esr() handler
> and is required for NXP S32N79 SoC support.
> 
> > diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> > index 8b70952f7f05d..e7e3fb41f55e7 100644
> > --- a/drivers/net/can/flexcan/flexcan-core.c
> > +++ b/drivers/net/can/flexcan/flexcan-core.c
> > @@ -1300,6 +1300,22 @@ static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
> >  	return handled;
> >  }
> >  
> > +/* Combined bus error and state change IRQ handler */
> > +static irqreturn_t flexcan_irq_esr(int irq, void *dev_id)
> > +{
> > +	struct net_device *dev = dev_id;
> > +	struct flexcan_priv *priv = netdev_priv(dev);
> > +	irqreturn_t handled;
> > +
> > +	handled = flexcan_do_state(dev);
> > +	handled |= flexcan_do_berr(dev);
> > +
> > +	if (handled)
> > +		can_rx_offload_irq_finish(&priv->offload);
> > +
> > +	return handled;
> > +}
> 
> [Severity: High]
> This is a pre-existing issue, but could this lead to list corruption
> if these separate IRQs run concurrently on different CPUs?
> 
> Since flexcan_irq_esr() and flexcan_irq_mb() are registered as separate
> interrupts, they might fire at the same time. If flexcan_irq_esr()
> processes a bus error and flexcan_irq_mb() processes a mailbox interrupt,
> they both end up modifying the lockless offload->skb_irq_queue.
> 
> CPU1 handling dev->irq (flexcan_irq_mb):
> flexcan_irq_mb()
>   can_rx_offload_irq_offload_timestamp()
>     __skb_queue_add_sort(&offload->skb_irq_queue, ...)
> 
> CPU2 handling priv->irq_err (flexcan_irq_esr):
> flexcan_irq_esr()
>   flexcan_do_berr()
>     flexcan_irq_bus_err()
>       can_rx_offload_queue_timestamp()
>         __skb_queue_add_sort(&offload->skb_irq_queue, ...)
> 
> Furthermore, both handlers unconditionally call can_rx_offload_irq_finish(),
> which locklessly splices the skb_irq_queue list:
> 
> can_rx_offload_irq_finish()
>   skb_queue_splice_tail_init(&offload->skb_irq_queue, ...)
> 
> Are there existing synchronization mechanisms preventing these IRQ
> handlers from running simultaneously and corrupting the lockless
> skb_irq_queue list pointers?

Yes, same with the review of PATCH3.

Ciprian Marian Costea, please address this.

Regards
Haibo Chen
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com?part=5
