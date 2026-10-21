Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571534;
	b=oRuoWHsNVgT6JFKHcC8R2cUrKsgt8KNf6mU0kvWhWZ/BlUYrh6Trof9uPpNuUqeJzp75
	 spAgjW+rq3Yh5khtiFKW8UPP6ATf9ipqcQDc3F944n/BnO8PzG4SXOWnHs+YkOPrJ8tSm
	 wal0D593bFxcPnNhSVeghgOktvh0TazxkcvgeegzWIFMw7MZnW2Ay+80yjM6Ohv+zm4Is
	 6SiH/rXL1YH2MeoZOTKHLB7Esrt5jurpDpTexotH18QIe2kEnlBk23Uhvsjn5XLLbSrz/
	 j8vzyyAwFi0iSBzwPJSVsmyuzI57Lz7doX95w33PJMhLAQrhj2pPB+NrdC2i3xcHiCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qugW0mkjzTqi+Uk8CHKv0GYVKg1Y/PUT958GB34KimE=;
	b=ZwIzAbix31qgQ2iy8aC6RQ1XnfnHAOClrKcvSGlTN3BGlqqrzc9M137oRBEH5y1J9Jk3
	 xXroA/f++5cdfFCRFJb+lqX4EdJen0JWEtlouYyntjgUHOtEf95zSZNmiP+obYWNcd5v2
	 CTt6Pp0r8+gPA70Q8THW1GXFzjP6OCrsW7afrV8QyCj88eVJyd0mnE4MAegrnZTxHCNTz
	 Melj+rIDUdD1HeKltcw0bh+hRghRidm4a9xCk9QYlarzb1uM1N3JNyx1VKLHS0KmGeUiP
	 VahZURP5Hsm9uWxPzBji37riFoCFQU6VL6WcvP+Xb2fQtPtaF+jZhaFw5YkjNeFvZ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NjbTlr+j;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4674606A339
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 08:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4674606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NjbTlr+j
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so3360655e9.0
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571532; x=1793176332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qugW0mkjzTqi+Uk8CHKv0GYVKg1Y/PUT958GB34KimE=;
        b=NjbTlr+jXydAyPJs0tvpBO4ACVcvtrd+kiCAzkUz1NhWR2uBQ/17TE9cgQZF4LjBK9
         Mh2stAnMD3cn9DjNQTmh7yPpmDTU3x4bkL1RIlWZOJvQBCUovZF2AI8cFjZqrQzpfo7n
         o0FS7CcQ92AZUV6+ZOd3/1K3wYfgyzpEYgyAHctSweUQj6cadMGpLR2Sr3fgaLWY4C3X
         NZEay/+2g87FEP+Wc4eDXV1V4IDvTReDljK+1F4gOUAkHRrtUo5zZsxe+Ti8Z6Jko5gH
         VV1hkQSnFjLOFMonJr3Mi43HIq8WW/fENmkpJm54zWMGOxojjIAk/3aLseOrrA4t/A9s
         VsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571532; x=1793176332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qugW0mkjzTqi+Uk8CHKv0GYVKg1Y/PUT958GB34KimE=;
        b=oSqeOTWSFCLQzcqqy4yWpYYL7Rb2a6sfVrogAg4zJ46LxYr/qUZka7K857i6OcSfhW
         +E8Y3vQPlY02gZp8WXED/v6U/q4TXhyaNZMZqCpBvDsl58HGmQGP08ybT0wz3y2G0KA5
         U+Ge48CWpUwHkPIEph2j/wWXi15Q5mCvRuHjmam/Ce2SoFFqiF91+llo388esFxr2KjV
         1JkoYlRWg8f5JGolRMQHcCHHN6ifWllg4mfWtNpT0kJgCAsJTgFRq9P5IAxNQPtCi5Vr
         GIW1Kfvym9lto8pnA/AXi3FbaE9OMGqneJQUCQRx/rQQBN8GfvmNlV3USSE+qWIpJXpO
         L4HQ==
X-Gm-Message-State: AFq9FYIbi37+kzOH6KbdmcquFVyobQrgiaICidMeqybtv3Wps/ClVPTZ
	1UdQsB0vGtY8wsgOYJ7yMLeXyruzp2y0qzLQANXDMUNfHKmuRMCyAebT
X-Gm-Gg: AYBFou3rHzNeoSCOC1XSWACZTY/RwrQdAM6NortlAfV0kbqpqHo8L2wzwEZvhFvVPSR
	Y6c4vEqFUo12myXUvT7IkOpGoQxGPCVvgkhY80aoXZLP/GNKOfKCNJ4Ql8Hwha4JRb1fK8YkNIP
	PnBa1MWaHRcTmtzklYBy7M4HHvqEXFmCKQzskC2pZ7H541EuqSvQf/oflI/RRFL3fDXZxsThYCg
	czn2xth5V5MDLOWU28WrY94qsrnXoontPaOQVriCsEB1CnUbSmblPPjrIDbNbLbOcxViD8Ugm4W
	Ektik6j4kZiZ1V4mLAWzr4xBD8z+7fBCxzYEQHf024gDQlQgVLEEVs/QLbnfa3G1ZX0U3p04N1Y
	2pPTOJCV7/9/J+Hcl4pVDT9IDngFwhodtHJSkznBrmTMHtm1/DnOXzKl/F+5UMWEDw0N3Lcy+EN
	u0bAZcZIkhHxdDSRIF5dyC1I414cy1WtyjAvEMXCI9ZUZ1JKO1Zc9c5Qhjt9CoERZhO1ULF0AXl
	lvk0pCK4cAmkgCXRaHs6fUMD3dGPYjBKQyKL61bPeWLa6FvHaviP/osc7eI08a0O5gwr8PqwpHx
	CzRAfS1yU8TAQE18wgddpM/i
X-Received: by 2002:a05:600d:82c1:b0:49f:ff73:9971 with SMTP id 5b1f17b1804b1-4a1fdd393c4mr27446305e9.18.1792571531883;
        Wed, 21 Oct 2026 01:32:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:39f4:e118:e272:79d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm36250145e9.4.2026.10.21.01.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:32:11 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
X-Google-Original-From: Biju Das <biju.das.jz@bp.renesas.com>
Date: Wed, 21 Oct 2026 09:32:02 +0100
Subject: [PATCH v6 2/4] can: rcar_canfd: Document that RZ/G3S has no
 Classical CAN mode
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-canfd_rzg3l-v6-2-b4abfdba8e70@bp.renesas.com>
References: <20261021-canfd_rzg3l-v6-0-b4abfdba8e70@bp.renesas.com>
In-Reply-To: <20261021-canfd_rzg3l-v6-0-b4abfdba8e70@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792571528; l=2116;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=Mg413AXv0aGcEtmQw7fHPMeQbyR6mDUhguY+IkbxUz4=;
 b=5UDGorg6z9o9aQnn4qhvwiZ7wCyKkhzrXmsxtNFpUNerD5RiOUOmSGzeOxnQmw+fmN6aQD99Y
 DccY/J7tFg6D78t0Ew2YPn4OuS7iAD0nxIi9WHtERMClwRBvjuwf1V5
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

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
v5->v6:
 * No change.
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

