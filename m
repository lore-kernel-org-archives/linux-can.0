Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454B73F20E3;
	Mon, 12 Oct 2026 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795176; cv=none; b=Jp+jqYC1qLnyp2y9s57HADwo7hrWX1xQjmY8xplXXdaiJi6F+XzNF3Y6JyQ2zeujyRWuu+Dp0cnDEzH6IAY+/fWZFh6i+jAIH2O1H40OozJEznCjXysTTr8cZwHWDWqZwqyR6dV3oyH44sx2NGH26zesxgU50oZyFvRW7hABeYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795176; c=relaxed/simple;
	bh=PAs3/unkQTsE/HzXG0F+sn9y5qgwzYP965UoMpTQomM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iy0nenNGqbe0BXA39JbcO5cegtnlXOTJdJGACDmrs32gB8w5NUVJ+NyaffMgmNB6QvU6ZWAekTRHYO2q0qYycWy2x6GuRoP5womp84ChXToMNnHiBl1NLCUBzekbAc7iO8q3aWI5oVdeeQDz5BMKvYVD0qAWI86E/n2REffHqLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PHid+6UU; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PHid+6UU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8v
	EkFSLM9DHEiphTeciKiQiF8lgll8giuwOgersz8J4=; b=PHid+6UU9oBGiMV/2I
	e215duKX2R+5q09+jxABo9z5rnS4tRYYO2DOEHCz0feoUZjxsuzK0hvAyaXkZWh0
	c5UBjcVaiwibWp/caYSs6z8Lj4/iNV9bmRMcY3DvDycM5BZ9Mm25/MH3tw9YrpUW
	AOLbi1IZRsiPNULNJeyHeTz1w=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3nzHan8xqbiYcDg--.59897S2;
	Mon, 12 Oct 2026 16:52:42 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: can: add CAN XL raw socket tests
Date: Mon, 12 Oct 2026 16:52:41 +0800
Message-ID: <20261012085241.377683-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923034256.396514-1-quchaosheng000406@163.com>
References: <20260923034256.396514-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3nzHan8xqbiYcDg--.59897S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWUJrWDZF13Ary3XrWfAFb_yoW8GrWUpF
	WrGw1UKFWDG3W093s7Cr43Xayayr4ktF15try5tryUZ345WFnrtr4xGas09ay5Crs8Wa4F
	vw4Y9FZ8G3WDJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziiiSJUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BrrYWrMn9rPVQAA3N

Hello Marc, Oliver,

A ping on this one.  It has been three weeks without a reply, so here is
the short version in case that is what has kept it from being looked at.

tools/testing/selftests/net/can/ has one test, test_raw_filter, which
exercises classic CAN filter matching.  CAN XL has been in the tree since
CAN_MTU, CANFD_MTU and CANXL_MTU became distinct, and the raw socket CAN
XL options (CAN_RAW_XL_FRAMES, CAN_RAW_XL_VCID_OPTS) have no test at all.
This series adds eight cases to the existing test_raw_filter.

What they cover: classic/FD/XL length separation, the mandatory CANXL_XLF
flag, the declared length against the payload actually written, that
enabling CAN XL also enables CAN FD and cannot be undone while XL stays
on, and VCID handling including the RX filter.

On vcan, no hardware needed:

  # PASSED: 26 / 26 tests passed.
  # Totals: pass:26 fail:0 xfail:0 xpass:0 skip:0 error:0

On an interface forced down to a classic CAN MTU the same run gives
pass:19 skip:7, so nothing fails on a host that cannot carry CAN XL.

Nothing here depends on anything else in flight.  If the scope is the
problem I am happy to drop the vcan plumbing and keep only the XL cases,
or to move whichever subset you prefer to the next release window.  If
the answer is that this does not belong in the directory at all, that is
fine too and I will stop.

Thanks,
Chaosheng Qu

