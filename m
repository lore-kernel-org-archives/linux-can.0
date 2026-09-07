Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A1A46EC67;
	Mon,  7 Sep 2026 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793012; cv=none; b=KIzy4KBDPsW4TzRHqsdHftm0k4E2bFGydIHdri4dBmLOpdErDEN8Qap7UKrGSsZj8yC3pFg+ljzJ9ag0vmktFm48VBJbP6pRHc2b45MTdfF+e2ScStXRbRK+Fi+MJC5iuH8AyIliOboO1ZC0H+pXFbFCYgSo6CCykaN6fcvLnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793012; c=relaxed/simple;
	bh=B5AhgFZJrJky9o/z+Sor1elQ152RBxtXTY0aZNtcfyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQ+b+b6SKmXro2NQNYADKr0jDXjam6JHKG3feoo3TLhjJThqkANA00+dBLMGw6HQ56ya9FlHBeL0zLDfU6leL90hu8FSNoXGJNkZYhcwjYzH11slCMoX/A77rRzTHtFhmIQvEaluHR0+EA/RNasJeBpeetJisHrCp0Ek7WpBI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=UuH+MsB8; arc=none smtp.client-ip=115.124.28.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="UuH+MsB8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1788793006; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Xmc3O0bDMU1F4U4G79tAnX7c+Hqo20CPku12y9F8Am4=;
	b=UuH+MsB8IEnukJ9OsTnbvSpVGVoK3PAVofq3flIc8lZSbY2pmKaP1kHF5cQimrYJhb1LCOgyQapAysUNfM9v0CF1cSIAnpnJij9zmqfgm+WDucG4HA8k9gA7OtR+iLJG/3Awv0xiyxEhvuobPU19jG6MGDTOztf1gTiddwEHh/Y=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09551325|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0027107-0.000389232-0.9969;FP=11587885547167279795|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033022149254;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.j7vgRqm_1788793004;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.j7vgRqm_1788793004 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 07 Sep 2026 22:56:45 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH 0/2] can: j1939: tighten TP receive-path checks
Date: Mon,  7 Sep 2026 22:56:37 +0800
Message-ID: <20260907145640.1106170-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

j1939_xtp_rx_rts_session_new() allocates the receive buffer based on
the message size from RTS dat[1..2], but then overwrites pkt.total
with dat[3] even when they disagree.  A sender can set dat[3] smaller
so the session completes after fewer packets than the buffer was sized
for, delivering a short message to userspace.  With dat[3]=0 the
session just hangs until timeout.

eb96c58907922546 ("can: j1939: transport: j1939_session_fresh_new():
initialize receive buffer") addressed a related symptom by zeroing the
receive buffer, but the root cause -- blindly trusting dat[3] -- is
still there.

Patch 1 aborts the session when dat[3] doesn't match.
Patch 2 adds a pkt.rx check in the EOMA handler for unicast receive
sessions (BAM completes via the final flag in j1939_xtp_rx_dat_one,
not through EOMA).

Liu Chao (2):
  can: j1939: reject TP RTS with wrong packet count
  can: j1939: check received packet count before completing session

 net/can/j1939/transport.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

-- 
2.50.1

