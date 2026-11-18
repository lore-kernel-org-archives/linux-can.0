Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794994337;
	b=C8WVxNxpXcPHTcJOqHt2zBA9J5elCnS/14bE7E9hzQy5ekHaH6eKsR+RKHC+dZA/4vnb
	 /Apy6FatRtSMsPaW/l7KWGexKmKQ5m6pJqo4z61ODGyCuBMbhqoCLfeqyKHKe6hn/Dgwb
	 qHDjKucpdhf3AP2fm6zYwagrXp/eK93lTtIe9N/92g2MhX1YKKftARoYx8IpJOFavPXop
	 qpW7j951LnPcNrbURyljw1mIVoKu5Ky869UH9T2kbZgyNPb4Gw9DdVOXshg3XhOInMyMI
	 EEXV5IKO7zp8HprHSllH7eXdWVedXhuzU2+DEshZLs5RNGhV/Mht+rjD9rTKKHaa6wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994337;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dIEWDIE8C8HsxQkssvOS3FDL8HfIPsnvEYAXzhRE+uU=;
	b=wSWJOljBbfmmBwU3t2nusHP9tBCtSfkIUfVRd9dWeyIXQncqNOEteYrw402LyTHYCoji
	 WafYinAnx9OJ96s54jHE5Lju+qcoHvE434fxSh1Au1Un9I9tZ3VtLBPX0uBYHyQo6Ckj3
	 8ITKyRwTiCAUs8yF7hicjV/qOUe4VmXMQZELqVb0dEUTtVO75gLt7iLrgCk0jeAHtUARG
	 8fKUVE/bn0TI8lNL+sfh3L3SO/ifc0cerC+1oBl2XUMrFI84hoiG4K+U4UJDEGFKq/5Y7
	 4j4GiSga4c0nkMVgkiveI+5w0JWZm1M2uMXjBhR3fcJdlRAPyH1XAHbSxW3wG2evGKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=erEeLVt5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284CF606A320;
	Wed, 18 Nov 2026 09:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 284CF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=erEeLVt5
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 37ACA205A51;
	Wed, 18 Nov 2026 10:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dIEWDIE8C8HsxQkssvOS3FDL8HfIPsnvEYAXzhRE+uU=;
	b=erEeLVt5LF7uaU4se6lXvYd/PttVy6hNVF6SskO4oyNkM7PHXyPcrygKVCT4OCFrW3j73f
	GX8hn2BwmK22Ar4MGK++BMw0kuPC7FuK2bHz++NSDXAsA9OjFeRo61esz7SO4EOgOISyOI
	OhXS/mrbBiIxnsrtcsKcz6xxLVTKN7cKjYMC08OdXBu6m+pb0ONH2b+qxdX/8dih6MOm0g
	bKXmUblOho9TwydOx20DfDWreYNkAHO5tQgVH5jm0cH54NGrzpXb/7K5NcFo7LYgpgdplS
	8qq5SiSN26ms6ekEo8rMl0+7Ok0oWQD6WXcBMOLL17u91UhZIYeYTO9EJETgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dIEWDIE8C8HsxQkssvOS3FDL8HfIPsnvEYAXzhRE+uU=;
	b=FA6WysTnnF2FaB8+nC/s1EOjymcUd2LdEPMUe/dxmrHa6ZBe96CH6YH2aPxrBwdjfDxaLg
	JPkmPJiNobtpSN8KZOsC36DRVus3HC4egO7926XHIGlYAx4kBYdz7GqzxqwQoF+ZqhwayJ
	wXLkovHwekgwwG1v0CgBQZWPxOM2UVrCOvOQpRdH+urfnibGjMTOKjF/q55f7TjrtUJDkN
	KlfTJdCwRs1DVWIZIp72jWgTkq36wSHzI35kilc9wy1BvP5KsYpBJQ1N7CYcblfeknsw+v
	zF2vwb9b4kOx1pj2XwZi+ta9psR/HnwHIwhJ6P13TecXciSYGlQ7XDec8wft0Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794994334; a=rsa-sha256;
	cv=none;
	b=KU1k3D2tOfgBY13JqSrNP8l6l+Nc1V7lBzvGOMIMc5yZmaOnzY5TkRCGK+RYAgQtX75bEW
	50wJvgZSvcgRGJ3PKyAWiJDRH13F5179b6i+6cH6B+STBhe73oEc0Q5/hHiONrCr1iG6cn
	p6EDAx6MB/9/cI5CQZQexPiLPqJSjZeDw42MuD2AE+cxSYAD+f29BAOuFkjHBg/YcV8pAC
	gO5CWQaa0OlwIxcP6yQeTa55XiPmH33e0FcSDTHQFPiFnWYoTwb4RF2gruIrYEKmF8l6w2
	RofpBZJn/uvtO2rly24//yq69TdzaJaTLQ0OvrijsWymc+LhbaTBrOCVRzmZ5g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTc1V-000KHy-1k;
	Wed, 18 Nov 2026 10:32:14 +0100
