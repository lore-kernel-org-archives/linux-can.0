Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539641;
	b=VQr0b3xWH1QEBYYejgTFjB959izO64FWXp0bgqQwi4WjWioqTkaT61G75X+wfB+5oGJZ
	 9QMGo00K2lgSkreU7gRNJguduDcIhJMhkeHyGdWWIiUJHJi5EqVfe2VZPN2E4he56elk4
	 5zodNZQ2jcC9T8UUjQSxTakfCyCe1xNrxokEsTxqyNq0LwtNiL8a3/7CULIhAPbv7VtZ3
	 lD0ZegyfXx6TTz8sNiqr1CvebLqJhV+pxOD9LL70bBB5FQ8ibnkLGVY2sMIBwzRHPgZI1
	 fCgMSQXD0PzzKVvGe09PTbT30nmLHM9yHWGFktU+MUNRKmyYV8sDDUs9LJD87nkmJuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539641;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=cpc7tXIKbGVmxNlJrYjzNXSr8uC1GXrWgjwnpqzpGRY=;
	b=DMzblV305kdgSx9Q9sdZq/sI1UaSwi0IBiNb6WJK4wdX4jCdYPYAzJbUyrPx8sIzs5/c
	 4GCa8kkk/MXlJ5eXwvn8WODmgE2jVnvq9W7gQxePUIyVdqUUVA3SOhlfyfyRx9xHqe0KS
	 5Yu5q2xXKZZWDMWwBN6Qwwz4V/YkGdXnbsviGleycEbz25xQbWim7Uoan8LZU9RHagDCP
	 ivjWWJ/iGKhiF+FJeEcrm3bsbneEOfrlYxTMGol0kl3M0eNaVGghTfVwXo75ZXi2Ne3+Q
	 um/XSOStOLbh3eeAO2LRjO5+Gfe4zutE0k2AcmaKO6aVYAB20gyK2rQXuy8YVbOl/bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mOed42bn;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DEF60A2604;
	Fri, 13 Nov 2026 03:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3DEF60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mOed42bn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=cpc7tXIKbGVmxNlJrYjzNXSr8uC1GXrWgjwnpqzpGRY=;
	b=mOed42bnXdmjZ7krRY5j4XdmW1h/9ZY3V+Y29tXQTjzCjsRtxjS2uWmBPxlK1Q
	XMHCWir6Cd5/OCvVefK3ZJPVBdcSUVfiTA0ytvmPHZsqdKCbVM1KluFO1AihOqCK
	NU3ktjSLxVQ7HAIGRqg9xH+jMdcY/lfEke0x5H0ckEFmg=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: netdev-bot+sashiko@kernel.org
Cc: Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v7 4/4] can: j1939: reject a CTS that names more packets than the message has
Date: Fri, 13 Nov 2026 11:11:13 +0800
Message-ID: <179453947398.30993.18414105107780142143@163.com>
In-Reply-To: <179452018249.488853.178284371976315484@kernel.org>
References: <179410166346.60581.17199842424718803160@163.com> <179452018249.488853.178284371976315484@kernel.org>
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
X-CM-TRANSID:_____wCHdDZfgPZq96BOHQ--.26022S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry3Zw4xWr43Wr4rAF43ZFb_yoW8JFy5pF
	ZxKr9rtrWDGwsa9r1xArW0qF95Ar1rAa1rX3WUGr9rCw45ua1xtw17t3yY9rnrJr1I9a4Y
	gFWYgas0gFZ8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UeHqcUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-x+PBWr2gF+kHgAA3T

Hi,

The Medium is right and the changelog was wrong about the existing code.

An oversized ETP.CM_CTS already ends in J1939_XTP_ABORT_ECTS_TOO_BIG before
this patch: j1939_xtp_rx_cts_one() stores pkt - 1 in pkt.tx_acked,
j1939_session_tx_dpo() copies it into the DPO, and the local echo reaches
the transmitter branch of j1939_xtp_rx_dpo_one() with
session->transmission set. What changes is that the out-of-range DPO is no
longer sent on the bus.

The TP half I missed. There pkt = dat[2] and there is no DPO, so an
oversized CTS made pkt.tx at least pkt.total, j1939_session_tx_dat() found
nothing at pkt.tx * 7 and returned -ENOBUFS, and the session ran until the
1250ms rxtimer aborted with J1939_XTP_ABORT_TIMEOUT or the retry limit ended
it with -ENETUNREACH. Now it aborts immediately with code 15. That is the
visible change for the peer and the socket user, so it leads the changelog
instead of the ETP case.

The Low is the same correction: with this check in, pkt.tx_acked is at most
pkt.total - 1, so a DPO this host built cannot be out of range. Only a frame
carrying our SA that we did not send reaches the transmitter branch, and
BAD_EDPO_OFFSET is the right reason for it. The role split and the comment
around it go away in the next version.

Thanks,
Chaosheng

