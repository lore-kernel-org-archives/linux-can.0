Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1924582E7;
	Fri, 14 Aug 2026 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698227; cv=fail; b=uW4QrFXzBCqoAhHKpKN8zOTecd1zINcxPgkR+x1rqApcwqpz3q/KUb+QFfrOCfezufjn2K0jmbXWdMEUDGcClq5pQnsJ9FjKD85GTjQstb0DW8fVvJiH0fLarldv/wuEmDUHYJv0DjKqSGKrr80T8mnewFP6VoggexxrCfGBSTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698227; c=relaxed/simple;
	bh=1upDEasXsZkAK0im+GIkBFqGG2oU1/fr19aNvoErZ4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dz0fTOD99uVaou31Zp2qm1gZZPBon/3QOQQlyeR82meEso4daWTR86wqFIsBI5b4qxDwwlH9KTLQmBHMg/0bvkb0EMykp6e7+RIA4ZfLUlef2yZnS3hvCDuZ/GLxz07BKKOq7lnnpeNuAXyRb+gaByWd9a0NPER/dPz0sX/vRWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=T2bOAF3+; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="T2bOAF3+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/e3VB8CIMxaWwjVuit4B27pI6CFRaJzEyE/Bnw3K8/tMpfLCBrNrvIPTqej+3lbCxgBuGw9YmKqQQ3nf0OxScCMDzBPmcl6+R1CSsC71V4527vOQ2sFhyto+sr4ab4Y1STpBfhNOfmlaj9SYpWS537wd4Jp9w53bt5Y9afGZ3t7ckIAtoEcT2ssbmtMRTXbBXm10FTKJS8/wLO6rsTE8Y/yYRPzXoldNGTHYF+zm2H+8JS4ZjE547FI86Kl+FbfbB37TT6+t/XtJPgasTocGD5uqwlDglZjLDUP5j1D9sBKNOvg7nFV3ewQLp5bxyChQgQuczg55gar78MyD1TqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfLF2os2kzzc35jZf3bjNKQLGWICLw+dnzgpzDvFcWY=;
 b=ctZPJ+XPHVZ/67RrDsCdU8TAFcjmfdUspQwAq53WAsSA5RnMqll6r2d6NDFegTt+ax1c9U0xjf4kPa/2iuVtkY9ttyyNrf8RINjCmNdS3hY4ok/p0U7zbFHuA9GmFZb/9OFrXkwQwGZ8Fxz4//3Qe//OzwCS9FoXDNh19VMTmSZWZ77TRXkAO3gU3JfYURJ9IkMYLlvkO9NGB+4d+a7300A7B1cZSFiFTMLRPrbaNPzEmm2MGhFN8FlbPkQa1cJovZ+R2+bQ89f0XAYgK9l9uQet6ENVWZbpphlbepARBwqcmEFX1qAbwTBw8iBkPtJ5P9ZuAXpWbXk0VQMzcy69tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfLF2os2kzzc35jZf3bjNKQLGWICLw+dnzgpzDvFcWY=;
 b=T2bOAF3+8YdMzLLiebVBayrs6+qaloomn6xOnD6z4RojXSvtVIrrHWI3x3a95snNKlLEOMCrbs2bWhrDqid8fIoOQ7QIg54JkIxEDZ2koBjAhzk9YFsRFtBZHEnxJD/FS2aGBXL2u7bZ04WVFYgsCNa+sWFdmtM0YFOI34ohHAf9q4ZmBpH4kur869LRcgaUt4T9aC4yyMUlx4KYrI2kcrUtc+0Ix3BI8KhyxDiwX33yCIviIf2gA3DoOL9TEArtJJGhJxbNw0GCFMKcV9VXkD5hQd23B2g+UgNDr74C414bPz119evdK4+Hv8NwEG6RyefkIUHA6jssden2wE+v6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AMBPR04MB963705.eurprd04.prod.outlook.com (2603:10a6:20b:75d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 09:03:38 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 09:03:37 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Dureghello <angelo@kernel-space.org>
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
Subject: [RESEND PATCH v6 4/6] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
Date: Fri, 14 Aug 2026 11:03:21 +0200
Message-ID: <20260814090324.647898-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
References: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0324.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::14) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AMBPR04MB963705:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc11769-4d5c-4b8d-1707-08def9e2ed98
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|7416014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 mXsVWOU4n61c+s0Aw/t+u3DbR9h22fDNRaJlnbktuXEbjwkr2v4Ul3JZrGbpnADynHCV4152BgYdmeFVKr4uMy9mRjwQ/C3MqGyzNWWJWtAB69XpS8oMqnRjPoGfZwi+e01+gGYB+nAifD6Ic/LihE52MXivnUKHw4B1eO8KOJTwNRXQpaTklWBKGfKxYF8tur8NDEarTKh4mnjTu24MZUVnLYzqZY5eEqEDSNa+T+gfDfzqcBRD13VZyVYgNNKH4qxCkMPgRni6O6GhRX2XLn1PNagdTxL6t3Sm91uUNl2eTlWPMvB0iCVJdYxaex+NhoAAJ5i/eNBeb5j9AzEEcuXcquRxF3wDBXpeYxxVs7enR1iAu60mwEFqpq0ffgck0xpOa1waUovNDykWRURYrE4mwg+jzA1OTTKxskhdklxb00ZzAmE/Ajo8chTL5UddWePjujQEwM0w22SJcxFUjcOOC9lWzEPrqT5rfZ/sG9YN1QDdM/ZPDHCpNAwHhhdA1h/5KYSRuDsAI1ihqIxe+zqYM0mUQu1PzmMlnaEOo6FbdvzA0xnfU15hBovU4AnmwSHBUJzY7F9cUgIujcB8QuLY1sOZaLnwuvRLmVgkhHFU3VIK6x8bc1gqc82AtYFszGga3VYMFFG5vpHgTveSc50iWEmATYDBYhU6vTbZoFE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(7416014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cGJmTW8rL29pTUM2T3lWWjZtbTBlQVFFc0ExLzFSY0FiSE9nY09JRHBwMDJE?=
 =?utf-8?B?bGlKSHZ4RnVLc256OGYzKzQvejZKcFpRRGE1SDFEc3dyMkJtWEZjTE4yU0Vz?=
 =?utf-8?B?UzQxbTYwcWZtNDhNdmRvVGRTWFdLc1hxT0ZZdnRiaTl0YmVQNTJaSjJxZEt6?=
 =?utf-8?B?SmNQYUFja0g3QzZCZ0ZYVExZMTh4eUV5OFpyaGphaHZ5Q2R3Vkg1Z3BTblcr?=
 =?utf-8?B?b1VZSnFFTWNyN0Y1cW1wQ1JHVEdVSm1JK250RkxOdDJ3d0hHQlFzd3BUcWtq?=
 =?utf-8?B?Vnh3Q2ZrNUxVY2ZseklURi9Dc2htUjQ2YXRwWUlhckpwQURXN2UvNUJxSFRN?=
 =?utf-8?B?am12S1F4TkUrRXhUOGc5UmV2ZS9ISFVpMUp1dmRncHd6cCtCa1NZNkFUZHhi?=
 =?utf-8?B?bWV3dGplUHovNUxtbXY0amVsU0hVVzZ1TXU4SHlsYWV4NTRDajB1QzNWdXN2?=
 =?utf-8?B?aUNnMTdaUVNBc3FLU0RBOTM5b0RETzkvQjZNaG9WeG5zNEx6dU9ScGVzY1Fi?=
 =?utf-8?B?U2hJamlxT1pVaWxTc1FPUGdmNlhRSElSNDdHZ2FIRFJNWlU0d1VFNVpoemIz?=
 =?utf-8?B?ZWNnZFRRTldzWmIwMUQ4VmE5UkVwTmVtU1haUkI1amVRVGVmdnFSRnhXMVdW?=
 =?utf-8?B?aGJtVWtjZUtwdFpLZ3pIYjBkeTQ3NG9RQWZtY2dwa0xGZjFheXVFTkJ1RFN1?=
 =?utf-8?B?blN5c3U2cmRBUlA4Y0pGcU42UmkrakNEY2xzWkZpWlVQVjJvREpCMm5TUGRG?=
 =?utf-8?B?Zll6ZmpSdE1BWmxnV1RHNzlBRFhzeWE2YjVXb2lPcE1mZGVlV2dkdnp2WlF6?=
 =?utf-8?B?cC9UM2grOUpRZVlRWFNHRDhleitsMTJsNUplU2pzQ2dpbThyNUZWeHljRGtC?=
 =?utf-8?B?NjVKaFd5YVV5ZFdVNWx2ekh5dkxMY2N3dW5xQW9lYStGY0RiazZ1MHRxam5J?=
 =?utf-8?B?ZldzcjZHT2RSNDBKWXZwQVgvYitQNmFIZ1FDRmRXQUcyOS9UWFNwYWpUOGxK?=
 =?utf-8?B?SVJ5dU42dXZOMFBBR1VhWmdyRXYwQlFRTisyWUZkOUNOZW5WQ0NRTEJMZytM?=
 =?utf-8?B?KzRuMUVDRnJiWFYweU9mTzYwVnZIRDZ2TTU0dHNOYXoraDhLYUNTUklHck5F?=
 =?utf-8?B?SGY2dCtVcDlsWUM4VUFlUEtvQTl1emI2clBqNTM2RVoxNzdWRFd2U1dIS2NT?=
 =?utf-8?B?TzdQemRyQ254SHhCT21wSVNMaEFEZGlGUjEvM2tPc1FkVWttNGc0Ni9xZFpG?=
 =?utf-8?B?blY5eG10eFJPNE1tVTZ5Y0d4RDI2ckgvMWtDbExxTTBCbXlTUzRZcHNneTlX?=
 =?utf-8?B?SXFOa1pKSS9YWUxMK2lleDZYM21zMXl2cExsWWE1RVBUQmFJWEEzKzlmZ1Qv?=
 =?utf-8?B?b1FnK2lnSTN1MGtvYW16SmE2c3d0UU5ISklyQjlOVk8zbElPSFg5ZHd0YjFW?=
 =?utf-8?B?REx5WG9BUWQ3elp4dGlya2ZOb2xIaEUwQnNtcVdrVkJGai9HOHhTSVMyOWpO?=
 =?utf-8?B?OXRzQisyaFVWRmJxeWo2Z2dmMHRNRGNwVmtPR1V2ZGR0eEN5aERXRXJxbHEz?=
 =?utf-8?B?Tk5ZZzdqOFBPRWV3MXZpdksrdDJxUW0yb2FjTVdHUkY3YVRneU5DdjkxRWRy?=
 =?utf-8?B?MTI1WkJKK3g0U05sL2k1bWZtNW9ZNkphei94VHdhZ3NGL0ZsYWdjNXBJeEhs?=
 =?utf-8?B?Q3FSNlJya05uTjRPdHR0OFh5cmRwRm5pTTl6ZXlvM01LSk03ZUlTbzYzcExq?=
 =?utf-8?B?ZHVMVGJjZkVNOXRiVm1yZ3FsVEV6Um9xam93KytIZ2VncDBvY3IxUHBYd0Ru?=
 =?utf-8?B?VjZ4RjI5c2lPN1JJSGpzc0FLc1NWTE5QUG5vN1hscW1ZbDJHbmh1ck95aDdk?=
 =?utf-8?B?b1p4T3duMkNaR2lJdTRRZzRZVTYxaVZWVnN3VElxbkY2YlZ4U25SU2RmNk5t?=
 =?utf-8?B?TW9ZQ294ejVTM1hhYTYyNzhUeE5ma1NVZGZzbDcxYmRjcENIeXBrekJIekZh?=
 =?utf-8?B?RGIvaW9DU0Zva25wa2N1SVZMTEtoMngzeUhHVGE2VWxjT2QvaURCWmRqeVgy?=
 =?utf-8?B?YW0wd2ZtaWhRekl0ZHl3bHZFMmNpN0F0OS85a1FFWmJDS0RvR044T2RSdHpj?=
 =?utf-8?B?UktxVjlWenA2VFJjWC9NS2h2ZFlacHFlb3dET2xTa0JpUXBDbTRXbGNXM3Rk?=
 =?utf-8?B?SUNJcjR1YVZqQXRBbGNjVXFsdlhUSjY3dnVVWm9GR2xMc1lwUHppTnV6T3Jj?=
 =?utf-8?B?a21QT3dxcGVNQkRzRWtabXNNZ1F1SUQ3SngwRE5iSExGUXhWcWZxcmlUQzdV?=
 =?utf-8?B?MnVJUUIva2JwZHRxeDAwOUVzTkh3UVJPeWYzTHpPMFIxK2xvR0xMNk1MZG45?=
 =?utf-8?Q?o3e1HFZQ7ogsyy1M=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc11769-4d5c-4b8d-1707-08def9e2ed98
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 09:03:37.8903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrEhmkLqQFKcvFlk6aw47mNtFRvCbiZnEiQ80BVvk6xl2RytohYU0rbaffCtyiNdCO5Ijx2194lNSOhhodUX9n9LfoklYldv4aokaE66jR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB963705

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

