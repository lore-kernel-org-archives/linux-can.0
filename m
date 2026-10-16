Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6E44E042
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144661; cv=none; b=XB+BbFwD0TZtTW1fKeVEVYV/ggIQw7pZ8paP9uBvInCtwAPmU5HtfJ9RX34omSaejUHPLPcgK9kxQNm+xF77CpqEFPwz+9VvK/E1s3KQ6GeJcfp0UQ1QtKMMfvc2lFX8bD6dc4/p/jt+d6S+knQ2/J8Bse7yZK8hm0/NwSBc71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144661; c=relaxed/simple;
	bh=Zcs6tKuWm2/DGMhaMXXZbLjBCcLLaptFct2ql2IHJQg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EUhJ09l59Ek2WcAEJ4jvum3FvBB3NEVfG9Ok90SlbTCyy93zGFw6+zNx/Fk0FgfbypafZet480tDp/+qs49P8G4ADe4W/Ar2BzzZNepWDQkEjpFqyTurxk9kO+SArSCSjvBRPENp406GOrvcyUMib7CyoyOhRKqqEnhFL3Krv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Sx0Blv7l; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Sx0Blv7l"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c4d870d54so3959679f8f.2
        for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792144656; x=1792749456; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ya1tsXzQ6mk3VG6jxM9Qg9qvX/WcwUYUuy//xA+G4uk=;
        b=Sx0Blv7ldbDKgnQKV9qRD98L3LxwQI8kDKMLhCu0dXRBAZPf0NJym+D/s2SvC/OMEF
         Ujp+ciHLSJaWU2+EQLOSZwQ3W+W4FykNDQxbISzDd6hGuKXUOJy/be2oGgbcvknEKcf0
         0G559yNAGlr8VC/blD5e8T76PBLgE26O5YVfHYZhuRPMQGt4eKDTVYJANzgVGsc5TT8t
         TyOBUHK4FlYfLKk4OsIp0FQyWA2b/Qo7eyp2G2qKeZzRnOSHnXSDcqS98iE7+UX9L+Ov
         2tdtqUNq/+8VUX11XA4/bwI6hlKrZlLPqtyiQeZxlwhd+XEDWJoqNk11narMVsTRTGW2
         pfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144656; x=1792749456;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ya1tsXzQ6mk3VG6jxM9Qg9qvX/WcwUYUuy//xA+G4uk=;
        b=BUvE6HDXtZ5eQH0yaDMX1AjBNUlGug+jxzJtM3xJYpoXkICtb7KkgocCJQYgpv7oap
         spAKTo48bPtxYiu0/R9/rZeqYj3VWHL6czRUZqe2LIsBBEVOpTJTUKiBB+OWtUEZt+qg
         yMqS3bcLfTSxvKIN0JFrt4jRzcF3PQFh9Vna5lu3X+WVI6xF+5jgyq1hcq4LdyEgmmgn
         KP18Yvy9IslSKFTgJzzgt2Odf8bB/9jacprYkxvLXB1LxWSZLKpPV+Uf4Y3E/I3fC5Yx
         DLlOM8R/rTlnBiP3HSvqjOkV/RWlle+yZpOkfOi2VutFx3fWswk5vv33kvzM9qn8gtc0
         2Asw==
X-Forwarded-Encrypted: i=1; AKwUvBzVW0/RHo66g1yYl8UyJhjymIEg16S8qBLl3n0Kh1Adxhn7ujWV8v1eN3BqC0klQZff1ffxfTUzuw0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqywUUiuBeimik3WZfjl2RYnSzQljvfJdnjxMI7m6+LwjMGFIS
	b7J53Q+bit16yuFiEPZDsE1+H+rX/zNARY9DE/FhveExbnWjVkg3dIRcT/GPkc0S0YA=
