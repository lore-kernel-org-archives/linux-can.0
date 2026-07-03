Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011024.outbound.protection.outlook.com [40.107.130.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC33C5552;
	Fri,  3 Jul 2026 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087529; cv=fail; b=aDlCLwDqJWGN8mO9GlPqCl/HClIldlJWjTSmmCbKZVsR6c3mCsJmcgFPc+0UmlXVC8533NN2G6PfjCa8yn2otxcKNeAC4oF6XALGnIWQzpiqLBhEJvzQVR/+osIUL47f7AVJdotGhYRT9q6vOc0f2zcTUCf48MK3hJUQo9L5HlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087529; c=relaxed/simple;
	bh=r/e6jFlrj31GtzYEt+0ijgmsoQgn5RPIhaYpUeEmQ/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sSLGdPYweEMg+Nmk1Ao+88qZbIaZDeszEzzIWzsbABO9Kot7aeSjukz4pCM3XDjjccMenaCfue1jZjajXlpfkVF7f8iUaoqkmvRSKbXrMuA5Z8IsL9lszrKp3vOQ1+r/H/v5RyrYUQwcrD6usjKTTlhx9FRbR4bQPaRDazWOgmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=SWcLvvKN; arc=fail smtp.client-ip=40.107.130.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="SWcLvvKN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0EFyvk0yQKuDbfDrogB6mQKmtDsJnlUUZoflwL2jt6XI1NP+exPa9OqAc/7HnXIrT9jtWyUNH6JeYcW5uwmeAuz5OLZkZN1ETSG8v5zTdBIYD8P340AC6y1tghn8DM02cYTs+ZW+sZGYeXfvGQB1t+4NOcMfZDDz6safrQ1DifIKi9QU8u8p/DJWhELKC0EQOuyd8KKIK+gFtJtuTTlTQNt1oca5IVaSM/0xOsj5mNi4eiWRtApJ3a4gfq89UqS3hLl2EusXmrRu4k8ozm9evVwJGqtdQvEBG67ONxtmynq8oBkvVevqhG7KtIjqdT2eoP0bWrB9JAa24jZFpJwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnigVu7A6Eur55kca0znXTn0z1z6fhbjZbMpypzdNZI=;
 b=VNpTOy0PRgN841+N9B3T8AR0Aw/0WjwReCu6JFRJeFbJv/adhavYXIWQ+3L0oTDnu9EnwXYkgW17V1GnfK4LkIyc4dZv7OQ/U5DEMaZe7cDrPqlTqZYN/d9HXTDck0uF4tBsHtRX1ytCSfoU8qn6FbxGB3NJtTFfbu7RBBrJ2M/G6P959h4l96QhLyF7pWjSGjP2t5/zW+JftEagN/kiT97wid5+yQQKUa8+RKRUrxgzw/0ujGY+wEkbxJEyK/jIenON5rBja9zN8s6Qyr9zkFKsz1Fqx9JOKdw3gO3foF5VFI3j7CoL+XAeS0hgLJJXHYkaHitRYzKwucfwYvVjkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnigVu7A6Eur55kca0znXTn0z1z6fhbjZbMpypzdNZI=;
 b=SWcLvvKNK3iXTFl3H8vMz+lk0yMbvRDOfeBP5fSw2nF9Rfhhn5gvEQo0TuOJxM6grsFd49P9OrjgSiPMBDvNMf5WiYHkZvDqvYbKGXffZY1QteIAosYm03fI2w+5PQrJ1SztJGQr/W3Bn+IsmFrW0uqjC9uOhbh8A4MEFr7tI2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DBAPR04MB7414.eurprd04.prod.outlook.com (2603:10a6:10:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 14:05:20 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 14:05:20 +0000
Message-ID: <e03fcd5c-de56-4f39-90c2-3ba0636a1cca@cherry.de>
Date: Fri, 3 Jul 2026 16:05:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64: dts: rockchip: Enable CAN controller on
 RK3588-Tiger-Haikou
To: Cunhao Lu <1579567540@qq.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20260703-master-v4-0-47d40bbf5fda@qq.com>
 <tencent_F79E849B11AF805A4401BF9F263B1A469907@qq.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <tencent_F79E849B11AF805A4401BF9F263B1A469907@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1PEPF00005B8F.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::626) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DBAPR04MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 19dfd7a8-6257-432b-025a-08ded90c1e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nUmGJKV8CIgWTqZTPyIwMgEdaB26sH+DtHEDdHjF5L0saDrNrGjIBONhJngZjVFLzTtVxJEGMWWJR/heZEairWjZKIw5ZgIWAzTilFu0ahSlKfVCoNHO7JAnttEXdnIkzPBjtebt/H3NzXMgwb1Pn/BAL/Jv5k4wd/A5l0B5gfFOB0dcqPixXECJk0uF1uhKg3m19Os+B0Fq0TW8KejcZWXBkouKmKne4KppzvVRRJfsT606wbQxaC+EmtZ/hnaAK0u8cCT/8F8J8Iwe+UUNpZPztlVpoLHavWdUKUUE7HsOHLVZH519VZ7g2wouaXv6X1deqMmLYIdWUt8O6yrANCeQLkJ5CGUak9Ab3RNjckYMH99EnXxY1dzqVqU5Ui0WWX2Q2T5SNjgzmCVApjBRzgsjntXkLehOpAGLJle/epjIIpOHAg9gUf/DwKkPr2TVKBSksIiHJdmhlY4iaHGNUX6zGm2sm6edYH1aDxE6spkB717df3VwDo9AHNQ/Zq3q7s2s3A30wcICQ/A8J0UW5hf4fwPQpVs9JWCZsXeHiYTIpcAwVbGIPQDP1YiHGi8GUPRUzk0N/rDk2/KqahQwdIjDM5+tBkpl84MbvVoKTBX343KF3jbgIEtIEkzwMd7UwoHqDdl5eFSnq2ul2G97re0SgNgALaG1Ph4WhcraGzg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFhMVDhCMDR3eEhLOGN6RDFjRkFlb1ZPSWxNMzdZbW56azBXQmNjRFNvYnNI?=
 =?utf-8?B?OWhHSXZOMGp5clpPVUo1VFNtMld0elRDRDEvbGZrUU5nSFQ5cFpJc1Brbjl6?=
 =?utf-8?B?TSt6bzdnUlZzbk43eUpmbE1TbDd2NStId3BEaXRzSXZQMnJueVFrL2ZSWHRo?=
 =?utf-8?B?dFJ3VGNwZHp5WEFYV2loc3ZicDdrWEUwVzFtRCtBd1FvRzBMYlJmK2JrSXJM?=
 =?utf-8?B?YXMxcUNVYjI5clpMU2ZGU2VkN2QvQmc5UzhlYWtjR0pTMkRQblFsZmVLRHZ5?=
 =?utf-8?B?MVlhSUkxMDQvcFZKY2JrRGhlL1gxVHM5QzB5NjBoZ1l4eEpBa0VmaTR5a3NF?=
 =?utf-8?B?TjlkVTk2TUhsUkRrZld6Z25WVTZRZkFBMlg1Tm9QcWI1SDVUVTNha2Uyd3Bw?=
 =?utf-8?B?azg4Q0dhZ3JQaDBUNWdmWjY2UDB2ZmhkME14Z1FqL1JWQjY0RDFEVzBWT3FD?=
 =?utf-8?B?TFoxSW95ZjMvb3FQek9pdlAvU2dtZDR0UG9INlZUTkFoNjE2ZGZRZjNVMmx4?=
 =?utf-8?B?TWJnbjkzN0JiY1YyLzh5M0w2dUVrMUVmdUtvK0JlUXp5VUx5M09sYlBEd0VF?=
 =?utf-8?B?RGh0azB3TU9QNWhTTWlkeVVJdGJwZklXVUxlWUNPaU5IVHp1ay9jVGJTRGQw?=
 =?utf-8?B?dmI5WFRVQ1hJVWh1TUJMT2tQUklLa2V4WTJteFVLcEN1YksrL2dDQ2dLN2lk?=
 =?utf-8?B?dGtET3k3bjN3ZWorTEttRUxuVjdNYzA1VkpZZkhsWE9IcHROaGRwL2dNT2t4?=
 =?utf-8?B?ZUpqNWpRS0JjZS9vbHI0UVdMZ3FXM09lcElTSkE3RDdaM01CYVF2MkhuelVP?=
 =?utf-8?B?ZzdoWDg1VkdmY3FPbHIweFRXMFNlUWYvckNoUzRZcVNaR29JS0Y0UXIxZXEx?=
 =?utf-8?B?K3FVQUtXaG9ZbkFjNTlMdE5BOG9mSzhWaStZa3N4K3Rtd2VIeTlXbFVGWFVo?=
 =?utf-8?B?cGlob3VESkU1S0ZEQTM1bEhuRkdHUlZSNWFueUVsWkdEcWgzRUg0ZUxVOVhz?=
 =?utf-8?B?dXVFTm5jbFNzMm9ZS2V0ZUJzbFRDc0JGTHhmZFJyTmdoQTlIZmJHWVpTTnI3?=
 =?utf-8?B?QUYxN00wNHRTcXhWL2cxS0cxUXdyRWVDY2JOVTNQclhvUmdETFg2OUFjRkdB?=
 =?utf-8?B?eE44TnVzTWYwdU5nMGROd0tVWWIwSmQ3UE5BVjRSZTlNdHZTQTIwUkxRZXh1?=
 =?utf-8?B?NTFCNk9hSUtrbUxMblU2L0llTlZDa0QyUzkra1lnRGI4MitCOWZFTXFqcWdr?=
 =?utf-8?B?Q1dWd1FZZHhDTSt0a1c5V1BsWVFITTA5dy9UQUhpRm9UY3NuaEJLTXdmRVky?=
 =?utf-8?B?UmN3MDJQZmptUUh3RUV4T3ljL2VVTk5Fb29BZ01uOVE3U3ppSGhPYkJEUEZk?=
 =?utf-8?B?MTRNeUZSWmdjbHlYTFYrNXozcFFTU1FYUXhiMDVET0lmbGU1bENFNDB1QSth?=
 =?utf-8?B?SERIZzVHK3lHNEhJMm9rSWRuZGt3RC9qZjF0Qndjc3NlWVd3KzR4SFdYVlkx?=
 =?utf-8?B?L2wyMlVaOS9Sb2hxMi9CQytjUUlwWGFGQ2xhOGhySklpdnR4Z3JyY0RoQnNv?=
 =?utf-8?B?OTJoZStXMXJHTmJEa1VOaEFDUEptUVJlZXNTQm1Sb1o3WTZ5RkNGc3VOTm15?=
 =?utf-8?B?d2dGNnl5UDFycGcyQjNKT2JUUVpLWUVEd3pUR2d4aE5hSzY2d3JqYklqQWhI?=
 =?utf-8?B?b0ROZFJPQlVlUVViZUpqQWtNdUlvVnlHVkdXaG0rYmlYc1g2ZGRBUm9yK1Y4?=
 =?utf-8?B?TmQ0L2E2TTBCMXFmU3FLUzlKbnFMcHdMTXcyQmdpQkNZWGFuanJEUGdYVHpH?=
 =?utf-8?B?M3BKaU04aHhlZnQ3UG4xL2I3TEpzZVJ3enAzSXBxMHJQWDhodjFNQjNWdzFu?=
 =?utf-8?B?bE5kWGZqNENZVVJYQmZxZm5yM2ErZ2RMMnJKR1MzWWViZEpQeFFSZzQwT2xW?=
 =?utf-8?B?Y3V2c2VVMDNuLzZCUG1wWjl2d0pyVXZQZnNQeEdZYnE1Y2V0c2t2MVduR0p4?=
 =?utf-8?B?emo3b0JUNytGQldtNmhQUGFxWTBVN0s3c3RKeDBvUVBKNWFoeFJCaFhSOElV?=
 =?utf-8?B?cml2SEpnQ05vckN2NGFHVFFneEgyYUt2bkZ2cnpEK2NPOTM3VFN2dnBzYksz?=
 =?utf-8?B?SUhZaVhvK3Q2RFRqWEZRdmxWUlZMVXRiM1VzNDF1cDNCTlNFZjZ1bjNGYWFR?=
 =?utf-8?B?ZkRoK1ZlMVhNcGFwS1lZUmlldnR2YW1HcHNUZ3pFY09RK255VkdQTTZuWURV?=
 =?utf-8?B?alhPTVJVdmR4OUFrenJ4anp5NVNMT0ExZjhEYzZNMnhOQWJpYzJkTkkrcUhm?=
 =?utf-8?B?VTNBSzdhcTRsVzdpTmVUaFlhMFp2QUZPRmNkYWYrdGhxb2JYS2Nndz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dfd7a8-6257-432b-025a-08ded90c1e1a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:05:20.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOUpcHPQSVHfcEMGZe49cUk07/lWd3B0iQLMORiJ5bR1ep54BxvGuA0bdBJDOQDkKtgp+9AYH4rabGA77X1GpMP5spu64BIRVyB/Sl4S3nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7414

Hi Heiko, Cunhao,

On 7/3/26 10:01 AM, Cunhao Lu wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> CAN0 is piped through the Q7-connector to the CAN-Header on the Haikou
> base-board, so enable support for it there.
> 
> At least on RK3588-Tiger, the CAN clocks default to 99MHz, limiting
> usable CAN bitrates without skew. Errata documentation mentions
> 300MHz as the default frequency on RK3568, so replicate this here
> to allow more bitrates.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> index 873fbeb8daa1..6273e695b039 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> @@ -155,6 +155,12 @@ vddd_audio_1v6: regulator-vddd-audio-1v6 {
>   	};
>   };
>   
> +&can0 {
> +	assigned-clocks = <&cru CLK_CAN0>;
> +	assigned-clock-rates = <300000000>;

Why is this not SoC-specific? We are only routing the signal from the 
SoC after all.

If it cannot be put into rk3588-base.dtsi for some reason and is 
product-specific... Why is this in the baseboard DTS and not in the SoM 
DTSI? I would like to avoid our customers to have to copy things over if 
they should just work on their baseboard too if they don't do crazy 
things there.

I'll try to find time to test the three CAN controllers on RK3588 Jaguar 
with the CAN1-CAN2-UART4 Mezzanine adapter board and will contribute an 
overlay for that if it goes well. I don't have a CAN-FD adapter though 
but I hope they reused the exact same IP for the three controllers in 
the SoC :)

Cheers,
Quentin
