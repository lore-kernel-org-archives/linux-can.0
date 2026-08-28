Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB0E38D407
	for <linux-can@vger.kernel.org>; Fri, 28 Aug 2026 03:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787886957; cv=pass; b=gEhY3Cl9PolF5d4vfUw+hecsDKP0gTbQe98Z4OCZz/hXrDiCig4oWNoLsZhDfE/pPoyqPTWGu8xy77u2HaZx2qKzuEMeIcjNx5syl3rF/mi8AH6MFnj8mbN5MlWfIkcaeaWRKHG+YOTn0ewFNxCa9rUXT213ENTJ1/NvidhTnmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787886957; c=relaxed/simple;
	bh=1miJQ3XU67QGxzaMp89AvZFl+Okgcn5d5LRthW/MVn0=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=ghw+UOslhOkxSiTSgP7wkRdctOAtJar92qKQZtfghbuCOAJ4MBLN+VhS6RKP2gzELl1z+Y3KfaSkV/wUE8GhD3eRYtIs48FidhAELjsD7GpIyJUt2tfFw5cCOfBuUVQRz1LcsPX+jgKK73WnLnhOHEZX3aqxlPTbqSGsHdXciMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=neBLinKC; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="neBLinKC"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso3675365ad.2
        for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 20:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787886946; cv=none;
        d=google.com; s=arc-20260327;
        b=moE4k8rUosGSugRZcZ6cUTcRbGObhx8sDOC2sTW3KbKFARfTrEXlgEIXEavTuQR1Rz
         vWTOtKSp+UbwEvDrwcpBGsSEA4iquWH8wJE0CxW1wjDVp4x/sRzdlcb+yUQiewWi1/so
         lB2o+1WjDcuk4Kx39b6IsFF2/9pjqQ+Dlb1YyTS8sdkxtb0hGunEMINEP3WQ6cUF+pPz
         ADzJloggdAZXCDmJX0M3UZE2+E8TuxiINhdKoYe267KVxrPj3YuAo+tcSwqfTwzEL8O3
         s3kfbrKzMtad8sIqF3cBXff26mpDujN8KHSlzLkQvB0o38TTa/utALD3+l3icV6NF7fW
         xtXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=GVDaim1d9W/nazmbFLIR9MFq39kGfUIj6rnd22ExSQs=;
        fh=suITxOd12k9TP1X4j/6sOHU9SCsTvb4DzpdfQKrfPIE=;
        b=mIHE07kCeOuUot4PoKI28aLgJI1gZSB6FHtwaw+CbUA6RCxexioUtUIHB2N0FvwnJg
         rG7sJaRDvYLSZjxbNCi5axqz2n6cZh80V/tJ8jSgLIKA7TLNRWDss3pp3C3zWVFIrNc5
         +6SqMMOu3mOsiffQYyhsRnYMdcdK4MoP1GF13wgC0kV5Nk+25BpqeWX7mtnAdq4YX4Uz
         Gf8lQMpAnkobi9B1K7+Wum6sej7FS2IXj1eHPuy800hAxMvjTVV1EivcRhDpkLcRc7eo
         5/K+5I/HS7tqLv1z1HhOVrFAu2VxABZb5jUbMxe/fC0lYxx8Ai/q1sgV7aW8AIrYy6gD
         dAYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787886946; x=1788491746; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GVDaim1d9W/nazmbFLIR9MFq39kGfUIj6rnd22ExSQs=;
        b=neBLinKCAT+MANInucguTZWim03AHHpj+bO5hrp1IvLBqrDqUNUFIi3HnOaTacaN0A
         BSzXklUQ4ZkMuoCQMMC1lMD6Z9kUCHgKc42RAoR5TFpM1yoO7fcRWDUrNPjBVTM6DZgS
         f9pR736ovN7AgX4QHJLr/jIy/9n3RuQMjXyoBiC0FAfBQ4XDeHTPVwFpKTfJZm9Uhmyl
         oSZSmRPMDpfNEx+H81fNBdQJlHL6B6x4qrzwEziyIcS3ATYAE0coIpFpwVV1vQaCoQGy
         VWPdTrA5jhiBIyYE7+jTp+yJZKCVNcByX+LTUgxVRmyjjNtdtjNwNNEi9gNioNv1otMp
         5d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787886946; x=1788491746;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GVDaim1d9W/nazmbFLIR9MFq39kGfUIj6rnd22ExSQs=;
        b=IwO4cZQkxDAbELCma+2dSG+p/WXI0PDhlwZEJiCzND+2/V2lRYFqAKs96mo5nPzHoN
         F4Rm3a0EZ+kNzP3EoXMZ1Ck68DeZ8/UJSDCwDMOLd0gJBGtCUwoSjt26lw/26ZpQetsZ
         jiV50yfrrJNcotHscc+WCblqmBss1NDhypbsv6u16bTxHSC5NKoNAfEYt3+wLUBmkdV0
         SSBOfCuqdd1zokvKwiv4bjPWCSwwcqO3dVHMWIAaPPyU3+skZIMj7gW7unQWjM2+FKFm
         QVEpWAsAwLrQmXgRtzOiE0qDW7CFpPZH3oXEytlBdyHjGd8TWARYpyLe4mo7fvS4Qf7f
         tuyw==
