Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE53D79E8;
	Tue, 30 Jun 2026 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837850; cv=none; b=mn1jWenwQW5suDWTDRmC8WpdLv6cDMCQk1XXay2cJizNhRWfL0/YlOBZbqxzk/nRqtwrvEo5wDgcvzVDPRHnsCZqOajl+vyjfM7uwvRKyJpi3+wYLz2GQk0Q7AqRomt4Aic3u/0R6EZv4n5MXkRty2iir6DwN0ZYk/05lkyb5s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837850; c=relaxed/simple;
	bh=2RS22bCvU29SJTPJBZRqkhGt6eJpyXkgbTgJ00CVcWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBZMJhrIu8j/+mHlBpGSEbDhJLjCwnvlsOgebkCaDWfIkqhcO+5dN3JehmCHLIZKZLg43wmdx7QSIOrxMaqfPzu3d6LmisbU9TO0piqrcv50DeeQ2bD+O/GWfrtIWsNdWC7PIfZKfSGKawXSsQvcCv5uRuYsEfNdJStC1Fu8/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jcGTMlov; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jcGTMlov"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=YxgRnbMG5q6RvDxWCmqV39hig+L95ZAtZ0OCJoUEZCY=; b=jcGTMlovmEnW5T6RR38oDr3o8E
	49onk0OPt7MV/hZ+wUlLFyHB3OMHc021B9MoEGePIowoNdMV0SIBA7aoZi+YXoUQCS6Mexp1BTgdc
	JI1bDAqCmMMhGjhn5G5HTV6A8Rd23TkMRmbxRgE9fYqy/QmZ43RDdCYkVJJFSlVVBL4z+6mJ8TNGc
	yk9T8hGiTcV7HJ1T1iY90TcvfWc1G1gOhWsRp6czZ99Y6n7rtl5AwtfDZQ/EJYTNWI+g37xVoRtqf
	vWlJkaXXvD+7r1yZ3G/v3LJcXUmwf2D8F7JS2+8BrKnHZTGjyEnXfYlFgbF4Ojus+MW1v/LAcSXWG
	jBY+R5vg==;
From: Heiko Stuebner <heiko@sntech.de>
To: mkl@pengutronix.de,
	mailhol@kernel.org
Cc: kernel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	shawn.lin@rock-chips.com,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	zhangqing@rock-chips.com
Subject: [PATCH 0/6] Enable CAN support on RK3588
Date: Tue, 30 Jun 2026 18:43:30 +0200
Message-ID: <20260630164336.3444550-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3588 uses basically the same CAN controller as the RK3588, except
the documentation stopped claiming for it to support CAN-FD.

So add a compatible to the binding, the basic driver support and the
errata I could test for so far + enable CAN on the Tiger-Haikou board.

I'm not sure if more errata apply, so I've added Elaine Zhang in Cc
to maybe add more information.


Heiko Stuebner (6):
  dt-bindings: can: rockchip_canfd: add compatible for the RK3588
    variant
  can: rockchip-canfd: add support for the RK3588 variant
  can: rockchip-canfd: enable erratum 6 on RK3588
  can: rockchip-canfd: enable erratum 5 on RK3588
  arm64: dts: rockchip: Add RK3588 CAN controller nodes
  arm64: dts: rockchip: Enable CAN controller on RK3588-Tiger-Haikou

 .../net/can/rockchip,rk3568v2-canfd.yaml      |  1 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 39 +++++++++++++++++++
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts |  6 +++
 .../net/can/rockchip/rockchip_canfd-core.c    | 12 ++++++
 drivers/net/can/rockchip/rockchip_canfd.h     |  1 +
 5 files changed, 59 insertions(+)

-- 
2.47.3

