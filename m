Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704382;
	b=eEctGOV0PZFoBJdl1/hgs1KOTNirpiZjNLELgNjCA9mZ10LFQ33BdBZrNzRwMu5IXKj7
	 3ea891XjPRsRTT6IbCfI6Cci70s3z9H8/LRvEQQ91oX2PUbTG8Sa79hD9Rs/VzqQqMEs6
	 ubAv3roTULkVQOz58HJ0j47VTkMyfU05vJwj12Lo6uj3RO04CBJofZEyOPT9FkINcyzEz
	 ZOFPyJfttW1qaVmjaXIuGgH57a2X1EUH+uAk6DtyJdPjJnzbz9YZ+LQatUP1EVIYSjWVJ
	 mclMZtKgkTL899Ire27KD1xyvJEOy+3KgjIbeEUvFagvbMvWZnPT1ZEgwH7e1bNbX8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704382;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=drsQ/m3F/jvhH7booytJRPg0GjZmq5POwHXmQgH4+Ik=;
	b=zr4r33hfvfuQqiO9K+PcXwbhFrpCUddftY5lVn22/9AsBipqTEtK+RTXUlEoOz2agvCN
	 MQGtK2c1sSTRQsXtUB03MwVVuUSv9+0zhhFAxMfjQuGcUl+F0o8Fnu//JYhv9J7vXhcr4
	 VDKcL1z97L+mIM3/dz+Olh+5S0zJYAcEPtQAHQA68Otu6vpb31LenmAAs0s2gODsbbyXb
	 IzbGFwkQKHu8eHGvKhgL+7LtUcHkn1OAZrKJN/JKS9QsUDpc6QSCb3/jIEKBq4ccmNOW+
	 Dm32QoMt1KRYSSdRF/8thnFnyxTSPKl05gplQ6PvfJZHj1BrVRyWzQCEI2unmvFqlbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2RRfEeW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34E3606A321;
	Thu, 26 Nov 2026 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2RRfEeW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7F21F000D2;
	Thu, 26 Nov 2026 14:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704381;
	bh=drsQ/m3F/jvhH7booytJRPg0GjZmq5POwHXmQgH4+Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A2RRfEeWh8blK9xK6Gbi7fsS3zH9cgBTkMrS2hx6haDn8tweh+XsfWRAX+CCntCe4
	 P7liRoxVkH7pu0szRhescMOU2udZP5FnBHcHG2sW8ebO0g7kutb3PBj55KU8tbJa8/
	 CKXJlgvjCOFGFySHkLaV8S2LzRF82uev5jRYKl+zKF1a5yV4qiLQYEwBwMHR1eh4IZ
	 zgnx20Z5PS5cgQ7inKgJA7QCg4JVBoiDIDj/qInLLLlwPHN6IrutDI9PhLpFEc2bKs
	 MNSCqiM8uxC+XsL0DdOnSjLlXpkGaE3ZP7g2tvXN8B9irFy9tvkL1lK0poFrcLlNp3
	 2/FfYc916Yy0Q==
From: Geert Uytterhoeven <geert@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 1/4] dt-bindings: can: renesas,rcar-canfd: Document R-Car X5H support
Date: Thu, 26 Nov 2026 15:46:06 +0100
Message-ID: <1cca52e1a662aabbacca8618c8fdd312ee0be5da.1795703576.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795703576.git.geert+renesas@glider.be>
References: <cover.1795703576.git.geert+renesas@glider.be>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

Document support for the Controller Area Network Flexible Data Rate
(CAN-FD) modules as found on R-Car X5H, which is the first member of the
R-Car Gen5 family.  It is a further evolution of the CAN-FD block found
on R-Car Gen4 SoCs, adding Freedom From Interference and Virtual Machine
support.

Binding-wise, the major difference is the split of global and
per-channel interrupts (like on RZ/G2L), and the addition of Virtual
Machine interrupts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Do we need the VM interrupts, or are they meant for the hypervisor?
If yes, instead of adding them at the end, should we add a third option
for interrupts and interrupt-names, using a different order
  - 2 global interrupts,
  - 8 VM interrupts,
  - 8 (= number of channels) x 3 channel interrupts,
so we can easily restrict the number of interrupts when a variant with
less than 8 channels appears?

