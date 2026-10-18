Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052DC2ECD32;
	Sun, 18 Oct 2026 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342456; cv=none; b=Qlgyl3IO9qi7VxdkxmlROt/dXo5BvUxO0q6JHLQiGckWoZ3yqJiXAeRk8h5mhg7Gd2yHZdROUx5Mzbkme5nm3Spjk1027g6gQab2X6ptx9nhdasgmh5Ra55ZnMv09mPFE25I3QlyZSMyUCVPpv0yAjTOEh/CYCc644GwDRg7VMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342456; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nvLuu18SvAtYXqamhrRn4Sgwhrwf7S1IaI48kSPwrAqCm8rNHZgj/nvpGzcT4uTlnP5zbl16cRwRkNtk9vDb4u0YxqhrejrF2eJt4kllv0oPq9aRxgI3dqbi3TUQEaMk0KFlLT8ahmCKpLDuGpF8zlCEzNQtqVaEGxZxaQjUjuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk8iNXxM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk8iNXxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF931F000C4;
	Sun, 18 Oct 2026 16:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792342454;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dk8iNXxMe7iZEFlT6J4iRkCZn+v6g04VwQ7/Y8T5GANhPL0uPxG9A0RBKDEx6UrRP
	 F7rwFylvP9ywuVtYePWZviyIeMP9P/eG/qFdcrnnHHcDhCTNFuq4B+BsfnlP6elL0H
	 S1w+vS2n1ol2PDgFUvPFn8lFgwW9UCPDEvMk95aU756qPb2DZZKA7I7/iuVIT6im5Z
	 kK24j+IOZ9YYu5ceY9klJGO4RulylXWoszMNP/DMZAdotIiy5bFvpYpt7GY0QeZF/u
	 brO8ulqQuXrlznTkDF8GZIkX+ouaB9E0NGwrWXddO53tOo6KHK3ys3riGI75+70xHR
	 WIlKb2CVVE9gw==
From: netdev-bot+sinfo@kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Vincent Mailhol <mailhol@kernel.org>, stable@kernel.org
Subject: Re: [PATCH net-next 01/12] can: dev: can_dropped_invalid_skb: drop
 CAN XL frames on non-CAN XL devices
Date: Sun, 18 Oct 2026 16:54:13 +0000
Message-ID: <179234245371.3290.10647099846878651094@kernel.org>
In-Reply-To: <20261018164417.1540449-2-mkl@pengutronix.de>
References: <20261018164417.1540449-1-mkl@pengutronix.de>
 <20261018164417.1540449-2-mkl@pengutronix.de>
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
