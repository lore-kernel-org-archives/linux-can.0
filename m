Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9076A46DFF3;
	Mon,  5 Oct 2026 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193623; cv=fail; b=C/oSPAz0ylAgzsqZKbvwlqd+mAoCfWLj9kOOUNcaKz/UbKX4hiVx8uv662elfnKecVBA3Tw20mYEW/NuQyUH3T6KoB9Yp6ds5IPMwhH+O2dtRrY8cAJ+GIWbiHWaZRNNgeytKArxzai4FEwn9VH425ZgoFk6Zc4JoxhUTNL4o3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193623; c=relaxed/simple;
	bh=2l0jYZqkqFrxyxP8Ms8MHvyb6VLipjTwByvtDqrGy+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DybWClHPKW/ZrMH9Jax5TtpcdEBqKiZihWCxjxUqSY5OuaC2P7iGPNikFajkKz5kph3Y6dG0sTN0QgF6bGdMI2EGFv49uh63SkZF4CvXfkFy7xXK6EjmnUTFDDHfEJj8g5Bo8ZIUu7tlUMy3C0h83Ob+8w2LTdm1JPwtzkXYnR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=o/QUOxut; arc=fail smtp.client-ip=40.107.162.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o/QUOxut"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAfWL+v/sOmETlIZSw7lhYh3kSHT32+0k9BONzzBTzolnTePVo83oHiz8hsWTK89ai6QUkBb8L/0mccua/gHJLrZR1yawxSYTSJlRkAbG7IZIxsnz/Q3XCYKQebq9+b6CLuJPs93XMuxXGeDJfLWxJHztiGLsia610yFOxQy3eN/fek5Q/WmtDNXrB+rbrA/Yb/x+dqNqkLvVG9Tm6fhOun0pihevGUKlJdHI9GLTbM2KNNxXpvMquOR+JaU6w9yfe596sjq1ai+l6JuOgbdeMF87t7IZJiJCCm02JoTKmlK6Uf0mKgru9IHOSh8rYOd1GwVkDiRz9cLuKTLJvIDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnvJ6j/wguFIfH6Scgrn9vT2mzZkwGt+NOFOpjlFvYo=;
 b=IWhDrXNc+i0PS6OrnyHHJVGRB0n1ySfkwcNMkxlesdDXTDjwfC1rMuV6CTgdfSt2UjZEums9oWhJ8sfpuKAzn/ujKl2+ShS7Fb7icJIMl8LsHYStCG9sTa6kBKjv3RLj3ZwmPeniWcaoHPVUDvZD7nYB8xR7hzR6BQ0MIAMkoFcTW7A7u1sMjW0acNpKY5JbF2HgHjyYpNRfeHfhO20bbvA10pUrtAhQN2f+9HN+D0XdJmnjGQUS6/C36f3egTi5Y82qEPFr4RPCI4XY8vVwkL/EwCj1jU8K9I23MriPpW3JFgpo5JYQ1aP8O6ycZ+5a0gqrgLUQom5B4xOa5QCSYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnvJ6j/wguFIfH6Scgrn9vT2mzZkwGt+NOFOpjlFvYo=;
 b=o/QUOxutE8tL4sRYMjQgfPtK6FdXDFeQ4EF6neE79AipHnM/Uebkkyf/FilPeDOLixAPBkxZBK5mZZV69n/S8ojRKyE/iqdNtcu7vNxDLeNGNY30tKktkameDjOC3/oim83SM9eXK96L725bjyACVSWPiBwUS9tTdgXU2pFoZwIJOkOhr65+Udemxz/LWbTqXhAv9QVqnMKL86YbyE/h17vjCnDMSIEMbEZeA7Z+hOkcv3hP3+zI4d4d4sOZ7DFuvSEH/meEl4DhWQNmTznQ8AFklXqvasmuxDVXkUOKw2zsbP9gAV8Y+m1C8MbaEvVQxjp0XAYCS62pM9c3/NLpBQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AM9PR04MB8939.eurprd04.prod.outlook.com (2603:10a6:20b:40a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 09:46:47 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 09:46:47 +0000
Message-ID: <46937886-4d3a-499a-a9a5-f1b371fc3fd0@oss.nxp.com>
Date: Mon, 5 Oct 2026 12:46:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] can: rx-offload: allow more than one receive
 source
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de, mailhol@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, haibo.chen@nxp.com,
 linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, s32@nxp.com, imx@lists.linux.dev,
 eballetb@redhat.com, kuba@kernel.org
