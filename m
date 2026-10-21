Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571535;
	b=WhdAn7fjlQwORE7Xlb9wKtZJ9rgP0qkPH5r4N3wBPi04WaxlXmHSJ5el0XJTQp15fnKk
	 97921W84O6LxQOnH84VFKsBMcM8UTmOGm7y5/fOVMYszpEmD5WSfe9NK035Tk6QGmUwhu
	 W4qlqmIZTE4SnTvDeRv//snyPpN+TsorMi2s5IlsXgWlFq5OuU3WLr+R2mI6FBt5/QHbH
	 YMhY5UhjE/Kk7CVEeszZoqOsgqLLgMUwRRXQ9FdsC+EryTTvbILgKsCnk1S3Q26xTiABh
	 n9kwseI5yxiWtUL6LebUX7Rj1e2TttheyQ9xSWi7mUZ7UORH1uYVsq2wClv0DwVGMnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XHkZnXLKgc2u7atwUSMq1qI8y8rutYesSRY3BaJwcwg=;
	b=YiB73k1wqxMxokhpp1YwaxASNIugRUMzEI6xqqr6uVBhcHcQ4lhAINCVGMLA+dueDyMg
	 UGHT6QfpqijyqLCt2k86k+/RVMyolmyAaVgLMuTcUCfZqAsAi8yHVBN0SzSjd5WZOs+HQ
	 gagx75i5uHciMkJSIhhyoGjuobmT6g0gzDbOhCT7gOEl06LqRf0s/vXvJo3UGv/VgjEEH
	 wzWJUOkWnMMxO6j691VF412tryj/RYjaZSwB7T63lZzEo75Os4vOKlO2FAev9hIiQbfXK
	 t+F9HFhc3V0zuQeXuBXPhONaPQvrQMTOY10NgdRWzxyTUPsF1bf4LvZHUym8lnntR5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jgqTZQ7d;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D2606A339
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 08:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F0D2606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jgqTZQ7d
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so3154415e9.1
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 01:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571533; x=1793176333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XHkZnXLKgc2u7atwUSMq1qI8y8rutYesSRY3BaJwcwg=;
        b=jgqTZQ7dXyfUmGEhbeq4E6y9+r1sMqaDFQ2eyKbLWWdyWsKmIRH1k3dcmF8i3Ys+cJ
         o1fpwrNwlMeWR8N32fxRBC6xdgS2qOymkc/A0O+8aUtPSI2mqntWZB+IDDSsttz6UMdn
         kXXiinfXuPBv3DsFl2oNYTkhCOHIPesjCnPXTetiG0XQmxuH+RMyzH59U5N09OnagWeh
         ZxqfDM7VbFOjXSuKVlOLUWVh9TwjQutcX9jaFCeLGcw5PxZyrif6peDUU5G8tW4TQyM6
         m68CoutLv6J4Gl9DBX0ZtPWWvYQ/3D8fLze+8Tgn98OZIT+bb4L0zwSCIthkxnwf3I9w
         Ma9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571533; x=1793176333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XHkZnXLKgc2u7atwUSMq1qI8y8rutYesSRY3BaJwcwg=;
        b=wrMRKY2Lvuis392IdRZfJ+VaYqKIuC1SXj1jeCtyQ9Ei+AiNoRmTGzqVwTGrX5wUBJ
         y5pGAOOQLWJtyGOmopBrQTtVqZFlevLa6rAH4D1bBtD8/AjUwjfWRlECV9U5ia7KIcQ9
         J+C2mTM00cS0DHdxE+XuO6K5eTG8/94W4q9bBkQ8kW2084xWhnuuCOS7PyO3uI/Krc7C
         gqHoaR02CTO7eg8+Lo2ttAgCBNctRheAvFcOPsENBfwCYXjwk31O+28TEGGHwYnWp51C
         aFvP/tMxlNcKiyGEI0aUeguYts/xZAOCi2z7aoo0M2B2Shw9M/qHTJjkS4C/JTw3tcrs
         taIA==
X-Gm-Message-State: AFq9FYIhP1Zj73wAIzBRTQHa9p+9mhy2KrKmW8IqJmi2KnnBMSZI45tT
	xaw1qyco9IsNw6fCqcMHaeJBJqUqlpAG7Q3XZqJOQllbRjtFEMQ9fkYr
