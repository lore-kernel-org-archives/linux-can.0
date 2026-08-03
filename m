Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E85B3BB135
	for <linux-can@vger.kernel.org>; Mon,  3 Aug 2026 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748486; cv=none; b=HLfHNlZtRcwXeGmDXVtgk95IDJV+Nm5yGuf5kuE3M+R/U698OboKdJAx712MxrRkQPYpF9cRJqm/8EZ284QIDp6rVmQiMmEIP2rWqTI0gritpmv8uf/SCjBPGRaWkcgzbtCZcTizqAydm4EMSSLJP/brjK5pbVeqGuGQ35Y6Yug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748486; c=relaxed/simple;
	bh=RNbayJ7BiYPsSATeDTDF5Fcz1ooDst05MNn0R3F5YAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RelJLcXNAo/wzp1q8H/G4TtcminIikRh6EWKXfwQ1PNiuL1iepFh4Qnc3qw21DMFRETa15QUBK1vkJj92i1IIfqVtQuLLgo9//W1FU9pY3JXNf++cnZdZvZvUXZujv/XkrUfd06tJ0RB4ocYxHhVHTZkfKZg9Zu4NNrZTSuJMRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sl+h8ZFy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl+h8ZFy"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d02b4c3601so34434255ad.3
        for <linux-can@vger.kernel.org>; Mon, 03 Aug 2026 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785748481; x=1786353281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OCqAMzusK2ktygAt8T0k7wPs6+VubJNUB0NzLquWhiI=;
        b=Sl+h8ZFyjtSufO+Cyo9PN2QvQJsOZtTOqqZjs5qfo5eVaOS0i9zB/d/J1dvpXJRsQg
         qAeG1bprsEIdUMGULRxeQDYJtW9Hax/z5Py+aM+VqtO9NHp/gZNtIhdKL1bdRcOLxKzf
         EsJ0pS1sRN1F31zNx1NjPRpCGH01CewxC+sBOQO9Q7y+58iRKDrLoEr4ciAezQXFBQRC
         MjYHdhAOtdIusB8Ngx66uaM/mWKiLawuxqoeUjN4cRb8tam0u9DsQZ9Tlv0C9ewcEpHm
         TdVH7vuyqdVUWY5cUYXaj37gaK+zHweMcy38DHo5xDOjE0wEd9pbLA2OAuhkMi3Kql+1
         gi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785748481; x=1786353281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OCqAMzusK2ktygAt8T0k7wPs6+VubJNUB0NzLquWhiI=;
        b=ag1aU5z/l9Yc/6ZKjtWEGlofrolm1kEylPA0mCPzJfiRux/iBl317YgF0fm3kYCzUj
         uFWhEYipvQ0mnIC5A/CBC22cDX3y1JDA2F98IOG90V7pSoC3UF0b6wUUkwIl7+lg8AZr
         2WWQKUDlywvrcuHGHVqBPuYqsmvL2DjemxpWW0JPzJI6zWcDRUs3qByZX4SgdA7eJHVN
         VLTzehFbFekSHPbZIj7VMd54p/fGVdhLXclTVFRCdZVne5vMcWXwSTogYjIzeZ25KDp1
         7UcZIwl6/NSneT6dS7IGJyARSezDpd9xN4XnA04YcRCCuZFTtEq9RlM8c0Xtm7NeAIeC
         osXA==
X-Forwarded-Encrypted: i=1; AHgh+Rp4oy8mj7ZapbaOkRxU37E7JvqnTzCrLgAeq1CCUguCXHA7BYB+dgAnePa90b5K0Lh7RVBEh5sx5lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkY3wQH5WljfDmdw6+553hoiD9NYmjkrpxbvYo5VoYi+DXBGOg
	CvMAMykkoGHUyRxfEnlrLUfT4/tKNQP9mGT25AUzalayPgcM9XgetnL0
X-Gm-Gg: AR+sD10gvbgj7WOVy49Q4x0CTQZ9hzhCcNs1NzFIq34pThw71Ai/fgjPawxhrRJ8OWx
	86velV+E9MpqpXoUPXRzqfC+Ut1IQ56zigqXSZzHTGrRJPlJV4WJFC5N/m5C45mb36J4CDamdFT
	QVEPnI3XDPJEmzsF8gSGtM7mc021I7BknUOWhwZ8KpF24QFpCrxLZO2WAKtZDpzEbyRFLzctBby
	zikak7w/MHKuA/2mF2EsBsHYEUxWMZkBlBPCNce0S/+rCQh1Hr/UsMO5DF4XXQBhtFbzveZ41+5
	f+9s5T9AkQFEXmOJxrPscdSv5RXY7zFkcmNpF9B6wp3lcl7sa1flaJ52Ri6Dj/mhPm+NIRcl0rk
	Z4Vxdup1zh+H7h4e0d1Ag4UnrVt6po0aVLNrxw2l6+bRtfBzcTVbGPJsqQQ2+dPMKyRyrUItLSP
	p4QJ0Pgom5uT2s9syh/6W0npVamhWgJ992FVFsM4u6t8kI6+7GMwVBcfT/R3Je+jZWo/jfBZF5u
	b4LMY7VrxPTDJrMOpm40VsL1y+v4TeKpNziWvM8Mtdlnby/YTFWfw==
X-Received: by 2002:a17:902:dac4:b0:2cf:8131:75e8 with SMTP id d9443c01a7336-2d05221d386mr91231755ad.13.1785748481490;
        Mon, 03 Aug 2026 02:14:41 -0700 (PDT)
Received: from C-PF5A3Z8J.nsn-intra.net ([167.103.78.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb7b7sm34546515ad.39.2026.08.03.02.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:14:40 -0700 (PDT)
From: Sureshkumar S <ssureshmsd7@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sureshkumar S <ssureshmsd7@gmail.com>
Subject: [PATCH net 0/2] can: bittiming: fix two defects in the userspace bitrate conversion
Date: Mon,  3 Aug 2026 09:14:24 +0000
Message-ID: <20260803091426.29050-1-ssureshmsd7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can_calc_bittiming() converts a userspace supplied bitrate into hardware
timing parameters. Two defects in that conversion are fixed here, both
reachable through IFLA_CAN_BITTIMING on any CAN device that provides a
bittiming_const, and both caused by 32 bit arithmetic on a value that
userspace fully controls.

Patch 1 fixes a divide-by-zero. The 32 bit tsegall * bt->bitrate product
wraps to zero for bitrates carrying enough factors of two, and the
following division faults. A bitrate of 16777216 is already enough,
which is below the 20 Mbit/s CAN XL data bitrate ceiling.

Patch 2 fixes the candidate rating, which applies abs() to an unsigned
subtraction. A wrapped difference is read back as a small error, so a
bitrate far outside what the controller can reach passes the 5% gate and
is silently accepted instead of rejected.

Both were found with a netlink fuzzer against dummy_can and verified
under KASAN in QEMU. Testing covered the unpatched tree, patch 1 alone
and the full series: bitrates from 125 kbit/s to 10 Mbit/s produce
byte-identical bittiming at every step, patch 1 alone removes the oops,
and patch 2 turns the silently accepted out-of-range bitrates into
-EINVAL.

Sureshkumar S (2):
  can: bittiming: fix divide-by-zero in can_calc_bittiming()
  can: bittiming: fix bitrate error calculation on unsigned operands

 drivers/net/can/dev/calc_bittiming.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)


base-commit: af39eb111ce6b5eba9c08513b62c4868eb7e7fd5
-- 
2.43.0

