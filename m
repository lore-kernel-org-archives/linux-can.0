Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826D2882D7
	for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827485; cv=none; b=nich4H1BGxFAAGFVJIKGjOvFYxHoHqbMBE9kedYowmBnM91wDxBM/RwCCnBnVbBACAb0jM3czM0e/0884Z+PQSJMajNOM5fRi63NVEipSA6kqs0Pw5gAxcuF1+GftVjl5vjUM+VxHeUseigZKR+RCgP2rTl20b8FZV/NxNM7g2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827485; c=relaxed/simple;
	bh=PgojFsD1/N3BmrsVTkPr2gfq4qeEOrZIF9naADyS8pU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okXwpRJrLacGQPrdRGzbVWERsYOIjuJFWmzPy+yBzcwaaDD/wY6xwnxiprCweTsW9pdEu+tacaJyNHJ0P+zDX57XEfjEagDcybizLXGzoUEjypvebGRJw5FJ5Otc21J3FRnJQ8is6ndu9jmyvNIPXBzMb79wNHrWiZS4YLGoFws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqvDthPe; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqvDthPe"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4745492ed3aso1359723f8f.1
        for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782827482; x=1783432282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXI5HLrGQCJ/qDQSn0D2WY2pyWpMCSDIiJq7g2CIyqQ=;
        b=AqvDthPep5EtWVZnDh320En24EHekwWnPrk7e/vTya6lsvlnlo2h3vYmWBdViymTJ4
         djISsTl2DmiQ44O7yFMT1TJ8aMCabQDDwys22mf6LJ3OIxHqIF4BU258TuS34fRlGamM
         phXiKiygXaPekefBB6AT15x5LptkfQxIfmZuA28fecQJnK9CQHv5BZx4I0dahnE1cgEU
         GVsWLBwhI09kSsBFot4Tc9ka2TYyNtJhA9+KOJc1wD2SL8cK4SAWtM6b40xDuVxWb5LW
         pUUPxz+sYWPOLASmkXn0kQIEoM+6pAgIAGukb6Wum/KId7du8NQyyZozF/ddEz62KdPF
         8vSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782827482; x=1783432282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXI5HLrGQCJ/qDQSn0D2WY2pyWpMCSDIiJq7g2CIyqQ=;
        b=GmyjPeqPkr8zybN3v2J73lFg9dLHmzzJ990mHe2ygvZ3siG4cJqJUM4eEKZwB/eR2w
         cvrX0cLj94HgVzrVHH5M5YyOibSlBux/igdkDLn15ukomzcfinSxzjI0sYHPa+N/B79e
         t1BQqWJGeXfBoDSCXN1VXWJIj09ftRQzxXbgvI9y9IevURfVHNBA4+0ShjfmNOJu4ED+
         +U8M6d8hvW5ufR6LKMRiE1MeGG5249MnP47mUAiTCu211w/VBx/R93R4N5qGLwEi/Mz1
         1/UmELDzY1kNdIXkfw2dz+v3yHeS8t7RZmJWYjfPSOJL9kzhPXaQ/G+I6vG5FupDoiu8
         I9FA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3dgQA+PE3qsvrZSgyzlIqodJaz2hwKqG3jcEzxEjvOxGkqg96NfBNkG6Gq8WtZsSE4Ou5Y8H5Wow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmVznnrvyly7D3C/rbXgdhYptITYdTpyhhfoRdcKLSwTY85bTM
	HcKYIWNRz+rWczvFJ9DXvTXux1/M37qHX49VcLtEkcv/WL+AUSau+Q/l
X-Gm-Gg: AfdE7cnStQAoGS/vmXJhuV3KMXCpEX84Afpwv7/9j3j4kmdNamQ+ULbpRVQ67HMlrGP
	xBZ5GnAhXETKIQ0DllgHSMWWVAIBRe+ZfJzQOq5NlHZxRqMRE798Vsn8sdXN14GyIrs5VHuCMPa
	2CaCzXwBF5+333a12dQwY9yHq58XIDo1UxHTyy9v8T3cEc4ceMKFShiwBuCj2Z8tgRhiob9IewA
	4rJKuYyDPF1NllDsa8wQ3OxQYptDujyoA52XmQDsO+j2/lotJOVs6O9ghV1n1ncX325YnJjMoW/
	yxjXMTUE5sKSREVa2uXHKVcgz/NzD2ROZovswXfaZo3kURP07FJ7u9dpkO25gzLjMyi6hS2lNts
	1h4n0/1A02m/eAOuYHg3FasChF6XPIKLB9OwaBJMCFf5biRnCFWSVKYLx6xViVMLyvjWet5X9ig
	gQG0FBMnli6b4xgeb9A2tPD0BHRMZP6v9gVL31Tw==
X-Received: by 2002:a05:6000:46d0:b0:472:7dce:d8c7 with SMTP id ffacd0b85a97d-4765b608f21mr647635f8f.36.1782827482164;
        Tue, 30 Jun 2026 06:51:22 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf26sm7216964f8f.19.2026.06.30.06.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:51:21 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Tu Nguyen <tu.nguyen.xg@renesas.com>,
	Rob Herring <robh@kernel.org>,
	Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 0/3] Renesas CANFD Fixes
Date: Tue, 30 Jun 2026 14:51:13 +0100
Message-ID: <20260630135119.104774-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

This series fixes the pre-existing issues reported by sashiko[1].

This patch series depend upon [2]

[1]https://lore.kernel.org/linux-renesas-soc/aj2PBvZYaVs0G-be@shikoro/
[2]https://lore.kernel.org/all/20260625135216.130450-1-biju.das.jz@bp.renesas.com/

Biju Das (3):
  can: rcar_canfd: Fix dangling pointer on channel probe failure
  can: rcar_canfd: Fix double-cleanup and unclocked register access on
    init failure
  can: rcar_canfd: Fix interrupt registration order

 drivers/net/can/rcar/rcar_canfd.c | 33 ++++++++++++++++---------------
 1 file changed, 17 insertions(+), 16 deletions(-)

-- 
2.43.0

