Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D73346A1D;
	Sat, 25 Jul 2026 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784963276; cv=none; b=ERRIG3HTXl5S2m1dhPTzJXROrjcy0148kcXa8u8gW2ksvz8BeoDoOk+2HKg3tos8RC9pHYsX0MrHuJNZfQygQ7aeZzayHs7sz40hlRol3kDnyzdqCEhcocjFfDwL+yuzqYgauDcQmMdVrEwD09U9PzYkPHFnWcXa6FsxXhb06NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784963276; c=relaxed/simple;
	bh=wktxRFmuvhJMB8KqsehkaKuvQGmUjAdIBCq/NAHUgWo=;
	h=Message-ID:From:Subject:Date:MIME-Version:Content-Type:To:Cc; b=s62gI1cx7pk//ywthc4mwWZ92P5HJfHAw0zJ8WeE0T3jvDNJn0Kg5/RL25cqYKU1QEqr5eDfUYC4Znn55ex7mQheTPVzZDM+sC+2t0S7o3FJUoTjf8YZHNrzN0eAcxe99p8IxUo3kPlUtOqWB+MnT7AZ8tkPiJymGwPUMEKCHZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yMHiqz1U; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yMHiqz1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1784963263; bh=UJHt9ywOQl2bnmRRbANrsvI4ILo3SAjG24mslnqrFmA=;
	h=From:Subject:Date:To:Cc;
	b=yMHiqz1Uv4UoWmEzjEd2rBEPcaBIduHvGRnRhxnnFzhEN/Cz0mb6B7JlH4HJZudv+
	 Sx9fC7ibhMumAnCtWfFltaQkENaL1ZpviIVKOsgSaxZZx2+9YTwDfCnFQiYH/2toHK
	 f1gLtqcHJ50mSwYYMk+7S9lxenNt95fGuVyGGQr0=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 19989659; Sat, 25 Jul 2026 15:06:25 +0800
X-QQ-mid: xmsmtpt1784963185t2gcjelk0
Message-ID: <tencent_AE0DC47B3FBB26371A1699AC849811AD8007@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtP/BCvwWKJmXXDPshPqly9CxPJGOru6tiLb4qQEORL0PNSzZryG
	 qqhcx6t5hhamUBNSmU8fdLuD9m8ONw9BBOG055z1eyuMgDbH2cOrvD53JA9r6qDICpQJArexOt+W
	 sLRP6tFxH9DGjxsi37s8DeYefMUtmvsyy3heZPHMIzJ9BzK9vU/f/oQUu8rEEzMapyrqhk9aVoG/
	 LzoAFrg1EmB8vjWjR03oZAkGfH7YednBE7kVabq6XMzAIKTPUF8GJ4kl89SD34ZGIWTrj6wl6/IG
	 muskOpMoV08vmFnO9OH4URYcNRmO3CzRUiNMpD0ss5LIrPuGBW9z7fpwjzgXFZ/amJGuWzXFrECG
	 EE/aGqtAVamb50YFMgIV2HG1pALdSRj20zBf+ShqLOV88eMOkyTpllaCReQrtMd87EC4I/FcuXfs
	 2odrjwsIygMG5xtTy+xkK3klS6E0pA/9J6ICLdOPsgXJT4V5UvoAAxRX29DO9vUkuhffvNAjE6qp
	 i9wfBsP0AOUqdEjTdJRI8kY+AnJj8HK7N2BRcgAwtewyHHmmHpmqoqhRjNIGw33AMaH9ytPkp3TM
	 9lntPntexlmN4AdCtpwYoke2x+rc78xE/hUFBTGT0Mu1GRlwPGOW6gQQYYqXnE5OlBT5OWXk7FoT
	 Mes1tCXcHKBkRq4pjeCtETOx8Tx2vVCxkIcIt8r21IZNOk0vxkjgVLTeAmmPVNNBWhD+a1eNc8lK
	 jh8vjjHslkZCgQZPj8A4b5H9URhMksJbkd5LEdKTvOqz9QCdvZhv1bpXeoSn7aX5B69DRFN/5aVQ
	 CvshKeU/U3U01z3MCoBQI79cRzjEnjW0jO4bMoMhYsOeVjv+g0+RQ1d3FzKYJJgcEi+cvjNJumBS
	 A5CoZI+d3zx/1zXdUtbHDh280bxEnE8oGoo3gpNz7sg5j6wSunbYDx0dzhuLmxv2KeFhhoaC1Lpk
	 OwXLlwNqR+5+opyJ70jpveLRBzyCS1g29wttJSU65kl1wurA90t+0snqDchS0fwDbDus5Wlts7sw
	 GyBezakNF2K17V1b0eRtD00VTCASzbnCG39GLjJ4JXinxXdrFifxgRjV5mFGGhQYYtkoU+iwo0N6
	 OSXy5+2Cg8w8mqDWpFwBCDhUgKrNhMroe9+Q1+8jM+V3Xp2P1rgdoryu8MjHNL/sk7gCZh
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Cunhao Lu <1579567540@qq.com>
Subject: [PATCH v5 0/4] can: rockchip: add RK3588 CAN support
Date: Sat, 25 Jul 2026 15:03:30 +0800
X-OQ-MSGID: <20260725-master-v5-0-75da459d2b93@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMJfZGoC/22NyQrCMBRFf6VkbSRkanXlf4iLDC82QqekBqX03
 00qdeXywD3nLihC8BDRuVpQgOSjH/oM4lAh06r+DtjbzIgSKklNKO5UnCHgxgiqoTlRxRzK4zG
 A868tdL19OT71A8xc7LJofZyH8N6eEiu7Pcr2aGKYYGmFtCCdpY5dpulohg6VYuL/HZ4dXltOt
 HbCWfVz1nX9ALUKrNXfAAAA
X-Change-ID: 20260702-master-8c52be892a3f
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Cunhao Lu <1579567540@qq.com>, 
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
Heiko's testing, v2 also enables the erratum 6 workaround for extended
frames being transmitted as standard frames.

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
v4 -> v5:
- collect Quentin's Reviewed-by tag for the binding patch
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

---
Cunhao Lu (3):
      dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
      can: rockchip: add RK3588 CAN support
      arm64: dts: rockchip: add CAN-FD nodes for RK3588

Heiko Stuebner (1):
      arm64: dts: rockchip: Enable CAN controller on RK3588-Tiger-Haikou

 .../bindings/net/can/rockchip,rk3568v2-canfd.yaml  |  4 ++-
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      | 39 ++++++++++++++++++++++
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts      |  6 ++++
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 17 ++++++++++
 drivers/net/can/rockchip/rockchip_canfd-rx.c       |  5 ++-
 drivers/net/can/rockchip/rockchip_canfd.h          | 14 +++++++-
 6 files changed, 82 insertions(+), 3 deletions(-)
---
base-commit: 0ce37745d4bfbc493f718169c3974898ffec8ee7
change-id: 20260702-master-8c52be892a3f

Best regards,
--  
Cunhao Lu <1579567540@qq.com>

