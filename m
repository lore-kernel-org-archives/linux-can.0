Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1232D4F4D01;
	Mon, 28 Sep 2026 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624172; cv=none; b=n6piXBOBak9Pz60KQBATSBFUjsVO5cxY2viz8kioyvvQ1xICymwOCfcslwGcLY7a4IHNi3tHtphf53pFQdyOFgtYa8iJYlTi1bu3Mqh7ZBVTp4fT34hsVt8p6vfCgz5+uFkEMtgEVcJLPDW7/ZLt37CkMVdoMdaOkfcx0PcnJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624172; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nbMtaqbblqi5jwHgw0LCR1qktq2fFzmdPwdYdO+bis95VDcPfeQzYsspG/FJxkD1kgd5WfkMFZ4peUGJarD7ZoV37/+MWVhPmzNUwkZAXWC8fXSpmzz1ZNys+NO+fDBDoTpkWjWQX9PWYTezbIHqtt4nsc/wLU9FhfEa4/lc5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdhqOquG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdhqOquG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A7B1F000FF;
	Mon, 28 Sep 2026 19:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790624170;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gdhqOquGvaqbTSsnG3HkDIsneciiW/JvoLKdtLSBHTjDA1ml63B4QBIEA5R3d/PAj
	 WgzrVG6NL50S09E7iiAQg8HNjcQwVHwOl4yKzfBxNIHSzScbspp0FlH9BYCNc1hW3F
	 rZbx3evQFS93gAp776/4tCimFxRTR9Kyk3aCBK9tqaJNCNu+XTyCw6T2iv47pgYy4r
	 vDkytqaHpZK7cnBlER7nhPYOUG/thRZHKAvpHpypArCIUQzV9obNxWeXKinrbY8Ldx
	 PZrWLGQnAodKBQSXUg9BMAjfgSPVp6Ump7dL7D4QCn9uKNQb8XCsMOaj6e7FoKNXET
	 kAUZhdWIwwafA==
From: netdev-bot+sinfo@kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Vincent Mailhol <mailhol@kernel.org>, stable@kernel.org
Subject: Re: [PATCH net 01/22] can: dev: can_dropped_invalid_skb: drop CAN XL
 frames on non-CAN XL devices
Date: Mon, 28 Sep 2026 19:36:09 +0000
Message-ID: <179062416961.31693.13012733403972252556@kernel.org>
In-Reply-To: <20260928193312.553632-2-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
 <20260928193312.553632-2-mkl@pengutronix.de>
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
