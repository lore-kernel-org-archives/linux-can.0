Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F3443A89;
	Thu, 30 Jul 2026 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424905; cv=fail; b=D3siD/nWBRey4ZP05m6HjChKpvVb8P/N9fnJb1cKtvYHjYNabHs25Id96yVaG6MLWYIGoLf64MeWfd5WfyIVNSb0zB9eL+rJuJ9ZcMtuLM470xiScRhc0SROGaVdfZqJ88nbvlaLeJDlubXvluH24bZ621ntH7/Q0IXOw62r3vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424905; c=relaxed/simple;
	bh=y28s1iOsNXaYCSbNSlhvYcaQGjp7lzg9049LZOzK1PQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r9tQAbTQkg9MqFqVMWtAsqIDQwRIS9nXaKQFKQM/JPgCOCa7OnGCoNsP8UFGBIdnsekUF4Uv+VUipflnrYMknFU7GB0f3hbZq5YgfxQkIvCQTPv8m7HUZspKxAZAYiDUqZQgBpcnefxUNtuKJVSMX1g2Vv4AVncB1FW36ry++2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=QF2z09a1; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="QF2z09a1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfKtTjcDtrnQDGMHn5iadomKUFFFKBuyjlfQcIRXM+vbubPdHg4m/q9j0CxIRQChKkh7HKqcFvsBUIfTh74oMMhHsVSa40oJDvnaizpG7lZC083NZ3uBzi+hmc/dXfTbQYedFxYX+FfvHekjZR7fspQD82cKcB4AWZyZwXlKWXi7/e8S+wqw0zCfUYU4KPsDELBkO7jK/BDIUCcfyvyG5PtbQl54YbIeVECjzmH94azX5AslnNnetU1AZJx+7qe6b3B+6/fLnRdyL6tmHFGyrhvZScdhydgS+DZ5kJO5LZYmwsxe20wB9zg6q4Syqx7GZqktL4wE2myb9KSebdKwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gurVjpa+FxGcc5JDGH4iqrszVOvSbB78c2N1hLBEYJ0=;
 b=KtEZmhPc9AHHF+7grFrPRS7Byg6JwjVBRVhcJVrXod7DdxD4dWDFrncRkE9xcIavOGk8EDpsjUIWjYLbNy1Q18/zjrQ1FlhjyxWbY5ka4otHfEuVCk1v85ZKDvj7crItgfpEtr/vZk5vIdLYsCGChjy5rp1TTM8SL6ysJnv0W0dpYp9H+pl/07dfZ4i2qbLbqqfeg8KDA8X4XrOOgSRrzU2noWiBG1ijQwc6bIBoXXXIhqx/L5VcHe37mFQeCVlTFqwRJW1EAnSJYXzgaJsZffuJPSClWJzbUV1ofcda5iSkSBkcIyFYOI9YDrxsW57DQfz+wRTwqYFZIbKDaV6fqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gurVjpa+FxGcc5JDGH4iqrszVOvSbB78c2N1hLBEYJ0=;
 b=QF2z09a1EBYquni5w+6oOo1nYtJeE/LOGJvc4gjZwMTdLYsLgNY1RbAIR9oiVAq7KjvibfxmXAo25rc9t/XppzG/lYGo4GBUsL0ke7TW5RjuZkzQlmF/Jcv4zND4g8p96rgVWbPAOH5yuGQibS3jb5aZjRDFeHKx0afclbw4NfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by GV1PR04MB10558.eurprd04.prod.outlook.com (2603:10a6:150:20f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 15:21:36 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 15:21:36 +0000
Message-ID: <d83d2d39-7c58-44e6-9454-6d8e38511bf5@cherry.de>
Date: Thu, 30 Jul 2026 17:21:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] arm64: dts: rockchip: Enable CAN controller on
 RK3588-Tiger-Haikou
To: Cunhao Lu <1579567540@qq.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20260730-master-v6-0-dfb63e234775@qq.com>
 <tencent_A982C9885A401DE2AB5F405336CDA14C7C06@qq.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <tencent_A982C9885A401DE2AB5F405336CDA14C7C06@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P309CA0028.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::6) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|GV1PR04MB10558:EE_
