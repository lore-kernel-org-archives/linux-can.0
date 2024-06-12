Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF47FB
	for <linux-can@vger.kernel.org>; Wed, 12 Jun 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202573; cv=none; b=YZZkEMEbidZEfmqYe1wCI80d9R/3/+Ww5lbMuLCHutdC1GMXx55X71ZSiLpBENoNNIMeSWCSLWjtnJwszH/2LUNJ7N6YQl8/fXtCdtc+kFHGFo32RfZhaPPhhGNn9mFnAN6fEgE2sJhaB8SiXk5JkI0IXJV8Q92CL9zOBrigUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202573; c=relaxed/simple;
	bh=WJO68NRKpJosG1wy4AZTdzo3SkSpDM1bopvgNNWMCZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WVfy08s0nJHnDcujh1ZdBCZW7fIM3tzKsx6E0nRuRi2/0MlvXFToyjAGi9CsHcNXj9rlMLXCYGW+zv7PbWDKSgMznNqYAR8JOi0hyZpouzviV8HAtL/kOazKV7uiVAtJWZsYWz5KimxHY01ujzVj3ezz3uWnJA5yDBPyBA1/S3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id 9B652E009F;
	Wed, 12 Jun 2024 16:19:49 +0200 (CEST)
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH 0/3] can: kvaser_usb: Add support for three new devices
Date: Wed, 12 Jun 2024 16:19:43 +0200
Message-Id: <20240612141946.3352364-1-martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the following devices:
* Vining 800
* Kvaser USBcan Pro 5xCAN
* Kvaser Mini PCIe 1xCAN

Martin Jocic (3):
  can: kvaser_usb: Add support for Vining 800
  can: kvaser_usb: Add support for Kvaser USBcan Pro 5xCAN
  can: kvaser_usb: Add support for Kvaser Mini PCIe 1xCAN

 drivers/net/can/usb/Kconfig                      | 3 +++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 9 +++++++++
 2 files changed, 12 insertions(+)

--
2.40.1

