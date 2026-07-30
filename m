Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9B40963F;
	Thu, 30 Jul 2026 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422104; cv=none; b=mF/ZgeQAosXS3gLvIMIHXq1gQGZZqv/bWU39EUdJsjsid6C602OcEMUZiUM9aolwOB6C5NX9fGHpman57OZnqMMqDnVh6TQrGERKK3tSaalGtWjx3tG9TZz5UesFCnSE2qPJOJgAvKTtEc64iB53YxR4k3OxmqG5B3FSs/Fvj14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422104; c=relaxed/simple;
	bh=lfECkFltrIC5I4L6RX24lgVOn83WLPrQpz9XJFeWnYQ=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=fnBOgs+4NYcPY8QnvcohgZeh5ZIwdsxr/HCRycNYaWCfqrPyp+Lr1xYiQupfE0bo/OUEOPw7+eRvLSgcPNFU8vDHNx8bjj11WEswXibWFaMCsDWmJjgQZ7sNKApS47qO5MLkSfV293/3bzfVR/sGR/XTqe59G9pAoAQ8jMFEmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Wphgl1a6; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Wphgl1a6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785422097; bh=YbT/VBy8/jyTVyfcMlrMZ1rcuYWd/SqJbq1DiU5dIYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Wphgl1a6iPqW8jaXPjQINjI8VPIoDXywirAvj4L2MXD1PyLNA3zX/ki1pjeA1mqRR
	 yalruNkiO47hKXjAJOnFzr1xO/2eBVwhn+iQ+UWuINYH0L4wun6rQgMQQBJLoCGItx
	 lmwPpxlNms97ZSW9CCaUof5ojpihLVyL5ctK9xuI=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 8B38245A; Thu, 30 Jul 2026 22:34:51 +0800
X-QQ-mid: xmsmtpt1785422093tylrip7vf
Message-ID: <tencent_AE1A1199FC8C9ADC680C6458134A46B40309@qq.com>
X-QQ-XMAILINFO: MC6m07AaSFhrvwmDTwhytxEJhh9nxDyjG7kdMzLWFRkZI5yPgzPYsP8xckGLFj
	 5pHd/omhx2VtQrCp3o970+DnHWr5CHS/jvErnPaGxxOCa8gDxp99d1KX/FDOEZR2Gx7SM0fDq6Q+
	 vR1iBzwq1ahtr1oCDKJ/yXipYb5fbmDeVeM8ns56KN/kpHRfhbl8BEJUNMVuuVXcy8uIxiXQQtR/
	 QNTruEuS8jlyhiNq0NBo5LndRYOyheuHvgFAv45Dnr1m6YHoFHP0IqeE0n5tnCWO/8TJRKlr6UuA
	 TZXsu6zseoiWEa3YXvLlSJ0VtKTUpaCH/S2NP8EWDVYHJkgQqiqvVUAiZocY4XbyYNLFLrb7335p
	 9uniLOQMzoIpe1iDUfyh7n1oJLU3yWFUld1dHJ0hrtuyitiO7j9f9OJBQSa/+qaMbSH4djPr+dBL
	 PyKplCDYqtdjwORfeYWlqs2PAll16+JFMgN8IkvOGpySAkMjVEaYiIjqdYcS9wNj9KI0NidgUDZm
	 jrjoviR0elcfd+bXskzUjDzBD7qygKXcZOBEW3QaZalC42Uf2D0vLttZYVCG7m79IcsLKTEvui3m
	 3VpZ/2cfZnT+3sT01E9kUYXah7DQtg+UXqFNPIy+G962tf2Xm3cwMGjZ9wjhrOCNdBMohOx02Eow
	 DyMn8ISuYkIerKfvdfH2KG4ynPn9zOmNhd2bMEAsShBglfaz608FsxBASjRJP9GLxvv4lLNpBA6I
	 Z1ZG7SXRr8i7m6XLAjQ3KnaSWOhGiTKlQhKFXdhha4aBLrUZhptE2S5+5mP2GDWnm6dPkepF/2Rw
	 RIFngKgaeQOa/nxnvLZrisMcWZwoTSLwEbYjVdSmoR66P/LZkPd1tJFkkpOKksm9IuX/C+5Y0dzV
	 vzFaWSwRAfz6/BNkpi/gIDzNt7IO6Wvzi5emNuhd/0jkSgQouxs0i1K29oxZpMc4dFII+i4RBb/r
	 XHI1YP8esNffUh8q/BTBKM2gTOA8f3EYLKFDLJvw4xwfw+/2eVbeuSDQjv6ACrDGjw9VN03adRhj
	 YSsw1a11IWEf/qY8vg5bHDUGArLciMOG4WmvkLCyaZ2YuARt1E2R0q6fGY1nNvtlaKzmfrC0tNBa
	 T9GJpJ/5gRgpHJIOTDDVz/qjUpAz30h0xDohhqYlo67idKLxayL+obCXLht/6o1poKTCgpvGLgG3
	 Y0qMI=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Cunhao Lu <1579567540@qq.com>
Date: Thu, 30 Jul 2026 22:34:02 +0800
Subject: [PATCH v6 1/4] dt-bindings: can: rockchip: add rk3588 CAN-FD
 compatible
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260730-master-v6-1-dfb63e234775@qq.com>
References: <20260730-master-v6-0-dfb63e234775@qq.com>
In-Reply-To: <20260730-master-v6-0-dfb63e234775@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Cunhao Lu <1579567540@qq.com>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

RK3588 integrates a Rockchip CAN-FD controller variant that is not
fully compatible with RK3568v2. The RX FIFO count register field is
encoded in bits 7:5 on RK3588, while RK3568v2 uses bits 6:4.

Add a dedicated rockchip,rk3588-canfd compatible to describe this
variant. Do not use rockchip,rk3568v2-canfd as a fallback, because that
would describe a register layout that does not match the hardware.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
v3 -> v4:
- Collect Krzysztof's Acked-by tag.
v2 -> v3:
- Move the Changelog below ---
- Collect Heiko's Reviewed-by tag
v1 -> v2:
- Use enum for the single-compatible entries, as suggested by Krzysztof.
- Reword the commit message to explain the hardware difference instead
  of referring to Linux driver match data.
---
 .../devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml          | 4 +++-
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

