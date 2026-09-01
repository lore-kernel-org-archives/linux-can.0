Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25543A75A3;
	Tue,  1 Sep 2026 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251980; cv=fail; b=HkFFDUtufF8NgQhkcNq5ZgiGxP5CwUj4/6iS8BKEz1rOjIssHFrGZprQZ72XpqRQAJHwrBILZklawrTpfH60hOanT3lMH8f8OYUvDXplw4fABUKvhwbpw2J0wcExItYTxtIaL/pCARlLrWLMIvAmmotSRSxZDpUQ56Quh1EAHl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251980; c=relaxed/simple;
	bh=iLDfGoddpJyBQHphQL5DQ2jE1kJqML3XPUOw6SV9U2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iKnAutjYznFD1gXzi80oMBiZVlukmHhIk3gRdCTX4ds0gb8ZIKBhw4f0ymdWqLfn595fBC6DQyRaeqpwpkG3eZjEtD4lEbZrX3LdGRWCNd1rCfstg3zhblplyIKxlAB8uDMXTVMmc8JiagoE7ae5SkyZKhEHqayi0hvYHDvQJAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ArNvaS57; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ArNvaS57"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cn4EhNRITipD2GPVTQ2QhK/0Dz0KCKxZuz47or9VAE4r/UAP8WJBlleWroyp4wz2h3AfYKmma3dOmHfN4yn6c9+6NnyOqDHpC2cuKI70DIWO94nLaWYQKi7AB6R518lr5R/8dq7C9Dqs0SyiiEdammh2JuTAzxDig6HbTawIpXnAv4X0gfZHmIzI2egBJfCYoVQbiwVKFicmzWsbc9CxZMWi4lOheN8gpmwAhE17VwHpYazt1+rT45L1ivp2di9yFe4JqsEA1BbqxLVilBlu3GOiS4PuqO/IRuXVFZ5DsfattRD03uLWXN69XQUTSY3Cp8qeWDHJvDn6yuqiZGFssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU9teH0VE5kNE+CbJyqYzLnyCb9XShZFOySfCc81VD4=;
 b=dZlSbnysOTyQnlmNirEC6y6qLob3JH2iXFN83mPvF25kO1aNcDw3NhGeyKNI/RLMNqZgncK9H6+RVX04GNAKOdIYCxRksAafyLBJza/R/fTOVNV5h31pBSZ2Oa+cSYA+AtW8+YfhKNYDikP4l583a2wf7kB5nCRArJF1X+z4RevXGqLl2D1gozWWQcHVkj3umbjs2JxCIH3t9xc2VMhJab7HGDL0xMlYCP3ygsHYxT2HUGm+GALK3b4ugz94t2Uxj7f+Zzd+HzlPKa7QISmtVxCtM93SSiv62atuXvv8S4n01snMLzxpmMqyWaXhG7gSG/YgosOcHGYBaCLUpi3Uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU9teH0VE5kNE+CbJyqYzLnyCb9XShZFOySfCc81VD4=;
 b=ArNvaS57/UBK3coylUl8ZCloATjP2fIdp74V+k70vypBIZFg0H1Aq5WtsLL/+M5lIqVR3an8Qs7X2PlHZuiIz/hj7bg2viIhqWig7YjmHBTd0m1UHhsxpGWKvErvzY1vdohYPqfSICnO03mo8sK5vd1uUbnaokrfFz768SrnUMPWi+zEWYdzwzt3OGZNcrpjQnAEvHxLO0htEgWdM+bflJRwg5tcto5BsUjsjrE44KFiXloLlqM4ZNyZO+B8Yb9ZN4qB8AOwL406rrGrnMZ6s4eUj/jHAE2tE2S82C3PLA1J7VK2bVwvA7OxhFeIKYYkT/kbNaZabeQvomWV6JV+JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AS8PR04MB9077.eurprd04.prod.outlook.com (2603:10a6:20b:444::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:39:33 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:39:32 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	s32@nxp.com,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v2 2/2] can: at91_can: add missing can_rx_offload_del() in at91_can_remove()
