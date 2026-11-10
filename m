Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794310853;
	b=cFWMw3Rrg7LZ2q07v+QiRcWzJw/vhPPCl8cx+WUGEEFwFf3kOX18b8ZZkGLkKCyq01NO
	 RH57/TDzKKK3IvFNGMZnL32VzzfyU92Wqsi77561GPMGNqdOh1oYE49XXH4KjtkreXoED
	 31rN5JogMNZ7x8Y+Vl39PTQ4R/Do4odOemWHu5OU6T1gcjpDL7kLItAneIfn1eA3oQ4AM
	 pUMIK9W7aE1aV2IRDoOVawdf3HkzBiYLuGR0d5sWsHsRg0MoRSc5GTuNaUzbw3lJOAdn7
	 3UtPvtqxOjDeqS1p00k2tEXxgSCUeLTBtmGlUwmZQGiUsbPJq4OJgE16zBkUN5vr+cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310853;
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
	bh=vGoWfjD43iXBphEGvoWJbo1Y8/vexMojq0Bsetb94Aw=;
	b=3u0vLic5Od3SDsaZUvmMFAcytbK72QEqJNVojgEEdvabc+e9HcZq00hXK4mXrxBZZfYk
	 Bi8+bvQimAX1isizGqAZNn5C5cS5zUJZWAPeUtsQ5Z7HPJkZhWe0z/9MivRdf98NAr5bZ
	 08hhZecrZvMrF4LC88SWZlx2DGju+NNYp/MY4uS4qC9USiU0qjME8z/tQ9BHlxO1u93Ze
	 +UCAQbkxbm0bSzEtpGw3r3RFRHxWlfAyGhXFx9Fy1fLT+NEOtI/2mcrDT6uKWJvn2OMJv
	 6QvAb6zBXXScLP/Q4+JC/uF3suCdCaReV2L8v/TCPA1VcnEh4yPFWn7oZq/71jn3Yew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=S+mflxit;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.66
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010066.outbound.protection.outlook.com [52.101.229.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9325B606A335;
	Tue, 10 Nov 2026 11:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9325B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=S+mflxit
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDnDS4W4nUY45i5XB2YLVcOe2Bm1Y1SZAUcq3CjGCq+pF5o+9tT8qPr+rYoIqNfREtpgSKo7esjOzYL267vaJAWVGwPiYTTUd2ZU2FYSgNSZnsI7nOxOt/SfSf/ga8aBnBMrm3gYIU7r5FjFedZFA420w51fHuYCZvjdL+SRRw1R8VUhE27zp5IW26QY0a0tLG8ROEST/3xV8PAgmrdl5FBWborR/dPDU3TfLK99Yapy0GMl8eblTdOb22DtghsYfB0fVntXYC/PzNiXRwyFx62HntDKfTrbsRSXVyzQPNM8B6pN6sDFhFB2v2daS0cirPigv0qVPzeyziPJ/aXLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGoWfjD43iXBphEGvoWJbo1Y8/vexMojq0Bsetb94Aw=;
 b=APkMCQlUisRD9pkAJA0i8QJC+CUXzSbKjvuoBo+xxsjVe3oRwrTCTAV8SXbwDcJ8SHZK7wud66h+TM9IlBm+rFq/SDUzxcach4ZuafdLMXKBfn1+lT2nxA2aheJOwPxq2S7rQHLL19THPBqxNYfGmKVbdawoWxG+9pyAvhfJDOx1J2ozQiBHKjzEqlwgb0Rt3a7gchQZF6sa9e2zBK2np167DtwTh/8dvF72G2UbvdIBSDSbyXnXRlZ+qTKVq+NW+gkvVUXmEWhuK4cIWuvqQac9LQG/CmXPrQQH7qLT4yqjBm7wsMWXVcfjG2wfeEGzFmK7wHEcInLMOWd/rU4l8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGoWfjD43iXBphEGvoWJbo1Y8/vexMojq0Bsetb94Aw=;
 b=S+mflxittHpCPLLT1Jw5KE1tLvb7K7ZP0PpvLYo2xN9xg8NCMAfUEr9pWwLzveWsmyhIMJGrCqniCGawTWoZZcfQKM5P3CVT9FNpkfSaipkpeg6S2fKM7zAia762OhRCfRwCxTElE8hhQ1wN9i6W/5DVT0X3X1t86ud5TxP7Z8s=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB13340.jpnprd01.prod.outlook.com (2603:1096:405:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 11:40:47 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 11:40:46 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, Marc Kleine-Budde <mkl@pengutronix.de>
CC: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>, "mailhol@kernel.org"
	<mailhol@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "magnus.damm" <magnus.damm@gmail.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, "Claudiu.Beznea"
	<claudiu.beznea@tuxon.dev>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v4 0/7] can: rcar_canfd: Add support for Renesas RZ/G3S
Thread-Topic: [PATCH v4 0/7] can: rcar_canfd: Add support for Renesas RZ/G3S
Thread-Index: AQHdcQPq+biG69jEFUiO0W/B028fhLcnKxqAgAAC5YCAAAB3IA==
Date: Tue, 10 Nov 2026 11:40:46 +0000
Message-ID:
 <TY3PR01MB1134685B707947CCC7A0ED12286722@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260929-loon-of-remarkable-romance-197df6-mkl@pengutronix.de>
 <CAMuHMdUE1Jh605kgj4ADU7p1UjE-0u3ydBehL_5wsQPbe1EPMw@mail.gmail.com>
 <20261110-urban-bald-mastiff-d3cc34-mkl@pengutronix.de>
 <CAMuHMdX-jMZ+cxq54DdECVHTN+noavo0RfW8vv+GAgoxUyEkqg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdX-jMZ+cxq54DdECVHTN+noavo0RfW8vv+GAgoxUyEkqg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB13340:EE_
x-ms-office365-filtering-correlation-id: e55cdc63-b4c2-4443-aed9-08df3f1f7603
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|23010399003|376014|366016|18002099003|22082099003|10067099003|38070700021|4143699003|11063799006|261009223027099003|261026121527099003|56012099006;
x-microsoft-antispam-message-info:
 85OBaBr4W8+59EjpIXBBQrYb96bE7KgRKAocaKrMFC71LZOQqCmWm2PvtrO3zlNJTPvN3m1dg+ze/7JEByMG0in0po7roPwPCrTB26BYTqPAUymdh1cJggtRj3zWlm4ZwBmfb2a+Iym23idw5dTeIVXjl6rTf1IWqBcbe/pcAR99RKg0IByZ4FoCekRfUI3GYLn8Xo0cPYRA4imVl0Lj9hhGQv2tQAzvbt7mXvzx1POmyVVeQ5k6P1EOPGeEzq2hC07mepOwkj1raV0iE3tQqysCO1MeqsEarr+cyxSDl58iZ9VCZu3aII5t+QCMMzEKnat/62UdEkvL7+sqSyaBkpm4Yb1bWzgXf2eGDVVrmLg8Qv5y9Z80Wgtpee8+HqHspopbdv31bQJxnv+FMoyS1Jog1vFPeFtgQoBu1HmqlQrw6OvpC0isR8Rvto2xlpUURwG0w2Ua75JosqLcETdQchXjwy+H8+N7ZiSlieREkg30vivCqTbhI757yZOdtxRRtrQpFCC7f/UR6uvCoE8I5uCZIECkSQpGCaQ5awz04zXRz197otf8zVRVzlATb/HbN2ciMIJdNKw6irX9tjgrWOKHzPEeMrxIlrUotS0Sh3D7IKN29d/qvOXQ0RyHlpuOD+o8POAz+5qgymUWUDsbVdNc2vodTCeZ5wHviB+2RRmp3qThhMuliVT9n2mlElHe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(11063799006)(261009223027099003)(261026121527099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzE1Q1pDZFVjbUZWUjRMSTExWFMzK1h6aFBwb1hpS3orVlpISHVIYXJrK2ZJ?=
 =?utf-8?B?RjZMdW5IUEllUkFDMDdCbk1DaGU1R2xSeTQ0M1kwM0h3QjJJdTg3ZmR4cHA3?=
 =?utf-8?B?b3ErOS9KckZxK2VJOWo2TUl0dDRPZG5hbFhSNFNCVEdaMThnVU52QzZNd3pY?=
 =?utf-8?B?L1V6MkdBSEhKNmg2K0xMOHhCQ2RKZndtTlk5UHFraWZUbmwrVmg4SkhPS2ZU?=
 =?utf-8?B?UExEcFBiTk4wK3pXeXdqREFLQjdoZ0RCMGNRazA0VS9PUmgyMHZlRzlCWExN?=
 =?utf-8?B?RGRRcGRhQzVsKzRrQVczWC9NYmVJcHIzVkkvRElSTEtpUXVGbUZoc2F0aVdN?=
 =?utf-8?B?OVJYcUNwQVZkbHlSOFZqUlhIZUo4VTRXcWxKZ0wrOG5HRkRzelhaN1JDTWxr?=
 =?utf-8?B?cVd6UlVJS3cwR3l1dXdOWEh6eUttVjMweTNBYUdBdnYrT2Z3bkc5OFluSVBZ?=
 =?utf-8?B?dFp3dS93VENKMnJmcUN3RUNoa3lnZGw0V2s1UWt0MEJNNTB5NkxUVUFIeHJq?=
 =?utf-8?B?Slp4U1lLVGRjOFVKbW9EeFZIZFVFWHk3S2VDaU54Ly9WbG5EOWhNZ0dzaWxF?=
 =?utf-8?B?d1pzSk05WStlMzBFU1hVZ2ZrakNkOHZWWm5nSVk5MEdWSUdJZDcxNFlWazA2?=
 =?utf-8?B?dmZ1dGhUUWhGc3YrWDhkN2dkSnRlZ3lrRTIxNEdiMUg5TmtIcDYrSWxxbmV2?=
 =?utf-8?B?blgyZER0cWM3K3FLS0MzUEJZMnpkcUFPaWR5ZHIxZS8xelNrdVVrYXppNlpL?=
 =?utf-8?B?M1ZDc0hESkZJaFFCaWl4dzVHMlhudWpmRm5UMFUxcDBiM1Q1NlJEQnN2Ylk5?=
 =?utf-8?B?V2VhSlpNWTVFS0tkRmYvUUpMYVRtK01LWWRDdllDRFgzdDNXbzhtZEhFaXU5?=
 =?utf-8?B?akR2RmVoNDNPb2FFVG5ENVR3OUpTNWtJanNRbUJ3NHoveUZVdnliOHF3aW5Q?=
 =?utf-8?B?N0RUMjBzUnNGTTlGRldCVGVhQjVtd2JsWldINGhYcFdrbWtWVWpRREVHOHBx?=
 =?utf-8?B?aGRkSGx0dHVtV1czcjJGaE1aRFFWbk11OUl3MTdEVlhLVW5tajNNbm1IM0h0?=
 =?utf-8?B?ZVY3U0tvS1JtYlAwdU9ScHNEK3FnRk1wMXlUczFwZjhBWXRFUDUzd0tzMmI4?=
 =?utf-8?B?dEgvZHlKc3JDZUUvWlVoTFJ1NkRrOUNUUm8zem4zWjhsdkpUcXFsdW9xSWlL?=
 =?utf-8?B?a3FzZ1Zmck45ZlNBdnFHaHp0R2FyOThMWjFCSUNwTGVBZWhiVGh1eFRHTnFV?=
 =?utf-8?B?SFBla0llSWFwTjRTdDRHRnlhNm5ZSnROaGVTVWpEZi9iL3c4YWFoWURKVS85?=
 =?utf-8?B?enRkOU5Xbko2M0V2SkxuTHdlWkhlaWVrOXNpbWxWcVhUOVdTUjUya2NkVlF6?=
 =?utf-8?B?TFhIVVZzTmpNSGNMK2FkNlBicVpHN1VEcWoxOUhidGxycWFGa1ZaMUJPUW5z?=
 =?utf-8?B?Y1JNT2toTmJ4VGZvbi9mOU1FaWhCYmg2ZndpK2hlaXZ2SzF0dUlsYjhIQ1d2?=
 =?utf-8?B?aEJkeUJHbDJpWXpSZWM0eHdGU3ppRm9LVXRaY1VtYXc3KzlzZUVNdi9JTWVD?=
 =?utf-8?B?RWU1SlNFaHVCNXByS1U5L2RTalF0alRoc0NKUkpzVVlhTXhYQmUzMjhNZkZt?=
 =?utf-8?B?WUtaZDVpYzQ5Y0ltYXlhUlE3eHdyYmZRdXBvR3BRV014d0s1NEVTNkNxUERO?=
 =?utf-8?B?WXg0NHJ2Qm9DMW9lRUJVczVrNlJ3V2dHU0Rmd0doVVdGQnFLMExteWZLdWxm?=
 =?utf-8?B?UHNGUkZGSnlVY1l1MENkbEprRzNDSkJnN1VLWDFOR0tYSURiNkVJY0N0MVdu?=
 =?utf-8?B?U0ZVR3Y3TlhRVmJ2RjJpMm1pRkJEY3BjclAzSCtBODJzYlVpY0RCMzdDSmJX?=
 =?utf-8?B?QlhHQ2tWOHlCc3hNK2lNT240cW5pZkpFMXZsVGVYLzVORjhGTmhyOVg2MW91?=
 =?utf-8?B?SnM2YTljTFdTQ2xObG1oK201SzExRmJabnhHR2RRSWJRd3c5VDJQb0tqZW1Q?=
 =?utf-8?B?eVNtaVJ6Sll6ekpvMGNVejZoRElpVEF3cDZsRnk5ZGwxOVNOSk9zdkIvUHNY?=
 =?utf-8?B?emxnQzJYUzQ5VzZQSDlGSk41ZzVsR0Q1R3g2WmZmeHFNSkFzVlV2L0RENXlR?=
 =?utf-8?B?MmdjMkk3S2MzRHVJREc3bTk0T1IzNzVidW13Y2ltN1lmQ1NYTjg3RFF1QUJG?=
 =?utf-8?B?Qyt6RklOV1NUK0FxeXFyTUlrOTM0azdHZnFuNGtpekpXZjB2RzFLUmR3VGZo?=
 =?utf-8?B?YWNWK0FYV2FuOUVFNkg3UjllTytyNnlJVHVDNTBqbjFSQWovajFNcGNXRjlZ?=
 =?utf-8?B?ajVsVzhyeHRXMDI1VGg5MGtvRm1vSXdhWW9ZZmxwQk40VFBHMlhhQT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55cdc63-b4c2-4443-aed9-08df3f1f7603
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 11:40:46.5556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4Q0DY/M3sN/Vj6mIIGs4/yIfZyv5JrhaTy7xdDePYwMIM+QDDQ6aaakkxSHKKkgoP98j/UD7rgSZe41OPcQeDm73Ggvtcm5IybFnGX5hwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13340

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMTAgTm92ZW1iZXIg
MjAyNiAxMTozOQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvN10gY2FuOiByY2FyX2NhbmZk
OiBBZGQgc3VwcG9ydCBmb3IgUmVuZXNhcyBSWi9HM1MNCj4gDQo+IEhpIE1hcmMsDQo+IA0KPiBP
biBUdWUsIDEwIE5vdiAyMDI2IGF0IDEyOjI4LCBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1
dHJvbml4LmRlPiB3cm90ZToNCj4gPiBPbiAxMC4xMS4yMDI2IDEyOjA4OjQ5LCBHZWVydCBVeXR0
ZXJob2V2ZW4gd3JvdGU6DQo+ID4gPiBPbiBUdWUsIDI5IFNlcHQgMjAyNiBhdCAxNjoxOSwgTWFy
YyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4gd3JvdGU6DQo+ID4gPiA+IE9uIDAy
LjA5LjIwMjYgMTc6MTU6MzcsIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPiA+ID4gPiA+IFNlcmll
cyBhZGRzIENBTiBzdXBwb3J0IGZvciB0aGUgUmVuZXNhcyBSWi9HM1MgU29DLiBBbG9uZyB3aXRo
DQo+ID4gPiA+ID4gaXQgYSB0eXBvIGZpeCBwYXRjaCB3YXMgYWRkZWQgb24gdGhlIENBTiBkcml2
ZXIuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBNZXJnZSBzdHJhdGVneToNCj4gPiA+ID4gPiAtIHBh
dGNoZXMgMS01Lzcgc2hvdWxkIGdvIHRob3VnaCB0aGUgQ0FOIHRyZWUNCj4gPiA+ID4NCj4gPiA+
ID4gQXBwbGllZCAxLi4uNSB0byB0aGUgbGludXgtY2FuLW5leHQgdHJlZS4NCj4gPiA+DQo+ID4g
PiBUaGFua3MsIGJ1dCBzaXggd2Vla3MgbGF0ZXIgdGhleSBhcmUgc3RpbGwgbm90IHZpc2libGU/
DQo+ID4gPiBTYW1lIGZvciAiIFtQQVRDSF0gZHQtYmluZGluZ3M6IGNhbjogcmVuZXNhcyxyY2Fy
LWNhbmZkOiBSZXN0cmljdA0KPiA+ID4gcmVzZXRzIGluIHRvcC1sZXZlbCINCj4gPiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnLzIwMjYxMDA5LWhvbGlzdGljLXdhcnBpbmctcHVmZmluLTNiOTJm
ZS1ta2xADQo+ID4gPiBwZW5ndXRyb25peC5kZQ0KPiA+ID4NCj4gPiA+IEFtIEkgbG9va2luZyBh
dCB0aGUgd3JvbmcgdHJlZT8NCj4gPg0KPiA+IEkgdHJpZWQgdG8gZ2V0IHN0dWZmIGludG8gdGhl
IGxhc3QgbWVyZ2Ugd2luZG93LiBGb3IgdmFyaW91cyByZWFzb25zDQo+ID4gaXQgZGlkbid0IGhh
cHBlbi4gQW55d2F5cyAtIEkndmUgcHVzaGVkIGFsbCBxdWV1ZWQgUmVuZXNhcyByZWxhdGVkDQo+
ID4gcGF0Y2hlcyB0byB0aGUgY2FuLW5leHQvdGVzdGluZyBicmFuY2guIEkgaG9wZSBJJ3ZlIGNv
bGxlY3RlZCBhbGwgdGhlDQo+ID4gbGF0ZXN0IHNlcmllcy4gQ2FuIHlvdSBoYXZlIGEgbG9vaz8N
Cj4gDQo+IFRoYW5rcywgTEdUTSBhdCBmaXJzdCBzaWdodCAoSSBndWVzcyBCaWp1IG9yIENsYXVk
aXUgd2lsbCBzY3JlYW0gaWYgc29tZXRoaW5nIGlzIHN0aWxsIG1pc3NpbmcpLg0KDQpZZXMsIEFs
bCBPay4NCg0KQ2hlZXJzLA0KQmlqdQ0K
