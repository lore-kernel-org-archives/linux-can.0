Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD8A3CDBD7
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870064; cv=pass; b=iE1EGFvRot061quI22L49w8WLj/bBEW6o9LldcRz9lEln5T4iFSJspmdjz+5fYz7qqSrsSF4/nsF7WozTs8x2a37r68wZSXh5pwPFrarBo+PsE2aAMwjtZ7EVCve4C3NVTQXIKLwMziNLPB7rAqYpdWKSZwpm75p1fxXs5vt4Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870064; c=relaxed/simple;
	bh=jTT7whqRclQt7kghPv/9oOUawR4JyN6F5wmXBtdLJ4A=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=qK9f8vTRyzqvb30mKUIpqRz7BdY3Est/n2tVP1ZnOkrKqgtCS4SAMLwzilu2D409NVvqb10XSjpseKqeT5gTyGjjm5+qv09QseJQ9rcmd9dfj8Rh/v5/8Bc7wDSj4IIJWP8FVSN0MSc//CD/u/QLoa7/7UYceowv5U3AyhAVUk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=ChtBLJvp; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="ChtBLJvp"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d712281f8bso4328715ad.1
        for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 15:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787870059; cv=none;
        d=google.com; s=arc-20260327;
        b=emV2Iw8obgLXKjDrHDQTW7NRdecnARJ/SOmG4IsZ8CZ91bi7CT9QI4/nX5OjUBohuj
         1HUfXd5tg/Ke/h13qk5dt9TslzH5PTDXYKaJ06RQq7IV2wN2G1UYNPOu5wCys/KHTTF/
         UoC/cZGabjJnHzHploJA6fl7EZ39gVmEsZ1osb1p7JZ0Q43Uo9t3UQxHcePxcSHFATJG
         PVmiqoM6ZuLN7Yafh/Ytdzwm6iveF3QQXk3TguCpyapdK5shVjvmH9XsWXrctnDycDhU
         Tc528uod/lUb3dDFZZucj+7UeTMzSfYovgjMG3Fv7MK02YBNV+cPtFURSffpKcshmD0a
         xjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=DI57I51j+Focgn0V4hRZn/s0X9Oen4m8HFBxSjHiQRI=;
        fh=LpPlVtcstdjyWhj30BtgAA4nsxDDBVPXhB8TKjrPX4k=;
        b=ALoEsm8kHBfbEE8t66S+xnOI/SXGPtWT8Vz5c9usYSSApVUDsLvwwJENUsaNZKeWPg
         mhW87OKNkDh1+x7yoJaFVhrEFhQwSSglH04LVhUps0cCP/sTXlTnSoYjDwK5v0WbSNk5
         eyVB/jmkvbcjyrpHqKIR59keb/Bta8JnQRpVwQGUyqmosHtzhXh/P+m/HBqRI99Awunu
         3kZrZVLH3tXpVj7eLMcwLRERYzm+Dz8rKdqf9QZcOc0vSTC50A+EBdT8PLwbT+g/RWZD
         ZbWznVyP4CR574UGL0gP2ouJ1fxzIFseSWb8rDKih83q6Ea5l9Ob0qQ3011KQ4RI/oGE
         Cy3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787870059; x=1788474859; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DI57I51j+Focgn0V4hRZn/s0X9Oen4m8HFBxSjHiQRI=;
        b=ChtBLJvpJjalJqijI0fVeJMmO0/WqVq9h7oiSkpyz8sqVWty5Z74aoq4ebljWkaEp7
         TCmcxZOlZ9ze/zwmGrhcpqRy1WsV+x0jzdQ0rUuYxYXRy1Mw/hqZjWqA3qVuTYRs9hH3
         ZBSp9WEvQf+ezujpmFeSZipuxlFdHdIQoMGtK7zywJC9z9ad1d/iDUqNFIYaSHbT+nAf
         /f5KlIbZ8VGUf5khvm96q3vR6lcInZO7IxLdDgz+eOFFljGM4VFUjjZRkrz6IP+cF2AM
         HSxAXzKeVlewJRgRvTvN0Jl3bRWJI5hAh3+UVhVlltw1dOsRYRM+2GrN6cflMv2mRuBB
         KdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787870059; x=1788474859;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DI57I51j+Focgn0V4hRZn/s0X9Oen4m8HFBxSjHiQRI=;
        b=ekStswNq3ZZhBJih99WnX1X4Yl8GbXGH/FBxiiI+CTi+Ix3ozSItNCOQ0gLPZnoq3R
         iBq/By3vrL/fQXQoqbc/kjB3Xgry6Hc58NLuD77WLioYHXQTONSBmaJA8Dw/ddyh4osM
         ac58WXf/UG7if1vXOFgVjy/Lj2rKg001Xl5e0bgP17G78W+qFTy5J08congxJ9ttgHQc
         ApMmsE8q69zgFAjyjdlmRVJuHwGREXqjVbpwcmDq8A8UFSCmMY9jRhHxHdIsnJDdgs0a
         tOWrNxZrFBOiOD8ER5BBo67LYVsF4OakASGOBCXQg1dFRrwBbyZ7OeTHzYWjc0yspVPp
         YX+g==
