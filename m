Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994A429802;
	Thu, 30 Jul 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422102; cv=none; b=qTGmDCvur0GK1c1lt+NSnbkVGEQcRFimK0GeExRi+c00gk0yReLJ46OW9S+YHDs9R09kbjkh3KP2msjV+085Pamn6hDdeRdUMB0qLyejjsoT2LgTqtfQTN65E/gmjmQfXDjpWN4xp2eJPOeA/j3SbsR+MBveaZ6LWHSODamKVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422102; c=relaxed/simple;
	bh=cc6pgEg0QvUNMzrqGggBt02+UTZclIkmEsDyTO/5sl4=;
	h=Message-ID:From:Subject:Date:MIME-Version:Content-Type:To:Cc; b=NK117m9wn3sL4wsxUN2FM0EypPK4LojaLzx3i8FhXEBxCJ4FmjecNwJ/B2zgMGzNAEFMtVoW8n8q+Y05fYlq/XyPBgV+j+tJYxakC0OwmQZKKUxehMCEPjpeu3kcg0rpuIonP6LlaKeP5vvtUum4RnqJ4q1LClYEliaLZCr5veA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HXJJmJ8G; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HXJJmJ8G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785422095; bh=wCfvL8EiUbPUR9soYjWwjuZEDl9DDwTqiLOrLKAPRp4=;
	h=From:Subject:Date:To:Cc;
	b=HXJJmJ8Gslxg6Zer0c/vO5daApBITwXcExtAQkUPEwA+rlBbycM4EkmlE4pMHcy7w
	 J2++2631iEnD4NudaV61vXk6TO+cBxtkRHp4pC317y3xMXDSKojp1hl2ZG4Pp8bAjm
	 YP0BtL4D43s5YNLjcwi0aaaj33uKSP6XY56qvLQQ=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 8B38245A; Thu, 30 Jul 2026 22:34:51 +0800
X-QQ-mid: xmsmtpt1785422091tq8yny41d
Message-ID: <tencent_7BAA0052C402BFFD26291A64198084E39107@qq.com>
X-QQ-XMAILINFO: NQQUvflVuqBOL3+Hgkhuy1UC34W10feVP2QXMNiogXwMs6YFQvY98RKf7wCo3O
	 o1ZTZ2yRvTfcdBSG2GUn0WfYlmGgsqT/MBgLes3yJ3LiXh7Km9ec4IRrYFy5zEWBwEqEtXcGfvZO
	 BUmfXQPSRBdIuKMKUMq4Npx8tXLIDzPoBduye2WFoLPyNr5sGlcyDJbFttdIGFFAi/Bo8KZFWz+M
	 rAFgl1dL5sy7L5IdcwmeWn9PXCLGFymHXB08iv2AJMNHfpew2l2DHR8ziD26ylfX7DK/uoCo24c0
	 uMnTtknte0dhMNoECaRtC6Rkk40qfH8FjFZmNfp/PGYYwwiJy9FGDClHNgEHhbLE2lhZxjFjW+uM
	 TDkcdAyrSl9sjVcRJmY4EowCX2JTaUsiwyuh1RuuflFVAMiZOCKLyBVvrOO+hKErxZBGrwfGdGAM
	 tTMLG7SBrAiFVkToKpEdzxIiLVINCJQxjJ4SSHWmIaCX86TEOfX+bPfIz04YhsKJgZBm6iSiaGkF
	 qdOod1VHWwqz/Z19kJU8+fTPtxxA2Y8Y+y62mSRmq/LQiqF6YRiiamkJlKZmEeSFTTA+umMdqEj8
	 HBz1FP8uaT6mzWyCqNwYcO5Zx0Bbgl0BHnrsXGIjMBecGWeCKnsV5LFhcVt1joMpj/X5eDTrHdfb
	 B4UmSUYE2rtzHXmvkeU8+qKNOPymuX/WC/b6LDs76ep4A+/EaRktCkcT+VbPUuQ5sl+CUzbXYtq4
	 1J6iz8OIUFDNc3z8KCuz4HozY/PjtdOgRsJDtB87nTP4t2IiuHOnO0rKwTyWsaEApNTTFO3VTDJW
	 nt+jgqdY2Ntcpx0wvSIsL+UuTWthT9wTBhUzexdrjVQ/yXI2xwoTUgWNe9qOgspwYnr7YxCzAaEw
	 3KHUv+gdzhKAlQ1VQdgcbd66D56Z29lX65ZF1ROt7HoqnDGhBJGLk4dskoudhPDIbXSPZp/lQD5W
	 QsvOnFDt8aOLDUjgx1lyqUj4mwOYKaex2r0Z8lVdCoVPMiM3QJgh3yXwezvc/IxypllOlqW78Hpi
	 18tIN3ovUPs/4GmmQqbpEc6bGk/z7GUAzc4Ik4gXMbfiblkYFt9vX2CV9PtKJLHHPfX0hea0z3RM
	 qrNn/q1Nthwda9dNQPMuUgl+YXcSggP6W6M54EhtjRpaa7YLzq0jpMbsf2XZQOtwU5ThUiFRhot8
	 pgQPbHnAnitEOPkTmts8NsxKaUpw3i3vs1aH4=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Cunhao Lu <1579567540@qq.com>
