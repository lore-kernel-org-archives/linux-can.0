Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792639195;
	b=IzY9FS/sKGgAYajoOXC+e46Qz/OwSHVGQQcGQz7mBaMjFA/mbqAg82esnykZ/JY3NPfP
	 mh3W0/TYs9cJ19gQD8JwIkNpdyQqoP9tsJNFiBQe3xCN4jCWCzzxoudt3Xv0DTI9zNOhR
	 MLttVL2YabKHy6goZyb7yxY6t87CssVPBukkQTKFcJoym6xLqyWZrB7pAAp7rdUn/sGc+
	 +eQvEavjs+jN9OmjHEfXhdPlHnXzth24fFRo6K48+hA2gC+8A72LTZ65AnRCDRnsXZCqK
	 681E8vvw8lRPN74THdgTLhn3AHhVHBnp7em57h86N80mhgKDN4UfNcFxRfuymS4aPZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792639195;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=T4TbRBYRht2MpW36j2+Hkqf0Z2uKFzZt6708MsiJj5s=;
	b=qShLY8fdAjqVEdPuEfubFlxMwuKU5VHuL8CuXNwKVT/fLdk9liM+zj7Hyg+jAkxvC2l2
	 6T60MZNodxsIzJmNIybRbG0pBL6HO91gId3nbrcFe/ydA4Oa02RpYVaJ0xe5K6YCBn5/p
	 iY13CfY9+mZvCtR6z7d/XU5GjgDwgdY7xa9pXzMZsPNboSZWbaUsuw+LTzdXfepm/UAmd
	 NeseHYY3oUP17ZVRaQGUahoT7MINf0ay3nCnaQEYNN6INGhzDpfXeim/B969d8AHTx01O
	 sgerRw7vnduDvU3Qs7T8t1EiU4MAqSA0Prpd1hsBBLKFij4NgnC0MayI0Z5jdTFiDBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b="mT3/DSLM";
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Dndm4Mq6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4F5606A31A;
	Thu, 22 Oct 2026 03:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A4F5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=mT3/DSLM;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Dndm4Mq6
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M28Hww3298343;
	Wed, 21 Oct 2026 22:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=T4TbRBYRht2MpW36j2+Hkqf0Z2uKFzZt6708MsiJj
	5s=; b=mT3/DSLMvMGXlGjYEreauDTz8UHJOTjzsEpdaRNxPrdGeBgJW/JalVtSY
	v6H0AeTr1Z4FlQ/jMnPa35UPgLAe4+i7qSaOck0pLavqQkA+OlQkqQNR6Ptzi0/m
	urz0xo/rqbyW6eziIGRd6lYyRILFD0XH6tJ8d6abLmaYK2/Kz5OOPdCQaUPHIV5k
	1cbaHxdLjilydWDKs6FeDJn7ZmSBS3NfgcyAX/EDg986HofBFU7K74+RVB8orxuc
	au6KinKdiqxqjgbTiH1H0IYYxOqyv8BD0c3ZxrBHvZm/N/tP999JUpaXg87lueoj
	mMgO/UQpDdvxStynr8X6Cq8iuly5A==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hf9ekrcq5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 22:19:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXu2Ng9sk1H2JJQq8Iox/vOefREBDy9TTURTKEOTEGwZmQybCU6o2CiAHq6MVSdBtZ+FYVTVRU4z9m+sZ4JhRyIVnAomYm11HkHR/bPlpCAhT1qlD/FqGdeZ0r8XyrRV6eLBrnWaXVfNMHDpg6ddW2eeAkdbLkRVy21gpVLPqrRP0sNdSULMFtrG5nCy1oD2PhFKbmL10QITuwj+90cp+8+LvvrkutJKWNPnlLsFCCgCfgWq31ybb1vHh4tiA2pc8VbZpU+kivws2xAMhlnfg9Fctmtg9GyL0BxKVoXz2Jd5xNMA78hOEnoYQxZj1ldyPe4V0SHTFvaCBrnXZpZUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4TbRBYRht2MpW36j2+Hkqf0Z2uKFzZt6708MsiJj5s=;
 b=a+TebOFb12Av+kAzM+jjV9htYCrR3uDtEXPRJz08vuPDHgstriZofo1wY5hIoEzX3TYxuliV0/IacXfjL1btRSYzJPgIxsXZeFEQ60B5La+0zBSa4d8AYeFLorIWrlhYJvloRNS/K8wsdttZKqAxP7C5qCU7Eb9DMt5C6obyfV0cJMXyeRAFT2JW8UlwDRwnASLMsCQp1T9lqund2+SHRC0tDUybxNCLSCAAnHdx0wWLS+0tHlkRfdwz4gRkyE12IhGDbCuiCxaE6eH34FeS8Crjuq1acDESOcVXye4AH74x14alU4UnC9RdeGDBVAZmvLjiVYOAg/dRapjZlRPeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4TbRBYRht2MpW36j2+Hkqf0Z2uKFzZt6708MsiJj5s=;
 b=Dndm4Mq6wRqaKxl2pUzjYHfuWCFAAMk21aIzpq4LkyHbwOSCv9NIvdVzLMHMG8QzZDHfJRseGmzV+hkXgqgoCX4xgnLtBDQmZD9uUP05zyzpcj9BCOx7EkN2ZWkiXhceMTXxDByQENmV0S0i0Num1sjN8XgsmtmHvAw203JCDDk=
