Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C362147F9
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479933; cv=none; b=LiBlz0FLN9LaMIe1O/kXBgVI9qHkwhV8Q2SIoTc67zFrhmQiylWteNqdwOPdNmZrJIxLPfe7P/3YKzAbs595CO2Fw9WBUKXcE/OTlNqcuXc2R8+YsX2caQpkiTZiuePCmyBnmBhT0/WDWJFhrVCYrTSlHZehDjF6iiFriJwslos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479933; c=relaxed/simple;
	bh=RDjNVBHsJeP5xhO7Wyb7fa29u/GNUNTqbCtElT40KWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSRIk4jy7zMLW4Xd/67orKigLITsc45vlJbkFys2pEnhBLab18ufHBncO3OrpL1EnohxJzl5imfSn2qxuz+lI2LmMW1aJmI0P3a7fjgMEZOSnnHhFLdsyUjgP0tVbPEKrr4t4c5SZhhxYTSq6U+K2oVxjMaxxkUsFRgYjrgmBe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jckxlL8s; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jckxlL8s"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so3382795ad.1
        for <linux-can@vger.kernel.org>; Tue, 07 Jul 2026 20:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479931; x=1784084731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fxkLrYr5aWISG484jr5FD5Wa9ToyrlfnhtwYV/kULB8=;
        b=jckxlL8sluSO9pZ0nEwj3yGnwpn0Qk8DbDBmAazAyOxRfbMtdQ+n+OxbIRbYB+ISm4
         XH500hWIBq3/xu9zdSwms6FSb7Sv5U0XI/Bzs4Yb+zEMQ1Oa25ZBCY9nuMxZL668jeA2
         9MXvqFDHi4OEZwOlYHmG3CAIc1ziFWckmlmuYwhUGDTQQNrNXYHOkup6RxR2gG5kYrcK
         y+gudrp75q7B4pBx5/Lrwab2MTgLCvZND5n1Q9ziAQ9CWKoMpIUu8U2pvl3YCW81nUVp
         voZk4ZEdFhjP0bv7VYc7lWAKVVZWQAjn1YcLvgAhQlGjZ6eM9DnPts8QaEbdgTmvh4ak
         KgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479931; x=1784084731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fxkLrYr5aWISG484jr5FD5Wa9ToyrlfnhtwYV/kULB8=;
        b=cpXZgaLx7DWPg3A70sMydeCm9aYXfhNdXrxshTAVE2O1nFF+pth7+nkJ13nbwkPwl7
         Z8OnQUi1E3Mc+VNxPt50ESuu9SPKF7tGHFk6fu4TYjScA3N9IqMCLfpnkIYqIvPStJ2Y
         AJq6DehEY/ozoE8KUXyj7nZiIg+9amojjrQbyxvEuY0W0pYjvEUtTWqQYoYdjp9kaDsY
         6zXXWmGzTvBsCv0GiPVKS4Ig80g3Lrx+2M4TGkdfqKhpSDUFhNU3BhRIR3OphpSH9TCD
         x73vuhCWyCLWxQUu/NzQdBNbLDbnQwfAtYaTgMSP5MNhA4NN6BmZWOZbDUb6lZ3OGQ2B
         Zp1A==
X-Forwarded-Encrypted: i=1; AHgh+Roh+bbLdW8Sgk+ymwPRf5V2TPY+A+FcNEPN2s/QWXMxlB9NG0xayZe0+bmpsfg/1YOU9MusVVMQyes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZy1GPNXLIWzs90uDCdVhEWduMqmqjeE8UC2xg03tpSZqZfk5k
	3XTX6WEzxpjTrqpq8syXYQHu3YhBZBAYmD51/52/Jm4UxP+Dx19RmkBd
X-Gm-Gg: AfdE7cnuDDeccAl7aPh33RjK5vmttp2l89W0/1606rqDQqzJYvcRsyJEPG2KA/cL4gT
	ViN2/XRYs/p5DH+M5zPsEy3n8tPo6/6/Je04m3wQ0kReHybtTwYGwC96yEq9MV1n5Z8CfTmLHZy
	tRhdnWuqtMUXATl8EeN/ZlboxzrGgm2DMmDO6zfNgmvsv/EPuoonBdNx0+bkOhcZIWKi02An12E
	oUbc02KkNtVIcw2SeX/0ZCnV4sWqibTjgEMuMMBWPZJU4lkw/8L6furd7G8Ih+sVdSngDKtT8g3
	GoIlAPJYwyWgEeTJwHL+j6BrHTAieIqqF/enr+pCpeUIZOmOYuKWnpPyTP+wYZIdMjj9r4e5CJ/
	zbt9zIgUGsyXqbecJBXfb3PguJIUO2d2r3skPjcDPHE/QLz1acTQ8ZeuB35GI+sBCGwwnBZK1tl
	02/Tt+ypFfdbDA2f68mKugQH2tJk1147kqj9P4mGZHGSZsqvfBZYvOPO6daw==
X-Received: by 2002:a17:903:1a87:b0:2cc:e620:e307 with SMTP id d9443c01a7336-2ccea3b0e71mr6494625ad.20.1783479931549;
        Tue, 07 Jul 2026 20:05:31 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d45csm20099865ad.62.2026.07.07.20.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:05:31 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Kendall Willis <k-willis@ti.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v3] can: m_can: Use of_property_present() for wakeup-source
Date: Wed,  8 Jul 2026 10:05:12 +0700
Message-ID: <20260708030512.8570-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

The 'wakeup-source' property is declared as a phandle-array in both YAML
bindings and Device Tree source files. However, the driver currently
uses of_property_read_bool() to check for its existence.

According to the function's documentation, usage on non-boolean property
types is deprecated. Switch to of_property_present() to comply with the
recommended API for checking the presence of a property.

Fixes: 04d5826b074e ("can: m_can: Map WoL to device_set_wakeup_enable")
Reviewed-by: Kendall Willis <k-willis@ti.com>
Acked-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Note:
It was originally posted in May and has already received both 
Reviewed-by and Acked-by tags. I'm resending it to bring it back 
to attention in case it was overlooked.

Changes in v3:
 - Add Reviewed-by tag
 - Resend.
Changes in v2:
 - Add Acked-by tag
 - Add Fixes tag


 drivers/net/can/m_can/m_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index eb856547ae7d..16f80607e150 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2464,7 +2464,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 		return ERR_PTR(ret);
 	}
 
-	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+	if (dev->of_node && of_property_present(dev->of_node, "wakeup-source"))
 		device_set_wakeup_capable(dev, true);
 
 	/* Get TX FIFO size
-- 
2.43.0

