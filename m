Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F135391E7B;
	Mon, 20 Jul 2026 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784528235; cv=fail; b=A6FpAbC8ZEw+XX/bvoRl2KqrnVS3xxTqmXMKAcMNgTFD93MhaAxZvZVQRLpsnLY5QKfQ37tAseKeo2RMJnv40EwPpybjtlOZzsIg8KKeNQ8q7Ip65/vFDq9Ul/ms2+gJ23D2AsOrI0y9nrZdtF/iON1d3ZLbLFFhsQ2zwRnh+ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784528235; c=relaxed/simple;
	bh=6er2C/aAzp5rfp5m3/4JLrrzaLVuEirfOCEY1fyiix4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=smVGFVBonufrYIH70IcAyFvVgTkJdJ/P1BnzPTZcEB99z8YLA+2gJLQ5DdzEZqUZ9NOiDBh5xDynJ9caZuwB2EFEev7yzHKCau9tiv2tvKXM81MxLHWT0kdeLfKr+2K3ErC6Lbx3k5MyD2lRroJBlOu1a32bckTjLUUnKp5r0Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3/6xkSTC; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3/6xkSTC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/NnkzIW4yeWmrvWlYRweJXnLjgsM0DhZKO/TB0pRCV18Rn/0HMUzlgT/wiGfOroBfluEFdBjR7gQuGeKRd8gC62v+iHp31NoUt/uXgH6GoGn0odBy44yC1jq0ZKDQXGTwGXtVcgHIlCfyvfBtl3u7bqbCigeBc7hZ+p6wsgyFDIXkKUGnvPS4Y2IviwSY7r+HGMOoxbK0mH/lC14GclHe13h7J3JK3x1KE6oix+CU8pnFzVcFMR3YpvAVmjVxodJUu5X3imE9xVD3Y61CRgwP4Ix+E1AaAULhWLsKn+hwDOPbX/1qvdn2tH5zihDzy5EIoRenHCvbgOmZXjiXm5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8x/x6wj1EIFH9JMaE6eiwXWpPDi9GJ0kCiBgWEdhTM=;
 b=Ukeo+fZpiI92CVOQEy+NQtIf8ZFugy6MkAsCcCXtre3e72jGIs7Bg3zjUUBc01evxAgRA7mXvyFwkR1kyLCEak0uytQ+fRjevXGGlp1NJzcVT8YVrMscdwG3JMcCVVoYAlUqeAK3DdRCbTMUoRLQx47+h1nwecSq3BOmLMcpr7511XAeQHlRN8we7zapq4ZL9pppMjlJtDshSePo31PlgMKTQgP4bFhyDWJaJ8QtO4OYR8CKASMeFEXUlRzBVxE/dt189oihWqpsb1QGmiUjCOW+Gow3RzWS/AJe2r7uk1yza2fhknkxFF7jwNmAEPm5FWSTNCbGyxCmiAYZcpPWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8x/x6wj1EIFH9JMaE6eiwXWpPDi9GJ0kCiBgWEdhTM=;
 b=3/6xkSTCrLlOky4C43nM9rLhzSIw0r6wkKl/37K3rrVCbQYJ2NJMVca1xg8RSh//1/VCHyyxGgkrxFlOefdHIfxeDb9Wy9PbQsoMfA2Ps1u7tTQKKAMuAwRL3+S4O0nei7tdFJ7NWZKft+QZFmQmICMRVkzf8gcwE3QCbFzHq8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 20 Jul
 2026 06:17:01 +0000
Received: from SJ2PR12MB8847.namprd12.prod.outlook.com
 ([fe80::a5b3:669b:dfa5:14ca]) by SJ2PR12MB8847.namprd12.prod.outlook.com
 ([fe80::a5b3:669b:dfa5:14ca%3]) with mapi id 15.21.0223.011; Mon, 20 Jul 2026
 06:17:00 +0000
Message-ID: <efd5b639-4def-4c27-9dd0-0407576dd74d@amd.com>
Date: Mon, 20 Jul 2026 11:46:54 +0530
User-Agent: Mozilla Thunderbird
From: "Rao, Appana Durga Kedareswara" <appana.durga.kedareswara.rao@amd.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Replace maintainer for Xilinx CAN driver
To: Harini T <harini.t@amd.com>, mkl@pengutronix.de, mailhol@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 michal.simek@amd.com
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260717021415.2234865-1-harini.t@amd.com>
 <20260717021415.2234865-2-harini.t@amd.com>
