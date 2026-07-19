Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438911BF33
	for <linux-can@vger.kernel.org>; Sun, 19 Jul 2026 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784469713; cv=none; b=ux00eBaE1OhIFgtDoMPFzJsvz97e9ssw7jajPyopDbg1YVZxleDveTVq8hNJYeWcMC+r0WZw6dCmd5kqrhr/Fy7tPiprvKxI/TZ31wyIw7RI7cmP4Xek+wxacnjALTchdaIJxFViQelv7ERro+/mY950dxkXeBrjKrrt69OVeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784469713; c=relaxed/simple;
	bh=AvLin6EDY6264ybOlhKWfxnfgaO9Sorakm1LZ4HBTD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zq43EfnUr2EDevoB5MKgX6Zw2jBf1bb+g7LONhhQAQJ8hKjunemsJsKa2bZhevkFS6PxieLBauOUbTCHyToc0y1l/hLuqPK5SXBoQrtZrQkd+ZEwa3Mazsb+nlzRuztsWFXaMqJXhWxup/oUFH1hwD506rWBR5wGDv01seLXRkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fl/2JaTn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl/2JaTn"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso6124167f8f.3
        for <linux-can@vger.kernel.org>; Sun, 19 Jul 2026 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784469710; x=1785074510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zxf1Fi8GIcPdFPVfUhThJUmBpCeIaz9jG77yqiqq2HI=;
        b=Fl/2JaTnsZU0tVwKPFdr5hQziVDSGRhYMESekf8AmrPLyq4FookF/NjV7mCPCjVhz2
         i2Cwy8g7Y6d+lSc/BZtyRtaCyPER1P2qHOy8QSn4fd4asoU0EWlri+q4tOjJbfRjIE/P
         MK/3s9fioA4/Snwv3lGxJ97xQk6FReHwNy4VIP106NsAWqxiK7dPm+R3j9j/6Om0v9wT
         5twKnY81MMQu7Lpx4OejhPOOBihWyi+boYlQLuhR1KEoTzxRmBmHRoUsYU3TLJEaqblE
         JveKBfmbh0She1YegLjnAe/F9EtZSadN7Qjgbz+Q34wynqGKfW9A15hgMR7JxM15dv0d
         wknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784469710; x=1785074510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zxf1Fi8GIcPdFPVfUhThJUmBpCeIaz9jG77yqiqq2HI=;
        b=hlSUhOlFKd/N6MaPWQ/LDgfUeUqzhbinko8nRtXEWDzFwX2rQhcRVdINjsOrizH5YG
         glQCbCsXTQCclbfnlnh1JLHQJrtYQZa0tBuopRrufT49yhQiS3kUDhUZafD2qL7R3Hxk
         bS6bFL6KqBesB909EhZgCtlsAcMSEZEUXC5oPW+xHZ2cP54/JkiNlTLfp+bSf+ZZDxYw
         xV7oME0+YB3g0zyKbpsVu+5U38lRmFN47YEY7F1fRtlbybtD3Ypua6Uod4+xva+VFLxA
         Na4KpcX58FUnCfOJSR7nmxRDH9Zo1eX7uS+Q0w1LqSXqGhRDKwbVSqzQRXkgOJ0aPkw5
         k7MA==
X-Forwarded-Encrypted: i=1; AHgh+Rrxs4VUX583qeKeJ2Q9RomDU7oFmbFsPhYltf/7EE7yxzUj33UJQV3caKPUBxWRYv/TnfiER/b4eXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLE8tHb5SwuejNkH6LJIqMoYjGDCZG1VkFBqGIm2O7ZJoxaJe
	CkKmOiGnp64Oib9Ul899CAI5hO4D5EuKR1b5dUqCKLieltHz8zIP0tnW