Subject: [PATCH v6 0/4] can: rockchip: add RK3588 CAN support
Date: Thu, 30 Jul 2026 22:34:01 +0800
X-OQ-MSGID: <20260730-master-v6-0-dfb63e234775@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANlga2oC/22NywrCMBQFf6VkbSTk1daV/yEukubGRqi1SQ1K6
 b+bVOoDXA6cmTOhAN5BQLtiQh6iC66/JJCbAjWtupwAO5MYUUIlKQnFnQojeFw1gmqoaqqYRWl
 89WDdfQkdji8ON32GZsx2XrQujL1/LE+R5d0aZWs0MkywNEIakNZQy/bDsG36DuVi5P8dnhxeG
 k60tsIa9eOIL4eKtyOSUwqjuKgN1fXnZ57nJ/+PAocTAQAA
X-Change-ID: 20260702-master-8c52be892a3f
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Cunhao Lu <1579567540@qq.com>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2

Add support for the RK3588 CAN controller.

RK3588 integrates three CAN-FD controllers that are closely related to
the existing Rockchip CAN-FD IP already supported in the kernel. The
RK3588 variant is not fully compatible with RK3568v2 because the RX
FIFO count register field has a different layout.

This series therefore:

- extends the existing Rockchip CAN-FD binding with the
  rockchip,rk3588-canfd compatible
- adds a dedicated RK3588 match entry and devtype in the driver
- describes the three CAN controller nodes in rk3588-base.dtsi
- enables CAN on the RK3588 Tiger Haikou board

RK3588 encodes RX_FIFO_CNT in bits 7:5 instead of 6:4. This
difference was found by comparing Rockchip's vendor kernel 6.1 CAN
support for RK3568 and RK3588, and was also confirmed by runtime
testing.

RK3588 uses the existing erratum 5 empty-FIFO workaround. Based on
Heiko's testing, this series also enables the erratum 6 workaround for
extended frames being transmitted as standard frames.

CAN-FD is enabled for RK3588. The BRS bus-off issue seen in earlier
testing was caused by the transmit delay compensation setting. With
RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION programmed to 0 on RK3588,
CAN-FD with BRS works in local testing.

