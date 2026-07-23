Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD643DAABE
	for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792651; cv=none; b=UKtFYsLh3Qig9L6eyWpbKUZaD8MQy2NQc/bR7e1bY6AmVDDVxqjvSlei8gC2yzEZJ/iuR21NgT9Z0J1Rpl0PIdMB0/HoJHLi0ANPzeRJynb6lXSHeoNPeJPUFQRxgeZTjpJzg4z0o9DD28IsuvCKx8GHPPO3LZT0l7yZncU6ZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792651; c=relaxed/simple;
	bh=gLQ4S20QbAFSS87VViitTilsh4wYPJVg2NOW9XEM2mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ka5AB6iSYt3kakBekyHI1SkmSAqJeevNJMksmF5xSH2uHOeDk5rCQ1Omvq1KmxIIfm23AmgprZBwXANvVccv7jqTlKQVPsOvutCp88yQjqOCD4I2GiMR1ToGAkSIzfxxveAMlJLbYi8y9iQ3o5i63va/+GEHd+v+rEavjrg8nd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qUL7lDPk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUL7lDPk"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so2011435e9.1
        for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 00:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784792648; x=1785397448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MblM2TM8BGuW7T2s+VRM2b21exbLaiD9GJmSPm/AYxg=;
        b=qUL7lDPk08pqlgzPfwR4/UdJzpOjVIdf13U8DJEBV2Y6CQsnxwKeX9NsW50FwuauPw
         6VZZHIfciXdM74QA0kgxZF/Mx59ybcl/f30GY7HdFBdI8DrUbm8Bep/rNn1mXkUzZu0T
         coKMq7ubbRftnBnpHmsvTdm4thQcT61AJuemauqy4y1KiXlqHE1AgA944YC7DacadL0k
         hR03vMAY87UKIgXraj8Ea73SxTVRJlhSoCKgM+PHl21x68u97I7jA2NJfqjEj39F/+DH
         R90N8qwlbUr5sMZPhZDCbbBMqpafE1IASg8f7kSGCejPkd2T07AjKtzJHHLFpn4kHvGJ
         M10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784792648; x=1785397448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MblM2TM8BGuW7T2s+VRM2b21exbLaiD9GJmSPm/AYxg=;
        b=HkbumJd4Linxa1UpNvhijTVqts4j/BfWvj5dKhvcp4JCyf/Ko8l7be8BnXyXaWWZj3
         iZSfa8cKRnQ6zXC6kAuA8phqDeIbJz743vEUke7I50JEaTd/OUKysj8Ty4wfipOCNJKI
         MP2zbcorYmxjTBinESzyLrW0UlJOGV5HlZwoHwgqkjJNeEvlBwioMbv8GEIi8cZ27GMh
         6Ceqs2iyp/sG7JhND309jmg/4b+wxMZ9RkKD3tJpKJUPRGj45Bogz7Tb25GtLNCA/aK9
         RizoJl0pF5mmZkYSTQmrIB4XAuq7Cfzmle/hkPkuS8p9cKAzLXX14bK/KQUFpequmfTo
         3nxg==
X-Gm-Message-State: AOJu0Yy3Wlu3sSIaQu/V3z1x6hwKQZ7HLihOl64aIR8HcDctfbWp+smM
	iHjjJEJz4nllxnLAip8FRVSJ12UDxLu0gPs9CgjwfWvdSZbZwLgTfGuE/KUrxlfVMLpc/Q==
X-Gm-Gg: AR+sD13UlhlKMqFpXvHmeUd/EhYmbif9vS9nVAbIJIWU6u8s6ttApIvvtBXKb+//Vx7
	pKaVq0cEEfPvhYvXvXIWqKJoQAjoACBt2PDIkp8cL/xJv+EMbefVXKvZFt1JTPnvPIFmdgM7W0l
	JMEkUvsaHbgpMWgEuxJj+L2g1xhyNth57CwjQhpe+cToF4eV+AajNMZpNIki2zIBjjnqm7GIg4r
	Q9biyqTcrpgXV1ZaRxzM8lbNlh3Su8MB8vwy1MoFEv1KG+1Ei8j6TPVUabsx2YXy8nBqEyXUJLm
	8bPWtAlb9E+vbbvWjluAjIk2PN5SpMRFxpzn6SFktCphz2PusAbIkhIyYW79oEvZ/xIsk0jVV10
	DxpDi7QACeHkTAAj9KlYrKHdMiJY1P4FVqyegUWujeca41DUrotJuOzPpMB6ZZORBilRV3wWOGN
	m3+ThtZvvdglX+FiS9eRbDnoHyVgc=
X-Received: by 2002:a7b:c443:0:b0:493:c84c:2b57 with SMTP id 5b1f17b1804b1-49573d2068bmr12443275e9.29.1784792647703;
        Thu, 23 Jul 2026 00:44:07 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net ([2a00:a040:1b7:4f41:2931:f9dc:7c7e:1085])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85a2573csm12333857f8f.0.2026.07.23.00.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 00:44:07 -0700 (PDT)
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
Subject: [PATCH net] can: ctucanfd: handle bus error interrupts
Date: Thu, 23 Jul 2026 10:44:03 +0300
Message-ID: <20260723074403.131575-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include REG_INT_STAT_BEI in the top-level error interrupt condition.

BEI is enabled when CAN_CTRLMODE_BERR_REPORTING is requested and
ctucan_err_interrupt() already handles it. Without checking and
clearing BEI in the top-level handler, bus error interrupts are not
handled or acknowledged.

Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source IP core - bus independent part.")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 0ea1ff28dfce..0cd2d428c1f1 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -1136,8 +1136,12 @@ static irqreturn_t ctucan_interrupt(int irq, void *dev_id)
 		/* Error interrupts */
 		if (FIELD_GET(REG_INT_STAT_EWLI, isr) ||
 		    FIELD_GET(REG_INT_STAT_FCSI, isr) ||
-		    FIELD_GET(REG_INT_STAT_ALI, isr)) {
-			icr = isr & (REG_INT_STAT_EWLI | REG_INT_STAT_FCSI | REG_INT_STAT_ALI);
+		    FIELD_GET(REG_INT_STAT_ALI, isr) ||
+		    FIELD_GET(REG_INT_STAT_BEI, isr)) {
+			icr = isr & (REG_INT_STAT_EWLI |
+				     REG_INT_STAT_FCSI |
+				     REG_INT_STAT_ALI |
+				     REG_INT_STAT_BEI);
 
 			ctucan_netdev_dbg(ndev, "some ERR interrupt: clearing 0x%08x\n", icr);
 			ctucan_write32(priv, CTUCANFD_INT_STAT, icr);
-- 
2.43.0

