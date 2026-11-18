Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994724;
	b=ZJ04fdXZxXqktvG/i7p80dXeljG+NVDahSF6jlR70DTRyyUB0eZ2lh4j85IMLkZ7zVnX
	 jFDREDr6Hv7yJ4vSOMq8a6y1JNwyh3vAHxiToleXoRgZ7K5NYFPgzydIgC24lJ8PhlzxP
	 oWup3Qmc+6/wqzJUawGsEBtCRt/3WRAHzwz/KtmwIrkeoowZRLQUkx8sKdJrES7UmksFJ
	 McinNWJka3b7bsWL4DwzFC16lh4A7Jcu+AO4psSgQi9oUrECmLkvrWjKB0xKY72LQYiix
	 x7NnVTld3OfubtZMcQ19nLqFvsB1lrmnK1yrOLa9MkI5Qm+6b93b91BUm4R1N1KK7OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994724;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=QG0RdIGyvJFkpQhgw4XfyT/A3u03EjIUibXjBttdPzIrdUE4n/tbSyB3bDfHkHFSTGXQ
	 SU9d/5NNZ2qpaNbNnDai62gjkpkflEnFU08h7euWXehSVW2eXz5R9MdRCr4KneCQXQ00g
	 egibdbqO/rOifJvlWaAvyTQBJqeW7dciAINRU9CZL0WqfNhF5zGpICia80eno+bthTEzk
	 t2LQnFIyiWY/q0Cnm/c5nz6gCmhiSDE9P2McMzkdV8qVuqEbYM73ozNbBQt8atffaCj/K
	 yvAomeUuSGEPTy5tDKAHWXSHLFraxq5J87YRqc9G7yrlZxB+ow2e7Y3oxlJGtAIdupg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFGlXUuo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1B9606A31C;
	Wed, 18 Nov 2026 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFGlXUuo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8921F000C4;
	Wed, 18 Nov 2026 09:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794994723;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CFGlXUuoq1F93eff3bINULM8BV0jh31Bbb75sm47g2ed0+0uWTFRNfVxliQmxTgJq
	 qGgGc1LujFeEtAGIlfuuUbgUVcJThc93cdnvZAffW6PSM4tlSy5bojq7RyhssjXrh9
	 xxokn9W5JbdomJBPPvxnozZuZh9WHcC+qMFkJA6bQ911yeCyuerzwvKLDSJFDa+COc
	 lLpVa4jJIebAyeonuP7CJfxtLs9kHgnCeJ2Xemj0aEAhbHSSNJY9gP4qFgSRfd0Wj8
	 37S7KV4bzRRlgU/3tlRWYcqvUdWdkefo+Zygjzl6Pv5FVgyX4wtmYM0S3LnjmAG84o
	 Q1reVf4wFZ5zg==
From: netdev-bot+sinfo@kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 =?utf-8?q?St=C3=A9phane?= Grosjean <s.grosjean@peak-system.fr>
Subject: 
 Re: [PATCH net-next 01/12] MAINTAINERS: add entry for PEAK-System CAN drivers
Date: Wed, 18 Nov 2026 09:38:42 +0000
Message-ID: <179499472297.3291.1921538258116208727@kernel.org>
In-Reply-To: <20261118092955.1283165-2-mkl@pengutronix.de>
References: <20261118092955.1283165-1-mkl@pengutronix.de>
 <20261118092955.1283165-2-mkl@pengutronix.de>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
