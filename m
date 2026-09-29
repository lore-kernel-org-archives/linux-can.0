Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0BB3B841B;
	Tue, 29 Sep 2026 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716408; cv=none; b=E2NvtlDqh/p7CUznQ3ew++t+1QmLXYRjjBjh0MuGKdwPiJanlvOgtber/tkv9STQ4de6flkc95m8yMCRdCFoLjlKBN3ArKQt6SUDCihHbmFv9cTOjVWu4Jw1ENScyeuY+J9dE1OhaJgar/tBXIM7ejGxZ1vLcX1TU5LEBpDwr2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716408; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AGQ7rUMD9aodLMy3+6bdIAl02ax/Q7n+Gl3cILRhST1xbwAIW87kmnpDsiVHDeo9UpTNiG+dL0SWzoi4/OepenzxIxeT+q4nfkjXFXvWWIDHZQ+PcpaTbV5cVUUIdeUlRQAW1TNJ1JhaHnlmVfWcGs/ZWI9u1uiPPydiLoH1feo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7/I3+ta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7/I3+ta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81611F00893;
	Tue, 29 Sep 2026 21:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790716407;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z7/I3+taIN7WudaWZJi6ZQiuMRuzf4qOib9VGhy7q9qag0RexXauEBTVjV6MC5rgQ
	 zoEc98T8SOwVSAgb0Cs2lQqZxk7z8aKn3RWt8Kg9b+UGGc882bLHS6CnT6s42c/RDS
	 YDb04G0IbFsbAKi1GawkKtzUHOimKrRIqCnrXDzQ0PeNbQno3c0GUWKCJr+jfsQd8F
	 0kxoqOB6h4vYLmuVFnL59BT5I+o8PuAKpej6daA5xlfMJ9qonB2bteGeYyq3gR9Wbm
	 0bBszqdeGEFavYlKiHsQgKNT9T9S53sKjvBQNvc5PXRIjVtaY2xlUfAp9+HOgEBt+/
	 T/Q2h0CuZi7Nw==
From: netdev-bot+sinfo@kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Vincent Mailhol <mailhol@kernel.org>, stable@kernel.org
Subject: Re: [PATCH net 01/16] can: dev: can_dropped_invalid_skb: drop CAN XL
 frames on non-CAN XL devices
Date: Tue, 29 Sep 2026 21:13:26 +0000
Message-ID: <179071640627.31693.12358286964171064885@kernel.org>
In-Reply-To: <20260929210700.1183036-2-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
 <20260929210700.1183036-2-mkl@pengutronix.de>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
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