X-Forwarded-Encrypted: i=1; AHgh+RqLwBZuq+2/Hlj9Bj0e+hFG1+wpLqRyX+HPw6uTvBNDOgXjM6KLgZ+EJWmSH2Q4GfjK2E9ixWfHRbI=@vger.kernel.org
X-Gm-Message-State: AFuF++l3PvXPOfTcLlP36ZKb5jU62PpsTnMs3BSZXnVaZUCwrVac3AtO
	RAjVbU/dq76dEM/uY5UO/UH6fSKytb7h5m/8YOZs9xj1497z0QRfuMeWK6ONZLXAxn8lW5EQXgv
	lltjxipmTghK9ZqzYvRk3tgkcTxBQdZ2PbsDslQkP
X-Gm-Gg: AR+sD10qSNJi23MkrGqiWfDPRHEsiwT1V1P1eGCj7/EVmfLTmMDlwPvX68CrX1eTTxI
	c+V5wpYqQ8Ovgib5m1svJXnYu3M3k4n1ntIFV3nDMKzx6qT72J0lYONGltafpD5ZgB9mwUXGQiG
	6Za/RzfsY1JDummNwRZV79hvUxkOiKw4ll0yyoHWyvkJczVnNkzVtHwUqKe4ZG35Viys+lQO/VQ
	s23re6paq6OKvOc7a/yEWt6mg+sbcVfyNMmp3n2oQyOz0Mu9R8GO2xQDL0XR+nccFEcWoDgdvjT
	aDKTcv7QqnpDPiTZ9z5AYOjGFRlSgH8A51MctULALYeyRXKxI15Ti86e1V2kEAmpICREVk9DUfR
	dwUU42v0HZvW+W5KkNp8YY2OJx3QO6Tfo
X-Received: by 2002:a17:902:d591:b0:2c9:deec:f564 with SMTP id
 d9443c01a7336-2d74df52c1bmr43303475ad.13.1787870058622; Thu, 27 Aug 2026
 15:34:18 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 15:34:18 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 15:34:18 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 15:34:18 -0700
X-Gm-Features: AcwNN1UeYwUFYJ4SEKlzJNcHonSYy_dKU76J3YshUs7BUlrXtVgNUCgLOwSuidw
Message-ID: <CA+0ovCiiEbjTc_ZirZ_PXHWFjc8SjCEtZ4p+G2jiOwaYq6nU4Q@mail.gmail.com>
Subject: [BUG] can: double free in unlink_all_urbs() in ems_usb and usb_8dev
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Cc: falemi@asu.edu, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Marc and Vincent,

While fuzzing Linux 7.1-rc5 with syzkaller, as part of research at ASU's
SEFCOM lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/100-can-usb-double-free-unlink_all_urbs-ems_usb-usb_8dev/

  BUG: KASAN: double-free in unlink_all_urbs+0xc2/0x740
       drivers/net/can/usb/ems_usb.c:713
  ems_usb_disconnect+0x83/0x130 drivers/net/can/usb/ems_usb.c:1088

  BUG: KASAN: double-free in unlink_all_urbs+0xbe/0x660
       drivers/net/can/usb/usb_8dev.c:840
  usb_8dev_disconnect+0xaf/0xd0 drivers/net/can/usb/usb_8dev.c:1004

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