X-Gm-Gg: AYBFou31NxVWLtsnCPVHF7rDHo3E7W7+WZD03bFav7hCBNO66CoCACpGgiuKVOrtZWY
	r26rX6smr7/MJDWQNg79wJg+kQ3+3D0QWESkWtKsl6dQiHLpZaszgPbtJgzWm7DbTDL8xAGEgh6
	8ozYXGHYQhDnt5ejYcMmHUeEwQFV3WebKxgo7jyXIM17e05Z3BZNS9/ObenzKsyP9Clji8e7/qB
	Qw4lJtW3OHhfHk0Txgz6Zz5qwRFzAvmXJiiMwghoQw3e6OI8ZTXpmQXcxJYeIzqT5BKEck1U7Y4
	c5O0z/H371HEBzG+elXmwQpfWlo+Y/hwgMOolGfM3XBmcrgAbYB1r8/DFUFTY18ICX9TUvW+Unr
	YSk/qr/rTNWKMHP9lXIIjdZtOgjdUadkdnM6s5t9xFIPK+NFk8spQvGrYdgFKxA4AQSomPfb+FE
	oW8mbSJICCv10LAAieUlv8MOipyx2t7MXGYJgH71nGK/pGNSQWMiXPa/lY9yGRvzeI53Q=
X-Received: by 2002:a5d:5848:0:b0:48e:390:80cf with SMTP id ffacd0b85a97d-48e03908148mr103784f8f.32.1792144656011;
        Fri, 16 Oct 2026 02:57:36 -0700 (PDT)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd510ba3sm3959893f8f.56.2026.10.16.02.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:57:35 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Subject: [PATCH v2 0/2] can: m_can: Fix suspend deinit() error path
Date: Fri, 16 Oct 2026 11:57:11 +0200
Message-Id: <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-0-7efa2b172cce@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPf00WoC/4WOQQ7CIBBFr9KwdkyhaIsr72G6ADpYjEIDLbFpe
 ndpjWsXs3g/P//NQiIGi5FcioUETDZa7zKwQ0F0L90dwXaZCSvZuRSUQ6qhgtEPVsNLSwdxigO
 6Dox976cErwQTXWPQkLwyBMzxbri1X46TeqAet9mt0ds4+jDvLyS69X625q8tUaCAjBtZl7o+c
 bwqOT+tCnjU/kXadV0/RTFhOuMAAAA=
X-Change-ID: 20260914-v7-3-topic-mcan-suspend-fix-fix-b943929d8fef
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Sean Nyekjaer <sean@geanix.com>, 
 =?utf-8?q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: Kendall Willis <k-willis@ti.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Zcs6tKuWm2/DGMhaMXXZbLjBCcLLaptFct2ql2IHJQg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyLX348u3dT8Nuc3Qs9/vtmuH8POyamPWfH/50ccqJzq
 naX8O9p6ihlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJdCgxMvRM25UgIRsV4uO3
 d9WW/EkMHhXtSeG3L84Q9Onsf9Z22IeRYU/CQtbrzx79Vm2Xnu6ZN8WpRy5eL1Po6NsjHJeWFHT
 cYgUA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Hi,

this small series tries to make the suspend error path of m_can a bit
better.

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
Changes in v2:
- Add a patch for tcan suspend
- Start the hrtimer if coalescing is active and suspend is cancelled
  instead of modifying active_interrupts
- Link to v1: https://patch.msgid.link/20260918-v7-3-topic-mcan-suspend-fix-fix-v1-1-e24fa70c754e@baylibre.com

To: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
To: Martin Hundebøll <martin@geanix.com>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Markus Schneider-Pargmann (1):
      can: tcan4x5x: Add suspend error handling

Markus Schneider-Pargmann (TI) (1):
      can: m_can: Fix suspend deinit() error path

 drivers/net/can/m_can/m_can.c         | 25 ++++++++++++++++++++++++-
 drivers/net/can/m_can/tcan4x5x-core.c | 11 ++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260914-v7-3-topic-mcan-suspend-fix-fix-b943929d8fef

Best regards,
--  
Markus Schneider-Pargmann <msp@baylibre.com>

