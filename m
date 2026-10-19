Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D54848AC
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411353; cv=none; b=YJXwSZ6EkL7CiLsxxR7NWbYyj0TVvL3CMYJRmZho2HIn3RKDsE5SKh+8VLXcYehJfoaYYmI0SWIVNgQvrc6Xyvdz8T+0VpERgw9Hj80r7GL8F+osKR9rt5O03CSeM6jZKlXKVHqNknkKfp9gdpj1473105My63pVFNsgFRYkrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411353; c=relaxed/simple;
	bh=jJW7RQip9aLZnuTavNG7BTkWhgnupXed1qgikA55KDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8kGLomGqlajR1f+gUOg4Qb7Wgbz3x3y/u8nALJuK7KsvyICWFpJ8bE+L/cR678hvSMxDi8WNhM3xNXZMzyrpPM7bjKPIhb1ZDWBLrgGBpybdRsacDxtfqz4rOZyapjtieCZTQ2QN5oLxnk3JGWRZUHbSTlB6BcV6wiCp2qG8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xsz9hk2g; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsz9hk2g"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1e266fca2so7316855e9.3
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 05:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792411351; x=1793016151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pao6ud2K4dDg314zRiJyzOc7KVdNceVjwCxdWrFBC3o=;
        b=Xsz9hk2goW5JJdI9NPJD41m6IDQjOE6aB40ttgitWi/438z0FZQEbdr1wXqn53oxnA
         Vyw4lVw1aJ8F64ImwVV0r2j09IaRMXC43ieaDzqL99YnAhcM+V5wLVJoFNdNmGhe/lAD
         XwL2mA33lE6FuhCjBuZfDa/1sF4Ls4WoeaUn4fNDqbRPzeZ91QK8eeO9Lqd+Lr1ClGke
         y1JxQqxtV3+RV4EkNJgppypff2bUp+QsJ1H3WGLBZEABh511D20LYQdSaBjgB4whBdUl
         DDHprNW5Kz2Pxp1sVpjy87xyXlmpY98U/7C9yY3N+aj3Kw/D/I5FQqikhex7HOUf1siO
         N2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411351; x=1793016151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pao6ud2K4dDg314zRiJyzOc7KVdNceVjwCxdWrFBC3o=;
        b=2LKxibSpkJwAx35xlSrshugMvE1Tou7pYPk9QeaB/wtrRYpTA41J4LqjNoMDLsbUtI
         OH0YWVHpsYS4hrfvLAR/NK9GqOn3wuOUooXkouhAmtTLdO1geLY8/QMEV85zxgMgFfkd
         fpLLBNu6gvzoQEWWQzO5+DoxK2wjh3orYUMZlU/9nvI4RUADxlPCH1iL/1ahlruZtkog
         tW4swcz7f9AIs+4JcW2c6tXr58wIQD3DIiFX3QPOAZEr4heu5BUnHrZMWWRFxAeIf5k+
         m8GYnYYPZ/yNKBKcqqj3LOsntDw1Nry/sEgcoxg9mZ8w4PV3OEaVLDwhhC3BnOh/tHIw
         vrQg==
X-Forwarded-Encrypted: i=1; AKwUvBylBxXPQAsht/GkyaVxE/38PEA69XNSiCSFPFPo7hJZlRDtPimNQIdMNyb9C7GVgyXXfIYGSrFvEzk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPo84s88jPRoLZ71Trrihj2D4wWWzW/FCTSpeU/vnndBKxqBBJ
	zpj8rGgqZGjvkIxtxvucjfRY+BK1i0UdklQHfMX69zEnSowPZoRzydaE
X-Gm-Gg: AYBFou09bskQgQU0hoA7hTt7XCL2hLcd0/8mF+FJJcW4Wgmaf7Y1N9SUiIlmJHhVaL8
	aNyN9iHcxS9kztKx0LiHAuF0HihjwINKRdM8dO+Sp4u3r5hWD+fUVHIpInBZH/j2D4nIdjqPakX
	mDSlLraOMmIdLXF6J/X9rMzVqRNQFwDXvz/egUApnieGZTuy5j6XtDQ0wv3o+TIZtUDhC2uQsxo
	zKdaDBxg/AerKCMgteh0uuiqCrjEOMj/rzT+XJasHuO9ZgsF+4CpUp1G1wq9bNyFDY+fj89WWFa
	3qbolf56rJXIONAeXQZJrYLb05CQtdS+8lHaVqA6IGca1+n3u8emkYbtfEeLUbt75SOplBB3le0
	WrJ7Jm8HFj+DKoj2qFOddXbD91b6wDIuww1GyG5mJAIloIr5Luk+5/dsfchqTTVNwlZzPqiVVMe
	LQNhK6vA4s8ijZsu//5vZ5q4PRiDMG5L43vK1aJrrPNqdgyIgzIBgDTzF2WvvhgA92TrSV/rtWv
	SWHkJourZvlNqlg+fDjY7hQu40ltc1y2eZdNx4krklDd/T5ygoqvB8=
X-Received: by 2002:a05:600c:1da1:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-4a1d76011ffmr164064965e9.19.1792411350653;
        Mon, 19 Oct 2026 05:02:30 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:1439:c865:be43:6676])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfdc4eecasm22400720f8f.13.2026.10.19.05.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:02:29 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Tu Nguyen <tu.nguyen.xg@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v5 2/4] can: rcar_canfd: Document that RZ/G3S has no Classical CAN mode
Date: Mon, 19 Oct 2026 13:02:14 +0100
Message-ID: <20261019120220.166163-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>
References: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The header comments in the driver describe Classical CAN (CAN 2.0)
only mode as a mode the controller can operate in, without saying that
this does not apply to every supported SoC. RZ/G3S does not support
Classical CAN mode.

Update the comments to note the RZ/G3S exception, so that readers of
the driver are not misled about which SoCs can use that mode. This
matches the corresponding dt-bindings update.

No functional change.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 74c3c3f20991..86fa88ccf63b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -6,7 +6,7 @@
 
 /* The R-Car CAN FD controller can operate in either one of the below two modes
  *  - CAN FD only mode
- *  - Classical CAN (CAN 2.0) only mode
+ *  - Classical CAN (CAN 2.0) only mode (Except RZ/G3S)
  *
  * This driver puts the controller in CAN FD only mode by default. In this
  * mode, the controller acts as a CAN FD node that can also interoperate with
@@ -247,10 +247,10 @@
 #define RCANFD_CFFDCSTS_CFBRS		BIT(1)
 #define RCANFD_CFFDCSTS_CFESI		BIT(0)
 
-/* This controller supports either Classical CAN only mode or CAN FD only mode.
- * These modes are supported in two separate set of register maps & names.
- * However, some of the register offsets are common for both modes. Those
- * offsets are listed below as Common registers.
+/* This controller supports either Classical CAN only mode(Except RZ/G3S) or
+ * CAN FD only mode. These modes are supported in two separate set of register
+ * maps & names. However, some of the register offsets are common for both
+ * modes. Those offsets are listed below as Common registers.
  *
  * The CAN FD only mode specific registers & Classical CAN only mode specific
  * registers are listed separately. Their register names starts with
-- 
2.43.0

