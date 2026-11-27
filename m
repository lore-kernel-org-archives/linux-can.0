Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795781399;
	b=G3VmSNjQaDskg+2AQquD9q+YD8nPikhSsxrOmPc2EhNwQMd8MscDDbjATz2WoKG625hw
	 ZfUs4y6+5FMX5NC/3wOcKpJMhBoDLQa1Y0Oj7TDE4Khmv3AnWer8XkBcKcf+XQtuQV9HU
	 Uqjt3r9rSgdgk8cDVImMmu6W/5wCs01A2l+UGB9l6ZRfUhO8cUBpM9ekQCLtpp5r6S45D
	 SPb8kt/y6zuhuTJ/QqRzJ3ljIpBMlqas32FEsYu+zDiSy7VlU9sN7M+s7E9zZU8BprcIW
	 of2sNvHffrOrHv1s/VjF3OiiTDoYD/PKmweNg01vLNujJ4MGWo/6iuuHPSgi02WRt6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781399;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-traffictypediagnostic:x-ms-publictraffictype:client-request-id:
	 request-id:x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BllV/BR5dbZaNuynhCv7czLcrDKISb8Ua6EaXZY7nLw=;
	b=zqFGxcpxXs+N23wALOJEiTFI9wr+4PFTt2ljqRe4KeFakYRIIoyUpfFTn/AyH4Hr8ZDo
	 IzhgGcqJ/PI0pTEGSoQaryRx8iQP7N6weSBFaXHmfIpq7dieaguXEiQgTOFj58XlgJpsa
	 Tl8JCfxFg0hbHOAhqXtfB+Duopls+OloCM2bVHLYxBnKytqGUVHq1DPZjBGincAKr3IjP
	 KVW2pPsMSqwZ24P0knRQ2ll2HzrTtSqW3Ttv0yQ6hnO38sjGSI+K1RmUeRiGcyMVo/Ba0
	 1TrjIT+z2Mh82+iS+xggh+pLY4q+KtFpoA1/QvLDWQhUaKnYo298ZGNFmK9IOm+SN2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=f2oL5bQY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.80
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022080.outbound.protection.outlook.com [40.107.75.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED1606A31E;
	Fri, 27 Nov 2026 12:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CED1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=f2oL5bQY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQ2kR1ZHwdd17Xz6D+J1xnXx2LTfeGc03HoCfyIqSgSzp4DtWhxQesaQ3cBzTm4S3rDJ5KWJ3vc+c9GcjSod+V7qfEj3dJ6NtbGh5zqWG8OYYFfewdhxyS9A4Z3Iuilp1WZ1rq+e7OFN/QwyWhsLQSSQeVZrzfXtJU8ksslvNMMm9JFMOUoAgYy6qmbs2fRn7anWZboM8KnfoQi3KxUZtfM7QVhcNAYf8vdCaeyemdfd1dpsISLELgZUGEXd+qWGdr8MO2mlXV/MmEEUDAtQmgfMmaMNyiPaw2EHSadGiIfFXW1eS5gUIeiu0T+rmiygr2kQmWFkkULPNtZQ3OgIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BllV/BR5dbZaNuynhCv7czLcrDKISb8Ua6EaXZY7nLw=;
 b=OZHa9eLR4aeK4rKcvObE6W7m/IfWCUbSl/MhbvmcQWcjUCljj3g8hUm4A+QyKPMda2Y5mYqwFcivyFedzRR5lQ/DEBEhWEcpUiU8pjf/bzFv8WZhT0BEzVWODc28JHdRT55eg05n0K5K50/Ii0ptkz+ljAbV88NrIQerua1qbTkIBL0A2nfvDO8SjflIbsmGOll5tAcuOh6VA2mw313La6ahTx7huGr7i0BQYfyr3aL8Xy2ps7Oi+0o8ucrBRmqC3JaJA6BdhM3Wov6e/WYNJKIM1Rvq1Mk4WwtEUoK8U8WShIw1NMu+BJxusM0MWQ/n44o5fUZsyQyaygB32NA0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BllV/BR5dbZaNuynhCv7czLcrDKISb8Ua6EaXZY7nLw=;
 b=f2oL5bQY6vCD7r3GCP2hefTJxUxgQ+fThimIPDLIIx7vX8SC4XGiZODAaY6+AErXDh8DhDBNIPcM/n9xG89QIG28OZ4kchOEjExs3LTUWjqO0brvuUVBE5kjT4wknO3xUDKR7WXVL7aBSAROdME/p9NKL+jsjF7kTZX0f7cFjE/uyUb9O62A2yl8yTZFap9LOn71fi24oPLSNIgCxH+M78nQVhIdtnFkoCKGJ7AXthEaTCi+cvUiU8Lsy1l6gzT1kJ4hTXZxx/jpyBYfiaGbUJwj9xd1ezn/t6jbsiL7TIHIe4+iRIieC39uJL2Fmfy5pqNJaXaNM3SWpyPkNxM5xw==
Received: from KUXPR03MB9689.apcprd03.prod.outlook.com (2603:1096:d10:5b::12)
 by SE3PR03MB9489.apcprd03.prod.outlook.com with HTTP via P2P; Fri, 27 Nov
 2026 12:09:55 +0000
Received: from KUXPR03MB9689.apcprd03.prod.outlook.com
 ([fe80::dd25:455d:8d52:bc12]) by KUXPR03MB9689.apcprd03.prod.outlook.com
 ([fe80::dd25:455d:8d52:bc12%6]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 12:09:54 +0000
From: Zelong Dong <Zelong.Dong@amlogic.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
	<khilman@baylibre.com>, Rob Herring <robh@kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Vincent Mailhol <mailhol@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-amlogic@lists.infradead.org"
	<linux-amlogic@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>
Subject: Re: [PATCH 0/3] can: amlogic: add support for Amlogic A9 CAN-FD
 controller
Thread-Topic: [PATCH 0/3] can: amlogic: add support for Amlogic A9 CAN-FD
 controller
Thread-Index: AQHdeMZagdxxTxakm0mrN3rBKukIW7c2nwcAgAs/sYA=
Date: Fri, 27 Nov 2026 12:09:54 +0000
Message-ID: <6dd79fd6-1504-42f7-9600-d915162acf53@amlogic.com>
References: <20261120080820.3340646-1-zelong.dong@amlogic.com>
 <20261120-positive-strong-rooster-bb80bf-mkl@pengutronix.de>
In-Reply-To: <20261120-positive-strong-rooster-bb80bf-mkl@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic: KUXPR03MB9689:EE_|SE3PR03MB9489:EE_
x-ms-publictraffictype: Email
client-request-id: bb2e7103-eea6-47ac-b7b1-e7f2acd99d58
request-id: eedca984-dfa6-40af-3451-08df4c7f5901
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|4143699003|11063799006|22082099003|18002099003|10067099003|56012099006|261026121527099003;
x-microsoft-antispam-message-info:
 UYDHg87ahKcU71mLIBV1Bd+JApeTB75nHgljDBGgSoIooke0SffTReHJiNwjKYsbbinYnEHP5/9qhVCF3Q/pCIR/3LcPZRTqgmIv6kUTYWMrikp6OV1Ot1TMU5pnR7FJ26mVmpWa8YVuLM9if9Ts2zGok0pDtZSZ5h2paP2WokeTfWRfmYLJNvYBxRPyR1LXDSf+MbUfDeMUogyHtcDiYAeaT1gO9/N/+UOeYwR/T9gvPP8RnUk+mUCwRu0UO4o4VqTa8IkZGb67Ht5I+zTW1EWADVZK3KKrbdp7D7tHZTO7Et4nbXBBX1nrgcJvjXCXVRy1RCEaPQAgutlOkeBdy/8gC1Crah2CfYlhlMXOREFphkcxDD0qLY+VZvgYS0ltKTBpin0ZuTDDPo+hRfztNqTgtwm1fMblyR+7wenbY1nxzHjtg/Wd4R2RpHGNnqI/2oAJNZrUdCqgdV/ZX2b0U1LoVPRR68zwXPo0rqYzhss2ndDdoS55ajGPR3m2lZcCI1S3ErbKotViZMQd5ZFXr1RxI1f5QxMaXXYik9RRSbCb5gpp7DccSfUakr+TtqOG8SdM3/SPlnKX/ylMrGlnNrqKypxzrlU9sir4KydG2mrXxM2UHo3YFnc2rW3m5TNAQbcdrj+HeRmpr0BguL1rjYiC+dgqoi7OI8huB5KAPe8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(4143699003)(11063799006)(22082099003)(18002099003)(10067099003)(56012099006)(261026121527099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWh2UUd5cWRwN2FMelpIRlJiYm1XUU1LeDdTVkhGaFlLY0t6N2tFZWl2Mnhr?=
 =?utf-8?B?aXRRY24xbXFJQnkvY29qbGtOV04wanlrTDBLdjlJUVNqS2E1cEJZR3BIZERi?=
 =?utf-8?B?b0IzdEhtdG4vTHVneXRDZzBnU09ERzNjcU5PZTBaNXlMMkozZENTNzRHUkFi?=
 =?utf-8?B?MngxU2d0dWNYdXVINjNzN1B0OVNuL1R5WHB4M1VBaWpCQk5ONmZTbkZhN2JF?=
 =?utf-8?B?SkQvY2lVWmhobzVFeE0wYTRiWmx6Q2dSaUtVWVhKVGNGNnBWK3JMTmR5ajQv?=
 =?utf-8?B?ZjUxMFVrV3FZb2JlOGdrVzYzYUh0bkZLVEZrdUI4OVcwUG1nU0grS0hoSE9p?=
 =?utf-8?B?YnUxeW5sTHpyeDVDZjJzdFFRMTdHMW9zNy9DZm96ZmpBQU5rU2tIcUZVeWs0?=
 =?utf-8?B?cDhhc0o0VG9PYis1NVZ1S0FHM0ptL2xtRXhxU1NBc3hZUjMycWViMTRXWGkr?=
 =?utf-8?B?aGJFemR4bHBNTjJtSkkvcE1BUGJxTzE5UjRlSUx2Z3NKVmY0VEc4OXFSYlNh?=
 =?utf-8?B?ZkplUDFmVGpwQkc5aFBBcXJjcTdBQkNXY3FJOXZVMmt1c1pyTnhSdGpzdjlD?=
 =?utf-8?B?RHkrbFNqTlhGRVN3YkNrUm5IL0VUMzF5THJXR0NJQTM4Y0k0dHdtSUV1VWJP?=
 =?utf-8?B?ck5DN1IwaG1TRTJrUmw4NWFTeDNncExHdE1obkRPWnZMVWJBL3dzYVFRMmJW?=
 =?utf-8?B?cjgwcUNUaGd4Z1NYaXJYN2k0bkptTUJKdXZ5OVlCUG1vRlo2ZWw1emQ3RGxE?=
 =?utf-8?B?YUNzclR6cVJia1pTVGdvbzhtSlZ5a1p3UnNsYjIvZDAwMHNVOC9EdkRYR1c5?=
 =?utf-8?B?RExYbFk3Z21ENTFCeko1MXFGTGVtWldoOEpramNpQUdic1F0TzBBNUJXNGNh?=
 =?utf-8?B?UWtvTjZ3d3I3Vkk0cFdDaWJpSHV0U1EwYUVrcHhBeUJCM3lBOURLdVlYS3I1?=
 =?utf-8?B?bXRQUHVYWDJ4b3daNVpCamhuYk9ZREdtUktLd04wcDRNcTRDUXRlYm10cGd0?=
 =?utf-8?B?UlVsMFVwKzBITndxRVl2Y3UrLzdTb0RocWlyWFhMN01HT0VvQ3gzZjFVUGpj?=
 =?utf-8?B?M3hmREpKRHBLWEZwMEhoTzRoakdUUlpvMWdldWptb1FoUnRBZTBBMzZFMnVM?=
 =?utf-8?B?R2tZd0hiMnFseWdDblVveGN2T0ZDVWh1ZE9CbWJ3dHRpNU1sTmR1RUpkKzA0?=
 =?utf-8?B?cXdDVkhKOUhzTGllRzJwVVphMk5oRlhaYnovT1l4YnkvTXNFWFhZcWRrZ0E5?=
 =?utf-8?B?L2hDMnUyd0xzMStoR2NoTHJoY2VIRER3cG41WGlaT25aZFVvQ0ZqZnNrRGlx?=
 =?utf-8?B?S3VYOTF5MGFHbk1zVVlpQ1A3K0JRdmZhUDAxS0loTFA4ZzdUM2xzVFF6QVpS?=
 =?utf-8?B?QWluODhHS29BWlpkejRPR3laeWRtdUNkUHhJK1BBYUV5MFo0MndsSHByRE9i?=
 =?utf-8?B?eCtPWHhISnBQNGMrUmoxTElQNlFudDlTT3VJNlVFc2dPR2xYSnVYdWRad2I5?=
 =?utf-8?B?WUhpRXhKRndRZE1LY0hzenRyZHRxOGFoVXM4eFk0aU84djhkYityRm0xRlM2?=
 =?utf-8?B?MXkrYlpzOFA1SUF4K0EvTktjT2tGSTA5THpKMlYwYTMrS3RlNllud0k4c2dY?=
 =?utf-8?B?MmN1SllnQnpMSG5rMG1RUzRBbGo4NUtiVXkzZkt0Nm9tbVMydXdTRC96RDRz?=
 =?utf-8?B?bHJmQ3Awd0k3aDVvMmJ1Nitab2ZFcFpQZUxEemZ6ZkdpUVoxdks1RCtQbDMv?=
 =?utf-8?B?bGJ1WGt6RExsN3M3SVhLMjlrYVhheklMZ1I1Q2RuT3JmMGllMjU5ay9ubTJB?=
 =?utf-8?B?Qk84ajQ2U1RVM0Q1azFsRDM4MktPNXZmZERPR3dPY1BTTTdCVyszd0JMWlJC?=
 =?utf-8?B?V1NuTjFSMlNtNWM5ZjBKWndXWUtrR2VNMVBGODl4cnlNN3NQZE55SnNReGVi?=
 =?utf-8?B?RXAra3JINDNOd3JBelFRTTc2VjUzeDR6SXdSdy8wd1F2d2RVREZBcGhzUU9L?=
 =?utf-8?B?VkVOZVFFQk1oSU9mMEVIUDR4T0NrQ2hWa05zMDRVcVJibVBSejUrRjRmdm5t?=
 =?utf-8?B?VGpIc1gxc0x5WTFHU0R5MTNJVm0vemdwVk14a0J3MWZQUFNzRGMzN0w1Z2pt?=
 =?utf-8?B?NmxoU1ZWRTlsQndaOVB4YVNnbUZCZUhEUTkzWEdYQlpjUDQyTzNCL0lUNUhz?=
 =?utf-8?B?WkpsblFJdHhKMWpaUjVobXZZdlRWRjBjS2h3UWRYbUpWQzg1WHI2TGgxVC9m?=
 =?utf-8?B?cjhYNEp4ZTlsOG5MUkEyTmRENUZ6Q3dZNkFXa3Q4N256YnZBN3dHK2hxTmQ1?=
 =?utf-8?B?NHYzdHYvenViK0Y4SWpubjYyZ2RrTUpaV1ZiK2VFU3lUd2Q1dSs0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C99B8A57BE6B294485A4A66413949DB5@apcprd03.prod.outlook.com>
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
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUXPR03MB9689.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedca984-dfa6-40af-3451-08df4c7f5901
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 12:09:54.7584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58LjOwuXZ+uRnCtJHuz9YCT7YaKCp2Mg7p3YerPoMaJswhjdOGmN/ieOZZ3/ezzVcs4x01bsGcmRYh6+RRiLbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR03MB9489

WWVzLCBBOSBDQU4gQnVzIENvbnRyb2xsZXIgaXMgYmFzZSBvbiBGbGV4Q0FOLCBidXQgc29tZSBy
ZWdpc3RlcnMgYXJlIA0KYXBwZW5kZWQsIGFuZCBub3QgZm9yIE5YUCBjaGlwLA0KDQojZGVmaW5l
IENBTl9WRVJTSU9OIMKgIMKgIMKgIMKgIMKgMHgzODAwDQojZGVmaW5lIENBTl9UT1BfQ1RSTMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4MzgwNA0KI2RlZmluZSBD
QU5fRE1BX0NGR8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMHgz
ODA4DQojZGVmaW5lIENBTl9UTVRJS19DRkfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDB4MzgwQw0KI2RlZmluZSBDQU5fVFdSQVBfSU5UX0NMUsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgMHgzODEwDQogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogMHgzODE0IC0g
MHgzODE4ICovDQojZGVmaW5lIENBTl9USU1FU1RBTVDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDB4MzgxQw0KI2RlZmluZSBDQU5fV0FSTl9JTlRfU1RTwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgzODIwDQojZGVmaW5lIENBTl9NQl9JTlRfU1RT
MMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMHgzODI0DQojZGVmaW5lIENB
Tl9NQl9JTlRfU1RTMcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMHgzODI4
DQojZGVmaW5lIENBTl9NQl9JTlRfU1RTMsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgMHgzODJDDQojZGVmaW5lIENBTl9NQl9JTlRfU1RTM8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgMHgzODMwDQojZGVmaW5lIENBTl9TVFNfUkVHwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAweDM4MzQNCiNkZWZpbmUgQ0FOX0VDQ19F
UlJfQUREUsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4MzgzOA0KDQpJbiBt
eSBvcGluaW9uLCBGbGV4Q0FOIGRyaXZlciBpcyBvbmx5IGZvciBOWFAgY2hpcC4NCkRvIHlvdSB0
aGluayBJIHNob3VsZMKgIHVwZGF0ZSBGbGV4Q0FOIGRyaXZlciByYXRoZXIgdGhhbiBhIG5ldyBk
cml2ZXI/DQoNCuWcqCAyMDI2LzExLzIwIDE2OjIyLCBNYXJjIEtsZWluZS1CdWRkZSDlhpnpgZM6
DQo+IE9uIDIwLjExLjIwMjYgMTY6MDg6MTcsIHplbG9uZyBkb25nIHdyb3RlOg0KPj4gRnJvbTog
WmVsb25nIERvbmcgPHplbG9uZy5kb25nQGFtbG9naWMuY29tPg0KPj4NCj4+IFRoaXMgc2VyaWVz
IGFkZHMgc3VwcG9ydCBmb3IgdGhlIENBTi1GRCBjb250cm9sbGVyIGZvdW5kIG9uIHRoZQ0KPj4g
QW1sb2dpYyBBOSBTb0MgZmFtaWx5Lg0KPj4NCj4+IFRoZSBjb250cm9sbGVyIHN1cHBvcnRzIGNs
YXNzaWMgQ0FOIGFuZCBDQU4tRkQuIFRoZQ0KPj4gZHJpdmVyIHVzZXMgdGhlIGdlbmVyaWMgUlgg
b2ZmbG9hZCBpbmZyYXN0cnVjdHVyZSB3aXRoIGhhcmR3YXJlDQo+PiB0aW1lc3RhbXBzLCByZXBv
cnRzIGJ1cyBlcnJvcnMgdGhyb3VnaCB0aGUgQ0FOIGJlcnIgY291bnRlciwgYW5kDQo+PiBpbXBs
ZW1lbnRzIHN1c3BlbmQvcmVzdW1lIHN1cHBvcnQuDQo+IEhhdmUgeW91IGhhZCBhIGxvb2sgYXQg
dGhlIGZsZXhjYW4gZHJpdmVyPyBUaGUgcmVnaXN0ZXIgbGF5b3V0IG9mIHRoZSBJUA0KPiBjb3Jl
IChhbmQgcGFydHMgb2YgeW91ciBkcml2ZXIpIGxvb2tzIGxpa2UgdGhleSB3ZXJlIGhlYXZpbHkg
aW5zcGlyZWQgYnkNCj4gaXQuDQo+DQo+IENhbiB5b3Ugc3VtbWFyaXplIHdoeSB5b3UgcmVxdWly
ZSBhIHNlcGFyYXRlIGRyaXZlcj8NCj4NCj4gcmVnYXJkcywNCj4gTWFyYw0KPg0KDQo=