Received: from CH2PR07CA0058.namprd07.prod.outlook.com (2603:10b6:610:5b::32)
 by DS0PR10MB6917.namprd10.prod.outlook.com (2603:10b6:8:134::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 03:19:33 +0000
Received: from LV8PEPF00000059.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::5e) by CH2PR07CA0058.outlook.office365.com
 (2603:10b6:610:5b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 03:19:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 LV8PEPF00000059.mail.protection.outlook.com (10.167.245.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 03:19:32 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 21 Oct
 2026 22:19:30 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 21 Oct
 2026 22:19:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 21 Oct 2026 22:19:30 -0500
Received: from [10.250.144.11] ([10.250.144.11])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69M3JNuK3826224;
	Wed, 21 Oct 2026 22:19:24 -0500
Message-ID: <9787fdc5-8a51-4567-a576-a3b9f4fcc59d@ti.com>
Date: Thu, 22 Oct 2026 08:49:22 +0530
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: m_can: Implement workaround for errata i2278 and
 i2279
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: <vigneshr@ti.com>, <gehariprasath@ti.com>, <rcsekar@samsung.com>,
        <mailhol.vincent@wanadoo.fr>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <msp@baylibre.com>, <u-kumar1@ti.com>
References: <20260514065511.3573223-1-a-dutta@ti.com>
 <20260514-tiny-koel-of-order-65ade7-mkl@pengutronix.de>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260514-tiny-koel-of-order-65ade7-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000059:EE_|DS0PR10MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dac0d3b-6c9b-45ee-0558-08df2feb4ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|36860700016|82310400026|4143699003|261021123027099003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003|13003099007|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	zKjWoqJZFOcE1xljkuKX70FlafHJ+34IICzGzhmF/DcRbpeTDPbGF8q76qW0OXxU7Kh9lKY0Qsnp3R3vpXXMK7p8gdo5WAbAI1BXaa42XxrdfaikG7v9i4pH34Xld18O2ijdEGGTc77OWgmHJ6iyadyQMKhP8l9yk9YArO5HjxF+ANlKdTtQg5fJuBZxJEmRxBYjoE4dogO263NT3qMmY38L9gRFJX4o+r+xecGTKBv9+mKjc40qPGiV0QxZRM5XMNcsrNjtRESN6lvpZAE/r1hdo7Qq2qeB8/cGG7K/a3CA9tY8irJbiv57tHBhnuB1z3qkYDgwcDB839sO0sjrmray5AXAnWTP+w1Qyh5p/g+y94uEWRAM0an9bgEDDN/mGAN693QKrp/S2DVOlqKtT/5BhifPWPcGS0yi1DzEwEbWSHSQethClRuXZs3kFxGhsnDZJiht/jFPUxxYmc0M62dQ/3G83bERp8/fDK/Qy4Psc7LCjZ6o1yiKKUa/tmqMDzSN6Ab97UEAPkYXpFN1x3Qjcuj3tXGp3TmlyMMotCmIbwjvFRGIFcJqEKJmMLl5JoJ8VXzG69C/uCnklfgSqHFB+z0P7ewHf98ySYZfN6g8qmHYRx7QtJpA5Xl1ZBqta+GG0SZVAxjbPrF+2JwIbCGaKKADpP6g8LiiKdTK4/C5EBj9bRBUc65aZmf6GZ+2/LyUxj1mR9ch++jayrxgBw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(36860700016)(82310400026)(4143699003)(261021123027099003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y4UQkq2xc3AJ4gm9ImgO2qCm6wtaNk9I6v38m7TRIqdLqpfvEE10IpUe+uoOmpPwb1D2AYAHi6K48ngv8jqlZT9//r6sCwsRzQYIf4SPaaIhWMBccLTw9BKrARgohfK5DF0QavuMkXCjw/dD9kIpLEklSCO75wTfBXO9O0hWHMG3OiECw1wP5bFajCCAIxE4SucCrImsl2Avs5ook9WbxPIgA3Ce5LXBf62FT3Z2boviX+S3QitfaVDtov0I9SXt2OhDiN7HkBBs1WQo0mB/a6gC5YF/DQT94XqAQxzQKTkdJc6V8l1GdkKQeNb7YOfv3/fGjSjc/fksPEm9j+9LXvhDT+JYxBdxhPzqsIpWS1DZNLdYs0e48SejW92b3ikqpG7uz7WqqYnt9Sg8wj+ovpBR7vIrS7AGCgt1xXnOxvF5t1yWhRUIPXQgGQRGCDQ8
X-Exchange-RoutingPolicyChecked:
	HADrn/e0EXiF/W/JtrebD0AG8tzi3qnbxTK1YVkFe/JadzwP2WC5fb8/gN7m1OXT41Orwr6Bg2edXcQzfp2gd09NRdloUFyWbcEhlaiObcTRgZ7BnZEpjDcQV1mwoY19F/QZJhkJlON26E7H3qBRt3nB8194+D/Ow15J7jH1d1xAbi5Zmjlb1OCUXiPe7KoBSN3wdiq0pw9Of7ZlGWLn7vrar7n9TtNzYtAzwrw1zPmOL/18EVL7c8/wTR5KQM63EBgUmLE6hCKpR1kmuaPaocpGkD3sPz1WiPENvxMY5eGjQiZYDxLEXDH72zuRzNHPow8MWQWwi7WmeTJ5pTTcTw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 03:19:32.6678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dac0d3b-6c9b-45ee-0558-08df2feb4ac0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000059.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6917
X-Proofpoint-ORIG-GUID: hg0O0MDOJ0oOIQ4dav7GQkaqfaG8nh38
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAxMiBTYWx0ZWRfX0B8svTpuKwJK
 OPCDEr7woAs/w8/wNzHYtEOcNWI9qpkBpIgIrY5i6b78uPkZOzXDoL3VbHaiR59PeAEE2vHRvCm
 78tPWyqW/4il0B5MK8oQVTSIOycNUPI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAxMiBTYWx0ZWRfXxt7zZwfR+4Y+
 NS1CwPjqfkkvpwOaiB0hgX4suEL1HkEZmIldjGmqgrkDtrNO49ukKz8Sw8jOrDK8VYmr5KqUEjn
 aEOL1P7VvHlu5FiVMHr2YLipuAPQaYsIuZC4eAeCxjHKrLuR/1wKbBE7eWGxOfEKG11+z1MPxrL
 2kluWXrQI5uGn/yZbXx8BRdQz4jtznYbDkLw9iuYCKITkIQ7f1xVcm73cgbYbPX1Xvcl3f/nCbN
 BkzYnFXMJd6GbOT6QKjW7po+QHw5MGnlVHFyhUPslN4TjvtgCF1dEjEfYzCdANidRrehLvymNsa
 BR+RayG/akVmwc/zDBExtl1y2M102nDC54D2WYVNt8yuDYSsq5n9Ec+fIiUdGbFA25VbN7kGZzR
 si0bsrSXSMqtqxdnmuPJFEEuL4Eo15ZexyufCRA3nc5XKoB+k5Hut670S+8dJwKh17Cs2EogC8T
 7a5StIdwWDlmxpedQog==
X-Authority-Analysis: v=2.4 cv=H5JOUOYi c=1 sm=1 tr=0 ts=6ad980c8 cx=c_pps
 a=lq01mLAL2wBNHDG9j+U+0g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=UGuXxYvM5Rf7GQbo49MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hg0O0MDOJ0oOIQ4dav7GQkaqfaG8nh38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1011 adultscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220012



On 5/14/2026 3:35 PM, Marc Kleine-Budde wrote:
> On 14.05.2026 12:25:11, Anurag Dutta wrote:
>> Message transmit order is not guaranteed when dedicated TX buffers
>> configured with the same Message ID are submitted simultaneously via
>> TXBAR write. This is described in J7 errata i2278 and i2279.
>>
>> As a workaround, introduce m_can_tx_peripheral_submit() to submit
>> buffers one at a time using ffs() to find the next pending buffer.
>> The TX complete interrupt(IR_TC) triggers submission of the next
>> buffer, ensuring strict FIFO ordering.
>>
>> Link: https://www.ti.com/lit/pdf/sprz530
> 
> This errata is for the "J721S2/TDA4VE/TDA4AL/TDA4VL/AM68A Processor
> Silicon Revision 1.0". The code path you modify is only active for the
> is_peripheral case.
> 
> is_peripheral is only set for the tcan4x5x SPI CAN controller, and not
> set for memory mapped M_CAN cores as found on the above mentioned TI
> processor:
> 
> | $ git grep peripheral\ = drivers/net/can/m_can
> | drivers/net/can/m_can/m_can_platform.c:149:      mcan_class->is_peripheral = false;
> | drivers/net/can/m_can/tcan4x5x-core.c:460:       mcan_class->is_peripheral = true;
> 
> The latest Bosch m_can documentation doesn't mention this problem,
> neither the TCAN4550 docs. Can this be an integration problem of the SoC
> on TI's side?
> 

Hi Marc,
Sorry for delay
this is similar to Errata 22 from Bosch
Message order inversion when transmitting from dedicated Tx Buffers
configured with same Message ID.
page-29, release doc REL20210625
Thanks
Udit

> regards,
> Marc
> 