Received: from blackshift.org (unknown [185.109.152.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 454035EDC84;
	Wed, 18 Nov 2026 09:30:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/12] pull-request: can-next 2026-11-18
Date: Wed, 18 Nov 2026 10:11:33 +0100
Message-ID: <20261118092955.1283165-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit

Hello netdev-team,

this is a pull request of 12 patches for net-next/main.

Stéphane Grosjean's patch adds him as a maintainer for the PEAK-System
CAN drivers.

A patch by Sang-Heon Jeon removes a redundant NULL check before
netdev_hold() in the CAN RAW protocol.

Magnus Aagaard Sørensen contributes a patch to remove the unused
function safe_candev_priv().

Triet Hoang converts several CAN drivers to DEFINE_SIMPLE_DEV_PM_OPS().

5 patches by Chaosheng Qu clean up the error handling for
platform_get_irq() in several CAN drivers.

Oliver Hartkopp's patch removes the obsolete Softing CANcard driver.

A patch by Hemanth Selam removes a repeated word in a comment in the
ucan driver.

The last patch is by Maximilian Zimmermann and sets CAN FD related
flags on received frames in the xilinx_can driver.

regards,
Marc

---

The following changes since commit d6816d9a93b66a12bf01e10037e377f3333ad6cc:

  Merge branch 'net-dsa-add-dsa-support-for-the-lan9645x-switch-chip-family' (2026-11-17 18:09:58 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-7.5-20261118

for you to fetch changes up to 400814a52bdb0c8e5f7c72330962830e682291ba:

  can: xilinx_can: set CAN FD flags on received frames (2026-11-18 10:07:51 +0100)

----------------------------------------------------------------
linux-can-next-for-7.5-20261118

----------------------------------------------------------------
Chaosheng Qu (5):
      can: sun4i_can: don't discard the IRQ lookup error in probe
      can: at91_can: don't discard the IRQ lookup error in probe
      can: janz-ican3: don't discard the IRQ lookup error in probe
      can: ifi_canfd: don't discard the IRQ lookup error in probe
      can: cc770: don't discard the IRQ lookup error in probe

Hemanth Selam (1):
      can: ucan: fix repeated word 'is' in comment

Magnus Aagaard Sørensen (1):
      can: dev: remove unused safe_candev_priv()

Marc Kleine-Budde (1):
      Merge patch series "can: don't discard the platform_get_irq() error in probe"

Maximilian Zimmermann (1):
      can: xilinx_can: set CAN FD flags on received frames

Oliver Hartkopp (1):
      can: remove Softing CANcard driver

Sang-Heon Jeon (1):
      can: raw: remove redundant NULL check before netdev_hold()

Stéphane Grosjean (1):
      MAINTAINERS: add entry for PEAK-System CAN drivers

Triet Hoang (1):
      can: convert to DEFINE_SIMPLE_DEV_PM_OPS()

 MAINTAINERS                                  |  12 +
 drivers/net/can/Kconfig                      |   1 -
 drivers/net/can/Makefile                     |   1 -
 drivers/net/can/at91_can.c                   |   9 +-
 drivers/net/can/bxcan.c                      |   8 +-
 drivers/net/can/cc770/cc770_platform.c       |   7 +-
 drivers/net/can/ctucanfd/ctucanfd.h          |   4 +-
 drivers/net/can/ctucanfd/ctucanfd_pci.c      |   4 +-
 drivers/net/can/ctucanfd/ctucanfd_platform.c |   4 +-
 drivers/net/can/dev/dev.c                    |  12 -
 drivers/net/can/ifi_canfd/ifi_canfd.c        |   2 +-
 drivers/net/can/janz-ican3.c                 |   2 +-
 drivers/net/can/m_can/m_can_pci.c            |   8 +-
 drivers/net/can/softing/Kconfig              |  31 -
 drivers/net/can/softing/Makefile             |   5 -
 drivers/net/can/softing/softing.h            | 168 ------
 drivers/net/can/softing/softing_cs.c         | 335 -----------
 drivers/net/can/softing/softing_fw.c         | 700 ----------------------
 drivers/net/can/softing/softing_main.c       | 864 ---------------------------
 drivers/net/can/softing/softing_platform.h   |  41 --
 drivers/net/can/spi/hi311x.c                 |   8 +-
 drivers/net/can/spi/mcp251x.c                |   8 +-
 drivers/net/can/sun4i_can.c                  |   2 +-
 drivers/net/can/usb/ucan.c                   |   2 +-
 drivers/net/can/xilinx_can.c                 |   6 +
 include/linux/can/dev.h                      |   3 -
 net/can/raw.c                                |   3 +-
 27 files changed, 57 insertions(+), 2193 deletions(-)
 delete mode 100644 drivers/net/can/softing/Kconfig
 delete mode 100644 drivers/net/can/softing/Makefile
 delete mode 100644 drivers/net/can/softing/softing.h
 delete mode 100644 drivers/net/can/softing/softing_cs.c
 delete mode 100644 drivers/net/can/softing/softing_fw.c
 delete mode 100644 drivers/net/can/softing/softing_main.c
 delete mode 100644 drivers/net/can/softing/softing_platform.h
