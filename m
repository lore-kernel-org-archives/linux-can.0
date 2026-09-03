Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF33F3A7839;
	Thu,  3 Sep 2026 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422693; cv=none; b=cBg2DJ+z4rKzwQ1XhvkBxvF8xJIeV+iDY/l3s20v5XBMIinXeH94/oqovG4J/T58jXZGJSBYONPUbQ/uwwyO5ef+LIMdBhymeI9ZZvw+DL/I31JGw8vMWk9Xb24aDicFbKIoz9BoWaCbw6uu99IIOl6iSMfANTVgltrbUQNos5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422693; c=relaxed/simple;
	bh=h2ldmazA5v4mdRaUIrWW/FfjdGihQsR4HCRicL5vgQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzRjByvnnHAhpeiXr1MDzTudunQlf0OkMj3T8JlX2nuWOTbyys63vyVLR/zD4yQBhVYnyPMiG37fsz1Mq/jecD2M7XtVeH+IBksT7TFEIRR2PgjAZbpGrLsmDrN1gNDmGJ6HPiyTiCKuTO6xSL6XADo90ZEWD1mGD5ku2HhF010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=LeWR7577; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LeWR7577"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1788422671; x=1789027471; i=wahrenst@gmx.net;
	bh=FpLnyOXfo46RB6n1cURFdPxGkl5NCQ3MrHGWEwfPNVs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LeWR7577cR8jW/vc7fr8WXihNjAvEhEQWf7rk70tw/YVy5+NaUdWruej6Xq7Z80T
	 JZoTxsolrU18cZIMr1AYhAHMrqHkifeT/Ljx5F0o91X5tAhTXyPVfl71Nspw20lPV
	 v+MHUNOSwW+6GFQSz1e9HLceIBhqKQm3eVdU++sohuz2stvTs8thZKUW/QmG4zG2B
	 DvvCQm2NM09qXiNaYSqF0NgrePy7HTVuVJqaHyK4Do50Psi87AfLfc5mLhktl3zMC
	 QnHibxMtb/PEuDMj+fc0EDbuP+jWVPFg1Jn9uHf6lutNnum8uir5gtC75qCkIApf8
	 hUFliddW66YgSOzNuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAONd-1x8rvo2qE7-00Cgtk; Thu, 03
 Sep 2026 10:04:31 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aswath Govindraju <a-govindraju@ti.com>
Cc: Christoph Stoidner <c.stoidner@phytec.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	sashiko-bot@kernel.org
Subject: [PATCH V4 1/4] dt-bindings: phy: ti,tcan104x-can: Fix property constrains
Date: Thu,  3 Sep 2026 10:04:24 +0200
Message-ID: <20260903080427.6103-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903080427.6103-1-wahrenst@gmx.net>
References: <20260903080427.6103-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lZPzleGRmX+Qu3EXOHQNAXDC2uwKc2ekLa8c1Loth6UwV/X9x/6
 ky4r9+rbd5p5nb6QPAEH3YPPbUElGN579XCUGQZyBHlD49C1htckfzzXb/I1eCBUMoMN2sH
 tEhySoloThmbC58Nnj2ogVK/ZgrcNTUvV6lNpvBAzBF4CUwjsEtRUR68Tgku0T5+p7uGcYs
 OOM7qEr3KALlbRsq6o+iQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xhrq0OKJX0Q=;gPBuzcTUcnEfGlpKXDzpouHAxOf
 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
 +o0b6tJ9duizd8GEelTAyePpHVE1RHI9r0bnmy6wxLNoH40MoU5kKN080ohbOH9gVuJjk71g0
 XagPVqmqj7te/E0f/VCQIBmB2JdFlJ3Prq+fVHX62RoordVq558lt4V8TaKpXo0xJTusSA6RP
 xIS3la11RrtzddNC7/2lnyUhpdFqDHbS/J3FdQTrc51kXu5ioDZH6n1PftHxbDln/aFYudSTU
 vVdcvGLVchrPFPAUF1N7J0IC0Evyyy0rw4BDC9sVa6hc3B14OEzIjUkHd+laGs5TgKHFP+Ubi
 bmkQuSZsu26h8X74TgDtP38Z84BQwLtIm5A9KICLBV9yRevanaCTfaCIySWklY6PBgfrkzwtz
 2bdHMmG72JwORDW88yS0ydaWRA0tFfKdH9bz4gHFu+3FOCsHl7GntQfUMRfswdBflf/Io/sdn
 lqGKFaSlXL91XSw8CS4a5souJi1gOiIbekYtkdUirATO5pHvfidFNCtrM65LfpsF4gIF9Wp43
 qbcsF1jw+WToostANaJ0ozTGDarblpzljDcXDpfooYtKGW7Z4757IaPG+PsbldYcc1CdKLq2P
 HqKBX9Y9XXArWH6e2g5xhgp7DjWiCwC/

Microchip ATA6561 is compatible to TI TCAN1042, so the same property
constrains should apply. But they use a strict scalar enum match, which
makes Microchip ATA6561 fallthrough. So add a "contains" to cover also all
compatibles ones.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-devicetree/20260902133525.E22DE1F000=
E9@smtp.kernel.org/
Fixes: 05ace63d0bcf ("dt-bindings: phy: ti,tcan104x-can: Document NXP TJA1=
05X/1048")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml         | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/=
Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 9f5c37ca6496..0cf5fa21106b 100644
=2D-- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -71,10 +71,11 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - nxp,tjr1443
-            - ti,tcan1042
-            - ti,tcan1043
+          contains:
+            enum:
+              - nxp,tjr1443
+              - ti,tcan1042
+              - ti,tcan1043
     then:
       properties:
         '#phy-cells':
=2D-=20
2.43.0

