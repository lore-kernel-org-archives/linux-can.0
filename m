Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010035.outbound.protection.outlook.com [52.101.228.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED26E35A393;
	Fri, 25 Sep 2026 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324514; cv=fail; b=bKhRoHYjtAimQ7UwpUKXy19a5Cx48fkINNKoRx2LmmFa6g8+0NAg8Zu8IZovLGxJSakm8FnIulnscWAPVUh3EQFxhNmYKLe5bxaDT8p8RG/bylsZy13m5MBSFQIUzOEa+QimvNew/eHU1vxEW5kBKwuU17xj3gISL4bJXiOCPzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324514; c=relaxed/simple;
	bh=4ZASVOe2esl38n2WtIzsT1GIXjxv+fqZtIwu5SxrcQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qi9Nx/goMuEUcFv36v5zbioUCNxxLTPBKzw2E0Fjx+c7RmbuYKSi4nMbqrSUNVkRcJI+D0jU0LWZi83QLnZksNmdO8fTFRF0z8SpAgZHEnQXmkZb2K4n+zrNj3tthi64WPRXy0PI4jRYE9NMw14Ff7IbUSbAht5PA47oZHbr+Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=as5MDZfA; arc=fail smtp.client-ip=52.101.228.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="as5MDZfA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGy+ozVbmbkGPzLMmBeEvoiM2sIfVQkMYig7MhE2VoKoqEeJVtXo+ZzP6lnSGddpavk2F8JvzDEHZ2XQ/QM2BKhW3iS4Fo0tZt7Aw1dzIPwGATkYQwULBuS57TvizZLlXjVdIsbrFyZPiHY89w8NcnzSgo9F5yWBXsKCVdTBjWh/iV3MnirJmciDNBkQ9eXKkFOVh4OZV6QTOhAoF/m3tG/vtN6SoOUF84aOYvsMl1SlAhusXI3CCvV2mKD/WU0H0plnTFzF2B9Ut4EafQyIUNv91g2s6pwLQOoO/bpHfxUSny8kKO81Prp6//LYDKuH5LQuYqsY7C7smV55/M+gYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln5lsclYMZSWEJQbR1tgHHyea5a06i7+e8/loQBEBBs=;
 b=F4dFb+PoHhSuKnv6A5eNsUh4t64sDaHqt0GotkvsNEELf8VMKF9TkLUJ+106L4CHbZ8AchtggIdX1NEIytab4wOrHC1slEmyjRKSaKUMbHTtgAIMMoB1dY2Dn92GOO+0MR/YBtX+mNF+3MDuRyJXcTO4JXrwMjd2Ci6aXYD7aVn++RQwc3XsBioPANE2NuaqMZ4cuzm/MyLg7VnfuXU1j1zZYyhENqmnPy61wSkQh2YZ+Qk6iS11PKp4r2arJkB4mnerPQPh8baLtt2VzJYJFmEv0HrxlOMvf5lYvq++ezIWI/OXhJmU5GRA3XlA9g8dfbZR/YzazMTM7tYPbLy70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln5lsclYMZSWEJQbR1tgHHyea5a06i7+e8/loQBEBBs=;
 b=as5MDZfAF1NpmMI5vaOu0cFwsBtwa6OL0tzR6vRNUFYejGqtym1AojWxL0uXNq7TJU/x5GwQ1r3vTEuoWPVn6oRpwj80RjmYoO/SqKWiI8TGgrutUTsnhJrePZwRQIDqu7sWxeiMWlho6bBjn95PlEzX94xiSPZ+sdY6pa4nnms=
Received: from OS3P301CA0044.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:21e::16)
 by TYCPR01MB18169.jpnprd01.prod.outlook.com (2603:1096:405:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 08:21:46 +0000
Received: from OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:21e:cafe::1f) by OS3P301CA0044.outlook.office365.com
 (2603:1096:604:21e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 08:21:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D214.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 08:21:46 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.93.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id E7364300023F;
	Fri, 25 Sep 2026 17:21:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 0/3] Add support for Renesas RZ/G3L CANFD