X-Gm-Gg: AYBFou2Z90geyak/iwwSuJPXjy8edDooYe56V6TfRbOWwgZ7GAlXOXDfqxuOBiQBr/U
	GYR8SDnbtdAsE3dJaNCb6svdrZfE82zxqzb9r8PwltQzaKrTnLmvdYkmvB5jszSluvOjE6NDgGA
	N3MgaxKAqW7VxrJRcZp690EJq/DsKiWMy9cbz+X+KlT/hFJO0LgRIzpeKgF5lezowhI8Hy1jhrS
	+dCLth+ZvBG4hpfVpm8UWTDUrMFPjIt31uxmm8JRUucc4tRHeSvulw6eFBKXJjjscfaadljBO50
	frDQIsJvTqboVPRrJM7bd6LezHe4CFBshNowYPmQ54qemJhIwHGFz3taA6hOXyPs8k9V6NV+/cJ
	9CYJD2aC/JGygazvyORT4K2ULhoL+xWWetZmHjCfr5J1SDC8BZn/9v1JR1yarUhBSD/YfcHz8DX
	0mYuktM+lM/CdAPbC4LGku7qyKRy6kF62ikFdlzToXxNWD4Tec9ifX41jXDiV+B+Trke3t+CCr6
	FAEXQOCeP31crfX9aYy9V3elxNz6gfYt7oubnCEE/oITfKzenZabetiYcOiILP5C8jRCpcZ5SOG
	zsGLoyPmCj+FqtmQKOgylfg=
X-Received: by 2002:a05:600c:83c8:b0:4a1:fb0f:770a with SMTP id 5b1f17b1804b1-4a1fdd60118mr20825395e9.32.1792571532857;
        Wed, 21 Oct 2026 01:32:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:39f4:e118:e272:79d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm36250145e9.4.2026.10.21.01.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:32:12 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
X-Google-Original-From: Biju Das <biju.das.jz@bp.renesas.com>
Date: Wed, 21 Oct 2026 09:32:03 +0100
Subject: [PATCH v6 3/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3L SoC
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
Message-Id: <20261021-canfd_rzg3l-v6-3-b4abfdba8e70@bp.renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792571528; l=2893;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=X0n6ZC0bn5Ctncd8qiK6joWTdvbAr8xg0jq7gE0tCPA=;
 b=qU7zrl1cMevGo/TjFhTmY3dTbdFJ/2gHYltfN7jt23ozoCoun7k159kl0p3gPrRq0258Ohuby
 oYcudLfjdf/CQ5RxIJMg1duhhJsHtNDKDTuGxIdS5gohfsm/NsEb48r
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

Document the RZ/G3L (R9A08G046) SoC support.

RZ/G3L has 11 interrupts and 3 CANFD channels compared to 8 interrupts
and 2 CANFD channels on RZ/G3S. RZ/G3L has 288 buffers in total
compared to 192 buffers in RZ/G3S.

Like RZ/G3S, RZ/G3L supports only CAN-FD mode, so renesas,no-can-fd is
disallowed for it.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5->v6:
 * Updated commit description.
 * Dropped adding RZ/G3L in the description of renesas,no-can-fd as the
   description is generic.
v4->v5:
 * Dropped the tags as there are new changes.
 * Updated the description for renesas,no-can-fd to document RZ/G3L has no
   Classical CAN mode.
 * Restored maxItems on interrupts and interrupt-names.
 * Added resets/reset-names required property for RZ/G3L.
v3->v4:
 * Dropped maxItems from interrupts,interrupt-names and resets.
 * Collected tag.
v2->v3:
 * Collected tag.
v1->v2:
 * Updated commit description
 * Dropped RZ/G3S fallback as there are lot of differences.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml       | 27 +++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 81674ea4bef4..dc7437702120 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -14,6 +14,7 @@ properties:
     oneOf:
       - enum:
           - renesas,r9a08g045-canfd        # RZ/G3S
+          - renesas,r9a08g046-canfd        # RZ/G3L
           - renesas,r9a09g047-canfd        # RZ/G3E
           - renesas,r9a09g077-canfd        # RZ/T2H
 
@@ -292,6 +293,27 @@ allOf:
       patternProperties:
         "^channel[6-7]$": false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g046-canfd
+    then:
+      properties:
+        interrupts:
+          minItems: 11
+          maxItems: 11
+
+        interrupt-names:
+          minItems: 11
+          maxItems: 11
+
+        resets:
+          minItems: 2
+
+      patternProperties:
+        "^channel[3-7]$": false
+
   - if:
       properties:
         compatible:
@@ -332,6 +354,7 @@ allOf:
           contains:
             enum:
               - renesas,r9a08g045-canfd
+              - renesas,r9a08g046-canfd
               - renesas,r9a09g047-canfd
               - renesas,rzg2l-canfd
     then:
@@ -356,7 +379,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a08g045-canfd
+            enum:
+              - renesas,r9a08g045-canfd
+              - renesas,r9a08g046-canfd
     then:
       properties:
         renesas,no-can-fd: false

-- 
2.43.0