Content-Language: en-US
In-Reply-To: <20260717021415.2234865-2-harini.t@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b4::11) To SJ2PR12MB8847.namprd12.prod.outlook.com
 (2603:10b6:a03:546::19)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8847:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 44965fda-2a09-4aef-b659-08dee6268275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|11063799006|56012099006|10067099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	XiXM4s4+RqMAilYT/4KQQx5Zjhyn7mX3ZfdDBnAkaSMcSb6D+F//Ze1d+AnCfayqvazJiT93GadZ8b12yhWcfRaS2cPtxyYO5jxpaw5VXZfS/LCV9p+COOOCurGS0uyE7nHNG6LOibmHcxEDuYu1DVJ2IHcXkeZfosVEuExqLGIrEUZOzX+3FTl/63qLS9EQUWXGhQ0zHpHEwtvjOL8yxfVDYlGCnJcjF52hyWEEz+PjaEfZmfmWTdtBTRrN0aQ3nc7Xa5qhCEuEPo/36rGUT8dIL+wVmp1hTWlV1j4TbsPbyA+jbDXs2iaGk0jnMoipDxXyxJsdW3DRGYfYDXYr5kTAROgr+vtx0a4f8Fa6TOJWnQUNZL5G1JI507obOjN0Y7CmBHY2iZ5CZTK3z8Ev/vUWLoap8Jj8D5yrxu7JCfJc9tR3877fA42Cd52OYe3DZFvqqallnWWDCSRQL2X2SATI3lONNSZQXFdRjHQ1uyOxSlRM8zhHjEx9GkqsKrzw2At6/ViwMNvfeWsCrqI7EtPwReBoZSO86ZzZld5mBsJc4qL9nKLNZsghCtoy5gNzJ5DryzEswjyTY/AvaiRY8fbaXVZiUO3uJkLiH0rud7yG8u9+re+155Fbl88aHOUDDoyykY083zPp9NxPgq3KB3BE8lEfyzN6hE8kdpT1XtI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8847.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(11063799006)(56012099006)(10067099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmdYNmFOclNvTW1ER3BrMWhvZjlUbFdQWlJNT1NuVWplK0tVWkRiTGJBbW94?=
 =?utf-8?B?MVZqc2c3NVhBNk1HRDZYblZTUkMxblU1WUhVdUhXOERmV0JlOFZyNVV6RzNB?=
 =?utf-8?B?WHU3T2xyeWVwR2I2WVE3K3FTNWdoUGdZdmdoclZlaGZ5V2VqWW1lYnBYYXJP?=
 =?utf-8?B?ZWgrVGREQlNEUWowNjFEdHNXazNSZ001b0h5Mi96V3lTaDkyVkRJanl1dXpq?=
 =?utf-8?B?YWtudGx6ZFNUUklwYmFYRHJtVGpHcGJPSzNNSFl5eDFTaDhYb2oxL3BaaldJ?=
 =?utf-8?B?MkJsenYvV1QwWGVBcm96RDFOTXNGZmR4T3U3UkFFRkg0a00xaW1pMEZIbXFm?=
 =?utf-8?B?MmpkZ0ttWHJpTEx5UFlnRmdLYkxZZ0VhYVNmdFBySU9qOVlOL2xYR3RZRDY3?=
 =?utf-8?B?VUhTQVBaM2dwdElPdFBpQWRFS3U2WmRoZjhOdS9vTUsvYTFPV2VLUDFGck5L?=
 =?utf-8?B?bGtsWXBXZWVLMUNDOGpLeTZ1SERrMm5qWnZEV3c2WmxJSnZWMC80aHB4SHRo?=
 =?utf-8?B?ZjVMTWJkMHJWOUlZTE9tOFpDdUNpN1BMcDcyK1dyZWlEK0hoamZMcm8zbTlJ?=
 =?utf-8?B?d2VjemZjTVNLZDVVZlpaem4xanFUM3BTMXIwVTAzcXZiZUw1Z0hKZmV0QlJ3?=
 =?utf-8?B?SmRSd0M2Ny9uWktlVG11bWtRaldtSTQwT3Npd29URlhrZkk4Tm10aVIzQUl3?=
 =?utf-8?B?U3BoZDRncDN6UmhmSndmdnlHa2x1LzM0NDNadmV6cVJrbm1EU0VaMlNaQzRz?=
 =?utf-8?B?NEpLWitoTDVnaTNPb201eUs2Y2J1bmkwdjZiNWNvWXZNdUxBbXlnNmZneVRW?=
 =?utf-8?B?Qm5hUG05eW5WVGk3c0c2a0FLMFdNa3RRdStaUDYxWkNIQkxBOG53S3IzSnoz?=
 =?utf-8?B?c1lXRk1aTFZWMGVTakRnK204YUlwQ1VoNTlnMlc1WjhNcFJXMlFoKzYrKzUy?=
 =?utf-8?B?cHVQRE1GSTh0ZmkyemtMVHMrZGt2WDBDUnBPZTZRVzZMZVljM2N3VGtIbnRs?=
 =?utf-8?B?QnBmWStMNWhxWW9TTDh5L05OeHFyWDYwNm90R0NrNldRU1BSdHl5SWJESWc5?=
 =?utf-8?B?KzZUN1pqaDg5TlB1dkVoUzMvQktCYXpNZ1NUckVPVlppdEVaSVNmMEJTdFlU?=
 =?utf-8?B?VDlOaWE0eVo2SXZKc2ZBSlBNVXRhQjhXb2ZvWnU2eFB3TFcvSGtvTHBuZ1Ix?=
 =?utf-8?B?UldXMEpzNWZOWTBhWGE3WkQwWEF1YnlPdXRnSlNwamk3WXdaVjBKWlVnclFS?=
 =?utf-8?B?eURqZlRMTzFETzl1WHVCTVoxSmh2NDhiMDdLbEpjc1MxY0pubHl2VE1Od0R4?=
 =?utf-8?B?LzY1cFlFemFPWFZhUDJ4VFRwejMwd3QwUFd4a09wWVExemd1aU1rSm9aczVB?=
 =?utf-8?B?UHVGWk5kbUdkQUt2NGJDUWp6bnRpZ21OTTNmbnUyaEsvK3BSNFBmSWtLT1Yy?=
 =?utf-8?B?S1ZCYjBiMjdXZzNDb2ViRnhFNDRCRU1la3VwNkdwM05oS240OXdENEszOUNO?=
 =?utf-8?B?Z0tFQVV1RGVBRFc5QmI0RFI2dmg3MWxuR2VhLzVJV2lOWHdDSUFOQkRybTVu?=
 =?utf-8?B?cXNySjZNWmhnVTVEYS83MXV5cnVTeWVOMUNRZjdOQlFPUVNLSHpOVk5LOGVu?=
 =?utf-8?B?MzYvSE9QTjlGWHBhMkFLQUxJaWdqRFcrK0pyK1NwMlQ4S3RraUFCVTM5ZzNL?=
 =?utf-8?B?NXAvQS80dzczR0RGYzBMSEwyT3BrWDZnTkk5THkzdUJXNElMeTBqVjdLQUxr?=
 =?utf-8?B?RWFsZEpkUFUyakdHMFFhazNjMitJUmcxRGZCWFJpUm9EL21HNmQrcCtvdndq?=
 =?utf-8?B?SGJJVW1KWmF6Y092cHhIdEFrNjNueUYrSWtXRGprZlZ5SjRlNmNWalJpUGc4?=
 =?utf-8?B?bzRld2s4N1dXcVhDOEkvVlBhU0U3YnJCaUhxYWFpQVdiU0hnbzNWKzJmUWFI?=
 =?utf-8?B?b3hZS3hwbHpJK2oyRTkxU0QwR0x3V1Bzb0ZzajBVd3AzWHFMV2M2Y1RnQlN2?=
 =?utf-8?B?Z0hBMyt1YU9EdjRBaUZGcURmU1dvOVFzYUV0bUt1MStqa3YvZ2pidGcxMDQ3?=
 =?utf-8?B?cWpWeDZjRkhhM1VhZVAvamdKcFFycEkzZGJOYWREOFk1eW1mMUpQTmhyT0FR?=
 =?utf-8?B?Sm5HTUphVXlqNFpOUW9IWHRIT3ZEQ1NWdTQzeU9MTExtUHZOZjQ2K2lkZUM5?=
 =?utf-8?B?RlA3aXhaOE1mTWJ2dmVmQ251eTc0ZnVQNkk0NzZwaG45WDlLTThkU2lLeDZn?=
 =?utf-8?B?VDNQcVpCRGxMM2tJa1hZQVg0OS9FalFlMlBQSjI2Qmh6WDNXbG9OemViK3VQ?=
 =?utf-8?Q?NgeSy6KJAwlDjzu6TD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44965fda-2a09-4aef-b659-08dee6268275
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8847.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 06:17:00.8255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+1sMHBtfZGG19PKDnk1xyaKos4yBeITNoCMl1CQRxCp1PGl8riLYFvkd1GMez84
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796



On 7/17/2026 7:44 AM, Harini T wrote:
> Replace Appana Durga Kedareswara rao with Harini T as the maintainer
> of the Xilinx CAN driver. Kedar is no longer maintaining it.
> 
> Signed-off-by: Harini T <harini.t@amd.com>
> ---
>   Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 2 +-
>   MAINTAINERS                                               | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> index 40835497050a..e705c719f7b5 100644
> --- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> @@ -8,7 +8,7 @@ title:
>     Xilinx CAN and CANFD controller
>   
>   maintainers:
> -  - Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> +  - Harini T <harini.t@amd.com>
>   
>   properties:
>     compatible:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a2ffd9d37d5..db619dcaddbf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28874,7 +28874,7 @@ F:	Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
>   F:	drivers/net/ethernet/xilinx/xilinx_axienet*
>   
>   XILINX CAN DRIVER
> -M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> +M:	Harini T <harini.t@amd.com>
>   L:	linux-can@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml

Acked-by: Appana Durga Kedareswara rao 
<appana.durga.kedareswara.rao@amd.com>

Regards,
Kedar

