Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB513A6B7F;
	Wed, 30 Sep 2026 06:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750035; cv=none; b=T3q8jW71etYy4xrdqEnZm1WtD5/tZikHyCAKZHuVJa9PytDV0mfPW+Y/RR4s/UwDGH2pMKYkSBeNkG+R5QlvYUQqZjEq7g3FxKkOvEzf6fEFLij4RxnHuErRCw3JWM1ogJ9c0gOoDSUP9jOsvSrfOJ5Wfim3mbtMF0tFR9aPg2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750035; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nsLWOuDvG6gPhk1KOcOpXIoRuwdc7oE+Pi2I3D5CDnsn2nVlNm/xaPkNHmZpBJL8UC2W0kQ+zBDSEnndctziOXQRnhf0RZ58LF4DW4DwiKMyPLBbBA8ScufyFatHJWq4w7Ve+++UacNBmvPJ6faLA8cDtMxh3noF8VxW7zf2CNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chAkhc61; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chAkhc61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E951F000FF;
	Wed, 30 Sep 2026 06:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790750028;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=chAkhc61vEYUyi0F4kqr7QHvc4wZwAFI9qpVJmf6A9EAmGxIwJa/LAZzjdPDSBQl8
	 3W2UY6ZObCrwdIYFq916SgNaDdOqODjDFKcfiOkuuT7lFbLeZh4deNNENtL6uDF/N7
	 ku1WeNBHf2REXpFuSrQgNzoqQ7BYqWJCE9K/ZYPDqoO9MvfIOI66rceRHwFnClXt2a
	 +8DrX2zhYgjYXRU2JZgK1zdmuEXZmbcr20pYFWP1TlekN5dTh/t9fWr7ju3UVDzEIn
	 9+TQLLKuUcGzA4wjqthbkZ+a2d9C6Bk4z3J8I+01B6mmbb1D1KbE0tidvkX6+0PkgY
	 6YiexPI7AgAqw==
From: netdev-bot+sinfo@kernel.org
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, mkl@pengutronix.de,
 kernel@pengutronix.de, haibo.chen@oss.nxp.com, shawnguo@kernel.org,
 imx@lists.linux.dev
Subject: Re: [PATCH net v3] can: flexcan: flexcan_get_berr_counter: don't
 wakeup controller if interface is down
Date: Wed, 30 Sep 2026 06:33:47 +0000
Message-ID: <179075002798.31693.10584366091913056693@kernel.org>
In-Reply-To: <20260930062738.30145-1-chunyuzhiqiang@yinhe.ht>
References: <20260930062738.30145-1-chunyuzhiqiang@yinhe.ht>
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