References: <20261002071203.1287650-4-ciprianmarian.costea@oss.nxp.com>
 <179106338585.1406898.13675590689657020972@kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <179106338585.1406898.13675590689657020972@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AM9PR04MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: c0da0017-b839-4799-b090-08df22c5922d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|19092799006|376014|23010399003|11063799006|5023799004|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	SAPAzT4gdbNSFxYuwReC3BDT7ZwF4dxMxmYMsZOTeMcVleOnYwGliKZMeu4WupK1T7akZsbplHz+/WLDC5q9YdDgN/l+6dq2POgJubAFXBfzbB70UNKTJA85EMgRfwfNxzJSmDnotinzlb7n7Bt+58SNeL90pbFBY+lEn2EIqBvazhTLbCdn/ceFUkqi+WrHv1Ir0jn0B6s0yvnN//WxRZz4V6oKVHTdQLX26JceCaFWhboxvNMyZSXkWprLq4Dq2D2fLIdEeaUijPtfPk+Yd/NWUnum03e5T9aISFeVNMD0RRj2x1kV9rgr71rEGwODXUJJMQ6Kg4HCO5qrpVltt4zNJ1Fsl+T+FxHrf7zPcd58E2Rt0WQAytNlbSUofyQhGE/t6BJBzvKCtUS6GEkbktYysPkfxBKpxS2lW1Tdqbh96YOlxuMdQp8TSnwaDwouFT+gCuTuiuJYXXBmvskawvEvzaLcM6TUeTN6GCDOAZh74pgUIxvG70YPE9g9B4qLrH2JaDBxDRh6AYnKf+LIEuVgV94QTz9RhM9Tx/uTbBGuqudlkWYLD3MVCppfEfN4+xQchTriAvsPzt55QvjkITqW25eEeW0mNF2vlDBECv7k/07WGDn9oKycipX4Iy1R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(19092799006)(376014)(23010399003)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVB5T3lVbVg0TXE5T2RIekw2cis0TWlrOXd4bzdqL1dXRU5abGcrMWNNVWhl?=
 =?utf-8?B?aWNWbkxpWnZYRWZpNUJ6aTB5dWlZaktuSWpjNjFQejE3OWhuMGpjblg2VW5y?=
 =?utf-8?B?QWVJUkFVNHptbWFESzgza2lPcWFCYTRjeXJDTmhjUGxSWitZKzg1dmxBdkls?=
 =?utf-8?B?OWhyRGt2VmtoMFpIZDM4aTJ1bS9kSk5lVVhMVlQ3UFNMUm56NlJwVEVTdW02?=
 =?utf-8?B?WCtJOXl6U1Z1Z0ZQcDVIelN4eUFqVks4ZEZHcFZDODBjR3JKY0ExK3hrNG55?=
 =?utf-8?B?WHNOQVhmMkFGVUovbWFBUVNYaVV3SWNNNm1pZDdPekFMbkxRd3dDbWlIeU1U?=
 =?utf-8?B?d255Vy9rcDdPUDQvenZ6Wnp5Y29WU0Z0Y1FIQzYrdjN5dHAzNnBtZUxsbWdO?=
 =?utf-8?B?bEtxZm5janBBMGV5L090VXdVNUgzY2VjTWRxbUY2bDRDQ21sRUlXdnlyc1lN?=
 =?utf-8?B?WGdCaVZWMXRWQXVtNmFaTDZzb3gvL3BGTTZZcCs2Q0dyMUZmRFhaR1loSjI1?=
 =?utf-8?B?Y2ZoVy9sYnByNHdCUkd6WVhVNmFqQ3RTRm1xUjYvd2E1T3lPVkhtUmlzSlhH?=
 =?utf-8?B?U3cxNHk2ejhnUlhKY0tPUGF0QlhNYkk1alFxaUprWENLVXJTa1ZTemhvV3ZF?=
 =?utf-8?B?THlJWHg0ZEJFb3VqS3lpTTVEbWRUeExBYzRHajREV2pPNjZsSXpVYlRaSWNo?=
 =?utf-8?B?YnEyaU5DUWVSNlNiRlczTlF4UDVRSG03UjRoSVlOT3hlZU5HYkFSUk43Z0ZD?=
 =?utf-8?B?b3NkWTlJVVE5TzZnYll3T3R0Y1dwaGUrMVlwUllrS3l4R2hlbHNPZGJ0Nlhw?=
 =?utf-8?B?T081K1o2aGtsVGhJbm1FZnFOLzU4NVFzaHFKQUVFcGJUSjZLa3JZZnkvVGRV?=
 =?utf-8?B?M21NN1R5SForZC9qcDFHN0RRalg5WlNJQnV5YWZRODlGdmZrMjg1MWI1eVZB?=
 =?utf-8?B?L0lPVEE4cFFydXZ6K1hXN2ZwUFBWVjc5Z0phdFIzRmNMeFlVZFlNbzk4UDVU?=
 =?utf-8?B?TWdYOXQrMEZhNVlhQTUzVDlHdU0raUFnQTVVNkhxb3hMR2haM2k1R1VFWHhh?=
 =?utf-8?B?SG9VWWtnbCswdmhISmhUbjNLTVF0Tlp2K2Z3VjZvNThWdzZ1Mk1LZHFDTE12?=
 =?utf-8?B?NDE4T0g0Yy9MekdRQ2k2ZEU2bEt5N2FvRXRXN3U1WWpRMnRYTVhLbkhHcnBU?=
 =?utf-8?B?K1MvWjZNS2FEd2dCaGJLRCtzYW1Fc1d1cFJVOUpTNWlCYVJ3WjFhME9xdGRi?=
 =?utf-8?B?c3VNQm5VSTMzRnFrNDUwcGJ5RlhwVjJOb285TGFmSk9jUnN4d3c0U2tvdll1?=
 =?utf-8?B?VFlWa2JzZkt0QjA0QVZ2WjdzTkYwWFZYcit3NWZxdU1pcy8weUpCc1lHZHJW?=
 =?utf-8?B?WUU2eDNKYVpRN21IY3pvdm9OVmo0eDI3a0pQZ08yRjB3V3VGV1ZTUTh6WWQy?=
 =?utf-8?B?ZEVqVjk2UkFaTzluanRrdkptVE9XQitJdEZyMHA3VVplR2tlU2hYY3pDbVBK?=
 =?utf-8?B?ZUhYcXhQMUFxb2Y5dlpGZ2Vja29OdEp0dXVGRFoxeHpYTW55Z0ZPdFRRQmty?=
 =?utf-8?B?SGZXZGFNK0h6T0dXeFNZeDhReUE1Z2JaVG4xejVHTXpNNWIzRXdmL3RjNFdO?=
 =?utf-8?B?U24xUnRJYysydTZZaVljeGtrelFOdjArK0ZVaHlKc1kyakt5SnZTR1d0WWda?=
 =?utf-8?B?NUk4bVV4RG92NFJTVDVwbzh2K0lKUUxoam9kbEVDc2pQV2d0Kys5Uk5GUjVV?=
 =?utf-8?B?dEpjK3RrUHdhMkJ5YW51T2c5Q3BJTDJ2MTdiOG0waVo4Ni9qYjlZVjN3eFRx?=
 =?utf-8?B?VUJEWFRZN2VQM2lMR2VZdWlXZ2ZiMlBWdDRhZjAvNHUxMTJySzMrL0xoblll?=
 =?utf-8?B?bi9QV1IxMmZ1RHBvYzVUSi84aDV2bkQ3ek0zeWw5WVBTRWtGVEt5YkM2alFu?=
 =?utf-8?B?a3RLM0Jtd2RwU3crV2pUZ2V1dTFUb09Ia21xWGxTUUFVM0tOSE9uRHpHREhn?=
 =?utf-8?B?N1pLUjFMNWo4ay9KektLQzdoVkFKa3NZeGNFdlFkNE9Balp3MVBJUzd0OVVO?=
 =?utf-8?B?NE02M2lqT3lkMnNBYjJ2aWgzVksrVUxLNTh6b21FbVNVbWkvTkZ6MWMxZkIx?=
 =?utf-8?B?YThRbFdKdHFuWjAybmZCYzZEaFBpUzZGVno1dUNzOUlPd1I3aFpvMS83YStR?=
 =?utf-8?B?eGJlZzF1NW1pMnFtY0FtYXo1bHdzRFNXTDQrNytlYmsxaGtJS2tWcXVmSzBZ?=
 =?utf-8?B?L3F6RndaNC85ejF1dGxWck1JcklaZGIzdExyQU5vRVV2SXV0UGtxNVNNbFA1?=
 =?utf-8?B?N3NYV3VBWGhpYzFUSzdiUHNKR0xMWG14d1FTSG1Sc0lReTR1cE40UDlHOTJk?=
 =?utf-8?Q?q7IhHT3a6utpSVMc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0da0017-b839-4799-b090-08df22c5922d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:46:47.3738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFt9Lx+Nc68MVXKRNnkeaB8VgY2dU8lfDN8hTW+NrVYbDkmy+xIh6wI3JT/15CebhghxA2wBNK+T+WrGVyNI0yI7YGa6QZUy/FNxrQ0cQKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8939

