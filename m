Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794811748;
	b=MV61OmuZuzeWg3z1El+ATGTyJE1RFelCQA62tziFgSJ7Uc/kXAU6MQsLuAQkP3h8utXo
	 Fywx1FEMK8sYupJ5PboUjXP5FiDwG06s2kvRjUePq1lmO5IPAxPQDFY6pgFLSi9ZT38Q4
	 1h4O5+YGk533gmTcuUHt0+eFPNyFcesLS6OeOaXIrSVyn8aLkXfwmtQ61GOU1ZsIZXZgZ
	 tNefKmL6nd4FG+ZDx6+XG0Q6+8bwOF/jhnDwTHUwmSRqHXF0vnpyJaIz6zO7qdRBLinIW
	 3Asfqdwsh2emema6tTX4dUc/slM/qxYRCvDUAQlNOgb2umkF8NYPqFtQ9WpPUyQMnkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811748;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5NuddfxQK0tlY1FwiSwNbZZ2tr8BfI86RkFLN15nQAQ=;
	b=cvzXP2eM78Lp+Rtep7GT5kTLxhMTSLkeY7KCTAfq3MNJzCHa1/Rypr8p9MZaMAEmSdp1
	 E11ZhM4NI9+dW1MCjFAiyjETDb9UWD6gQ9jsYkOYBTc1EdnjuvTagW+BVhvqf5p64gnbL
	 FVAjSE3bRMeN10rEvIQCuwU4/WzEw36fUF/Exj1U9MpdAJ+x9wQXHnAZcaoNTdmO162M8
	 /wAZqhOPebuHolRre8dldhmK1yBZsp/m8YVpZtRk2Nn38DjD/qZFLe/kWzOdz2NiKomok
	 5tDzNQBOARmABVKHttNQMZ2xjJWAMHcYrdbdtZRhHAQdRoPHfqG83MQ7jb7KrimUJ/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xCuC04fn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.66
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D074606A31C;
	Mon, 16 Nov 2026 06:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D074606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xCuC04fn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miHILuU142J885oq8Gj6MfGBbxdlPDLA73CshePqcG7OxzwSs5Pk1Qrj1qZXbAIMH/lAQCvLBZ9HQI57f0jCf2MmI/0xxpMD+FZgCDOkTUDaISQmID1hHiYws5jeDU59YXwLXMh9uu62UBzd/ckyfe9RuBNTXpv4ulwUJabA5pKONfa9B3WCQd0FVXs2PMYCWizROzm1e9NiuUeWjW22TsjJN1GFnGkRC12KbVHcLND1PKyGyKII/HSzuRV/GuJX6khouQkhCUSIP1Uzs5884xKe/e0Yv8EW/up9XqVEMyF1p+IZYjCgeRcd5IKqU/R6vcbUugjHEnVfg/CrtdVtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NuddfxQK0tlY1FwiSwNbZZ2tr8BfI86RkFLN15nQAQ=;
 b=pfLp00fVWqW21yGaq1KHUdoxB6Ur2foET27WubZTCLIAtSpEowq62j8zfIz5glUAzLlzhm2ih/afXJkBD0zDvsZSUzEBSqRNrnzPh3uB9eviAC0FCYQ+7Yr001dEuW/S7OiWypdHKqkzl4NPyMwPihVjCqp2CI4viKvEKuwP7lIaSJU7qhpN26KezjWBlp6kHeE6AQ8zy7kTF2LZEodTNNNjbq5gICXvZ83nqsMIgRpgGZoJ9gS2jEjy3L7g3KSZl66+bpUJM4f58NOCBEZELIIitUIPPQxOxidjkpL3C6v7e7lSo+e7DWchCPbKFBNPpJVhwRWnwzSbb0rtwzWbOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NuddfxQK0tlY1FwiSwNbZZ2tr8BfI86RkFLN15nQAQ=;
 b=xCuC04fntquq+qiZBFUwMoeCFwTg8SXTtRGJn2xWSj8M84UTM6xJE5WH97YM83vdDyHmZ9Ilgd8DLeQ+MPflCspEeoYY5fcoYZo4WB2jKLmOthes8ULXr/nuAzfleWccp3srJMS8f/g9IK2d8d/UdeK1NBiKf4omaMu5QFB0Vi8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 06:49:04 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 06:49:04 +0000
