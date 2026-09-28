Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD234A9D5C;
	Mon, 28 Sep 2026 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595463; cv=none; b=JUxx8yc4NGhn5ZM43gAGzXR1zULvEQhvGbNxTPsLymYr1qLgAdrkOJcLxTXVw7XAcB7t8airlTo4vhWeDrqHV8JhzgA43IwOSgvUuC4g/b2YmbwHVzUPeURFPiRu0QqUa6F65uP7pw7MoVZeO32BDoaKU+90d4T9t1nFmBmiV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595463; c=relaxed/simple;
	bh=i1HLmhfYYY1XgeHMmP92XohC1QUEx0bM50CxC1yMQGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuPpTf1AnWSn17fV2fSz3fHzcMWcxWXMKgtd/fhBHpUBIBT8S3lUHkINWo5BFtep+6SATUboDULMGUCzsCRCsDhI1lZZ5HOYkeb6Fg3Is4jC61SPo40vKKHiFMLZ8453yRnXTIhJmIo3JFRen0qcUA3oix8qzwh+cySmJHj1jrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O58xL+t+; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O58xL+t+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4I
	P/18Z3LtA8nsNujgY1Bh7YEYYCD4uNr6tnkGKZr6k=; b=O58xL+t+UNayHHIBQ3
	WVsay3ts5ObItAJblDTt1bX0xI8TLjV3a1c7WBUApaFFHrx5zixghxpY01M6Fn2f
	/BBrcmK0RC2wTsRdQNC0r6wt0Bn0DijqxVrHz/bNHSdgRg7/R7iTNAlVb6qE42FR
	dvyva01VC7iCzaDkPx73ol/qM=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnZ2ptUbpqvOicBQ--.36813S2;
	Mon, 28 Sep 2026 19:37:17 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: Quchaosheng <quchaosheng000406@163.com>,
	linux-can@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>,
	Kaixuan Li <kaixuanli0131@gmail.com>
Subject: Re: [PATCH] selftests: can: add isotp frame-type tests
Date: Mon, 28 Sep 2026 19:37:16 +0800
Message-ID: <20260928113716.2133785-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928112720.2120220-1-quchaosheng000406@163.com>
References: <20260928112720.2120220-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnZ2ptUbpqvOicBQ--.36813S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrW8Gw1kJr1fZr1fWry8Zrb_yoW8XF1xpF
	W5KanrtFWkKaySg34xCw4rXr93Kry3Zay5GFyY9rWqvwn8W39rKr4fXa4Uua43CrWkWayY
	yF4Yqa4DGrs8Ja7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU_CzJUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4w24Lmq6UW0FFAAA3F

A note on the expected result, since the test is written to fail on a tree
that still has the bug it pins down.

On current mainline the suite reports pass:3 fail:2.  The two failures are
the two CAN XL cases, which is the bug; the three passing cases are the
controls.  With the fix applied it is pass:5 fail:0.  I would rather say
this up front than have someone build it, see two red lines and assume the
test is broken.

The fix it is aimed at is Kaixuan's:

  [PATCH v2] can: isotp: check the frame type, not just the length

which was posted on 09-20 and is in the CAN patchwork, not yet in
net-next as far as I can tell.  I sent a Reviewed-by for it this morning
and I am not asking for it to be expedited -- only flagging that if this
test lands first, the two failures are real and are what it documents.

If a maintainer would rather not have a red selftest in the tree at all,
the alternative is to take this only after the fix, and I am fine with
that.  Say so and I will resend it as a follow-up to the fix instead.

One detail on the skips: the two Classic CAN cases need only any CAN
interface, and the CAN FD acceptance case needs one that carries CAN FD.
The two XL cases and the FD case are skipped rather than failed when the
interface cannot carry the frame type, so a tree built without CAN XL
support still gets flow control and padding coverage rather than a red
result.

  v7.3-rc5, vcan, in-kernel isotp sockets on both channels:

    stock              pass:3 fail:2
    Classic-only guard pass:4 fail:1
    Kaixuan's v2       pass:5 fail:0

Thanks,
Quchaosheng

