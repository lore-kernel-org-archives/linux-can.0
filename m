Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A64A1399;
	Tue,  4 Aug 2026 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873372; cv=none; b=hVszZaaE5+Bh3EFOSeZIYUdZv//ep47M7h1hjElRHpAtg/l/BCO7pN8oW9LMFg+tcxi+E8TImQ7yUvS91RaP3EJxMIKJbnerwj2AoxGRc5KIuCsFwZAFyfRtzwDezSWFQrx6QFNgT4BGJb5BFM83qbcqgEfiPwbG990QR7oLvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873372; c=relaxed/simple;
	bh=yW4YesIP09lNGs+jGMyZNGXhGHw1mg4Y18iqWAsMWFY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AeCIqrZu3jp/KtMcsp7TjC8dTfvR3OIz6t5ointzicvkz2XDTtUkuj+HlvDVPGG79SVKOeLLSb9vcG+IBnWeJuEbnFXsDstJXL4LIQOtMJUqiVhvHsNkVqD5W+MbA2Kk9Hqh81Nke2tq9DbLUKFqtCzAWbPjdwrWGq0CAJQHT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5ZLfsvm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5ZLfsvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3611F000E9;
	Tue,  4 Aug 2026 19:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785873371;
	bh=H29vGUNlkBcH3n1W99XytXAVVyn+ysCOGT1wYfzMvao=;
	h=From:Subject:Date:To:Cc;
	b=a5ZLfsvm4YK9CrHGmQ+7QuCeWdd2MEc7ZB7/E5cR/vvZHmHoLh7GEVyizJqYTD1Tl
	 HJxCATzulPJFH6Swt4N8h0sWfJlxqb4N6zyBeoE48fmTQb2vl49W8ljjz1zsDSnqJY
	 Ob5AhIk2D4NmnHwS33gSxiTse8Zqs1B+hsRDBt5YO3qqILGmrL+cknsmdsLf/WIDQY
	 zLd/n9E+Ujzddk+NxdEppn9eRw3YsAWGMmmRu1fr2WiYgXtvOK8ppc+d3GxgE1Oyym
	 UmvDfUmyYKjzfRPHULuLvI0zyK/2IOUa2EJSQFt/+nWTSTjWd55XleZzAKwtTL9oTM
	 I92ZHf1Gcdbgg==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH 0/4] can: automate IFF_ECHO flag for generic echo skbs
Date: Tue, 04 Aug 2026 21:55:23 +0200
Message-Id: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3M0QpAQBBA0V/RPNtaEvIr0jaZGaaw2kVK/t3m8
 Tzc+0DkoByhyx4IfGlUvyUUeQbjjNvERikZSlvWtrWVwfPwKx7sVMTxOHsnC06mJqJGKmJpEFK
 8Bxa9/3E/vO8HutAm6GgAAAA=
X-Change-ID: 20260804-automate_iff_echo_flag-6ddd7f4def7a
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3869; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=yW4YesIP09lNGs+jGMyZNGXhGHw1mg4Y18iqWAsMWFY=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFlFzleb0s5uYZdPvvt1y5/E5LSM5Ocqv/OjP80/c2bje
 pGTO+3edExkYRDjYrAUU2RZVs7JrdBR6B126K8lzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGDFwcQrAVPspM/yzr5M5YFC0LV1LuGddVPafZbVHI64nNZuG30xq/mcUtcuWkeG05yXJN91
 8UlFW7Za/vy0t9U8692HTtwklE0Tz8//JR/ECAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Most CAN drivers allocate echo skb slots through alloc_candev() or
alloc_candev_mqs(), but still have to manually set IFF_ECHO to tell
PF_CAN that the driver handles local echo itself. This creates
boilerplate and makes it easy for drivers to forget one half of the
setup.

A recent example is commit c77bfbdd6aac ("can: dummy_can:
dummy_can_init(): fix packet statistics"), where dummy_can was already
using the generic echo skb helpers but needed an explicit IFF_ECHO
assignment to make tx_bytes accounting work.

Patch #1 cleans up slcan, which does not use the generic echo skb
helpers and therefore should not allocate echo slots. Patch #2 fixes a
small inaccuracy in the can.rst documentation in regard to the IFF_ECHO
flag. Patch #3 sets IFF_ECHO automatically when echo skb slots are
requested. And Patch #4, the final one, removes the now redundant
IFF_ECHO assignments from drivers which are covered by alloc_candev()
with a non-zero echo_skb_max.

The remaining explicit IFF_ECHO assignments are special cases with
custom or virtual echo handling.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Vincent Mailhol (4):
      can: slcan: do not allocate unused echo skb
      can: fix IFF_ECHO example in documentation
      can: dev: set IFF_ECHO when allocating echo skbs
      can: treewide: remove redundant IFF_ECHO assignments

 Documentation/networking/can.rst                   | 7 +++++--
 drivers/net/can/at91_can.c                         | 1 -
 drivers/net/can/bxcan.c                            | 1 -
 drivers/net/can/c_can/c_can_main.c                 | 1 -
 drivers/net/can/cc770/cc770.c                      | 2 --
 drivers/net/can/ctucanfd/ctucanfd_base.c           | 1 -
 drivers/net/can/dev/dev.c                          | 1 +
 drivers/net/can/dummy_can.c                        | 1 -
 drivers/net/can/esd/esd_402_pci-core.c             | 1 -
 drivers/net/can/flexcan/flexcan-core.c             | 1 -
 drivers/net/can/ifi_canfd/ifi_canfd.c              | 1 -
 drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c | 1 -
 drivers/net/can/m_can/m_can.c                      | 1 -
 drivers/net/can/mscan/mscan.c                      | 2 --
 drivers/net/can/peak_canfd/peak_canfd.c            | 1 -
 drivers/net/can/rcar/rcar_can.c                    | 1 -
 drivers/net/can/rcar/rcar_canfd.c                  | 1 -
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 1 -
 drivers/net/can/sja1000/sja1000.c                  | 1 -
 drivers/net/can/slcan/slcan-core.c                 | 2 +-
 drivers/net/can/softing/softing_main.c             | 1 -
 drivers/net/can/spi/hi311x.c                       | 1 -
 drivers/net/can/spi/mcp251x.c                      | 1 -
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     | 1 -
 drivers/net/can/sun4i_can.c                        | 1 -
 drivers/net/can/ti_hecc.c                          | 1 -
 drivers/net/can/usb/ems_usb.c                      | 2 --
 drivers/net/can/usb/esd_usb.c                      | 2 --
 drivers/net/can/usb/etas_es58x/es58x_core.c        | 1 -
 drivers/net/can/usb/f81604.c                       | 1 -
 drivers/net/can/usb/gs_usb.c                       | 1 -
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   | 2 --
 drivers/net/can/usb/mcba_usb.c                     | 2 --
 drivers/net/can/usb/nct6694_canfd.c                | 1 -
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       | 2 --
 drivers/net/can/usb/usb_8dev.c                     | 2 --
 drivers/net/can/virtio_can.c                       | 1 -
 drivers/net/can/xilinx_can.c                       | 2 --
 38 files changed, 7 insertions(+), 47 deletions(-)
---
base-commit: 828c4a5a9518117f9f7bdc445a7eeca85fc91bf8
change-id: 20260804-automate_iff_echo_flag-6ddd7f4def7a

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>