Message-ID: <867581ef-2ed0-4c6f-9429-0655a3792ed4@amd.com>
Date: Mon, 16 Nov 2026 07:48:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can 3/4] can: xilinx_can: xcan_probe(): reject devices
 without match data
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Harini T <harini.t@amd.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
 <20261114-fix-device_get_match_data-v1-3-2d82025e9646@pengutronix.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261114-fix-device_get_match_data-v1-3-2d82025e9646@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 5283295b-7bee-40f4-bbf6-08df43adb414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|56012099006|11063799006|4143699003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	B+oXLNMV+fIJZfnIRBHLTCx/2o1nP73EOFt67xs6nc+sdMlYQGN9AuvIPkRAXkIkVrthKeABW/+eb+Gz69boSPzn5MxC7nJkCrk/HvQx5o5FDHhA1MgHv/2fQ0lYnChpXJJWH5LtpBF0q6hN+bEQyusSUY60niL24fUX7H86XmkDrJLgkhTMwBXm7alT72iSuCZfpu3/uFKI/40QZ7+7lTUfPUtoJ9XdzAzXgVvx1zqec46VcY7c5nlpbLasfO8Y1oEQZqlJoTFFwkZpnIVAOu/pkM66zQdltuolws0oavkjoS6op7WWRdA+Ligy3PfVDoThgv+mOyVIQlvQvS8goFU1IAvu28VOdfRU3F5z9f4P383b+Iy4SYDfbFnyVcQDJ+fetNfcVisREi6F21pFE5mgtJERWBon468JMLHg3SarUqeUXwS0ywIeIp6jhhcalJCwdH0RCyWiyZpy0+CprXOLPGqTFFj7YSpfO2K6iY08HeGSI46X8kk473c4sA/nSFgKPYg1m8utPibb3WCf/52EqmKtjJt/m3U+co/hNYQ+4qqjhEVlajFNhrEgBmlER0zRcfE6pMFtRdqM4Rq52my1G+Sxmnucw3nyxvndeDSF0D1Bzm1rEhg5dFQunGHLc8jFIR6MvwbPTYS7TluxlYv9NfafwuoBGSQx5xhUTRI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGIxMnNyT0ZTdks5UlNyK2JGUjNTa1dDZ085N2c2NVBMU0JvRFV3UUF6RklX?=
 =?utf-8?B?eGk5SmliVVk2S2RWT2EzcmFBVnhBTmY3enZmQWxBY0FWN1hEUy9YWi9pWjFJ?=
 =?utf-8?B?YXVaTlEybnF2TjNhRUdJMTNIUlpzdVU0NFRYaXBhOExON2krZEtlWU1IOXdF?=
 =?utf-8?B?WkJLUStwNVBqSTRpQXBHc0R1YW1zNTI2b1VqWEdEK2RNN0pKTDIyV0JBeG0v?=
 =?utf-8?B?bUQrb3pXM0VVZFRBYmJjZDJtSDAvY090VVZXTWFKTjYyZGQxU05hSVVaeUtN?=
 =?utf-8?B?SWVRaUxTV1FwbUY4Ui9EcW9FNGN6eVE2WFdYVUMyc0VGaG4zMWlnazJPVWVT?=
 =?utf-8?B?cFpYUHRvMG5FUGFzOStYdGkwdkJnVVBITlRXZ0w0dFJDb3NiU3FXdGcyYXR0?=
 =?utf-8?B?TEJHQnJCQmh4cCtQRDNYZE9zc0UxUzhhTU9WazRBZzBlZ0RBN0hpTWJJZmph?=
 =?utf-8?B?OTFDdWxtY0dwUU02TStPT2htcm5IWURsMjZHSWFBZjc1bDBpMWVWSTJPYmlB?=
 =?utf-8?B?VmJqZlUyWU54Q3R2MHRLWHVDNVM3dzBMYjY5WnljaGRONkpHb2ovRldJUmdT?=
 =?utf-8?B?YUpnWE5GWU1OanV6Q0cwVE05Wk1xUFdZSDZKWittdk5BSjg2YkNSNHdvcWRh?=
 =?utf-8?B?WllNRWNBYTdDTWNzbTFQNElwUHNPYVNFR1Q2WkNXQnpyZzZXLzU4Um5QZlAy?=
 =?utf-8?B?QVRPd20xeGxmdGRNMW11VE43VzZWUFVBZXlGOHhHbWNzWmJ0eElkTWtCVXcy?=
 =?utf-8?B?cTBQUzZuMlBMTXhhek5aREhYNmxtUlhuT0xDbm50WHZkY090eUxhcWxhaG81?=
 =?utf-8?B?S0lENU9oU3EwcG9iYWoxbWE2NjZuWGNXM28wVDhBWlZIQjZCdWprdDcwNWRx?=
 =?utf-8?B?dGIvU0VXbVY0M1FEb1lvU1B5UVV5a0hwQS9yR1dRNm1GTTNpTXdtdmNhd01w?=
 =?utf-8?B?cGJyYkVXQkZTODdLbzlpenpyRE9GbU9NR3lHdVZOOVZwTXJpZVEvYUtGTUo1?=
 =?utf-8?B?RGQ5czA0ZEpJZm12Ryt2VS9MSlZSM3ltcE9ZYU9ENXBkZHE3eXJ6eC9WalVR?=
 =?utf-8?B?R21nSTlSTGNaQUdncVM1dm81TFZGeXYzQW1qS0kvMy80cGtET0RSQ3BvWFQv?=
 =?utf-8?B?UXRmK0crcWJ0b204amFrSkhkYjZobURYTjhjSnpVeHpEZEFmMXJJeWZOU1Nn?=
 =?utf-8?B?RUNpUnF3aGYxZEZqeXhyTWFsRTAzNisxalRvZU91SjlwbmxJbVdxYWxsRWdn?=
 =?utf-8?B?UkxTd2dUNStXUmJMWDgzczVUbTBIS1ZPeHYyVGMwK3JRQWJEdTR2ODEwLzhU?=
 =?utf-8?B?elgxSjBwQVR3WndmL1JiZk9iY1dvSUVXZkhrK0FabWJHd0tjMCtJN3JObmpT?=
 =?utf-8?B?Y2F5UkQ5TGNSMHQ0RjVQY3pCZmFUcnVCbHFraXlXcDdyekJ1YmtyQ0RyYVNO?=
 =?utf-8?B?QVZ0OFVjTlNYNjVmUnlHSmxTT2p4ZDEwakhrOVRkZm1qZG9UVmNtOXFTT2l5?=
 =?utf-8?B?NEQ4Nk1zcXEwL29PVWlId3JldXpOVmIvT3htYjlrY1lSa1FBSzVVTmNiTDBm?=
 =?utf-8?B?cGluSUlZL3BhQWxDVVZuMHljeFprT2ZaaGRhMGkraFRRc1J1amo3UEpzSnE1?=
 =?utf-8?B?WWF3eWhrOVA3dE82SWpnNE1kSmlmVmdMV2w3S3lpTWRSQnM5dGxhQVB2WGVH?=
 =?utf-8?B?WG5uNTlBYjlHaFBFNXpTYmwrSStDNEg3ZXdEaWlNcEVUUWxxUlNwWGdqNG54?=
 =?utf-8?B?WHUrV245MXRSZCtpMGw4VTBhWjZrYzNUTFNtRXhXaVNqSncrK0EzQkNRR2RX?=
 =?utf-8?B?UEh1RWYzOHF5OFJaMVhib3gvSWQ4N202amtpQUR1ZUV5MVFCZnp5Y2VuaE1B?=
 =?utf-8?B?RG5nSmE4WkZ3K0RRMEwwb2JkdzV4dmZkZ0JFQTZXYTJMS0t6d0wxRWV0WTg2?=
 =?utf-8?B?MUlJY0x4cHk0YnkvU251VFczaDZ4ZHJSRWlPUTErNzhuYTBhUXZNV0Exbm9T?=
 =?utf-8?B?Wkg2NHYvckRKcTZoUlBoL0ZYK0NDVzR4aWRKNHhEM1RwRGI4RkJ0MDRTSWZM?=
 =?utf-8?B?YmhrM3FQck9NOUwrWWdDRFNWMnMzM1NxRGdRcHZSWU9yekVsOG1hdEdRai9y?=
 =?utf-8?B?UzJaekVGM3JLK3F5ZG1yZC9Xd283T1NtT2F3UWI3aGlEa1lVdW84RE1YdnVR?=
 =?utf-8?B?L1FtSWF3MmdSaWJ2bVoxSEdBNG8yL29JRjdJcW1Dd3hFYVBZYXlZMy80L1pX?=
 =?utf-8?B?Q0w0MDZQS1dVNjBHQjJPa3B2bEFsMGVScmZwUTFBTGNiaDRCL1VqcjdQRm9Z?=
 =?utf-8?B?SDhBWW1VQkYzbjE5aFNVVjRwWStpSlVDamwxdEpVL1h1TThCOWZlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5283295b-7bee-40f4-bbf6-08df43adb414
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 06:49:04.1026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xaqg16XXdYpQr4RSUElZttWetYKbUwumVOxyN3PQGJT5R+VxNvbl6mwrzYf3dl3n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130



On 11/14/26 13:56, Marc Kleine-Budde wrote:
> A device bound through driver_override need not match an entry in
> of_match_table. In that case device_get_match_data() returns NULL, but
> xcan_probe() dereferences the result.
> 
> Reject devices without match data before continuing probe.
> 
> Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   drivers/net/can/xilinx_can.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index 43d7f22820b8..bbe6f9662cac 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -1895,6 +1895,8 @@ static int xcan_probe(struct platform_device *pdev)
>   	}
>   
>   	devtype = device_get_match_data(&pdev->dev);
> +	if (!devtype)
> +		return -ENODEV;
>   
>   	hw_tx_max_property = devtype->flags & XCAN_FLAG_TX_MAILBOXES ?
>   			     "tx-mailbox-count" : "tx-fifo-depth";
> 

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
