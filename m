Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B63340F75A
	for <linux-can@vger.kernel.org>; Wed, 22 Jul 2026 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716756; cv=none; b=SvNM93ofwfx0sWlweVI8YKEAbC/4CXs0rFJxtGlmP3JwgrRxVb/8bxSnEjgobTHxr8c7AL/3DEm6XTb03ZK3TtxrU0MngBqdvRDAHNFHXMggk+zksCIhlwn4uiMsiOkEWLp3isb9uq3RjgJ2GDsLEsmLvhLxCbSOYV6WMfwhpcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716756; c=relaxed/simple;
	bh=qVkwbm5skxHmjijSQlwkYEBcOxBNQ7+31ovrvai2xds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dq7dGffsh2zyTUu5y/pWGqnn7RaoDg6xcgIy1igY/LsSyV1Azll8ZhTzmFqd0PeC6MM3iAC0h97VzLW56m7lRcqYIB6m0LNxYO8UP9c9nIaGp4UURXRFIM1iLyO/tr1H5qq8Fz8fNgfaCJItpaYHgoZ3B3xdVMZcL6ohWFhYrq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=Y84w2YQj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="Y84w2YQj"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cad8076b01so147119515ad.2
        for <linux-can@vger.kernel.org>; Wed, 22 Jul 2026 03:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1784716753; x=1785321553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Nme6Toj9C3wtO+kV+jhiXnrP22CDDJWcY5DQqOuABI=;
        b=Y84w2YQjPHNvZbIZaOnXVY03cU1FLLT4uo6G39NScqUCyfG77S+Xm+2FMusxSDp5Ta
         jqkg+HxyHfaDwgLaBKeD4aSnDF3jfAZHCuPdhGh9ga3rA5JrYvWv+ycjcT8tgJvI0Th3
         Y7XVwh0NA/SwjK0kmHttTWIADe6ZumEsWinX1+HKov9zRk1rT3Xuy/yvFsPuD9jpKAEe
         bIUDdthVin3B15Lp/RRuwCie5cXAG0a1iqu8NGeag+1w28cqsa8w9gpI6NevwJWlWXNx
         JMohUqMI3ipkdHF94lwZxTzmv0+dXkO5tghMTKz3RdL41eo2zqpOIVeKQqGH3HmvK2Bu
         6SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784716753; x=1785321553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Nme6Toj9C3wtO+kV+jhiXnrP22CDDJWcY5DQqOuABI=;
        b=Lx44TCKtyj3Rr6G8JDbtcL0ZE21ZUP2DOQ8G7wa/mbGfQGdNZsQzL9kt93muDC9JM/
         0ENAKq097j43H13vOvrZOSjNTtSTUdK1As/cx+yeLdNt+iieZ1VdVjXGCNa90t0CXrMm
         jVvE8m5HHnuu4JPyrJVXAPOicAvCVOPzILAb5KoJahEc7R0ut5Cwy26g5Za8k6v6VFED
         pSnwc/MtSZidbSz+ST8hbCczk9z5/rGUNu8sLuQnwK3kX2ZYDYUj5jzQmksh1V7cazJw
         /t/mRjK7lLopejsjzX7c0tSi1czRohTg9gwiphEsIx6pO7PwitUr6nJzQF18z/9u8nte
         X0Jw==
X-Forwarded-Encrypted: i=1; AHgh+RrLkYkV03Q24iHYVDf0+e32/QQR7rHjO9TzwAUWyTnUG1zPAEEV8fxMEnaO9ZpELj4qj4/JTe25sc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFSFXRl1y4qlECCMo09ujGNXb+bWyCWNRvo0kJUTTPS4xBA0yO
	a8kz26J8b5CYX+f7Iul/HgiY1DRDZIwC4eqOz4qX8kPMHxtc58HjpRFN/9bK/dIL+A4=
X-Gm-Gg: AR+sD11klt5AnYHcZhOLJ1lzaqPqFBEPa/SHIooQqYp2jeaG5eo579eEB1I0AAAIQl7
	PSyGMlqAbvt/b0cWkUXLgmieegoWS5eLil1WyrXmJEJ00BdbmHaY8nHrCoBuldeo6boXNOsXhcK
	HCp1Vj3fRKQEaa6LWDNHEkh/Uj14BssS8ovg5aVrKepeHyB7h8ahhAUnLrHQUkKDaf4zLJYQcqK
	5Erp09QDPseFVZcs6iTaPjXD8XHhfQpK4jKPc8bTFk/ftwURDACaB9r1AmMTJVmJJnCXNlboJOL
	t6B93lxev5214s3L/w4lVeUcrJXhxcT7DhgS+1fm6Kvx6bsNzhsYhKUEEBK/F2Yu8phnL+tQr6U
	4llVIM5YAzzSYoHHLn9Ntz3IkGeVjW9HqQIG1YYg+9GjHbuiCVU5CLW+q1acvkPas9lmi1kJFB3
	oxMFkiUBreWaI2iF2+Kt/9fKExM3cesTJA6yTPVNbmEMskh2Q5AlokfBQOZvkZzPKhUJOrTHuZK
	g+KvsdfIwNc/F8Jj19zlC6NswkvO+73
X-Received: by 2002:a17:902:ef01:b0:2cc:d192:50b5 with SMTP id d9443c01a7336-2cf349aa87emr250699035ad.34.1784716753616;
        Wed, 22 Jul 2026 03:39:13 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3147dc7d8fbsm9185429eec.10.2026.07.22.03.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:39:13 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: mkl@pengutronix.de
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	mailhol@kernel.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] can: kvaser_usb: Fix memory leak in kvaser_usb_hydra_get_busparams()
Date: Wed, 22 Jul 2026 16:09:03 +0530
Message-ID: <20260722103906.108571-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for cmd is not freed after the call to
kvaser_usb_send_cmd() in both the normal and error paths.
Fix that by adding a kfree() immediately after the call.

Fixes: 39d3df6b0ea8 ("can: kvaser_usb: Compare requested bittiming parameters with actual parameters in do_set_{,data}_bittiming")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index e09d663e362f..efbb7bed34c9 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1626,6 +1626,7 @@ static int kvaser_usb_hydra_get_busparams(struct kvaser_usb_net_priv *priv,
 	reinit_completion(&priv->get_busparams_comp);
 
 	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
+	kfree(cmd);
 	if (err)
 		return err;
 
-- 
2.43.0