Tested on an embedfire,rk3588-lubancat-5io board with can0/can1
directly connected, no other device on the bus, 60 Ohm bus
termination, and a 300 MHz CAN clock. The test used 500 kbit/s
arbitration bitrate and 1, 3 and 5 Mbit/s data bitrates. The 5 Mbit/s
data phase test ran for 15 minutes with:

  ip link set can0 type can bitrate 500000 sample-point 0.8 dbitrate 5000000 dsample-point 0.8 fd on berr-reporting on
  ip link set can1 type can bitrate 500000 sample-point 0.8 dbitrate 5000000 dsample-point 0.8 fd on berr-reporting on
  cangen can0 -I 2 -Li -Di -p 10 -f -g 1 -c32 -b
  cansequence -rv can1 -f

The receiver reported continuous sequence wrap-around messages up to
sequence wrap around (37219). Both interfaces reported 9528377 packets
and 150667356 bytes, with 0 bus-errors, 0 error-warn, 0 error-pass and
0 bus-off events.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
v5 -> v6:
- Move the CAN0 assigned clock properties from the Haikou carrier board
  DTS to the Tiger SoM DTSI, as suggested by Quentin.
- Collect Quentin's Tested-by tag for the RK3588 CAN controller nodes.
- Link to v5: https://lore.kernel.org/lkml/tencent_AE0DC47B3FBB26371A1699AC849811AD8007@qq.com
v4 -> v5:
- collect Quentin's Reviewed-by tag for the RK3588 CAN controller nodes
- Link to v4: https://lore.kernel.org/lkml/tencent_42B49B0E68A8659A13EC46A402E41133FC09@qq.com
v3 -> v4:
- disable TDC on RK3588 by programming
  RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION to 0
- drop RKCANFD_QUIRK_CANFD_BROKEN for RK3588 and enable CAN-FD support
- document successful RK3588 CAN-FD/BRS testing at 500 kbit/s
  arbitration bitrate and 1, 3 and 5 Mbit/s data bitrates
- collect Krzysztof's Acked-by tag for the binding patch
- Link to v3: https://lore.kernel.org/lkml/tencent_AA108D2806AC225EF9553469D218C8C0260A@qq.com
v2 -> v3:
- Move the Changelog below ---
- Collect Heiko's Reviewed-by and the driver patch Tested-by tag
- Use Co-developed-by for Heiko's RK3588 contributions and add his
  Signed-off-by
- Link to v2: https://lore.kernel.org/lkml/tencent_87CB2824608F3C06B4229EF99D3609D00C0A@qq.com
v1 -> v2:
- use real author name
- fold the single-compatible entries into an enum, as suggested by Krzysztof
- enable the erratum 6 workaround for RK3588 based on Heiko's testing
- add Heiko's RK3588 Tiger Haikou CAN enablement patch
- keep RKCANFD_QUIRK_CANFD_BROKEN enabled for RK3588 so CAN-FD stays disabled
- document the RK3588 CAN-FD/BRS bus-off failure mode
- Link to v1: https://lore.kernel.org/lkml/tencent_1A4614039A100DFD8A9AE2692865FE126009@qq.com

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: kernel@pengutronix.de
To: Vincent Mailhol <mailhol@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

---
Cunhao Lu (3):
      dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
      can: rockchip: add RK3588 CAN support
      arm64: dts: rockchip: add CAN-FD nodes for RK3588

Heiko Stuebner (1):
      arm64: dts: rockchip: Enable CAN controller on RK3588-Tiger-Haikou

 .../bindings/net/can/rockchip,rk3568v2-canfd.yaml  |  4 ++-
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      | 39 ++++++++++++++++++++++
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts      |  4 +++
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi     |  5 +++
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 17 ++++++++++
 drivers/net/can/rockchip/rockchip_canfd-rx.c       |  5 ++-
 drivers/net/can/rockchip/rockchip_canfd.h          | 14 +++++++-
 7 files changed, 85 insertions(+), 3 deletions(-)
---
base-commit: 0ce37745d4bfbc493f718169c3974898ffec8ee7
change-id: 20260702-master-8c52be892a3f

Best regards,
--  
Cunhao Lu <1579567540@qq.com>

