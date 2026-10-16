Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EC839D6D5
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131129; cv=none; b=s42A9Ortfa0JtRH53FND/59FyfQYisEaFMSnHxPgyDVLuA2f/SULqM9tZQw2PtKH1x4RPOzDGC4Ch7ofNo65dNiKC1hiqqcMoX4aouC7xk/wo02DXxFpC6ak95orpqPLIruHUKJCtkytmNm0pdJGZqrqBXv6LGY+wWFZwsVkOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131129; c=relaxed/simple;
	bh=L9ZFiyAFmPsRderO1/Rh8bWC0nqqw4eZS58Lu9GM2YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+RpxQrVcMKJtOB9zN63YwHCYQSRlz32AHRpjw0gL+KRrrOjfCCRtzalGI+Go9gfCRqKVm9xZs9BKM2saryik0Sj8i9HtSeqTguKiDRYsOKw+/mZFiYE4CjIaKV82dTDC19UokWFqcobjo8BPrFi0Jyu+lbbdj4e4BA6PJc7rtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2DX4C4K; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2DX4C4K"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-16079d54c17so296529c88.0
        for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 23:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131127; x=1792735927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8JY0PAJ8qLoMlN4L9aNAG6FBeK4r0HomK4GOKTTjBOY=;
        b=V2DX4C4KC5EgOE4gzbxBD1swceF+drPnKz66lXurb0IRsJgwq3aAMjt4UTJQKxKQFz
         Jlze47oOKwp01hhH1fk26x9kVNgT19HCKIQIMApaf8bauH68i2a40aJEdBo8d9LhMIGk
         KMFxVRmKW2KQKwe1n8yVCPJJTae4eY5VLX/kzBr6BC16iE1PIvOsbe2L2IBU1QaYy/dG
         gjImftdhKoDPXFG2ymTA4tp3sr5DmlER8ibI8jiGcvnm9129YEPNYgN3cjqOTLvt2miZ
         M54+oml1P215mN6wAvBW3VK56zaiiGEBl/p7IajwaoYpBQK60L1/TIUWUPPOexKI1huO
         Y/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131127; x=1792735927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8JY0PAJ8qLoMlN4L9aNAG6FBeK4r0HomK4GOKTTjBOY=;
        b=UbZvwIFq71vlOd4mrZz7gM2+/zzKLOJOHo3AkcQomBzRnzBCCtOMThoccHpA6X2sts
         9dQmxz+hB4hjr3xRvOmELZlP48mviXFJFUsmlEJZgtMEKkwy7F1N7L/hIcWr2ktwgOKh
         YQbNwa45ojYCLyAmej2zahGNo+zuczxhYZI3rsrF22JYEGLo+ctNFUeiTI1ExfG6Fop8
         8geS4+W73BWW5rdWjwp3OVT3Uym2aLrFiQAs87ckyNFZQzDzPsi3C7MOq1fYRANdcFb9
         GIRHEpMmjIFsRXNeydhuEn7lhuTU/76p7Gv2wKXWiwRzNOtf9wdNitKgI1TfRIxGe+kL
         1QMw==
X-Forwarded-Encrypted: i=1; AKwUvBzIDUq4kHRbfXAi6guJKjRMJ22C3ICc0HMwLs6wyXYoQIARBcxIv/l2U+oiHpDpZIdA9tMbpUKYHpM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUyJshJBwOwcdgAfjATYflAZf2zJ/khhpLzLQEJPl1v+z+2QZp
	hlgbL5ip2F6c6R4kTokpaklg+JBo1eUHWwgRvDojZ4wRjbF6+KF+NOB1
X-Gm-Gg: AYBFou2lAUTU/5q+bs7wzXkWxZvKdgs26423eEFX2X33rAbx15nZKnyNlCgEcFUsmSE
	sS7AUMKrmErAsyzkR35udbnACR9oFmrUSonsioKGTI35IFtshIIK9/VIcbcnLYD3aJW30Fr2sus
	JDeTe7cTN0VLa9KkiAuHWO5t88FWBnYRIDluU3Ooo2PnRj7T9Ml13wLoU7R0shEEs95N/SbCTyJ
	I+ikm/52l44m+7mp1n/Xsz+8sLW61Bg8wncnETIGMdAH+XlAkkw/hsoAsZdTgQXZOEGBB8GGJqq
	uTVMSa7JFFY8nngE44p5/VBnnAIlNyOiDzaQlSkB/9lV85d26iKtvDJl8f47Oas4MY29e0biiS/
	PothaH5+RnYv835cMFragNl6+hkRUMtQ5GfgbiHVpRTQujRXX/7vluzb4OGu3KmkfAfyh0IEBqY
	4OOwUpPnduhUuWcQnggAeiIoUd+CXqCC4BiAUb7prJXMlKspPjAM7gkwa1Jlct1N3kh4TlzLYSi
	adlb1Sl0zYO9GQsfX8TI/ogPsq1eTkPCuK03Z7VeSZOtfQ=
X-Received: by 2002:a05:7022:ea8b:b0:145:287:ce91 with SMTP id a92af1059eb24-16a5c6ec19cmr28597123c88.14.1792131126858;
        Thu, 15 Oct 2026 23:12:06 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm3755480c88.13.2026.10.15.23.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:12:06 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] can: janz-ican3: don't discard the IRQ lookup error in probe
Date: Fri, 16 Oct 2026 14:11:38 +0800
Message-ID: <28add8d0570b72d35c65c19b2365007cf0aa15c3.1792118040.git.chaosheng.qu.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
References: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ican3_probe() collapses every failure of platform_get_irq() into
-ENODEV:

	mod->irq = platform_get_irq(pdev, 0);
	if (mod->irq < 0) {
		ret = -ENODEV;
		goto out_free_ndev;
	}

Return the lookup error unchanged, as the neighbouring CAN platform
drivers do, e.g. commit 057bd6168d98 ("can: cc770: don't discard the IRQ
lookup error in probe").

This driver cannot see -EPROBE_DEFER and the change does not fix a
deferred probe. The device is an MFD child of janz-cmodio, which takes
the interrupt from the carrier board's PCI device, and the driver has
neither an of_match_table nor an ACPI match. The probe should not invent
an error code for a lookup that failed for another reason.

Build tested on x86_64.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 drivers/net/can/janz-ican3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 1efdd1fd8caa..a65326b0f11e 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1944,7 +1944,7 @@ static int ican3_probe(struct platform_device *pdev)
 	/* find our IRQ number */
 	mod->irq = platform_get_irq(pdev, 0);
 	if (mod->irq < 0) {
-		ret = -ENODEV;
+		ret = mod->irq;
 		goto out_free_ndev;
 	}
 
-- 
2.43.0