X-Forwarded-Encrypted: i=1; AHgh+RqKYa0mCD1Fs/5Z4tOh+zgG/V7bgMqxUa5XxMeSO5m2sGhTD/4eDUjs8LK+Al7m4KUnvkm6ETo4M58=@vger.kernel.org
X-Gm-Message-State: AFuF++ky58A2g1wEjTdVOoAYaKDjbz/dI2i7FUowmS2qCavCGTvS8f8B
	OivmnrASyAjvUeVe9vl+wz+dTBL8EURoeXHibXllTftGtaDUW8kcOJlLa7MTntqp1rfJF4J0RCS
	GMO9z3ejuIBM1yLD07Li6OvkLCQYCvT+eYdsRmaDk
X-Gm-Gg: AR+sD11xSTB0q+HH8Xkaf20u+N2dmkKH1Zjxl+mj42KqgsREdDpL/WiVWKVMTlTD1IJ
	7LZtTV+hFC66ZI3rQcOhBL21l2efuz2cPaChrwlXD5C54biNWll04CQjTbrWEFybaLvVmjapUHU
	NoNRaZx5HPgsNLRFrjUsJnydvWG5byoMrSvIDO7f6tDzl7pf3b/Xk+XIOEGFksx07gL1RcBjoGd
	+umD2r93eUOfzv+klEBVOFdrUtweZNOTn+oGtOYtBKUG5aTLZpFar6IvbBMiDy6oE9B22jWQKTH
	MX4OuG/BAf+vpELy94UzpL0MtXj8ybJpXQpkZcx0QtGx0+pC4H88mYs5ZNz21rbumTzxztPqx1H
	fgzPQlMswPmtK3G2WwIB+EqKUdU7UU7kQ
X-Received: by 2002:a17:903:8cc:b0:2d1:1a18:4d0a with SMTP id
 d9443c01a7336-2d74ddc4043mr72395145ad.9.1787886945097; Thu, 27 Aug 2026
 20:15:45 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 03:15:44 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 03:15:44 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 03:15:44 +0000
X-Gm-Features: AcwNN1XK4N9AZ5nSdtzZJJ7gOvoMbccpDuyxz4tcgDKwL6eXRIcA7BljFOFKVRY
Message-ID: <CA+0ovCjbbonrZ-eWsjT6r7VhBaO7t8M_HCYwWzU5XJDettsd8w@mail.gmail.com>
Subject: [BUG] can: kvaser_usb: WARN_ON(!dev->cfg) in kvaser_usb_probe() from
 an unhandled clock-frequency encoding
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: falemi@asu.edu, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/123-can-kvaser-warn-null-dev-cfg-kvaser_usb_probe/

  WARNING: drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c:989
           at kvaser_usb_probe+0x14a9/0x15e0

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