Date: Fri, 25 Sep 2026 09:21:27 +0100
Message-ID: <20260925082134.146015-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D214:EE_|TYCPR01MB18169:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7fde621d-3a04-46d0-d42b-08df1ade0a18
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	1aDye7pbTqYEse1glXu7N6QVxIFxmplncy5KqJUjTFAF4G73J9Zu25mikafE4S2Ui0H0i+fTJ3e+159bqnaeaoWj6uXmqUG5NE6SPMs0XRzIy98rADkdVxnJTbXD/eomfrrW4gWRB/MzneV5toUr4Rpll8JqRttZsaJJr8XuzmsrshIA+8gpri8YsiUG1VzJhEjKzNRzcU/onYus4VR0jjERnMdQVVLg6uRjEH82AJkFVOOBDsJjr62XOzQptUL6SAZr1/KNEVkqjiFrKZ3R5QkO6szKJGA9Z6RzVwJNjLA6s7t8iAn6nXyyhmFSt7HbtvdM92SmBlyqpXp4TkYyR9Dz0/qh23LoG3rzeny+fCLynt5xmA7w4L+goyDL180hGDDmwmR1IhV5MpBiemrIeLfionSSeaAitEgJ9p+2DPJci/O+MDTg8UdeyBfgGLq6qi9RLiR+AVyc88JYaJcYGFQvj8hilWhFlsq75zsj4gmQ0uLF/WdiINoydwkr80II+q9en4WDH2f241S2sMmLOTp4qf/cdxcSdjGFYz6vK3lkzg4UkYAOcoDFrCN6PIdAXFtfJazdIXIDsH0qYXG4caiIQiZ6j/GabmOjU5WmU9LMbe42rrfap+UkWTQyPL16XqTceR/ZBab4GV3udodJNysubQsk0s0H5MkTTi1QXdY=
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jpm0jHyluhKeCUfCzm3NfAwc/I5fswpCgK9J0ozpjEZiFNBa2zKzPX551Fw3AQooihZ/rA21Rf1kE1mmRY0QefpF7oa8cGU1p0g+21SYFfisxg6R0bUPiyJA6bD36l6FZy96pOXJqhcNVa1oYZFUEwUM57poD9vtNJVhN44JO7G5aKpppAxicOm41b8q85pYz/8DPAiMzKrGFNLgc1Nt8atXYOMJrxheVybRci68ZmbK/fi220ZzrGqkXRxyamrdazT/mZdh/O3T+1lwjmPymrOivIohWMLPnKV5/ybqM1E+iUBM/Q+7295NtpxwRhAI1wtD2oLc60GspbN2KC6REHWCma9jBUWlIasdh5QGvabA52+i3TBxpp1YST4JuN/qhwirP99se6vb+5M8pdfapAYCaS/YLcV16Rgbs/3nx3i6MVHF4svTaShAGuB43jZt
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 08:21:46.3722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fde621d-3a04-46d0-d42b-08df1ade0a18
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB18169

Add support for Renesas RZ/G3L CANFD.
The RZ/G3L CANFD IP has 3 channels and 11 interrupts compared to 2 channels
and 8 interrupts that of RZ/G3S. RZ/G3L has 288 buffers compared to 192
buffers on RZ/G3S SoC.

This patch series depend upon [1]
[1] https://lore.kernel.org/all/20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev/

v2->v3:
 * Collected tags.
 * Added check against RCANFD_NUM_CHANNELS, to avoid overrunning the
   fixed-size rcar_canfd_global.ch[] and transceivers[] arrays.
 * Fixed typo 198->192 buffers in commit description.
v1->v2:
 * Added support for deriving max_channels from the device tree.
 * Dropped clock patch as it is accepted.
 * Dropped devicetree patches, will send it later.
 * Updated commit description
 * Dropped RZ/G3S fallback as there are lot of differences.

Biju Das (3):
  dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
  can: rcar_canfd: Derive max_channels from the device tree
  can: rcar_canfd: Add support for Renesas RZ/G3L

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 27 ++++++++++++-
 drivers/net/can/rcar/rcar_canfd.c             | 40 +++++++++----------
 2 files changed, 46 insertions(+), 21 deletions(-)

-- 
2.43.0