On 10/4/2026 12:36 AM, netdev-bot+sashiko@kernel.org wrote:
> [You don't often get email from netdev-bot+sashiko@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 4 (2)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In can_rx_offload_move_to_skb_queue() the comment says the
>    sorted merge will 'keep the timestamp order over all sources', but it…
> - [Low] Concern: the commit message describes a live S32G2 flexcan bug,
>    but the patch only adds can_rx_offload_add_source() and nothing calls…
> - [Low] can_rx_offload_add_source() calls
>    can_rx_offload_init_mb_range(source, &weight), then never uses the…
> - [Low] queue->sort is set only by can_rx_offload_add_timestamp(), so
>    with several FIFO-mode or manual-mode sources each source's…
> - [Low] can_rx_offload_add_source() does not check whether @source is
>    already linked.
> 
> Pre-existing issues:
> - [Low] This problem wasn't introduced by this patch, but
>    can_rx_offload_init_mb_range() (previously inline in…
> - [Low] This problem wasn't introduced by this patch, but several sources
>    share dev->stats, and can_rx_offload_offload_one(),…
> 
> --
> 
> can: rx-offload: allow more than one receive source
> 
> This commit lets a CAN device have several rx-offload sources, one per
> producer such as an IRQ line. All of them share one can_rx_offload_queue,
> which the primary source owns. A new can_rx_offload_add_source() attaches
> extra sources, and the IRQ finish helpers move each source's skb_irq_queue
> into the shared skb_queue under skb_queue.lock, sorting by timestamp when
> several sources run in timestamp mode.
> 
>> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
>> index 92309ed47bac5..5352d70b6e93c 100644
>> --- a/drivers/net/can/dev/rx-offload.c
>> +++ b/drivers/net/can/dev/rx-offload.c
>> @@ -304,18 +304,40 @@ can_rx_offload_get_echo_skb_queue_tail(struct can_rx_offload *offload,
>>   }
>>   EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_tail);
>>
>> -void can_rx_offload_irq_finish(struct can_rx_offload *offload)
>> +/* Sources may run on different CPUs at the same time, skb_queue.lock
>> + * serializes them.
>> + */
> 
> [Severity: Low]
> This is a pre-existing issue, but the sources also share
> offload->dev->stats. can_rx_offload_offload_one(),
> can_rx_offload_get_echo_skb_queue_timestamp() and
> can_rx_offload_get_echo_skb_queue_tail() update these counters with plain
> increments from IRQ context:
> 
> drivers/net/can/dev/rx-offload.c:can_rx_offload_offload_one() {
>      ...
>          if (IS_ERR(skb)) {
>                  offload->dev->stats.rx_dropped++;
>                  offload->dev->stats.rx_fifo_errors++;
>      ...
> }
> 
> When sources run on different CPUs, can these increments get lost?
> 
> flexcan already ran these helpers from several IRQ lines at once before
> this series. The only effect is slightly wrong drop and error counters.
> 

Pre-existing issue. I do not target it in this series.

>> +static void can_rx_offload_move_to_skb_queue(struct can_rx_offload *offload)
>>   {
>>        struct can_rx_offload_queue *queue = offload->queue;
>>        unsigned long flags;
>> +
>> +     spin_lock_irqsave(&queue->skb_queue.lock, flags);
>> +
>> +     if (queue->source_cnt > 1 && queue->sort) {
>> +             /* keep the timestamp order over all sources */
>> +             struct sk_buff *skb;
>> +
>> +             while ((skb = __skb_dequeue(&offload->skb_irq_queue)))
>> +                     __skb_queue_add_sort(&queue->skb_queue, skb,
>> +                                          can_rx_offload_compare);
> 
> [Severity: Medium]
> Does this really keep the timestamp order over all sources?
> 
> __skb_queue_add_sort() only orders the frames that are in queue->skb_queue
> at the moment of the merge. can_rx_offload_napi_poll() drains that queue
> independently of the producers:
> 
> drivers/net/can/dev/rx-offload.c:can_rx_offload_napi_poll() {
>      ...
>          while ((work_done < quota) &&
>                 (skb = skb_dequeue(&queue->skb_queue))) {
>                  ...
>                  netif_receive_skb(skb);
>          }
>      ...
> }
> 
> With two sources on different CPUs:
> 
> CPU0 (source A)                  CPU1 (source B)
>                                   reads frame ts=10 into skb_irq_queue
>                                   still busy in RX loop, TX complete or
>                                   ESR handling
> reads frame ts=20
> can_rx_offload_irq_finish()
>    merges ts=20, napi_schedule()
> NAPI delivers ts=20
>                                   can_rx_offload_irq_finish()
>                                     merges ts=10
> NAPI delivers ts=10
> 
> Can CAN frames reach the stack out of timestamp order this way?
> 
> With the next patch in the series, S32G2 in timestamp mode runs all four
> flexcan sources through flexcan_irq() concurrently. That configuration
> meets the queue->source_cnt > 1 && queue->sort condition.
> 
> skb_queue.lock only serializes the list manipulation. Nothing holds back
> delivery until the other sources have merged their older frames.
> 
> If full ordering isn't achievable here, should the comment and the commit
> message describe the narrower guarantee?
> 

I agree the comment overstates the order guarantee.
The merge orders a source's frames only against those still in
skb_queue. But before this series, the concurrent handlers could corrupt
the shared skb_irq_queue, so there was no ordering guarantee then
either.

In v8 I'll change the comment and the commit message to describe this 
narrower guarantee.

>> +     } else {
>> +             skb_queue_splice_tail_init(&offload->skb_irq_queue,
>> +                                        &queue->skb_queue);
>> +     }
> 
> [Severity: Low]
> Only can_rx_offload_add_timestamp() sets queue->sort. With several
> FIFO-mode or manual-mode sources, each skb_irq_queue is therefore just
> appended here. That happens even when a driver ordered its frames with
> can_rx_offload_queue_timestamp().
> 
> The commit message documents this ("Otherwise they append it").
> 
> At the end of the series, the only in-tree FIFO multi-source user is
> flexcan on mcf5441x (FLEXCAN_QUIRK_NR_IRQ_3). That part is uniprocessor
> m68k, so its handlers never run in parallel.
> 
> Would it make sense to state in the kerneldoc of
> can_rx_offload_add_source() that ordering across sources is not kept in
> FIFO and manual mode, for future SMP users?
> 

Agree. I will add such clarification comment in v8.

> [ ... ]
> 
>> @@ -350,6 +369,16 @@ void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
>>   }
>>   EXPORT_SYMBOL_GPL(can_rx_offload_threaded_irq_finish);
>>
>> +static void can_rx_offload_link_source(struct can_rx_offload_queue *queue,
>> +                                    struct can_rx_offload *offload)
>> +{
>> +     offload->queue = queue;
>> +     __skb_queue_head_init(&offload->skb_irq_queue);
>> +
>> +     list_add_tail(&offload->node, &queue->sources);
>> +     queue->source_cnt++;
>> +}
> 
> [Severity: Low]
> Nothing here checks whether offload is already on a sources list.
> 
> Suppose can_rx_offload_add_source() is called twice for the same source
> with no can_rx_offload_del() in between. Wouldn't that reinitialize a live
> skb_irq_queue, count the source twice in source_cnt, and call
> list_add_tail() on a node that is already linked? The node could end up
> pointing at itself, and then the list_for_each_entry_safe() loop in
> can_rx_offload_del() would never finish.
> 
> No in-tree path does this. At the end of the series, flexcan calls
> can_rx_offload_del(&priv->offload) in flexcan_close() and on every failure
> path before flexcan_open() adds the sources again. can_rx_offload_init_queue()
> also resets the list.
> 
> Would a defensive check against adding the same source twice be worth
> having?

Adding a source twice I consider it to be a driver bug, but the check is 
cheap, so I'll add one in v8.

> 
> [ ... ]
> 
>> @@ -357,41 +386,65 @@ static int can_rx_offload_init_queue(struct net_device *dev,
> 
> [ ... ]
> 
>> -int can_rx_offload_add_timestamp(struct net_device *dev,
>> -                              struct can_rx_offload *offload)
>> +static int can_rx_offload_init_mb_range(struct can_rx_offload *offload,
>> +                                     unsigned int *weight)
>>   {
>> -     unsigned int weight;
>> -
>>        if (offload->mb_first > BITS_PER_LONG_LONG ||
>> -         offload->mb_last > BITS_PER_LONG_LONG || !offload->mailbox_read)
>> +         offload->mb_last > BITS_PER_LONG_LONG)
>>                return -EINVAL;
> 
> [Severity: Low]
> This isn't a bug introduced by this patch, but the bound check moved here
> accepts mb_first or mb_last equal to BITS_PER_LONG_LONG (64).
> can_rx_offload_irq_offload_timestamp() walks the range inclusively and
> does:
> 
>                  if (!(pending & BIT_ULL(i)))
>                          continue;
> 
> so i == 64 would be an out-of-range shift. Should these checks use >=?
> 
> No in-tree driver passes 64 today. flexcan uses mb_count - 2, at91 uses
> rx_last, and ti_hecc uses at most HECC_MAX_MAILBOXES - 1.
> 

This is pre-existing, but valid.
I'll fix it as a separate patch in v8.

> [ ... ]
> 
>> @@ -416,6 +469,46 @@ int can_rx_offload_add_manual(struct net_device *dev,
>>   }
>>   EXPORT_SYMBOL_GPL(can_rx_offload_add_manual);
>>
>> +/**
> 
> [ ... ]
> 
>> +int can_rx_offload_add_source(struct can_rx_offload *primary,
>> +                           struct can_rx_offload *source)
>> +{
> 
> [Severity: Low]
> This isn't a bug, but the commit message describes a live S32G2 flexcan
> problem, while nothing in this commit calls can_rx_offload_add_source()
> and there is no Fixes: tag.
> 
> This is resolved later in the series. The next patch, "can: flexcan: use
> one rx-offload source per IRQ line", does the following:
> 
> - adds the extra sources in flexcan_rx_offload_setup()
> - picks the source per IRQ via flexcan_get_offload()
> - switches flexcan_mailbox_read() to netdev_priv(offload->dev)
> - carries Fixes: 8503a4b1a24d ("can: flexcan: add NXP S32G2/S32G3 SoC
>    support")
> 
> So adding the infrastructure first and the user next looks fine.
> 

Yes, this is intended. This patch adds the infrastructure and the next 
patch converts flexcan driver to use it, along with the Fixes tag.

I will add info that the next patch converts flexcan into this commit 
message in order to add more clarity.

>> +     struct can_rx_offload_queue *queue = primary->queue;
>> +     unsigned int weight;
>> +     int err;
>> +
>> +     if (queue != &primary->own_queue || !queue->source_cnt ||
>> +         source == primary)
>> +             return -EINVAL;
>> +
>> +     if (queue->sort) {
>> +             err = can_rx_offload_init_mb_range(source, &weight);
>> +             if (err)
>> +                     return err;
>> +     }
>> +
>> +     source->dev = primary->dev;
>> +     source->mailbox_read = primary->mailbox_read;
>> +     source->skb_queue_len_max = primary->skb_queue_len_max;
> 
> [Severity: Low]
> The weight that can_rx_offload_init_mb_range() computes for source is
> never used. skb_queue_len_max is copied from the primary, and the shared
> NAPI weight is not adjusted. So the drop limit and the NAPI weight depend
> only on the primary's mailbox range.
> 
> This matches the commit message ("inherits the mode, netdev, queue length
> limit and mailbox_read() of the primary"). Later in the series,
> flexcan_rx_offload_add_source() copies the primary's mb_first and mb_last
> into every source, so the limit fits there.
> 
> A driver that split its mailboxes into a small primary range and a larger
> secondary range would get an undersized shared limit, though.
> 
> Should the unused weight be dropped, or is it meant to feed into
> skb_queue_len_max?

The NAPI weight and skb_queue_len_max belong to the shared queue, which
the primary has already sized. A source only needs the range check and
'inc'.

The flexcan driver gives every source the entire RX mailbox range, so 
there is no range split issue.

I'll drop the unused weight for source in v8.

pw-bot: cr

> 
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002071203.1287650-1-ciprianmarian.costea%40oss.nxp.com

