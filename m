Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE63AD526;
	Tue, 28 Jul 2026 05:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785218330; cv=none; b=rOEJ1fwqC3TjN3i/lPTiW7npOFndOWvvgjIiZ/B++j1JhUaEEiJyx7NdS4hWafV5FZ4Ae1W1yWBhwublTlkGSi7XbQbrff91AEpJEXf0/pPKIZLvhBPSuwshUbyUP/HnCi2yWEhx0laXxaRslBaKtg1i4AEWBCTGuC6C+RlO8pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785218330; c=relaxed/simple;
	bh=8R/DA/hJcIgQz7+toA+rRrZwxX9RzjB0WHVVuF8Kqd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tR+4LdbdNFXproJjuBJ16i1bcIybESG/oHfcWav4HNkHTKvFMAaugWoUmWS425OtHcjYavTiRlUk6kCHxXh8Vw4BSWWMTzuadvS1wU4EdiFRnEDsdy9CMO6R6rx+Ayp6BYmIYvifaV5ALf6g+dTmiDhwrL51VGJ7DBuIgAMTw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 210A820113B;
	Tue, 28 Jul 2026 07:58:37 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1woapp-001feG-01;
	Tue, 28 Jul 2026 07:58:37 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1woapo-00000004pdo-3vmq;
	Tue, 28 Jul 2026 07:58:36 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH can v1 0/2] can: j1939: resend lost patches for buffer init and netdevice tracking
Date: Tue, 28 Jul 2026 07:58:33 +0200
Message-ID: <20260728055835.1151785-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series collects and resends two j1939 patches that were previously
lost on their way upstream. They address different, unconnected issues
in the stack:

- Patch 1 prevents residual data leaks by zeroing the allocated receive
  buffer in j1939_session_fresh_new().

- Patch 2 implements netdevice_tracker for j1939_{priv,session,ecu}
  management to help investigate a dev_hold/dev_put refcount leak
  (unregister_netdevice waiting for vcan0) reported by syzbot.

Oleksij Rempel (1):
  can: j1939: transport: initialize receive buffer

Tetsuo Handa (1):
  can: j1939: use netdevice_tracker for j1939_{priv,session,ecu}
    tracking

 net/can/j1939/bus.c        | 2 ++
 net/can/j1939/j1939-priv.h | 3 +++
 net/can/j1939/main.c       | 8 ++++----
 net/can/j1939/transport.c  | 4 +++-
 4 files changed, 12 insertions(+), 5 deletions(-)

--
2.47.3

