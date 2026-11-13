Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560134;
	b=boeZfvrJVIdGojZTw2TBFlwvAsHR7CMTPl4d6sDd/LvIQ2QijyRJixWVtxuNC22g8vMb
	 ciQu2O82qmFh3qofmaA2hE4kS+WMPii7FdGE9rCjJvDU7yKu+x6BplizdKXoMnvu9XOYz
	 x5JlnewdSziXwfGZRs1lTKNJPuRyXeCbtIsnUykS+HoLSrx6qAHwqYgGJ0DN67cw+AA+5
	 Iu6dl4OP9StoNtKv6DgN7DveIx/M63lqWJwq/vOzKHE1n5RyVJYUIXNGLeNZUhPAaux+u
	 wK/jqjhVbAlBwJXtT8XywpHFSxkITrwR2NaATQSey3Yow2SFYdXPcfQHhvsiss9m6nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560134;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=o/vM+pKJQWYxMg49HuZsa9BuPYyQNP+6g98C9jaB+Hw=;
	b=lgBNfBUDiJPZ0uD6bUmlNM17eAOhL5WVIcyqrecuRqsC/msPTlCqi0lV+zLSPJqd53Kk
	 q2plFE/yHvCCn/OepyVKMh9007XCYh5DmW6ECaIVMNn+k1iX5cHt+IKQw0GNoz+RwvSZn
	 IuhxZVwb64APdFHp90EnbRcrJbqtDWaUNFEecQqUJc8QucrSI/I3yJjlkL2ixRjfpcRCH
	 J/Pzi/+vhFuHSRUveSQLVkjOS6yLHdwEVxR2b8h1CLFr90O3XRhgsAqSHA3jx8167pu/J
	 O598OjRUivhbts+BcM4r9vM0R+5riaXAWOKeKq9FBZPrrEXmPcQTfoQrFXc4wsnXC7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=B2rVECKe;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005A606A336;
	Fri, 13 Nov 2026 08:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0005A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=B2rVECKe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=o/vM+pKJQWYxMg49HuZsa9BuPYyQNP+6g98C9jaB+Hw=;
	b=B2rVECKeXmSlPJyCcYpjQSsNzWml3qZsjWM28mNaKs/KvkAwnCLVjb1JSyjtwP
	75ZszseThRWoeD06XspWP4KhAopM9uSO+Y4Y/pYuguZcAKgY3/CTgUIAg4F98bs4
	Kasu0Gx7+P5W+ithGMJPwZ1D+YSsjipHOZmY54kXNlQUY=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev-bot+sashiko@kernel.org, Robin van der Gracht <robin@protonic.nl>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v7 3/4] can: j1939: drop the message when the reassembled skb is gone
Date: Fri, 13 Nov 2026 16:54:28 +0800
Message-ID: <179456006880.149752.3451373615421898441@163.com>
In-Reply-To: <ava7hRQ7lxXckkPL@pengutronix.de>
References: <179410166346.60581.12668181404057434786@163.com> <179452018024.488853.2874336452045412196@kernel.org> <179453947398.30993.12910253526180673543@163.com> <ava7hRQ7lxXckkPL@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBnNC1o0PZqTmkAFw--.64557S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4rAF1DKFy8XF1kuw17Wrg_yoW8WrWfpF
	98C343GrZ7Wr4xXFyxXrW0ga4Svrn3Jr1rur13try7Cw43Cr45try5tw4avasrGryv93ya
	gF4Ivw4DJa1vkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UY_M-UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wumHGr20GvYZQAA3I

Hi Oleksij,

No, a stack trace adds nothing here, so netdev_err_once() it is.

The branch is defense in depth: with the EDPO bound in place it should be
unreachable, and if it ever does fire, what I need is the session state, not
the call stack. Whoever reads the log wants to know which offset missed and
what the queue looked like, and a backtrace of j1939_session_completed()
tells them neither. So I would put that state in the message:

	if (se_skb) {
		j1939_sk_recv(session->priv, se_skb);
		consume_skb(se_skb);
	} else {
		netdev_err_once(session->priv->ndev,
				"%s: 0x%p: no skb at dpo %u, total %u, rx %u, queue %u\n",
				__func__, session, session->pkt.dpo,
				session->pkt.total, session->pkt.rx,
				skb_queue_len(&session->skb_queue));
		session->err = EBADMSG;
	}

One correction to what I wrote yesterday, since it is the same line:
session->err = -EBADMSG has the wrong sign. __j1939_sk_errqueue() assigns
session->err straight into serr->ee.ee_errno, which is a __u32 that user
space reads as a positive errno; the TX_ACK case right above it stores
ENOMSG, and j1939_xtp_abort_to_errno() returns positive values as well. A
negative value would reach user space as 4294967222 instead of EBADMSG. It
should be plain EBADMSG.

That also means the two existing negative assignments, -ENETUNREACH in the
tx retry-limit path and -ETIME in the simple-tx timeout path, already deliver
a wrapped value through TX_ABORT. Pre-existing and not this series; I mention
it only because it sits on the line I am touching, and I would rather not
copy the wrong convention into a new one.

Thanks,
Chaosheng

