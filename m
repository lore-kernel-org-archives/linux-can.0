Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F914A2A44;
	Mon, 31 Aug 2026 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186902; cv=fail; b=RpHfrZkUKTxhWBuu8bERkydzquNtIxfuQPkOJU3mHsjqlo9JfrID/aGbOPiAyGZEtXD2i1H/WFNlVDfMeaxTAx0KvfujoDwLL5/yP1boV8vpawBpPr9kuEmRR8aqBqbZC9AO73nk1JfjjB3bMEblcHetP2cuGuMvfF1MMZwU6YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186902; c=relaxed/simple;
	bh=1upDEasXsZkAK0im+GIkBFqGG2oU1/fr19aNvoErZ4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LzPwzYc/IQ3Tlmpq+YcpVZb31byi61Yc53NlVqV9P0Z7nhPbgAEbqJZbChAR8hOH+RsWoqiV/ITheaUB4Hzir8yOn3SNC1HXT3yju0YYFizs/nu6xjdCa/mbGQyY5X7q8yGOC49yitmxHheBgnglDmZO0Ya5Dh4Ja8k4nZHkHQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MWRbo/EX; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MWRbo/EX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joUx/jAJEDbHeiEl/k0UrT07MnXYY7mFM+ki3t8Bj8lhtZu792nmPye2xrpX7EsZH5BcuWNEhpl2wFUGYK2jCvexOVKIqA1bG/bMUnGudwhE8O34FPom3AgCufb7dVoYllcPF9/UZ3UUPKfh17pYK5ggIl/xqn6m2AKi/BAByD7VNOQPQzLlO4cTDkWLDHLmoHcBu1CpbETaIOPMBHI12YgBrDLSx2daQuFi5H8eTHBqm0GzxSfVM559uOD04QIdQd04v2MINlLyCrUsIknCebQ4wsleYOL7Wt5DJusL0JJxLsCa9KuWPZHtThB3ymrp421tV0mnmo9sYSYitS3u7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfLF2os2kzzc35jZf3bjNKQLGWICLw+dnzgpzDvFcWY=;
 b=sL75+auCK8Ztvu9s9OC2TuBYqRVUzope4fWS18XZ6frSN+469EODwkOTBd4sRn+c595gEmSG30LK9Z/g11lf2eQcLBcySoPQu+1hDrBJ21BArCs92b7Ptx/cf+5psbajdyy2nAZmJTOnajLw3g4ii75WWUW2m8/sxRtHtK+hik5RwaA25lCAyATBaSL9rfv0Ysc85J95jTNSHdnEcAjVzEGKHzfgLWNVIdnY55vO/G88wUCXDF8Vs7GikXu7yl2HB+Pyvn3nT4ndeyg4SdM25TiWXU6eSCtwBfEwnPysx0o/F36a0aurB/44LKs5KmUJqbzHSy9DdJQXhFyTf4gKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfLF2os2kzzc35jZf3bjNKQLGWICLw+dnzgpzDvFcWY=;
 b=MWRbo/EXuejQfwDLlG44isVWKIxcEygsMLkJNB0qiM3XhqBwOTG0SPelbl7Si7mj0kZcBQkHMlAP5H8ZtUeBEaHQF4BXgw63LQCsbipC3JSlIGf/zOKeHZTqzbi9JfUNabDAkTT760MR80mXnHIZFcl3P1F8PihZPx7fA20NPoLN3SzTZ2vKW1fXvJlIggVcmTOsdpWfyT2fqS9QP/dzOujK/jNhJN3MRIi/ENfu+jX2zOHeXgXJzYwqOzQlRrvLEHDnZvshKNM5GMfg61hhoJN7y/hVIGqusDM0gJqJG1B5x9GoBlqbMMNzsHj9V8WLlElX+qggonBHnWzigPV7lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:34:56 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 14:34:56 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Dureghello <angelo@kernel-space.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v7 4/6] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
