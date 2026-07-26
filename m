Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5E4346E54
	for <linux-can@vger.kernel.org>; Sun, 26 Jul 2026 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785036402; cv=fail; b=gxS+u+dzDb/qM/Zycw8a4cf+2KTX30mQ/cwwIWNjx843GOkC1Efng9pqOMqccTzTJpTNm1D8Jl4XY91/eiM4KNtvDcfos/QdBEmc2MxqgGfVwHR/q2cwuGbEG+Wr8pLtHIWDUPraRmea3Mjaf32cmFXqNXG53v+L4x1sGLzyLJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785036402; c=relaxed/simple;
	bh=9Jv4hJQJSjmw2rxc/dk4RhDwbxC33khzJDF4nGUvPjc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dVuBHNRfBT6FrNUhFFvmdatrQhf25u5oaOEPqT+4uI/+j5lPOIzLzX/lnw1WmxQWUi6AHQFK8WxLKto4QvXNdt49mhEuqqiivWNtLCQwO4ju+6ki0YFCeIlYD8cmcz74HC5rUKKr6p/v3Mc6DzJ/ESspwzDQC2W0snPIPFHh2+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=XXNAJuau; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="XXNAJuau"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q3A2QP1471758;
	Sat, 25 Jul 2026 20:25:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=wy+fTqLRIZbCYfLwoJ9yfU5oBPC0t0LfvK8uwoR6a7s=; b=
	XXNAJuaukCcO6z/VESLydDv0t13VjW9h2SJoOf/0rUKfdim8vKQtMOHNBduTSQP0
	qcunQ5DgTihWpHyjIE/QBoqWjdGnJNcsNBiOj44WeL5pZzbzQE+nZJN9kzacm5uL
	AlPOOzXWDkDd0gLEJtu2ZPtiqzVeQJZof7664he6ZcZweVDrVYEl0hwwqkVKqc/c
	QA1Zjbnk+XGAZkBykks2obZgUTbNR9gVLya4pfuNxxFsIwj0CKH0ktEW+ko13olP
	iLQpPVpQRA2N8yLXcnvAWdA19VV82t6TwKBSfuEe94AwgfQg7k8NDlNjwc9qqIRL
	fPn5aKfUGfeTXIb5UT9+pg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fmvnf0eps-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 20:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP08Ro8tP/RXer7qZM6k9aiG/zMcXgx/XPZxrvI8jN7s5z0M8uTFIT5+DaofYXH5kOsk3mS/NaLEdQDwV4rnO++sE6KCpSoIgSpq/fdvohZPhQp4mSirFegeH7WIdbXKo8xXIlwagBANWOrvfZB5uZFjhH0lP6jD/XOMMlF2HpGvre5cXAHN7RMY6dRV/N2IHyhqCMWow/iQZC5ByekipTErtajcf2gXuI4rFpzzcfnmJ0/MEKb8ma4KP8xZ2Od/CU5SEZDXhXwQb1DqatQ14qfs9+S8qKWuMxRUbYfc7EVwulYl4l5gvBAg+zU7mTV3bfd6PIoPHxHrh6iDhzxB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wy+fTqLRIZbCYfLwoJ9yfU5oBPC0t0LfvK8uwoR6a7s=;
 b=j/5amlugnAfbn7gI6fyJinTiR2BPb/QBko9H8S5iDCi2kAEce+i6jygF6nf2eLRbXpG6I2gku8ZUFKekc/d/1jWmbqwpZhOjpzOSyJDt40PZanEUDPmUxnW0HKtj1srF0vXIKZRZ8QXwhqDPe4W+j9KgMFswt6ozbyNUHY7/QvQtvf/W3dI2ipSjViFvDVH6chxgeitmtRJ1oxyZZ5/rO1bXaR01pCGOEJI4GtZjGy7yjEwYewSsFdj1NRnmYtbTk+K+qhqMb2bfPO5ITqcpcm7Uv2dpbv4vEOtybQ8FV2dlLVFCnVE9uvLBr+9LjiuybV6ODd162pGemzr7eCq9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by IA0PR11MB8398.namprd11.prod.outlook.com (2603:10b6:208:487::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Sun, 26 Jul
 2026 03:25:49 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 03:25:49 +0000
Message-ID: <3894bbdd-1930-4ad4-8b28-431a162aece0@windriver.com>
Date: Sun, 26 Jul 2026 11:25:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tty: ldisc: fix deadlock between ldisc_sem and
 rtnl_mutex
To: sashiko-reviews@lists.linux.dev
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Vincent Mailhol <mailhol@kernel.org>
References: <20260724084648.3879356-1-yun.zhou@windriver.com>
 <20260725084748.C82601F00A3A@smtp.kernel.org>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260725084748.C82601F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|IA0PR11MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a1e315-b8d9-45c5-33bd-08deeac59642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|4143699003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	K0WRmF3kR7w9Nu8ZoYGayIdifJ98cuF9FwGPCO0QZYMOYHo0YS/eNcb92k51FYtCVD3HvquO/Juk/cu7O8Dh6tuT01fOoloUpNTNMFWcxvQiZgkUFDLI6FjtuFsgJNFopurXCmr55ri6s/2cPzftQn/emjmF88Kwrkb8fkQBfQKf3Ouz1p7Dm6o7/exT6vDHn81KJIYF7rO0lGCdTP/MHVJxmMgzvAnyCIzTormN/XTYxFBLtRRlDR8EtIaB4wRs+PQd4ck3fmMTPz3UVgG5+5NFaOucBs9vMGnUx3IdGGt0XAwLTrH1tOSyGfBkuNy0yw7hiIhxwYXmk6UtRAYHE11jv45yHGSattjHDelYrclkZWATTeOEsJDL08MPyowqz35fHblAomiHExTLoWJAB9iT/Mo8auWR48QLovnSfRzcAa/0yaEb6qnmYNhssFOaHkxiUTHJVY+3YbwGLP9gXNjxeIKwqk0c4E3FYoHuO+lViBlc4VWK12EI64jErQe/XHJxxe6SvDBkJjJpR8sAY18iTGSMJVJUUOCT6jO6dKrbQCtxCX1xkI6BRBKM7SRC1O/+O1Kc/ynvhRf373X2coAqkopnanktJatLHz3XaLc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0M2LzhOUHFZdWt4M0UxOGpoTE50U3NUVUJiTEdUZmo2c3FKTm5tMjlTd090?=
 =?utf-8?B?RjkxcWlwSHZYL1pZTDVFUS8vcDFRb2ZMTVJYMmxyUTNUck9waHIwaUNza0g1?=
 =?utf-8?B?c2g3amljNDQxQmNtcUREbEdWSTNCeXcycmttazdaRzlYd0hSZ0VLcHNDaFZG?=
 =?utf-8?B?Q2ordzUvNlhSeU5TN1dPT0prRlY3NGJ6STlBcHd2MmpSaE5mT3hxUWc3MkNy?=
 =?utf-8?B?ZVl3UUtEUlQzM3U1OVJDaC9uNGEwL0JzcmF2aW5kNmRpeEwzRVVWNlBYS3Ez?=
 =?utf-8?B?VEhybzVnb2xUc2lVa3IyRGk5VU5zY24vNGlRRnVoNng5a1NEaXFObnR5MkZJ?=
 =?utf-8?B?WTlnMVVLWjE4eVBVZDA0ZE5nblNoTkhlWXlaVXhQdXA1aGRKbVM5NGliQVRQ?=
 =?utf-8?B?a3hkQzNyNDA5NVRvVGtjZy90QnNQUXRrTWp5a3lPRDFQUG05aktXS3BRN3pQ?=
 =?utf-8?B?ajJ0TVNUMlE2TTA5RFVwQi9VY0J0SjRjRGVGTlBVQ1F2TmNMM3JFVzR3R1NB?=
 =?utf-8?B?Nm1KcnVpbmtnMXlkZDM3cCtsM29wOE9ncS8wb2VIbUpaRFlSWll6R2ZQbFpI?=
 =?utf-8?B?VkcyL0xDUlF5YWl5aVRKTWRzVlpqQ2xFdVJ6QnRPT1J0UG9qSHVQWkdKUU10?=
 =?utf-8?B?b3EvRlNFQXRVWWRnSGw0NHBxeGRlNTk0QkQzT3ljOUdIeHc3S3E0RzFaVFk3?=
 =?utf-8?B?WVVuRkxUOVVRNVlEOU5WbUI1NnpZOVNYZldLMGoyWVkvSEY4NjVlVm4vQzJs?=
 =?utf-8?B?eFFTaUJkTHJrc3p3eUY1YjFLcFBUSFMxR1poRHhpcTlsNjlZdHcwMWFrNHJq?=
 =?utf-8?B?NkF5N3pwQ3JHSXJYbVJOVkN6RVFkZFdRRFR3Z21FYXEveG5jVnJWZ3VIT2sw?=
 =?utf-8?B?bVBWWnRKMk9OV2xQRG5nY1ZkSThzOE5QTHU3UUVPMkRzMWxFZ2xlTmRNcUpy?=
 =?utf-8?B?TzduTFB0OHljaU5RdE5GTE9GTDdYU04rUnZBaHkyRTc2Q3ZlOHk5alFnUm9W?=
 =?utf-8?B?MERmSW43M0d6eEhPN3EyT2I0cVRCTkRIZVBTWUQwcGx2alUvUTd0MFE1OWUr?=
 =?utf-8?B?NHp5dU9qTWYzWEFXbWhyOVBBR29yMERrM2NuSFRzdjZSM3UweS95VVZsMDJl?=
 =?utf-8?B?WmRGQzhud0ZidEE3MEZMTzZHRDAvWWpybjZXTlFQTFN4bG9mTGN6cWVmcjNN?=
 =?utf-8?B?U0E4VWhhTDA0RlVhc25yOG1zb1ZnTGtmMTVVcXlvdkdiNi81U1FFM3Fjb0hv?=
 =?utf-8?B?cnNVQXFsYkd5dUovd2pVQXNTSmtzZnl6N0tYTHNrWHUyNk1paDZOOWNmQ242?=
 =?utf-8?B?aGVmZlN1ZFJQZlozcTJVZnM5alFZbE1MUFZvN2tacXkrQUNEWk5NSHk5R3FM?=
 =?utf-8?B?VytZR0krN2gzb09rcXBCazkxY1laRFVmRU1KOVlXOStudVh1RHF5TVlDNENC?=
 =?utf-8?B?b2p3MUZDM3dBbGcwZmlKbThtYWU3V1FhdU9ZY2xnZ3BBajRiOUdBVFFlcm5I?=
 =?utf-8?B?eWR4cjNqZ3FkQ3lOWlB1T0JWdSs2NVdadytkTW4vVENZWnY0UDlYZW4yREEr?=
 =?utf-8?B?eXVHbGN2ZGlxQU1iaHNoMWNEWFhudmlwMThNcVh0M3grdXNGcjQ0WXpLcExq?=
 =?utf-8?B?Wmx3Z0dMK29ING9RU0ZDMEJ5YUozWHgxYzRycG5IWnMxL2dxeTUwZ2VxNjBX?=
 =?utf-8?B?L1FIKzlyQ3ZIaGpsd25sMm1iYWlQaTZ1SkZvYTB0ZlQ2UWs3dkgvN2JGZktB?=
 =?utf-8?B?dUQ3T3pvKzBobWkyUS9WN25jcUJKbGFQRnBJcWJxTE5pR1ZVQlowTkl4Vnhk?=
 =?utf-8?B?L2JheVY1Y0YvMEtQdWkxVEVPU2x3MWlnS0xXdjZuZ3hWM2cxODNlOFR4bmhP?=
 =?utf-8?B?WURNTFIySTNnOCs2L0tIRXZ4THVwRVV0U2c3N3RwSG9yZmRPdSs2YUZPRWxt?=
 =?utf-8?B?M3oxZUFwcmdETDVldWQ0SGEvNlQzWWlxS3FNa3FHb0wvbUdOb0xMN2YvTGhR?=
 =?utf-8?B?OVJWSTJIN3E5NVN1L1pGUDU4Y1F6VnlRUmExc1p0Wm5xdGtYZU52cmRGN28z?=
 =?utf-8?B?V1pSeUdNWktISWhFUm1uOVkzVkk2U1dpOVE4Z29ldisxWi9nUS9vdmZIUmxU?=
 =?utf-8?B?cjhJTjFJT0pKSnAyUERMbnZjTUVFMWJtM05vMHovM3BTbjdUODVOS2IvNEFC?=
 =?utf-8?B?WG5MMzJQME9mUnVQK3hPbmFoZWR1ODg3TUdFSHdtTS96RGl0aDNXV0llSUpC?=
 =?utf-8?B?T3lqRGJLNGFOZjlpTms0N1RyMEN4eVk1Y2pMZUphL2Y5S1Z6ODh4NHF1VytB?=
 =?utf-8?B?cHZWMHdpb09IQTg0azgvTEprU3kyQVYzTGgzaUpPdFRGcVBJZTFBUT09?=
X-Exchange-RoutingPolicyChecked:
	CcYaxwY57RqPxfGdUAasifD8zmRoP4zdW+T+F22ee9m8c9eXI1Nxf4uVgqGtLgwGE21Ls3AshlVVm6YOOs1mm8Wp6PxSZevQJ+AEqLyFDEDuBgQUMpmFf/+tXPgGsvWGm5gD5QspfwvDCyexF7M7fVBI5LWVQ4mxEOr0KCUEVYwml8UytnOY773D+J6vXEkcAKvWRKP49N8/jjTLZvhlywZvQAIWTm0rJCrVjeWeiUMZ+tF9BExA4X41HZjQrMYHT3OJnOL5UMW1Ha+Do44k8eUIxZ7BsKC6Lc1MAdfRrQjz6AS0iYtSipGZvcbZXj4uAuGZYZaamHz6vvx1T5jqIQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a1e315-b8d9-45c5-33bd-08deeac59642
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 03:25:49.1000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANClfwSeOuSoWud5f2IXBCfh0BV3glFRadNzknkOpMckRCNfxdVSPwxAYAlmIVyr+oeZ9QZzwcE4H6ZPdBIe6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8398
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDAzMCBTYWx0ZWRfXyjvWHWe5v1iM
 wI7J0vtjcnnIYO6v73XeIfT11h9Y5h8n8xdcvjTy7SWWIK4K/wPJuaVB11KThiFl4Ep7VKVDoFa
 6zsT/jY+85q9p3+iXExTy561H0muDWJDjAzeE3/onlpwAwg6Mro8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDAzMCBTYWx0ZWRfX5Ax5Wy4/pQMX
 nHJF6ESiyolKEPKMNmubA1IDiO95BouDPALNK2xOIZu0HpjCa0OX/rMS35wOgZgykNSfZfubsQi
 rZgYflqKyVFHLaA5UoROhXgVIMZ62yiBxMeHBmAeb6xYfR49PFcelvJUeV0WJX+S3kljbwVQoR1
 paGEMgWG8mdd54suLH0d1HlVqLUlRaas6OJ1r11Knu22D8ADSXCXM9r81pbYb4dYsJmK0wU5+Lz
 6A4AkufEbx4uast6UnYODFWcteJfv8kfri/chd+P1BZmNW7gY868XW0cE08xvnBuf0j7NO0qxlQ
 PK4FSXXjuqYB00AmRHu4514brcH0e0WP7jwrPzP29xMeOAGoVQa7lVR5FQB01FSLHMuL39Rqi/Z
 ZjTUZ5FClQCJ+jWYkKrTMs5IS6ncw4pIwA9MuBdwLk4JGxJAGtGiO30ppxqnrSqudMjCe3OZ6EO
 F732QK7WC4GIEqCGkcA==
X-Proofpoint-GUID: mAqQ3QCPLYT29RecMPiu0PaXlmbKq9ah
X-Authority-Analysis: v=2.4 cv=M7x97Sws c=1 sm=1 tr=0 ts=6a657e41 cx=c_pps
 a=oxxrQmGkUFFO/gDwv9AvRA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=ERVMgzBrPe5e4UrgZ1QA:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: mAqQ3QCPLYT29RecMPiu0PaXlmbKq9ah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_07,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260030

On 7/25/2026 4:47 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] The patch replaces a lockdep splat with a silent waitqueue deadlock on the success path.
> 
> Pre-existing issues:
> - [High] Incomplete fix for circular locking between ldisc_sem and rtnl_mutex, leaving deadlocks on teardown, error, and hangup paths.
> --
> 
> --- Patch [1]: [PATCH v3] tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex ---
> commit 98cde28b47f83f4a2bf71bb1e35f53d9a7a36294
> Author: Yun Zhou <yun.zhou@windriver.com>
> 
> tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex
> 
> This commit attempts to fix a circular lock dependency between ldisc_sem
> and rtnl_mutex reported by syzbot. It moves the tty line discipline .open()
> callback outside the ldisc_sem write lock in tty_set_ldisc(). It also adds
> logic in tty_ldisc_ref_wait() to wait for the ldisc transition to complete.
> 
> Closes: https://syzkaller.appspot.com/bug?extid=de610eeef174bd59a8a3
> 
>> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
>> index 27fe8236f6623..6ec93e6b84988 100644
>> --- a/drivers/tty/tty_ldisc.c
>> +++ b/drivers/tty/tty_ldisc.c
>> @@ -242,6 +242,16 @@ struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *tty)
>>
>>        ldsem_down_read(&tty->ldisc_sem, MAX_SCHEDULE_TIMEOUT);
>>        ld = tty->ldisc;
>> +     while (!ld && !test_bit(TTY_HUPPED, &tty->flags)) {
>> +             ldsem_up_read(&tty->ldisc_sem);
>> +
>> +             /* ldisc may be NULL during a discipline switch; wait and retry */
>> +             wait_event(tty->read_wait,
>> +                        READ_ONCE(tty->ldisc) != NULL ||
>> +                        test_bit(TTY_HUPPED, &tty->flags));
> 
> [Severity: High]
> Does this wait_event() create a silent waitqueue deadlock that replaces the
> lockdep splat?
> 
> If thread A switches to a network ldisc like slcan, it will set tty->ldisc
> to NULL in tty_set_ldisc() and drop ldisc_sem, but then block waiting for
> rtnl_mutex in the .open() callback.
> 
> Concurrently, if thread B already holds rtnl_mutex and calls tty_poll(),
> it enters tty_ldisc_ref_wait() here. Thread B will observe tty->ldisc as NULL
> and block uninterruptibly in this wait_event(), waiting for thread A to
> re-assign tty->ldisc.
> 

No, this scenario does not exist. tty_poll() is only called from 
userspace poll/epoll/select paths, which never hold rtnl_mutex. And All 
callers of tty_ldisc_ref_wait() are userspace entry points: 
tty_read/tty_write/tty_poll/tty_ioctl/tty_open/tty_show_fdinfo/paste_selection/tty_perform_flush. 
None of these are reachable from any code path that holds rtnl_mutex.

> Since thread A is blocked waiting for thread B to release rtnl_mutex,
> will both threads hang forever without a lockdep warning?
> 

