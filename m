Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CAA39F179
	for <linux-can@vger.kernel.org>; Fri,  3 Apr 2026 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209818; cv=none; b=hyC6fGoFEds01+fVn7OC3LNeXwMhXwuo3QpRxcUg9eYyx4cwqfoPZKAQwpIuio4Hg6JhDc3Ore7y7Li4HicVLKEcloi5HhbbYjHVu9zi3ZafXvAe6Gd+4HwH9AJnUWyiLM3EWJPKR7g1iZIb/+VYqTRb15L1N9a37Z+v6MSbyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209818; c=relaxed/simple;
	bh=6ugWwfQ5L0iabK8CMZr+B4V7AT4RC9S6pPlq4Ilxjxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ox13r8hLgPYnsey/JLArw3p5WF4/73RyAIM0maRlKRHjfJsIdnvl1gy7Opg6NiRwbqxnsZS9Tw0pM/aiPwbqvkTgfr4Mal2lkuVX4gh/N0bbDwDiXSYTfb8GSpqyoSYpJ9G2sJERMJuiEktWGADG7H2YXIHw+/itCB6LIbsij9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfXOxFKU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfXOxFKU"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48896199cbaso9443335e9.1
        for <linux-can@vger.kernel.org>; Fri, 03 Apr 2026 02:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775209809; x=1775814609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jbdj/CfPzvOfHuEeqbKOKvVft4NyhHKd3EC2N1Thlq8=;
        b=rfXOxFKUe669fED/C70yEKWrycbl9+D2etb/qUGXs1OOFYiwiSChxtiMRr3bqXTAeb
         3G8mx9smvCKZ07/2LLYNOLbc5hif4moFSf6lpgfzIsCDo6FCAMUc8TJuWeBf4hXbP4OO
         +Le7xrrmqBdgn8VwyG0ciUVqHzbi16ki+lCWMu54V+u/rvr0k0JEy7axLJrEnEYl4TXI
         8Rm7EjuaKmdxpYGhbXu+tXgP4zldEKXnqs7GR2N2A9hA/8Ij6OdPEblvNzho4F5JER7I
         CUUqavOcqNWD8EH5+99Q2ukKpKFfnIC9ET4q3qWUDQkZl9dHyL1l0SdK/prKnunc5BMI
         VZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209809; x=1775814609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jbdj/CfPzvOfHuEeqbKOKvVft4NyhHKd3EC2N1Thlq8=;
        b=aeuu+6Sqvwr//Ia6QN9skXMj1jRCcEdhhGN8JopV31JwuZmCUjxP8zF0fbpwQiv7ND
         21vPY1Ewoz9nfvsoGkTLSLHnlrlEZ32B093YBNPrsAp7PKIc4FffmXU7g4tValnRi23p
         I+GCtvGWjUGhINmeqj9HdIvZs1LptwV1gl73uSAj3Bijb5EALoM7RXRNrTrF6GQjuoMv
         BC/Y6dGi2KoLYCG8utFJX3IwUyAqTmbAkCcixjoFDhXfufp+20danN5KxKNazkd8RGQF
         Kwnv8dehNJG7GJxorf3htng52N5xCtOyQT7bJofBdAPRwRZa0Prlnu2r5TB/rZl5tyUh
         Y8BA==
X-Forwarded-Encrypted: i=1; AJvYcCX1/SH70hoKioXR8l3c8tNzm+/tMrKktGHCr97C3cUZ7NeWqkDy1hkbDhmYrW1BPJIMBGzL5VI5pXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8IShSi/tl651633KC0nb1mOgsSQAn10Em+CBlZiQH/PGTIuv
	3d90b4hkZVr+/7XZI0K/O98xcH+6PuonAO7pG0sUqxZszntKM6m7AdGd
X-Gm-Gg: ATEYQzyrCTymk1S6wjEypXVFU+xI+MZTzM+cwMPBRlm8EvcajMRDQCTGTQ2IQ9P1zrS
	NwiuYkCn+zgEz0Q51J7oq5A1dXSQVpAPLmwxCrRSS9C5NPLSaVCRUyp/e4TyRNtQd04ybhl/MxL
	8WUHvpWoOW+l04kFRzb1hhm+/a/rXtJG8V88f23ASnkN99hp/58yx1zbHzFOovQzgVCUJaC5eqs
	yi3/PM1/8Et9xV73pu9VFpBlOXxzeb/uLIxYXQCz3xIJd3W++5daaRnZrc8yCoy3D2RRGEDBrYB
	n1n712HmhzLW0djWt1LNg80sXLfe57JltFvOFyuuODKFOlKh0I07vNNeynyVcNI4V1TwxNPdT+7
	PHIe3VupiNmuQzGwx3DBpHRZD5OVUGP7i9NvLEOUuBOKmMqHMpvEy7I8e1qNbWDCFOnz+tKP77y
	8ViR14zVHtGcU601JHDRDPdV8nMKc5qDpgvZhOtDtldzX1Lpc5
X-Received: by 2002:a05:600c:8b84:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-488997b2345mr35984745e9.15.1775209808745;
        Fri, 03 Apr 2026 02:50:08 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:58b8:b4b6:c8e1:8690])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fc89c0sm25965355e9.1.2026.04.03.02.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:50:08 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
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
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 1/3] dt-bindings: can: renesas,rcar-canfd: Document renesas,bus-off-recovery-mode property
Date: Fri,  3 Apr 2026 10:49:58 +0100
Message-ID: <20260403095003.104542-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403095003.104542-1-biju.das.jz@bp.renesas.com>
References: <20260403095003.104542-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Document renesas,bus-off-recovery-mode property in the Renesas R-Car
CAN FD controller binding. This optional u32 property allows selection of
the bus-off recovery behaviour, supporting four modes:
0: ISO11898-1 compliant recovery
1: Automatic entry to Channel Halt mode at bus-off entry (default)
2: Automatic entry to Channel Halt mode at bus-off end
3: Entry to Channel Halt mode in bus-off state via program request

The default value of 1 ensures backward compatibility when the property is
omitted.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml          | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index b9d9dd7a7967..4190e514a7fd 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -154,6 +154,17 @@ properties:
       communication in Classical CAN frame format is disabled. Specify this
       property to put the controller in FD-Only mode.
 
+  renesas,bus-off-recovery-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3 ]
+    default: 1
+    description: |
+      Bus-Off recovery mode selection. Valid values are:
+        <0> : ISO11898-1 compliant
+        <1> : Entry to halt mode automatically at bus-off entry (default)
+        <2> : Entry to halt mode automatically at bus-off end
+        <3> : Entry to halt mode (in bus-off state) by program request
+
   assigned-clocks:
     description:
       Reference to the CANFD clock.  The CANFD clock is a div6 clock and can be
-- 
2.43.0

