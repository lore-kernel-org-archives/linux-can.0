Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B03C1973;
	Tue, 30 Jun 2026 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837848; cv=none; b=FRg+GzvrXVoCLG976uK8Mxo3nIGoeCdqs+qkpMyaDXoB4btRq5xQJGy1zEEOvGTXIs3TF2ozFvk6kwl+KofNMsx05XM+XOvFah0Z8KWplL5KivqQPrVGTmaFnEF37mK5kTkrvsyvU7FFghHWkObSzTlHuankG5m9lNuOomnbfw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837848; c=relaxed/simple;
	bh=R2YgUFMBLrWlpSt7g+6ANQQZNUDLNvc8uk6XrVvLToI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHaRJWAVpxqE5f8tWS02j9zqluPLpFy5Wr8C0QRbySJqdXIMSoV7K8gr6ozYHuBQ6L2K4lvS4+PANcK//guQaahR4pg1brTIqwle6Z6AJ+NllGB+F5ELYDTpneieb2ElJk4fMGAaWa4dK1Bo1xjQgumFKJod6JpreB3Z8fDDbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=XIaELJRE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="XIaELJRE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=dV/6p+jnBCTZ+PzDK8GCl4Bvcm15c7cMycChV092hzE=; b=XIaELJRETsTj0t4x8bf4WRerHW
	Xg3gCR6NwJa/r6Pm/k7WmIfhlxVZDk16KzuhgPwYVLOOwLqz5kr74lkVmAHZ9yv9aErlVil2Tuhoi
	Nk3lvl5DAsVc+PL30E340+eONDw2lgS2AqlXRexMg/92Se3hk0l9doEoaY4BzK5pcNlYH3H7P3uog
	74Ul8oum7ov7BeDVI3d2MpwHZX7kGADNY3uEmW47p8Xhuk2LgN4BWf2O+NDFQtGk5M6UL66cg0QmV
	KxQL035iMJbwo/ZQ5LMY6Fvxwz/ouKhB/yoXCmilGjtBz4lMaC58ZH0YpRZpA8/cOg8Sa5ITBn2SR
	sKj8oweA==;
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
	zhangqing@rock-chips.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6/6] arm64: dts: rockchip: Enable CAN controller on RK3588-Tiger-Haikou
Date: Tue, 30 Jun 2026 18:43:36 +0200
Message-ID: <20260630164336.3444550-7-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630164336.3444550-1-heiko@sntech.de>
References: <20260630164336.3444550-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

CAN0 is piped through the Q7-connector to the CAN-Header on the Haikou
base-board, so enable support for it there.

At least on RK3588-Tiger, the CAN clocks default to 99MHz, limiting
usable CAN bitrates without skew. Errata documentation mentions
300MHz as the default frequency on RK3568, so replicate this here
to allow more bitrates.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
index 873fbeb8daa1..6273e695b039 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
@@ -155,6 +155,12 @@ vddd_audio_1v6: regulator-vddd-audio-1v6 {
 	};
 };
 
+&can0 {
+	assigned-clocks = <&cru CLK_CAN0>;
+	assigned-clock-rates = <300000000>;
+	status = "okay";
+};
+
 &combphy2_psu {
 	status = "okay";
 };
-- 
2.47.3

