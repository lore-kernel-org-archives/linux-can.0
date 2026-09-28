Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD836B91C;
	Mon, 28 Sep 2026 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578286; cv=none; b=FcSLKgS9D8eC7Sw4doiz3TTVy/PVZPZtfHu5AuZztE+igW20m8ttvQtVdcW/HM6HQjhnsh+kchiTZ6TqFhrMm29Mo6ZLqL+GGVMb5SboCt4vHr8vxIe5sz+ekwxfkEm0ZzoUfJaBpv/1YG7YLwUP/NCE0jqS59+7yZYj3JuWM0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578286; c=relaxed/simple;
	bh=0yzF/FMWkf25zDuDPn+6mPi3d1Mnv0EK7qW9Qss+hB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpCZ3aaSBJ16g5V/nUGdZHdEJedunDaRROh4zTaINIqpodFtNBXSLqUyK2XpvmzXhA+1bTCCTcwQ02sAhVGWlaNvrSzcsjcpya7g2oYI8RPIaqXZzvkcL+jsMP/a6BqtgwVAJjJDleNkqOWMvk/XquBHC3GIoJuPLn0Udy3vOKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mZVxIMqa; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mZVxIMqa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sP
	jQQ3i3HZlk8RHhJOLbP3Ox7Qn+1Lsq2zbmXgJgnk0=; b=mZVxIMqa13JQdUi00S
	xSrMqILeEgncEDV4aUirh6OiRBrEiEzfeCTGSqOlwh+oYAStc73aDrF0P0klhYAg
	YqgYYUUt/aNpTQRlie6LYqgGsmn3VMKdID9YRiIfbjdg4XoqhL7Toe827wsFlbSW
	PVZl61q8Z46xFsErcPKgdI2dU=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD338lcDrpqNj3_BA--.62282S3;
	Mon, 28 Sep 2026 14:51:10 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Kaixuan Li <kaixuanli0131@gmail.com>
Cc: Quchaosheng <quchaosheng000406@163.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] can: isotp: check the frame type, not just the length
Date: Mon, 28 Sep 2026 14:50:52 +0800
Message-ID: <20260928065053.1750765-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920035626.2581040-1-kaixuanli0131@gmail.com>
References: <20260928065053.1750765-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD338lcDrpqNj3_BA--.62282S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1DZF1kJFW5Cry3urWfKrg_yoW8GFWkpF
	98KasakrnYvF93Cr9ru3WxtryFk34kJr10yFn8tr1jywn09r4vyFWrKa4YgayUCwsav340
	gw4Yq3s8Ca1DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRrMa8UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5B7jWWq6Dl77GQAA3i

Hello Kaixuan,

I hit the same collision from a different direction and independently
arrived at the same fix, so:

Reviewed-by: Quchaosheng <quchaosheng000406@163.com>

Two things I checked that may be worth having on the record, since they
are the questions this patch is likely to attract.

First, that isotp really is the only gap, so it does not need to grow into
a series.  I went through the other places that consume a CAN skb without
looking at its type.  bcm_rx_handler() and can_can_gw_rcv() do gate on
can_is_can_skb() / can_is_canfd_skb(), and those two helpers carry a
second condition on the frame length field
(include/linux/can/skb.h:93 and :101).  On a CAN XL frame that field is
cxl->flags, and CANXL_XLF alone is 0x80, which is already past
CAN_MAX_DLEN and CANFD_MAX_DLEN, so an XL frame is rejected there before
its length is ever used.  So the collision is specific to isotp.

Second, nothing on the transmit side can produce it.  isotp always builds
its frames at so->ll.mtu and validates ll.mtu against CAN_MTU / CANFD_MTU
in the setsockopt path, so the frame that passes the old length-only test
can only come off the wire.

Your A/B table is what convinced me, by the way - case C in particular is
the right control, since it shows the EBADMSG already existed for a
malformed Classic FC from any sender.  Nothing becomes reachable that was
not reachable before.

Thanks for fixing this,
Quchaosheng

