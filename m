Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011056.outbound.protection.outlook.com [52.103.14.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904513F58CC;
	Sun, 18 Oct 2026 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341945; cv=fail; b=s+XevR2lccWkxi5IO96vkHv6tuurGXj429DvvtpFIb0SgTf58LlhO0OMQnO/w9M1T4E3xsm6Z+bpLIg6s5BWy4Fq8/pv5A144mHX/oiNEuGNIFmmgDJ+s4XemTDHlxu+V7cvbaoECAc28noV/Ux338v5VqrsBnUj9HDLLIiGe6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341945; c=relaxed/simple;
	bh=D/fiVCHxLYmdAIrcs/iAyx8GR2wgnap5f1xA/I72GKM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gr/CcjNtjzbeqTwwaNoF5aQBB/20b+x5A7jWUYjfIuilGPL6alM5oKEADyd6tVx2WH9MoU4ghcdXd/7XIaLAnKsdkM2BAY5JZeTkZe5BP0jNFcZxHrdl4kXChccdsR4BPS7Jsl+sDovJE9/L50fww2gM9Wx3/WKfv5QnDOYHRK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mysl+oAb; arc=fail smtp.client-ip=52.103.14.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mysl+oAb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9hbEVd8n5v/kHQOIrRgGYzxlqz+RF7M7yNeXCILGA7meD6fqNvvGsmultb6kmStpZZqzB4w+Dohtk/qZdXPtPLgvtUg+J7+cACJl1CMLjcDu+wf9b0TBHYG0NhwY9LCHyAaiG6ovkTJhAnIcyTH7WkRifMvcKu5j+PZUxUfJkOBreBxAkjx9ENFq5k7VIb0jg6IXrCoUbk3UvuDeiKoE34fFyHYAvjWcSc39851FjnSO25hDga17RT9UJs2GkSoVozPhM2fClAbrBu9VRIpM07bjHN8cHaoQcynuO4Lv7pbwgMaQZR/eRaA3CILHTs5dDggoWZqzOtiPBpJh2TInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovpgcvCplm+qXgwpOoDIH71lYHkA9hal/0RP5B3xuj8=;
 b=Wva/RMwky2LehvJb9i1jWfYvxyPGgoL46wYlL3BscoZ80jN9sf4Ja4k7R5unwwZHXhlcO/VFSrjRAxzmaQaexwlPHhxVNXrljeLMXlsU1NopkSpS4gOkkGiYQxW1TtTcL2ezUfDHLpVNArVCpakqHgCEqYIgnrA/6i8YxQuPqySrVJJ3SVpligKXn8Dt2QOYeIiq+mV1jciLraEkoncU2qTAXdsPoH8qcBbbmtCkjYbfw/pfeo7KniggwVQWp9VGKZcoZoNgfkcc564zvNn5AJYXm5zFohBxjmNR5aQ5oCAUn9+INMYgenJdQLnjQIqTSc96INYtH3QL2lS69yydQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovpgcvCplm+qXgwpOoDIH71lYHkA9hal/0RP5B3xuj8=;
 b=mysl+oAbbqbOF0cIUKgzxhm4XtWTiAvjs5ii0p0zKOMj37giA/G6oQJ5bQjz0ABNxqoFL/ufjHXxtjgQSyA4OzWCEnerx9g7vIXkJfNaX3/uKSNiVBecvneL8C1oCfs8ezpjNJybmTRoBkqr8MrclxpWdGr90tRslQ5KyQzi1g0j3dcD4vj+XA7gAKoHdy4pwTw6V5sMec1d0CnybwB/xZPJY1NN18KrWwop0GPivFHkFI0yjT6FnW1yhzM2vTU9Q0mtlg0tjyVSqLACesJhSq3F8M72mBO4nov3bmobU/cTiIsQcSK+BBMi00heq4e+1th0je4kui/I2awFozypOg==
Received: from CH5PR19MB997156.namprd19.prod.outlook.com
 (2603:10b6:610:2f1::23) by CH9PR19MB9514.namprd19.prod.outlook.com
 (2603:10b6:610:2da::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 16:45:37 +0000
Received: from CH5PR19MB997156.namprd19.prod.outlook.com
 ([fe80::4f59:5a3e:6e0d:ee17]) by CH5PR19MB997156.namprd19.prod.outlook.com
 ([fe80::4f59:5a3e:6e0d:ee17%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 16:45:37 +0000
From: Liu Changjie <liucj1228@outlook.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
Cc: =?utf-8?q?St=C3=A9phane?= Grosjean <s.grosjean@peak-system.fr>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>, linux-kernel@vger.kernel.org,
 Liu Changjie <liucj1228@outlook.com>
Subject: [PATCH net] can: peak_usb: accept short uCAN end-of-list records
Date: Mon, 19 Oct 2026 00:46:34 +0800
Message-ID:
 <CH5PR19MB997156AB3BE253C3BE445223B0AC992@CH5PR19MB997156.namprd19.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0078.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c6::15) To CH5PR19MB997156.namprd19.prod.outlook.com
 (2603:10b6:610:2f1::23)
X-Microsoft-Original-Message-ID:
 <179234199485.15890.14766470918134463502@outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH5PR19MB997156:EE_|CH9PR19MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 4842331d-b33d-412f-72c0-08df2d373c88
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TWTq462A1ci1xfPBdi3ebdl+v8WK0FRsKoAWHtRup7F59kWFjb8qFA0lHt63wU6dCZ7hVx/Po3ZqjNMMJbmoLvoQjL4GgvIcEgwog5v7d14zDRAFR7EygCkDVPBEsWxcVkyk7IE11CZxAWSifG3pDPTulqsRozsXT3u4X53SsCTRjA+3C1UQgLkuEehB5F+ciqpogo8V8I8Smw9ZSFUKBFU/VmNZz8/yi0+uRulGHX9IckcFsycLcYcTGjI2mj3u6T8Z0xEJ4j+j6CVHTqVqHuPIEgfyTTaudLuVdg/ZCRdeLNsuee0+EMdOmvF/8lre8Fe4zCwxra+hoPEvX2HnRyG47Ii8mjtRCOGaAWM81YVT/Odq+bk1wO4nMHgm9hZiJ3lnaXVCvgsQcWzeGcJwfGtpG+BxW/yi269izesqphYgStqG/buPCV99VocBOAOJXmtt7VuY3bwF3OPfh1u7Thlxl6nDr71sE9NOFB3AILNntP3hpIyLh4AHvvgqOKemUd2koIx52nEVAJvsd0YEgYXY8q4HmIeQZYlqszzDvXyTMQT/kpHGUwZlxdx4KTZntsBGFiqfheTd60AszhPtg/3m1OTF5K7VeH4TEnPDWCg2TuefczuNulSl140i4UgNaTFo0RcuDrZiTcxLkfMB8t4uACSWze8WiC19tvKeLsTTixoCmhkDsNi/Fd+2jb4S5PfS6g16gEQ4MlrFxFcohxsVfpYGFYANznOTGtWKTJOtp+xVyS2yuIw4Qm7yVGxyLGod38K78pc4CHSbaL/Gd0rxR2TfcI2LwY=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5062599005|6090799003|5072599009|37011999003|23021999003|22121099003|12121999013|39105399006|19110799012|8060799015|25010399006|24021099003|4140399003|440099028|3412199025|26104999009|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?81N+3WLEAfySIa01lpmLGmGAarFxI3qUFnl7Zd2VoWxvX76fUowNNcoZF7ND?=
 =?us-ascii?Q?3IUQFPkCuUPZTbg6w3iAbm7DWMdu+gwtLLRve5RCWqKUbCD5RQDRAWncTXt/?=
 =?us-ascii?Q?5Yxv+mrF1xC2v7atBShUm73kmavDK8qV+IAiMoGZ0LlsLgVJRJohNJukVeqk?=
 =?us-ascii?Q?dBeQg/koEpZMJ+KyKolRR8DhV/gOCqyAJSrb1LCLMFkDJpM/8tl8JFv0YwAt?=
 =?us-ascii?Q?EPaB5V5W6Xf//+v+oEYNe5CelxakgtmNAAa4KFZM5lmVAcDXDyv5UsTWsIM7?=
 =?us-ascii?Q?5LgJmUiTZIRGCIwD1VQTbaISnLHTfdGLttI+hP27nch+H7G08BELzAxy3UrF?=
 =?us-ascii?Q?C5Ekr7hjMdCGJGL1iMvmW3ZDPLojcA+mV6sCtEdikL6zRYIJu+tp0/KJlCJ0?=
 =?us-ascii?Q?NdqzbFj0mD2XKVgCdRJGJBFzEMG6kiwLbCcyQ3DHql7iOYUSpEddTMD4zBav?=
 =?us-ascii?Q?ESicvT8jHpWzIBKy54VuiRC1o777r/lEt1Qh4bvv5hFMyt/Ua9YWVEI002Ot?=
 =?us-ascii?Q?1Ky3BcAxOjRxA5eTUf6i+k/DEr70RMR4s/hs7Zx3oOpIYwfAhPPlhc2G2BsR?=
 =?us-ascii?Q?ZeKJ+qhUSaiHNRr0bILiu1XBx4dx7sJ2GD5uPAi8PAHJW9kwuOKrhgnkdhtH?=
 =?us-ascii?Q?JrfXkP23AJvWuHwMyPskJVG4nVOYh21l0Es0FzUhPwavUO9ehSS37dsLQNev?=
 =?us-ascii?Q?m8ShxZMMNQ0+irYvFhH03aZGOgK7VlexOrAgmgw/Tt5ma+v0NZiFgpYOndFC?=
 =?us-ascii?Q?J4WeNS5fVhpKOREU6NnNL2Ay2mNV3PZzu7n377fobdn2L+JKOCTEbNvGlqOP?=
 =?us-ascii?Q?MC4B2ctlcaoTOIPXBB+ZJdkLi57eb/TVXTjh9RstyLWPipw53nC/EgNv/TJx?=
 =?us-ascii?Q?0fVs4i+jvsufhJXvWpj7s1vxOKRxDZ53vVpP5iksrjCtURuAbC3fv0H75wG+?=
 =?us-ascii?Q?LGTmjkiCy7TeF/fAQz8Dc+G+q5wccQq8LEhtPDUhnLkl5pUYKgQizRLLR/Oi?=
 =?us-ascii?Q?SP1A8tCBXfyOhBMUBb7SGSCef/gveJBr2/p3fklX62K/bZF15vHm+z4p60bh?=
 =?us-ascii?Q?388dXNnHsN43e44EuzGkIQyw4PgKT8smmhpDzDZCwaQGqkYQfnBA/w65Wgir?=
 =?us-ascii?Q?xjqfvX1NCWY/?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y1GEKqb3iE4Jb3FMwg0VRrpstKCyTIHQUGTWrAFb4EFm37VJ5wgmbV3w1uaT?=
 =?us-ascii?Q?vZMGH8WCcyD1bZ92AmC90q6aZYClCTG5jeaTsfLfIkhB/cJ+UANnDFQWInEm?=
 =?us-ascii?Q?zFKuNEX/V15ud3evE/kRVui8SMrPqJncPZPVeWC4vhdYfQEGT5QTArr4shxn?=
 =?us-ascii?Q?moZSLZG43KW9Rpuu8Ts5e7yicdVmLCk5hpWiG4c7JVxHgSnD8o75yKkaOoL6?=
 =?us-ascii?Q?MB5k7B03QsEq4SvU84dGSNXPbRKe34TRlw6PmJnpFN0fTB+7EYw4TI9DAA6I?=
 =?us-ascii?Q?gTLWzMqJ4/6rG3aU/O4hPB6740wgeYxD24t/HCs0211LKm7ju7GbdbpJkrBN?=
 =?us-ascii?Q?+A3kCL+lkok7dgvSuYomzxteyHTBuwoSDiOfg4raefFTxvUUPWTf4MAproXa?=
 =?us-ascii?Q?urDP8qvA9CZI8o2RZiFa92wYs/rdulpnf6WMSm1hBJuVRkRrkdWTqgg2cG+g?=
 =?us-ascii?Q?2uK2vQsYfyPoDLOaelbvkGen9x3CprP+xSpHbFp84Ro6It+Co2t3hytzG/TZ?=
 =?us-ascii?Q?+XXy3uMwGK+rg7baiAe+4QeqpB6iLRazvtiso5zxD0RgmriLGe7bHXPOpLp5?=
 =?us-ascii?Q?kM0F8xVKrXtkRWA+1YrRvCoKosiLjA7mv1JwmHHpTdBUkR5sZtudrTOxtUKN?=
 =?us-ascii?Q?gvFQFXWd+CuNtFjiwOc5MCikO8ojBhlzL29AqiCO8q9ECL3/rOoygZxLIZUy?=
 =?us-ascii?Q?RdmWnvXz0hWGsYhwPipYf6aUq/zRjEjGY7hweU9Ndk0ZazM6Tpuj0qUpbqxq?=
 =?us-ascii?Q?D6wuziHzdrS1jPYJwReHtt7Pk9Xip5Z+//+rH+yziB+MO3fQrE3dNfWdrgJW?=
 =?us-ascii?Q?mZkQSCkywcSeeDY5kuRiYYGHDNR0jhZR3aOjeSvzezsIUGKXj6E+JRf6BX7I?=
 =?us-ascii?Q?xeGKU/QHAIp31vOreYoCaXd0E1o84DEQXBX63gh3/wMGd+VstE26tkK7krff?=
 =?us-ascii?Q?eKtCGd6dWFWFh1ojRm/+rksNjUwqC2OjJQzpxVXUIYi2m5PLZlllnMZEVzt4?=
 =?us-ascii?Q?7wP39rMy0omGCZEbBjNta5LFeFm+n2T4gjPMYR6lj4JgDPXx5pNU/QJEiZdP?=
 =?us-ascii?Q?9oORKof3HoD1jnw1Gk8dTYHBKkFEg76Ny/o6FGWLoBrCD3wo9F0pnLuaPbJu?=
 =?us-ascii?Q?wEprF4f2jXCFbFAPdd+y67yC9huhxlUT7uDlJ2I7y6ZrcKAKSCLdwlTl7hfb?=
 =?us-ascii?Q?6paE+E3fsKp0Btgy+8DRbgd049vaJktdyZLcntec2e1i7VdIJThLNlyrFhxT?=
 =?us-ascii?Q?VB14n80ft2O2BAynH/QBJdOTRzWmfAOCU6PPjZZsBR0RMGPgRrR2vBzsG45k?=
 =?us-ascii?Q?bvPinHNkabddC8j/Fq4TNEND30vg//+YnwcPRCwy41OcE3wEOBdFDftmlUo4?=
 =?us-ascii?Q?oEYeOEMtqNW36OVhyIMtyEIVzztQVyLNL2wpOImyuZfdBKogZg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4842331d-b33d-412f-72c0-08df2d373c88
X-MS-Exchange-CrossTenant-AuthSource: CH5PR19MB997156.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 16:45:37.3662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR19MB9514

A PCAN-USB FD v2 running firmware 3.2.0 sends a 16-byte status
record followed by a four-byte zero-size end marker. These transfers
cause repeated receive-buffer dumps while the interface is up.

pcan_usb_fd_decode_buf() requires a complete 12-byte struct pucan_msg
before checking the size field, so it rejects the end marker with
-EBADMSG.

Check that the size field is present before testing for an end marker.
Require the full header for nonzero-size records and keep the remaining
record and payload length checks.

Fixes: 93fcab2c6968 ("can: peak_usb: validate uCAN receive record lengths")
Assisted-by: LLM
Signed-off-by: Liu Changjie <liucj1228@outlook.com>
---
Built and tested the original and patched peak_usb modules on Arch
Linux 7.2.11-arch1-1 with matching kernel headers.

  - Classic CAN, 500 kbit/s: 25 decoder errors in 5 s before the fix;
    none in 15 s after.
  - CAN FD, 500 kbit/s nominal and 2 Mbit/s data: 26 decoder errors
    in 5 s before the fix; none in 60 s after.
  - Three additional down/up cycles: no decoder errors.

USB captures during the patched tests contained 406 packets with
short end markers. Neither receive-buffer dump recurred.

The CAN bus was disconnected; external TX/RX was not tested.
One startup "can_change_state: oops, state did not change" message and
an RX dropped count reaching 2 were observed during the patched tests.
Their causes remain undetermined.

 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 0d46f4c..39f0740 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -755,7 +755,7 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 		u16 rx_msg_type, rx_msg_size;
 		size_t rx_msg_min_size;
 
-		if (msg_end - msg_ptr < sizeof(*rx_msg)) {
+		if (msg_end - msg_ptr < sizeof(rx_msg->size)) {
 			err = -EBADMSG;
 			break;
 		}
@@ -766,6 +766,11 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 			break;
 		}
 
+		if (msg_end - msg_ptr < sizeof(*rx_msg)) {
+			err = -EBADMSG;
+			break;
+		}
+
 		rx_msg_size = le16_to_cpu(rx_msg->size);
 		rx_msg_type = le16_to_cpu(rx_msg->type);
 