X-MS-Office365-Filtering-Correlation-Id: 3717e1d6-5921-40b7-f494-08deee4e3eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|4143699003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QNa3dnXJ2BwR0OnRaQ2ilFqYnVT9rpynNo/1Yx7r5+212hXVgFkemQrXXEa7qX5ssm+uw/pMbDYzsWLGuQOh08xVpF9LzUFYO6hm/L8p8On4WrXkDKWFNVUyh/IBA74wS6vEv00YxxmLSNlGDdas/aA9xqy1HYNFopmeolZReaCZlDmQ8+ulvNPa3tOFiqmNQu6C7Zsnea5yvUGKuCfzlplAfssAcme55x5lE3Ui2pDP7fyLUaX2AeHeJBJ+ymgejE2dh2VTRJFnEqH7PDVCEO/697U1fIpVuTchwzqfWG6+UvoTUmJdCSbEtnB3KTitBFfOQfpc9PBuZOvDqG4REeuQAnqbgTnKe9HJRPv8RQbawEPCBz/vnMhdcaAmnPX2kMw0x0YqQJ2/pYxqkpBzeCp9EHHUXbl3YOg2owqn0qtNgAECPnrYqthrQ4A+AVBu9a8uJ1upR77bNtdBScD/EMjqmVCA/8qg7QQObhDRP93hpAN1qH5HEWt3RTfMQ/cO9Px3s3A0xrkBxlda+/NTv41BdyyZVULTEAz4lND8/YIvpYk4zcDuaFk5KEWjC6pHXXdtagmaIrfaCqD4bzGU5SJpHpvLzNTRm00MstZWWh59bo+WD/+aS7qT/nFxYBUNL/f3FQMNTu8/YkCr6TkAbL9GH+c9cqqa7zxiU3+xTqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(4143699003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW9jZzQ5T0NQWDZIcTdvUU9POTRqRDBjb3R1dVg3RlltQW9PalBFOWhjODRo?=
 =?utf-8?B?QjErZ3JZb3o3VWE4OWhmU0dkaTliTHgwY0RyUUkzalh5ZFFOcDA4aGl1UHJV?=
 =?utf-8?B?Q0tudFJtaGdVVW5tQTAySFQ3QjlzVlRmekxVVCtsc2JQMFNESmg3ekhYbTBh?=
 =?utf-8?B?RElHNHFwRTRuN21VeXRKM3dKUHd1L09sclVrY1ZkZmhBTnBzMUd0NFJGeXIw?=
 =?utf-8?B?M0JtM3dISmNQYmJxSjVyeG1XYzV4MmVQVkVkZjM2ZWdXbjQxYnR6YUdwODlL?=
 =?utf-8?B?VGdCM2YxLzJWYkM2cDBXcmorUHUyZ1AyU3hyRk5nWVNVem82d0ZtRWtmSVho?=
 =?utf-8?B?UEZSM25QNmE5QmgwcnRta3hZUUc3THFQK09NcjVwQ01ROGozYk9YeU1UdUNa?=
 =?utf-8?B?Z0lFdjZPZTVQVlcyR0FES0tONjJqRjFGWjRsWTV1YU5ZVmlxSDBjN3BPQVp0?=
 =?utf-8?B?Z3U5R0JTWGFVV2IrRlYwM1lyUm5ONm9ILzU4WU5zUlRuVVBDUTY2ZHgwMloy?=
 =?utf-8?B?Y1FVeTk1NXF3TitSMWNsYmpXYWg0THVvQ0kyMWdiSDVtMTJQbUJJY0x3dmFo?=
 =?utf-8?B?Zmt2ODBtUkh1a1gwTWUzN0dQck9Lbk5RYStnQnBwVnJjSFVFSnY3ZTIybmNl?=
 =?utf-8?B?MlJsZkszb1Y0SzNjN3dsV3crb0NIZmQ0b0dNTnQ1MUhlTUs3SmtOclNNMXZC?=
 =?utf-8?B?bFQ4a1kxZnJKeHptWUNjWmpIT0I5UmxmZmczdUJLK0lzVXZxVDBmeU1LR2cx?=
 =?utf-8?B?bnRtWGtZOGYyUXBMQVlNTnFwOGh6YXRuTS9oWk5QOTEvQ0IzUy80QVhPN2V4?=
 =?utf-8?B?T1g3ZmsyWEtyRHZVN2FpRE9jay9VaFR6SHhzZFhjdEFSWXJlME9QbnRuV1Uz?=
 =?utf-8?B?SVVpTHpkSkhESUhoTVhuR3RiaHRRYjRhVXRXdDlGdXB2RlhEYmh0a3BKMFNV?=
 =?utf-8?B?a0dUMk5HSXlLVXBPOXl3VFZVZ3VZZ2JMa292WkVkeDdEZEtNMGxWbTVIR0I3?=
 =?utf-8?B?NHE1eEVhK3E2KzlaYndvM1NPUEF0UlIxNHk3dnFiUGlQeXB2MkgxeElGbTNt?=
 =?utf-8?B?cUhyYUJWQmt5TU1idHF3c1ZGNmRBb1loL3FZOWdxenk0aWMvSEZtRHEwWlZO?=
 =?utf-8?B?WHVXUDNPbWp5UG96TFRzYW5SNlQrTUZmcVVwZitqKzlkUVd1THd4ak13ZjhL?=
 =?utf-8?B?c1QxMEtxeEozMm9xUEJmcEduN0FqNkw4aEtQMW1uVmkrS2x2UExlNjhwOXpP?=
 =?utf-8?B?ZCt2TVkwNkNiT01VNHhCZms2ankvTDcrY05JWVlzbENTNDdCZHBCVHVDdmJG?=
 =?utf-8?B?d3QyYlkxVFl2Ylk2RG9OYkp1c3Rtdzh4VE0rQytQS1phN21KQndQVGk2V0Q1?=
 =?utf-8?B?NDRDQ0tkUTZUTkJtRVZXMW1keXdxM2tSc3F0alMwck9FR24zOEVWS3J0cE9v?=
 =?utf-8?B?bC9QVjgvOWREUVhWMWRxbGNxRnJLeHc2VGdIc1dMWHc5MjlZOWpJbmluMmRw?=
 =?utf-8?B?dUZRa09vMVIxYWRITCtUQU9hQkJxV2l2ZmxVTE5WeWRLT3Y0SXdDMndMMjJi?=
 =?utf-8?B?TUZZWnRqK0ZtYUxCTVBVN1Z4cXd1MCtFVzdEMkNCMHZ6OXJNQ3dLblhlSjU1?=
 =?utf-8?B?Qnp5dk94d3lqK3puOHlHekpJMS9ETFNwNVZFblN1Rll1bmpFNzh5YWpnNit4?=
 =?utf-8?B?UGpTSkhoWkMvRDZLSHRITlQweUtWYVVlSk9NYXpwTWZoN1dmWXQyK3FHOVJD?=
 =?utf-8?B?NkJESkJCVG12em1rVStaVlJXUnNVcUt6RDVrTEpwNDBXeHdBMzlWL09sNU1T?=
 =?utf-8?B?Yk54TlZPM2pXODh0OWdTWnh4T29WQU4xL0Nja1M3TWhTbjluYi9FVVVXT0sv?=
 =?utf-8?B?WkVqQS9yQkdOMk83eWNjaDhZQVJFb1I4SXV3N0V0dlVXaHEvNmpDWjdMNFVX?=
 =?utf-8?B?b1ByRTVrSE1NU1FRUnU2ZEgzRGk5ejkwTndoMU8ydk1hODRISytwMHFTZUxC?=
 =?utf-8?B?SmVKbFRScm8vK3J0ZlZZQnAwQkRTQlg0VUJXRjNORklkcDVaWmxRVlNQblNp?=
 =?utf-8?B?UXVYZzQ0bnZKOWxoRUVmMVpJSGxRd21FMDd4ZUhFRTByMkk1bW9EQzBPZnNT?=
 =?utf-8?B?Zy9vSVhyNjhyS3g1b0lWaXZKbVR4eVpJVmZZSCtVWTJSM3dTbXhxemRSTk83?=
 =?utf-8?B?NitpYzlGOExKQTg5RFMxT1VFZWxTZzRzT2ZwTEt2Mm1KYWVQeDdaT0RUeEx1?=
 =?utf-8?B?bmFPODJzL3R1RlNES2VVRHdDL0ZnWkQzSVFSZ083S25HYjF1YU00dEVjSlIr?=
 =?utf-8?B?WFEvWnY1czhBODNCdThlM0hlTkVoNC9TWnBISEV0WkJLOTl2YXpNZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3717e1d6-5921-40b7-f494-08deee4e3eec
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 15:21:36.7018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOkG2YI2QZQe3bUpgYJ/m/4YoTg3h+/YILTqr2QVv3zi7l4NCvaZe2EZKYLVusgzg7niXgTctJF+PJ9uyVenBzGBMQNGF0ApZ7zIaFI1P+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10558

Hi Cunhao,

On 7/30/26 4:34 PM, Cunhao Lu wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> CAN0 is piped through the Q7 connector to the CAN header on the Haikou
> baseboard, so enable support for it there.
> 
> At least on RK3588 Tiger, the CAN clocks default to 99 MHz, limiting
> usable CAN bitrates without skew. The RK3568 errata documentation
> mentions 300 MHz as the default frequency, so request the same rate to
> allow more bitrates.
> 
> The CAN clock setup is common to the Tiger SoM regardless of which
> carrier board exposes CAN0, so place it in rk3588-tiger.dtsi. Keep CAN0
> disabled by default and enable it in rk3588-tiger-haikou.dts, where the
> carrier board routes it to a transceiver.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
