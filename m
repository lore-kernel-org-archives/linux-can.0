Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794820338;
	b=lV73oa8ysn9nHd++T4ccTpglHC/i9e5x04/lIrLLb8ORnv0L2JA2Bcd96Orv8GQQEwd3
	 ySxlhWfAfTN0sZmQN/Qa8GjBCrWf9uGWh22rpY0XW7P4pIaQYM9VGyfFO0AespwR47EUW
	 YmWtHrrPjOTvyoDM/I++H1bvltJpe9DXlIHEmgQDCjDJhYCHxUBHGSQGqdR6AQtaXHIEc
	 MgMNTAQcTXAiEufO73UQZ/sQkk59xHjNKWEVfI1pYiValNpBYwJpqL+w/DRPG2x5NXGVu
	 FxDFX4wxtJkkpzPRZ0V4/meoBjwxCSA7S+hA2l6Y6TOl7+vSoiO2rKLxgwRoaFyvVCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820338;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=FK6EVe10hRl1wlB2XPvUf/BYYP4nRVDCgd7GngWZEwg=;
	b=jXem9cA/aTd5sDxROR50xKyq9ZdJWP267RXSf663vsGG2giKpgMvu//eBJUaCimHkavU
	 mrUFUTqIif8Hey4CDorBlOLCgK2DyfV0Vy4Q7sab+qlVEJtCaryb4WdVORzencsRdhols
	 m0VuAxL/dWJhUkmaRGtq+wv6Si5xi6DiSJJ/fhaA5Zf/LXa+7WYJRjwpwxmHdfv2IoYv4
	 /Yoen4x/HOjptwHH7yFW/lPOrUDFqIVVkWNy92PzQsyFlQBJJvQL+TrhbGxyiVSnFPepv
	 i86E3zjCS5Fs3zutFE2KcSUOli+Hzf8ox38KkHCRO2nm7YQyDoOWLWocTT7Yjt4hPuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Ixrc7SI3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.16
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010016.outbound.protection.outlook.com [52.101.228.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA5606A337;
	Mon, 16 Nov 2026 09:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82FA5606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Ixrc7SI3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0s9phsa+vZW5rwnH2Rj/K7K5D6bqQ4wpcv+yVT3vJSct0VF3gqCae4OxDjnmMxPsgjfqyehCNAweSvaxJkMQ+ygbezMJI6QRjo7D/FhaUICywfcwYiUyRI2VbyOrQ9jmGN3BUW8Gq1A0Kz9nBVFvYCqQAG+8ZeLsg3tE0K6gHHOkj3fB3j2Lb+p3xacQ8b/nVB7zPwpNdQaVjzQiKpCsoR4PB8kMWEe4uGF3K7c4SyTrGc7VDI/62XJs/k5ZuyPh4zzALeUm4grBLcR6AqWvMqUewQS3tOVsQZwcxd1D36N9gmVU9DO9Q2/CRK5r+Pg5YTLdMBBFgY3t+7uYONdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK6EVe10hRl1wlB2XPvUf/BYYP4nRVDCgd7GngWZEwg=;
 b=tOc3J4DVelDCSsbIs6C9H1n20C8SoLB7decUhkCDBwVKh2fim7U00B2uNgX/oxFA3wsU4dtQ+0UA/ubIhud6SCDXBJMXWya0qykZoE/IaalMcCJgdaiRWUX+Y62x2fUpx86XPIy+psm5s3fglbJ2jzAttnw6qRX9NiPgKQlHgFHCoEeliHc9kcR7XFz8C8Y7jhLDfPJ6p1NpmCn4rhquhFknc8niZy8/Hf/Yv/PF9BPGpS/otvUMw31RjMk8i3IyS2w+O0AvkfGZoAwCUGiYSSkcRCQA0YH8Ve5YnNvb9++bLnCDdSY9X6ygbUJVh1qZeTxy8hRp8fIr4e6IdUL0NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK6EVe10hRl1wlB2XPvUf/BYYP4nRVDCgd7GngWZEwg=;
 b=Ixrc7SI3WBW5Pu8rgDJUn3K7dCW2UmC2wMr0GGRpZ+dnkTRi0tSr/z3+eWJd6NdB4yv8N0K4MBo0TTjgTe2pwbXYZmCKTxpetUAkoIv2hIwiqR4ScF7RlHsoA0GCbsZ1GLhSL3r71RWFdmWV1dVLJCzC+uVXvre7Z/9xtWJtvjc=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TY3PR01MB10386.jpnprd01.prod.outlook.com (2603:1096:400:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 09:12:14 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 09:12:13 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
	<magnus.damm@gmail.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<ukleinek@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: RE: [PATCH can 4/4] can: rcar_canfd: rcar_canfd_probe(): reject
 devices without match data
Thread-Topic: RE: [PATCH can 4/4] can: rcar_canfd: rcar_canfd_probe(): reject
 devices without match data
Thread-Index: AQHddDe+pqQcO6zuIUW4lgS12hIyWbcwYs1wgAAFEwCAAAMz8A==
Date: Mon, 16 Nov 2026 09:12:13 +0000
Message-ID:
 <TYYPR01MB660333DE58031D8231CD1B3B867C2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References:
 <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
 <20261114-fix-device_get_match_data-v1-4-2d82025e9646@pengutronix.de>
 <TYYPR01MB660340F5E219C29045BF61F9867C2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <20261116-cream-hornet-from-lemuria-703c6b-mkl@pengutronix.de>
In-Reply-To: <20261116-cream-hornet-from-lemuria-703c6b-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TY3PR01MB10386:EE_
x-ms-office365-filtering-correlation-id: 9cd67146-515a-46ff-585a-08df43c1b417
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|3023799007|4143699003|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 uk4UhKPbMohsPQKQXraXEwGKRDbDHurEJQ87/zPDZOVzvt3lF+5RbPAHF+4wO8kzWmK0mlezqKfKcZ5P808sQYPlqd4jHqEdC32SjpobSrPljvTtQWYeX/4hbUh9e8FCXHaMlGXmzc07Kb0Dd/lgU0z3fFKtO1F3IKsL0BtvtuwNV9dfz2gIm2t6+bd/cS3pSABlNJuUVcIX1KI+7iYn2CnJdSbcMdGf+Poeyh6ARr+dJRSWdVqUaNaUpiE1Rz+K7MpST4jYOc0EoAlOsG0eCQeBO8jXATIXWnbgxiie2UwCI6s1Bq4NZQfdzAdHFkdW+gxXcr8VKhJ7vrDZnNiSAQU/dv7xbr1bKF6f7eV0sJHoDWheae7QC97oKbOyB79zUmBv6Q62sQI6JlZ2p9fJgcO1+DZ/uitgBWELApjODLfvL6wrfIopdmbx9yVpD95CKVYyG+nZR+QyhLO+VrE/luurQdIRXzd/zVqwGYV/y7RbfwLv0+j1EyPr0tXpmTlUsK6jjc/28RazNgUofyqy/s3Yer9AoN0tebdjmIHSQYVDcU7qhfmdAUU1peuWVPBLTQNNwDzLPGdcSvcnGjZ5sxxI0nEK5B2JOfH+DP5oBNlIMfS5S0iJlIDJfUKtxzIuGN8GKzK4Ac1BTtr8GCWqbnPdIN3XMKexv4fDZ3EdbPg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(3023799007)(4143699003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LzRCNG9heVF2VDZZTDJGUEhzWGNXQ1JUa0ZuTVFTdHlxMlVLQWM3ZjB5QjZC?=
 =?utf-8?B?MncrN2N1cjZ6RXVKZG03dFdwQ0xiZ2tpQy83ZUMva3NTdnhCa3FDNDdNMzJB?=
 =?utf-8?B?bWFvRFBUTGR5eFB6cWJ4VHJwWUx3NjZlK3RxZE5UVGRTQkpWamdlY2tsc3pq?=
 =?utf-8?B?MTY1L3o1M1JCTUhOMWU2Z2JzY3U5RkwyR3hrSUVvSmxPa2dMZzBYQ1JzR202?=
 =?utf-8?B?dk12bHdYS2diUE1YUEZSZXFjS3gyL21nUGpkNVZnS0NibkhObEtpQ3hJODNm?=
 =?utf-8?B?Yk1KQ2IvRzlScW4va0MzaFhDSGk3RDA4N3NwRkJIT01ZZUd0VVZ2M3dOY1Vx?=
 =?utf-8?B?anBxWm9TU1ljNU1MNlpVdmdIb204US8vQ1dBdWhTWFpVZTFFK25XOGVRMkdD?=
 =?utf-8?B?N3JjaUFWQlU1U3Aya1RObFAwQnhtTVJYWDV4aTF1bWZOejJsMis1VmVHTFJC?=
 =?utf-8?B?NnhmYS9VbVp0T3ozWEFwejkrOW1kMy9xSXZjdlZYcVFCVUpXUmMwVHhDMVlk?=
 =?utf-8?B?VUNpbGJPM2pZODV5bzFITGFYN2JOVlNDSGdJQkFaSjlWVWpaRXJDc3kyREVZ?=
 =?utf-8?B?OGRXQW5xSmNXdzJBcnFGMEgvUTVzeVhDbjk0UzNUZ1ZaTEJ2WHVpNDl2REVI?=
 =?utf-8?B?TlBhMXJrY2xwcC9IbUdnYzFmU29DVmhmMHBiTHFkTEViYVE4YmN1Q3QxaDJt?=
 =?utf-8?B?VmdSZXNJanE2TXRBU1gzNkRaYUR4enl1NFNsVDFxTmlKaXVxZk9DOUJ3T3Bw?=
 =?utf-8?B?Q2phblM5aWQ2ZE5KVnp5RUdRaURlZkNURTBGQWRDbWJocnc0cVIycXVma3Vy?=
 =?utf-8?B?L25QWEFZU2hwN21ZdjBneTA5OVEzTzdON2tGQ2pFSFlHTWU4YWp4ZTVVK3Rl?=
 =?utf-8?B?Rk1RQkRwVGFUQjIzMEVKdFRFQWpjNFVWT2ZkaWtxN0ovcWFMeEFmNWlPTDll?=
 =?utf-8?B?ajlqZWExYmRLOUpYUExLek8rcTc4Zjk2UkZocXl6ZnZJZGF6YkdFL3huZi9a?=
 =?utf-8?B?WGxuY1FncktkN01WdjczbHRrV05hcmc3amNzRlJ2ZGxnaWU4aDdwa2NjWFg4?=
 =?utf-8?B?T3k1V05NU3FzUnRuNG5LWVNhWW1kTTZVTUlnc1EyM1EzWUcvSFZJMVBSSGUy?=
 =?utf-8?B?Z2VyL0lFTHhCL2ZLY2VXdXlhekprZkVLZkJYOVZkSEtua25oTmI1Q09TUFlM?=
 =?utf-8?B?WmVkOFl3cUVxRmRiekRaSmpZb3JEa2Jmb1NuUm1CbC9wdDNHajV6OVA2RTdm?=
 =?utf-8?B?R3l3SlBxQlVKQWZLTjgwdEJWUEdoTENVZzhSYWcrYTBlNU83dDJjNjFSdEJp?=
 =?utf-8?B?ZUFDYTY1TGgvWmxoRUdxRXErL3N6ZklaY01mSy96VWd2RUFUY0wrMy9tNEVC?=
 =?utf-8?B?aXFabnJueGtvVytLMzgya2pBUm5UK0dKakk3dStxTDV4S3d6VXFza2ZOTHNm?=
 =?utf-8?B?ZWFqUFRDUVR6TFZpeTZCRnI5MWJtS242cHNESWVyVTQzWDVka25kMFJETGFF?=
 =?utf-8?B?UFEwVkxTZXhiaEd5STc3ZUpRaitZWERnNXhsSjBoUW40Q0JrdkxmcEVoMEd6?=
 =?utf-8?B?bFJEMGFCbEczbEJzUTlSYnZCQ0xzWTJrOVlVS0hJZmhoK2ZnUzVXdlI0RnV6?=
 =?utf-8?B?WE92M1dJak9Icm5CczZ2d0RUZHk1N2xGZWM0aThGMzNlTnBqbzFTa2VlWEFh?=
 =?utf-8?B?NkU1TUVsbDRNYkU3K2tSVUlnNm5raE5uT2xHbXRTQk5RYmwzRzh6UERpR1BP?=
 =?utf-8?B?N2w3ZU4zZmRQRmsrVHRlamdaZmNhWU9vMVdENG85VjFsckQxTGszVE9LbWVw?=
 =?utf-8?B?NUNaUmdPVUlocWpIbDczOFNtU2hObGI0L2xxWVhGa1BneDU3UkFwYjZjVVB2?=
 =?utf-8?B?K1VzMzh0NzZ6c01OWWF4YzlrL0JaNXVYTzFjekIzc1JqVWw2emRzQ0RIRTFY?=
 =?utf-8?B?Q0pzL0s0bXF0bFZWVU9qNmRUVHMyTHlqRDc3Qk1zMXlSMk4wb2VYaDV1Wi8x?=
 =?utf-8?B?ZzdZZHZJVmFVaTUveTBUVnZtZEp0Zk1obURlWHE0UDFIdkVRMzREY0FQOUdP?=
 =?utf-8?B?MFRvU2FJR1diYlg2UnUyd1ZGRkluYXhhU09HcW9ZWFNkK1F0WElhWERmR29W?=
 =?utf-8?B?LzQxelRsTFFzRTZOaDdJSnFhaXYxeUpFeW41Z1FGTDNyVGpmZ25DY1BhTEx3?=
 =?utf-8?B?L0dwNWJIamRQelowdzd4VzY3clJOY0xyOWE2ODNiMi9MazU1WXR4enZpbFZX?=
 =?utf-8?B?R1N0V2t2UE1EU3FsSDV2cks4WXI4SjhkOVI4bDBINWROaXFvbnZkclRjVzN5?=
 =?utf-8?B?cElPRDh1QittSkZjQW9QSEhldzRXdXhhUWVsK0Zza2NUK0NHbnh6Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd67146-515a-46ff-585a-08df43c1b417
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 09:12:13.8420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhRLie3Q2nkHmELRRizvzjSdcNNo5KlVE6m8ETYuugKFh+F9srOwlA/QMc30ROJvDC9xc8wlSlg9oJMms2XELZsw1+T0OjjAHooxCMk+UFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10386

SGkgTWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEts
ZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAxNiBOb3ZlbWJlciAyMDI2
IDA4OjU1DQo+IFN1YmplY3Q6IFJlOiBSRTogW1BBVENIIGNhbiA0LzRdIGNhbjogcmNhcl9jYW5m
ZDogcmNhcl9jYW5mZF9wcm9iZSgpOiByZWplY3QgZGV2aWNlcyB3aXRob3V0IG1hdGNoDQo+IGRh
dGENCj4gDQo+IE9uIDE2LjExLjIwMjYgMDg6Mzk6MzYsIEJpanUgRGFzIHdyb3RlOg0KPiA+IEhp
IE1hcmMsDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9t
OiBsaW51eC1hcm0ta2VybmVsDQo+ID4gPiA8bGludXgtYXJtLWtlcm5lbC1ib3VuY2VzQGxpc3Rz
LmluZnJhZGVhZC5vcmc+IE9uIEJlaGFsZiBPZiBNYXJjDQo+ID4gPiBLbGVpbmUtQnVkZGUNCj4g
PiA+IFNlbnQ6IDE0IE5vdmVtYmVyIDIwMjYgMTI6NTYNCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCBj
YW4gNC80XSBjYW46IHJjYXJfY2FuZmQ6IHJjYXJfY2FuZmRfcHJvYmUoKTogcmVqZWN0DQo+ID4g
PiBkZXZpY2VzIHdpdGhvdXQgbWF0Y2ggZGF0YQ0KPiA+ID4NCj4gPiA+IEEgZGV2aWNlIGJvdW5k
IHRocm91Z2ggZHJpdmVyX292ZXJyaWRlIG5lZWQgbm90IG1hdGNoIGFuIGVudHJ5IGluDQo+ID4g
PiBvZl9tYXRjaF90YWJsZS4gSW4gdGhhdCBjYXNlDQo+ID4gPiBkZXZpY2VfZ2V0X21hdGNoX2Rh
dGEoKSByZXR1cm5zIE5VTEwsIGJ1dA0KPiA+ID4gcmNhcl9jYW5mZF9wcm9iZSgpIGRlcmVmZXJl
bmNlcyB0aGUgcmVzdWx0Lg0KPiA+ID4NCj4gPiA+IFJlamVjdCBkZXZpY2VzIHdpdGhvdXQgbWF0
Y2ggZGF0YSBiZWZvcmUgY29udGludWluZyBwcm9iZS4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiA+ID4gLS0tDQo+
ID4gPiAgZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jIHwgMiArKw0KPiA+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gPiBiL2RyaXZlcnMvbmV0L2Nh
bi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+ID4gaW5kZXggMDAwYTY0MzNmNDZkLi45ZDQ2M2E5YzE3
NjYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMN
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+ID4gQEAg
LTIxMTMsNiArMjExMyw4IEBAIHN0YXRpYyBpbnQgcmNhcl9jYW5mZF9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gIAlpbnQgaTsNCj4gPiA+DQo+ID4gPiAgCWluZm8g
PSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gPiA+ICsJaWYgKCFpbmZvKQ0KPiA+
ID4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ID4NCj4gPg0KPiA+IFRoZXJlIGlzIGEgcGF0Y2ggb24g
dGhlIGZseSB0byBkaXNhYmxlIGRyaXZlcl9vdmVycmlkZSBieSBkZWZhdWx0IFsxXS4NCj4gPiBJ
biB0aGF0IGNhc2UgaWYgd2UgcGxhbiB0byB1c2UgZHJpdmVyX292ZXJyaWRlLCBwcm9iZSB3aWxs
IHJldHVybiBmYWlsdXJlLg0KPiA+IEkgbWF5IGJlIHdyb25nLiBQbGVhc2UgY29ycmVjdCBtZSBp
ZiBJYW0gd3JvbmcNCj4gPg0KPiA+IFsxXQ0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8wZjc0NDYzMjRmNmEwYzhmMDE1M2Q2NTMyZDkyYTZlZWVjZDZhMzA4LjENCj4gPiA3OTA2MTIy
OTguZ2l0LnUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20vDQo+IA0KPiBUaGFua3MsIEkgd2Fz
bid0IGF3YXJlIG9mIHRoaXMgc2VyaWVzLiBJIHRlc3RlZCB0aGUgZHJpdmVyX292ZXJyaWRlIG9u
IHRoZSBmbGV4Y2FuIGRyaXZlciB3aXRoIGxhdGVzdA0KPiBuZXQvbWFpbiwgZml4ZWQgaXQsIGFu
ZCBhcHBsaWVkIHRoZSBmaXggdG8gYWxsIGFmZmVjdGVkIENBTiBkcml2ZXJzLg0KPiANCj4gU2hv
dWxkIEkgZHJvcCB0aGUgZHJpdmVyX292ZXJyaWRlIHJlbGF0ZWQgbnVsbCBwb2ludGVyIGNoZWNr
cyBmcm9tIHRoaXMgc2VyaWVzPw0KDQpJIHRoaW5rIHNvLCBjdXJyZW50bHkgb25seSBmZXcgZHJp
dmVycyBhcmUgdXNpbmcgZHJpdmVyX292ZXJyaWRlIGZlYXR1cmUgYW5kDQptYWpvcml0eSBkb24n
dC4gVGhlcmUgaXMgYSB3b3JrIGluIHByb2dyZXNzIHRvIGRpc2FibGUgdGhpcyBmZWF0dXJlIGJ5
DQpkZWZhdWx0LiBUaGUgZHJpdmVyIG5lZWRzIGRyaXZlcl9vdmVycmlkZSB3aWxsIGFkanVzdCB0
aGUgcHJvYmUoKSB0byBtYWtlIGl0DQpmdW5jdGlvbmFsLCBzbyBpdCB3b24ndCBmYWlsIGF0IGFs
bCBpbiBwcm9iZSgpLg0KDQpCdXQgaGVyZSB3ZSBhcmUgbWFraW5nIHByb2JlIHRvIGZhaWwsIGlu
IGNhc2Ugc29tZW9uZSB3YW50cyB0bw0KdGVzdCB0aGUgZHJpdmVyIHVzaW5nIGJ1c19vdmVycmlk
ZS4NCg0KQ2hlZXJzLA0KQmlqdQ0K
