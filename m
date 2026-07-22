Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF85440A28
	for <linux-can@vger.kernel.org>; Wed, 22 Jul 2026 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784748458; cv=none; b=VoNJ6b9OOp7+bvffX1RalgxZFGSKT+ust7G3wyRuGsmi6o4MpQ9ySGvDQxkcU/XcRi30sAv+5Vz48HS3vbMRAWTBLRSB0tsIEmetaXznTDXsCHvj4TetQJz13PN4Y197qItjyBIE2JLXxpdCNXnFdCSGGhuBGeVe1x6a0KxvhBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784748458; c=relaxed/simple;
	bh=NXrNrNrobISj2cFdOzeQsXJni4zC9IIseLuYFi5TarQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+aEzh3/F4FmVvIir+U9OZF6NZLrIp44sTSiVWc5RhYbdhcLopcoYOdnGZBGmRfmafWjs65kKAa2+QA5XycxfPadRQ140s73EgQk0VQ2Zcj7+Wcnk6WLxrNcNRzH52zDW4ZeXYdW3DX5/78fV6201sLyI1w9XeqZylXx0eao1OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYufu8gi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYufu8gi"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4728c12ba97so6765939f8f.0
        for <linux-can@vger.kernel.org>; Wed, 22 Jul 2026 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784748451; x=1785353251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A4QGtthpDoSR8w+cOub6icKKshFZB4+JzCuuHxM4qR8=;
        b=lYufu8giCFoshMhaytTaXVd3ctCaam7gEXKU9T3D+gj+oCb2TH2h0cKoL7tEqKoBWD
         y1WNC6/QLEFIHaC0f+uy/X2gch23kpMuq6iP7/aZ88tPU++IeU3W3MtkUtnW5RZI9xWU
         wAFK/GFu4VmrKW2wI7KFQwFvgn+o94sLaZZKsyQB4m9VpDqikOCt/rQ1/ZE1WN/mz6z2
         XrRD7Xqg4hq4k+HAPFLOL2OJw6CzMw/IT9+8rTmim94Erc861XqrRZ35OWigfrG4Vdjt
         K+KOivd3CK25Bed0HhnfXPDmYbotZsCp6XaQ8eR2ptIOHXZIKJUQvMupLcdezShjT68E
         +DMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784748451; x=1785353251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A4QGtthpDoSR8w+cOub6icKKshFZB4+JzCuuHxM4qR8=;
        b=iEgUhZgXyHtPi83cVyF9vhMB+Ocj4348DYiFZmgOBKDGh6LF0+V7uno7E1ZgEl+mrw
         GwuIw3cwW01krr6A95GP3RPKnNPUyKbqnT2eP4My4XljKMH81srwMB9uImGaak65ph4h
         VvSKe6keqV2l6B+3D96whZbNde6k74W/PBrJLOjvXfBFHRkzvZJJp8opFs2O8FLv8rU+
         gpcY23dyUUbKtrL1BaFtQpsyDSYH5jkEQ+ia7zz01fAuFc/FKaHkHzcZ7e+p7Tf0P7bO
         bW3zm1prEtAv8UfnyPtmWvsjjG4weOD0wQ/9hJrlHGS/ZZ42o/kG7oRWYSo9mrSxI+gc
         tPvw==
X-Gm-Message-State: AOJu0YxREMGvrMvYwgx+FtRWAhUsfzYYr2rkSBlngeoDqpEuSFibuWNV
	i1Im58XLdST/jcjqxNJGImkmkQqSZrg/XBiP5JXomzRIzfeas/CnZWryKJc+6XKN
X-Gm-Gg: AR+sD11kSxK1docGlEkFjOIHwvQwZq6tKWyzjD6k+hGPWid6f7wv9LPYwJiDQ7oyo1w
	MhjzKjphsw7BOsidCVt6RBKyi4rMTbk5uk9MC7NjmH/8hKvbPF7lHUEoofJZ+kl+jGNNNDp4VOM
	Cc9mrZzLW4Ux5NSQBscqWi16py7SRwYS6CTYGJiw4ANfnYbpbPvHeTjoFUIxA0OU7baiGfH5fX1
	QJbxwT3/K5BJXKoHngW3SmVBhsXFjsB3Yiw/RqL5O/i7LtogOVksbXz5DXeqx7nksmT+IRaVuNN
	abvrHgKSlTwuzDnqkEgoF/mKdX1gJy0Wls1J+ZiMOUywpftvpNEADB60vw0zFewjTSQuIx+rorj
	803wQqpfRD6AuT9B86+wFbgkCNUKrHaJ3i1BPMihH6H/kGJzlmr8xzAM+SzJb5ayzLFAlhrhSci
	AjSzMc0PmWKf9QUzorjcIufHUq1q8=
X-Received: by 2002:a05:6000:2401:b0:47f:5289:d5e1 with SMTP id ffacd0b85a97d-47f8dc7a475mr188635f8f.37.1784748451208;
        Wed, 22 Jul 2026 12:27:31 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net ([2a00:a040:1b7:4f41:5526:66e3:5bad:ba45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c7880dsm8585606f8f.37.2026.07.22.12.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 12:27:30 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: linux-can@vger.kernel.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Martin Jerabek <martin.jerabek01@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net] can: ctucanfd: use self-test mode for PRESUME_ACK
Date: Wed, 22 Jul 2026 22:27:26 +0300
Message-ID: <20260722192726.230729-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use self-test mode for CAN_CTRLMODE_PRESUME_ACK so transmitted
frames can complete without receiving an ACK.

ACK forbidden mode prevents the controller from acknowledging
received frames and does not implement the presume-ack behavior.

Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source IP core - bus independent part.")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 0ea1ff28dfce..8e0a606f2c84 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -340,8 +340,8 @@ static void ctucan_set_mode(struct ctucan_priv *priv, const struct can_ctrlmode
 			(mode_reg & ~REG_MODE_FDE);
 
 	mode_reg = (mode->flags & CAN_CTRLMODE_PRESUME_ACK) ?
-			(mode_reg | REG_MODE_ACF) :
-			(mode_reg & ~REG_MODE_ACF);
+			(mode_reg | REG_MODE_STM) :
+			(mode_reg & ~REG_MODE_STM);
 
 	mode_reg = (mode->flags & CAN_CTRLMODE_FD_NON_ISO) ?
 			(mode_reg | REG_MODE_NISOFD) :
-- 
2.43.0

