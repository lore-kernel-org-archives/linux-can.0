Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA1D3D649D;
	Tue, 30 Jun 2026 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837848; cv=none; b=N6OGi9iYIerru2U+Fa/RfPDIbCBJcovPvQSGw62GHIG4I4YJC+/9pmNv26jJ5HVI4mDegF/T/9gYiInZfeEsQWdmGpfQ9d0YpDmyahlqAY1Fpq/nmomH/EcM1vAE+0cKj51u95lLpLWsp3K1uq3kS+c8/RceqcZL2xzNM0WvgbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837848; c=relaxed/simple;
	bh=cL/qlUg1wkXPDzymqEP/9h5OI57tZzvr4cSKCtMXvng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeiyGZi8oFNFWjFHuxxqgPGQ4tYF+9JB4QrZXF9dRau8xaJMSV0h4xE99UG1Ce21Kn6ctP+enhxSxY2LDj/YjEImqF6ZT3VJZHX+3BIAsaSDU9gwjEtq7BuNlAGvBF06vExNNyQYhbzHZv6ssTYZhOdBFLsPcak1YzQ5ox20l+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=JdHD6w+W; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="JdHD6w+W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=Hc28g7vpWVux2YAwXkS9a5h14xHv2zGqzwm/FemriIM=; b=JdHD6w+Wqy9VksFAbRDbEizRds
	HcOoPowR5rNidLnnN2fynfvv8gWrSZrK57jkirfXvLhDFx4FADGvS+NTrnFDjEa72a1/GoWW1Vyh+
	67Z0oEurLs7ilhxNXpKd2nHj9dn93elW+L2XeogBA9KlrCIHfmVD1zycy0qgEgxt/PJt2Uh1o0bU9
	I8vAeObhCmU/YFI6PXu/zOtdp7HSEcOJQp/ALx2KqF0bwg/uf1a+C0aD+QvAEbHuldlezjFPrxKDI
	BLnv3YmiysKYjFB6ISXD6akkE8l/xVV3NDH0UrKtmxVAKRTGWKTa4J+fC9GY1/ce1cw+fOmw1mnuw
	nZSrTpyw==;
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
Subject: [PATCH 2/6] can: rockchip-canfd: add support for the RK3588 variant
Date: Tue, 30 Jun 2026 18:43:32 +0200
Message-ID: <20260630164336.3444550-3-heiko@sntech.de>
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

The RK3588 SoC uses a variant of this controller.

From the start it does not claim to support can-fd in any part of the
documentation, so it seems that is still broken.

Further errata will be enabled in subsequent patches, with more
in-depth explanation.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 11 +++++++++++
 drivers/net/can/rockchip/rockchip_canfd.h      |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 29de0c01e4ed..707f387e7cf4 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -50,6 +50,12 @@ static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
 		RKCANFD_QUIRK_CANFD_BROKEN,
 };
 
+static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3588 = {
+	.model = RKCANFD_MODEL_RK3588,
+	.quirks =  /* Possibly more errata */
+		RKCANFD_QUIRK_CANFD_BROKEN,
+};
+
 static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 {
 	switch (model) {
@@ -57,6 +63,8 @@ static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 		return "rk3568v2";
 	case RKCANFD_MODEL_RK3568V3:
 		return "rk3568v3";
+	case RKCANFD_MODEL_RK3588:
+		return "rk3588";
 	}
 
 	return "<unknown>";
@@ -846,6 +854,9 @@ static const struct of_device_id rkcanfd_of_match[] = {
 	}, {
 		.compatible = "rockchip,rk3568v3-canfd",
 		.data = &rkcanfd_devtype_data_rk3568v3,
+	}, {
+		.compatible = "rockchip,rk3588-canfd",
+		.data = &rkcanfd_devtype_data_rk3588,
 	}, {
 		/* sentinel */
 	},
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 93131c7d7f54..92566822e141 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -434,6 +434,7 @@
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
 	RKCANFD_MODEL_RK3568V3 = 0x35683,
+	RKCANFD_MODEL_RK3588 = 0x3588,
 };
 
 struct rkcanfd_devtype_data {
-- 
2.47.3

