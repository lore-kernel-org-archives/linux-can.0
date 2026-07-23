Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3FD3DCDB1
	for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784791840; cv=none; b=pjXwDs045UfNgn2R6MwMYrDYlHZ6X+vhZRRd+7upXruc/EYj+UUtfV5q91+GdivsC5dK1P6rpPkoRE6GLL0kLU1vuRpfZVNfVwLlRD18FYr6sIKcZ1pEHUVN8FkQP5YxTYa2cl9b7nSGKXsVQPlkuekL7So+E5ve195vr2FJ7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784791840; c=relaxed/simple;
	bh=XLOtuUR2hVwp71LUQ22QendaweQswhhhg1b7VpgYs+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J/vDTlgyQXLJEE/sjljt1p/olgUCTgllC03u7wEXjLa/gGsU8cQHY+FFTF9lEv9vGQ1rFGNGNVkkmOHKABxDAXPLgZjQuQWv/JFy7TxSMTZYHtzFH/9BzLEZqFmNUk7IW5dHKSO1t9Qxxuoz8/ow5C+I3BsFPeb0x71xHy/G9DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=G4P+7Psc; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="G4P+7Psc"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id D8FB4834AE9
	for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 09:30:25 +0200 (CEST)
Received: from stf-laptop (unknown [IPv6:2a02:8428:60a1:3e01:76e8:6ddc:7f18:a4b2])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 215E12003D3;
	Thu, 23 Jul 2026 09:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1784791818;
	bh=XLOtuUR2hVwp71LUQ22QendaweQswhhhg1b7VpgYs+s=;
	h=From:To:Cc:Subject:Date:From;
	b=G4P+7PscnF/ImwjPBeUTZd+JPDvwr6vAMuk48mDurmO8gbQRWTz1N5+tGMLoOj9gV
	 rjg1a2J22FpvhFsKfryliWn1NWSqIzIdXrwz3CR246HObrvab3gFbnyRlJUCyYps6M
	 GQO1aOC/pMYVWwdPBl827foR92L5bvcgCrzkQBuAQyrWgMCIzXL4l3Y4sCyyI5yXe2
	 JFqz0M27d/0u5eF3WrWdgwstyqbwsg6Kw6215XQ7UfEFgc/zgt9xAX2N4jL4GKEtjG
	 /USiMM0+wqtT+U95xiNHORQz0bnV4RKwqDJg9Fr/CKkzi0eXy6pR695F2Gr+FQkIrv
	 gmgVJ1GhP16uA==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>
Subject: [PATCH 0/4] can: usb: Add driver for HMS IXXAT USB-to-CAN adapters
Date: Thu, 23 Jul 2026 09:29:35 +0200
Message-ID: <20260723072955.32575-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

This series adds a SocketCAN driver for the HMS Networks IXXAT family of
USB-to-CAN and USB-to-CAN FD interface adapters.

The driver supports two USB communication layers:
- CL1: the protocol for classic CAN 2.0b devices with legacy firmware
- CL2: the newer protocol used by recent device firmware versions

Supported devices (VID 0x08d8 and 0x08db):
  USB-to-CAN Compact / Embedded / Professional / Automotive / Plugin (CL1)
  USB-to-CAN FD Compact / Professional / Automotive / MiniPCIe       (CL2)
  USB-to-CAN/FD Pro / Standard / Standard Card / Pro Module /
                      Standard Module                                (CL2)
  USB-to-CAR, CAN-IDM101, CAN-IDM200                                 (CL2)

Supported CAN control modes (device-dependent):
  listen-only, loopback, triple-sampling, bus-error reporting,
  CAN FD (ISO 11898-1:2015), non-ISO CAN FD, one-shot

Additional features:
  - Hardware receive timestamps propagated via skb_hwtstamps
  - Bus error counter (do_get_berr_counter)
  - TX echo via the SocketCAN echo skb mechanism (up to 32 in flight)
  - Up to 5 independent CAN channels per physical device
  - Automatic protocol layer selection based on firmware version

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>

Stéphane Grosjean (4):
  can: usb: ixxat_usb: add shared header
  can: usb: ixxat_usb: add CL1 legacy protocol layer
  can: usb: ixxat_usb: add CL2/V2 protocol layer with CAN
  can: usb: ixxat_usb: add core driver and Kconfig/Makefile

 drivers/net/can/usb/Kconfig                   |   17 +
 drivers/net/can/usb/Makefile                  |    1 +
 drivers/net/can/usb/ixxat_usb/Makefile        |    3 +
 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c |  188 ++
 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c |  347 +++
 .../net/can/usb/ixxat_usb/ixxat_usb_core.c    | 2567 +++++++++++++++++
 .../net/can/usb/ixxat_usb/ixxat_usb_core.h    |  862 ++++++
 7 files changed, 3985 insertions(+)
 create mode 100644 drivers/net/can/usb/ixxat_usb/Makefile
 create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
 create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
 create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
 create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h

-- 
2.53.0