v2:
  - Improve RFC question.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 9adaa85ae5ae1061..189f2e4d52d9099c 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -42,6 +42,11 @@ properties:
               - renesas,r8a779h0-canfd     # R-Car V4M
           - const: renesas,rcar-gen4-canfd # R-Car Gen4
 
+      - items:
+          - enum:
+              - renesas,r8a78000-canfd     # R-Car X5H
+          - const: renesas,rcar-gen5-canfd # R-Car Gen5
+
       - items:
           - enum:
               - renesas,r9a07g043-canfd    # RZ/G2UL and RZ/Five
@@ -88,6 +93,36 @@ properties:
           - description: CAN5 error interrupt
           - description: CAN5 transmit interrupt
           - description: CAN5 transmit/receive FIFO receive completion interrupt
+          - description: CAN6 error interrupt
+          - description: CAN6 transmit interrupt
+          - description: CAN6 transmit/receive FIFO receive completion interrupt
+          - description: CAN7 error interrupt
+          - description: CAN7 transmit interrupt
+          - description: CAN7 transmit/receive FIFO receive completion interrupt
+          - description: Virtual Machine 0 transmit interrupt
+          - description: Virtual Machine 0 receive interrupt
+          - description: Virtual Machine 0 error interrupt
+          - description: Virtual Machine 1 transmit interrupt
+          - description: Virtual Machine 1 receive interrupt
+          - description: Virtual Machine 1 error interrupt
+          - description: Virtual Machine 2 transmit interrupt
+          - description: Virtual Machine 2 receive interrupt
+          - description: Virtual Machine 2 error interrupt
+          - description: Virtual Machine 3 transmit interrupt
+          - description: Virtual Machine 3 receive interrupt
+          - description: Virtual Machine 3 error interrupt
+          - description: Virtual Machine 4 transmit interrupt
+          - description: Virtual Machine 4 receive interrupt
+          - description: Virtual Machine 4 error interrupt
+          - description: Virtual Machine 5 transmit interrupt
+          - description: Virtual Machine 5 receive interrupt
+          - description: Virtual Machine 5 error interrupt
+          - description: Virtual Machine 6 transmit interrupt
+          - description: Virtual Machine 6 receive interrupt
+          - description: Virtual Machine 6 error interrupt
+          - description: Virtual Machine 7 transmit interrupt
+          - description: Virtual Machine 7 receive interrupt
+          - description: Virtual Machine 7 error interrupt
         minItems: 8
 
   interrupt-names:
@@ -116,6 +151,36 @@ properties:
           - const: ch5_err
           - const: ch5_rec
           - const: ch5_trx
+          - const: ch6_err
+          - const: ch6_rec
+          - const: ch6_trx
+          - const: ch7_err
+          - const: ch7_rec
+          - const: ch7_trx
+          - const: vm0_tx
+          - const: vm0_rx
+          - const: vm0_err
+          - const: vm1_tx
+          - const: vm1_rx
+          - const: vm1_err
+          - const: vm2_tx
+          - const: vm2_rx
+          - const: vm2_err
+          - const: vm3_tx
+          - const: vm3_rx
+          - const: vm3_err
+          - const: vm4_tx
+          - const: vm4_rx
+          - const: vm4_err
+          - const: vm5_tx
+          - const: vm5_rx
+          - const: vm5_err
+          - const: vm6_tx
+          - const: vm6_rx
+          - const: vm6_err
+          - const: vm7_tx
+          - const: vm7_rx
+          - const: vm7_err
         minItems: 8
 
   clocks:
@@ -234,6 +299,22 @@ allOf:
 
         reset-names: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rcar-gen5-canfd
+    then:
+      properties:
+        interrupts:
+          minItems: 50
+
+        interrupt-names:
+          minItems: 50
+
+        resets:
+          maxItems: 1
+
   - if:
       properties:
         compatible:
@@ -243,9 +324,11 @@ allOf:
       properties:
         interrupts:
           minItems: 20
+          maxItems: 20
 
         interrupt-names:
           minItems: 20
+          maxItems: 20
 
         resets:
           minItems: 2
@@ -379,6 +462,7 @@ allOf:
             enum:
               - renesas,rcar-gen3-canfd
               - renesas,rcar-gen4-canfd
+              - renesas,rcar-gen5-canfd
     then:
       required:
         - resets
-- 
2.43.0

