Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0278395AEB;
	Tue, 29 Sep 2026 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667449; cv=none; b=U0+JjJRDCI8YXtdwvyjTjOUBV5bJ3g/liSGPOTHdPOnbElvODpIhWi0GHzpZzQhnJ/DRIiIT6XyhCg8fXYfM4m02eZXDqfnbQtAx3y5Xq70h2P0ul6W9wd8mYPTMCM6kT6siFInjYGbh+MGHaJgbsTWgjog+wuS7JPwpDd/oxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667449; c=relaxed/simple;
	bh=Qa3Db2j1Y68653Q+6PC6oV2QxaHFr0W0WH1Pu4X7iRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buqyTRnWGKR2N9699Kbw63SJmmaxcFgZ9BOWXEwPazkkYKYa8olNI3MjqWM+3VOyhK9hwdNbC7bDcEPp47gj7FOS072kiOitOEMmR6njYo+40EztgZuJ/UxrcyyYI/oHnoDiWZXtA5S1HcHZTieBpCzzx6Q5Lyvf7ifDsc52yZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Bb6rX6On; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Bb6rX6On"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hg
	a33SVNks9ojHUUI1aMDk4zOQwGpCtnaoDberMk8Wo=; b=Bb6rX6On527dAW94Iy
	vhbhmUXtPynGQHF0bIeGZ416glNbEB+zucYdR3dTRHRZ0+8UWFbBSfA4vQtZhdr4
	+ygdznYKkdVsB+0Ji7SI25zTWKCA07kAjJGaF5ryNagcdcjuhVLWh4H0XeTNQeQL
	bTHRObbBQI8l551dMi8sAVDXg=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgB3RBWfartqm_LUBg--.35712S4;
	Tue, 29 Sep 2026 15:37:06 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Quchaosheng <quchaosheng000406@163.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] net: can: grcan: update the binding file reference in the driver comment
Date: Tue, 29 Sep 2026 15:37:03 +0800
Message-ID: <20260929073703.2748220-3-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929073703.2748220-1-quchaosheng000406@163.com>
References: <20260929073703.2748220-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgB3RBWfartqm_LUBg--.35712S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy5XrWDCr15Jry8Zr48Crg_yoWfKFbEkr
	n7Ga17Xa47Kr10y3Wj9a17AF9xA3yF9r18uas3tryFyw1Ivws8GrWvvr13Ja18Ga18urya
	yF9xAryUWayIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiCD73UUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-wJMwWq7aqIwpgAA3-

grcan.txt is replaced by aeroflexgaisler,grcan.yaml.  Point the comment at
the new file.  No functional change.

Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>

---
 drivers/net/can/grcan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index ce12fa6df..1b4944d1d 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -10,8 +10,8 @@
  * Full documentation of the GRCAN core can be found here:
  * http://www.gaisler.com/products/grlib/grip.pdf
  *
- * See "Documentation/devicetree/bindings/net/can/grcan.txt" for information on
- * open firmware properties.
+ * See "Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml"
+ * for information on open firmware properties.
  *
  * See "Documentation/ABI/testing/sysfs-class-net-grcan" for information on the
  * sysfs interface.