X-Gm-Gg: AfdE7ckp9R1rSIKQHxc1COj/McKFl6+KgPqz2oUVMliOC9ev7Jew7sYq87HpJtsk3oG
	4viumQHUrQFwFM45rNQjOgs5+8bS+7F+1SyezlcMs1NGm1tCOVq1yHrxxP1SADa0qVkloAuPnur
	frTnN9WqCnW3kENsegfVWabmCsFbkXDrVUcueLd2vHwdx1ZIO/WXJz1ww2iS1a9tOOpjzt2tIJI
	QRR8mryIVW6nd1uL/a/lgP/FOVOnqvDweIw4JEdew0kDeRfItz44ehJj/0RP+3kg8NkcBIuL2f+
	YQB4MMTX2ocnk1yRAVXldXe3QQvXtWcmcOCLHznFlOwgVHSh9RKshn5dNp8ijuT/IgzBJOGx2l4
	unIc0c2lFOfdLPsq/qcLa2rCG8jML8vuzxgSJcpgpR/sCeMHI7pJQOSFUl+N88BTww+PnefvqBU
	bw2tGu/QEz3R78hZi7KwWZVlYglLGbfb7X3YSLKTBblxzF
X-Received: by 2002:adf:f604:0:b0:475:f0f0:9ef6 with SMTP id ffacd0b85a97d-47f6233f338mr9270742f8f.59.1784469710353;
        Sun, 19 Jul 2026 07:01:50 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63e49ce4sm21657818f8f.8.2026.07.19.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 07:01:49 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Eduard Bostina <egbostina@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH] dt-bindings: net: can: Convert TI HECC to DT schema
Date: Sun, 19 Jul 2026 14:01:27 +0000
Message-ID: <20260719140127.3558941-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Texas Instruments High End CAN Controller (HECC) bindings
to DT schema.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 .../bindings/net/can/ti,am3517-hecc.yaml      | 64 +++++++++++++++++++
 .../devicetree/bindings/net/can/ti_hecc.txt   | 32 ----------
 2 files changed, 64 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/ti,am3517-hecc.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt

diff --git a/Documentation/devicetree/bindings/net/can/ti,am3517-hecc.yaml b/Documentation/devicetree/bindings/net/can/ti,am3517-hecc.yaml
new file mode 100644
index 000000000000..7874e9e49224
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/ti,am3517-hecc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/ti,am3517-hecc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments High End CAN Controller (HECC)
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    const: ti,am3517-hecc
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: hecc
+      - const: hecc-ram
+      - const: mbx
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  ti,use-hecc1int:
+    type: boolean
+    description:
+      If provided, configures HECC to produce all interrupts on the
+      HECC1INT interrupt line. By default, the HECC0INT interrupt line
+      will be used.
+    default: false
+
+  xceiver-supply:
+    description: Regulator that powers the CAN transceiver.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    can@5c050000 {
+        compatible = "ti,am3517-hecc";
+        reg = <0x5c050000 0x80>,
+              <0x5c053000 0x180>,
+              <0x5c052000 0x200>;
+        reg-names = "hecc", "hecc-ram", "mbx";
+        interrupts = <24>;
+        clocks = <&hecc_ck>;
+    };
diff --git a/Documentation/devicetree/bindings/net/can/ti_hecc.txt b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
deleted file mode 100644
index e0f0a7cfe329..000000000000
--- a/Documentation/devicetree/bindings/net/can/ti_hecc.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Texas Instruments High End CAN Controller (HECC)
-================================================
-
-This file provides information, what the device node
-for the hecc interface contains.
-
-Required properties:
-- compatible: "ti,am3517-hecc"
-- reg: addresses and lengths of the register spaces for 'hecc', 'hecc-ram'
-       and 'mbx'
-- reg-names :"hecc", "hecc-ram", "mbx"
-- interrupts: interrupt mapping for the hecc interrupts sources
-- clocks: clock phandles (see clock bindings for details)
-
-Optional properties:
-- ti,use-hecc1int: if provided configures HECC to produce all interrupts
-		   on HECC1INT interrupt line. By default HECC0INT interrupt
-		   line will be used.
-- xceiver-supply: regulator that powers the CAN transceiver
-
-Example:
-
-For am3517evm board:
-	hecc: can@5c050000 {
-		compatible = "ti,am3517-hecc";
-		reg = <0x5c050000 0x80>,
-		      <0x5c053000 0x180>,
-		      <0x5c052000 0x200>;
-		reg-names = "hecc", "hecc-ram", "mbx";
-		interrupts = <24>;
-		clocks = <&hecc_ck>;
-	};
-- 
2.43.0

