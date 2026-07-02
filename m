Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04F275AEB
	for <linux-can@vger.kernel.org>; Thu,  2 Jul 2026 03:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962015; cv=none; b=MJzZv89mTCBfOwRNGHz+av81wrTjZNnLDxdzCZma4pJC9nubg4GmRaKE+Wo2ofujIjvrNAuUpeaLf4Ydht3svEKr0v1GQgzRt5V0rTZsXnz7RG0iYm86+2ABZvD5E+6RVhos/Sf0p1TAbQLVPIWCSz5beNb0JSZqWr+6z/giONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962015; c=relaxed/simple;
	bh=qBkSu0A33eegj3nweF+Pt4Dn4p0P5+7grpAxyJwYmGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPD7zIJafaq4BxRVeu1SidmpeDX4G0W/KZqYr/lKhBm6QR4zlPW2Z7NIrCWHUIsF3VyfUfMpr+DO653JRaU63RDKmeNa8eKuRmCygXK92Tq8ObCXJOvtNDctZrx208+ecbbHeHlhdMfwZoWDMBcIK6sZ+lXqn6fRiVBQ3Anpcfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lP+GxFkq; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP+GxFkq"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e5c9211d2so100642585a.1
        for <linux-can@vger.kernel.org>; Wed, 01 Jul 2026 20:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782962013; x=1783566813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q8sR5ecN2rmpd+2Q7WX0gpqT6ByQ55CSEJP4mE1OAo=;
        b=lP+GxFkqNCji3RJGsM9ylsfvqLJH/fMsG6jy1LWJFVOX4gOIk3PWbqo2Letee28k1X
         BW6UEAHvbmNgYC1lTS6AFvKNLya6XM8iqNTYCNArTOf9XlzkGNnL37s04bL1UuGS1I45
         Zq+zpr7tXUWSbFI3UEZ8liucF78cw54igfVVC7B/uOxVfDd+7BfPAXENtT+DKW8buOcs
         1Xrtf9l+qxMLDaTvnHzamKOnUA1NoPtESS+tDyLs9ZFYOzqZQlQvgoO9usOhdqK18ksR
         Nq3c1i3gO7f680pUDZxkGDL8mWri3UQfbMZuZ+3k/5KeBemVdn/PAVX0OOn6tWowl/2z
         nI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782962013; x=1783566813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Q8sR5ecN2rmpd+2Q7WX0gpqT6ByQ55CSEJP4mE1OAo=;
        b=F/z/OcYPmoAgmyjuhXxOt6z6lEltHIk3ZHT4zar4Sl+K4v1BpA0gc6rrbnZBhkKZyL
         2cPiRwuQTyAnfswbtIwXZ/LCip6jAhKBJDS8550Q6VEa+c8OEVItHSXcfImuAXSAizAI
         NyzfjMguD/rWfni2zf+Tgsoh0I4LISy8DZKM/RDEuRmzJH43Fc8lFNmyTkFa6hLl7SUL
         O4QyKbDLdyhFLiwlsa2we35FS4weJPwehXYN+7BQX90OsrUOWN2bIyW5/tJX4UQFL8BP
         S8DR9c7ktiwq4w9728VGgPKyR1Ijr6OwCJAz4zSgugnNx0AmiFPofmh7ruR4dMe1yVwU
         CmdQ==
X-Gm-Message-State: AOJu0YyZmUKA9P+6A7lAZcw4Vm8bBd4tAobpbg+tNQbAvuhF27+75z/x
	O4aW7iOW/Slo7JeyWF9PVZjyiQc6ZpVYtRGLZHvHMx+RaiJrNae7JAh4
X-Gm-Gg: AfdE7cn2pKMF+QpJef1iAtKUrvJYAuIaOanQ0zKghm2SkWw74RO+6S3HLnAFLPEiJkZ
	oDxnoi/VMfDbxLwZibHW3vHEeEey+USdcav1F/i1oRLgJFy2J8wShohtzwpVzfxgmirG5V7P9dc
	pcjBvTtqs1k2y27/r7Pf8CQmnfPtMa1gd+pfNVCfdsdOpZRtjcWIAUvUW35mSSPYbyEaeBdA8T+
	7F5yVvIHpZWuFkfcLjyJMRMG13D40A6y9TrHTObS+Ua+Aew1K1WB397nlNLWlzBQFtAhXt/Fe7u
	8CHNpMdkR3ngpXFS7swcP+lUsTtPZfs0b+hrq4eYtk8/zMaLhr5M0BOXE8iTdd73m4I1bRy6L82
	+4Ui6kfGjlO380czVGsxGoCjvIvT+/dX2eXpjcGalePKTGDMpnpy1s6JcVwJ6vCrQn0EreDrBlD
	GHljR33uM=
X-Received: by 2002:a05:620a:d89:b0:92b:6805:91b4 with SMTP id af79cd13be357-92e78502506mr677162485a.60.1782962012746;
        Wed, 01 Jul 2026 20:13:32 -0700 (PDT)
Received: from DSKTP-14.. ([107.172.253.62])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de9a33sm17919906d6.36.2026.07.01.20.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 20:13:32 -0700 (PDT)
From: Fanbo He <hefanbo@gmail.com>
To: mkl@pengutronix.de,
	mailhol@kernel.org
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fanbo He <hefanbo@gmail.com>
Subject: [PATCH] drivers: gs_usb: gs_usb_probe(): fix typo
Date: Thu,  2 Jul 2026 11:13:06 +0800
Message-Id: <20260702031306.18988-1-hefanbo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Fanbo He <hefanbo@gmail.com>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ec9a7cbbb..512ee3617 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1565,7 +1565,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 
 	if (icount > type_max(parent->channel_cnt)) {
 		dev_err(&intf->dev,
-			"Driver cannot handle more that %u CAN interfaces\n",
+			"Driver cannot handle more than %u CAN interfaces\n",
 			type_max(parent->channel_cnt));
 		return -EINVAL;
 	}
-- 
2.34.1

