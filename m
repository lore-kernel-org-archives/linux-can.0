Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9D4C6EF4
	for <linux-can@vger.kernel.org>; Thu,  2 Jul 2026 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001251; cv=none; b=to1EA/3onBi6JISW2Pi3R7YAtaP9tc+RgqFhx8HFzUU675ulS6BcMAowdJQAyWI3rpbT8Zmu4aj4uzjdHoUaIacp2qTh1YQpX75w8m0dYyN9DXz8SjP5GXNusjxEmcYBpr4dPXY2WFjNjuTlE5f7zf7ekKxMuzG3sYLpdfoIF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001251; c=relaxed/simple;
	bh=IdvGTt/N3RyEHNIIN0Ci2nl3TBvehqz56QEruhnSMNc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=UkyZRK4u+eXCOwBOt5vRP0ePqJHAvvG7+v4ecWtICYQHsUGY2yrcbleGFW8MpgA9wC9JmTs1pK4acfMWaBN3I0Lq7svPTWcJq++0hsGsRacDh6RceKAM9wdxMhahyxntaazislQ9x7A4/yNTu3JArp3bFxFF9u76AnwA128N8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=le88ryaI; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="le88ryaI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783001246; bh=68umrRJwjcSl0SyHmvSITSEjDGeABNfJiVRzgwyCTsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=le88ryaITlbvOvp8ujEE3d1I6zilgHtpx/0cHQt74gp+V1c1Qv3WtucayYsbMfyGH
	 pwLiUTG7YzkvJczv1I71B1itLfY0VvL/HCv87mWNLJNSxk1Jq/6ZzRz8IfxTPBIKkK
	 xmEGE9DLg93OfHqSCqUfa0ZMa9TE2pNkCuzqXJTk=
Received: from localhost.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 1D09A800; Thu, 02 Jul 2026 22:07:16 +0800
X-QQ-mid: xmsmtpt1783001239tb38rpwa1
Message-ID: <tencent_3B2B6003D1DE4FB7A984665A062581766405@qq.com>
X-QQ-XMAILINFO: Nb+v+bm9wQoUq/DtgdEc2I6YSo1drC1SRiyFXoRlMe3SZ7e9S1Q7m64zPQrKNh
	 zfpmuPrQiI8OZMGlgvYnz2a5ECWNVj+ivr5ZYWZ+jZ18XHRpc9M8RiiOh+weZ/DEi9KX8FYa6HY7
	 BcJso5jkk4gr4Z4mp9bMZg10L4I42xhIOw0I+c8OvlJisgTeSLJbwzQT9FWCoxQhFcUKTBKT7dAj
	 3SRkxL9a256tr0130WsEJGmlpAv/wzIBMjQunth+rDCrOn5173vbRrxvMVexx4jcgy+4GgGbFOCR
	 K0Y9lHud2/G5noA5lL/HnSyOmHOtdcZeDE1q2hzlUHMtzCL5/DcZt5VcE+AGnmoECT9PAu9C2YBq
	 Qeqhp1UYVSkjwRWjGtg8w9NyxhMYDxFhnL9Y1LPifGwgnkjs37QGGNnO2tiYxKa2+/wodq8QDipp
	 S+JkojC4NngqzDsUwclJsYh7zS4MD2R5UDizIG4DNmblSNDXb40QYrlxzbWBgTXikikUdjqgPMJ2
	 F5BtoLOH6FYx+7jEDc0pFgN4QEsRyo7j6uv9A1JtsQyf5lzk4QuoDgPXDWvm0SFRMdl3o/x8vK5O
	 Fie1jpl7h87MRn/27Dh4rvRYbrGEwYNC1JzwlI9uGhpGqERjnaUp/NbxIFjSa5eBDIQ73u0UPMe+
	 iVi8XKRKhla30f3zmTLw1ChdOIHZkxvx+JuKZjbb7HPhEsO1g/j0TR1EndxqYLmU8m1fqURR2jb3
	 Eaf6ZHl2eH+D5IhyDwhjQCSXBUS1/CTyCtTCkyC6aj+3oLy17c/eTR1vnD99uy1XvKJoEO8DWKuP
	 NSmBSSAYxW4J/4JVtrHFE1kD1bTLAm6x0LotZI3CN7XDyJQ8HEt1au/Hr+oF7hEglYQoj1hfOT9v
	 9vwNNYNtYPK+xwBWBPdR8b0QUU39ob3paKWqeNgu2d705K0nDt/akqWTzhjezGpOFYpoxQOziEl4
	 8sthCSyceMKdfjmRMgsthVcpTpQlPbJWemDhzvQbd2tH17ZxJJ4HRaDyDyiUgSaTVGb7jxk3v7rL
	 tKHiEsn823HEO4/RD0TKXN3WaRggs=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: 1579567540@qq.com
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can <linux-can@vger.kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	kernel <kernel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Eric Biggers <ebiggers@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Yixun Lan <dlan@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-rockchip <linux-rockchip@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Cunhao Lu <1579567540@qq.com>
Subject: [PATCH v2 1/4] dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
Date: Thu,  2 Jul 2026 22:06:51 +0800
X-OQ-MSGID: <20260702140654.2961561-2-1579567540@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702140654.2961561-1-1579567540@qq.com>
References: <20260702140654.2961561-1-1579567540@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cunhao Lu <1579567540@qq.com>

RK3588 integrates a Rockchip CAN-FD controller variant that is not
fully compatible with RK3568v2. The RX FIFO count register field is
encoded in bits 7:5 on RK3588, while RK3568v2 uses bits 6:4.

Add a dedicated rockchip,rk3588-canfd compatible to describe this
variant. Do not use rockchip,rk3568v2-canfd as a fallback, because that
would describe a register layout that does not match the hardware.

Changes in v2:
- Use enum for the single-compatible entries, as suggested by Krzysztof.
- Reword the commit message to explain the hardware difference instead
  of referring to Linux driver match data.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 .../devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
index a077c0330013..81e2b6dfeb02 100644
--- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
@@ -16,7 +16,9 @@ allOf:
 properties:
   compatible:
     oneOf:
-      - const: rockchip,rk3568v2-canfd
+      - enum:
+          - rockchip,rk3568v2-canfd
+          - rockchip,rk3588-canfd
       - items:
           - const: rockchip,rk3568v3-canfd
           - const: rockchip,rk3568v2-canfd
-- 
2.34.1

