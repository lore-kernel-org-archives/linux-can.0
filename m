Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738908;
	b=YgO0iis2BY+zQns2uSSeJ+rWMOS59pTvC9S3x/psgqN5Yyo06Q52OhXzk0Br6dQfRAIr
	 0dSY2XAF9G0W1NMz/rXJOseSv7mxHLnzIXMnGOiNopRXfGq0asntnVEfqlMQsml3uHf9G
	 PmGa0TlKAw9SjVE5pBqBmD2VWdFi9MZscSsiTdZcUuJdnCB6b8dS+jBX2nnpF3uJxSWCY
	 CfgMZxBOWFaOkoeXw8K/LMakXatJw17v47bRN2uex9wOvkwZvw21eagBc0JT4rF9wGBCP
	 U9HVjc2P/8W9/O94zgaWCYDr/pNYl9EI5/KyX/w/mjpukxhBWqxfZsKEoNI1MbLiHug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738908;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=0uLQMpvq3l3deY4cavt8kyFNUrHG84RgqUQrbvmQPHUuL/zzJ55DCJoMahilNEHCj+47
	 bQVc04sJbjk/QZkB5jZpYRrsaJF0MSj7BJ6bVUWXsIYMWvUW7Iw/8YyvAYRpcHXt+KBG2
	 DdVyEXl8UXgfhJ77eWe9i6DZ0JG7izzJTbZLETYRQjdrHtQU9RFCw6UEgTDUzQQE7fhqD
	 w6ifeIuN0E6fitrmP82NjrTqaasT/ixZaccOOlZxMUWyMNHGXn4DaZECbXsK/1cZY9RCA
	 +XGqZqoGUGOQI0ovdmgh9wAdhz6puv0xAkDuh/WUJQP4fQigqTna0/flvVyw1qjWmTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoFAp4N5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2A606A324;
	Tue,  3 Nov 2026 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoFAp4N5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E051F000C1;
	Tue,  3 Nov 2026 20:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793738907;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UoFAp4N5xwBnisN3EUY7HiGa+LBzJag6sF5EJZhrlFlqVuZxQR3z+bv0+nX5Whqyi
	 BUWv9lTGAAHI5AdZyxjHiHHQLf+7FwAmUJd0rx75IWKV1sjYNGlC3rBjdXN0fNntCF
	 Pz3cd2dQtQXIVOr6a3oZf1FvnLPPwrOgwqlKb4rtRNvC9CE+k0jZPUVl5F6yjV/JWh
	 rrVnsy4szqxNO4RUIKBSz3+rucvUBeiBTdS5pYuAa8+MRNHwTJw0oyCset1rK15jZK
	 eV79JahH8XNT6bX0BaaEuxvB3LS/VCTbtvJz4LDpk7WkNtO6S/3Ak257iPoZnU+Kad
	 2csfvw4Hoq2dA==
From: netdev-bot+sinfo@kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Vincent Mailhol <mailhol@kernel.org>, stable@kernel.org
Subject: Re: [PATCH net 01/15] can: dev: can_dropped_invalid_skb: drop CAN XL
 frames on non-CAN XL devices
Date: Tue, 03 Nov 2026 20:48:26 +0000
Message-ID: <179373890635.488859.7020450257277754751@kernel.org>
In-Reply-To: <20261103204305.3211144-2-mkl@pengutronix.de>
References: <20261103204305.3211144-1-mkl@pengutronix.de>
 <20261103204305.3211144-2-mkl@pengutronix.de>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
