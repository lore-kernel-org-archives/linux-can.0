Received: from mail-wr2-f38.google.com (mail-wr2-f38.google.com [74.125.225.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD754705D
	for <linux-can@vger.kernel.org>; Fri, 18 Sep 2026 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720173; cv=none; b=T88ts85Bb3GIkA8aTn04zfdubebbr04yu/at03wHh2yNkguaDlrLJTdu484FVRJDfc0VTzcCPgyO6o0S2GUPqSTSDJLaiuSuVLoDyLvc1pfQYEeh2nfav2yaspso0w4e4W9uXe8jOHWmNLI0qcCRU7rplt5apPPnejohQ5vJun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720173; c=relaxed/simple;
	bh=f8H5E/YfBBH82cx965GQK3srFAvkp6XlE1/3CJPT5mQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=txLH90rYyIfxcXvt4VdbcJO/JApKwcK1PRB0IfcCOIVq5D+B1nvdMEGSZhJY6zMqmGWs9JZJOgmkAxHq2lEDcXOtK7UikfhGa8zPhaqmxf8vTC0VJ3Re2fsPl7inNpaRZ7HCpq8okxnNaKXIzr4fYhxbqbTdcE5U9AxhLOUIJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=osYXZErk; arc=none smtp.client-ip=74.125.225.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="osYXZErk"
Received: by mail-wr2-f38.google.com with SMTP id ffacd0b85a97d-482f6350f89so240276f8f.3
        for <linux-can@vger.kernel.org>; Fri, 18 Sep 2026 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789720169; x=1790324969; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=26+NgLjZ67QyyrIUh0oGlFjqG371VHNZMs6LZelIEuE=;
        b=osYXZErk6pwltVeCLBjvweMqp55g8cy0g6NAp/xF1w4LV9QvMGYM0MNIyny1OsqS+m
         67sXBtdcTp5ksedPLzFDlA/6HbZvUcELsmaWHEKWHBpDw/lbSUr8EpHY7Gcv1iSMRWpg
         GxfW/AwmgrB9SqxI3hIrRa4AIkfKSxx9olea31YdtTRNEy6fEsI3YSLwpW901pUHU4du
         8RTx8FN579t6cLjzO2t+UxUDZsvtgDcV1RMswjbQeAf9+x06VoxoOjbhj52ueKwe+Ln+
         BE2OBn6yQnafh7fpW92LU1MVu3B1vefYaXUjzlQDWjIRaCwYyOuDEKjGLiYSYWcegSS8
         qxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789720169; x=1790324969;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=26+NgLjZ67QyyrIUh0oGlFjqG371VHNZMs6LZelIEuE=;
        b=Y/nKIaizAwQfRWGq6S8w8oX7gL86ib76GdeMf3DxKCu03F6R6B3brDD3Kej+A4yT0G
         5oQO+q4aj9jeBg/EsMFUxidvUij/7MZgNZgcC254UbqHWXxCW1KAs0UCGmVAU1mzySk1
         cduxv4ooiPjft/YVAwqegnJi8II/iOaBHRwhgFxxjL5CoUGYmvoJj6qXjq/xBg6RRfwD
         vtHf2OxfZexCtSaTDjP/1nCL95ztqNs8ku19NKowH5uebv+SfTENYAa193gSgYrxx1Tp
         8L1bAmVy/K8qnxCuD/4lZsm2ZG0ytFM9hbyte+qwuDYZXy4gSTyqk8d5nlKGFUq+Ci/+
         zOiw==
X-Forwarded-Encrypted: i=1; AKwUvBy64Snlfwc1VpdBDos+sGA//PK3+neckA/zTaok4vYHSAFwUM+EHQ4yw3qCYowL4uRrOrzEDMyl/6Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nnUto3MY9TRUTvtxfkeCz8SAwWVTrYrU2bbn1KxFDTemxLUt7T
	CKvP1mxuAhlFQlZDRFJKq5aSj+fiJ537fFZdsoHEcV5S6FnVAE6ifsPA69G4ZK/35o4=
X-Gm-Gg: AYBFou1LTCBMN6yN7gzJNMzEM5sNGD5G5hcgruE5WfeQH9D85aqIfjm2R5Jpn5go4dN
	728+k6Da4kzSvbDSy5QUg4PNa9vd00RuM3gaCVQtKnqpGx5xV+MaM73l6Lh1JY9sxC6NkmNZdGP
	UvK6em6zAnIaSDXnFwQ10kMueMapmiO5fFvNL4zqKUOqx1EcWKZSuhGV8Pec+aId8IJoXXj9qRj
	m/WDq8E9jgULtr6fV8w/njOKhmNqzPZecbHd6Jbnj4AwTM1YeBzXJSOtzKl8Pr/em+nx2MXDHzb
	atkX9GEaVlBg7nrCsEps9g2zvp7nNel5OFasOfDW7608JCXRMXtxmPBrhstDm3OIyhV7KydN6Pe
	mdRkO/e5DCzUs7bSJZuFlSZ5jwwRdw1aCDWv2tEjAus5Uov5ZeXp2mkU1n1JuGX3QOLtpoHYadt
	HrxlPDf6Lvyj7oM3aIirRBBx2yuqWGnTCparWLNs4HjJctQrLMPnyBCs7LNyUbwwHC/lw=
X-Received: by 2002:a05:6000:1885:b0:487:c4b:7bd7 with SMTP id ffacd0b85a97d-4871e261f7bmr2008031f8f.34.1789720169186;
        Fri, 18 Sep 2026 01:29:29 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8223:7a95:1dd3:2926:35eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871ff5605dsm2337466f8f.19.2026.09.18.01.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 01:29:28 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 18 Sep 2026 10:29:14 +0200
Subject: [PATCH] can: m_can: Fix suspend deinit() error path
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-v7-3-topic-mcan-suspend-fix-fix-v1-1-e24fa70c754e@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAFn2rGoC/yWNQQqDMBBFryKzdkCjaNOriAtNJjqFxpBRKYh3b
 9TFX7y/eO8Aocgk8M4OiLSz8OITlHkGZh78RMg2MahCNYUua9xbrHBdAhv8msGjbBLIW3T8uzf
 qutJK25cjB8kSIqX7LnT9w7KNHzLrpYXz/AME4GW0gwAAAA==
X-Change-ID: 20260914-v7-3-topic-mcan-suspend-fix-fix-b943929d8fef
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Sean Nyekjaer <sean@geanix.com>
Cc: Kendall Willis <k-willis@ti.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2018; i=msp@baylibre.com;
 h=from:subject:message-id; bh=f8H5E/YfBBH82cx965GQK3srFAvkp6XlE1/3CJPT5mQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqw132KMn09Z2pwSXZN067hyp0W0tEXOtD1M+6Rux6g4c
 L4o5kzvKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgInMrGFkWLWA66jiNiVHr3UO
 R3L5WOZePqt3M/XZnHwHxrplDlMFdzAy7FnE+sLrU3Pso4AclWCeq3IWa+IMzhjYf2O/cOW3vJ0
 +MwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

When suspending mcan, deinit is called and its return value is returned,
but nothing is restored. Returning an error in the suspend function will
stop suspending and resume the system immediately. So on error the
device should be restored to its previous state.

Fixes: ad1ddb3bfb0c ("can: m_can: call deinit/init callback when going into suspend/resume")
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16f80607e150..91a0c5eca260 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2612,8 +2612,14 @@ int m_can_class_suspend(struct device *dev)
 			hrtimer_cancel(&cdev->hrtimer);
 			m_can_write(cdev, M_CAN_IE, IR_RF0N);
 
-			if (cdev->ops->deinit)
+			if (cdev->ops->deinit) {
 				ret = cdev->ops->deinit(cdev);
+				if (ret) {
+					netdev_err(cdev->net, "failed to deinit device while suspending %pe\n",
+						   ERR_PTR(ret));
+					goto err_restore_interface;
+				}
+			}
 		} else {
 			m_can_stop(ndev);
 		}
@@ -2625,6 +2631,21 @@ int m_can_class_suspend(struct device *dev)
 	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
 		pinctrl_pm_select_sleep_state(dev);
 
+	return 0;
+
+err_restore_interface:
+	if (netif_running(ndev)) {
+		if (cdev->pm_wake_source) {
+			/* Enable interrupts that trigger immediately if
+			 * something is there and keep the hrtimer off
+			 */
+			cdev->active_interrupts |= IR_RF0N | IR_TEFN;
+			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
+		}
+		netif_device_attach(ndev);
+		netif_start_queue(ndev);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(m_can_class_suspend);

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260914-v7-3-topic-mcan-suspend-fix-fix-b943929d8fef

Best regards,
--  
Markus Schneider-Pargmann <msp@baylibre.com>