Date: Mon, 31 Aug 2026 16:34:47 +0200
Message-ID: <20260831143449.12828-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
References: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0175.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::12) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc12022-34ab-4403-049c-08df076d06f7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|1800799024|366016|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 pns5uMxK11EmXaaN+N16pUDcpvaYwtNecGqC4ys9pZiE0SFAUnFtMvomYy66Gc1JlnquqNlEBzzwYr86IKkm2hUoMbGRjN/Vy235o7B+wC9+fU77IU0RK74OSNMWgZSy/1JlsW4NCCyV50GxzjExJ9+2jeLjIIWVTmdvAprlk0PXrqHQOjrihLWcjyBh5sq406H632/cIRUKRW23hP+evmCi2it495z0MUy2pgWDd235iVsVibqaBjU8Xjo7f7isQQoNy8iLUye4xlcHLvs7jt6Nio98KA2vk0CPVsoLOEVjn9kDKoEH4iESB3Om1sDzL56ONrn+oVgf/n0qNxaCZhqB2WR30TkMHSVnNmrj+9royQxAHwb87O/KtPiwIe4TXWCpqkEvU4zh2rmCEZXcFh+tKnFJ9ZudN13FrlFa7tfbzff2potgG58jVFu8hKp9mRK7KG1rj6Xn10kOLA/FSIA+6/n6WAqPAcFIFiLl62atdMTZsXcH0XCpE0Z0pYz0DC4OYwNGbNKc74/lr5NkVyPpkFbbW7aflpTUReCg43n6VNz9BvAnVn5V3gSUBtyKdN7nstBPprqOxFvDqFgFYOM2c0z96FSUKifA3CAZXUDdKLwbu6iDTBmNTeQGtG4/MKH9AXJDvMd3hKXWxWVjhbNUuZcH9WOcfyxI+q0/ClQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(1800799024)(366016)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VUNOMUluKytDOVJKdDlsVVZaNk9OVmZydGR2NlQxZ01KVjRtbGZLQjQyUFlh?=
 =?utf-8?B?Z2JmLzZBRmtQcStNbzBXeDhmTFBqSm5KTzU2eUsyd0piZElhRGdEVzV4ajlm?=
 =?utf-8?B?dGlaeS92Z2FtWHNYWnA0MHJvaWFIZjRJT05WbnYzUWlueUt0RVlwT2twVDZq?=
 =?utf-8?B?bDJwZVJldU9BT1NoOE1rMUV5a2dPTENsWW92ZU5pK3FzR3VDMk84YWpFTnR3?=
 =?utf-8?B?aWFIaHczUjlGWmZJOFZ6c3Q5UzJZQmRIdENobFhRTTJraDJCWWdSeXg0OEx1?=
 =?utf-8?B?QUFpdDJtQkRHTjFOK2lxMmwxeE9wWEZ5Rml4bGx4Z3AzVzZuYXFYNllSZVpn?=
 =?utf-8?B?aDVML3lnczdBWW0vZEN0NVQ1dXJQcWU0UGU3bm9TUlBxZmgyQWpwbjhyOVlO?=
 =?utf-8?B?K0tobU5Fc0ZuNVIvcHdSTTVaRTdBRDk1YTY5aFNydklFTTIzR2dSOURFRFNO?=
 =?utf-8?B?V2hHS1lCTFRsZVhON2ZZTGNiQUZUUSt3dW4wNHpWMVVvTitmODViQUtQeWxk?=
 =?utf-8?B?bkp5eU5aQXJOSXg4R3pSQlI5Q3JQb2VSTVlnWmpGTzQ1VjQ4a2hWR1pzTlAr?=
 =?utf-8?B?TUxrSFBkZFVKOTM2V2ZhTVV1bE8yTTBFTzBKYm1CZHZ6dHhCdmhXQTJZeC8y?=
 =?utf-8?B?M2Q4M1ZEbER3ZTMxeDM4dk05bExiUXI3R3BPVXlibUFIRTlKYzRVcjBtNEdv?=
 =?utf-8?B?ejZva1Z0V0dJRit4VG9SVDJPVXRIWlo3U2F2VGR3ajU3ZjY3QVF2TzlQV3h1?=
 =?utf-8?B?WTMyaVBzR2VDVFY2bmMrU3FReGgwbHNlNFBrcDhORk9TVm1ldjFVY1k4U0U0?=
 =?utf-8?B?YlVSWnEvMlVLS1ZjU01jTDRnUFk5YWFNa2dMa2E0Q2Rnd1htMUxxMmFZdytL?=
 =?utf-8?B?OUI2TzZ0UUZnNzJrMXFsVWxGaTdsck9yRjhMZzFnSHNpbG5jdDhRWjJ0Ulda?=
 =?utf-8?B?TzdwU1dvWmlUQUw4emE5SHh6dzE4R2gwK1ZYN3IwVEhxMWVKVUVqZHphREls?=
 =?utf-8?B?MC8vYXB2aUYyYm5DL3V3N2MwT3BNY3BvdTRJRVYvNFNyVmcxK1MxMjN0RGtl?=
 =?utf-8?B?WSthZlFUd0UvSzk5bGlYWjFSZ1BCKzl5c1lCY1lvSVZ4cG5xdjQ1Q1BPMDFt?=
 =?utf-8?B?cWNXNVBSdGNXbnkrRUI4SjlPbkt2MUFPSHlIekZFcWFzV3hFM0RjVGs5WTZ3?=
 =?utf-8?B?Ky9hZ2ZrTVdLQmRFejN1eEt6NUU1MVlTbUJOUW1jZTFXdG5Nb0NnL1RpUVJk?=
 =?utf-8?B?LzBlYjNLMHpoeFJLUS9yQThhS21NODJVTk1lWUh3R0g4NGdCZ2hnTnJoTnJG?=
 =?utf-8?B?WE95QkNXWEFvdVFZU0lhZXNJWW1YOERhT3VTeWdFOGtOODYrc2tJU0FaaDF2?=
 =?utf-8?B?QjByMHV0STh2RGpuZTRwdHVTZFNaSlFaQmpuWTROWnd2WHRMUThiM1FYbU5v?=
 =?utf-8?B?RnhmWE5HeTR0cER1ZzllL0xjY2tWOXVoYWdjYy9EUTVSaTZCQ0ZUQSsrM29X?=
 =?utf-8?B?bTQ4T2R5WDNuWTY1SDN2bVNOcWd3T2RiNGZCWnU0K2FaYVlieHNRUGI2VmR4?=
 =?utf-8?B?L0FrTmdGTW9ibVhtMlYrekxERlFaSkYwdlRQZFlnVmJ5TDVKUUl3UTM3S1pn?=
 =?utf-8?B?dmYrdmZiWUpHbVNpVEVNdi9qNncvNWlGUTI5U3JubVVJR3ZRVzI3Mk1Nbmtw?=
 =?utf-8?B?ZEk4UThjbFRrWG9XNFVUYm4vOHZTTEdmWWZhUzVzZmdreER4KzJudko3cHBr?=
 =?utf-8?B?cGVTOFJ6ZDdKeGFrMktrOFIzQUMyQkN4QjZmS2RBbVlXdzJqVzFYRzBiOTYx?=
 =?utf-8?B?Rlc0L29hTXJpcmZIZnBOMXQ0dTNXN0NVVWdFVU5LSTg1VEswcktQZlJYdElG?=
 =?utf-8?B?UzZxZlkxaEMyMTdmNWxCQ1hQbVd3ZWlhUFdnbHplZjdWTFEzY3p3UkV3R3R6?=
 =?utf-8?B?aGluOEwvZTBIc0J2cm1NeVJ0ZEZMdXYxVHhzWCtRWmdsclYxZXJodFRlSC8x?=
 =?utf-8?B?b2lQeXRiK0RuajV3cEszSUZ5NXpqTUlVcC9aWmNoNHpKM2U0eUtPZjJnOVQ5?=
 =?utf-8?B?TCs5WU5FYzd4QVRIUmJMaWFTWTM1bXpIRDd2SWZFVzArQTQ0akc2a1RjdDJV?=
 =?utf-8?B?Y0dxQUVWeG5YaUQwTHNKZlhoZjFDaVByMnpkeDd2QmhOWjZmOFZaa0NiOUpP?=
 =?utf-8?B?Znd5V3VGNks2TjJQbFllR2c1MDJYN0VBWm1CRmM4L3kwbmxQeWFzZEtGUllH?=
 =?utf-8?B?UTVMaFdFY0lzLzdQSnNoVk5nWG9JN0JUMkt2cGtWNGlLSWV0d0FKQUFTMStl?=
 =?utf-8?B?SmVOV1I0ZmdWZXRwZkNiMGdXanhUang1Mm1ldWtHaEF1WnpnWllDTmhUbHNO?=
 =?utf-8?Q?rTRARzuHTE6JLCpg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc12022-34ab-4403-049c-08df076d06f7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:34:56.1127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhSi2tb2pFPaVU+5keuGv8GpDuIHAdVra+R7KDnb3VFgkmDqLotc2QBITRKO+jdT6SDWmnZCrtDjfUSRJGpSmS5pSiVqgOFD8ujUzKuzRQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add NXP S32N79 SoC compatible string and interrupt properties.

On S32N79, FlexCAN IP is integrated with two interrupt lines:
one for the mailbox interrupts (0-127) and one for signaling
bus errors and device state changes.

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
---
 .../bindings/net/can/fsl,flexcan.yaml         | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index f81d56f7c12a..d098a44c2b9c 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -26,6 +26,7 @@ properties:
           - fsl,ls1021ar2-flexcan
           - fsl,lx2160ar1-flexcan
           - nxp,s32g2-flexcan
+          - nxp,s32n79-flexcan
       - items:
           - enum:
               - fsl,imx53-flexcan
@@ -173,11 +174,38 @@ allOf:
             - const: mb-1
       required:
         - interrupt-names
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,s32n79-flexcan
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Message Buffer interrupt for mailboxes 0-127
+            - description: Bus Error and Device state change interrupt
+        interrupt-names:
+          items:
+            - const: mb-0
+            - const: berr
+      required:
+        - interrupt-names
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - nxp,s32g2-flexcan
+                - nxp,s32n79-flexcan
+    then:
       properties:
         interrupts:
           maxItems: 1
         interrupt-names: false
+
   - if:
       required:
         - xceiver-supply
-- 
2.43.0

