Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430027;
	b=WYbGIqihFs8DK3Oygsap23VB+u5EzhlT3aCZgcjKOCiF80YX+I/cmMaLqfDFrxtjC4rf
	 oPwYlMfYglIZOopagGJXGcHp421pKIPh+YdM5q0z1lpErY1K4hKrWSLWy4iIUO5EDFXq+
	 raf/d+F4I5LtnEGCEMqFs5p6PRYku0JdIPOzziU8QqDdd/JlSCUUCUEnqwKPUFos5Akds
	 s2HiKqJcbiESJ+CqggwsrGiRyaQ8Irn5gn+mRHKqc0E9ZQOvrs7bLn+T2lTc/TlkTyCDV
	 rl9gJ5JDqa/tnW3RkXTbqJjdLIUxkswlUNvPoeD2WmniJYU8vYyT5IcZpiMNJxOtf5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430027;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=iooxnR5sU2USAi0y20KPQ7iKWoMSTa7Cnz8q4f+B4/4unSfDQxdkfhpZWDefUcFG1EOA
	 dWT99pYx2Na6ho3Uc0um+1s/AKqpy8ZA/QGDQ2T+Ow7tlNpN5RMMOrEJPNvzYK76KarvE
	 x6LgSg3ISwvw2mCz0WNbmRUDfBVL1l7kshLvlTPTpoVSXt6LTXBvQ6FltLBvzLU2hTv6h
	 QM2qNLyCeOhx3t4zuvTq467Wh/tJmIvGjTpjbudWLbM5YDDPKvUYNc8SYMBpWAUNXWOFX
	 nzIU9Pq6YwZTir4DC0NgCEw2GVv3bFHoO4OCE4LoaWuGy8v33ikedcUjq2xNn4raoJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gitq+yVT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C460606A319;
	Mon, 19 Oct 2026 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gitq+yVT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F37D1F000C4;
	Mon, 19 Oct 2026 17:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430027;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gitq+yVT6rfwdLCpNDZcj/jTAigNvADXMsT1rPPKb5eRa7bJ3if9wZgxTnsdcny9M
	 RGdf6SKq+adySil7GBRKl+ayoENJRPQhi+WdUhb7lchvnBrPP6TCe91viu9GpfqzGr
	 3XHl2wNVZOezqR/IGUZ0rFjfKBkt0ZRsRWsRscESMx7pKbVfurvwv0hTwlv1Z1yEU/
	 UYlK28KmvZjwfNP5P1X1Ok6kdEUhtn29awJvx5HIJvFHhV4PUshtNOUr88fF8zQAkB
	 cLBa294jdgP0aOYLLBen74SHuei/+fJ9Xb0lJy7fVb7RhTWN5YH7aMtDvza3IvTTSh
	 Yctxe5cHSbd/A==
From: netdev-bot+sinfo@kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Vincent Mailhol <mailhol@kernel.org>, stable@kernel.org
Subject: Re: [PATCH net-next 01/11] can: dev: can_dropped_invalid_skb: drop
 CAN XL frames on non-CAN XL devices
Date: Mon, 19 Oct 2026 17:13:46 +0000
Message-ID: <179243002608.3290.2702114370297782861@kernel.org>
In-Reply-To: <20261019170834.1727150-2-mkl@pengutronix.de>
References: <20261019170834.1727150-1-mkl@pengutronix.de>
 <20261019170834.1727150-2-mkl@pengutronix.de>
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
