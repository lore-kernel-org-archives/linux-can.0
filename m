Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F703499F11
	for <linux-can@vger.kernel.org>; Wed, 16 Sep 2026 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562569; cv=none; b=YRyxqyAkovrUKjbmi/PS385oE0CDcVOFrkWZu/RBSLbJedWvZ2tj9Lwbo1UuH1nDNe1GhamGmElKaPpDz2TNX0eKvQKG+pqVrx6kh0RjxLoBlUENiMurW69A9E1ya9lWrl2cMDAgVIbvzIGrs7NcZ9pILgA5d9FrXfAiUDVNS9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562569; c=relaxed/simple;
	bh=O3kCx8wll8cftRShmLU6mCy2LT8u/tOsraI5NQjuTag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCo1Jt1uQcIO7dPuAKZ+0MxT5AWHANmVnK2a6Nym2+/oKW21lwf1jyw6CYR8tU5H9RM7HHViKZF8WIUI5G5pobPPdT+k93hdXlCVO4a1/Ccf6638dSt4a+uzdaXqHUTcYzACzg5w+38nYOb3oopI+6wcEJpYAvcwmUurCQZw2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LU9zegG/; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LU9zegG/"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663c1so118986866b.0
        for <linux-can@vger.kernel.org>; Wed, 16 Sep 2026 05:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789562566; x=1790167366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CSiRXz+rk1x+flrUjYGBzi7758ew3AZ+JbhIvlUn8pA=;
        b=LU9zegG/RgLOwltPk1hhEmW1xq1jVj5bL8S3hbpUP6TuyE7XoRre3JcXeTU4ZAVQpv
         RFYrllxITghVI/g16sOlp82o9yo1k4Te31ys62a90kOy8GLQ1a3lkfJaUSgTCdz3Sul0
         39Z2XpHdtjDr34tNt1mxdUlc+hGOVu+xZfRQch7Kg6EBYwCEvS4357kZ1kDtRLsnBjiY
         /DT/PH59/GM092u4TpL/V2PRp2KdHKO5nvIG3/MrBBhK2B7JUGz6ep71vgGdLJWLbPsY
         GCr62WWoKRjOjTejp0HlhjTLgweGB792zGIYSak9ANclj8wtYM5aOhQZ4a5/zpqn8wLV
         nwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789562566; x=1790167366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CSiRXz+rk1x+flrUjYGBzi7758ew3AZ+JbhIvlUn8pA=;
        b=IcRHMs0L3d8Gc1LUxcBlQgv+pIjvXPX98Hnld7I1v+3Hk2v8UP4khMNFqWm27f2U6a
         TC7CNxp2vaIRztbXZQGyeVn/ufOy4eWEC7tTNjBgNCDuMDG23EM0PyVUCS7qK+NFDHVr
         lrFZw3zMPW6IjuiuvYtGz7rI4uUrA6MQLS2Tu7sk54s33sEL1kqmqpxL2UbbnTp8EpeX
         XaqoGv7SZbmAZr/2QKmB9TclTsofAKU4PKJXhMyDFaQUIxt+PwGREg0jN3tL4ok0mmZz
         p1rqyo0qyvZ++GNOCSeuQ5Ujoh35UlY4DOALCvtWlbT3Giyhrl2ntcc4Zy4QV2AFpO1l
         ymMQ==
X-Gm-Message-State: AFuF++l5w9ZSMgScd4W4Uuu3uTweUXxRAayIvIJpiexUNr2/UJmA1POq
	EhmeIZarO2Vii7P0bSmqMC8fKWMBeysFIPXAw6Po4URg3DmGr4rdIkCt
X-Gm-Gg: AYBFou0PfeeeB8D9nafUS71DNCjmhh04Y+IK6IC/8ZMTuMfbsBRX134t+BZJ7NpnEKI
	MT6BGl1X2y3CpLh9xYt8lHUFnHoj6oQ5YQE7BKtuY1JKfEbRU5lPrDTD+CrVkKaoNl9O6Rf+W5M
	9fJj0vu7gRYWdMEOSHohV51NwphogMU1L1UphkKK3dxbnLDQug8QupyIcwFPTx1yPbPXpcuiAut
	id/+/X5JymhpNhonKf9mMT22E3hprO8Q42Ydc6Dsw0MDSmWbqzg9mN3Jg+r32dhzSXtpf8Q9cmL
	UdJQpkZ9eMUMBXnB6vaiqK4bXq1fbdPBPetGjsIMqbo/rNrjj85AdLKgBQm++r9aKJ5+PD4YjUr
	mBOwXMgVaMTaDQP0ElFnfHOIAIP+NO36kRhstngfzAQ4CM7qmBlfIc//RC+/ywiaMdm6C+gLvEo
	aQyMP59qxcrwdxeMe9zILo+z9Oj0uUP4KRDObjeQWn9JBadfrdqxVD140ma09cPlp9Vh/lPz0sc
	DozPJ8GBwjZA3lJmk6OKM6WMdsMB1NqXcNNUR+7CQ0S3q05tH4i25VOY6zHzz/6pNcV0tz/SiI/
	+9SdSeblbfTq8EApTkGqZVN6dvBdIDPpXYZ1Wm+8nCFLqNlapdYYkB5Zbq0htIqfAN52vcty2ie
	UnzbbExp6XLdFT20kibMz4bkx7251JDb7UkPK+r74ko+pMnXFleyfIO/I3vtR2anTXviEDLh3+K
	hH64ra9UNXbmazpWP1YUtVdANBYCEAbQcdPG5MH5cZncGm5GBccKYOTibD6fyjtVFbptdVpaNu2
	1ksLUawaQkO59hCptc=
X-Received: by 2002:a17:907:c22:b0:c29:c531:7525 with SMTP id a640c23a62f3a-c29e523eff2mr323459366b.7.1789562565839;
        Wed, 16 Sep 2026 05:42:45 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.oa7bb030819b2a894-tp.internal (225.220.204.35.bc.googleusercontent.com. [35.204.220.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de5baa11sm132865466b.40.2026.09.16.05.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:42:44 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: m_can: pci: add missing pm_runtime_dont_use_autosuspend() call
Date: Wed, 16 Sep 2026 12:42:36 +0000
Message-ID: <20260916124236.1389-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

m_can_pci_remove() forgets to call pm_runtime_dont_use_autosuspend() on
teardown, even though autosuspend is enabled in m_can_pci_probe().

Add the missing function call.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Found using a Coccinelle script I'm currently working on [1].

[1] https://lore.kernel.org/cocci/20260916095616.1394-1-joshua.crofts1@gmail.com
---
 drivers/net/can/m_can/m_can_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index d11a7c88fc32..3c595749b5c7 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -159,6 +159,7 @@ static void m_can_pci_remove(struct pci_dev *pci)
 	struct m_can_pci_priv *priv = cdev_to_priv(mcan_class);
 
 	pm_runtime_forbid(&pci->dev);
+	pm_runtime_dont_use_autosuspend(&pci->dev);
 	pm_runtime_get_noresume(&pci->dev);
 
 	/* Disable interrupt control at CAN wrapper IP */
-- 
2.47.3