Date: Tue,  1 Sep 2026 10:39:27 +0200
Message-ID: <20260901083927.316283-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901083927.316283-1-ciprianmarian.costea@oss.nxp.com>
References: <20260901083927.316283-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0326.eurprd06.prod.outlook.com
 (2603:10a6:20b:45b::34) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AS8PR04MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: a010e66f-14fc-4412-cd6f-08df08048bc2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|19092799006|376014|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	BGaQ8Jths3rR/GmFGv6yZvl2I/kSzT996GjWtLT9yKEX2RuPd864P3k3mvDa8PkkcFukRZZCCfA6+Gx5R59cxo8fByvqPtTFLlWSjqJpUPzLe2T9MkeKU1HmlW6mUkBD3C7YhmuAbfXmcd/6qx+9KI//mR3NiGZR7A7itp6PshdkVnvqBi7DVsFSQxNUY5eWCvgksl7XEdCPiSKGJ2nqHOwrTrdSTkkUNycGki4svlUavmEfl5Kg50FJ4w6U9LAjo2cTm+sJFvsHKgU1bath5ySM17VuyATyo4o4P6sef0jVdVo8VIvp+ORxEn2jHDMj54LxXoUNPUwPuB8Kh1vud7+2LQaJAxGFacUi+Mb5cpWQC3Qfkso+tAsMKklZRqZCdLZMhcsvoqtISVR+vvY4f2i2w8k0Ttb7xEC6OrV03UFkWtQ3jW6oYVNs4QhAROKWT7uHiPJfz+dEV4/svkkZPZTLZxB99WyNBtJ+6w41AdW7D9qTgS/f9wnpGm8zLSCr+BYm2rsICd64oGJIpVz72SqaurZPsZwjvFlAeh42QNmjy4jtWqmN0ujdp7YdgWbrODf6WVopBnRfWmtrsniCCRqhimUr4Fm1sR7lsAKTkzh2EHsGV3GE0aDX/AtUeOPzSLLiat5eFfJqXzRUWkXCs1qa/Wh0npzKnxlFsqi+Qog=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmJ0Wm1EdG9zL0xvZjkxRzlkVkhZSHoyV000ZnUraCsxRjVpTktSQ053Slpj?=
 =?utf-8?B?aG5NUWQ1SCt3U0lYd2swWHBjQjByaHJzQzQ3RGo0VnNaSXVJV01VdDFnY082?=
 =?utf-8?B?TmRVUTRzOGp0amRQcDNVaTFjaldTQW5wcVpYdk9JVjBWT0dxZUxuNEo2V2x6?=
 =?utf-8?B?VkNMQ2pJMjlhMzNoNkNNVGh5b2NLcHFYSVV6bUVoMmxxWmNPOVV1NDE1dTlK?=
 =?utf-8?B?dFl3aWpzL3lxNVhGQnI1dS9USmlvN0pvb01Caks5anp5VmFKOVhCbTVzQWNZ?=
 =?utf-8?B?YUtYKzdrd2FzWGNOKzhJZFhCZjlLSGN1NUQ0OWtuT1F1NWRreU9ucGFRTVhy?=
 =?utf-8?B?ZHpVVnZtUzRpaHRXbCtKbkwzQm1mK3E4R1JMTjcyZ1pSTWFxSno1R2pEdkg5?=
 =?utf-8?B?MTZ6WHROV1R4MUl2YU9ReTk2QU1LUjFiSUtYRURZZCtWYUtTK0srWXF1Qk1N?=
 =?utf-8?B?UGZpaC9kaDlDSEt0eTc1MnowbWZDQzFaZzVVc3FPd2lYSno1RitpMnQ2NVRp?=
 =?utf-8?B?OENBOU92N29kekdvM0Fsb0lRVDdoZjNSWE1rUW85dHhpenZuRmhoTnE0Vndx?=
 =?utf-8?B?aWVTbGVpNXR6ME1JZzJkRC8zdWs4Kytucms1MmR3MTArei9Cc2w5ZUpJUEJr?=
 =?utf-8?B?cmxtekg1NUtUcXNRRzJmRldFM0JxaXR1M2J4R0pPN2hVbnBIWkQ3d2JWbnpj?=
 =?utf-8?B?SCswRDErV3plajhIZzRkSXZmVzB4ckZqRm52NVlNWFBCcGdnaGJUWmgraDc2?=
 =?utf-8?B?eHI4NmFoUkdVV2t6L2VHZVRyWWFPRFhuNzU1TVJ6SkxSUnNHU3JUdWhtTUJO?=
 =?utf-8?B?a3hFdlFsYmV1L2dueFNSVDJRRFpvOFJ4NjUvRVVnMmV0dzVnelZNVGVQcFhk?=
 =?utf-8?B?UVp2SithcWIwc1kya0VIbW9IQ3RUZk5JSS90dGtKdnJkTkM5bUl6d0h1amd5?=
 =?utf-8?B?eHBLRlZlMnJTWXhmWGErenhGRURTQW1uWDhwa2ZFUkF6alVrTHpRV0J3bVR6?=
 =?utf-8?B?ZW5DOTcvbjkzYjc4bS9OdTJNOWN2N2Z5bmFQVEJrMnJ0NHhsVklYZnJvaEho?=
 =?utf-8?B?L1ZVdVRCSmZ1NjRkcUgxT3cvNWZkSjErR3hCOUtERk5adEk5dGFXTitwYVJC?=
 =?utf-8?B?SU9COGZ4WVR2Q2h4NXZ0WUM5Y3kwMzhqakNWVTVzM0NjRGp2ZjQzY0E0VlQ3?=
 =?utf-8?B?WVBjTW1yOHpPc1hNaERjWnUrWTUyWnRxTjdzakZxNngwdEFWaDZTem9YUDJD?=
 =?utf-8?B?L2JySS94ZXRZd1ZwRTFLWHBOZy9SejR0QzhUWVVuZTkwVnp2eFV3eEhXWlds?=
 =?utf-8?B?eUdvenUyWldEeVZQS3lybFkwczZ4MFJLamtNbTQ5OFlTbURQZXphbjBKdG5N?=
 =?utf-8?B?SWJ3dlRiSE5rYm8wNXQyQ1dVWG5RVFlTYWM2akRnR05XQm5kYnJaRW1Hc25F?=
 =?utf-8?B?RzR3SDZPa3VvTjJlSGdoVmxyYzZHeTVqMmdhMlB4L1VhV2U4QzJZb0hDajc5?=
 =?utf-8?B?UG1IcTlPbk5JTkhiY1dOa1I3S0FzZk4vVlZZaVd5VThtaW5vZEUzc1VjejFJ?=
 =?utf-8?B?L1VXMFlBSEhkSHFRUEdOQzNDejJuSVpuOHJJYm56T01NWmN5d2RNb3pnRzhh?=
 =?utf-8?B?MUJMVG1XNUhlRHEvRndxdUFVSDhmdHR0ZDZIZG1YVTgrbzQxcWZEWHVxc3BH?=
 =?utf-8?B?bGVCSmJQZ1dYdTBnMHJyYWVrRFNybTd0bWtCaGx6YktJWXRBMEFzWFZlNTFw?=
 =?utf-8?B?QjcyaWhmcHRTanJZZmlKazJCSVhnaFFtRCtKS29VZG9XSHBocU5MMWtKcS9w?=
 =?utf-8?B?L0NvZHpBd1hwdlBzd3c2Ri9BTXRNRFU2K0JscFZqVUd1S2dURjF3STBGRXQx?=
 =?utf-8?B?bVhwSnFoQkgyZ2h5TmZBeG5FeTcxVVFTNG1qdFdJNmYvMzJiUGZ1LzBON3pt?=
 =?utf-8?B?VGlvZXdCOGQrN1pEMzV1bDhqNFYvT25iWG55clNHSmVFQkExMGE4OGZpcFp4?=
 =?utf-8?B?RVZySVF4REN1MmdEN2F1YVAwQ2VTKzNHRm5jK09rSFNjUFlEK1BQcFUxQmhF?=
 =?utf-8?B?ZEdlVG8xeWJCU2Z3WU5QUWFSbmxJSmIzTFQ2REFOV3NZaEp3eUZZTEJSUDJJ?=
 =?utf-8?B?VWNNVG9lcXBOUVBRcGFadjFQSllOWTdaR1lmc0djMWJIcEJqOE1HOWhrUCs0?=
 =?utf-8?B?MlUrSnlRZEpEUTZVV21QMm80UlIxQXRlMzgxMWIzVWlpQ3YvT1QxQ0RHbHRB?=
 =?utf-8?B?R25BMVFnVHpEQ2NtTTNqdy9ockJHOXpWdlZITWxqUG1PYUNHTXVaU1JRWEpL?=
 =?utf-8?B?am1YWm9xL090NFh2L3JlRVJsRkdFSVFPTGxOL0t1TG9CUGJtRU91blJMejBS?=
 =?utf-8?Q?++Y/MLT9GSWsYcBA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a010e66f-14fc-4412-cd6f-08df08048bc2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:39:32.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjWvwP5bBCyO9eqFpNXqCHcJwd8D+Y9TP9PgaBsz2F85YxztByjF8Fx/eHXgfy1BKil32DO9iF4QlgHdsaK2XsOtl0jgUhciK0SnRm6w3Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9077

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

at91_can_probe() sets up rx-offload via can_rx_offload_add_timestamp(),
but at91_can_remove() never calls can_rx_offload_del(). The NAPI
instance added by can_rx_offload_add_timestamp() is therefore never
removed on unbind.

This was benign while the offload's IRQ queue was embedded in struct
can_rx_offload, but it now leaks the per-CPU skb_irq_queue allocation.
Add the missing can_rx_offload_del() after unregister_netdev().

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/at91_can.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 58da323f14d7..3ee908817add 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1165,6 +1165,8 @@ static void at91_can_remove(struct platform_device *pdev)
 
 	unregister_netdev(dev);
 
+	can_rx_offload_del(&priv->offload);
+
 	iounmap(priv->reg_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.43.0

