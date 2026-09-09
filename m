Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345123955E7;
	Wed,  9 Sep 2026 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977168; cv=none; b=JbLUg1YYN77z+Zepywh0Bzi/NPyl5wJBZIJDQSw2kbBaRMQ6Y8zenhFBlDsUwSJUIAyAcvnjMYp7pvf/z1AaIDhvKe3o9RcNHxJRzIHZGols+l9fFgAmFXFggZzyzPWfZ/BIkc54GoEZiwulrbuAbBP5H3B8PdEv8F2t2JhgGtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977168; c=relaxed/simple;
	bh=9E+T9hOgRu29T+NHLrQVye5P8lcKnemzwLjrjnZHf7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omvgA52p112u3Pp2VJfkpqrl7gW1lrO6IItIDa7ry+/YM1hJ/1dPrwGyPopjPf+VsE5SqEcDG09wZqzMeb7Jag9gAHJDdY9pImDmuLrI4DTpT6E+lquNpzlMg8tCFgxLa3dd98pOWXFjVgsPPFXu9j9GYktEy+fRv+jOjumur44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=Jlky25kn; arc=none smtp.client-ip=115.124.28.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="Jlky25kn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1788977156; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ilb6MMd8fuWTjBsaIfpa76cUkFI2nh511CWhQTWNKSA=;
	b=Jlky25kn46+PUDCbssRE+YROtnmqBPF9esHV5Og/m6I3wzC7RggklIq6lbwYU2E0Zf6n8oZwLZ0gV4jdXUqhbp5ReEqGumR97u6TQ97gvpwoNdf/qf3nWtvhz34912FNfpKOgtPBy2Pmf51hX7V6VFdtPXasIKMs6bK40bo9m2E=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2790607|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0106812-0.00285087-0.986468;FP=7551090251449564603|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.j9rv3mG_1788977155;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.j9rv3mG_1788977155 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 02:05:56 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] can: j1939: check received packet count before completing session
Date: Thu, 10 Sep 2026 02:05:54 +0800
Message-ID: <20260909180554.365350-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260908145715.D70BD1F00A3D@smtp.kernel.org>
References: <20260908145715.D70BD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Addressed in v2:
https://lore.kernel.org/all/20260909173105.158202-1-liuc63@xiaopeng.com/

> Does this inadvertently suppress the diagnostic warning for EOMA size
> mismatches on transmitter sessions?

Yes.  v2 emits the warning for both rx and tx and gates only the abort on
!session->transmission.

> Could this error path cause a permanent leak of the session structure
> and permanently block the SA/DA address pair?

v2 returns early for sessions already in J1939_SESSION_WAITING_ABORT, so
the deactivation timer armed by the earlier abort keeps running.  Same
failure mode as 1809c82aa073 ("net: can: j1939:
j1939_xtp_rx_rts_session_active(): deactivate session upon receiving the
second rts").  j1939_session_cancel() is fragile here in general -- the
cts_one and dat_one cancel paths are still unguarded -- but that is a
separate patch.

> This is a pre-existing issue, but looking at j1939_session_cancel()
> exposed by this path, could it trigger an AB-BA deadlock?

Pre-existing, and this series adds no new locking: j1939_xtp_rx_eoma_one()
calls j1939_session_cancel() from the same RX softirq context as the
existing cts_one and dat_one cancel paths, so the reachability of the
cycle is unchanged.  Fixing it means restructuring how
j1939_session_cancel() cancels the rxtimer under active_session_list_lock;
that is a separate change.
