Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795424507;
	b=0XLNb6sw3Uhk4tfj41jehafvvX03zj2iO//L0/jicDtD/ofzNBPoBlkbcXQFawvsn+MG
	 UC8CSSJtu0LRgWd7/fk7yF/ryOGEQUp7sDb8JDAGik3rrIqTPK5qsk0fxmILGA9khnYp7
	 ZZj42AwWa1CFFTfXwMv9V7MGaUc8vKjO18x2XU0NqSUhO4DYgb+w1+IhSuulJe8yqQvXG
	 dTNyNDpSKnTARZ1rIpiCqNcpgFPM9vxLx1OiifaDhs9QazaUx35SBUn/pMhQKWgWOZfP6
	 LfNDJHAAjel5/rVgbHZvBpdkOCV/KHUydf8HVodqlLyBXfggJVIp36f7ce0Ei2fZSow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424507;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Ev0lJDXMUQjyehKfMryLspXHYCyMHgoZW6Nir8JJli8=;
	b=kO3eV7JwMWVOAODcHFDwMKE85tgKjQM0MgydlK3T5ZHaKhSvXVtMng+vP2AMEhZUehJZ
	 joT3iNQWHSMrNI7slfvCQ6zU80fQ/utTRf2HRlLc4XghicfjfVOHZMt3jxoosA+rcVL7i
	 3bLgFjik4a/h+fNKmZq3EEoADsRsz7+7bjMrCrs7zLVBdKsqMgYldvfSK5VTx3XEkvIxE
	 nJ8yJQItKJvzDbVhWl2nb6oFrgQR7XQERYuQCXgG+4VjTm8Of3nitTI3Vk7aIQD9E1r3t
	 kL+PLJmn1std216KCx133JO2L0jnXzK0u70perfpzLQAAgYTg6IR4erOv5uz9xBsi8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=obq+ENuI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.9
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012009.outbound.protection.outlook.com [52.103.14.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D1D606A31A
	for <linux-can@vger.kernel.org>; Mon, 23 Nov 2026 09:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D1D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=obq+ENuI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6DgQYR4wmItZgM4y3MT9mMLrWGyjaacT1+s9jOhvLjKoCS/CTnBWkvISIL8OIxqnbbuESkTC32jFd4SBG/AwhryI1j+mY7rVXkcFXAIA2Kvkb/HFTYZuiOEZgko1ZKRb+/Gz+GiAF4YKG7zVS292UnvT8aIHJfoj/s57sJsfAJwQAa+EwMd/zwDPahoYIK6w6gdA/lMtvwTbPxeVRCA2z79YZLLD5wc9JtPIJCJ3pXzfkA0rIXGiHTHsk7S2KTfv9I0MknMSPEHNYf16K85OyviImgpLBuzpmulFzKug29qCtTw2ibjc1D0h1qDDZ2ivIPz1vaBQ/M2N894d3MjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ev0lJDXMUQjyehKfMryLspXHYCyMHgoZW6Nir8JJli8=;
 b=Xr75mJhh0WjWye0uFF5QrMTYzXidzmp117Lh8gvs54kvzhNVqZUiklsl1xNZjGt5yzVde2HeLJKQuvZc/4rWksDZUhSM1uiNgUyKm26JNheEwgmVOJxwhkMcDNlGd1Yq6WgIrgL1KM6jAUNd/oLUmRh0He5y2z0N0tcD/qZtqNsCa/vIItF7MgioxlELpqxNvAzTPCFhxZbuzCF/GtaxpeNJ5waXz+pNnz1OOKoO5nJeKKuYpc0icYs9UojrHrp6gjkoNFBJj0c/pRSvjAsJbHljIZxV3wFpLtT/zIYZdoqnnCBjawV5yQBZxwbiDWXEGK1ifBfuP2VQ2lS9HMgS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev0lJDXMUQjyehKfMryLspXHYCyMHgoZW6Nir8JJli8=;
 b=obq+ENuIIKQ301cTQLTvZ2zQDnak9H5ahLzhS9SAsOS5vNTWq2Cx4O1x7arUjy/Q1aiRKgqIfGs9Zh5G+wRQ8NX0T268cI97TDaT/OA+Rs+PR20zwi0Us6bRtyeRZ/ecCttdO6r+KhrLOiFopJUoTxGeg7V2IW3v+epHtEpTeadLGAIUgXDDd+YMx/nCXrVfSF4nVGUf7ncn7mKD0VlsKafS6fnj8wYa0MNO7HV17Lj131CgQbfOCStTyuvK5qgOHwJXgO/HvF+KGApic1O5c/OjLNa/+3FsenVTfvzlxLwUcKZzx7SLTKYW/dmsnVw9V3PzOLhJ90X7bQyTLRJ46Q==
Received: from BN8PR06MB6177.namprd06.prod.outlook.com (2603:10b6:408:4d::27)
 by PH7PR06MB8996.namprd06.prod.outlook.com (2603:10b6:510:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 09:01:44 +0000
Received: from BN8PR06MB6177.namprd06.prod.outlook.com
 ([fe80::859d:df4a:66a3:142f]) by BN8PR06MB6177.namprd06.prod.outlook.com
 ([fe80::859d:df4a:66a3:142f%3]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 09:01:43 +0000
From: b.lane130@outlook.com
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	s.grosjean@peak-system.fr,
	wg@grandegger.com
Cc: linux-can@vger.kernel.org,
	Bruce Lane <b.lane130@outlook.com>
Subject: [PATCH] can: peak_pci: fix UAF and leak of PCIeC resources
Date: Mon, 23 Nov 2026 17:01:24 +0800
Message-ID:
 <BN8PR06MB6177DC485B9CA4729F930DBDA4452@BN8PR06MB6177.namprd06.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0033.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::8) To BN8PR06MB6177.namprd06.prod.outlook.com
 (2603:10b6:408:4d::27)
X-Microsoft-Original-Message-ID:
 <20261123090124.2055609-1-b.lane130@outlook.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR06MB6177:EE_|PH7PR06MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a1829e-e5ee-4c76-dbae-08df494064b4
X-MS-Exchange-SLBlob-MailProps:
	5fu/r660v9Mj6U6kz+12O9pZy2TuKGHD3PxhaizLDBzdQESnqLP0hdx/OpCB0fQWOX4NPLk8frU8ZkizKIsMhXCQTloJDsAQu0AajDL+stauFPXvqSESJ0bQCyq8NE3O4GRT/7i1lGFIGgwBfJ7M+GwJUnGGbhv2bZBnqXrUpewWMhsD2xz0D2g+RI9Fg4VtYWqvw5N2ITELcSHFdIKsxkElIZyz5W5jtIRPUrbbxcsNaLQdTSR8QunnG4PzuZZrJxRpYNMweIZfKwlqqc5vuROBoTLL8/kJiH6gpniSePF9jnO5leHogWdYWHHc8mzR0VgAcLBS9RGL0Y+7NwLlcMBsCktMPdNIGpMh2kTZeCqXY7QLZVuArl+5/qK0QvxBGJgLiGs4iUjC0pyMYwXiHYoPoko+BVnVLtjXMsjNDt50x9kvh/oOQ/6EBK3xyOF691kSf3KJAPmkEdllp+mjICct5b4YlQWkZWStsz1VcPhRFAL9SWol0BZlvALXL68ND0IdvJjmDZ+EGsM0UGGxjH+hy4njmKfyJE3lP6WSclLmPOPq1XWS2pj5zAOGeFhnTt3AM0+faI+vIGuH1HB5bgqtR8VcxIKSowmyaYQC22CxDWgNqKgkjKylM+V6Lcu1om6pBTY1HiXVKYOyZqQGsvR507qveY4tGUrUiRyuGBfngq0Ax8ZTZXHND1J04/VI8pL3DdsH9A3okyarjGpwgCWJaPIUZiWKNGorLMBwiKg=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|23021999003|8060799015|19110799012|10112599003|15080799012|260925184616899003|5062599005|22141099003|5072599009|22091999003|24121999003|2604031031799003|39105399006|4140399003|6050399003|440099028|3412199025|12091999003|3430499035|40105399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o9Zzo7+14FTCdAH9DQAe/FUFp/ewYgISo8r8KXxdxrhh0Zdy/SiYXRu9lmnP?=
 =?us-ascii?Q?jOaKvz0sq0yNtwe5JJCxHTB/zzvX+0KQcftYlDjWY7k1s0jL6/pGyA8Yrmk5?=
 =?us-ascii?Q?j7+QbaL+GQvzln6MBk4uGqykVb3ecRFAWMrHmaIn4vqL2Gi8/SrUsU8SDrey?=
 =?us-ascii?Q?qraTbEyOVju/+FG4XWe5JuhUZX0nzT6WCGWfqS0Sbr6aS72XVwwJoUVVPtW+?=
 =?us-ascii?Q?Yi3RlanBtD+F84YoXGMTILh2VmFc1GDcvj+bmEp7gUoT/f8XBcFu3juWpJkG?=
 =?us-ascii?Q?Ut5DhxD5DqIbriquEqu3vWl17+05qobwJjSgkG+xiHqTpYwRWUhEaXwpqEE/?=
 =?us-ascii?Q?40SgHcBdj8fs+OcMqTnxXwFxU6znZ0j69IXXeFXO5B0X5I7m4qL6JaSuPQss?=
 =?us-ascii?Q?eYewFHndJZ4Zv2cWZokKdKPQOq7hE1Ec2fwwnziQHAVel4BgZJnk62bxZrLG?=
 =?us-ascii?Q?4anQ6XjF0ea9zBhp7XczetwfGsZiXk43/vPIWIyEnmZ4XwY6fW6PSRsgUfS1?=
 =?us-ascii?Q?GlavGRvqwO718fuRRANEERDz5uhiTXDeGvfTxWP3GE3CRkh1UPGvUWiaHoAA?=
 =?us-ascii?Q?AY7D8DqPOIGfPP9DROCYJsZdesc080kdxia3CQGRVQO2HV+A1Q1/6qS9MTlv?=
 =?us-ascii?Q?Xo8ZXq3kioXxL5ysVZ5lo0oZPz/U1Q2w4rawr6tm7WCs+TzLbNK1K+fcn+sf?=
 =?us-ascii?Q?vLLbkI9fgxW+/bBxLdaZfo6Uv2qroL+mNrL/5uH7KZB26yOdiRpKmtpqTcpz?=
 =?us-ascii?Q?h0ddsjUt0YasehvhZP5KVQRA765hJEx31VIHIlB8aMCOBQkqkbefYynwozzN?=
 =?us-ascii?Q?wSMWp34DZrAvzKPHrumHtOMfwwDvgqIWf9locQTKfZMN5WBY+AZqDPy5o8fb?=
 =?us-ascii?Q?uCLeqJi8t/1+kTdC0399FomEhZaAhMwCjCbUnFNcPqR0mkkIIed8XhczhnGe?=
 =?us-ascii?Q?HWUfjsOFVSWPIruc+Jj3ifRuSGBs+TmXKVz9XhsaXVezyiLns8dZIO5Cypqt?=
 =?us-ascii?Q?ffZpUTeSP3NBzdRB8IO5v/3ijVvbN6IX/c7GHQ8RGUzoIwDjacG+QmZIjB0d?=
 =?us-ascii?Q?ySPAFxMbsh8ThkvJ9E7PLGoGWw+ymQFgthB11KL2WErHy5mn4OvaJKvDNIDT?=
 =?us-ascii?Q?u3FRCex+t1WKt0qZtejie7jznwF2Q+xb3UNJc6VQycqP3PtwuHa6nP7M48ax?=
 =?us-ascii?Q?gaoUz99W4chGNuv4BZxXXBg1HHsA8GOGaQIQzfYb28GCrv2FVcfN0o3hmHw?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E98oWtdYVOZl2F3Weg19ny9R+JXIih0zZfRe4OfDA5KEUZLiDAS8jewlvJ+c?=
 =?us-ascii?Q?Ps6ZRrNJf8Mc93aDmABahTEr0JjrN22OhlTVUcVOrAivcB+W5Z6zCiIVByt0?=
 =?us-ascii?Q?3ffoEvkWniDjVkGEYs8C/Ac4JotE2bpAZB5K5+p1MiG0AFLitnTQ81QLS1CZ?=
 =?us-ascii?Q?wX+7azPWWpUgtTgE1i1x/Csaga3wCX34DoqnoOAroZwTL7JoFkgw1w25ag/u?=
 =?us-ascii?Q?p2VK2kQM11WZn6lddn6Z+YO2HCFuGRvfBuRxhRJQnwmnRCbFoT5Tuz0GLnqt?=
 =?us-ascii?Q?SjjfhOb+xruEf7tUI1WPJ2ixqZ+uqshc65Af380XlXchQ9rXb8+N2aXjkw4W?=
 =?us-ascii?Q?wQDW8gp88koW6Cd1dbVMRqbzk4mUxX0hyM6KMj73dsbckCJXxhMDamZuTifU?=
 =?us-ascii?Q?fHs/sL8YmbNO+ZiKuKA6nHF+mKPFF392X+mlMtEpFJI6vF3jvl+8cLaNsx9M?=
 =?us-ascii?Q?j2jQg38cSUN4pk2PyZIZkg25KcNySNmMpivPuCpe8M6ruHcro4drfAr/DSTo?=
 =?us-ascii?Q?/h1thwTJ1D6UaXznD6GdklkfQW0+U5zmlwpg503Rg/6e9ZOJ2ZaUKxrEF8LI?=
 =?us-ascii?Q?x4NnyPMm+mHu8bcaQImchEOQ7sn3Tca85tOxKmVBgMzwuloa1mQDzUzhspmr?=
 =?us-ascii?Q?4MGf/+7l+3d/kFX5pVsH/vV5VLSsNrotv8e7WyW/feEbh9mByMaVDKAKpPdr?=
 =?us-ascii?Q?oCp0taEfF1aacL0z8KDHII+DZqhkUkJbePruS61cHEMuV/jLhHQHOpfjH/UA?=
 =?us-ascii?Q?eGsdjC1fNVxqsdngr/705ThtHeJw8JA9OLVnlils4LE/ew/q+XYaU1ACZUJN?=
 =?us-ascii?Q?eiWAPP+fqwiBAvR98tUEUvFRCeQ21KZnKSqCnrAZ2MIc64f4M/6aA6BX5GlS?=
 =?us-ascii?Q?8CZaa2qHL+PIxHupBDdXZGGH68SAkqyz817kZYsWtFaio4lIgCLD+t0XfBSQ?=
 =?us-ascii?Q?6xOdpeXtmMB8lZLB8dmGd4XMjr/nVMuuzE+6VQ2Ho4dKJX1pU5Ip1FNuCQzN?=
 =?us-ascii?Q?GnDdmNPdvchJykjwrFj4qYJFXn3mlfYxvhM6uWGDD4mOmhcLinGOIxiahXNX?=
 =?us-ascii?Q?hfgRsl0i22qf14IZT8GmWBDVYe6iZFZJjlMQUstlZO+T6DDB5obxforTOy6H?=
 =?us-ascii?Q?ItlOwZvvh2jHMbW4F6ji4ViIr1zzDWdIlEdb5xf9FPo9VqAfYZ6guPhDarDM?=
 =?us-ascii?Q?/kqWU1kdfyzC641pH/2IR/qaJG/Xpl8XW5A3auMNSzjtuaHdPF4h8jQrEWa9?=
 =?us-ascii?Q?AVwhqIlMSo1M4U2kPPWpZQ2Gfh9bND2ngtFsF4tEgC7KcKTuY5vHBhcBQvaW?=
 =?us-ascii?Q?iBaci3U++uu/Z477rctx+zn97I5+G1oJxlkjV7ERM98DASVjTym2grIXoPR9?=
 =?us-ascii?Q?xsBgZ2UEzfeHOfqf0GOix/obGJ+tLUrXTGpurcQTx668ZEKD6anOn5W2uXhb?=
 =?us-ascii?Q?jblKb9FltEhudkh/f1gbDI+MNxdOWWb4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a1829e-e5ee-4c76-dbae-08df494064b4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB6177.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:01:42.8751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR06MB8996

From: Bruce Lane <b.lane130@outlook.com>

If register_sja1000dev() fails on the first channel in peak_pci_probe(),
failure_free_dev clears drvdata and frees dev without calling
peak_pciec_remove(), leaking the PCIeC card and leaving the I2C adapter
registered.

If probing fails on a later channel, failure_remove_channels frees all
devices in the loop and then dereferences chan->pciec_card afterwards,
causing a use-after-free. This is the same issue in commit 949fe9b35570
("can: peak_pci: peak_pci_remove(): fix UAF").

Call peak_pciec_remove() under failure_free_dev, and change the cleanup
order under failure_remove_channels.

Fixes: e6d9c80b7ca1 ("can: peak_pci: add support of some new PEAK-System PCI cards")
Signed-off-by: Bruce Lane <b.lane130@outlook.com>
---
 drivers/net/can/sja1000/peak_pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 69c61ccf621d..d5f862f05480 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -697,6 +697,10 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 failure_free_dev:
+	/* free any PCIeC resources too */
+	if (!chan->prev_dev && chan->pciec_card)
+		peak_pciec_remove(chan->pciec_card);
+
 	pci_set_drvdata(pdev, chan->prev_dev);
 	free_sja1000dev(dev);
 
@@ -709,15 +713,12 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		priv = netdev_priv(dev);
 		chan = priv->priv;
 		prev_dev = chan->prev_dev;
-
+		if (!prev_dev && chan->pciec_card)
+			peak_pciec_remove(chan->pciec_card);
 		unregister_sja1000dev(dev);
 		free_sja1000dev(dev);
 	}
 
-	/* free any PCIeC resources too */
-	if (chan && chan->pciec_card)
-		peak_pciec_remove(chan->pciec_card);
-
 	pci_iounmap(pdev, reg_base);
 
 failure_unmap_cfg_base:
-- 
2.25.1

